# BG3 Shadow Improvements

## 1. Engine Shadow Architecture

### Two Separate Shadow Systems

BG3 has TWO completely independent shadow systems. Previous sessions confused them.

| System | Class | Target | Atlas | Max Tile | Consumer |
|--------|-------|--------|-------|----------|----------|
| **CSM** (Cascaded Shadow Maps) | `ls::CascadedShadowBufferStage` | Directional sun/moon | 8192×8192 D32_SFLOAT | 2048² per cascade (HOOKED → 4096) | CSM Resolve shader (0x8AD4A32B) → R8 mask → deferred lighting |
| **Local Light Shadows** (Tile-Based Omnidirectional) | `ls::LocalLightShadowStage` | Point/spot/omni lights (incl. hero lighting in dialogue/level-up) | 8192×8192 R16_TYPELESS | 2048² per light (4 faces × 1024×512) | ClusteredLightingDeferred INLINE (set 1, binding 41) — 12-tap Vogel disk PCF |

### CSM Pipeline (Directional Sun)

```
CascadedShadowBufferStage::SetQuality → this+0x2684 = resolution (HOOKED → 4096)
  → Shadow casters rendered into D16_UNORM intermediate (per-cascade viewports)
  → Depth linearization + atlas packing shader (0xE4E786B2)
  → 8192×8192 atlas (R16_TYPELESS, packed cascade tiles)
  → CSM Resolve shader (0x8AD4A32B) reads atlas, outputs R8 shadow mask
  → Deferred lighting multiplies shadow mask with sun illumination
```

**HARDWARE DEPTH BIAS: CONFIRMED ZERO (2026-06-05)**
- Nsight capture VkPipeline_uid_126220 (CSM shadow caster pipeline):
  `depthBiasEnable=0, constantFactor=0.0, slopeFactor=0.0, clamp=0.0`
- Dynamic state list: viewport + scissor ONLY (no VK_DYNAMIC_STATE_DEPTH_BIAS)
- Runtime hook confirms: 0 vkCmdSetDepthBias calls during shadow passes
- **Shadow maps already store unbiased depth.** No ASI modification needed for FFXVI approach.
- The existing bias in the CSM resolve shader is purely software (dFdx/dFdy derivative normal
  → slope calculation → comparison depth offset). Replace that logic with oriented bias.

Disabling the CSM resolve shader removes ALL directional shadows (ground shadows,
building shadows) but does NOT affect hero lighting shadows in dialogue/level-up.

### Local Light Shadow Pipeline (Point/Spot/Omni — Larian GDC: "Tile-Based Omnidirectional Shadows")

```
LocalLightShadowStage::Execute → allocates atlas tiles per light (size = f(screen coverage, distance))
  → Geometry rendered into D32_SFLOAT 2048×2048 staging buffer (tetrahedron viewports)
  → 4 faces per light packed into one tile (tetrahedron projection, not cubemap)
  → Tiles copied into 8192×8192 R16_TYPELESS atlas at allocated positions
  → ClusteredLightingDeferred reads atlas at set 1, binding 41
  → 12-tap Vogel disk PCF with IGN rotation per pixel
```

Source: Larian GDC talk + [Doghramachi15] "Tile-based Omnidirectional Shadows"

Key parameters (from GDC slide):
- Atlas: 8K (High), 2048 (Low)
- Max tile: 2K (High), 512 (Low)
- Tile size varies by: screen-space coverage + distance from camera
- Same system used in Forward pass for translucents

### Local Light Shadow Sampling in ClusteredLightingDeferred (VERIFIED — shader source)

All 14 ClusteredLightingDeferred compute shaders sample local light shadows INLINE.
There is NO separate resolve shader — shadow lookup is embedded in the per-light loop.

**Key bindings (present in ALL 14 variants):**

| Set | Binding | Type | Variable | Content |
|-----|---------|------|----------|---------|
| 1 | 39 | UBO (std140) | `_19` | ShadowParams — texel size (`_m33`), PCSS config |
| 1 | 40 | SSBO (readonly) | `_20` | ShadowMapTransforms — per-light: mat4 VP (`_m0`), tile offset (`_m1`), tile size (`_m2`), normal bias (`_m4`), near/far (`_m5`), depth scale (`_m6`) |
| 1 | 41 | texture2D | `_21` | Shadow atlas (8192×8192 R16_TYPELESS, depth comparison) |
| 1 | 32 | sampler | `_12` | Shadow comparison sampler |
| 1 | 25 | SSBO (readonly) | `_11` | LightDataBuffer — `_m8` bits: 0=has shadow, 2+=shadow index; `_m5`=shadow strength |

