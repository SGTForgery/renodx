# Cascaded Shadow Maps (CSM) System

> Shader: `csm_0x8AD4A32B.frag.glsl`
> Stage: Fragment (fullscreen or tile pass)

## Overview

BG3 uses a **4-cascade CSM** system with PCSS (Percentage-Closer Soft Shadows). The CSM shader reads depth, reconstructs world position, projects into each cascade, and performs a multi-stage shadow lookup.

## Shadow Atlas Architecture

### Rendering and Packing

Shadow maps are not rendered directly into a final atlas. Instead, the game uses a multi-step process:

1. **Per-cascade render**: Each cascade is rendered into a **2048×2048** intermediate shadow map texture
2. **Actual shadow content**: The active shadow region within that 2048×2048 texture is only **1024×1024** for the 3 close-range cascades. The long-range (4th) cascade appears to use the full **2048×2048**
3. **Blit to shared atlas**: The per-cascade results are then blitted/copied onto a shared **8192×8192** shadow map resource

### Atlas Layout

The 8192×8192 shared atlas contains:
- The 4 CSM cascades packed into designated regions
- Additional cached shadow maps from other sources (point/spot light shadows, static shadows)
- Not all regions update every frame — many are cached and only re-rendered when needed

This packing scheme is visible in the `shadow-depth-linearization-atlas-packing_0xE4E786B2.frag.glsl` shader, which handles the linearization and atlas coordinate remapping.

### Resolution Implications

The effective shadow resolution is quite low:
- **Close cascades (0–2)**: 1024×1024 each — this is notably small for a modern title and contributes to the visible shadow aliasing and shimmer
- **Far cascade (3)**: 2048×2048 — higher resolution for the long-range cascade, likely because it covers a much larger world-space area and would look unacceptably blocky otherwise
- The 2048×2048 intermediate texture is larger than the actual shadow content for cascades 0–2, suggesting the game allocates a fixed-size render target and only uses a sub-region

### Why This Matters for Reverse Engineering

- Look for `vkCmdBlitImage` or `vkCmdCopyImage` calls between the 2048×2048 intermediate and the 8192×8192 atlas — these mark the packing step
- The 8192×8192 atlas is the texture actually sampled in the CSM resolve shader (bound as `_9`, a `texture2DArray` at set 2, binding 8)
- The atlas coordinate remapping is handled by the per-cascade view-projection matrices (`_m10[0..3]`) which include the atlas sub-region offset/scale
- Cached shadow maps in the atlas (from point/spot lights) may not update every frame — look for conditional render pass submissions

## Cascade Selection

Cascades are tested in order 0→3. For each cascade:
1. Project world position into cascade's clip space via `_m10[cascadeIdx]` (4×4 matrix array at set 2, binding 26)
2. Compute edge fade: `clamp((1 - abs(clipXY * 2 - 1)) / cascadeEdgeSize, 0, 1)`
3. Depth validity: `clamp(clipZ × nearScale / (farScale × halfEdge), 0, 1)`
4. Combined weight = `edgeFade.x × edgeFade.y × depthValidity`
5. First cascade with weight > 0 is selected; if weight < 1, blend with next cascade

### Cascade Parameters (UBO at set 2, binding 26)

| Field | Meaning |
|-------|---------|
| `_m4` | Tan of shadow cone angle |
| `_m6` | Cascade edge softness |
| `_m7` | Depth bias scale |
| `_m8[0..3]` | Per-cascade far plane |
| `_m9[0..3]` | Per-cascade texel size (resolution) |
| `_m10[0..3]` | Per-cascade view-projection matrices |

## Shadow Lookup: Two-Phase PCSS

### Phase 1: Blocker Search

- **Samples**: `7 - cascadeIdx` (more samples for closer cascades)
- **Pattern**: Vogel disk with golden angle rotation (`2.3999631...` radians)
- **Dither**: Per-pixel rotation from blue noise + frame counter
- Subgroup quad operations aggregate blocker results across 2×2 pixel quads when `_183 > 0` (edge detection metric)
- Output: average blocker depth

### Phase 2: PCF Shadow Test

- **Samples**: `9 - cascadeIdx`
- **Penumbra width**: `min(0.21, tan(coneAngle) × (blockerDepth - surfaceDepth) × cascadeFar) / cascadeTexelSize`
- Uses `sampler2DArrayShadow` with hardware PCF
- Cascade blending: if current cascade weight < 1, a second PCF pass runs on the next cascade with offset rotation

## Normal-Based Bias

The shader computes a bias offset from the surface normal projected into cascade space:
```glsl
vec3 normalInCascade = normal * mat3(cascadeMatrix);
float biasScale = 0.00048828125 * cascadeTexelSize;
vec3 bias = normalInCascade * biasScale;
bias.z += max(0, 1.52587890625e-05 - biasScale / cascadeFar);
```

