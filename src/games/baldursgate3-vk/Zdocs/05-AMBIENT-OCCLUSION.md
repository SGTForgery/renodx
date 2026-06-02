# Ambient Occlusion

> Shaders: `hbao_*.frag.glsl`, `depth-deinterleave_*.frag.glsl`
> Stage: Fragment

## HBAO (Horizon-Based Ambient Occlusion)

BG3 uses **HBAO** for screen-space ambient occlusion. The implementation runs as a 4-pass fragment shader pipeline:

| Pass | Shader | Purpose |
|------|--------|---------|
| Depth Deinterleave | `depth-deinterleave_0x47DE1613.frag.glsl` | Split depth into 4×4 interleaved pattern for cache-efficient sampling |
| HBAO | `hbao_0xF70799BE.frag.glsl` | Per-direction horizon search in screen space |
| Bilateral Blur | `hbao-bilateral-blur_0x93ED1679.frag.glsl` | Edge-preserving spatial blur to denoise AO |
| Composite | `hbao-composite_0xBD3EE691.frag.glsl` | Blend AO result into the scene |

### Depth Deinterleave

The first pass splits the full-resolution depth buffer into a 4×4 interleaved pattern. Each sub-image contains every 4th pixel, which improves cache coherence during the horizon search since neighboring samples in the sub-image are spatially spread out in screen space.

### HBAO Main Pass

The core AO computation:
- For each pixel, marches along multiple directions in screen space
- At each step, computes the horizon angle by comparing depth values
- The AO contribution is the integral of the unoccluded solid angle above the horizon
- Uses the deinterleaved depth for efficient sampling

### Bilateral Blur

Edge-preserving blur that smooths the noisy per-pixel AO result:
- Depth-aware weighting prevents blurring across depth discontinuities (object edges)
- Normal-aware weighting preserves AO detail at surface orientation changes

### Composite

Blends the final AO value into the scene, typically as a multiply on ambient/indirect lighting.

## Depth Linearization (Reversed-Z)

BG3 uses reversed-Z depth (1.0 = near, 0.0 = far):
```glsl
float linearDepth = 1.0 / (ZBUFFER_Z * rawDepth + ZBUFFER_W);
```

## View-Space Reconstruction

```glsl
vec3 viewPos = vec3(
    (screenUV * 2.0 - 1.0).x * tan(fov_h/2) * linearDepth,
    -(screenUV * 2.0 - 1.0).y * tan(fov_v/2) * linearDepth,
    linearDepth
);
```

## AO Integration in Deferred Lighting

AO is read from a texture in the deferred lighting pass and applied to ambient/indirect lighting as a standard AO multiplication factor.

## Key Parameters for Ghidra

When looking for AO-related structures in the binary:
- The `ZBufferParams` pattern (near, far, 1/near-1/far, 1/far) is distinctive and shared with other depth-reading passes
- The 4×4 deinterleave pattern means you'll see 16 sub-image render targets created at 1/4 resolution
- The bilateral blur uses depth thresholds to detect edges — look for depth comparison constants
