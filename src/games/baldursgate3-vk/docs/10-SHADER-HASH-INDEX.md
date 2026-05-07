# Shader Hash Index

> Complete index of all decompiled shaders by CRC32 hash, organized by rendering subsystem.
> Use this to cross-reference shader hashes found in Ghidra with their function.

## Ambient Occlusion

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x47DE1613` | `depth-deinterleave_0x47DE1613.frag.glsl` | Fragment | HBAO depth deinterleave |
| `0xF70799BE` | `hbao_0xF70799BE.frag.glsl` | Fragment | HBAO main pass |
| `0x93ED1679` | `hbao-bilateral-blur_0x93ED1679.frag.glsl` | Fragment | HBAO bilateral blur |
| `0xBD3EE691` | `hbao-composite_0xBD3EE691.frag.glsl` | Fragment | HBAO composite |

## Auto Exposure

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0xEE04F959` | `auto-exposure_0xEE04F959.comp.glsl` | Compute | Auto exposure computation |
| `0xD162BB3F` | `luminance-tile-downsample_0xD162BB3F.comp.glsl` | Compute | Luminance tile downsample |

## Bloom

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0xFDAC0941` | `bloom_0xFDAC0941.frag.slang` | Fragment | Bloom composite |
| `0x18926820` | `pre-bloom-dithering_0x18926820.frag.glsl` | Fragment | Pre-bloom dithering |

## Characters

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0xD37E9557` | `appearance-vfx_0xD37E9557.frag.glsl` | Fragment | Character appearance VFX |
| `0x3886692F` | `eye-gbuffer_0x3886692F.frag.glsl` | Fragment | Eye GBuffer write |
| `0xE273B9FE` | `eye-shadows_0xE273B9FE.frag.glsl` | Fragment | Eye shadow pass |
| `0x5F5BC3D9` | `eye-specular-IBL-reflection_0x5F5BC3D9.frag.glsl` | Fragment | Eye specular IBL (variant A) |
| `0xAB5FCFE1` | `eye-specular-IBL-reflection_0xAB5FCFE1.frag.glsl` | Fragment | Eye specular IBL (variant B) |
| `0x54BBD70F` | `hair-depth-pre-pass_0x54BBD70F.frag.glsl` | Fragment | Hair depth pre-pass |
| `0x174B0A7A` | `hair-gbuffer_0x174B0A7A.frag.glsl` | Fragment | Hair GBuffer write |
| `0x151CFF03` | `hair-scalp_0x151CFF03.frag.glsl` | Fragment | Hair scalp blending |
| `0x65692EB2` | `hair-shadowcaster_0x65692EB2.frag.glsl` | Fragment | Hair shadow caster |
| `0xF22F6DD9` | `npc-fresnal_0xF22F6DD9.frag.slang` | Fragment | NPC Fresnel/rim light |

## Deferred Lighting

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x6B5EDB4F` | `anisotropic-material-vsm-probes_0x6B5EDB4F.comp.glsl` | Compute | Anisotropic + VSM probes |
| `0xB92BEFEE` | `base-deferred-lighting_0xB92BEFEE.comp.glsl` | Compute | Base deferred lighting |
| `0x3B67DBD8` | `deferred-ibl_0x3B67DBD8.comp.glsl` | Compute | Deferred IBL pass |
| `0xEE06F4F5` | `deferred-lighting_0xEE06F4F5.comp.glsl` | Compute | Standard deferred lighting |
| `0x7FE5A589` | `deferred-lighting-specular-aa-volumetric-nocsm_0x7FE5A589.comp.glsl` | Compute | Specular AA + volumetric, no CSM |
| `0x92395FFB` | `deferred-lighting-specularaa-csm-volumetric_0x92395FFB.comp.glsl` | Compute | Full featured deferred |
| `0x4D74577D` | `hair-deferred-lighting_0x4D74577D.comp.glsl` | Compute | Hair deferred lighting |
| `0xB0AF807E` | `hair-per-tile-reflection-probes_0xB0AF807E.comp.glsl` | Compute | Hair reflection probes |
| `0xAB2320F6` | `main-deferred_0xAB2320F6.comp.glsl` | Compute | **Main deferred lighting** |
| `0xD5B01922` | `multi-material-deferred-nocsm_0xD5B01922.comp.glsl` | Compute | Multi-material, no CSM |
| `0xD360C8D7` | `terrain-secondary-normal-deferred-nocsm_0xD360C8D7.comp.glsl` | Compute | Terrain secondary normals |
| `0x3F6F9DBA` | `transmissive-material-deferred-lighting_0x3F6F9DBA.comp.glsl` | Compute | Transmissive materials |
| `0xBDAB4D15` | `two-layer-material-deferred-csm-specularaa-volumetric_0xBDAB4D15.comp.glsl` | Compute | Two-layer materials |
| `0xA4582498` | `vsm-two-layer-materials_0xA4582498.comp.glsl` | Compute | VSM two-layer materials |

## Fog / Volumetrics

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x266D3BE3` | `fog-vfx_0x266D3BE3.frag.glsl` | Fragment | Fog VFX |
| `0xB8A3C87D` | `volumetric-fog_0xB8A3C87D.frag.slang` | Fragment | **Volumetric fog composite** |
| `0xAAC285CF` | `volumetric-fog-atmospheric_0xAAC285CF.comp.glsl` | Compute | Atmospheric fog |
| `0xB02E82D6` | `volumetric-fog-directional-ambient-pass_0xB02E82D6.comp.slang` | Compute | Directional + ambient fog |
| `0x9F73FD51` | `volumetric-fog-raymarch-_0x9F73FD51.comp.glsl` | Compute | Fog raymarch |
| `0x0A763473` | `volumetric-fog-voxel-scattering_0x0A763473.comp.slang` | Compute | Voxel scattering |

