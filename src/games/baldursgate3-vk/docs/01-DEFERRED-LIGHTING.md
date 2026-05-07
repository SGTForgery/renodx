# Deferred Lighting System

> Shader: `main-deferred_0xAB2320F6.comp.glsl` (and variants)
> Stage: Compute (8×8×1 workgroups)

## Architecture

BG3 uses a **tiled deferred** lighting system. The main compute shader processes each screen tile, reads GBuffer data, and accumulates lighting from multiple light types.

### Tile System

- Tiles are dispatched as 8×8 pixel workgroups
- A tile classification pass (`light-tile-classification`) runs first to build per-tile light lists
- Light indices are stored in an SSBO (`_41`, set 1 binding 9) as packed uint32 values
- Each tile entry encodes `(tileX | (tileY << 16))` in the lower 32 bits

### GBuffer Read

The shader reads from these GBuffer textures (all set 1):
- **Binding 1** (`_35`): Normal (R16G16_FLOAT octahedral)
- **Binding 2** (`_36`): Albedo (RGBA8)
- **Binding 3** (`_37`): Roughness/Metalness/F0/MaterialID
- **Binding 5** (`_38`): Depth
- **Binding 6** (`_39`): Additional material data
- **Binding 7** (`_40`): Motion vectors or auxiliary

### Normal Decode (repeated in every deferred variant)

```glsl
vec3 oct = fma(vec3(texelFetch(_35, coord, 0).xy, 0.0),
               vec3(3.5554, 3.5554, 0.0),
               vec3(-1.7777, -1.7777, 1.0));
float len2 = dot(oct, oct);
if (len2 > 54000001024.0) {
    normal = vec3(0, 0, 1);  // fallback
} else {
    float inv = 2.0 / len2;
    normal = vec3(oct.xy * inv, 1.0 - inv);
}
// Transform to world space:
worldNormal = normal * mat3(viewMatrix);
```

## Lighting Model

BG3 uses **fully real-time lighting** — there are no baked lightmaps visible in the deferred pipeline. All illumination comes from:

### Direct Lighting (3 light loops in the deferred compute shader)

1. **Point lights** — omnidirectional, real-time, with per-light shadow atlas lookups (PCSS with 12-sample Vogel disk blocker search)
2. **Spot lights** — same PBR evaluation as point lights, with cone angle attenuation and angular falloff
3. **Area / box lights** — OBB-shaped volumetric lights with parallax-corrected projection into the light's local space. Support optional shadow maps and optional 2D light textures (cookies/gobos) via bindless texture arrays (`_25[]`). These are used for shaped interior lighting, windows, etc.

All three light types share the same BRDF evaluation (Cook-Torrance GGX specular + Disney/Burley diffuse) and the same shadow atlas system.

### Indirect / Ambient Lighting (after the light loops)

- **Global sky irradiance cubemap** pair: one for diffuse irradiance (`_14`) and one for prefiltered specular (`_15`), with an optional blend to a second cubemap pair (`_16`, `_17`) controlled by an area-specific or scripted blend factor (`_19._m29`) — used for variant lighting conditions within a region, not a continuous time-of-day cycle
- **Local reflection probes**: cubemap probes stored in **bindless texture arrays** (`_24[]`). Each probe has:
  - Box or sphere shape with parallax-corrected ray intersection
  - Distance-based blend weight with smooth falloff
  - LOD selection based on roughness for specular
  - Optional blend between two cubemap snapshots (for scripted lighting transitions or area variants)
  - Diffuse and specular contributions evaluated separately
- **Directional sun light**: evaluated as a single directional light with full PBR, using the CSM shadow result and atmospheric transmittance
- **Atmospheric scattering**: precomputed transmittance LUT applied to both direct sun and ambient contributions. Rayleigh + Mie inscatter added to the final result.
- **Cloud shadows**: two cloud shadow maps sampled with spherical projection, blended by a factor (`_m16`), attenuating both direct and ambient light

### Environment BRDF LUT

A 2D LUT texture (`_18`, set 1 binding 38) is sampled with `(NdotV, roughness)` to provide the split-sum approximation for IBL specular:
```glsl
vec4 envBRDF = textureLod(_18, vec2(NdotV, roughness), 0.0);
// envBRDF.x = scale for F0
// envBRDF.y = bias (added to F0 * scale)
// envBRDF.z = diffuse IBL factor
specularIBL = probeColor * (F0 * envBRDF.x + envBRDF.y);
diffuseIBL  = probeColor * albedo * envBRDF.z;
```

## BRDF Model

### Specular: Cook-Torrance GGX

```
D = GGX NDF (α⁴ / (π × (NdotH² × (α⁴ - 1) + 1)²))
G = Smith height-correlated
F = Schlick (F0 + (1-F0) × (1-VdotH)⁵)
```

Specular anti-aliasing is applied: roughness is widened based on screen-space normal derivatives:
```glsl
float aa_roughness = sqrt(clamp(roughness² + min(dot(dNdx,dNdx) + dot(dNdy,dNdy), 0.18), 0, 1));
```

### Diffuse: Disney/Burley

The game uses the **Disney/Burley diffuse BRDF** — a Fresnel-weighted Lambert model:
```glsl
// Fresnel-weighted diffuse (Burley 2012)
float fd90 = 0.5 + 2.0 * roughness * VdotH²;
float fd = (1 + (fd90 - 1) * (1 - NdotL)⁵) * (1 + (fd90 - 1) * (1 - NdotV)⁵);
diffuse = albedo * (1/π) * fd * mix(1.0, 0.6623, roughness);
```

## Shadow Integration

- Per-light shadow lookup uses a shadow atlas (texture array)
- PCSS (Percentage-Closer Soft Shadows) with Vogel disk sampling
- 12 samples for blocker search, variable samples for PCF
- Shadow penumbra width scales with blocker distance

## Output

Two UAV outputs (set 1, bindings 10–11):
- **`_42`** (RGBA32F): Diffuse + specular combined lighting
- **`_43`** (RGBA32F): Separate specular (for SSR/IBL compositing)

## Deferred Shader Variants

| Shader | Specialization |
|--------|---------------|
| `base-deferred-lighting_0xB92BEFEE` | Base variant |
| `main-deferred_0xAB2320F6` | Main (most common) |
| `deferred-lighting_0xEE06F4F5` | Standard deferred |
| `deferred-lighting-specular-aa-volumetric-nocsm_0x7FE5A589` | With specular AA, volumetric, no CSM |
| `deferred-lighting-specularaa-csm-volumetric_0x92395FFB` | Full featured |
| `hair-deferred-lighting_0x4D74577D` | Hair material specialization |
| `multi-material-deferred-nocsm_0xD5B01922` | Multi-material, no CSM |
| `terrain-secondary-normal-deferred-nocsm_0xD360C8D7` | Terrain with secondary normals |
| `transmissive-material-deferred-lighting_0x3F6F9DBA` | Transmissive materials |
| `two-layer-material-deferred-csm-specularaa-volumetric_0xBDAB4D15` | Two-layer materials |
| `deferred-ibl_0x3B67DBD8` | IBL-only pass |
| `anisotropic-material-vsm-probes_0x6B5EDB4F` | Anisotropic + VSM |