**Per-light shadow algorithm (12-tap Vogel disk PCF):**
1. Gate: `(_11._m0[lightIdx]._m8 & 1u) != 0` → light has atlas tile
2. Shadow index: `_m8 >> 2` → index into ShadowMapTransforms
3. World → shadow UV: `_20._m0[idx]._m0 * vec4(pos + normalBias*3.5, 1)`
4. Comparison depth: `(z - near) / (far * depthScale)`
5. Rotation: `IGN(pixel) * 2π` (first light) or cached from previous
6. 12-tap Vogel disk: radius = `sqrt(i+0.5) * 0.2887 * 2.5 * texelSize(_19._m33)`
7. Each tap: `textureGather(atlas, UV)` → 4 depth compares + bilinear
8. Final: `mix(1.0, avg_12_taps, min(lightIntensity, shadowStrength))`

**Fallback (no shadow atlas tile for light):**
- Hair/cloth + hero_lighting → 0.0 (forced full shadow, artistic)
- Other → `clamp(2*NdotL + 0.5, 0, 1)` (NdotL wrap as fake shadow)

**Resolution controlled by CPU (ASSUMPTION — not yet verified in Ghidra):**
- `_20._m0[idx]._m2` = tile size in atlas UV → determines effective texel density
- `_19._m33` = global shadow texel size → scales PCF radius
- Both written by `ls::LocalLightShadowStage::Execute` before the compute dispatch
- Override approach: hook the buffer write and increase tile size values

### What the Level-Up/Dialogue Shadows Actually Are

The hero lighting in dialogue/level-up uses 3 point/spot lights with shadow maps from
the LOCAL LIGHT system (not CSM). These lights get their shadow tiles allocated from
the same 8192×8192 atlas used by all other local lights in the game.

VERIFIED (2026-06-04):
- Disabling CSM resolve → removes ground/building shadows, hero light shadows PERSIST
- Hero light shadows visible at set 1, binding 41 (r16_typeless 8192×8192) in RenoDX DevKit
- Atlas contains character silhouettes (tetrahedron faces) from hero 3-point lighting
- Staging buffer: D32_SFLOAT 2048×2048, viewports 1024×512 per face (Nsight capture)

### Vista Shadows (Distant Static)

- Sector-based, 1 sector re-rendered per frame (amortized)
- Detailed: 1024² / 256m² (16 sectors), Broad: 2048² / 4096m² (256 sectors)
- Double-buffered, ~4.7s full refresh at 60fps

---

## 2. Root Causes (All VERIFIED)

| Problem | Root Cause | Fix |
|---------|-----------|-----|
| Shadow flickering/acne | `dFdxFine`/`dFdyFine` normals shift with TAA jitter → bias oscillates | GBuffer normals (Oriented Depth Bias) |
| Hair shadow flicker | Caster texture sampling produces frame-unstable opacity (VERIFIED: CSM resolve Mode 3/4 = no effect; caster Mode 2 force-pass = major reduction; angle term Mode 6 = no effect). Mip selection and sub-texel position shift as shadow rasterization changes per-frame (HYPOTHESIS — awaiting textureLod test). Worse in Mode 1 due to smaller viewport (512×1024 vs 2048²). | Force mip 0 (`textureLod`) + lower threshold (TESTING) |
| Blocky close-up shadows | Shadow frustum covers full character (~2m) for face close-up (~0.2m) | Tight frustum (FFXVI technique) |
| Hard shadow edges (cutscenes) | Per-object maps use single-tap PCF | Multi-tap Vogel disk PCF |
| 4096 resolution = minimal gain | Resolution was never the bottleneck (VERIFIED 2026-06-03, visual A/B: acne frequency unchanged, penumbra width unchanged, hair flicker unchanged between 2048 and 4096) | Filtering + frustum improvements needed |
| Local light shadow quality | **DIAGNOSED** — Zero temporal stability in pipeline. Hair: opacity oscillates around 0.333 threshold. Body: sub-pixel vertex animation → texel jumping. Both solved by temporal shadow accumulation (see §2b). | Screen-Space Temporal Shadow Accumulation (Tier 5) |

---

## 2b. Local Light Shadow Quality — DIAGNOSED (2026-06-05)

**Root cause: ZERO temporal stability in the local light shadow pipeline.**

### Problem Statement

Three quality issues during dialogue/level-up:
1. **Hair shadow flickering (SEVERE)**: Hair opacity oscillates around binary discard threshold (0.333)
2. **Body/face shadow instability (MODERATE)**: Sub-pixel vertex animation → texel-jumping in shadow map
3. **Overall low quality**: Stateless per-frame pipeline with no temporal smoothing