## GBuffer

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x9C3376CD` | `terrain-gbuffer_0x9C3376CD.frag.glsl` | Fragment | Terrain GBuffer |

## Color Grading / Tone Mapping

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x81C27E5C` | `color-grade_0x81C27E5C.frag.slang` | Fragment | **Color grading + LUT sample** |
| `0xA4AAB195` | `tonemap-lutbuilder-alternate_0xA4AAB195.comp.slang` | Compute | LUT builder (alternate) |
| `0x2056ED63` | `tonemap-lutbuilder-main_0x2056ED63.comp.slang` | Compute | **LUT builder (main)** |
| `0xA00988AD` | `tonemap-sample-lut_0xA00988AD.frag.slang` | Fragment | LUT sampling |

## Hi-Z

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x197960FD` | `hiz-depth-pyramid_0x197960FD.comp.glsl` | Compute | Hi-Z depth pyramid |
| `0x5B4CEDF0` | `hiz-depth-pyramid-generator_0x5B4CEDF0.comp.slang` | Compute | Hi-Z generator |

## Lighting

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0xF51C9B95` | `clustered-light-culling_0xF51C9B95.comp.slang` | Compute | **Clustered light culling** |
| `0x522B8BB9` | `dye-system_0x522B8BB9.frag.slang` | Fragment | Dye/color customization |
| `0xCCA3BE68` | `light-tile-classification_0xCCA3BE68.comp.slang` | Compute | Light tile classification |
| `0x7C1A8163` | `lighting-boundary-smoother_0x7C1A8163.comp.slang` | Compute | Lighting boundary smoothing |

## Motion Vectors

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x50A8A4FE` | `mv-alpha-test-foliage_0x50A8A4FE.frag.glsl` | Fragment | Foliage motion vectors |
| `0x7371D4F6` | `mv-depth-reconstruction_0x7371D4F6.frag.glsl` | Fragment | Depth-based motion vectors |

## Parallax Occlusion Mapping

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0xDF894609` | `rock-pom_0xDF894609.frag.glsl` | Fragment | Rock POM |

## Portal/Zone

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0xB356EA6A` | `portal-depth-clip-mask_0xB356EA6A.frag.glsl` | Fragment | Portal depth clip |
| `0x47273273` | `portal-zone-marker_0x47273273.frag.slang` | Fragment | Zone marker |

## Shadows

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x8AD4A32B` | `csm_0x8AD4A32B.frag.glsl` | Fragment | **CSM shadow resolve** |
| `0xE4E786B2` | `shadow-depth-linearization-atlas-packing_0xE4E786B2.frag.glsl` | Fragment | Shadow depth linearization |
| `0x74C7F7CD` | `shadow-penumbra_0x74C7F7CD.frag.glsl` | Fragment | Shadow penumbra |
| `0xA64685BD` | `shadowmap-tile-classification_0xA64685BD.comp.glsl` | Compute | Shadow tile classification |

## Sky

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0xD6695B52` | `sky_0xD6695B52.frag.glsl` | Fragment | **Sky rendering** |

## Subsurface Scattering

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x2EF65CEF` | `subsurface-scattering-horizon-blur_0x2EF65CEF.frag.glsl` | Fragment | SSS horizon blur |
| `0x013A0AF4` | `subsurface-scattering-horizontal-blur_0x013A0AF4.frag.glsl` | Fragment | SSS horizontal blur (A) |
| `0x9CABAE2F` | `subsurface-scattering-horizontal-blur_0x9CABAE2F.frag.glsl` | Fragment | SSS horizontal blur (B) |
| `0xC5EA79EA` | `subsurface-scattering-resolve-blur_0xC5EA79EA.frag.glsl` | Fragment | SSS resolve |
| `0x20CA3ADA` | `subsurface-scattering-vertical-blur_0x20CA3ADA.frag.glsl` | Fragment | SSS vertical blur (A) |
| `0x782733C1` | `subsurface-scattering-vertical-blur_0x782733C1.frag.glsl` | Fragment | SSS vertical blur (B) |
| `0xC51676F3` | `subsurface-scattering-vertical-blur_0xC51676F3.frag.glsl` | Fragment | SSS vertical blur (C) |

## UI

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x3F7A0B54` | `ui-character_0x3F7A0B54.frag.slang` | Fragment | UI character portrait |
| `0xD0328F82` | `ui-global_0xD0328F82.frag.slang` | Fragment | **UI global composite** |

## VFX

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x1AC33036` | `act2-energy-dome_0x1AC33036.frag.slang` | Fragment | Act 2 energy dome |
| `0xC81852ED` | `vfx_0xC81852ED.frag.slang` | Fragment | General VFX |

## Water

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x0AA19DDD` | `act1-water_0x0AA19DDD.frag.glsl` | Fragment | Act 1 water |
| `0x90428D80` | `act2-water_0x90428D80.frag.glsl` | Fragment | Act 2 water |
| `0x9C89CC2A` | `waterfall_0x9C89CC2A.frag.glsl` | Fragment | Waterfall effect |
| `0xDC038FE3` | `waterfall-gbuffer_0xDC038FE3.frag.glsl` | Fragment | Waterfall GBuffer |

## Dump / Misc

| Hash | File | Stage | Description |
|------|------|-------|-------------|
| `0x84A5F349` | `main-surface-forward+_0x84A5F349.frag.glsl` | Fragment | Forward+ main surface |
| `0xB737E71B` | `taa-resolve_0xB737E71B.frag.glsl` | Fragment | TAA resolve |
