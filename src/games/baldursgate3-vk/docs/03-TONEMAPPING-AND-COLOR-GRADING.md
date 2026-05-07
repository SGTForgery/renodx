# Tone Mapping & Color Grading

> Shaders: `tonemap-lutbuilder-main_0x2056ED63.comp.slang`, `color-grade_0x81C27E5C.frag.slang`, `tonemap-sample-lut_0xA00988AD.frag.slang`

## Architecture

BG3 uses a **3D LUT-based** tone mapping pipeline:

1. **LUT Builder** (compute): Generates a 64³ 3D LUT each frame
2. **Color Grade** (fragment): Applies HSV-based scene grading, then samples the LUT
3. **LUT Sample** (fragment): Final LUT application pass

## LUT Builder (`tonemap-lutbuilder-main`)

### Input Space

The LUT is indexed in **ACEScg (AP1)** space. Input coordinates are decoded from the 64³ grid:
```
float3 ap1 = exp2(gridCoord * 17.52 - 9.72);  // log2 encoding
// With negative handling for values below -0.3014
```

### Tone Curve

The game implements a **custom ACES 2 beta** tone curve developed by Larian Studios. It is not the standard ACES RRT — Larian built their own variant on top of the ACES 2 beta specification:

1. **Color space transform**: AP1 → custom working space via 3×3 matrix
2. **Hue-dependent saturation**: Computes HSV hue, applies per-hue saturation modulation with smooth transitions
3. **Parametric spline**: 
   - Below `minPoint`: linear segment with slope `_m0[0].z`
   - `minPoint` to `midPoint`: B-spline with 6 control points (`_m0[2].y` through `_m0[3].z`)
   - `midPoint` to `maxPoint`: B-spline with 6 control points (`_m0[3].w` through `_m0[5].x`)
   - Above `maxPoint`: linear segment with slope `_m0[2].x`
4. **Perceptual encoding**: Uses **ICTCP** (BT.2100) perceptual space for the tone curve:
   - Scene linear → XYZ → Hunt-Pointer-Estévez LMS → PQ OETF → ICTCP
   - Tone curve applied to I (intensity) channel
   - Chroma (CT, CP) preserved with desaturation rolloff at highlights

### Desaturation Model

Highlight desaturation uses a sophisticated model:
- Computes "chroma preservation factor" based on luminance vs. peak white
- Hue-dependent: warm hues (reds/yellows) desaturate differently than cool hues
- Uses a soft-knee compression curve for the transition

### Output

LUT values are encoded as **PQ (ST 2084)** in BT.2020 gamut at 100 nits reference:
```
output = PQ_Encode(BT2020_color, 100.0 nits)
```

### Two LUT Modes

The game has two LUT builder variants controlled by `_419` (UBO field):
- **Mode 0** (`_420 == 0`): SDR/HDR with full ACES-like pipeline
- **Mode 1** (`_420 == 1`): Simplified HDR pass-through

## Color Grading (`color-grade`)

Applied as a fragment shader after the main scene render:

1. **HSV manipulation**:
   - Hue shift (`_5_m1`)
   - Saturation scale (`_5_m0`)
   - Value/brightness adjustment (`_5_m2`, signed — negative = multiply, positive = lerp to white)
   - Blend strength (`_5_m3`)

2. **LUT sampling**: 
   - Input is PQ-encoded at 45 nits reference
   - Sampled from 3D texture with trilinear filtering

## Constant Buffer Layout (LUT Builder UBO, set 1 binding 0)

| Field | Type | Meaning |
|-------|------|---------|
| `_m0[0].x` | float | Min point (log10) |
| `_m0[0].y` | float | Min point value |
| `_m0[0].z` | float | Low slope |
| `_m0[0].w` | float | Mid point (log10) |
| `_m0[1].z` | float | Max point (log10) |
| `_m0[1].w` | float | Max point value |
| `_m0[2].x` | float | High slope |
| `_m0[2].y`–`_m0[3].z` | float×6 | Low spline control points |
| `_m0[3].w`–`_m0[5].x` | float×6 | High spline control points |
| `_m0[5].z` | float | Reference white (scene linear) |
| `_m0[5].w` | float | Peak luminance (scene linear) |
| `_m0[6].z` | uint | Mode (0=SDR/HDR, 1=HDR simplified) |
| `_m1` | float4 | Hue-dependent blend targets (high spline) |
| `_m2` | float4 | Hue-dependent blend targets (curve params) |