### Architectural Gap (THE ROOT CAUSE)

The local light shadow pipeline is entirely **stateless per-frame**:
- No history buffer, no EMA, no temporal accumulation
- Sub-pixel instability → visible flicker with nothing to smooth it
- PCF pre-blurs so TAA never sees raw noise as convergeable signal
- CSM by contrast: dedicated resolve → screenspace mask → TAA naturally converges

### Isolation Tests (RUNTIME-VERIFIED via DevKit)

**Consumer (ClusteredLightingDeferred) — ALL CLEARED:**
- Single-tap: shimmering still present → PCF not the cause, atlas data already bad
- Static rotation: no improvement → not from IGN pattern
- Zero bias: added acne, same quality → bias not the cause
- UV/tile visualization: correct mapping and sizes

**Producer — Hair (HairShadowcaster_0x65692EB2):**
- Force-pass (no discard): **MAJOR reduction** → discard IS the hair-flicker source
- Danger zone [0.25, 0.42]: ALL flickering pixels shown → **opacity oscillation around 0.333**
- IS-FAST stochastic: redistributes noise, doesn't fix
- Coverage boost, angle removal, threshold lowering: all insufficient

**Producer — Opaque:** Skinned mesh sub-pixel vertex shifts → whole-texel jumps at ~1024×512/face

### Verified Root Causes

**Hair:** `if (opacity < 0.333) discard;` oscillates frame-to-frame from vertex skinning shifts  
**Body:** Sub-pixel animation → texel jumping → stairstepping without temporal smoothing  
**Shared:** Per-frame-independent binary depth with zero temporal integration

### Solution: Screen-Space Temporal Shadow Accumulation (Tier 5)

Compute pass after ClusteredLightingDeferred:
1. Extract per-pixel shadow factor
2. Motion-reproject history (MVs: R16G16_SFLOAT 2560×1440, VkImage_uid_121790)
3. Blend: `output = mix(current, history, 0.85)` with disocclusion reset
4. Hair flicker → converges over ~6 frames; Body stairstepping → sub-pixel smooth edges

Requirements: persistent VkImage (~3.5MB), compute dispatch injection, motion vectors, shadow factor separation.

### Dead Ends (VERIFIED — DO NOT RETRY)

- ❌ D32 2048→4096 resolution — no visible effect (VERIFIED both repos)
- ❌ PCF tap/rotation changes — atlas data already bad
- ❌ Normal bias — doesn't affect flickering
- ❌ IS-FAST stochastic alpha — redistributes noise
- ❌ Lowered threshold / angle removal / coverage boost — insufficient
- ❌ `FUN_143e0c700` — clustered dispatch at render res (RUNTIME-VERIFIED)
- ❌ `FUN_143ca2310` `+0x229c` — workgroup sizing (RUNTIME-VERIFIED)
- ❌ Broad viewport hooks — 2465 false positives

---

## 3. Improvement Plan

### Deployed (active in current ASI build)

- ✅ Shadow resolution 4096 (SetQuality hook + vkCreateImage D32 override)
- ✅ LODFactorCalc ≥ 100.0 (SE fork Detours hook)

### Critical Path — ✅ COMPLETE

**Set 3 descriptor injection** is WORKING (confirmed 2026-06-03 via RenoDX DevKit).

Implementation details:
- `Hook_vkCreatePipelineLayout` extends both 6-set (replace empty set[3]) and 3-set (append set[3]) layouts
- GBuffer normals identified via framebuffer attachment [1] (not format matching — 3 identical R16G16_SFLOAT images exist)
- Deferred finalization at Present time prevents stale image references during loading
- Piggyback bind at `firstSet=0` on patched layouts delivers Set 3 to all draws

Tier 6 feasibility also confirmed: deferred lighting compute shaders use 6-set layouts
with empty Set 3 (VkPipelineLayout_uid_1455). Set 3 injection works for both graphics
AND compute pipelines.

### Tier 1 — Shader-Only (no ASI work, no Set 3)

| # | Fix | Effort | Solves |
|---|-----|--------|--------|
| 1 | ✅ PCSS sample count increase (Mode 4: 14 blocker + 18 PCF taps) | DONE | Soft shadow banding |
| 2 | TAA unjitter (`_8._m5` subtract before cascade projection) | LOW | Cascade pop at boundaries |

Note: Item 1 is implemented as CSMResolve Mode 4 (max taps diagnostic). Item 2 may be
unnecessary now that Mode 1 (GBuffer normals) eliminates the main jitter-induced instability.

