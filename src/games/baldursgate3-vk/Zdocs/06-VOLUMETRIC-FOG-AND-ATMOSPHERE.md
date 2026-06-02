# Volumetric Fog & Atmospheric Scattering

> Shaders: `volumetric-fog-*.comp/frag.slang/glsl`, `sky_0xD6695B52.frag.glsl`

## Volumetric Fog Pipeline

### Stage 1: Voxel Scattering (`volumetric-fog-voxel-scattering_0x0A763473.comp.slang`)

- Compute shader that fills a **3D voxel grid** with inscatter and extinction data
- Each voxel represents a frustum-aligned volume slice
- Inputs: light data, shadow maps, density functions
- Output: 3D texture with RGBA16F (RGB = inscatter color, A = extinction/opacity)

### Stage 2: Directional + Ambient Pass (`volumetric-fog-directional-ambient-pass_0xB02E82D6.comp.slang`)

- Adds directional light (sun) contribution with shadow lookup
- Adds ambient/sky light contribution
- Accumulates into the voxel grid

### Stage 3: Atmospheric Fog (`volumetric-fog-atmospheric_0xAAC285CF.comp.glsl`)

- Adds atmospheric scattering contribution (Rayleigh/Mie)
- Height-based fog density

### Stage 4: Raymarch (`volumetric-fog-raymarch_0x9F73FD51.comp.glsl`)

- Front-to-back raymarch through the voxel grid
- Accumulates inscatter and transmittance along view rays
- Outputs final fog volume

### Stage 5: Composite (`volumetric-fog_0xB8A3C87D.frag.slang`)

- Fragment shader that composites fog onto the scene
- Reads the 3D fog texture with **tricubic filtering** (8 trilinear taps with B-spline weights)
- Applies fog as: `finalColor = sceneColor × transmittance + inscatter`

## Fog 3D Texture Layout

- **Format**: RGBA16F (packed: RGB×32 for inscatter, A×(1/32768) for opacity)
- **Addressing**: Frustum-aligned (XY = screen UV, Z = depth slice)
- **Depth mapping**: Hybrid linear/logarithmic:
  ```glsl
  if (depth <= threshold)
      slice = linear_scale * depth + linear_offset;
  else
      slice = log_scale * log2(log_coeff * depth + log_offset);
  ```

## Tricubic Filtering

The composite shader implements manual tricubic filtering with B-spline weights:

```glsl
// B-spline weight computation
vec3 w1 = -(t * 0.5 * t) * (2.0 - t) + 0.6667;  // center weight
vec3 w0 = (1-t)³/6 + w1;                           // combined near weight
vec3 w2 = t/6 * t² + (1 - w0 - w1);               // combined far weight

// 8 trilinear taps at optimized positions
// Positions shifted by weight ratios for hardware bilinear leverage
```

## Atmospheric Scattering (Sky Shader)

### Sky Model

The sky shader (`sky_0xD6695B52.frag.glsl`) implements a **precomputed atmospheric scattering** model:

1. **Transmittance LUT** (`_13`, set 5 binding 1): 2D texture indexed by (view zenith, altitude)
2. **Scattering LUT** (`_14`, set 5 binding 2): 3D texture indexed by (sun angle, view angle, altitude)
3. **Rayleigh + Mie** scattering with configurable asymmetry parameter (`_m9`)

### Atmosphere Parameters (UBO at set 5, binding 0)

| Field | Meaning |
|-------|---------|
| `_m0` | Planet radius |
| `_m1` | Atmosphere radius |
| `_m4` | Rayleigh scale height |
| `_m5` | Rayleigh scattering coefficients (vec3) |
| `_m6` | Mie scale height |
| `_m7` | Mie scattering coefficients (vec3) |
| `_m8` | Ozone absorption (vec3) |
| `_m9` | Mie asymmetry (g parameter for Henyey-Greenstein) |

### Sky Rendering

```glsl
// Rayleigh phase: (3/16π) × (1 + cos²θ)
float rayleighPhase = 0.05968 * (1 + cosTheta²);

// Mie phase: Henyey-Greenstein
float miePhase = (1 - g²) / (4π × (1 + g² - 2g×cosθ)^1.5) × (1 + cos²θ) / (2 + g²);

// Final sky = transmittance × (rayleigh_scatter + mie_scatter) × sun_intensity
```

### Sun Disk

Rendered when `dot(viewDir, sunDir) > 0.999956` (≈0.5° angular radius):
```glsl
skyColor += transmittance × sunColor × sunIntensity × 10.0;
```
