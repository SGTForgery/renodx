# BG3 CSM Shadow Bias Investigation

## Date: 2025-06-05

## Problem Statement
Large-scale environment meshes (material type 4) exhibit excessive shadow acne and z-fighting in BG3's CSMResolve pass. The acne flickers with camera motion due to TAA jitter affecting derivative normals used for bias computation.

---

## Root Cause (VERIFIED)

BG3's CSMResolve shader (`0x8AD4A32B`) has a "two-sided shadow" code path that **inverts the normal-offset bias direction** for material types 3 (foliage) and 4 (large environment meshes). Material type 4 meshes are thick opaque geometry — NOT two-sided — but the engine incorrectly includes them in the inversion path.

When the derivative normal detects "backface to light" (which happens naturally at grazing angles), the bias gets inverted — pushing the sample INTO the shadow map surface rather than away. Combined with TAA jitter wobbling the derivative normal threshold, this causes oscillating acne.

### Evidence
- **Mode 3 (Zero Bias)** eliminated all acne → confirmed bias is the source
- **Hypothesis A** (exclude material type 4 from inversion) eliminated acne on affected meshes → confirmed the inversion is the specific mechanism
- Material type 4 is written by GBuffer shader `0x0A136550` which packs `((4u | ...) | (_14._m0 & 7u) << 4u)` into RT2.w

---

## Working Fix (FINAL — GBuffer Source Fix)

**Approach:** Change material type from 4 to 0 in GBuffer shader `0x0A136550`.

**File:** `src/games/baldursgate3-vk/test/0x0A136550.frag.glsl`

**Change:** In the RT2.w packing expression, changed hardcoded `4u` to `0u`:
```glsl
// Before (writes material type 4 — triggers inverted bias in CSMResolve):
float(((4u | uint(int(_14._m1 != 0u) << 3)) | ((_14._m0 & 7u) << 4u)) | 0u) * 0.00392...

// After (writes material type 0 — standard opaque, no bias inversion):
float(((0u | uint(int(_14._m1 != 0u) << 3)) | ((_14._m0 & 7u) << 4u)) | 0u) * 0.00392...
```

**Why this is the correct fix:**
- Material type 4 is for thin/double-sided geometry (leaves, flags, banners) where bias inversion is correct
- Shader `0x0A136550` renders thick opaque environment meshes (walls, floors, stone) that should NOT be type 4
- Leaves/flags/transparencies use DIFFERENT GBuffer shader variants that correctly write type 4
- CSMResolve logic remains vanilla — inversion still works for legitimate type 4 objects

**Result:** Shadow acne eliminated on large environment meshes. No regression on thin/transparent objects.

---

## Failed Approaches

### Attempt 1: Pure FFXVI Oriented Depth Bias (2mm linear Z-only)
**What:** Replace entire vanilla bias with `±0.002 / cascadeRange`, direction from `dot(gbufferNormal, lightDir)`.

**Result:** Universal shadow darkening (all pixels classified as shadowed).

**Why it failed:** Initial sign was wrong for BG3's reversed-Z convention (1.0=near, 0.0=far). After sign fix, the output was still too dark/flickering.

**Root cause of failure:** Flat 2mm bias is insufficient. BG3 has **zero hardware slope bias** (confirmed by Nsight + ASI hook) — the vanilla shader's XY normal offset IS the slope bias. Removing it means grazing-angle surfaces have no protection against self-shadowing. FFXVI gets away with flat bias because they keep `depthBiasSlopeFactor = 1` in hardware.

### Attempt 2: FFXVI + Slope Compensation (1/NdotL scaling)
**What:** Added `1/max(abs(NdotL), 0.1)` scaling to the 2mm bias + half-texel XY offset.

**Result:** Still flickering acne on most meshes during camera motion.

**Why it failed (hypothesis):** The slope compensation clamp at 0.1 (max 10x) may still be insufficient for D16_UNORM precision. Additionally, the GBuffer normals themselves may not perfectly match the shadow map geometry (sub-texel misalignment between GBuffer rasterization and shadow map rasterization creates per-frame noise in NdotL).

### Attempt 3: Hybrid — Vanilla magnitudes + GBuffer direction (no FFXVI Z bias)
**What:** Kept vanilla bias magnitude/scaling but used GBuffer normals for direction. Only inverted for SSS/foliage (type 3).

**Result:** Same as the working fix (Hypothesis A). This is what Mode 1 currently implements.