### Tier 2 — Needs Set 3 Infrastructure (IS-FAST noise texture binding)

| # | Fix | Effort | Solves |
|---|-----|--------|--------|
| 4 | ✅ IS-FAST noise for PCSS rotation (CSMResolve) | DONE | PCSS convergence, temporal stability |
| 5 | ~~Stochastic alpha in hair shadow caster~~ **DISPROVEN** (2026-06-04) — root cause is texture sampling instability from mip/sub-texel shifts, not threshold mechanism. | — | — |

### Tier 3 — Needs Set 3 Infrastructure (GBuffer normal + output textures)

| # | Fix | Effort | Solves |
|---|-----|--------|--------|
| 6 | ✅ GBuffer normals → Oriented Depth Bias (CSMResolve Mode 1) | DONE | Shadow acne/peter panning permanently |
| 7 | Bend Studio Screenspace Shadows | HIGH | Contact shadows (replaces inlined micro-shadows) |

### Tier 4 — Engine Hooks (Ghidra RE required)

| # | Fix | Effort | Solves |
|---|-----|--------|--------|
| 8 | Force max local light tile size (hook ShadowMapTransforms buffer write or tile allocator) | MEDIUM | Higher resolution hero/dialogue shadows (currently capped at 2048² per Larian GDC) |
| 9 | Cascade distance extension (g_RenderConfig+0x20/+0x24) | LOW | CSM shadow visible at greater distance |

Note: Old Tier 4 #8 "Tight shadow frustum via Mode 1 VP matrix" is REMOVED — the local
light system uses tetrahedron projection (per-face VP matrices written into ShadowMapTransforms),
not a single close-up frustum. Increasing tile size is the direct equivalent.

### Tier 5 — Custom Compute Pass (Set 3 + motion vectors + ASI dispatch)

| # | Fix | Effort | Solves |
|---|-----|--------|--------|
| 10 | 🔨 Temporal Shadow Denoiser for LOCAL LIGHT shadows (FidelityFX architecture) | MEDIUM | Hair flicker, body stairstepping, all local light shadow instability |
| 11 | XeGTAO Bent Normal Shadows (AO replacement outputs bent normal → micro-shadow modulation) | MEDIUM | Texture-level shadow detail shadow maps cannot capture |

**Item 10 status:** DESIGNED, implementation planned. See `temporal-shadow-denoiser.md`.
Target: local light shadows (hero lighting, point/spot) — NOT CSM (which already has
Mode 1 + IS-FAST providing adequate stability).

### Tier 6 — Full Shadow Resolve Replacement (FFXVI Tiled Deferred Shadows)

| # | Fix | Effort | Solves |
|---|-----|--------|--------|
| 12 | FFXVI-style Tiled Deferred Shadow system (replace engine CSM resolve entirely) | HIGH | All shadow quality issues simultaneously — smooth penumbras, flicker-free bias, character closeups, per-tile early-out |

---

## 4. Technique Details

### 4.1 IS-FAST Noise (Tier 2 — All Stochastic Effects)

EA's Importance-Sampled Filter-Adapted Spatio-Temporal noise. Pre-computed 2D vector
noise slices with importance-sampled Gaussian distribution, optimized for temporal
convergence under TAA. Proven in multiple shipped titles.

Reference: `patches/BG3/references/IS-FAST/` (32 PNG slices, 128×128, vec2 per texel)
Source: https://github.com/electronicarts/importance-sampled-FAST-noise

**Texture Format:**
- 32 files, 128×128 each → 2D array texture 128×128×32
- Each texel stores a vec2 value (RG channels). Files ending in `.0.png` are unoptimized
  white noise (for paper experiments) — ignore them.
- Load as **R8G8_UNORM** (2 channels, 8-bit per channel from PNG). Normalize to [0,1] in shader.
- Alternative: pre-convert to **R16G16_SFLOAT** at build time for [-1,1] range (saves ALU in shader).
- VkFormat for the texture array: `VK_FORMAT_R8G8_UNORM` (direct from PNG, 2 bytes/texel, 1MB total)
  or `VK_FORMAT_R16G16_SFLOAT` (pre-processed, 4 bytes/texel, 2MB total).

**Sampling:** Sample at `(pixelX, pixelY, sampleIndex) % (128, 128, 32)` to get a vec2.
For more than 32 samples, compute a cycle index = `sampleIndex / 32` and use it to offset
the texture globally via a stateless 2D shuffle (golden ratio + Hilbert curve bijection).
This creates a per-pixel sampling sequence 128×128×32 = 524,288 samples long before repeating.
Reference for the shuffle: https://blog.demofox.org/2024/10/04/a-two-dimensional-low-discrepancy-shuffle-iterator-random-access-inversion/

