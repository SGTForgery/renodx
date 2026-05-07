# Materials & GBuffer System

> Shaders: `*-gbuffer_*.frag.glsl`, character shaders, terrain, water

## GBuffer Write Passes

### Standard Surface GBuffer

Most opaque geometry writes to the GBuffer in a single pass. The GBuffer layout:

| RT | Format | Content | Encoding |
|----|--------|---------|----------|
| 0 | R8G8B8A8 | Albedo.rgb, material flags | Linear, flags in alpha |
| 1 | R16G16_FLOAT | Normal.xy | Octahedral, view-space |
| 2 | R8G8B8A8 | Roughness, F0/specular, metalness, material ID | See below |
| 3 | R8G8B8A8 | Subsurface/transmittance, AO, emissive, flags | Material-dependent |

### GBuffer Channel Details

**RT2 (Material Properties)**:
- R: Roughness (perceptual, squared for GGX α)
- G: Specular reflectance at normal incidence. For dielectrics: `0.16 × F0²`. For metals: albedo channel.
- B: Metalness (0 or 1, with rare intermediate values for blending)
- A: Packed byte — lower 3 bits = material type, bits 4–6 = light layer mask, bit 7 = special flags

**Material Type Extraction**:
```glsl
uint packedByte = uint(roundEven(gbuffer2.w * 255.0));
uint materialType = packedByte & 7u;        // bits 0-2
uint lightLayer = (packedByte & 0x70) >> 4; // bits 4-6
bool heroLit = (packedByte & 0x80) != 0;    // bit 7
```

### Dielectric vs Metal Separation

In the deferred shader:
```glsl
vec3 diffuseAlbedo = albedo.rgb * (1.0 - metalness);
vec3 F0 = mix(vec3(0.16 * specular * specular), albedo.rgb, metalness);
```

## Character Materials

### Hair (`hair-gbuffer_0x174B0A7A.frag.glsl`)

- Uses anisotropic specular (Kajiya-Kay or Marschner model)
- Separate depth pre-pass (`hair-depth-pre-pass_0x54BBD70F.frag.glsl`) for alpha testing
- Shadow caster variant (`hair-shadowcaster_0x65692EB2.frag.glsl`)
- Hair scalp blending (`hair-scalp_0x151CFF03.frag.glsl`)

### Eyes (`eye-gbuffer_0x3886692F.frag.glsl`)

- Specialized eye rendering with:
  - Cornea refraction
  - Iris parallax
  - Specular IBL reflection variants (`eye-specular-IBL-reflection_0x5F5BC3D9.frag.glsl`, `_0xAB5FCFE1`)
  - Dedicated shadow pass (`eye-shadows_0xE273B9FE.frag.glsl`)

### NPC Fresnel (`npc-fresnal_0xF22F6DD9.frag.slang`)

- Character-specific Fresnel effect (rim lighting)
- Likely used for "hero lighting" — artificial rim/fill light on player characters

### Appearance VFX (`appearance-vfx_0xD37E9557.frag.glsl`)

- Visual effects applied to character appearance (magical effects, status conditions)

## Terrain (`terrain-gbuffer_0x9C3376CD.frag.glsl`)

- Multi-layer terrain blending
- Secondary normal maps for detail
- Dedicated deferred variant: `terrain-secondary-normal-deferred-nocsm_0xD360C8D7.comp.glsl`

## Water System

### Water Shaders

| Shader | Description |
|--------|-------------|
| `act1-water_0x0AA19DDD.frag.glsl` | Act 1 water (rivers, lakes) |
| `act2-water_0x90428D80.frag.glsl` | Act 2 water (Shadowlands) |
| `waterfall_0x9C89CC2A.frag.glsl` | Waterfall effect |
| `waterfall-gbuffer_0xDC038FE3.frag.glsl` | Waterfall GBuffer write |

### Water Rendering (Forward+)

Water is rendered as a **forward+ pass** (not deferred). Key features:

1. **Multi-layer normal mapping**: 3 normal map layers with independent:
   - UV scales (`_m6`, `_m7`, `_m8`)
   - Flow speeds and offsets
   - Temporal blending (fract-based crossfade between two time samples)

2. **Flow map**: Texture `_52` provides 2D flow direction, modulated by:
   - Detail map (`_54`) for flow variation
   - Scale factor (`_m22`)

3. **Foam**: 
   - Depth-based foam at shorelines
   - Flow-speed-based foam on rapids
   - Caustic-like pattern from `_57` texture

4. **Refraction**: Depth-based underwater distortion using scene depth comparison

5. **Fresnel**: `pow(1 - NdotV, 3)` for water surface reflectivity

6. **Lighting**: Full PBR with:
   - Clustered light evaluation (same light list as deferred)
   - Cubemap reflections
   - Atmospheric scattering integration
   - Subsurface-like depth coloring

### Water UBO (set 1, binding 1)

Contains ~62 float parameters controlling all water appearance:
- `_m0`–`_m4`: Water colors (shallow, deep, foam)
- `_m5`–`_m9`: UV scales for normal/flow/foam layers
- `_m10`–`_m30`: Animation speeds, flow parameters
- `_m31`–`_m49`: Foam thresholds, depth parameters
- `_m50`–`_m61`: Roughness, refraction, caustic parameters

## Parallax Occlusion Mapping

`rock-pom_0xDF894609.frag.glsl` — Used for rock/stone surfaces:
- Standard POM with ray marching through height map
- Self-shadowing support

## Subsurface Scattering

7 blur passes (horizontal + vertical + resolve):
- Separable Gaussian blur in screen space
- Multiple blur radii for different SSS profiles
- Depth-aware weighting to prevent bleeding across depth discontinuities

## Portal/Zone System

| Shader | Purpose |
|--------|---------|
| `portal-depth-clip-mask_0xB356EA6A.frag.glsl` | Depth clipping for portal boundaries |
| `portal-zone-marker_0x47273273.frag.slang` | Zone transition markers |

## VFX

| Shader | Purpose |
|--------|---------|
| `act2-energy-dome_0x1AC33036.frag.slang` | Act 2 shadow curse dome effect |
| `vfx_0xC81852ED.frag.slang` | General VFX particles/effects |
| `fog-vfx_0x266D3BE3.frag.glsl` | Fog-integrated VFX |

## Dye System

`dye-system_0x522B8BB9.frag.slang` — Character equipment color customization:
- Allows per-channel color remapping of armor/clothing
- Likely uses a mask texture to define dyeable regions