### Normal Source: Depth-Reconstructed Derivatives

The vanilla CSM shader does **not** read the GBuffer normal texture. Instead, it reconstructs surface normals from **screen-space depth derivatives** using `dFdxFine`/`dFdyFine`:

```glsl
vec3 dPdx = dFdxFine(worldPosition);  // position change across pixel in X
vec3 dPdy = dFdyFine(worldPosition);  // position change across pixel in Y
vec3 derivNormal = normalize(cross(dPdx, dPdy));
```

This is a common technique that avoids an extra texture read, but has a notable drawback: because the world position is reconstructed as `viewRay × depth`, and the view ray includes TAA jitter, the derivative normals shift slightly each frame. This can cause the bias offset to change frame-to-frame, leading to shadow acne or flickering on surfaces where the bias is marginal.

An edge detection metric (`_183`) is also computed from these derivatives to blend between derivative-based bias and a simpler depth-only bias for edge pixels:
```glsl
float edgeMetric = max(0, min(1, 2.0 * max(dot(crossProduct, crossProduct),
    abs(dot(crossProduct, diagonalQuadDelta)) * scale * 60.0) - 0.2));
// edgeMetric near 1.0 = flat surface (use depth bias)
// edgeMetric near 0.0 = edge/silhouette (use normal bias)
```

## Analysis: Why Depth-Reconstructed Normals Instead of GBuffer Normals?

Nearly every modern deferred renderer reads the GBuffer normal for shadow bias. BG3 is an outlier — it reconstructs normals from depth derivatives instead. This is worth investigating in Ghidra because it causes real visual problems.

### Observed Artifacts

1. **Shadow acne**: The derivative normal wobbles frame-to-frame due to TAA jitter in the view ray. This shifts the bias offset each frame, causing pixels to alternate between shadowed and lit — visible as shimmering/flickering on surfaces.
2. **Peter panning**: To compensate for the unreliable normals, the bias must be set conservatively large. This pushes shadows away from their casters, creating visible gaps between objects and their shadows (especially noticeable on characters and small props).
3. **Incorrect bias on normal-mapped surfaces**: `dFdxFine`/`dFdyFine` only capture the geometric (mesh) normal, not the per-pixel normal from normal maps. A brick wall with a flat mesh but detailed normal map gets a single flat bias across the whole surface, when it should vary per-texel. This causes acne in the crevices and over-bias on the raised areas.
4. **Edge artifacts**: At silhouette edges and depth discontinuities, the cross product of `dFdx`/`dFdy` produces degenerate or wildly incorrect normals. The edge detection metric (`_183`) tries to mitigate this but it's a heuristic — it can't fully recover.
5. **Subgroup quad dependency**: The shader uses `subgroupQuadSwapDiagonal` to compute a secondary edge metric, which means the normal quality depends on what's in the neighboring pixels of the 2×2 quad. At object boundaries this is unreliable.

### Possible Reasons Larian Chose This Approach

These are hypotheses to investigate in the binary:

1. **Pipeline ordering constraint**: The CSM resolve may run before the GBuffer normal is available, or in a render pass that doesn't have access to it. In Vulkan, adding a texture dependency means either a subpass dependency or a pipeline barrier — Larian may have wanted to avoid the synchronization cost or the architectural complexity.

2. **Descriptor set limitation**: The CSM shader uses sets 0, 1, and 2. The GBuffer normal lives in set 1 of the deferred lighting pass but may be bound to a different binding/set during the shadow resolve. Adding it would require modifying the pipeline layout, which affects all shaders sharing that layout.

3. **Forward rendering heritage**: The Divinity Engine may have originally been a forward renderer (Divinity: Original Sin 1/2 were simpler). The CSM system may predate the deferred pipeline and was never updated to use GBuffer data.

4. **Material complexity**: BG3 has many material types (hair, eyes, terrain, two-layer, transmissive). Each writes normals differently to the GBuffer. The derivative approach is material-agnostic — it works the same regardless of what wrote the GBuffer. Larian may have chosen simplicity over quality.

5. **Performance trade-off**: Reading an additional fullscreen texture (R16G16_FLOAT) in the shadow resolve adds bandwidth. On bandwidth-constrained GPUs this could matter, though the quality cost seems hard to justify.

### What to Look For in Ghidra

- **Render pass structure**: Check if the CSM resolve runs inside the same render pass as the GBuffer write (which would make the normal RT inaccessible as a texture) or in a separate pass (where it could be bound).
- **Pipeline layout for hash `0x8AD4A32B`**: Check what descriptor sets and bindings are defined. If set 1 doesn't include the normal texture binding, that confirms a layout constraint.
- **Barrier/dependency analysis**: Look for `vkCmdPipelineBarrier` calls between the GBuffer pass and the CSM resolve. If there's no image layout transition for the normal RT before the CSM pass, the texture simply isn't available.
- **Other shaders reading GBuffer normals**: The deferred lighting shader (`0xAB2320F6`) reads the normal from set 1, binding 1. Compare its pipeline layout to the CSM shader's layout to see what's different.