**Binding:** 2D array texture at Set 3. Single texture bind drives ALL stochastic effects:
- PCSS Vogel disk rotation (shadow sampling)
- Stochastic alpha test (hair shadow caster)
- Volumetric fog ray jitter
- Depth of Field sampling
- Any future dithering or stochastic effect

**Why IS-FAST over IGN/STBN:**
- Importance-sampled: adapts to target distribution (Gaussian, uniform, etc.)
- Better temporal convergence than STBN under aggressive TAA history rejection
- Single texture for all effects (one bind, universal usage)
- Proven in production across multiple game titles

### 4.2 ~~Stochastic Alpha — Hair Shadow Fix~~ (DISPROVEN)

**Status: DISPROVEN (2026-06-04).** Empirical testing showed hair flicker is NOT caused
by the hard threshold mechanism. IS-FAST stochastic alpha made it worse. Root cause is
texture sampling instability from mip/sub-texel shifts in light-space rasterization.
The temporal shadow denoiser (Tier 5) solves this by converging the noisy per-frame
output over time — it doesn't matter WHY the shadow flickers, only that it does.

### 4.3 Oriented Depth Bias (✅ IMPLEMENTED — CSMResolve Mode 1)

**Status: DONE.** Implemented as Mode 1 in CSMResolve_0x8AD4A32B via RenoDX.
Uses GBuffer normals from Set 3 binding 0 instead of derivative normals.
Eliminates TAA-jitter-induced bias oscillation for directional shadows.

### 4.4 Bend Studio Screenspace Shadows (Tier 3 — Sony 2023)

Reference: `patches/BG3/references/BendStudioScreenspaceShadows/` (Apache 2.0)

Standalone compute pass injected after GBuffer (same pattern as our Hi-Z build):
- 60 samples/pixel, wave-parallel ray march toward light
- Bilinear + edge detect, hard contact + soft fade-out
- Output: R8_UNORM at render resolution, read by deferred lighting via Set 3
- Cost: ~0.3-0.5ms on RTX 5090

**Porting requirement:** The reference code is pure HLSL (DXC compiler, DX12-oriented).
Porting to our Vulkan SPIR-V pipeline requires:
- Compile with DXC `-spirv` flag (HLSL→SPIR-V path, same compiler we already use)
- Replace `RWTexture2D<float>` with SPIR-V storage image bindings
- Replace `WaveActiveAnyTrue`/`WaveGetLaneCount` with SPIR-V subgroup operations
  (`subgroupAny`, `gl_SubgroupSize`) — Vulkan 1.1 guaranteed
- Replace `GroupMemoryBarrierWithGroupSync` with `barrier()` + `memoryBarrierShared()`
- Replace `SamplerState` (combined) with separate sampler/image pairs (Vulkan convention)
- Port CPU dispatch logic (bend_sss_cpu.h `BuildDispatchList`) into ASI hook code

**Dispatch architecture:** Multiple dispatches per light (4-8 typical, max 8). Each
dispatch covers a quadrant around the light's screen-space position. Dispatches are
independent — no GPU sync between them. Our ASI hooks vkCmdEndRenderPass to inject.

### 4.5 Tight Shadow Frustum (Tier 4 — FFXVI "Closeup Shadowmap")

Hook the engine function that computes Mode 1 VP matrices (`_19._m4`/`_19._m5`) and replace
with a tight frustum covering only the visible face region:

1. Detect Mode 1 activation (g_RenderConfig+0x80 == 1)
2. From camera VP matrix (`g_vpMatrix`), compute screen-space bounds of the target
3. Construct shadow frustum covering only visible region (~0.3m) instead of full character (~2m)
4. Write tight VP matrix to the UBO before shadow caster rendering

Same 2048² map covers 6-10× fewer world-space meters → 6-10× more texels on screen.
Modifies the matrix BEFORE shadow caster rendering — depth pass itself renders at higher
effective resolution.

**RE needed:**
- Find the function writing `_19._m4`/`_19._m5` (close-up shadow VP matrices)
  - Search: xrefs to UBO at set 1, binding 0 writes; trace vkUpdateDescriptorSets calls
    during Mode 1 frames; string search for "CloseUp" or "closeup" in Ghidra
- Verify caster frustum culling interaction — does the engine cull shadow casters against
  the shadow frustum? If yes, our tight frustum might exclude body parts that cast shadows
  on the face. May need to disable caster culling for Mode 1.
