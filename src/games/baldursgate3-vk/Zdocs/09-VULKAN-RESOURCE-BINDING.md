# Vulkan Resource Binding & Pipeline Architecture

> Reference for reverse engineering the Vulkan API layer in Ghidra

## Render Pass Architecture

BG3 uses **traditional Vulkan render passes** (`vkCmdBeginRenderPass`), NOT dynamic rendering (`vkCmdBeginRendering`).

## Descriptor Set Convention

| Set | Typical Usage | Update Frequency |
|-----|---------------|-----------------|
| 0 | Per-frame globals (camera, scene, time) | Once per frame |
| 1 | Per-pass resources (textures, UAVs, samplers) | Per render pass |
| 2 | Material/shadow data (SSBOs, shadow maps) | Per material/batch |
| 3 | (Not observed in use by the game) | — |
| 4 | (Rarely observed) | — |
| 5 | Atmospheric data (sky LUT, fog volume, transmittance) | Per frame |

## Common UBO Layouts

### Set 0, Binding 0 — Render Settings

```c
struct RenderSettings {  // ~32 bytes
    float time;           // _m0: elapsed time
    float deltaTime;      // _m1: frame delta
    float frameCount;     // _m2: frame counter (for dithering)
    float ditherScale;    // _m3: dither pattern scale
    float shadowBias;     // _m4
    float shadowNormalBias;// _m5
    int   shadowMode;     // _m6
    float reserved;       // _m7
};
```

### Set 0, Binding 1 — Scene Globals

```c
struct SceneGlobals {     // ~608 bytes
    vec3  sunDirection;   // _m0
    float sunIntensity;   // _m1
    vec3  sunColor;       // _m2
    float ambientScale;   // _m3
    vec3  ambientColor;   // _m4
    float skyIntensity;   // _m5
    mat4  viewMatrix;     // _m6
    vec4  frustumRays[3]; // _m7: corner rays for position reconstruction
    vec4  skyColor1;      // _m8
    vec4  skyColor2;      // _m9
    float skyParams[8];   // _m10–_m17: sky/atmosphere controls
    vec4  fogParams;      // _m18
    float atmosphereIntensity; // _m19
    float atmosphereParams[3]; // _m20–_m22
    vec4  windParams;     // _m23
    vec3  cameraPosition; // _m24
    float cameraFar;      // _m25
    vec3  cameraPrev;     // _m26
    float cameraNear;     // _m27
    vec4  timeOfDay;      // _m28
    vec3  moonDirection;  // _m29
    float moonIntensity;  // _m30
    vec4  cloudParams;    // _m31
    vec3  horizonColor;   // _m32
    float horizonBlend;   // _m33
    vec3  sunDiskColor;   // _m34
    float sunDiskSize;    // _m35
    vec3  sunDirectionAtmo; // _m36: sun direction for atmospheric scattering
    float atmoMieG;       // _m37
};
```

### Set 0, Binding 2 — Camera Matrices

```c
struct CameraMatrices {   // ~224 bytes
    mat4  viewProjection;     // _m0
    mat4  invViewProjection;  // _m1
    mat4  prevViewProjection; // _m2 (for motion vectors)
    float nearPlane;          // _m3
    float farPlane;           // _m4
    vec2  jitterOffset;       // _m5 (TAA jitter)
    vec3  cameraWorldPos;     // _m6
    int   frameIndex;         // _m7
};
```

### Set 0, Binding 4 — Viewport/Resolution

```c
struct ViewportParams {   // ~176 bytes
    vec2  renderSize;     // _m0: render resolution
    vec2  renderSizeInv;  // _m1: 1/resolution
    uvec2 renderSizeUint; // _m2
    uvec2 viewportMin;    // _m3: viewport offset
    uvec2 viewportMax;    // _m4: viewport extent
    uint  frameIndex;     // _m5
    uint  flags;          // _m6
    vec2  dynamicResScale;// _m7: DRS scale factor
    // ... additional UV scale/offset pairs for various render targets
    // _m8 through _m22
};
```

## Push Constant Usage

### Game Push Constants

The game uses push constants for per-draw data. The exact layout varies per shader, but common patterns:

- **Deferred lighting**: Large push constant block with tile dispatch info
- **Shadow passes**: Cascade index, bias parameters
- **Material passes**: Material instance data, texture indices

## SSBO Patterns

### Light Data SSBO

Lights are stored in structured SSBOs with per-type strides:
- Point lights: 80 bytes per entry
- Spot lights: 80 bytes (same buffer, offset after point lights)
- Box lights: 128 bytes per entry
- Probes: 144 bytes per entry

### Tile/Cluster Lists

- Light indices: `uint[]` SSBO
- Cluster headers: `uvec4[]` SSBO with packed counts
- Atomic counter: Single `uint` for global allocation

## Texture Binding Patterns

### Bindless Textures

BG3 uses **bindless texture arrays** for:
- Cubemap probes: `textureCube _24[]` (set 1, binding 45)
- 2D textures: `texture2D _25[]` (same binding, different type)

Requires `GL_EXT_nonuniform_qualifier` for dynamic indexing.

### Sampler Separation

Textures and samplers are separate objects (Vulkan combined image sampler is NOT used):
```glsl
layout(set = 1, binding = 16) uniform sampler _7;      // linear sampler
layout(set = 1, binding = 32) uniform sampler _12;      // shadow sampler
layout(set = 1, binding = 34) uniform textureCube _14;  // cubemap texture
// Usage: texture(samplerCube(_14, _7), direction)
```
