# Baldur's Gate 3 (Vulkan) — Rendering Pipeline Overview

> Reference documentation derived from decompiled shaders for BG3 Vulkan.
> Use this as a map when reverse engineering the game's renderer in Ghidra.

## Engine Summary

BG3 uses a **deferred rendering pipeline** on Vulkan with traditional render passes (`vkCmdBeginRenderPass`), not dynamic rendering (`vkCmdBeginRendering`). The engine is Larian's proprietary **Divinity Engine 4**.

- **Graphics API**: Vulkan 1.x
- **Shader format**: SPIR-V (decompiled via SPIRV-Cross to GLSL/Slang)
- **Descriptor model**: Descriptor sets (set 0–5 observed), push constants, SSBOs
- **Subgroup operations**: Used extensively (`GL_KHR_shader_subgroup_quad`, `GL_KHR_shader_subgroup_basic`)
- **Compute workgroups**: Typically 8×8×1 for screen-space passes

## World Structure

BG3 is **not an open world** — the game is split into multiple self-contained regions (acts/areas). There is **no dynamic time-of-day cycle or seasons**. Each area uses static, pre-authored lighting and weather conditions. Lighting changes only occur via scripted triggers (e.g., story events, area transitions, the Act 2 shadow curse). This means:

- Sun direction, sky color, and atmosphere parameters are fixed per area, not animated
- Cubemap probe pairs and cloud shadow maps represent area-specific conditions, not day/night blending
- The blend factors observed in shaders (e.g., between two sky cubemaps) are for area-specific variants or scripted transitions, not a continuous ToD system

## Scope of These Findings

All shader analysis, resource sizes, and pipeline observations documented here are from running the game at the **highest available Ultra graphics preset** in the game menu. The goal of this reverse engineering effort is to understand the renderer in order to further improve graphics quality.

**Important caveats:**
- Lower graphics presets (Low, Medium, High) have **not** been tested and will likely use different shader permutations, lower shadow map resolutions, fewer lighting passes, simplified AO, etc.
- Shader hashes documented here are specific to the Ultra preset's SPIR-V bytecode. Different quality presets may compile to different shader variants with different hashes.
- Resource sizes (e.g., 8192×8192 shadow atlas, 1024² cascade resolution) are Ultra-specific and will almost certainly differ at lower presets.

## High-Level Frame Stages

```
1. GBuffer Pass (geometry → GBuffer RTs)
2. Hi-Z Depth Pyramid Generation
3. Shadow Map Rendering (CSM + VSM)
4. Ambient Occlusion (HBAO)
5. Clustered Light Culling (compute)
6. Deferred Lighting (compute, tiled)
7. Forward+ Passes (water, VFX, particles, portals)
8. Subsurface Scattering (separable blur)
9. Volumetric Fog (voxel scattering + raymarch + composite)
10. Sky Rendering (atmospheric scattering)
11. Bloom (downsample + blur + composite)
12. Auto Exposure (luminance histogram)
13. Tone Mapping / LUT Build (Larian's custom ACES 2 beta)
14. Color Grading (3D LUT sample)
15. TAA Resolve
16. UI Compositing (sRGB/PQ encode)
17. Final Output (swapchain present)
```

## Descriptor Set Layout (Observed Convention)

| Set | Purpose |
|-----|---------|
| 0 | Per-frame globals: camera matrices, scene params, time, sun direction |
| 1 | Per-pass resources: GBuffer textures, light buffers, output UAVs |
| 2 | Shadow maps, light SSBOs, material data |
| 3 | (Not observed in use by the game) |
| 5 | Atmospheric/volumetric: sky LUT, fog 3D texture, transmittance |

## Push Constants

The game uses Vulkan push constants for per-draw data. The exact layout varies per shader/pipeline, but typically contains per-draw parameters like tile dispatch info, cascade indices, or material instance data.

## Key Shader Hashes

Shaders are identified by CRC32 hash of their SPIR-V bytecode:

| Hash | Shader | Stage |
|------|--------|-------|
| `0xAB2320F6` | Main deferred lighting | Compute |
| `0x8AD4A32B` | CSM shadow resolve | Fragment |
| `0x81C27E5C` | Color grading (LUT sample) | Fragment |
| `0x2056ED63` | Tonemap LUT builder (main) | Compute |
| `0xA4AAB195` | Tonemap LUT builder (alternate) | Compute |
| `0xA00988AD` | Tonemap sample LUT | Fragment |
| `0xFDAC0941` | Bloom composite | Fragment |
| `0xB8A3C87D` | Volumetric fog composite | Fragment |
| `0xD6695B52` | Sky rendering | Fragment |
| `0xF51C9B95` | Clustered light culling | Compute |
| `0xD0328F82` | UI global composite | Fragment |
| `0x3F7A0B54` | UI character portrait | Fragment |
| `0xEE04F959` | Auto exposure | Compute |
| `0x9C3376CD` | Terrain GBuffer | Fragment |

## GBuffer Layout

The GBuffer uses multiple render targets at full resolution:

| RT Index | Format | Content |
|----------|--------|---------|
| RT0 | R8G8B8A8 | Albedo RGB + material flags in alpha |
| RT1 (normal) | **R16G16_FLOAT** | Octahedral-encoded view-space normal |
| RT2 | R8G8B8A8 | Roughness (R), specular/F0 (G), metalness (B), material ID (A packed) |
| RT3 | R8G8B8A8 | Additional material data |
| Depth | D32_FLOAT or D24S8 | Reversed-Z depth buffer |

### Normal Encoding

Normals are stored as **octahedral encoding** in R16G16_FLOAT:
```glsl
// Decode:
vec3 oct = fma(vec3(gbNormalXY, 0.0),
               vec3(3.5554, 3.5554, 0.0),
               vec3(-1.7777, -1.7777, 1.0));
float octLen2 = dot(oct, oct);
float octInv = 2.0 / octLen2;
vec3 viewNormal = vec3(oct.xy * octInv, 1.0 - octInv);
```

Normals are in **view space**. Transform to world space via the inverse view matrix (uniform `_m6` in set 0, binding 1).

## Material ID System

Material IDs are packed into GBuffer alpha channels. The lower 3 bits encode material type:

| ID | Material Type |
|----|---------------|
| 0 | Standard PBR |
| 1 | Subsurface scattering |
| 2 | Anisotropic |
| 3 | Two-layer / transmissive |
| 4 | Hair |
| 5 | Eye |
| 6 | Terrain |

Bit 4–6 (mask `0x70`, shifted `>> 4`) encode the **light layer mask** used for per-light visibility culling.

## Resource Formats of Interest

| Resource | Format | Notes |
|----------|--------|-------|
| HDR scene buffer | R16G16B16A16_FLOAT | Main lighting accumulation |
| UI render targets | R8G8B8A8 or R10G10B10A2 | Standard LDR UI surfaces |
| Shadow atlas | 8192×8192 shared depth texture | CSM cascades (1024² close + 2048² far) + cached point/spot shadows, packed via blit |
| Volumetric fog | 3D texture (R16G16B16A16) | Voxel grid, inscatter + transmittance |
| Bloom chain | Half-res, quarter-res etc. | Standard downsample pyramid |
| 3D LUT | 64³ volume texture | PQ-encoded, built per-frame |