- Camera target detection — need face/head world position for frustum centering.
  Likely in the dialogue camera controller (check camera target entity component, or
  read from the close-up shadow UBO itself — `_19._m4` inverse gives the target point)
- Verify cascade VP matrices are recomputed per-frame from distance settings — if the
  engine pre-computes them at init time, extending distances won't update projections
  (this applies to Tier 4 item 9 as well)

### 4.6 Cascade Distance Extension (Tier 4 — Direct Memory Patch)

Write extended values to `g_RenderConfig+0x20` and `+0x24`:
```cpp
*(int*)(g_RenderConfig + 0x20) = extendedDistance1;  // default ~80m → extend to ~150m
*(int*)(g_RenderConfig + 0x24) = extendedDistance2;  // default ~40m → extend to ~80m
```

**RE needed:**
- Verify exact field semantics (meters? scaled? int or float?) via livetools mem read at runtime
- Confirm cascade VP matrices are recomputed per-frame from these distance values.
  If the engine recomputes VP matrices from g_RenderConfig distances every frame (likely —
  cascade matrices must update when the camera moves), then writing new distances is sufficient.
  If VP matrices are computed once at quality-change time and cached, we'd also need to hook
  the VP matrix recomputation function or trigger a quality re-init.
- Check: do `_13._m8[0..3]` (per-cascade far planes in the CSM UBO) update automatically
  when g_RenderConfig distances change? Read them at runtime before/after patching distance.

### 4.7 Temporal Shadow Denoiser (🔨 IN PROGRESS — see `temporal-shadow-denoiser.md`)

**Status: Phase A COMPLETE (2026-06-05).** Infrastructure deployed and runtime-verified.
Full implementation plan in `temporal-shadow-denoiser.md`.

**Phase A verified:**
- Set 3 extended to 5 bindings (STORAGE_IMAGE at binding 2 works)
- Shadow factor image (R8_UNORM 2560×1440) created
- History ping-pong buffers (2× R8_UNORM) created, per-frame descriptor flip working
- Motion vectors identified and captured (2-attachment FB exclusion method)
- Zero crashes across full gameplay session

**Phase C validation COMPLETE (2026-06-05):**
- RenoDX shader `imageStore` to binding 2 confirmed working (constant 0.5, no crash)
- Toggle on/off via push constant stable — A6 verified

**Phase B pipeline BUILT (2026-06-05):**
- `temporal_stabilize.comp.glsl` → SPIR-V compiled, embedded in ASI
- `InitPipeline()` + `Dispatch(cb)` + `ShutdownPipeline()` implemented
- Barriers on OUR images only (shadow factor, history) — follows Hi-Z pattern
- NOT YET DISPATCHED — needs injection timing wired in vk_hooks.cpp

**Next: Wire dispatch** (detect ClusteredLightingDeferred completion → call `shadow_denoise::Dispatch(cb)`) then **upgrade shader** to real shadow factor extraction.

**Target:** Local light shadows (hero lighting, point/spot) — computed INLINE by
ClusteredLightingDeferred with zero temporal stability. NOT CSM (already stabilized
by Mode 1 + IS-FAST).

**Technique:** AMD FidelityFX Shadow Denoiser architecture (tile classify → spatial
filter → temporal stabilize). Open source, signal-agnostic, proven on noisy shadow masks.

**Data flow:** ClusteredLightingDeferred writes raw shadow factor to Set 3 storage image →
our 3 compute passes produce stable history → next frame's ClusteredLightingDeferred
reads stable result from Set 3 (one frame latency, same as TAA model).

**Motion Vector Source (VERIFIED — Nsight C++ Capture):**
- Image: `VkImage_uid_121790`, View: `VkImageView_uid_121791`
- Format: R16G16_SFLOAT, 2560×1440 (render resolution)
- Usage: `TRANSFER_SRC | TRANSFER_DST | SAMPLED | COLOR_ATTACHMENT`
- Convention: `MV.Scale.X = -1.0, MV.Scale.Y = -1.0` (negated NDC, DLSS standard)
- Written by GBuffer pass, consumed by DLSS NGX as "MotionVectors" parameter
- ⚠️ THREE identical R16G16_SFLOAT images exist — CANNOT identify by format alone!
  Must use exclusion approach (see `kb.h` R16G16_SFLOAT disambiguation section)

**Resources:** ~10.6MB VRAM (shadow factor + 2× history + tile map), motion vectors, Set 3.