## Close-Up Shadow System (Per-Object Shadow Maps)

The game does **not** rely solely on CSMs for all shadow distances. When the camera is close to characters/objects, a **separate per-object shadow map system** takes over. This is controlled by the UBO at set 1, binding 0 (`_19`):

### Distance-Based Switching

```glsl
if (_19._m1 != 0u)  // close-up shadow system enabled
{
    if ((farPlane * depth) > _19._m3)  // distance threshold check
    {
        // Beyond threshold: use per-object shadow maps
        // Falls back to CSM result if per-object maps don't cover the pixel
    }
    else
    {
        // Within threshold: use CSM result only
    }
}
```

The switching is based on `_19._m3` — a world-space distance threshold. When the camera-to-pixel distance exceeds this threshold, the shader checks two additional shadow map arrays before falling back to the CSM result.

### Two Per-Object Shadow Map Arrays

The close-up system uses two separate `texture2DArray` resources with their own view-projection matrices:

| Resource | Binding | Matrix | Bias | Purpose |
|----------|---------|--------|------|---------|
| `_17` | set 1, binding 4 | `_19._m5` | `4.99e-05` (small) | High-resolution close shadow map — used when the pixel also falls within cascade 3's coverage (blended via `min` with CSM) |
| `_16` | set 1, binding 3 | `_19._m4` | `0.0007` (larger) | Fallback close shadow map — used when the pixel is outside `_17`'s projection |

Both are sampled as `sampler2DArrayShadow` with a single hardware PCF tap (no PCSS), using `_19._m2` as the array layer index.

### Close-Up Shadow UBO (set 1, binding 0)

```c
struct CloseUpShadowParams {
    uint  flags;              // _m0: feature flags
    uint  enabled;            // _m1: non-zero = close-up shadows active
    uint  arrayLayer;         // _m2: texture array layer index
    float distanceThreshold;  // _m3: world-space distance for switching
    mat4  viewProjClose;      // _m4: view-projection for fallback shadow map (_16)
    mat4  viewProjHiRes;      // _m5: view-projection for high-res shadow map (_17)
};
```

### Implications

- At **far distances** (zoomed out, tactical view): only CSMs shadow everything, including characters
- At **close distances** (dialogue, close-up): per-object shadow maps provide higher-quality character shadows, with the CSM result used as a floor via `min(csmShadow, closeUpShadow)`
- The per-object maps use simple single-tap PCF (no PCSS soft shadows), so close-up character shadows have hard edges
- These per-object shadow maps are rendered separately from the CSM cascades and stored in their own texture arrays — look for additional shadow render passes targeting `_16`/`_17` in the frame

## No Contact Shadows or Micro Shadow Detail

The base game has **no form of screen-space contact shadows or micro shadow detail**. There is no ray-marched contact shadow pass, no depth-based micro-occlusion, and no heightmap-traced self-shadowing on surfaces. All shadowing comes exclusively from the shadow map systems described above (CSMs + per-object close-up maps + per-light shadow atlas).

This means fine-scale shadow detail — brick grooves, armor edges, fabric folds, terrain bumps — is entirely dependent on shadow map resolution. At 1024×1024 per close cascade, this detail is largely absent. The lack of any screen-space contact shadow technique is a notable gap compared to most modern renderers.

## Additional Shadow Sources

### Static Shadow Maps (VSM)

- Checked when `_19._m1 != 0` (UBO at set 1, binding 0)
- Two additional shadow map arrays (`_16`, `_17`) for static/baked shadows
- Applied when pixel is beyond cascade 3 coverage

### Shadow Tile Classification

- `shadowmap-tile-classification_0xA64685BD.comp.glsl`
- Pre-classifies tiles for shadow quality levels

### Shadow Depth Linearization

- `shadow-depth-linearization-atlas-packing_0xE4E786B2.frag.glsl`
- Linearizes and packs shadow depths into atlas format

## Uniform Buffer Layout (set 0, binding 1 — Scene Globals)

This UBO appears in nearly every shader:

| Offset | Type | Meaning |
|--------|------|---------|
| `_m0` | vec3 | Sun/directional light direction (world space) |
| `_m2` | vec3 | Sun color |
| `_m4` | vec3 | Ambient color |
| `_m6` | mat4 | View matrix (used for view→world transform) |
| `_m7[0..2]` | vec4×3 | View frustum corner rays |
| `_m8` | vec4 | Sky color 1 |
| `_m9` | vec4 | Sky color 2 |
| `_m10`–`_m17` | float | Sky/atmosphere parameters |
| `_m19` | float | Atmospheric scattering intensity |
| `_m34` | vec3 | Sun disk color |
| `_m36` | vec3 | Sun direction (for atmospheric scattering) |
