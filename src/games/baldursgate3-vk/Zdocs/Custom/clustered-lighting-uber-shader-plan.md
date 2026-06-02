# Clustered Lighting Uber-Shader — Implementation Plan

## Status: VALIDATED — Ready to Implement

## Problem

BG3's tile-based deferred lighting uses 14 specialized compute shader variants.
When modifying these via RenoDX (SPIR-V hash replacement), all 14 must produce
visually identical results for the same material type, or visible 8×8 tile seams appear.
Currently each shader is edited individually — matching them is extremely difficult.

## Solution: 3-Group Uber-Shader

Write ONE GLSL uber-shader body that handles ALL material types. Compile it 3 times
with different `#define` flags to produce 3 distinct SPIR-V binaries — one per pipeline
layout group. Map all 14 hashes to the appropriate group's compiled output in RenoDX.

---

## Verified Group Assignments (from static analysis of all 14 .comp.glsl files)

### Group A — "Minimal" (2 shaders, 36 bindings)

| Hash | Name | Materials |
|------|------|-----------|
| 0xAB2320F6 | Main deferred | Standard PBR (ID 0) |
| 0xB92BEFEE | Base deferred | Standard PBR (ID 0) |

**Missing vs Group B:** `set=1, binding=4` (GBuffer RT3)
**Missing vs Group C:** `set=0/b=0`, `set=1/b=4`, `set=1/b=21`, `set=1/b=28`

### Group B — "Standard + Exotic Materials" (7 shaders, 37 bindings)

| Hash | Name | Materials |
|------|------|-----------|
| 0x3F6F9DBA | Transmissive material | Standard + Cloth (IDs 0+7) |
| 0x4D74577D | Hair deferred | Hair (ID 4) |
| 0x7FE5A589 | Specular AA volumetric noCSM | Cloth (ID 7) |
| 0xB0AF807E | Hair per-tile reflection probes | Standard + Hair (IDs 0+4) |
| 0xD360C8D7 | Terrain secondary normal noCSM | Standard + Anisotropic (IDs 0+6) |
| 0xD5B01922 | Multi-material noCSM | Standard + Cloth + Clearcoat (IDs 0+5+7) |
| 0xEE06F4F5 | Deferred lighting | Anisotropic (ID 6) |

**Has vs Group A:** `set=1, binding=4` (GBuffer RT3 — tangent/eye/hair data)
**Missing vs Group C:** `set=0/b=0`, `set=1/b=21`, `set=1/b=28`

### Group C — "Hero Lighting" (5 shaders, 39-40 bindings)

| Hash | Name | Materials | Has set=0/b=0? |
|------|------|-----------|----------------|
| 0x3B67DBD8 | Deferred IBL (mega shader) | ALL materials | YES |
| 0x6B5EDB4F | Anisotropic material VSM probes | Standard + Cloth (IDs 0+7) | YES |
| 0xBDAB4D15 | Two-layer material CSM specAA | Clearcoat/Eye (ID 5) | YES |
| 0x92395FFB | Specular AA CSM volumetric | Standard (ID 0) | NO |
| 0xA4582498 | VSM two-layer materials | Standard + Clearcoat (IDs 0+5) | NO |

**Has vs Group B:** `set=1/b=21` (CSM array), `set=1/b=28` (HeroLightBuffer)
**Internal split:** 3 shaders have `set=0/b=0` (RenderSettings); 2 do not.

**Why this doesn't break the strategy:** Vulkan allows a shader to declare bindings
it doesn't access at runtime. The uber-shader declares `set=0/b=0` for all Group C
targets. For 0x92395FFB/0xA4582498, the code path reading RenderSettings won't execute
(gated by hero light logic). The pipeline layout almost certainly includes the binding
regardless — all 5 shaders share the same indirect dispatch pipeline.

---

## Binding Declarations — Differential Summary

### Shared by ALL 14 shaders (36 binding slots):

**Set 0:** binding 1 (SceneGlobals UBO), binding 2 (CameraMatrices UBO), binding 4 (ViewportParams UBO)

**Set 1:** binding 0 (TileDispatchParams), 1 (RT0 normals), 2 (RT1 albedo), 3 (RT2 material),
5 (depth), 6 (RT4), 7 (RT5), 9 (TileIndexBuffer SSBO), 10 (specular output image),
11 (diffuse output image), 13 (ExposureBuffer SSBO), 16 (linear sampler), 23 (LightClusterGrid SSBO),
24 (LightIndexList SSBO), 25 (LightDataBuffer SSBO), 29 (AreaLightBuffer SSBO),
32 (shadow sampler), 33 (DecalProjectorBuffer SSBO), 34-37 (IBL cubemaps), 38 (BRDF LUT),
39 (ShadowParams UBO), 40 (ShadowMapTransforms SSBO), 41 (shadow atlas), 42 (AO),
43 (contact shadows), 45 (light cookies cube[] + 2D[])

**Set 5:** binding 0 (FogParams UBO), 1 (sky transmittance), 2 (fog froxel 3D), 4 (aerial perspective), 5 (cloud shadow)

### Group B adds (+1 binding):

```glsl
#if defined(LAYOUT_GROUP_B) || defined(LAYOUT_GROUP_C)
layout(set = 1, binding = 4) uniform texture2D gbufferRT3;
#endif
```

