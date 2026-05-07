# Lighting & Clustered Light Culling

> Shaders: `clustered-light-culling_0xF51C9B95.comp.slang`, `light-tile-classification_0xCCA3BE68.comp.slang`, `lighting-boundary-smoother_0x7C1A8163.comp.slang`

## Clustered Light Culling

### Overview

BG3 uses a **3D clustered** light culling system (not just 2D tiled). The screen is divided into tiles in XY, and depth is sliced exponentially to form 3D clusters. Each cluster gets a list of affecting lights.

### Cluster Grid

- XY tile size: configurable via `_8_m25` (typically 16 or 32 pixels)
- Z slices: exponential distribution: `depth = exp2((sliceIdx + 1 - offset) / scale)`
- Slice 0 extends from near plane to the first exponential boundary
- Grid dimensions stored in `_8_m23` (X), `_8_m24` (Y), `_8_m26` (max Z slice)

### Frustum Construction

For each cluster, the shader constructs a tight **6-plane frustum** plus 4 axis-aligned planes:
```
Left/Right planes from inverse projection
Top/Bottom planes from inverse projection  
Near/Far planes from cluster depth range
+X/-X axis planes (view-space bounding)
+Y/-Y axis planes (view-space bounding)
```

Additionally computes a **bounding sphere** (center + radius) for fast sphere-vs-sphere rejection.

### Light Types Culled

The shader processes 5 categories of lights in sequence, each loaded in 64-element batches into shared memory:

| Category | Count Source | Data Source | Stride | Test |
|----------|-------------|-------------|--------|------|
| **Point lights** | `_15_m1` | `_5` (80B) | 80 bytes | Sphere-frustum |
| **Spot lights** | `_15_m2` | `_5` (80B) | 80 bytes | Cone-frustum |
| **Box lights** | `_15_m3` | `_6` (128B) | 128 bytes | OBB-frustum |
| **Reflection probes** | `_15_m4` | `_7` (144B) | 144 bytes | Sphere or OBB |
| **Decal probes** | `_15_m5` | `_16` (144B) | 144 bytes | Sphere or OBB |

### Point Light Culling

```
1. Sphere-sphere test: distance² < (clusterRadius + lightRadius)²
2. 10-plane frustum test: dot(lightPos, plane) > -lightRadius for all 10 planes
```

### Spot Light Culling

```
1. Bounding sphere test (using cone bounding sphere)
2. Cone half-angle test: dot(spotDir, toLight) >= cos(halfAngle) × distance
3. Edge case: ray-cone intersection for lights near cluster boundary
```

### Box/OBB Light Culling

```
1. Transform cluster center into OBB local space
2. Compute signed distance to OBB surface
3. Test: distance² < clusterRadius²
```

### Output

- **Light list SSBO** (`_13`, RW): Flat array of light indices
- **Cluster header SSBO** (`_12`, RW): Per-cluster packed header:
  ```
  uint4 header;
  header.x = globalOffset;
  header.y = pointCount | (spotCount << 12) | (decalCount << 24);
  header.z = boxCount | (probeCount << 10);
  ```
- **Atomic counter** (`_14`): Global allocation counter for light list entries

## Light Data Structures

### Point/Spot Light (80 bytes, SSBO `_5`)

| Offset | Type | Field |
|--------|------|-------|
| 0 | vec4 | Position (xyz), inverse radius (w) |
| 16 | vec4 | Spot direction (xyz), cos half-angle (w) |
| 32 | vec4 | Color (xyz), unused (w) |
| 48 | ... | Additional data (shadow params, etc.) |

### Area / Box Light (SSBO `_11` in deferred shader, set 1 binding 29)

| Field | Type | Meaning |
|-------|------|---------|
| `_m0` | vec3 | Light color |
| `_m1` | uint | Flags (bit 0 = use shadow, bit 1+ = cookie texture index) |
| `_m2` | vec4 | Spot direction (xyz), outer cone angle (w) |
| `_m3` | vec2 | Edge fade distances |
| `_m4` | uint | Light layer bitmask (lower 24 bits) + falloff curve index (upper 8 bits) |
| `_m5` | float | Shadow blend factor |
| `_m6` | mat4x3 | World-to-light-local transform |
| `_m7` | vec3 | Half-extents (for OBB shape) |
| `_m8` | uint | Shadow flags (bit 0 = has shadow, bits 2+ = shadow atlas index) |
| `_m9` | vec3 | Light direction (normalized, for NdotL) |
| `_m10` | float | Intensity scale |

### Box Light (128 bytes, SSBO `_6` in culling shader)

| Offset | Type | Field |
|--------|------|-------|
| 0–47 | float4x3 | World-to-local transform |
| 48–95 | float4x3 | Inverse transform |
| 96 | vec3 | Half-extents |

### Reflection/Decal Probe (144 bytes, SSBO `_7` / `_16`)

| Offset | Type | Field |
|--------|------|-------|
| 0 | vec4 | Position (xyz), radius or type flag (w) |
| 16–60 | float4x3 | Orientation matrix |
| 64+ | ... | Probe-specific data |

## Light Tile Classification

`light-tile-classification_0xCCA3BE68.comp.slang` classifies tiles into categories for optimized deferred shader dispatch:
- Tiles with no lights → skip lighting
- Tiles with only simple lights → use simplified shader
- Tiles with complex materials → use full-featured shader

## IBL / Reflection Probes

### Probe System

- Cubemap probes stored in bindless texture arrays (`_24[]` in deferred shader)
- Per-probe data in SSBO includes: position, radius, blend weight, parallax correction box
- Probes support both box and sphere shapes with parallax-corrected ray intersection
- Each probe can blend between two cubemap snapshots (for scripted lighting transitions or area variants)
- Probes are blended per-pixel based on distance and priority
- Diffuse and specular IBL contributions are evaluated separately per probe
