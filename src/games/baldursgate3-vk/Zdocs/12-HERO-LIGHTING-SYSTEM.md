# Hero Lighting System

> Analysis of BG3's artificial character lighting and how it is removed.
> This is a game feature that exists in the vanilla binary, documented here for reverse engineering purposes.

## What Is Hero Lighting?

BG3 applies **artificial fill/rim lights** to character models that do not exist in the actual scene. These are invisible area lights (OBB-shaped, from the 3rd light loop in the deferred shader) that only affect pixels belonging to specific **light layer masks**. The result is a "3-point lighting" setup on characters — key, fill, and rim — that makes them look like they're on a film set regardless of the actual environment lighting.

This is a common technique in cinematic games to ensure characters are always readable, but in BG3 it is heavy-handed: characters glow in dark caves, have rim highlights with no light source behind them, and look disconnected from the environment.

## How It Works in the Vanilla Game

### Light Layer Mask

The GBuffer alpha channel packs a **light layer mask** in bits 4–6:
```glsl
uint lightLayer = (uint(roundEven(gbuffer2.w * 255.0)) & 0x70) >> 4;
```

Character materials (skin, hair, eyes, clothing) are assigned to specific light layers (observed as layers **5** and **7**). Environment geometry uses different layers.

### Invisible Area Lights

The game places **unshadowed area/box lights** in the scene that are masked to only affect character light layers. These lights:
- Are in the 3rd light loop (area lights, SSBO `_11`, range `[_575, _579)` in the tile light list)
- Have their shadow flag (`_m8 & 1`) set to **0** (unshadowed) — they skip the shadow atlas lookup entirely
- Are masked via `(_m4 & 0xFFFFFF) & (1 << lightLayer)` to only hit character layers
- Have their own color, direction (`_m9`), and OBB shape (`_m6` transform)
- Can optionally sample a 2D light texture (cookie) via bindless `_25[]`

In the deferred shader, the unshadowed area light path is:
```glsl
if ((_11._m0[lightIdx]._m8 & 1u) != 0u)
{
    // Shadowed path — shadow atlas lookup, PCSS, etc.
    intensity = attenuation * mix(1.0, shadowResult, shadowBlend);
}
else
{
    // Unshadowed path — hero lights land here
    // No shadow lookup at all, just raw attenuation
    intensity = attenuation;  // ← this is what hero lights use
}
```

Because these lights have no shadow, they illuminate characters uniformly through walls, floors, and other occluders.

### Probe Override

In addition to the direct hero lights, the game also uses **local reflection probes** that are masked to character layers. These probes override the global sky IBL on characters, giving them a different ambient/specular environment than the world around them. This further disconnects characters from the scene lighting.

## How RenoDX Removes It

The fix targets two things: the unshadowed area lights and the character-specific probe override.

### 1. Kill Unshadowed Area Lights on Character Layers

In every deferred shader variant, the unshadowed area light path is modified:
```glsl
// Vanilla: intensity = attenuation;
// RenoDX: zero out intensity for character light layers
intensity = ((lightLayer == 5u || lightLayer == 7u) && heroLightingRemoved) ? 0.0 : attenuation;
```

This completely removes the artificial fill/rim lights. Characters are now lit only by actual scene lights (point, spot, shadowed area lights) and the global IBL.

### 2. Reduce Character-Specific Probe Blending

The probe loop blends local probes over the global IBL using a per-probe weight. For character layers, RenoDX reduces this blend:
```glsl
float probeBlend = probeResult.w;  // vanilla blend weight
if ((lightLayer == 5u || lightLayer == 7u) && heroLightingRemoved) {
    probeBlend *= 0.3;  // reduce to 30% — lets global IBL dominate
}
finalIBL = mix(globalIBL, probeIBL, probeBlend);
```

This ensures characters pick up the actual environment's ambient lighting instead of a curated probe.

### Affected Shaders

The hero lighting fix is applied in **all deferred lighting shader variants** (every shader in the 3rd light loop):

| Hash | Shader |
|------|--------|
| `0xAB2320F6` | `main-deferred` |
| `0xD5B01922` | `multi-material-deferred-nocsm` |
| `0xD360C8D7` | `terrain-secondary-normal-deferred-nocsm` |
| `0x3F6F9DBA` | `transmissive-material-deferred-lighting` |
| `0xBDAB4D15` | `two-layer-material-deferred-csm-specularaa-volumetric` |
| `0xA4582498` | `vsm-two-layer-materials` |
| `0xB0AF807E` | `hair-per-tile-reflection-probes` |

## What to Look For in Ghidra

To find the hero lighting system in the binary:

1. **Light layer assignment**: Look for where the GBuffer alpha's bits 4–6 are written during character material rendering. The specific layer values (5, 7) are set per-material, likely in material data or draw call setup.

2. **Area light placement**: The invisible hero lights must be placed by the CPU side. Look for light creation/submission code that:
   - Sets the shadow flag to 0 (unshadowed)
   - Sets the light layer mask to only include character layers
   - Is tied to character entity positions (follows the player/NPCs)

3. **Light layer mask in the light SSBO**: The area light struct field `_m4` contains the layer mask in its lower 24 bits. Hero lights will have masks like `(1 << 5) | (1 << 7)` = `0xA0` in those bits.

4. **Probe assignment**: Similarly, look for probe placement code that assigns probes specifically to character light layers. These probes may be attached to character entities rather than placed in the world.
