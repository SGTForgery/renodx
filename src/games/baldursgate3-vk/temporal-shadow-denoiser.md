# Temporal Shadow Denoiser — Implementation Tracker

## Overview

Screen-space temporal shadow denoiser for BG3's local light shadows (hero lighting,
point/spot lights). Solves hair flickering, body stairstepping, and overall instability
caused by the engine's stateless per-frame shadow pipeline.

**Technique:** AMD FidelityFX Shadow Denoiser architecture (adapted for raster shadow input)
- Tile Classify → Spatial Filter → Temporal Stabilize
- Reference: [GPUOpen-Effects/FidelityFX-Denoiser](https://github.com/GPUOpen-Effects/FidelityFX-Denoiser)
- Open source (MIT), shipped in multiple titles, proven on noisy shadow masks

**Why this works on raster (not just RT):**
The denoiser is signal-agnostic — it processes a per-pixel float shadow value with
frame-to-frame instability. BG3's 12-tap PCF produces exactly this: a [0..1] shadow
factor with sub-texel jitter noise from vertex animation and opacity oscillation.
The temporal accumulation converges the noisy per-frame samples into stable output.

**Parent doc:** `shadow-improvements.md` §2b (root cause) and §4.7 (technique overview)

---

## Why FidelityFX Architecture Over NVIDIA NRD SIGMA

| Aspect | FidelityFX Shadow Denoiser | NRD SIGMA |
|--------|---------------------------|-----------|
| License | MIT (modify freely) | Custom NVIDIA license (use as-is) |
| Source | Full HLSL on GitHub | Compiled library + headers |
| Complexity | 3 passes, ~800 lines | 4 passes, ~2000+ lines, opaque state |
| Integration | Drop-in compute shaders we write ourselves | Library call with version-locked API |
| Extra inputs needed | Shadow mask, depth, normals, MVs | Shadow mask + **hit distance** + penumbra size |
| Our control | Full — tune any parameter, add BG3 heuristics | Black box — exposed knobs only |
| Vendor lock | None (works on AMD + NVIDIA) | NVIDIA-focused |
| Memory | ~10MB | ~20-40MB (internal buffers) |

**Key reasons for FidelityFX:**
1. **No hit distance.** NRD SIGMA's advantage is penumbra estimation from ray hit distance.
   We don't HAVE hit distance — we have a PCF float [0..1]. SIGMA without hit distance
   degrades to basic temporal accumulation (its penumbra denoiser can't function).
2. **Full modification control.** If temporal blending ghosts on hair, we can add
   `if (materialID == HAIR) alpha = 0.5` — impossible with NRD's compiled library.
3. **No library dependency.** We compile our own compute shaders. No version-locked runtime.
4. **The math is equivalent** for our signal. Both do: tile classify → spatial → temporal
   with neighborhood clamping. SIGMA adds penumbra width estimation (irrelevant for us).

---

## System Architecture — Complete Data Flow

### The Circular Dependency Problem

The denoiser needs to READ the stable shadow result BACK into the same shader that
PRODUCES the raw shadow. Solution: **one frame of latency** (same model as TAA).

```
FRAME N:
  ClusteredLightingDeferred:
    - Samples shadow atlas (12-tap PCF) → raw shadow factor
    - READS previous frame's temporal result from Set 3 binding 3
    - Blends: finalShadow = mix(rawPCF, previousTemporalResult, blendFactor)
    - Writes lighting output using blended shadow
    - ALSO writes raw shadow factor to Set 3 binding 2 (for denoiser)
  
  Our 3 compute passes (AFTER ClusteredLightingDeferred):
    - Pass 1: Tile Classify → tile map
    - Pass 2: Spatial Filter → filtered shadow
    - Pass 3: Temporal Stabilize → writes history[N]
  
FRAME N+1:
  ClusteredLightingDeferred:
    - Reads history[N] from Set 3 binding 3 ← STABLE DATA (one frame old)
    ...
```

### Detailed Data Flow Diagram

```
┌──────────────────────────────────────────────────────────────────────────┐
│ FRAME N                                                                   │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  [Engine] GBuffer Pass                                                    │
│     └─ Writes: depth, normals, albedo, material, MOTION VECTORS           │
│                                                                           │
│  [Engine] Shadow Atlas Pass                                               │
│     └─ Writes: D32 staging → R16 atlas (8192×8192)                        │
│                                                                           │
│  [RenoDX] ClusteredLightingDeferred (14 variants via uber-shader)         │
│     ├─ READS (engine): shadow atlas (set 1, binding 41)                   │
│     ├─ READS (ours):   temporal history (set 3, binding 3) ◄────────┐    │
│     ├─ COMPUTES: raw PCF shadow factor per pixel per light            │    │
│     ├─ BLENDS: finalShadow = mix(rawPCF, temporalHistory, 0.85)      │    │
│     ├─ WRITES (engine): lighting output (_46, _47)                    │    │
│     └─ WRITES (ours): raw shadow factor (set 3, binding 2) ──┐       │    │
│                                                                │       │    │
│  [ASI] Pass 1: Tile Classify                                   │       │    │
│     ├─ READS: raw shadow (binding 2) ◄────────────────────────┘       │    │
│     └─ WRITES: tile map (R8 320×180)                                  │    │
│                                                                        │    │
│  [ASI] Pass 2: Spatial Filter                                          │    │
│     ├─ READS: raw shadow, depth, normals, tile map                     │    │
│     └─ WRITES: filtered shadow (intermediate image)                    │    │
│                                                                        │    │
│  [ASI] Pass 3: Temporal Stabilize                                      │    │
│     ├─ READS: filtered shadow, motion vectors, history[N-1]            │    │
│     └─ WRITES: history[N] ────────────────────────────────────────────┘    │
│                                                                           │
└──────────────────────────────────────────────────────────────────────────┘
```

### Set 3 Descriptor Layout (Extended from current 2 → 5 bindings)

| Binding | Type | Format | Content | Written By | Read By |
|---------|------|--------|---------|-----------|---------|
| 0 | SAMPLED_IMAGE | R16G16_SFLOAT | GBuffer normals | Engine | Spatial filter, oriented bias |
| 1 | SAMPLED_IMAGE | R8G8_UNORM (array) | IS-FAST noise | ASI (one-shot) | RenoDX shaders |
| 2 | STORAGE_IMAGE | R8_UNORM | Raw shadow factor (current) | RenoDX shader | ASI passes 1-3 |
| 3 | SAMPLED_IMAGE | R8_UNORM | Temporal history (prev frame) | ASI pass 3 (prev) | RenoDX shader |
| 4 | SAMPLED_IMAGE | R16G16_SFLOAT | Motion vectors | Engine | ASI pass 3 |

### RenoDX Shader Modifications Required

The ClusteredLightingDeferred uber-shader (in RenoDX repo) needs two additions:

**1. Write raw shadow factor (new output):**
```glsl
layout(set = 3, binding = 2, r8) uniform writeonly image2D rdx_shadowFactorOut;

// Inside per-light loop — track minimum shadow across all local lights:
float rdx_minShadow = 1.0;
// (per-light, after PCF):  rdx_minShadow = min(rdx_minShadow, pcfResult);
// (after loop):
if (pc.rendering_temporal_shadows > 0.5) {
    imageStore(rdx_shadowFactorOut, ivec2(gl_GlobalInvocationID.xy), vec4(rdx_minShadow));
}
```

**2. Read temporal history (new input) and apply:**
```glsl
layout(set = 3, binding = 3) uniform texture2D rdx_temporalShadowHistory;

// In per-light shadow application:
if (pc.rendering_temporal_shadows > 0.5) {
    float stableHistory = texelFetch(rdx_temporalShadowHistory, ivec2(coord), 0).r;
    // Modulate shadow attenuation with stable result
    shadowAttenuation *= mix(1.0, stableHistory / max(rawPCF, 0.001), 0.85);
}
```

Both guarded by push constant — disabled = original behavior (zero risk to existing users).

### Dispatch Injection & Barrier Chain

Same pattern as working Hi-Z depth pyramid (`vk_hooks.cpp`):
- Hook `vkCmdEndRenderPass` or detect compute dispatch completion
- Dispatch 3 passes in sequence with barriers between (OUR images only):

```
ClusteredLightingDeferred writes binding 2 (COMPUTE_SHADER_WRITE)
  ↓ Barrier: COMPUTE_WRITE → COMPUTE_READ on shadow factor image
Pass 1 (tile classify) writes tile buffer
  ↓ Barrier: COMPUTE_WRITE → COMPUTE_READ on tile buffer
Pass 2 (spatial filter) writes intermediate
  ↓ Barrier: COMPUTE_WRITE → COMPUTE_READ on intermediate
Pass 3 (temporal) writes history[N]
  ↓ Barrier: COMPUTE_WRITE → SHADER_READ on history[N] (ready for next frame)
```

⚠️ NEVER barrier engine-owned images. Depth, normals, MVs are already in correct layout.

### Dispatch Timing — Detecting ClusteredLightingDeferred Completion

ClusteredLightingDeferred is a COMPUTE dispatch (not a render pass). We can't use
`vkCmdEndRenderPass` directly. Recommended approach:

**Inject after the first vkCmdBeginRenderPass that follows the lighting compute dispatches.**
The pipeline order is: GBuffer → Shadows → AO → ClusteredLighting(compute) → Fog → Post.
The fog/post-processing pass begins with a render pass — by that point, all lighting
compute has completed. This reuses our existing render pass detection infrastructure.

---

## ⚠️ ASSUMPTIONS — Must Verify Before/During Implementation

These are logical inferences NOT yet confirmed at runtime. Each must be tested:

| # | Assumption | Risk | Verification Method |
|---|-----------|------|--------------------|
| A1 | STORAGE_IMAGE descriptor type works at Set 3 (currently only SAMPLED_IMAGE tested) | ~~MEDIUM~~ ✅ VERIFIED 2026-06-05 | Deployed 5-binding layout with STORAGE_IMAGE at binding 2. 23K+ frames, no crash. |
| A2 | Extending Set 3 layout from 2→5 bindings won't break existing pipeline layout patching | ~~MEDIUM~~ ✅ VERIFIED 2026-06-05 | Game loads, IS-FAST + normals still work, all existing shaders function normally. |
| A3 | Motion vector image is in SHADER_READ_ONLY layout when our compute pass reads it | LOW | Engine writes during GBuffer, DLSS reads later (must be readable). Wrong layout = GPU hang (obvious). |
| A4 | ClusteredLightingDeferred dispatch is detectable for injection timing | MEDIUM | Log vkCmdBeginRenderPass after known GBuffer pass. Match by attachment format (fog = B10G11R11). |
| A5 | Ping-pong history buffers won't conflict with engine descriptor tracking | ~~LOW~~ ✅ VERIFIED 2026-06-05 | 23K+ per-frame descriptor updates without crash. Engine never sees Set 3. |
| A6 | imageStore to R8_UNORM storage image works from compute | ~~LOW~~ ✅ VERIFIED 2026-06-05 | RenoDX shader writes constant 0.5 via imageStore to Set 3 binding 2. No crash, no corruption. Toggle on/off stable. |
| A7 | Multiple uber-shader variants writing same storage image don't race | LOW | Non-overlapping tiles (verified from tile classification). Each 8×8 tile = exactly one variant. |

**Test order:** A2 first (layout extension is the foundation). Then A1 (storage image write).
Then A4 (timing detection). A3/A5/A6/A7 tested implicitly by first end-to-end run.

---

### Edge Cases & Failure Modes

| Case | Handling |
|------|----------|
| First frame (no history) | Push constant flag `historyValid=0` → shader uses rawPCF directly, writes as first history |
| Resolution change (DLSS quality) | Invalidate history + recreate images (same as desc_inject::OnResourceInvalidation) |
| Scene transitions / loading | Clear history buffers, reset sample counter |
| Multiple uber-shader dispatches/frame | Fine — 14 variants process non-overlapping tiles, all write same output |
| Camera cut (teleport) | MVs will be huge → disocclusion detection triggers → full history reset |

---

## Implementation Phases

### Phase 1: Shadow Factor Extraction (RenoDX shader-side)

**Status:** NOT STARTED

**Goal:** ClusteredLightingDeferred outputs per-pixel local light shadow factor to a
storage image bound at Set 3.

**Approach:** In the uber-shader body, after the per-light shadow sampling loop completes
but BEFORE the shadow factor is multiplied into the BRDF result, write the minimum
(or luminance-weighted average) shadow factor to a storage image:

```glsl
// After all local light shadow factors computed, before BRDF application:
layout(set = 3, binding = 2, r8) uniform writeonly image2D shadowFactorOut;
imageStore(shadowFactorOut, ivec2(gl_GlobalInvocationID.xy), vec4(minShadowFactor));
```

**Decisions needed:**
- [ ] Min shadow factor vs luminance-weighted average vs per-light separation
- [ ] R8_UNORM (1 byte/pixel, 3.5MB) vs R16_SFLOAT (7MB, more precision for spatial filter)
- [ ] Storage image binding index at Set 3 (binding 2 is next available)

**Blocked by:** Nothing — can start immediately once format decision is made

---

### Phase 2: Motion Vector Capture (ASI-side)

**Status:** ✅ COMPLETE (2026-06-05)

**Goal:** Identify and capture the motion vector VkImage handle for binding to our
compute shader.

**Implementation:** Exclusion-based detection in `Hook_vkCreateFramebuffer`:
- 2-attachment FB at render res, attachment[1] = GBuffer depth → attachment[0] is MV
- Excludes normals (already identified from 6-attachment GBuffer FB)
- Creates VkImageView (R16G16_SFLOAT) for compute binding
- Auto-invalidates on depth image change (loading transitions)

**Challenge:** Three R16G16_SFLOAT 2560x1440 images exist with IDENTICAL creation params.
Cannot distinguish by format/size/usage alone (all have TRANSFER_SRC|TRANSFER_DST|SAMPLED|COLOR_ATTACHMENT).

**Identification strategy (exclusion approach):**
1. GBuffer normals already identified via framebuffer attachment [1] (WORKING)
2. Track all R16G16_SFLOAT images at render resolution
3. Motion vectors = the one that is NOT normals AND participates in a render pass
   with the GBuffer depth but as a CLEAR-loaded color attachment

**Evidence (Nsight C++ Capture, VERIFIED):**
- `VkImage_uid_116695` = GBuffer normals (attachment [1])
- `VkImage_uid_121790` = Motion vectors (DLSS NGX "MotionVectors" param confirms)
- `VkImageView_uid_121791` = MV view (passed to DLSS)
- `VkImage_uid_121772` = Unknown (possibly prev-frame normals)
- Format: R16G16_SFLOAT, 2560×1440, Usage: TRANSFER_SRC|TRANSFER_DST|SAMPLED|COLOR_ATTACHMENT
- MV convention: `MV.Scale.X = -1.0, MV.Scale.Y = -1.0` (negated NDC, DLSS standard)
- Written by GBuffer pass as color attachment, available after GBuffer completion

**Implementation plan:**
1. In `Hook_vkCreateImage`: track all R16G16_SFLOAT at render res (max 4 candidates)
2. In `Hook_vkCreateFramebuffer`: exclude normals (already done)
3. In `Hook_vkCmdBeginRenderPass`: detect the MV pass (R16G16_SFLOAT attachment with
   LOAD_OP_CLEAR, reuses GBuffer depth, not the GBuffer FB itself)
4. Store identified MV image handle, create VkImageView for compute binding

**Blocked by:** Nothing — can implement detection in vk_hooks.cpp now

---

### Phase 3: Persistent Shadow History Buffer (ASI-side)

**Status:** ✅ COMPLETE (2026-06-05)

**Implementation:** 2× R8_UNORM images at render resolution (2560×1440), STORAGE|SAMPLED.
Ping-pong via `frameIndex ^= 1` at Present. ~7MB total VRAM. Created in `shadow_denoise::Init()`.

**Pattern:** Same as Hi-Z depth pyramid creation in `hiz_pipeline.cpp` — proven approach.

**Blocked by:** Nothing

---

### Phase 4: Compute Shader — Tile Classify (ASI dispatch)

**Status:** NOT STARTED

**Goal:** 8×8 tile classification to skip fully-lit and fully-shadowed regions.

**Algorithm:**
1. Each thread group processes one 8×8 tile
2. Read shadow factor for all 64 pixels in tile
3. Compute min and max across tile (subgroup reduction)
4. Classify:
   - `min == max == 1.0` → FULLY_LIT (skip)
   - `min == max == 0.0` → FULLY_SHADOWED (skip)
   - else → PENUMBRA (process in Pass 2 and 3)
5. Write classification to tile buffer (R8 at tile resolution)

**Performance:** ~0.01ms (trivial — just reads + reduction)

**Blocked by:** Phase 1 (needs shadow factor image as input)

---

### Phase 5: Compute Shader — Spatial Filter (ASI dispatch)

**Status:** NOT STARTED

**Goal:** Edge-preserving spatial blur on penumbra tiles, weighted by temporal confidence.

**Algorithm (FidelityFX-inspired):**
1. Only dispatch on PENUMBRA tiles (from Phase 4 output)
2. 3×3 or 5×5 Gaussian kernel
3. Edge weights: depth discontinuity → weight = 0 (preserve geometry edges)
4. Normal discontinuity → weight = 0 (preserve surface orientation changes)
5. Kernel width adapts: wider when temporal sample count is low (young history)
6. As temporal accumulation builds confidence, spatial filter contribution decreases

**Inputs:** shadow factor, depth, normals (all available at Set 3 or engine sets)
**Output:** spatially-filtered shadow factor (write to intermediate or directly to history)

**Blocked by:** Phase 4 (needs tile classification)

---

### Phase 6: Compute Shader — Temporal Stabilize (ASI dispatch)

**Status:** ✅ COMPLETE (2026-06-06) — dispatching every frame, 6764+ verified

**Implementation:** Single compute pass (`temporal_stabilize.comp.glsl`, compiled to SPIR-V,
embedded as `temporal_stabilize_spv.inl`). Dispatches at 8×8 workgroups over render res.
Pipeline created lazily on first frame after MV capture. Barriers only on our own images.
Wired in `Hook_vkCmdEndRenderPass` after GBuffer pass end (same injection point as Hi-Z).
`AdvanceFrame()` at Present flips ping-pong. Resource invalidation on depth change.

**Skipped (for now):** Tile classify (Phase 4) and spatial filter (Phase 5).
The temporal pass alone should provide significant stabilization. Tile classify and
spatial can be added later for performance optimization (skip fully-lit tiles) and
quality improvement (edge-preserving blur before temporal accumulation).

---

### Phase 7: Integration — Feed Back to Deferred Lighting (RenoDX shader-side)

**Status:** NOT STARTED

**Goal:** ClusteredLightingDeferred reads the temporally-stable shadow mask from Set 3
instead of (or blended with) its per-frame PCF result.

**Approach:** In the uber-shader, add a mode controlled by push constant:
```glsl
if (pc.rendering_temporal_shadows > 0.5) {
    float stableShadow = texelFetch(temporalShadowMask, ivec2(coord), 0).r;
    // Replace or blend with per-frame PCF result
    shadowFactor = mix(pcfResult, stableShadow, 0.9);
}
```

**Blocked by:** Phase 6 (needs stable output available at Set 3)

---

## Dispatch Injection Point

Same pattern as Hi-Z depth pyramid (proven working in `vk_hooks.cpp`):
- Hook `vkCmdEndRenderPass`
- Detect the deferred lighting pass completion (by render pass handle or FB match)
- After it ends: dispatch our 3 compute passes in sequence
- Barriers between passes (our own images only — never barrier engine images)

Alternative: dispatch AFTER ClusteredLightingDeferred compute dispatch completes.
The uber-shader writes shadow factor → our passes read it → next frame's uber-shader
reads our temporal output. One frame of latency (acceptable — same as TAA).

---

## Resource Summary

| Resource | Format | Size | Purpose |
|----------|--------|------|---------|
| Shadow factor (current) | R8_UNORM | 2560×1440 (3.5MB) | Per-frame shadow output from shader |
| Shadow history A | R8_UNORM | 2560×1440 (3.5MB) | Ping-pong temporal buffer |
| Shadow history B | R8_UNORM | 2560×1440 (3.5MB) | Ping-pong temporal buffer |
| Tile classification | R8_UINT | 320×180 (57KB) | Per-tile status (LIT/SHADOW/PENUMBRA) |
| **Total VRAM** | | **~10.6MB** | |

Plus: 3 compute pipelines, 1 descriptor set (or extend existing Set 3 layout)

---

## Tuning Parameters (Initial Values)

| Parameter | Value | Range | Effect |
|-----------|-------|-------|--------|
| Temporal alpha | 0.9 | 0.7–0.97 | Higher = more stable, more ghosting |
| Disocclusion depth threshold | 0.01 | 0.005–0.05 | Relative depth for history reset |
| Spatial kernel radius | 2 | 1–4 | Blur size when temporal is young |
| Spatial depth weight sigma | 0.5 | 0.1–2.0 | Edge sensitivity |
| Min temporal samples for full trust | 8 | 4–16 | Frames before spatial filter backs off |
| Neighborhood clamp expansion | 0.0 | 0.0–0.1 | Relaxes clamping (allows mild ghosting) |

All exposed via ImGui panel (SE fork) for real-time tuning.

---

## Dead Ends (from shadow-improvements.md, preserved here)

- ❌ Hijacking output image alpha (_46.a or _47.a) — unknown downstream consumers
- ❌ RT shadows — engine has zero RT infrastructure (no BLAS/TLAS/vkCmdTraceRays)
- ❌ Resolution increase alone — viewport doesn't scale with D32 4096 override
- ❌ PCF/bias/rotation changes — problem is in source data, not consumer