**Builds toward FFXVI (Tier 6):** The temporal stabilizer + history buffer + MV capture
become downstream modules that FFXVI's VisibilityBuffer feeds into. Nothing wasted.

**Builds toward ReSTIR (§4.10):** ReSTIR reduces which lights update each frame (less noise
at source). Our denoiser cleans remaining noise. They compose — orthogonal systems.

### 4.8 XeGTAO Bent Normal Shadows (Tier 5 — POE2 / HDRP Approach)

Replace HBAO with XeGTAO, output bent normal as free byproduct of AO computation.
Use bent normal in deferred lighting for micro-shadow modulation:

```glsl
float bentShadow = saturate(dot(bentNormal, lightDir) + 0.5) * 2.0;
shadow *= lerp(1.0, bentShadow, 1.0 - ao);
```

**BG3-specific:** Deferred lighting reads AO from runtime SSAO texture (`_42`/`_43`),
NOT from GBuffer RT3. Our XeGTAO writes to same slot — seamless integration.

**Cost:** ~0.1ms for bent normal output. Micro-shadow modulation: free (1 dot + 1 lerp).

### 4.9 FFXVI Tiled Deferred Shadow System (Tier 6 — Full Replacement)

Reference: "Shadow Techniques from Final Fantasy XVI" (Sammy Fatnassi, Square Enix 2023)

Replace BG3's CSM resolve with 4-phase tiled shadow system:

1. **Tile Classification** — 8×8 tiles, Hi-Z + zBin culling → per-tile light list
2. **Accurate Light Find** — Per-pixel depth confirmation → Early Light List
3. **Shadow Generation** — PCSS 64+ samples, Oriented Bias, IS-FAST → VisibilityBuffer
4. **Closeup Composition** — Tight frustum into shared 2048² RT, composite with min()

Deferred lighting reads VisibilityBuffer via Set 3 (single fetch per light).

**Why endgame:** Unlimited samples, per-tile early-out, flicker-free bias, cinema closeups,
SSS-aware, VisibilityBuffer composes with temporal/bent normals/Bend SSS. Subsumes Tiers 1-4.

**Cost:** ~2-3ms (vs ~0.5-1ms current). Net less due to lighting VGPR savings + early-out.

**Implementation:** NOP engine CSM resolve → inject 4 dispatches → VisibilityBuffer at Set 3.

### 4.10 ReSTIR-Sampled Shadow Maps (Performance — Shadow Update Scheduling)

Reference: "Many-Light Rendering Using ReSTIR-Sampled Shadow Maps" (Zhang et al., NVIDIA 2025)
https://research.nvidia.com/labs/rtr/publication/zhang2025many-light/
Source: https://github.com/Utah-Graphics-Lab/ReSTIR-Shadow-Maps

When many lights cast shadows (30+ with "Shadows of the Gate" mod or our own flag forcing),
the CPU cost of rendering shadow depth maps every frame for ALL lights is prohibitive.
ReSTIR provides an importance-weighted selection algorithm to decide which lights get
their shadow maps re-rendered each frame.

**Core idea:** Instead of round-robin (update lights 0-9, then 10-19, then 20-29...),
use spatiotemporal reservoir resampling to select the most important lights per frame.
No RT hardware required — pure compute shader.

**How it works:**
1. Compute dispatch reads: light list (positions, radii, colors) + depth buffer + GBuffer normals
2. Per screen tile: estimate each light's contribution (NdotL × attenuation × intensity × pixel count)
3. Output: priority-sorted list of top-K light indices to update this frame
4. Shadow draw loop skips lights not in the top-K list (reuses their cached atlas tile)

**Priority logic:**
- Bright nearby torch contributing 80% illumination → always updated
- Dim distant candle contributing 2% → can be 5+ frames stale without visible artifact
- Newly spawned spell effect → immediate priority slot
- Light that moved → forced update regardless of contribution

**Cost:** ~0.1ms compute dispatch per frame. Saves 60-90% of CPU shadow draw submission
when 30+ lights are enabled.

**Implementation path:**
1. Phase 5 (optimisation.md): simple round-robin amortization first (get skip mechanism working)
2. Phase 5b: replace round-robin scheduler with ReSTIR priority compute dispatch
3. Same hooks, same skip mechanism — just smarter decision-making about WHICH lights to update

**Relationship to other techniques:**
- Complements Tier 6 FFXVI system (FFXVI handles resolve quality, ReSTIR handles update scheduling)
- Complements shadow caching (Phase 6 in optimisation.md) — static lights stay cached,
  ReSTIR only operates on the "potentially dirty" light subset

---

## 5. Engine Internals