---

## Key Findings

### Shadow Map Pipeline (Nsight Verified)
- **Pipeline:** VkPipeline_uid_126220
- **Depth format:** D16_UNORM (16-bit, per-cascade), linearized → R16_TYPELESS 8192×8192 atlas
- **Hardware depth bias:** `depthBiasEnable = 0`, `depthBiasConstantFactor = 0.0`, `depthBiasSlopeFactor = 0.0`
- **Dynamic state:** Only viewport + scissor (NO `VK_DYNAMIC_STATE_DEPTH_BIAS`)
- **Cull mode:** BACK_BIT, CLOCKWISE front face
- **Depth test:** GREATER_OR_EQUAL, write enabled (reversed-Z)
- **Color attachments:** 0 (depth-only rendering)
- **Runtime hook:** 0 calls/frame to `vkCmdSetDepthBias` or `vkCmdSetDepthBiasEnable`

**Conclusion:** Shadow maps store raw unbiased closest-surface depth. All bias is software-side in CSMResolve.

### Vanilla Bias Structure (CSMResolve)
The vanilla software bias has three components:
1. **XY normal offset** — projects surface normal into shadow space, scales by `0.00048828125 * texelSize` (~half texel). This IS the slope bias.
2. **Z depth bias** — `_13._m7 / cascadeRange` scaled by cascade ratios. Modulated by edge factor `_183`.
3. **Edge factor `_183`** — reduces XY at geometry edges (prevents cross-surface bleeding), increases Z to compensate.
4. **Material inversion `_235`** — flips entire bias direction for material types 3/4 (the bug for type 4).

### Why FFXVI Doesn't Directly Apply to BG3
| Aspect | FFXVI | BG3 |
|--------|-------|-----|
| Hardware slope bias | `slopeFactor = 1` | `slopeFactor = 0` |
| Shadow depth format | (unknown, likely 32-bit) | D16_UNORM (16-bit) |
| Software slope bias | None (hardware handles it) | XY normal offset = the slope bias |
| Bias approach | Pure Z (2mm linear) | XY + Z composite |
| Depth bias in shadow pass | Constant factor removed | Never existed |

The key gap: FFXVI has hardware slope bias = 1, BG3 has zero. The vanilla XY offset is BG3's slope bias replacement. Removing it and trying to compensate with just Z-axis bias doesn't work because slope bias operates in a fundamentally different way (it offsets along the depth gradient, not along a fixed axis).

---

## Shadow Caster Shaders (test/ folder)
| Hash | Type | Purpose |
|------|------|---------|
| `0xC3619944` | Vertex | Simple shadow caster (world→light clip) |
| `0x1769372A` | Vertex | Shadow caster + world pos output (for distance fade) |
| `0x7EADB4AE` | Vertex | GBuffer shader (quaternion TBN, MRT output) — NOT a shadow caster |
| `0x8D2E5B5D` | Fragment | Simple alpha test (`texture.w - 0.5 < 0 → discard`) |
| `0xF83D5036` | Fragment | Alpha test + distance-fade clip volume (noise-dithered boundary) |
| `0x0A136550` | Fragment | GBuffer MRT (writes material type 4 into RT2.w) |

---

## Open Questions for Future FFXVI Implementation
1. Can we implement slope bias purely in the Z axis by making it dependent on the shadow-space depth gradient (`dFdx/dFdy` of shadow `.z`)? This would avoid the XY offset entirely.
2. Would increasing the D16 precision (if possible via resource upgrade to D32_SFLOAT) allow flat bias to work?
3. Is there a way to add `depthBiasSlopeFactor = 1` via the ASI hook during shadow pass rendering? This would satisfy the FFXVI prerequisite without modifying the shadow map content.
4. The vanilla XY offset uses derivative normals (jittery). Could we implement slope compensation using GBuffer normals projected into shadow space for the Z-gradient estimation?

---

## Current Mode Summary
| Mode | Label | Behavior |
|------|-------|----------|
| 0 | Vanilla | Derivative normals, full vanilla bias, material-type inversion |
| 1 | Oriented Bias | GBuffer normals, vanilla magnitudes, type-4 inversion removed |
| 2 | CSM Off | Outputs 1.0 (fully lit) — isolates non-CSM shadows |
| 3 | Zero Bias | All bias zeroed — diagnostic |
| 4 | Max Taps | 14 blocker + 18 PCF samples — diagnostic |
