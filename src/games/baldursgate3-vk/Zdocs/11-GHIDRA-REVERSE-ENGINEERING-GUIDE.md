# Ghidra Reverse Engineering Guide

> Practical tips for using these documents when reverse engineering BG3's Vulkan renderer in Ghidra.

## Finding the Renderer Entry Points

### Vulkan Function Imports

Search for these Vulkan API calls in the import table:
- `vkCmdBeginRenderPass` — marks the start of each render pass
- `vkCmdBindPipeline` — pipeline binding (identifies which shader is active)
- `vkCmdBindDescriptorSets` — resource binding
- `vkCmdPushConstants` — push constant updates
- `vkCmdDraw` / `vkCmdDrawIndexed` — draw calls
- `vkCmdDispatch` — compute shader dispatches
- `vkCreateGraphicsPipelines` / `vkCreateComputePipelines` — pipeline creation
- `vkCreateShaderModule` — SPIR-V shader loading

### Pipeline Creation

The game creates pipelines at load time. Look for:
1. SPIR-V bytecode buffers (magic number `0x07230203` at start)
2. `VkShaderModuleCreateInfo` structs pointing to SPIR-V data
3. `VkGraphicsPipelineCreateInfo` / `VkComputePipelineCreateInfo` structs

### Shader Hash Matching

To match a pipeline to our decompiled shaders:
1. Find the SPIR-V bytecode pointer in `VkShaderModuleCreateInfo`
2. Compute CRC32 of the bytecode
3. Look up the hash in `10-SHADER-HASH-INDEX.md`

## Key Data Structures to Find

### Light Buffer

Look for allocations of ~80 bytes per element with this pattern:
```
[vec4: position + invRadius]  // offset 0
[vec4: direction + cosAngle]  // offset 16
[vec4: color + unused]        // offset 32
[additional data]              // offset 48+
```

The light count is typically stored near the cluster grid parameters.

### Cluster Grid

Look for a 3D grid allocation with dimensions like:
- X = ceil(screenWidth / tileSize)
- Y = ceil(screenHeight / tileSize)  
- Z = ~24-32 depth slices

Each cluster entry is a `uvec4` (16 bytes) with packed light counts.

### GBuffer Render Targets

Look for `vkCreateImage` calls creating:
- R8G8B8A8_UNORM at render resolution (albedo)
- **R16G16_SFLOAT** at render resolution (normals — distinctive format)
- R8G8B8A8_UNORM at render resolution (material properties)
- D32_SFLOAT at render resolution (depth)

The R16G16_SFLOAT normal buffer is the most distinctive — few other textures use this format at full resolution.

### Shadow Atlas

Look for:
- `VkImageCreateInfo` with a large 2D depth texture: **8192×8192** (the shared shadow atlas)
- Format: D32_SFLOAT or D16_UNORM
- Also look for a **2048×2048** intermediate depth texture used as the per-cascade render target
- `vkCmdBlitImage` or `vkCmdCopyImage` calls that pack the 2048×2048 intermediate into sub-regions of the 8192×8192 atlas
- The atlas also contains cached point/spot light shadow maps — not all regions update every frame

### 3D LUT

Look for:
- `VkImageCreateInfo` with `imageType = VK_IMAGE_TYPE_3D`
- Extent = {64, 64, 64}
- Format = R16G16B16A16_SFLOAT

### Volumetric Fog Volume

Look for:
- `VkImageCreateInfo` with `imageType = VK_IMAGE_TYPE_3D`
- Format = R16G16B16A16_SFLOAT
- Extent with Z dimension ~64-128 (depth slices)

## Uniform Buffer Identification

### Scene Globals (~608 bytes)

Distinctive pattern: contains a 4×4 matrix (view matrix) at offset ~96, followed by 3 vec4s (frustum rays). Look for:
- `vkCmdBindDescriptorSets` with set=0
- Buffer size ~608 bytes
- Updated once per frame

### Camera Matrices (~224 bytes)

Contains 3 consecutive 4×4 matrices (view-proj, inv-view-proj, prev-view-proj). Look for:
- Near/far plane values after the matrices
- TAA jitter offset (vec2) — changes every frame with small values

### CSM Parameters (~544 bytes)

Contains 4 consecutive 4×4 matrices (cascade view-projection, including atlas sub-region offset/scale). Look for:
- 4 float values for cascade far planes
- 4 float values for cascade texel sizes (expect values reflecting 1024 and 2048 resolution)
- Tan of shadow cone angle

## Frame Timing Patterns

The rendering order is consistent. When tracing a frame:

1. **Early frame**: GBuffer writes (many draw calls, pipeline changes)
2. **Mid frame**: Shadow passes (render to depth-only FBOs)
3. **Mid frame**: AO compute dispatches (small workgroups)
4. **Mid frame**: Light culling compute (single dispatch)
5. **Mid frame**: Deferred lighting compute (large dispatch covering screen)
6. **Mid-late frame**: Forward passes (water, VFX — fewer draw calls)
7. **Late frame**: Post-processing chain (bloom, exposure, tonemap, UI)

## Hooking Strategy

### For Shader Identification

1. Hook `vkCreateShaderModule` to intercept SPIR-V loading
2. Compute CRC32 of incoming bytecode
3. Look up the hash in `10-SHADER-HASH-INDEX.md`

### For Resource Tracking

1. Hook `vkCmdBeginRenderPass` to track render targets
2. Match render target formats/dimensions to identify GBuffer passes
3. Hook `vkCmdBindDescriptorSets` to track resource binding
4. Hook `vkCmdPushConstants` to capture per-draw data

### For Draw Call Analysis

1. Hook `vkCmdDraw`/`vkCmdDrawIndexed`
2. Track currently bound pipeline to identify which shader is active
3. Log draw parameters, bound resources, push constant data
4. Correlate with render pass to understand frame structure

## Common Patterns in Decompiled Code

### Obfuscated Variable Names

SPIRV-Cross generates names like `_35`, `_m0`, `_474`. Cross-reference with:
- Descriptor set/binding numbers to identify which texture/buffer
- The UBO layouts documented in `09-VULKAN-RESOURCE-BINDING.md`
- Known constants (e.g., `0.3183098733` = 1/π, `0.07957747` = 1/(4π))

### Known Mathematical Constants

| Value | Meaning |
|-------|---------|
| `0.3183098733` | 1/π (Lambert diffuse normalization) |
| `0.07957747` | 1/(4π) |
| `6.283185482` | 2π |
| `2.3999631` | Golden angle in radians |
| `0.16` | Default dielectric F0 (0.04 = 0.16 × 0.5²) |
| `0.18` | Mid-gray (18% reflectance) |
| `3.5554` / `-1.7777` | Octahedral normal decode constants |
| `0.2126, 0.7152, 0.0722` | BT.709 luminance weights |

### Reversed-Z Depth

BG3 uses reversed-Z (1.0 = near, 0.0 = far). All depth comparisons are inverted from the usual convention. Shadow maps also use reversed-Z.
