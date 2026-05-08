#ifndef SRC_GAMES_POE2_VK_POE2_RENDERING_HLSLI_
#define SRC_GAMES_POE2_VK_POE2_RENDERING_HLSLI_

// Local rendering helpers for poe2-vk.
// Extracted from src/shaders/rendering.hlsl to avoid pulling the full 13k-line
// file into every shader via renodx.hlsl.

namespace renodx {
namespace rendering {

// Bloom black-floor preservation (luminance-aware bloom scaling).
// Suppresses bloom contribution in dark scene regions to prevent
// black crush and glow bleeding into shadows.
//
// Uses a self-relative gate: brighter bloom loosens the threshold,
// so intense bloom sources still read correctly.
float3 BloomScaling(
    float3 bloomColor,
    float3 sceneColor,
    float  strength = 0.5,
    float  midGray  = 0.18)
{
  static const float3 kLumCoeff = float3(0.2126, 0.7152, 0.0722);

  float bloomLum       = dot(bloomColor, kLumCoeff);
  float midGrayBloomed = (midGray + bloomLum) / midGray;

  float sceneLum  = dot(sceneColor, kLumCoeff) * midGrayBloomed;
  float blend     = saturate(smoothstep(0.0, midGray, sceneLum));

  float3 scaled   = bloomColor * blend;
  return lerp(bloomColor, scaled, strength);
}

}  // namespace rendering
}  // namespace renodx

#endif  // SRC_GAMES_POE2_VK_POE2_RENDERING_HLSLI_