### CascadedShadowBufferStage

| Address | Function | Notes |
|---------|----------|-------|
| `0x143dee140` | Init | Loads shaders, creates cascades, calls SetQuality |
| `0x143def960` | SetQuality | `this+0x2684` = 1024 or 2048. **HOOKED → 4096.** |
| `0x143def9e0` | CreateOrResizeRenderTargets | Uses `this+0x2684` for size |

### LocalLightShadowStage

| Address | Function | Notes |
|---------|----------|-------|
| `0x143e21d10` | Execute | Per-frame orchestrator (~2700 insns) |
| `0x143e20750` | Constructor | Vtable PTR_FUN_1459f0618 |
| `0x143e0d310` | ResizeDependentRTs | Reads *(this+0x30)+0x2180/+0x2184 |
| `0x143e0c700` | ClusteredDispatch | NOT shadow render — reads 2560×1440 (RUNTIME-VERIFIED) |
| `0x143ca2310` | SetLocalLightShadowQuality | Writes +0x229c = 9/12/18/24 (workgroup sizing, NOT tiles — RUNTIME-VERIFIED) |
| `0x143f19420` | SetupShadowUBO | Shared UBO fill, 12 callers |
| `0x143e29a40` | Init | Creates RTs and pipeline objects |
| `0x143c9f700` | GameRenderView Constructor | Vtable PTR_FUN_14589e5c0, stores render dims at +0x2290 |

### Key Struct Fields

```
CascadedShadowBufferStage:
  +0x2684: int  shadowMapResolution (HOOKED → forced 4096)

GameRenderView (vtable PTR_FUN_14589e5c0):
  +0x2290: int  render width (2560 — NOT shadow dims, RUNTIME-VERIFIED)
  +0x2294: int  render height (1440 — RUNTIME-VERIFIED)
  +0x229c: int  clustered workgroup size (9/12/18/24 — RUNTIME-VERIFIED)
  +0x22a0: int  128 (max depth layers)
  +0x29b0: int  grid dims (computed from +0x2290/+0x229c)

g_RenderConfig (*(DAT_1462a6c80)):
  +0x43: byte  LOD/shadow quality (0=best)
  +0x4A: byte  local shadow quality (read by SetLocalLightShadowQuality)
```

---

## 6. Current Status & Next Steps

### COMPLETED

- ✅ CSM shadow resolution 4096 (SetQuality hook + vkCreateImage D32 override)
- ✅ Set 3 descriptor injection infrastructure (WORKING)
- ✅ IS-FAST noise texture bound at Set 3 binding 1 (WORKING)
- ✅ Local light shadow quality DIAGNOSED (temporal instability, not resolution)
- ✅ Hardware depth bias confirmed ZERO (Nsight capture)

### Resolution vs Temporal — Complementary Fixes (NOT Either/Or)

**Temporal accumulation** solves the FLICKERING (biggest visual complaint) but produces
smooth-but-blurry shadows if source data is low resolution. At ~1024×512 per tetrahedron
face, hair strand shadows are 2-5 texels wide — temporal cannot reconstruct detail that
was never captured.

**Resolution increase** (2048→4096 per tile) gives sharper source data for temporal to
converge on. The D32 4096 override was INCONCLUSIVE — viewport stayed 2048, so we never
actually rendered at higher resolution. To properly test: hook vkCmdSetViewport when
width==2048, find caller, override to 4096. Deferred pending temporal, not abandoned.

**Implementation order:**
1. Temporal accumulation FIRST (known implementation path, biggest visual win)
2. Resolution increase SECOND (RE still needed to find viewport setter function)
3. Combined = best possible quality (sharp + stable)

### Implementation Tracker

See `temporal-shadow-denoiser.md` for phased implementation plan (FidelityFX Shadow
Denoiser architecture: tile classify → spatial filter → temporal stabilize).

### Search Targets (updated 2026-06-05)

| Priority | Target | Purpose |
|----------|--------|---------|
| **IMMEDIATE** | Temporal Shadow Accumulation compute pass | Solve flickering via convergence |
| **IMMEDIATE** | Shadow factor extraction from ClusteredLightingDeferred | Separate shadow from illumination |
| HIGH | Motion vector capture (VkImage_uid_121790) | Reprojection for temporal |
| HIGH | Resolution: hook vkCmdSetViewport width==2048 | Find viewport setter for resolution increase |
| MEDIUM | Cascade distance extension | Extend CSM range |
| ~~DEAD~~ | ~~D32 4096 alone~~ | ~~Viewport didn't scale — inconclusive~~ |