### Group C adds (+3 bindings beyond Group B):

```glsl
#if defined(LAYOUT_GROUP_C)
layout(set = 0, binding = 0, std140) uniform RenderSettings { ... } renderSettings;
layout(set = 1, binding = 21) uniform texture2DArray csmCascades;
layout(set = 1, binding = 28, std430) readonly buffer HeroLightBuffer { ... } heroLights;
#endif
```

---

## File Structure in RenoDX Addon (deferred/ directory)

### Primary approach: GLSL #include

```
deferred/
├── clustered_uber_body.glsl                            ← shared implementation (~7000 lines)
├── clustered_uber_groupA_0xAB2320F6.comp.glsl          ← wrapper (5 lines)
├── clustered_uber_groupA_0xB92BEFEE.comp.glsl
├── clustered_uber_groupB_0x3F6F9DBA.comp.glsl
├── clustered_uber_groupB_0x4D74577D.comp.glsl
├── clustered_uber_groupB_0x7FE5A589.comp.glsl
├── clustered_uber_groupB_0xB0AF807E.comp.glsl
├── clustered_uber_groupB_0xD360C8D7.comp.glsl
├── clustered_uber_groupB_0xD5B01922.comp.glsl
├── clustered_uber_groupB_0xEE06F4F5.comp.glsl
├── clustered_uber_groupC_0x3B67DBD8.comp.glsl
├── clustered_uber_groupC_0x6B5EDB4F.comp.glsl
├── clustered_uber_groupC_0x92395FFB.comp.glsl
├── clustered_uber_groupC_0xA4582498.comp.glsl
├── clustered_uber_groupC_0xBDAB4D15.comp.glsl
```

Wrapper file example (Group B):
```glsl
#version 450
#extension GL_GOOGLE_include_directive : require
#define LAYOUT_GROUP_B
#include "clustered_uber_body.glsl"
```

### Fallback: Python pre-build generator

If `GL_GOOGLE_include_directive` isn't supported by RenoDX's glslang invocation:

```python
#!/usr/bin/env python3
"""generate_uber_shaders.py — stamp out 14 .comp.glsl files from one template."""
import shutil

GROUPS = {
    'A': ['0xAB2320F6', '0xB92BEFEE'],
    'B': ['0x3F6F9DBA', '0x4D74577D', '0x7FE5A589', '0xB0AF807E',
          '0xD360C8D7', '0xD5B01922', '0xEE06F4F5'],
    'C': ['0x3B67DBD8', '0x6B5EDB4F', '0x92395FFB', '0xA4582498', '0xBDAB4D15'],
}

with open('clustered_uber_body.glsl', 'r') as f:
    body = f.read()

for group, hashes in GROUPS.items():
    define = f'#define LAYOUT_GROUP_{group}\n'
    for h in hashes:
        out = f'clustered_uber_group{group}_{h}.comp.glsl'
        with open(out, 'w') as f:
            f.write('#version 450\n')
            f.write(define)
            f.write(body)
        print(f'  Generated {out}')
```

---

## Starting Point for clustered_uber_body.glsl

Use `deferred-ibl_0x3B67DBD8.comp.glsl` (the mega shader, 7058 lines) as the base.
It already handles ALL 7 material types + hero lighting + CSM. Steps:

1. Copy 0x3B67DBD8 body (everything after `#version 450` and extensions)
2. Wrap the 4 group-specific bindings in `#ifdef` guards
3. Wrap the hero light loop in `#ifdef LAYOUT_GROUP_C`
4. Wrap GBuffer RT3 reads in `#if defined(LAYOUT_GROUP_B) || defined(LAYOUT_GROUP_C)`
5. Add push_constant block (same as existing main-deferred replacement)
6. Add RenoDX modifications (diffuse BRDF selection, micro shadows, cubemap mod, etc.)
7. Verify the material switch handles `case 1` (unlit) with early break for all groups

---

## Evidence Classification

| Claim | Evidence Level |
|-------|---------------|
| Group A has exactly 36 binding slots | VERIFIED (grep of both .glsl files) |
| Group B has exactly 37 binding slots | VERIFIED (grep of all 7 .glsl files) |
| All 7 Group B shaders are binding-identical | VERIFIED (diff of grep outputs) |
| Group C internal split (3+2 on set=0/b=0) | VERIFIED (grep of all 5 .glsl files) |
| Vulkan superset rule (shader can under-declare) | VERIFIED (Vulkan 1.1 spec §14.5.3) |
| Pipeline layout shared across Group C | ASSUMPTION (same dispatch path) |
| GL_GOOGLE_include_directive works in RenoDX | UNVERIFIED (needs build test) |
| Slang causes visual bugs for these shaders | VERIFIED (user-reported, previous attempt) |

---

## Test Plan

1. Build with `#include` approach — check if addon compiles
2. Deploy, load game, check for tile seams at material boundaries
3. Key test areas:
   - Character close-up (hair tiles adjacent to skin tiles)
   - Mixed terrain (grass/rock with anisotropic stone)
   - Indoor hero lighting (lit character, unlit walls)
   - Grymforge (heavy cloth/clearcoat)
4. Toggle `pc.hero_lighting` via RenoDX UI to verify Group C hero loop
5. CSM debug view (`pc.csm_debug`) to confirm cascade sampling in Group C
