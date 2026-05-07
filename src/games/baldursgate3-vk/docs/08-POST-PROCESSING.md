# Post-Processing Pipeline

> Shaders: bloom, auto exposure, motion vectors, TAA, film grain, UI

## Bloom

### Pre-Bloom Dithering (`pre-bloom-dithering_0x18926820.frag.glsl`)

- Adds subtle dithering before bloom to break up banding in dark gradients
- Applied before the bloom downsample chain

### Bloom Composite (`bloom_0xFDAC0941.frag.slang`)

Simple additive bloom:
```hlsl
output = sceneColor + bloomTexture.Sample(uv * scale) * 0.2;
```

- Bloom texture is sampled with UV scaling (`_6_m15`) and clamping (`_6_m11`, `_6_m12`)

## Auto Exposure

### Luminance Tile Downsample (`luminance-tile-downsample_0xD162BB3F.comp.glsl`)

- Downsamples scene luminance into tiles
- First step of the exposure computation

### Auto Exposure (`auto-exposure_0xEE04F959.comp.glsl`)

- Computes scene average luminance from the tile histogram
- Temporal smoothing for exposure adaptation
- Output: single float exposure value used by tone mapping

## Motion Vectors

### Standard Motion Vectors (`mv-depth-reconstruction_0x7371D4F6.frag.glsl`)

- Reconstructs motion vectors from current and previous frame depth + camera matrices
- Used for TAA and motion blur

### Alpha-Test Foliage Motion Vectors (`mv-alpha-test-foliage_0x50A8A4FE.frag.glsl`)

- Specialized motion vector pass for foliage with alpha testing
- Handles vegetation animation (wind) for correct temporal reprojection

## TAA Resolve

`taa-resolve_0xB737E71B.frag.glsl` (in dump folder):
- Temporal anti-aliasing with:
  - Motion-compensated reprojection
  - Neighborhood clamping (color-space AABB)
  - Velocity-based blend factor
  - Subpixel jitter from Halton sequence

## Hi-Z Depth Pyramid

### Depth Pyramid Generator (`hiz-depth-pyramid_0x197960FD.comp.glsl`, `hiz-depth-pyramid-generator_0x5B4CEDF0.comp.slang`)

- Generates hierarchical depth buffer (min/max mip chain)
- Used for:
  - Occlusion culling
  - Screen-space reflections
  - AO depth sampling

## UI Compositing

### UI Global (`ui-global_0xD0328F82.frag.slang`)

Composites UI elements onto the HDR scene. The game's native HDR mode uses PQ encoding:

```
if (alpha == 0): pass through scene
if (alpha == 1): full UI element — decode sRGB, composite
if (0 < alpha < 1): alpha-blended UI overlay
```

### UI Character Portrait (`ui-character_0x3F7A0B54.frag.slang`)

Specialized UI shader for character portraits in inventory/dialogue.

## Output Encoding

Final output to swapchain:
- **HDR**: PQ (ST 2084) in BT.2020 (game's native HDR mode)
- **SDR**: sRGB in BT.709
