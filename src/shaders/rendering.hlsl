// Rendering Improvements — helpers
// ========================================================
//
// This file is organized into three major parts:
//
// ╔══════════════════════════════════════════════════════════════════════════╗
// ║  PART I — GENERAL RENDERING                                              ║
// ║  Post-processing & composition helpers (not BRDF-specific).              ║
// ╠══════════════════════════════════════════════════════════════════════════╣
// ║  1. Cubemap / probe modulation   (skylight luminance + roughness + AO)   ║
// ║  2. Bloom black-floor preservation (luminance-aware bloom scaling)       ║
// ║  3. Fog color correction          (OKLab hue / chrominance restore)      ║
// ╠══════════════════════════════════════════════════════════════════════════╣
// ║  PART II — RASTERISATION BRDF                                            ║
// ║  Physically-based shading models for direct & indirect evaluation in     ║
// ║  rasterisation pipelines.  No importance sampling or PDF required.       ║
// ╠══════════════════════════════════════════════════════════════════════════╣
// ║  4.  Hammon 2017 diffuse   (GGX+Smith multi-scatter energy-conserving)   ║
// ║  5.  Callisto BRDF         (SIGGRAPH 2023 dual-lobe GGX + diffuse)       ║
// ║  6.  Proxima BRDF          (SIGGRAPH 2023 diffuse antialiasing)          ║
// ║  7.  Hammon+Proxima        (combined energy + distance diffuse)          ║
// ║  8.  Multi-Scatter GGX     (Kulla-Conty specular compensation)           ║
// ║  9.  Material helpers      (IoR, metallic, aniso roughness, Beer-Lambert)║
// ║  10. Anisotropic GGX       (Heitz 2014 NDF + visibility + specular)      ║
// ║  11. Thin film iridescence (wave-interference Fresnel + geom. series)    ║
// ║  12. Volumetric helpers    (Henyey-Greenstein phase, RNM blending)       ║
// ║  13. RDX BRDF              (unified raster BRDF — single entry point)    ║
// ╠══════════════════════════════════════════════════════════════════════════╣
// ║  PART III — RAY TRACING / PATH TRACING BRDF                              ║
// ║  Functions that require stochastic ray generation or Monte Carlo         ║
// ║  integration — unusable in standard rasterisation pipelines.             ║
// ╠══════════════════════════════════════════════════════════════════════════╣
// ║  14. VNDF sampling         (importance-sampled microfacet normals)       ║
// ║  15. VNDF PDF evaluation   (probability density for MC weighting)        ║
// ║  16. Subsurface scattering (Hanrahan single-scatter transmission)        ║
// ║  17. RDX BRDF RT           (unified RT BRDF — single entry point)        ║
// ╚══════════════════════════════════════════════════════════════════════════╝
//
// Rasterisation BRDF sections 9-12 and all of Part III ported from
// NVIDIA RTX Remix (MIT license), adapted to fp32 HLSL.
//
// Usage:  #include "rendering.hlsl"

#ifndef SRC_SHADERS_RENDERING_HLSL_
#define SRC_SHADERS_RENDERING_HLSL_

#include "./color.hlsl"
#include "./math.hlsl"

namespace renodx {
namespace rendering {

// ############################################################################
//
//   PART I — GENERAL RENDERING
//
// ############################################################################

// ============================================================================
// 1.1  Cubemap / Probe Modulation
// ----------------------------------------------------------------------------
// Attenuates IBL (cubemap / reflection-probe) contributions
//
//   a) Sky-light luminance — when the diffuse probe reports very little
//      incoming light the cubemap reflection should dim accordingly,
//      preventing over-bright reflections in dark environments.
//
//   b) Roughness — rough surfaces scatter reflected light over a wider
//      solid angle, so the specular cubemap lobe carries less perceptual
//      energy and the darkening floor can be relaxed.
//
//   c) Ambient-Occlusion — occluded surfaces receive less indirect light;
//      the modulation scales down to avoid light-leaking in corners/crevices.
//
// Usage:
//   float3 cubemapColor = ...;  // sampled cubemap / probe result
//   cubemapColor *= renodx::rendering::CubemapModulation(skyLight, roughness, ao);
//
// Parameters:
//   skyLight       – diffuse probe / sky irradiance sample (linear RGB)
//   roughness      – perceptual roughness [0,1]
//   aoFactor       – ambient occlusion [0 = fully occluded, 1 = unoccluded]
//   lumThreshold   – smoothstep upper edge for the luminance gate (default 0.25)
//   minIntensity   – floor multiplier when modulation is at its darkest (default 0.3)
//   roughnessRange – {min, max} multiplier range for roughness term (default {0.5, 1.0})
//   aoRange        – {min, max} multiplier range for AO term       (default {0.4, 1.0})
//
// Returns:  scalar modulation factor to multiply into the cubemap color.
// ============================================================================

float CubemapModulation(
    float3 skyLight,
    float  roughness,
    float  aoFactor,
    float  lumThreshold   = 0.25,
    float  minIntensity   = 0.3,
    float2 roughnessRange = float2(0.5, 1.0),
    float2 aoRange        = float2(0.4, 1.0))
{
  // BT.709 luminance of the incoming sky / probe light.
  float skyLum = max(0.0, dot(skyLight, float3(0.2126, 0.7152, 0.0722)));

  // Compose the three modulation factors.
  float mod = smoothstep(0.0, lumThreshold, skyLum)
            * lerp(roughnessRange.x, roughnessRange.y, saturate(roughness))
            * lerp(aoRange.x,        aoRange.y,        saturate(aoFactor));

  return lerp(minIntensity, 1.0, mod);
}

// ============================================================================
// 1.2  Bloom Black-Floor Preservation
// ----------------------------------------------------------------------------
// Scales bloom contribution based on the scene luminosity at each pixel so
// that bloom energy is suppressed in regions that should stay dark
//
// The core idea:
//   1. Compute a "mid-gray bloomed" factor: how much the bloom itself
//      shifts the perceptual mid-gray anchor (0.18).  This makes the
//      gate self-relative — brighter bloom loosens the gate.
//   2. Multiply scene luminosity by that factor to get an adjusted
//      brightness metric.
//   3. Use smoothstep(0, midGray, adjusted) to produce a blend weight
//      that is 0 in true darks and 1 once the scene is mid-gray or above.
//   4. Lerp bloom toward zero by that weight, then blend the result
//      against the original bloom by `strength`.
//
// Uses BT.709 weighted luminance for the brightness metric, providing
// perceptually correct bloom suppression that matches human sensitivity
// to different wavelengths.
//
// Usage:
//   bloom_color = renodx::rendering::BloomScaling(
//       bloom_color, sceneColor, strength);
//   output = sceneColor + bloom_color;   // additive composite
//
// Parameters:
//   bloomColor   – bloom buffer value (linear RGB, already intensity-scaled)
//   sceneColor   – scene color at the same pixel (linear RGB, before bloom)
//   strength     – overall scaling strength [0 = disabled, 1 = full]
//                  (default 0.5)
//   midGray      – perceptual mid-gray anchor; controls the luminosity
//                  threshold below which bloom is suppressed (default 0.18)
//
// Returns:  adjusted bloom color, same space as input.
// ============================================================================

float3 BloomScaling(
    float3 bloomColor,
    float3 sceneColor,
    float  strength = 0.5,
    float  midGray  = 0.18)
{
  // BT.709 luminance coefficients.
  static const float3 kLumCoeff = float3(0.2126, 0.7152, 0.0722);

  // Bloom luminance drives the self-relative gate.
  float bloomLum       = dot(bloomColor, kLumCoeff);
  float midGrayBloomed = (midGray + bloomLum) / midGray;

  // Scene luminance rescaled by the bloomed anchor.
  float sceneLum  = dot(sceneColor, kLumCoeff) * midGrayBloomed;

  // Blend weight: 0 in darks, 1 at/above mid-gray.
  float blend     = saturate(smoothstep(0.0, midGray, sceneLum));

  // Suppress bloom in dark regions, then mix by strength.
  float3 scaled   = bloomColor * blend;
  return lerp(bloomColor, scaled, strength);
}

// ============================================================================
// 1.3  Fog Color Correction  (OKLab Hue / Chrominance / Lightness Restoration)
// ----------------------------------------------------------------------------
// From Pumbo
//
// Two functions are provided:
//
//   RestoreHueAndChrominance  – general purpose: blend an target colour's
//       hue, chrominance and/or lightness toward a source colour in OKLab.
//
//   FogColorCorrection  – convenience wrapper that composites scene + fade,
//       then restores the fog's hue/chroma/lightness to avoid colour shifts.
// ============================================================================

// ---------------------------------------------------------------------------
// RestoreHueAndChrominance
// ---------------------------------------------------------------------------
// Blends `targetColor` toward `sourceColor` in OKLab to restore hue,
// chrominance, and/or lightness that may have been lost by tone-mapping or
// colour grading.
//
// Parameters:
//   targetColor        – the colour to correct (linear BT.709)
//   sourceColor        – the reference colour whose appearance we want to
//                        preserve (linear BT.709)
//   hueStrength        – [0,1] how much hue is restored (default 0.75)
//   chrominanceStrength– [0,1] how much chrominance is restored (default 1.0)
//   minChromaChange    – minimum chrominance scale allowed (default 0.0)
//   maxChromaChange    – maximum chrominance scale allowed (default FLT_MAX)
//   lightnessStrength  – [0,1] how much OKLab L is restored (default 0.0)
//
// Returns:  corrected colour in linear BT.709.
// ---------------------------------------------------------------------------
float3 RestoreHueAndChrominance(
    float3 targetColor,
    float3 sourceColor,
    float  hueStrength         = 0.75,
    float  chrominanceStrength = 1.0,
    float  minChromaChange     = 0.0,
    float  maxChromaChange     = 3.402823466e+38,  // FLT_MAX
    float  lightnessStrength   = 0.0)
{
  // Early-outs.
  if (hueStrength == 0.0 && chrominanceStrength == 0.0 && lightnessStrength == 0.0)
    return targetColor;

  // Black / invalid colours break OKLab conversions.
  if (::renodx::color::y::from::BT709(targetColor) <= 1.175494351e-38)  // FLT_MIN
    return targetColor;

  float3 srcLab = ::renodx::color::oklab::from::BT709(sourceColor);
  float3 tgtLab = ::renodx::color::oklab::from::BT709(targetColor);

  // ---- Lightness -----------------------------------------------------------
  tgtLab.x = lerp(tgtLab.x, srcLab.x, lightnessStrength);

  float currentChroma = length(tgtLab.yz);

  // ---- Hue -----------------------------------------------------------------
  // Blend a,b (which encode both hue *and* chrominance), then rescale back
  // to the original chrominance so only the hue component is affected.
  if (hueStrength != 0.0)
  {
    tgtLab.yz = lerp(tgtLab.yz, srcLab.yz, hueStrength);
    float chromaPost = length(tgtLab.yz);
    float chromaRatio = ::renodx::math::DivideSafe(currentChroma, chromaPost, 1.0);
    tgtLab.yz *= chromaRatio;
    // currentChroma is unchanged by definition.
  }

  // ---- Chrominance ---------------------------------------------------------
  if (chrominanceStrength != 0.0)
  {
    float srcChroma = length(srcLab.yz);
    float chromaRatio = ::renodx::math::DivideSafe(srcChroma, currentChroma, 1.0);
    chromaRatio = clamp(chromaRatio, minChromaChange, maxChromaChange);
    tgtLab.yz *= lerp(1.0, chromaRatio, chrominanceStrength);
  }

  return ::renodx::color::bt709::from::OkLab(tgtLab);
}

// ---------------------------------------------------------------------------
// FogColorCorrection
// ---------------------------------------------------------------------------
// Composites scene + fog/fade, then restores the fog's hue and chrominance
// in OKLab so that HDR-extended fog blends don't shift colour.
//
// Parameters:
//   sceneColor  – the scene colour before fog (linear BT.709)
//   fadeColor   – the additive fog / colour-fade value (linear BT.709)
//   hue         – hue restoration strength   (default 0.8)
//   chrominance – chroma restoration strength (default 1.0)
//   avgBrightness  – lightness restoration scale from scene  (default 1.0)
//   minBrightness  – lightness restoration floor              (default 0.0)
//   intensity      – overall blend toward corrected result    (default 1.0)
//
// Returns:  scene + fog with hue/chroma preserved, linear BT.709.
// ---------------------------------------------------------------------------
float3 FogColorCorrection(
    float3 sceneColor,
    float3 fadeColor,
    float  hue            = 0.8,
    float  chrominance    = 1.0,
    float  avgBrightness  = 1.0,
    float  minBrightness  = 0.0,
    float  intensity      = 1.0)
{
  float3 sceneWithFog     = sceneColor + fadeColor;
  float3 prevSceneWithFog = sceneWithFog;

  // Normalize fade to extract its chrominance independent of magnitude.
  float fadeMax = max(abs(fadeColor.x), max(abs(fadeColor.y), abs(fadeColor.z)));
  float3 normFade = (fadeMax != 0.0) ? (fadeColor / fadeMax) : fadeColor;
  float3 fadeLab  = ::renodx::color::oklab::from::BT709(normFade);

  float3 sceneLab = ::renodx::color::oklab::from::BT709(sceneColor);

  // Scale hue restoration by the fog's own chrominance — grey fog has
  // no meaningful hue to restore, so skip the shift.
  float fogChroma  = length(fadeLab.yz);
  float fogHue     = hue * saturate(fogChroma / 1.41421356);  // sqrt(2)

  // Lightness: restore an optional minimum + proportional amount.
  float fogBright  = saturate(avgBrightness * sceneLab.x + minBrightness);

  sceneWithFog = RestoreHueAndChrominance(
      sceneColor, sceneWithFog,
      fogHue, chrominance, 0.0, 3.402823466e+38, fogBright);

  return lerp(prevSceneWithFog, sceneWithFog, intensity);
}

// ############################################################################
//
//   PART II — RASTERISATION BRDF
//
// ############################################################################

// ============================================================================
// 2.1  Hammon 2017 Diffuse BRDF
// ----------------------------------------------------------------------------
// Earl Hammon Jr., GDC 2017
// "PBR Diffuse Lighting for GGX+Smith Microsurfaces"
//
// Drop-in replacement for Lambertian (albedo / PI) that accounts for:
//   • Single-scatter Fresnel darkening at grazing angles
//   • Multi-scatter energy compensation between microfacets
//
// Designed to pair with a GGX NDF + Smith height-correlated geometry term
// on the specular side so total surface energy is conserved.
//
// Parameters (all expected saturated [0,1]):
//   NdotL     – saturate(dot(normal, lightDir))
//   NdotV     – saturate(dot(normal, viewDir))
//   NdotH     – saturate(dot(normal, halfVec))
//   VdotH     – saturate(dot(viewDir, halfVec))   (== LdotH by symmetry)
//   roughness – perceptual roughness [0,1]
//   albedo    – surface base color (linear)
//
// Returns:  albedo-weighted diffuse contribution, ready to multiply by
//           NdotL * lightColor.
// ============================================================================

float3 HammonDiffuseBRDF(
    float NdotL, float NdotV, float NdotH, float VdotH,
    float roughness, float3 albedo)
{
  // ---- Facing term --------------------------------------------------------
  float facing = 0.5 + 0.5 * VdotH;

  // ---- Rough surface approximation ----------------------------------------
  // Guard NdotH via safe division to avoid singularity when the half-vector
  // lies in the tangent plane.  Uses the same safe-divide pattern as NVIDIA
  // RTX Remix (materialEpsilon ≈ 8e-5) instead of the coarse max(NdotH, 0.1)
  // clamp, giving more accurate retro-reflection at grazing angles.
  float rough = facing * (0.9 - 0.4 * facing)
              * ::renodx::math::DivideSafe(0.5 + NdotH, NdotH, 1.0);

  // ---- Smooth surface approximation (Fresnel-weighted) --------------------
  // pow5(1 - x) expanded manually for broad shader-model compatibility.
  float oneMinusNdotL = 1.0 - NdotL;
  float NdotL5 = oneMinusNdotL * oneMinusNdotL;
  NdotL5 *= NdotL5 * oneMinusNdotL;          // (1 - NdotL)^5

  float oneMinusNdotV = 1.0 - NdotV;
  float NdotV5 = oneMinusNdotV * oneMinusNdotV;
  NdotV5 *= NdotV5 * oneMinusNdotV;          // (1 - NdotV)^5

  float smooth_val = 1.05 * (1.0 - NdotL5) * (1.0 - NdotV5);

  // ---- Single-scatter: blend smooth ↔ rough by roughness, ÷ PI -----------
  float single = lerp(smooth_val, rough, roughness) * 0.318309886;  // 1/PI

  // ---- Multi-scatter energy compensation -----------------------------------
  // Approximates the additional energy returned by light bouncing more than
  // once between microfacets.  Multiplied by albedo² because each bounce is
  // attenuated by the surface color.
  float multi = 0.1159 * roughness;

  return albedo * single + albedo * albedo * multi;
}

// ============================================================================
// 2.2  Callisto BRDF
// ----------------------------------------------------------------------------
// SIGGRAPH 2023 — "The Rendering of The Callisto Protocol"
// Jorge Jimenez & Dan Petersen, Striking Distance Studios
//
// A physically-based shading model built on UE4's BRDF with the following
// enhancements:
//
//   a) Dual-lobe GGX specular with configurable Fresnel falloff (slide 95).
//
//   b) Custom diffuse coefficient c₁ — artist-driven Fresnel darkening +
//      retroreflection via per-parameter falloff exponents and optional
//      tints (slide 85).
//
//   c) Smooth terminator c₂ — smoothstep-based NdotL ramp modulated by
//      view/half-vector angles, configurable intensity and length (slide 90).
//
//   d) Three-tier parameter system: Base, Advanced, Full (slide 98).
//
// All functions are provided as composable building-blocks so you can mix
// and match (e.g. use only the dual-lobe specular with Hammon diffuse).
//
// Coordinate conventions:
//   N = surface normal,  V = view dir (toward eye),  L = light dir,
//   H = half-vector = normalize(V + L).
//   All dot-products are expected saturated [0,1] unless noted otherwise.
// ============================================================================

// -- 2.2a.  GGX Normal Distribution Function (Trowbridge-Reitz) ---------------
//
// D_GGX = alpha^2 / (PI * ((N·H)^2 * (alpha^2 - 1) + 1)^2)
//
float GGX_NDF(float NdotH, float alpha)
{
  float a2   = alpha * alpha;
  float denom = NdotH * NdotH * (a2 - 1.0) + 1.0;
  return a2 / (3.14159265 * denom * denom);
}

// -- 2.2b.  Smith Height-Correlated Visibility --------------------------------
//
// V_SmithGGX = 0.5 / (NdotL * sqrt(NdotV^2*(1-a2)+a2)
//                    + NdotV * sqrt(NdotL^2*(1-a2)+a2))
//
// Returns the combined geometry + denominator term (V = G / (4·NdotL·NdotV))
// so the caller can simply multiply D * V * F.
//
float SmithGGX_Visibility(float NdotV, float NdotL, float alpha)
{
  float a2 = alpha * alpha;
  float ggxV = NdotL * sqrt(NdotV * NdotV * (1.0 - a2) + a2);
  float ggxL = NdotV * sqrt(NdotL * NdotL * (1.0 - a2) + a2);
  return 0.5 / max(ggxV + ggxL, 1e-7);
}

// -- 2.2c.  Schlick Fresnel ---------------------------------------------------
//
// F = F0 + (1 - F0) * (1 - VdotH)^5
//
float3 SchlickFresnel(float3 F0, float VdotH)
{
  float oneMinusVdotH = 1.0 - VdotH;
  float pow5 = oneMinusVdotH * oneMinusVdotH;
  pow5 *= pow5 * oneMinusVdotH;
  return F0 + (1.0 - F0) * pow5;
}

float SchlickFresnel(float F0, float VdotH)
{
  float oneMinusVdotH = 1.0 - VdotH;
  float pow5 = oneMinusVdotH * oneMinusVdotH;
  pow5 *= pow5 * oneMinusVdotH;
  return F0 + (1.0 - F0) * pow5;
}

// -- 2.2d.  Single GGX Specular Lobe ------------------------------------------
//
// Computes D * V * F for one GGX lobe.
//   roughness  – perceptual roughness [0,1], squared internally to alpha.
//   F0         – reflectance at normal incidence.
//
// Returns:  specular radiance contribution (pre-NdotL).
//
float3 GGX_Specular(
    float  NdotH, float  NdotV, float  NdotL, float  VdotH,
    float  roughness, float3 F0)
{
  float alpha = roughness * roughness;
  alpha = max(alpha, 5e-5);   // tighter clamp (fp32-safe) for sharper specular on polished surfaces

  float  D = GGX_NDF(NdotH, alpha);
  float  V = SmithGGX_Visibility(NdotV, NdotL, alpha);
  float3 F = SchlickFresnel(F0, VdotH);

  return D * V * F;
}

// -- 2.2e.  Dual-Lobe GGX Specular -------------------------------------------
//
// The Callisto model uses two specular lobes:
//   Lobe 1 — primary GGX with the surface roughness and F0.
//   Lobe 2 — secondary (tighter or oilier) lobe with its own roughness/F0.
//
// The two are combined as:  Specular1 + Specular2 * secondaryWeight
//
// Parameters:
//   roughness1      – primary lobe roughness (default: surface roughness)
//   F0_1            – primary lobe F0
//   roughness2      – secondary lobe roughness (default: tighter, e.g. 0.6×)
//   F0_2            – secondary lobe F0 (default: same as primary)
//   secondaryWeight – blend weight for the second lobe (default 0.5)
//
// Returns:  combined dual-lobe specular, pre-NdotL.
//
float3 DualLobeGGX(
    float  NdotH, float  NdotV, float  NdotL, float  VdotH,
    float  roughness1, float3 F0_1,
    float  roughness2, float3 F0_2,
    float  secondaryWeight = 0.5)
{
  float3 lobe1 = GGX_Specular(NdotH, NdotV, NdotL, VdotH, roughness1, F0_1);
  float3 lobe2 = GGX_Specular(NdotH, NdotV, NdotL, VdotH, roughness2, F0_2);
  return lobe1 + lobe2 * secondaryWeight;
}

// -- 2.2f.  Callisto Specular Fresnel (Modified Schlick) ----------------------
//
// SIGGRAPH 2023 slide 95: Configurable Fresnel falloff.
//
//   F = f0 + saturate(2 - r(n_s)) * (1 - f0) * (1 - cosθ)^(5 * r(n_s))
//   r(x) = 2(1 - x)
//
// At n_s = 0.5 (default) this reduces to standard Schlick (exponent 5,
// amplitude 1).  Lowering n_s suppresses Fresnel; raising it broadens it.
//
//   n_s  – Specular Fresnel Falloff [0,1] (default 0.5)
//
float3 CallistoSpecularFresnel(float3 F0, float VdotH, float n_s = 0.5)
{
  float r_ns      = 2.0 * (1.0 - n_s);                // r(n_s)
  float amplitude = saturate(2.0 - r_ns);              // t(2 - r(n_s))
  float exponent  = 5.0 * r_ns;
  float base      = max(1.0 - VdotH, 0.0);
  float fresnel   = pow(base, exponent);
  return F0 + amplitude * (1.0 - F0) * fresnel;
}

float CallistoSpecularFresnel(float F0, float VdotH, float n_s = 0.5)
{
  float r_ns      = 2.0 * (1.0 - n_s);
  float amplitude = saturate(2.0 - r_ns);
  float exponent  = 5.0 * r_ns;
  float base      = max(1.0 - VdotH, 0.0);
  float fresnel   = pow(base, exponent);
  return F0 + amplitude * (1.0 - F0) * fresnel;
}

// -- 2.2g.  Callisto Diffuse Coefficient c₁ -----------------------------------
//
// SIGGRAPH 2023 slide 85: Fresnel + Retroreflection for diffuse lighting.
//
//   c₁(θ_d, θ_h) = lerp(1, ρ_f, α_f) · lerp(1, ρ_r, α_r)
//
//   h(θ, n, φ, m)  = (1 - max(cosθ,0))^(5n) · max(cosφ,0)^(5m)
//   α_f = h(θ_d, r(n_f), θ_h, r(m_f))    ← Fresnel
//   α_r = h(θ_h, r(n_r), θ_d, r(m_r))    ← Retroreflection
//   r(x) = 2(1 - x)
//
//   θ_d = difference angle  → cos(θ_d) = VdotH
//   θ_h = half-vector angle → cos(θ_h) = NdotH
//
// Parameters (slide 85 table / slide 98 tiers):
//   rho_f – Diffuse Fresnel intensity          [0,256] default 1
//   n_f   – Diffuse Fresnel Falloff             [0,1]  default 0.75
//   m_f   – Diffuse Fresnel Tangent Falloff     [0,1]  default 0.75
//   rho_r – Retroreflection intensity           [0,256] default 1
//   n_r   – Retroreflection Falloff             [0,1]  default 0.75
//   m_r   – Retroreflection Tangent Falloff     [0,1]  default 0.75
//
// Returns:  scalar c₁ that multiplies f_lambert in the BRDF.
//
float CallistoDiffuseC1(
    float VdotH, float NdotH,
    float rho_f = 1.0, float n_f = 0.75, float m_f = 0.75,
    float rho_r = 1.0, float n_r = 0.75, float m_r = 0.75)
{
  // r(x) = 2(1-x)
  float r_nf = 2.0 * (1.0 - n_f);
  float r_mf = 2.0 * (1.0 - m_f);
  float r_nr = 2.0 * (1.0 - n_r);
  float r_mr = 2.0 * (1.0 - m_r);

  // h(θ, n, φ, m) = (1 - max(cosθ,0))^(5n) * max(cosφ,0)^(5m)
  // Fresnel:        α_f = h(θ_d, r(n_f), θ_h, r(m_f))
  float alpha_f = pow(max(1.0 - VdotH, 0.0), 5.0 * r_nf)
                * pow(max(NdotH, 0.0),       5.0 * r_mf);

  // Retroreflection: α_r = h(θ_h, r(n_r), θ_d, r(m_r))
  float alpha_r = pow(max(1.0 - NdotH, 0.0), 5.0 * r_nr)
                * pow(max(VdotH, 0.0),        5.0 * r_mr);

  // c₁ = lerp(1, ρ_f, α_f) * lerp(1, ρ_r, α_r)
  return lerp(1.0, rho_f, alpha_f) * lerp(1.0, rho_r, alpha_r);
}

// Overload with tints (Advanced tier, slide 98).
// ρ is "exposed as intensity multiplied by a tint" (slide 85 footnote).
float3 CallistoDiffuseC1(
    float  VdotH, float  NdotH,
    float3 fresnelTint, float rho_f, float n_f, float m_f,
    float3 retroTint,   float rho_r, float n_r, float m_r)
{
  float r_nf = 2.0 * (1.0 - n_f);
  float r_mf = 2.0 * (1.0 - m_f);
  float r_nr = 2.0 * (1.0 - n_r);
  float r_mr = 2.0 * (1.0 - m_r);

  float alpha_f = pow(max(1.0 - VdotH, 0.0), 5.0 * r_nf)
                * pow(max(NdotH, 0.0),       5.0 * r_mf);

  float alpha_r = pow(max(1.0 - NdotH, 0.0), 5.0 * r_nr)
                * pow(max(VdotH, 0.0),        5.0 * r_mr);

  float3 fresnel = lerp(float3(1, 1, 1), fresnelTint * rho_f, alpha_f);
  float3 retro   = lerp(float3(1, 1, 1), retroTint   * rho_r, alpha_r);

  return fresnel * retro;
}

// -- 2.2h.  Callisto Smooth Terminator c₂ -------------------------------------
//
// SIGGRAPH 2023 slide 90.
//
//   c₂(θ_i) = lerp(1, smoothstep(0, α_s·p, cos(θ_i)), α_s·o)
//
//   α_s = (1 - (1 - cos(θ_d))³) · (1 - (1 - cos(θ_h))³)
//
//   θ_d = difference angle  → cos(θ_d) = VdotH
//   θ_h = half-vector angle → cos(θ_h) = NdotH
//   θ_i = incident angle    → cos(θ_i) = NdotL
//
// Parameters (slide 98):
//   o – Smooth Terminator intensity [-1,1] (default 0 = off)
//   p – Smooth Terminator Length    [0,1]  (default 0.5)
//
// Returns:  scalar c₂ that multiplies the entire BRDF (diffuse + specular).
//
float CallistoSmoothTerminator(
    float NdotL, float VdotH, float NdotH,
    float o = 0.0, float p = 0.5)
{
  // α_s = (1 - (1 - VdotH)³) · (1 - (1 - NdotH)³)
  float d3 = 1.0 - VdotH;
  d3 = d3 * d3 * d3;           // (1 - VdotH)³
  float h3 = 1.0 - NdotH;
  h3 = h3 * h3 * h3;           // (1 - NdotH)³

  float alpha_s = (1.0 - d3) * (1.0 - h3);

  float edge      = alpha_s * p;
  float cosTheta_i = max(NdotL, 0.0);
  float s          = smoothstep(0.0, edge, cosTheta_i);

  return lerp(1.0, s, alpha_s * o);
}

// -- 2.2i.  Full Callisto BRDF ------------------------------------------------
//
// Combines all components per slides 85 / 90 / 95:
//
//   L_o = (c₁ · f_lambert + f_ggx) · c₂ · cos(θ_i)
//
// Parameters follow the 3-tier system (slide 98):
//
//   Base:     rho_f, rho_r, n_f, n_r, o
//   Advanced: n_s, dualSpecRoughnessScale, dualSpecOpacity
//   Full:     m_f, m_r, p
//
// Returns:  float3 total outgoing radiance for a single light
//           (multiply by lightColor * lightIntensity externally).
//
float3 CallistoBRDF(
    float3 N, float3 V, float3 L,
    float  roughness, float3 albedo, float3 F0,
    // --- Base tier (slide 98) ---
    float  rho_f    = 1.0,    // Diffuse Fresnel          [0,256]
    float  rho_r    = 1.0,    // Retroreflection          [0,256]
    float  n_f      = 0.75,   // Diffuse Fresnel Falloff  [0,1]
    float  n_r      = 0.75,   // Retroreflection Falloff  [0,1]
    float  o        = 0.0,    // Smooth Terminator        [-1,1]
    // --- Advanced tier ---
    float  n_s      = 0.5,    // Specular Fresnel Falloff [0,1]
    float  dualSpecRoughnessScale = 2.0,
    float  dualSpecOpacity        = 1.0,
    // --- Full tier ---
    float  m_f      = 0.75,   // Diffuse Fresnel Tangent Falloff  [0,1]
    float  m_r      = 0.75,   // Retroreflection Tangent Falloff  [0,1]
    float  p        = 0.5)    // Smooth Terminator Length         [0,1]
{
  float3 H = normalize(V + L);

  float NdotL = dot(N, L);
  float NdotV = max(dot(N, V), 1e-5);
  float NdotH = saturate(dot(N, H));
  float VdotH = saturate(dot(V, H));

  // -- c₂: Smooth Terminator (slide 90) ------------------------------------
  float c2 = CallistoSmoothTerminator(NdotL, VdotH, NdotH, o, p);

  float sNdotL = max(NdotL, 0.0);  // saturated incident cosine

  // -- c₁: Diffuse coefficient (slide 85) -----------------------------------
  float c1 = CallistoDiffuseC1(VdotH, NdotH, rho_f, n_f, m_f, rho_r, n_r, m_r);

  // -- f_lambert: albedo / π ------------------------------------------------
  float3 f_lambert = albedo * 0.318309886;  // 1/PI

  // -- f_ggx: Dual-lobe specular (slide 95 Fresnel) ------------------------
  float roughness2  = saturate(roughness * dualSpecRoughnessScale);
  float sNdotLSpec  = max(sNdotL, 1e-5);   // avoid /0 in visibility

  // Primary lobe
  float alpha1 = max(roughness * roughness, 5e-5);
  float  D1 = GGX_NDF(NdotH, alpha1);
  float  V1 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha1);
  float3 F1 = CallistoSpecularFresnel(F0, VdotH, n_s);
  float3 spec1 = D1 * V1 * F1;

  // Secondary lobe
  float alpha2 = max(roughness2 * roughness2, 5e-5);
  float  D2 = GGX_NDF(NdotH, alpha2);
  float  V2 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha2);
  float3 F2 = CallistoSpecularFresnel(F0, VdotH, n_s);
  float3 spec2 = D2 * V2 * F2;

  float3 f_ggx = spec1 + spec2 * dualSpecOpacity;

  // -- Compose: L_o = (c₁ · f_lambert + f_ggx) · c₂ · cos(θ_i) ------------
  return (c1 * f_lambert + f_ggx) * c2 * sNdotL;
}

// ============================================================================
// 2.3  Proxima BRDF — Material Consistency Over Distance
// ----------------------------------------------------------------------------
// SIGGRAPH 2023 — "The Rendering of The Callisto Protocol" (slides 117-131)
// Jose Naranjo, Jon Diego, Jay Ryness & Miguel Rodriguez
//
// Problem:  Lighting(Downsample(inputs)) ≠ Downsample(Lighting(inputs)).
// Mipmapping normal and roughness maps loses high-frequency detail, causing
// incorrect diffuse lighting at distance.  Texture-space lighting is the
// ground truth but too expensive at runtime.
//
// [Chan18] solved the *specular* side (offline normal-length → roughness
// bake).  For *diffuse*, Striking Distance compared a brute-force 3D LUT
// (from [Heitz14]) against Lambert and observed:
//   • The most characteristic deviation occurs when N ≈ V *and* L is near
//     90° from N.
//   • All other configurations are well approximated by Lambert.
//
// They fitted a cheap analytical function to the critical LUT slice and
// called it **Proxima BRDF**.  It replaces f_lambert as a drop-in upgrade.
//
// Composition with the full Callisto BRDF (slide 131):
//   L_o = (c₁ · f_proxima + f_ggx) · c₂ · cos(θ_i)
// ============================================================================

// -- 2.3a.  Proxima BRDF (standalone) -----------------------------------------
//
// Slide 128:
//   f_proxima = (ρ/π) · (α·(-0.55 + 0.19·cosθ_i⁻¹)·(1 - cosθ_k^½) + 1)
//
//   cosθ_k = -V·L   (retro-reflection angle)
//   α       = roughness²  (GGX alpha)
//
// Note from slide 128: "For numerical stability we recommend to pre-multiply
// by cosθ_i to remove the division."  We follow that advice — the returned
// value already includes the NdotL factor, so the caller should NOT multiply
// by NdotL again.
//
// Parameters:
//   NdotL    – saturated dot(N,L)
//   VdotL    – dot(V,L), *not* saturated (can be negative)
//   roughness– perceptual roughness [0,1]
//   albedo   – base colour (linear)
//
// Returns:  diffuse radiance contribution (NdotL pre-applied).
//
float3 ProximaBRDF(
    float  NdotL,
    float  VdotL,
    float  roughness,
    float3 albedo)
{
  float alpha   = roughness * roughness;
  float cosK    = max(-VdotL, 0.0);          // cosθ_k = -V·L, clamped
  float cosI    = max(NdotL, 0.0);           // cosθ_i, clamped

  // Pre-multiplied form (slide 128 note): multiply through by cosθ_i
  // to eliminate the 1/cosθ_i singularity.
  //
  // Original:  (ρ/π) · (α·(-0.55 + 0.19/cosI) · (1 - sqrt(cosK)) + 1) · cosI
  // Rearranged: (ρ/π) · (α·(-0.55·cosI + 0.19) · (1 - sqrt(cosK)) + cosI)
  //
  float sqrtCosK = sqrt(cosK);
  float proxima  = alpha * (-0.55 * cosI + 0.19) * (1.0 - sqrtCosK) + cosI;

  return albedo * (0.318309886 * proxima);   // 0.318309886 = 1/π
}

// -- 2.3b.  Callisto + Proxima BRDF (combined) --------------------------------
//
// Slide 131: drop-in replacement — swap f_lambert for f_proxima inside the
// full Callisto composition:
//
//   L_o = (c₁ · f_proxima + f_ggx) · c₂ · cos(θ_i)
//
// Uses the same 3-tier parameter set as CallistoBRDF (slide 98).
//
float3 CallistoProximaBRDF(
    float3 N, float3 V, float3 L,
    float  roughness, float3 albedo, float3 F0,
    // --- Base tier ---
    float  rho_f    = 1.0,
    float  rho_r    = 1.0,
    float  n_f      = 0.75,
    float  n_r      = 0.75,
    float  o        = 0.0,
    // --- Advanced tier ---
    float  n_s      = 0.5,
    float  dualSpecRoughnessScale = 2.0,
    float  dualSpecOpacity        = 1.0,
    // --- Full tier ---
    float  m_f      = 0.75,
    float  m_r      = 0.75,
    float  p        = 0.5)
{
  float3 H = normalize(V + L);

  float NdotL = dot(N, L);
  float NdotV = max(dot(N, V), 1e-5);
  float NdotH = saturate(dot(N, H));
  float VdotH = saturate(dot(V, H));
  float VdotL = dot(V, L);              // *not* clamped

  // -- c₂: Smooth Terminator (slide 90) ------------------------------------
  float c2 = CallistoSmoothTerminator(NdotL, VdotH, NdotH, o, p);

  float sNdotL = max(NdotL, 0.0);

  // -- c₁: Diffuse coefficient (slide 85) -----------------------------------
  float c1 = CallistoDiffuseC1(VdotH, NdotH, rho_f, n_f, m_f, rho_r, n_r, m_r);

  // -- f_proxima: replaces f_lambert (slide 131) ----------------------------
  // ProximaBRDF returns with NdotL pre-applied, so we need it *without*
  // the extra sNdotL multiplication at the end.
  float alpha   = roughness * roughness;
  float cosK    = max(-VdotL, 0.0);
  float cosI    = sNdotL;
  float sqrtCosK = sqrt(cosK);
  float proxima  = alpha * (-0.55 * cosI + 0.19) * (1.0 - sqrtCosK) + cosI;
  float3 f_proxima = albedo * (0.318309886 * proxima);  // includes NdotL

  // -- f_ggx: Dual-lobe specular (slide 95 Fresnel) ------------------------
  float roughness2  = saturate(roughness * dualSpecRoughnessScale);
  float sNdotLSpec  = max(sNdotL, 1e-5);

  float alpha1 = max(roughness * roughness, 5e-5);
  float  D1 = GGX_NDF(NdotH, alpha1);
  float  V1 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha1);
  float3 F1 = CallistoSpecularFresnel(F0, VdotH, n_s);
  float3 spec1 = D1 * V1 * F1;

  float alpha2 = max(roughness2 * roughness2, 5e-5);
  float  D2 = GGX_NDF(NdotH, alpha2);
  float  V2 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha2);
  float3 F2 = CallistoSpecularFresnel(F0, VdotH, n_s);
  float3 spec2 = D2 * V2 * F2;

  float3 f_ggx = spec1 + spec2 * dualSpecOpacity;

  // -- Compose (slide 131): -------------------------------------------------
  // L_o = (c₁ · f_proxima + f_ggx) · c₂ · cos(θ_i)
  // f_proxima already has cosI baked in, so factor it out for consistency:
  //   (c₁ · f_proxima + f_ggx · sNdotL) · c₂
  return (c1 * f_proxima + f_ggx * sNdotL) * c2;
}

// ============================================================================
// 2.4  Hammon + Proxima Diffuse — Combined Energy + Distance Correction
// ----------------------------------------------------------------------------
// Combines two orthogonal diffuse improvements:
//
//   Hammon 2017 — fixes energy loss from ignoring multi-scattering between
//   microfacets.  Adds a correction factor to Lambert that recovers lost
//   energy, especially at high roughness + grazing angles.
//
//   Proxima (SIGGRAPH 2023) — fixes diffuse appearance at distance caused by
//   mipmapping normal/roughness maps.  Reshapes the angular distribution to
//   approximate what you'd get from texture-space lighting.
//
// Both are multiplicative corrections to ρ/π that approach 1.0 in
// smooth/simple configurations, so their product is well-behaved:
//
//   f_combined = (ρ/π) · hammonEnergy · proximaShape
//
// The Hammon energy term is extracted as a ratio vs Lambert, then applied
// on top of the Proxima base.  This preserves Proxima's angular reshaping
// while adding Hammon's multi-scatter energy recovery.
//
// Note: Proxima was fitted against Lambert, not Hammon.  At extreme
// roughness + extreme grazing angles the combined correction may slightly
// overshoot, but in practice both corrections are small perturbations
// (typically 0.8–1.2× range) and the product stays well-behaved.
// ============================================================================

// -- 2.4a.  Hammon Energy Ratio (standalone) ----------------------------------
//
// Returns the ratio of Hammon diffuse to Lambert diffuse.
// This isolates the multi-scatter energy correction so it can be applied
// as a multiplier on top of any other diffuse base (e.g. Proxima).
//
// Returns:  float3 energy ratio (per-channel due to albedo² in multi-scatter)
//
float3 HammonEnergyRatio(
    float NdotL, float NdotV, float NdotH, float VdotH,
    float roughness, float3 albedo)
{
  float3 hammon  = HammonDiffuseBRDF(NdotL, NdotV, NdotH, VdotH, roughness, albedo);
  float3 lambert = albedo * 0.318309886;  // 1/PI

  float3 ratio;
  ratio.x = ::renodx::math::DivideSafe(hammon.x, lambert.x, 1.0);
  ratio.y = ::renodx::math::DivideSafe(hammon.y, lambert.y, 1.0);
  ratio.z = ::renodx::math::DivideSafe(hammon.z, lambert.z, 1.0);

  return ratio;
}

// -- 2.4b.  Hammon + Proxima Diffuse (standalone) -----------------------------
//
// Combines Proxima's distance-stable angular distribution with Hammon's
// multi-scatter energy recovery.
//
//   result = ProximaBRDF() * HammonEnergyRatio()
//
// ProximaBRDF returns with NdotL pre-applied, so the output of this
// function also has NdotL baked in.  Do NOT multiply by NdotL again.
//
// Parameters:
//   NdotL     – saturated dot(N, L)
//   NdotV     – saturated dot(N, V)
//   NdotH     – saturated dot(N, H)
//   VdotH     – saturated dot(V, H)
//   VdotL     – dot(V, L), *not* saturated (can be negative)
//   roughness – perceptual roughness [0,1]
//   albedo    – surface base color (linear)
//
// Returns:  diffuse radiance contribution (NdotL pre-applied).
//
float3 HammonProximaDiffuse(
    float  NdotL, float  NdotV, float  NdotH, float  VdotH,
    float  VdotL,
    float  roughness, float3 albedo)
{
  float3 proxima     = ProximaBRDF(NdotL, VdotL, roughness, albedo);
  float3 energyRatio = HammonEnergyRatio(NdotL, NdotV, NdotH, VdotH, roughness, albedo);

  return proxima * energyRatio;
}

// -- 2.4c.  Callisto + Hammon + Proxima BRDF (full combination) ---------------
//
// The ultimate combination: uses Proxima's distance-stable diffuse as the
// base, applies Hammon's multi-scatter energy correction on top, then wraps
// it with the full Callisto framework (c₁ diffuse coefficient, dual-lobe
// GGX specular with configurable Fresnel, c₂ smooth terminator).
//
//   L_o = (c₁ · f_hammon_proxima + f_ggx) · c₂
//
// f_hammon_proxima already has NdotL baked in (from Proxima's pre-multiplied
// form), so the specular side is multiplied by NdotL separately.
//
// Uses the same 3-tier parameter set as CallistoBRDF (slide 98).
//
float3 CallistoHammonProximaBRDF(
    float3 N, float3 V, float3 L,
    float  roughness, float3 albedo, float3 F0,
    // --- Base tier ---
    float  rho_f    = 1.0,
    float  rho_r    = 1.0,
    float  n_f      = 0.75,
    float  n_r      = 0.75,
    float  o        = 0.0,
    // --- Advanced tier ---
    float  n_s      = 0.5,
    float  dualSpecRoughnessScale = 2.0,
    float  dualSpecOpacity        = 1.0,
    // --- Full tier ---
    float  m_f      = 0.75,
    float  m_r      = 0.75,
    float  p        = 0.5)
{
  float3 H = normalize(V + L);

  float NdotL = dot(N, L);
  float NdotV = max(dot(N, V), 1e-5);
  float NdotH = saturate(dot(N, H));
  float VdotH = saturate(dot(V, H));
  float VdotL = dot(V, L);              // *not* clamped

  // -- c₂: Smooth Terminator (slide 90) ------------------------------------
  float c2 = CallistoSmoothTerminator(NdotL, VdotH, NdotH, o, p);

  float sNdotL = max(NdotL, 0.0);

  // -- c₁: Diffuse coefficient (slide 85) -----------------------------------
  float c1 = CallistoDiffuseC1(VdotH, NdotH, rho_f, n_f, m_f, rho_r, n_r, m_r);

  // -- f_hammon_proxima: Proxima base + Hammon energy (NdotL pre-applied) ---
  float3 f_hp = HammonProximaDiffuse(
      sNdotL, NdotV, NdotH, VdotH, VdotL, roughness, albedo);

  // -- f_ggx: Dual-lobe specular (slide 95 Fresnel) ------------------------
  float roughness2  = saturate(roughness * dualSpecRoughnessScale);
  float sNdotLSpec  = max(sNdotL, 1e-5);

  float alpha1 = max(roughness * roughness, 5e-5);
  float  D1 = GGX_NDF(NdotH, alpha1);
  float  V1 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha1);
  float3 F1 = CallistoSpecularFresnel(F0, VdotH, n_s);
  float3 spec1 = D1 * V1 * F1;

  float alpha2 = max(roughness2 * roughness2, 5e-5);
  float  D2 = GGX_NDF(NdotH, alpha2);
  float  V2 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha2);
  float3 F2 = CallistoSpecularFresnel(F0, VdotH, n_s);
  float3 spec2 = D2 * V2 * F2;

  float3 f_ggx = spec1 + spec2 * dualSpecOpacity;

  // -- Compose: (c₁ · f_hammon_proxima + f_ggx · NdotL) · c₂ --------------
  // f_hp has NdotL pre-applied; specular needs it explicitly.
  return (c1 * f_hp + f_ggx * sNdotL) * c2;
}

// ============================================================================
// 2.5  Multi-Scatter GGX Specular — Kulla-Conty Energy Compensation
// ----------------------------------------------------------------------------
// Kulla & Conty, SIGGRAPH 2017 — "Revisiting Physically Based Shading"
//
// Single-scatter GGX loses energy at high roughness because inter-microfacet
// bounces are ignored.  This section provides LUT-free analytical helpers
// plus a full combined BRDF.
//
// The approach:
//   1. Compute directional albedo E(μ, α) — the fraction of energy reflected
//      by single-scatter GGX at a given (NdotV, roughness) pair.
//   2. The missing energy is (1 - E(μ_o)) · (1 - E(μ_i)).
//   3. Apply a multiplicative compensation factor that recovers this energy,
//      tinted by F_avg (average Fresnel) for correct color saturation.
//
// The directional albedo uses Turquin 2019's rational polynomial fit, avoiding any 2D LUT texture fetches.
// Turquin 2019 directional albedo fit is calibrated for GGX + Smith height-correlated visibility, if a game uses Schlick-Beckmann geometry
// specular will get blow out and causes fireflies, clamp both primary and secondary lobe compensation factor
//
// ============================================================================

// -- 2.5a.  Directional Albedo E(μ, α) — Turquin 2019 fit --------------------
//
// Approximates the fraction of incoming energy reflected by single-scatter
// GGX+Smith at a given view angle and roughness.  Replaces the 2D LUT
// from Kulla-Conty with an analytical rational polynomial.
//
// Accuracy is within ~1% of the tabulated LUT for GGX + height-correlated Smith visibility.
//
float GGX_DirectionalAlbedo(float NdotV, float roughness)
{
  float mu  = NdotV;
  float a   = roughness;
  float a2  = a * a;
  float mu2 = mu * mu;

  // Rational polynomial fit (Turquin 2019)
  float num = 1.0
            + mu  * (-1.0816 + a * 0.0378)
            + mu2 * ( 0.1696 + a * 0.0856)
            + a   * (-0.6992 + a * (1.4424 + a * (-1.3616 + a * 0.4504)));

  return saturate(num);
}

// -- 2.5b.  Average Albedo E_avg(α) -------------------------------------------
//
// Hemisphere-average of DirectionalAlbedo.  Used in the denominator of
// multi-scatter compensation to ensure energy conservation.
//
float GGX_AverageAlbedo(float roughness)
{
  float a = roughness;
  return saturate(1.0 + a * (-0.7127 + a * (0.4364 + a * (-0.1188))));
}

// -- 2.5c.  Multi-Scatter Compensation Factor ---------------------------------
//
// Returns a per-channel multiplier (≥ 1.0) to apply to single-scatter
// specular, recovering the missing inter-bounce energy.
//
// The factor accounts for:
//   1. Missing energy from inter-microfacet bounces
//   2. Color saturation: each bounce is attenuated by F0, so metals
//      get more saturated highlights with multi-scatter.
//
// From Kulla-Conty 2017, rearranged into multiplicative form:
//   compensation = 1 + F_avg · (1 - E_o)(1 - E_i) / (E_o · E_i · (1 - F_avg(1 - E_avg)))
//
// At roughness=0, E≈1, so compensation≈1 (no correction needed).
// At high roughness with bright F0, this can reach 1.3–1.8×.
//
float3 MultiScatterCompensation(
    float  NdotV,
    float  NdotL,
    float  roughness,
    float3 F0)
{
  float Eo   = GGX_DirectionalAlbedo(NdotV, roughness);
  float Ei   = GGX_DirectionalAlbedo(NdotL, roughness);
  float Eavg = GGX_AverageAlbedo(roughness);

  // Average Fresnel: cosine-weighted hemisphere integral of Schlick
  //   F_avg = F0 + (1/21)(1 - F0)
  float3 Favg = F0 + (1.0 / 21.0) * (1.0 - F0);

  // Denominator: energy that doesn't escape after multiple bounces
  float3 f_ms_denom = max(1.0 - Favg * (1.0 - Eavg), 1e-5);

  // Directional energy loss from single-scatter
  float  dirLoss = (1.0 - Eo) * (1.0 - Ei);
  float  dirBase = max(Eo * Ei, 1e-5);

  // Clamp compensation to prevent fireflies when the game's geometry term
  // doesn't match the GGX+Smith model the Turquin fit was calibrated against.
  return min(1.0 + Favg * dirLoss / (dirBase * f_ms_denom), 4.0);
}

float MultiScatterCompensation(
    float NdotV, float NdotL, float roughness, float F0)
{
  return MultiScatterCompensation(NdotV, NdotL, roughness, float3(F0, F0, F0)).x;
}

// -- 2.5d.  Full Callisto + Hammon + Proxima with Multi-Scatter Specular ------
//
// The full combination:
//   • Diffuse:   Proxima (distance-stable) × Hammon (energy-conserving)
//   • Specular:  Dual-lobe GGX × Kulla-Conty multi-scatter compensation
//   • Framework: Callisto c₁ (Fresnel + retroreflection) + c₂ (smooth terminator)
//
// This is the most physically complete configuration available:
//   L_o = (c₁ · f_hammon_proxima + f_ggx_ms) · c₂
//
// Uses the same 3-tier parameter set as CallistoBRDF (slide 98).
//
float3 CallistoHammonProximaBRDF_MultiScatter(
    float3 N, float3 V, float3 L,
    float  roughness, float3 albedo, float3 F0,
    // --- Base tier ---
    float  rho_f    = 1.0,
    float  rho_r    = 1.0,
    float  n_f      = 0.75,
    float  n_r      = 0.75,
    float  o        = 0.0,
    // --- Advanced tier ---
    float  n_s      = 0.5,
    float  dualSpecRoughnessScale = 2.0,
    float  dualSpecOpacity        = 1.0,
    // --- Full tier ---
    float  m_f      = 0.75,
    float  m_r      = 0.75,
    float  p        = 0.5)
{
  float3 H = normalize(V + L);

  float NdotL = dot(N, L);
  float NdotV = max(dot(N, V), 1e-5);
  float NdotH = saturate(dot(N, H));
  float VdotH = saturate(dot(V, H));
  float VdotL = dot(V, L);

  // -- c₂: Smooth Terminator (slide 90) ------------------------------------
  float c2 = CallistoSmoothTerminator(NdotL, VdotH, NdotH, o, p);

  float sNdotL = max(NdotL, 0.0);

  // -- c₁: Diffuse coefficient (slide 85) -----------------------------------
  float c1 = CallistoDiffuseC1(VdotH, NdotH, rho_f, n_f, m_f, rho_r, n_r, m_r);

  // -- Hammon + Proxima diffuse (NdotL pre-applied) -------------------------
  float3 f_hp = HammonProximaDiffuse(
      sNdotL, NdotV, NdotH, VdotH, VdotL, roughness, albedo);

  // -- Dual-lobe specular with multi-scatter compensation -------------------
  float roughness2  = saturate(roughness * dualSpecRoughnessScale);
  float sNdotLSpec  = max(sNdotL, 1e-5);

  // Primary lobe + compensation
  float alpha1 = max(roughness * roughness, 5e-5);
  float  D1 = GGX_NDF(NdotH, alpha1);
  float  V1 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha1);
  float3 F1 = CallistoSpecularFresnel(F0, VdotH, n_s);
  float3 spec1 = D1 * V1 * F1;
  spec1 *= MultiScatterCompensation(NdotV, sNdotLSpec, roughness, F0);

  // Secondary lobe + compensation
  float alpha2 = max(roughness2 * roughness2, 5e-5);
  float  D2 = GGX_NDF(NdotH, alpha2);
  float  V2 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha2);
  float3 F2 = CallistoSpecularFresnel(F0, VdotH, n_s);
  float3 spec2 = D2 * V2 * F2;
  spec2 *= MultiScatterCompensation(NdotV, sNdotLSpec, roughness2, F0);

  float3 f_ggx = spec1 + spec2 * dualSpecOpacity;

  // -- Compose: (c₁ · f_hp + f_ggx · NdotL) · c₂ --------------------------
  return (c1 * f_hp + f_ggx * sNdotL) * c2;
}

// ============================================================================
// 2.6  Material Parameterization Helpers
// ----------------------------------------------------------------------------
// Ported from NVIDIA RTX Remix (MIT license) and adapted to fp32 HLSL.
//
// Utilities for converting between common PBR parameterizations:
//   • IoR ↔ base reflectivity (Schlick F0)
//   • Metallic-workflow albedo / reflectivity derivation
//   • Isotropic → anisotropic roughness mapping
//   • Perceptual ↔ linear roughness
//   • Beer-Lambert transmittance ↔ attenuation coefficient
// ============================================================================

// -- 2.6a.  Perceptual ↔ Linear Roughness ------------------------------------
// [Burley 2012, "Physically-Based Shading at Disney"]

float PerceptualRoughnessToRoughness(float perceptualRoughness)
{
  return perceptualRoughness * perceptualRoughness;
}

float RoughnessToPerceptualRoughness(float roughness)
{
  return sqrt(roughness);
}

// -- 2.6b.  IoR ↔ Base Reflectivity ------------------------------------------
//
// Converts between index of refraction and monochromatic Schlick F0 using
// the Fresnel equations at normal incidence:
//   F0 = ((n1 - n2) / (n1 + n2))²
//
// [RTX Remix, brdf.slangh]

float IorToBaseReflectivity(float incidentIoR, float transmittedIoR)
{
  float ratio = (incidentIoR - transmittedIoR) / (incidentIoR + transmittedIoR);
  return ratio * ratio;
}

// Inverse: recover IoR from a monochromatic F0 and incident IoR.
// Note: On conductors the resulting IoR will be unrealistically high because
// the true reflectivity depends on the complex refractive index (n + ik).
float BaseReflectivityToIoR(float incidentIoR, float baseReflectivity)
{
  // Clamp sqrt(F0) to 0.99 to prevent overflow with near-1 materials
  float sqrtF0 = min(sqrt(baseReflectivity), 0.99);
  return incidentIoR / (2.0 / (sqrtF0 + 1.0) - 1.0);
}

// -- 2.6c.  Metallic-Workflow Helpers -----------------------------------------
//
// Standard metallic workflow used by glTF, UE, Unity, Remix, etc.
// [RTX Remix, brdf.slangh]

static const float3 kDielectricBaseReflectivity = float3(0.04, 0.04, 0.04);

// Adjusted albedo: conductors absorb all transmitted light, so their
// diffuse albedo is effectively zero.  Opacity scales the contribution.
float3 AlbedoToAdjustedAlbedo(float3 baseAlbedo, float metallic, float opacity = 1.0)
{
  return baseAlbedo * (1.0 - metallic) * opacity;
}

// Base reflectivity (F0): dielectric uses constant 0.04; conductor uses
// the albedo color.  Opacity scales the result.
float3 CalcBaseReflectivity(float3 albedo, float metallic, float opacity = 1.0)
{
  return lerp(kDielectricBaseReflectivity, albedo, metallic) * opacity;
}

// -- 2.6d.  Anisotropic Roughness Mapping -------------------------------------
//
// Converts isotropic roughness + an anisotropy parameter in (-1, 1) into
// per-axis roughness for tangent (T) and bitangent (B) directions.
// [Kulla 2017, "Revisiting Physically Based Shading at Imageworks"]
// [RTX Remix, brdf.slangh]

float2 IsotropicToAnisotropicRoughness(float isotropicRoughness, float anisotropy)
{
  return float2(isotropicRoughness * (1.0 + anisotropy),
                isotropicRoughness * (1.0 - anisotropy));
}

// Inverse: recover anisotropy from per-axis roughness given the isotropic
// reference.
float AnisotropicRoughnessToAnisotropy(float isotropicRoughness, float2 anisotropicRoughness)
{
  if (isotropicRoughness <= 0.0) return 0.0;
  float2 norm = anisotropicRoughness / isotropicRoughness;
  return (norm.x - norm.y) * 0.5;
}

// Full roughness derivation: perceptual roughness + anisotropy → clamped
// isotropic and anisotropic roughness values ready for GGX evaluation.
void CalcRoughness(
    float  perceptualRoughness,
    float  anisotropy,
    out float  isotropicRoughness,
    out float2 anisotropicRoughness)
{
  static const float kMinRoughness = 1e-4;  // matches RTX Remix materialMinimumRoughness

  float rawIso   = PerceptualRoughnessToRoughness(perceptualRoughness);
  float2 rawAniso = IsotropicToAnisotropicRoughness(rawIso, anisotropy);

  isotropicRoughness   = max(rawIso,   kMinRoughness);
  anisotropicRoughness = max(rawAniso, float2(kMinRoughness, kMinRoughness));
}

// -- 2.6e.  Beer-Lambert Attenuation ------------------------------------------
//
// Calculates the extinction coefficient from transmittance color at a known
// distance, and evaluates attenuation at an arbitrary distance.
// [Burley 2015, "Extending the Disney BRDF to a BSDF with Integrated SSS"]
// [RTX Remix, brdf.slangh]

float3 TransmittanceToAttenuationCoefficient(float3 transmittanceColor,
                                             float  measurementDistance)
{
  return -log(max(transmittanceColor, 1e-10)) / max(measurementDistance, 1e-10);
}

float3 EvalBeerLambertAttenuation(float3 attenuationCoefficient, float distance)
{
  return exp(-attenuationCoefficient * distance);
}

// ============================================================================
// 2.7  Anisotropic GGX Specular
// ----------------------------------------------------------------------------
// Ported from NVIDIA RTX Remix (MIT license), adapted to fp32 HLSL.
//
// Extends the existing isotropic GGX with tangent-space anisotropy for
// brushed metals, hair, directional surfaces, etc.
//
// Required inputs beyond the standard N·V / N·L / N·H / V·H:
//   T (tangent), B (bitangent) — orthonormal frame on the surface.
//   T·H, B·H, T·L, B·L, T·V, B·V — dot products with the tangent frame.
//
// [Heitz 2014, "Understanding the Masking-Shadowing Function in
//  Microfacet-Based BRDFs"]
// ============================================================================

// -- 2.7a.  Anisotropic GGX Normal Distribution Function (D) -----------------
//
// D_GGX_aniso = 1 / (π · αx · αy · ((TdotH/αx)² + (BdotH/αy)² + NdotH²)²)
//
// Uses the algebraically restructured form from Google Filament / RTX Remix
// to minimize runtime divisions at the cost of extra multiplications.
// Full fp32 precision is used throughout because small roughness values
// (<= 0.01) produce very small intermediate quantities.
//
float GGX_NDF_Anisotropic(
    float2 anisotropicRoughness,
    float  TdotH, float BdotH, float NdotH)
{
  float ax = anisotropicRoughness.x;
  float ay = anisotropicRoughness.y;
  float roughnessProduct = ax * ay;

  float3 denomVec = float3(ay * TdotH, ax * BdotH, roughnessProduct * NdotH);
  float denomDot  = dot(denomVec, denomVec);
  float body      = ::renodx::math::DivideSafe(roughnessProduct, denomDot, 1e-30);

  return (1.0 / 3.14159265) * roughnessProduct * body * body;
}

// -- 2.7b.  Anisotropic Height-Correlated GGX Visibility (V) -----------------
//
// V = G2 / (4 · NdotL · NdotV)
//
// Combines the shadowing/masking function with the microfacet BRDF
// denominator, just like the isotropic SmithGGX_Visibility above.
//
// [Heitz 2014]
//
float SmithGGX_Visibility_Anisotropic(
    float2 anisotropicRoughness,
    float  TdotV, float BdotV, float NdotV,
    float  TdotL, float BdotL, float NdotL)
{
  float ax = anisotropicRoughness.x;
  float ay = anisotropicRoughness.y;

  float lambdaV = NdotL * length(float3(ax * TdotV, ay * BdotV, NdotV));
  float lambdaL = NdotV * length(float3(ax * TdotL, ay * BdotL, NdotL));

  return 0.5 / max(lambdaV + lambdaL, 1e-7);
}

// -- 2.7c.  Anisotropic GGX Specular Evaluation ------------------------------
//
// Full D * V * F for a single anisotropic GGX lobe.
//
// Parameters:
//   anisotropicRoughness – float2(αx, αy) from IsotropicToAnisotropicRoughness
//   TdotH, BdotH, NdotH — half-vector projected onto tangent frame
//   TdotV, BdotV, NdotV — view direction projected onto tangent frame
//   TdotL, BdotL, NdotL — light direction projected onto tangent frame
//   VdotH                — view dot half-vector (for Fresnel)
//   F0                   — reflectance at normal incidence
//
// Returns:  specular radiance contribution (pre-NdotL).
//
float3 GGX_Specular_Anisotropic(
    float2 anisotropicRoughness,
    float  TdotH, float BdotH, float NdotH,
    float  TdotV, float BdotV, float NdotV,
    float  TdotL, float BdotL, float NdotL,
    float  VdotH,
    float3 F0)
{
  float  D = GGX_NDF_Anisotropic(anisotropicRoughness, TdotH, BdotH, NdotH);
  float  V = SmithGGX_Visibility_Anisotropic(anisotropicRoughness,
               TdotV, BdotV, NdotV, TdotL, BdotL, NdotL);
  float3 F = SchlickFresnel(F0, VdotH);

  return D * V * F;
}

// -- 2.7d.  Anisotropic Dual-Lobe GGX Specular (Callisto-compatible) ---------
//
// Two anisotropic GGX lobes combined with a secondary weight, matching the
// dual-lobe pattern from the Callisto BRDF but with full tangent-space
// anisotropy support.
//
float3 DualLobeGGX_Anisotropic(
    float2 anisoRoughness1,
    float2 anisoRoughness2,
    float  TdotH, float BdotH, float NdotH,
    float  TdotV, float BdotV, float NdotV,
    float  TdotL, float BdotL, float NdotL,
    float  VdotH,
    float3 F0_1, float3 F0_2,
    float  secondaryWeight = 0.5)
{
  float3 lobe1 = GGX_Specular_Anisotropic(anisoRoughness1,
      TdotH, BdotH, NdotH, TdotV, BdotV, NdotV, TdotL, BdotL, NdotL, VdotH, F0_1);
  float3 lobe2 = GGX_Specular_Anisotropic(anisoRoughness2,
      TdotH, BdotH, NdotH, TdotV, BdotV, NdotV, TdotL, BdotL, NdotL, VdotH, F0_2);
  return lobe1 + lobe2 * secondaryWeight;
}

// ============================================================================
// 2.8  Thin Film Iridescence Fresnel
// ----------------------------------------------------------------------------
// Ported from NVIDIA RTX Remix (MIT license), adapted to fp32 HLSL.
//
// Simulates wave interference in a thin dielectric film coating a surface,
// producing view-angle-dependent color shifts (iridescence / soap bubbles /
// oil films / coated metals).
//
// The model evaluates Fresnel amplitude coefficients for S and P polarized
// light at each interface (air→film, film→substrate), then combines them
// with a phase term based on optical path difference through the film,
// evaluated at the center wavelengths of the sRGB primaries.
//
// [Gamedev.net, "Thin Film Interference for Computer Graphics"]
// [RTX Remix, brdf.slangh]
// ============================================================================

// Approximate center wavelengths (in nanometers) for sRGB primaries.
static const float3 kSRGBPrimaryWavelengths = float3(630.0, 532.0, 467.0);

// -- 2.8a.  Fresnel Amplitude Coefficients -----------------------------------
// https://en.wikipedia.org/wiki/Fresnel_equations

float FresnelAmplitude_RS(
    float n1, float n2,
    float cosI, float cosT)
{
  float x = n1 * cosI;
  float y = n2 * cosT;
  return (x - y) / (x + y);
}

float FresnelAmplitude_RP(
    float n1, float n2,
    float cosI, float cosT)
{
  float x = n2 * cosI;
  float y = n1 * cosT;
  return (x - y) / (x + y);
}

float FresnelAmplitude_TS(
    float n1, float n2,
    float cosI, float cosT)
{
  float x = n1 * cosI;
  float y = n2 * cosT;
  return (2.0 * x) / (x + y);
}

float FresnelAmplitude_TP(
    float n1, float n2,
    float cosI, float cosT)
{
  float x = n1 * cosI;
  float y = n2 * cosI;
  float z = n1 * cosT;
  return (2.0 * x) / (y + z);
}

// -- 2.8b.  Refraction Cosine Angle ------------------------------------------
//
// Given a relative refractive index and incident cosine, computes the cosine
// of the refracted angle via Snell's law.  Returns false on total internal
// reflection (TIR).
//
bool RefractionCosineAngle(float relativeIoR, float cosIncident, out float cosRefracted)
{
  float sinSq = relativeIoR * relativeIoR * (1.0 - cosIncident * cosIncident);
  cosRefracted = sqrt(max(1.0 - sinSq, 0.0));
  return sinSq <= 1.0;
}

// -- 2.8c.  TIR-Aware Schlick Fresnel ----------------------------------------
//
// Schlick Fresnel for translucent dielectrics that handles total internal
// reflection when entering from a denser medium.
// [RTX Remix, brdf.slangh]
//
float TranslucentSchlickFresnel(float baseReflectivity, float VdotH)
{
  float oneMinusVdotH = 1.0 - VdotH;
  float pow5 = oneMinusVdotH * oneMinusVdotH;
  pow5 *= pow5 * oneMinusVdotH;
  return baseReflectivity + (1.0 - baseReflectivity) * pow5;
}

float TranslucentSchlickFresnelTIR(
    float baseReflectivity,
    float relativeIoR,
    float VdotH)
{
  float modifiedVdotH = VdotH;

  if (relativeIoR > 1.0)
  {
    float cosRefracted;
    if (!RefractionCosineAngle(relativeIoR, VdotH, cosRefracted))
      return 1.0;  // total internal reflection
    modifiedVdotH = cosRefracted;
  }

  return TranslucentSchlickFresnel(baseReflectivity, modifiedVdotH);
}

// -- 2.8d.  Thin Film Fresnel ------------------------------------------------
//
// Evaluates the reflectance of a thin dielectric film with wave interference.
//
// Parameters:
//   outsideIoR  – refractive index of the exterior medium (1.0 for air)
//   layerIoR    – refractive index of the thin film layer (~1.5 typical)
//   insideIoR   – refractive index of the substrate beneath the film
//   thickness   – film thickness in nanometers
//   VdotH       – cos(θ) between view direction and microfacet normal
//
// Returns:  per-channel (R,G,B) Fresnel reflectance with iridescence.
//
float3 ThinFilmFresnel(
    float outsideIoR,
    float layerIoR,
    float insideIoR,
    float thickness,
    float VdotH)
{
  // Early out for parallel viewing angles
  if (VdotH <= 0.0) return float3(1, 1, 1);

  // Relative refractive indices
  float outsideRelIoR = outsideIoR / layerIoR;
  float layerRelIoR   = layerIoR   / insideIoR;

  // Refracted cosines at each interface via Snell's law
  float cosRefractedOutside;
  if (!RefractionCosineAngle(outsideRelIoR, VdotH, cosRefractedOutside))
    return float3(0, 0, 0);  // TIR at outer interface

  float cosRefractedLayer;
  if (!RefractionCosineAngle(outsideRelIoR, cosRefractedOutside, cosRefractedLayer))
    return float3(0, 0, 0);  // TIR at inner interface

  // ---- Fresnel amplitude coefficients at each interface -------------------

  // Reflection amplitudes (film ↔ outside, film ↔ inside)
  float alphaS = FresnelAmplitude_RS(layerIoR, outsideIoR, cosRefractedOutside, VdotH)
               * FresnelAmplitude_RS(layerIoR, insideIoR,  cosRefractedOutside, cosRefractedLayer);
  float alphaP = FresnelAmplitude_RP(layerIoR, outsideIoR, cosRefractedOutside, VdotH)
               * FresnelAmplitude_RP(layerIoR, insideIoR,  cosRefractedOutside, cosRefractedLayer);

  // Transmission amplitudes (outside → film → inside)
  float betaS  = FresnelAmplitude_TS(outsideIoR, layerIoR, VdotH, cosRefractedOutside)
               * FresnelAmplitude_TS(layerIoR,   insideIoR, cosRefractedOutside, cosRefractedLayer);
  float betaP  = FresnelAmplitude_TP(outsideIoR, layerIoR, VdotH, cosRefractedOutside)
               * FresnelAmplitude_TP(layerIoR,   insideIoR, cosRefractedOutside, cosRefractedLayer);

  // ---- Wave phase (optical path difference through the thin film) ---------

  // Phase shift: π when reflecting off a denser medium, 0 otherwise
  float phaseShift = 0.0;
  phaseShift += (layerIoR > outsideIoR) ? 0.0 : 3.14159265;
  phaseShift += (layerIoR > insideIoR)  ? 0.0 : 3.14159265;

  // Optical path difference → per-wavelength phase
  float OPD = 2.0 * layerIoR * thickness * cosRefractedOutside;
  float3 phase = (6.28318530 / kSRGBPrimaryWavelengths) * OPD + float3(phaseShift, phaseShift, phaseShift);

  // ---- Wave-interfered transmission per sRGB primary ----------------------

  float alphaSsq = alphaS * alphaS;
  float alphaPsq = alphaP * alphaP;
  float betaSsq  = betaS  * betaS;
  float betaPsq  = betaP  * betaP;

  float3 cosPhase = cos(phase);

  float3 transS = betaSsq / (alphaSsq - 2.0 * alphaS * cosPhase + 1.0);
  float3 transP = betaPsq / (alphaPsq - 2.0 * alphaP * cosPhase + 1.0);

  // ---- Beam geometry change + unpolarized combination ---------------------

  float beamRatio = (insideIoR * cosRefractedLayer) / (outsideIoR * VdotH);
  float3 transmission = beamRatio * (transS + transP) * 0.5;

  return saturate(1.0 - transmission);
}

// -- 2.8e.  Thin Surface Geometric Series ------------------------------------
//
// Evaluate the infinite series of internal reflections in a thin surface.
// [Kulla 2017, "Revisiting Physically Based Shading at Imageworks"]
// [RTX Remix, brdf.slangh]
//
float3 ThinReflectionGeometricSeries(
    float outsideFresnel, float insideFresnel, float3 attenuation)
{
  float3 attSq = attenuation * attenuation;
  float3 geomSeries = 1.0 / (1.0 - attSq * insideFresnel * insideFresnel);
  return outsideFresnel
       + insideFresnel * attSq
         * (1.0 - outsideFresnel) * (1.0 - insideFresnel)
         * geomSeries;
}

float3 ThinTransmissionGeometricSeries(
    float outsideFresnel, float insideFresnel, float3 attenuation)
{
  float3 geomSeries = 1.0 / (1.0 - attenuation * attenuation * insideFresnel * insideFresnel);
  return attenuation
       * (1.0 - outsideFresnel) * (1.0 - insideFresnel)
       * geomSeries;
}

// ============================================================================
// 2.9  Volumetric & Phase Function Helpers
// ----------------------------------------------------------------------------
// Ported from NVIDIA RTX Remix (MIT license), adapted to fp32 HLSL.
// ============================================================================

// -- 2.9a.  Henyey-Greenstein Phase Function ---------------------------------
//
// Evaluates the angular distribution of scattered light in a participating
// medium.  The anisotropy parameter g controls forward/backward bias:
//   g =  0  — isotropic scattering
//   g → +1  — strongly forward-scattering
//   g → -1  — strongly backward-scattering
//
// [Henyey & Greenstein 1941, "Diffuse Radiation in the Galaxy"]
// [RTX Remix, brdf.slangh]
//
float HenyeyGreensteinPhase(float anisotropy, float VdotL)
{
  float g2    = anisotropy * anisotropy;
  float num   = 1.0 - g2;
  float denom = pow(1.0 + g2 - 2.0 * anisotropy * VdotL, 1.5);
  return (1.0 / (4.0 * 3.14159265)) * ::renodx::math::DivideSafe(num, denom, 1.0);
}

// -- 2.9b.  Normal Blending (Reoriented Normal Mapping) ----------------------
//
// Blends two normal vectors in tangent space using reoriented normal mapping.
// Produces better results than simple normal averaging for detail normal maps.
//
// [Barré-Brisebois & Hill 2012, "Blending in Detail"]
// [RTX Remix, brdf.slangh]
//
float3 NormalBlendRNM(float3 baseNormal, float3 detailNormal)
{
  float3 n1 = baseNormal + float3(0, 0, 1);
  float3 n2 = detailNormal * float3(-1, -1, 1);
  return normalize(n1 * ::renodx::math::DivideSafe(dot(n1, n2), n1.z, 1.0) - n2);
}

// ============================================================================
// 2.10  RDX BRDF — Unified Rasterisation BRDF Package
// ----------------------------------------------------------------------------
// Single entry point that combines every rasterisation BRDF component in
// this file into one ready-to-call function:
//
//   Diffuse:   Hammon 2017 multi-scatter energy × Proxima 2023 distance-stability
//   Specular:  Dual-lobe GGX  (isotropic or anisotropic)
//              × Callisto 2023 modified Fresnel  (or thin film iridescence)
//              × Kulla-Conty multi-scatter energy compensation
//   Framework: Callisto c₁ (Fresnel/retroreflection) + c₂ (smooth terminator)
//   Material:  Metallic-workflow F0 derivation  (or explicit F0 override)
//
// Two calling conventions are provided:
//
//   ● Minimal — one line, returns combined float3 directly:
//       float3 color = RDX_BRDF(N, V, L, albedo, roughness, metallic);
//
//   ● Full control — configure every parameter through RDX_BRDFParams:
//       RDX_BRDFParams p = RDX_DefaultParams();
//       p.N = normal;  p.V = viewDir;  p.L = lightDir;
//       p.albedo = baseColor;  p.roughness = rough;  p.metallic = metal;
//       p.anisotropy = 0.5;
//       p.enableThinFilm = 1.0;  p.thinFilmThickness = 500.0;
//       RDX_BRDFResult r = RDX_BRDF(p);
//       output = r.combined * lightColor;
//
// Output struct fields:
//   .diffuse  — diffuse contribution  (NdotL pre-applied, pre-c₂)
//   .specular — specular contribution (NdotL pre-applied, pre-c₂)
//   .combined — (diffuse + specular) × c₂   (multiply by lightColor)
// ============================================================================

// -- 2.10a.  Parameter & Result Structs --------------------------------------

struct RDX_BRDFParams {
  // ---- Geometry (required — must be set by caller) ----
  float3 N;          // Surface normal (normalised)
  float3 V;          // View direction (normalised, toward camera)
  float3 L;          // Light direction (normalised, toward light)
  float3 T;          // Tangent  (normalised, for anisotropy; default +X)
  float3 B;          // Bitangent (normalised, for anisotropy; default +Y)

  // ---- Material ----
  float3 albedo;     // Base colour (linear RGB)
  float  roughness;  // Perceptual roughness [0, 1]
  float  metallic;   // Metallic [0, 1]
  float  anisotropy; // Anisotropy [-1, 1], 0 = isotropic
  float  opacity;    // Opacity [0, 1], 1 = fully opaque

  // ---- F0 Override (optional) ----
  float  useCustomF0; // 0 = metallic workflow, > 0 = use customF0 field
  float3 customF0;    // Custom base reflectivity (only when useCustomF0 > 0)

  // ---- Callisto: Base Tier (slide 98) ----
  float  rho_f;      // Diffuse Fresnel intensity         [0, 256]
  float  rho_r;      // Retroreflection intensity          [0, 256]
  float  n_f;        // Diffuse Fresnel falloff            [0, 1]
  float  n_r;        // Retroreflection falloff            [0, 1]
  float  o;          // Smooth terminator intensity        [-1, 1]

  // ---- Callisto: Advanced Tier ----
  float  n_s;                    // Specular Fresnel falloff     [0, 1]
  float  dualSpecRoughnessScale; // 2nd lobe roughness mult.    [> 0]
  float  dualSpecOpacity;        // 2nd lobe blend weight        [0, 1]

  // ---- Callisto: Full Tier ----
  float  m_f;        // Diffuse Fresnel tangent falloff    [0, 1]
  float  m_r;        // Retroreflection tangent falloff    [0, 1]
  float  p;          // Smooth terminator length           [0, 1]

  // ---- Thin Film Iridescence (optional) ----
  float  enableThinFilm;      // 0 = off, > 0 = on
  float  thinFilmThickness;   // Film thickness (nm)
  float  thinFilmOutsideIoR;  // Exterior medium IoR (1.0 = air)
  float  thinFilmLayerIoR;    // Film layer IoR (~1.5 typical)
  float  thinFilmInsideIoR;   // Substrate IoR

  // ---- RT-only: Subsurface Scattering (ignored by raster RDX_BRDF) ----
  float  enableSSS;                  // 0 = off, > 0 = on
  float3 sssAttenuationCoefficient;  // Absorption per unit distance
  float  sssMeasurementDistance;     // Nominal slab thickness
  float3 sssSingleScatterAlbedo;     // Scattering albedo
  float  sssVolumetricAnisotropy;    // HG phase g [-1, 1]
  float  sssNegNdotL;               // dot(-N, L) for back-face transmission

  // ---- RT-only: VNDF options ----
  float  useBoundedVNDF;  // 0 = standard VNDF, > 0 = Eto 2023 bounded
};

struct RDX_BRDFResult {
  float3 diffuse;    // Diffuse radiance  (NdotL pre-applied, pre-c₂)
  float3 specular;   // Specular radiance (NdotL pre-applied, pre-c₂)
  float3 combined;   // (diffuse + specular) × c₂
};

// -- 2.10b.  Default Parameter Factory ----------------------------------------
//
// Returns an RDX_BRDFParams with sensible defaults for all fields.
// The caller MUST set N, V, L, albedo, roughness, and metallic at minimum.
//
RDX_BRDFParams RDX_DefaultParams()
{
  RDX_BRDFParams p;

  // Geometry — placeholders, must be overwritten
  p.N = float3(0, 0, 1);
  p.V = float3(0, 0, 1);
  p.L = float3(0, 0, 1);
  p.T = float3(1, 0, 0);
  p.B = float3(0, 1, 0);

  // Material
  p.albedo     = float3(0.5, 0.5, 0.5);
  p.roughness  = 0.5;
  p.metallic   = 0.0;
  p.anisotropy = 0.0;
  p.opacity    = 1.0;

  // F0 override
  p.useCustomF0 = 0.0;
  p.customF0    = float3(0.04, 0.04, 0.04);

  // Callisto Base
  p.rho_f = 1.0;
  p.rho_r = 1.0;
  p.n_f   = 0.75;
  p.n_r   = 0.75;
  p.o     = 0.0;

  // Callisto Advanced
  p.n_s                    = 0.5;
  p.dualSpecRoughnessScale = 2.0;
  p.dualSpecOpacity        = 1.0;

  // Callisto Full
  p.m_f = 0.75;
  p.m_r = 0.75;
  p.p   = 0.5;

  // Thin Film
  p.enableThinFilm     = 0.0;
  p.thinFilmThickness  = 400.0;
  p.thinFilmOutsideIoR = 1.0;
  p.thinFilmLayerIoR   = 1.5;
  p.thinFilmInsideIoR  = 1.0;

  // RT: SSS
  p.enableSSS                 = 0.0;
  p.sssAttenuationCoefficient = float3(1, 1, 1);
  p.sssMeasurementDistance    = 0.1;
  p.sssSingleScatterAlbedo   = float3(0.8, 0.8, 0.8);
  p.sssVolumetricAnisotropy  = 0.0;
  p.sssNegNdotL              = 0.0;

  // RT: VNDF
  p.useBoundedVNDF = 0.0;

  return p;
}

// -- 2.10c.  RDX BRDF Evaluation (full) --------------------------------------

RDX_BRDFResult RDX_BRDF(RDX_BRDFParams params)
{
  // ---- Dot products -------------------------------------------------------
  float3 H     = normalize(params.V + params.L);
  float  NdotL = dot(params.N, params.L);
  float  NdotV = max(dot(params.N, params.V), 1e-5);
  float  NdotH = saturate(dot(params.N, H));
  float  VdotH = saturate(dot(params.V, H));
  float  VdotL = dot(params.V, params.L);

  float sNdotL     = max(NdotL, 0.0);
  float sNdotLSpec = max(sNdotL, 1e-5);

  // ---- Material derivation ------------------------------------------------
  float3 F0;
  if (params.useCustomF0 > 0.0)
    F0 = params.customF0;
  else
    F0 = CalcBaseReflectivity(params.albedo, params.metallic, params.opacity);

  float3 adjustedAlbedo = AlbedoToAdjustedAlbedo(
      params.albedo, params.metallic, params.opacity);

  // ---- Roughness ----------------------------------------------------------
  float  isoRoughness;     // linear α  = perceptual²
  float2 anisoRoughness;   // (αx, αy)
  CalcRoughness(params.roughness, params.anisotropy,
                isoRoughness, anisoRoughness);

  // ---- Callisto framework -------------------------------------------------
  float c2 = CallistoSmoothTerminator(NdotL, VdotH, NdotH, params.o, params.p);
  float c1 = CallistoDiffuseC1(
      VdotH, NdotH,
      params.rho_f, params.n_f, params.m_f,
      params.rho_r, params.n_r, params.m_r);

  // ---- Diffuse: Hammon + Proxima (NdotL pre-applied) ----------------------
  // HammonProximaDiffuse expects perceptual roughness.
  float3 diffuse = HammonProximaDiffuse(
      sNdotL, NdotV, NdotH, VdotH, VdotL,
      params.roughness, adjustedAlbedo);

  // ---- Fresnel: Callisto Schlick or thin film iridescence -----------------
  float3 F_spec;
  if (params.enableThinFilm > 0.0) {
    F_spec = ThinFilmFresnel(
        params.thinFilmOutsideIoR, params.thinFilmLayerIoR,
        params.thinFilmInsideIoR,  params.thinFilmThickness, VdotH);
  } else {
    F_spec = CallistoSpecularFresnel(F0, VdotH, params.n_s);
  }

  // ---- Specular: dual-lobe (isotropic or anisotropic) ---------------------
  float3 spec1, spec2;

  // Secondary-lobe perceptual roughness (for multi-scatter + alpha)
  float percRough2 = saturate(params.roughness * params.dualSpecRoughnessScale);

  if (abs(params.anisotropy) > 1e-4) {
    // Tangent-frame dot products
    float TdotH = dot(params.T, H);
    float BdotH = dot(params.B, H);
    float TdotV = dot(params.T, params.V);
    float BdotV = dot(params.B, params.V);
    float TdotL = dot(params.T, params.L);
    float BdotL = dot(params.B, params.L);

    // Primary lobe
    float  D1 = GGX_NDF_Anisotropic(anisoRoughness, TdotH, BdotH, NdotH);
    float  V1 = SmithGGX_Visibility_Anisotropic(
                    anisoRoughness,
                    TdotV, BdotV, NdotV, TdotL, BdotL, sNdotLSpec);
    spec1 = D1 * V1 * F_spec;

    // Secondary lobe
    float  alpha2 = percRough2 * percRough2;
    float2 anisoR2 = IsotropicToAnisotropicRoughness(alpha2, params.anisotropy);
    anisoR2 = max(anisoR2, float2(1e-4, 1e-4));
    float  D2 = GGX_NDF_Anisotropic(anisoR2, TdotH, BdotH, NdotH);
    float  V2 = SmithGGX_Visibility_Anisotropic(
                    anisoR2,
                    TdotV, BdotV, NdotV, TdotL, BdotL, sNdotLSpec);
    spec2 = D2 * V2 * F_spec;
  } else {
    // Primary lobe (isotropic)
    float alpha1 = max(isoRoughness, 5e-5);
    float  D1 = GGX_NDF(NdotH, alpha1);
    float  V1 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha1);
    spec1 = D1 * V1 * F_spec;

    // Secondary lobe
    float alpha2 = max(percRough2 * percRough2, 5e-5);
    float  D2 = GGX_NDF(NdotH, alpha2);
    float  V2 = SmithGGX_Visibility(NdotV, sNdotLSpec, alpha2);
    spec2 = D2 * V2 * F_spec;
  }

  // ---- Multi-scatter compensation (perceptual roughness) ------------------
  spec1 *= MultiScatterCompensation(NdotV, sNdotLSpec, params.roughness, F0);
  spec2 *= MultiScatterCompensation(NdotV, sNdotLSpec, percRough2, F0);

  float3 specular = spec1 + spec2 * params.dualSpecOpacity;

  // ---- Compose ------------------------------------------------------------
  RDX_BRDFResult result;
  result.diffuse  = c1 * diffuse;
  result.specular = specular * sNdotL;
  result.combined = (result.diffuse + result.specular) * c2;

  return result;
}

// -- 2.10d.  RDX BRDF Convenience Overload ------------------------------------
//
// Minimal one-line replacement for a game's existing BRDF:
//   float3 color = RDX_BRDF(N, V, L, albedo, roughness, metallic);
//
// Uses default Callisto parameters, no anisotropy, no thin film.
// Multiply the return value by lightColor × lightIntensity.
//
float3 RDX_BRDF(
    float3 N, float3 V, float3 L,
    float3 albedo, float roughness, float metallic)
{
  RDX_BRDFParams p = RDX_DefaultParams();
  p.N = N;  p.V = V;  p.L = L;
  p.albedo    = albedo;
  p.roughness = roughness;
  p.metallic  = metallic;

  return RDX_BRDF(p).combined;
}

// ############################################################################
//
//   PART III — RAY TRACING / PATH TRACING BRDF
//
//   Functions in this section require stochastic ray generation or Monte
//   Carlo integration.  They are NOT usable in standard rasterisation
//   pipelines — only in ray tracing / path tracing renderers.
//
//   Ported from NVIDIA RTX Remix (MIT license), adapted to fp32 HLSL.
//
// ############################################################################

// ============================================================================
// 3.1  Standalone GGX Shadowing (G1) — Smith Anisotropic
// ----------------------------------------------------------------------------
// The single-direction GGX shadowing function, used as a building block for:
//   • VNDF evaluation  (D_v = G1 * max(VdotH,0) * D / NdotV)
//   • VNDF PDF         (pdf = D_v / (4 * VdotH))
//
// This differs from the *combined* height-correlated G2/(4·NdotV·NdotL)
// visibility in section 2.7b which is designed for rasterisation-side
// specular evaluation.
//
// [Heitz 2014, "Understanding the Masking-Shadowing Function in Microfacet
//  Based BRDFs"]
//
// Augmented with a lower-bound scaling factor `k` for bounded VNDF sampling
// [Eto 2023, "Bounded VNDF Sampling for Smith-GGX Reflections"]
//
// Parameters:
//   anisotropicRoughness  – float2(alphaX, alphaY)
//   tangentDotDir         – dot(tangent, direction)
//   bitangentDotDir       – dot(bitangent, direction)
//   normalDotDir          – dot(normal, direction)
//   k                     – bounded VNDF scalar (1.0 = standard, no bound)
//
// Returns: G1(direction) — unitless fraction in [0, 2].
// ============================================================================

float GGX_Shadowing_G1(
    float2 anisotropicRoughness,
    float  tangentDotDir,
    float  bitangentDotDir,
    float  normalDotDir,
    float  k = 1.0)
{
  float3 denominatorVector = float3(
      normalDotDir,
      anisotropicRoughness.x * tangentDotDir,
      anisotropicRoughness.y * bitangentDotDir);
  float sqrtDenominator = length(denominatorVector);

  // Bounded VNDF lower-bound logic [Eto 2023, Listing 2]:
  // When k=1 (default), b = normalDotDir and function reduces to standard G1.
  float b = (normalDotDir > 0.0) ? (k * normalDotDir) : normalDotDir;

  return ::renodx::math::DivideSafe(
      2.0 * normalDotDir,
      b + sqrtDenominator,
      5e-5);
}

// ============================================================================
// 3.2  Bounded VNDF Lower-Bound Scalar
// ----------------------------------------------------------------------------
// Computes the scaling parameter `k` used to tighten the bounding hemisphere
// for bounded VNDF sampling.  Reduces wasted samples at grazing angles.
//
// [Eto 2023, "Bounded VNDF Sampling for Smith-GGX Reflections", Listing 1]
//
// NOTE: RTX Remix's exact implementation of calcBoundedVNDFLowerBoundScalar
// resides outside brdf.slangh
// This implementation is derived from the Eto 2023 paper itself and produces
// the correct qualitative behaviour (k = 1 at normal incidence, k < 1 at
// grazing), but the precise formula may differ from Remix's version.
//
// Parameters:
//   anisotropicRoughness – float2(alphaX, alphaY)
//   viewTS               – view direction in tangent space (t, b, n)
//
// Returns: scalar k ∈ (0,1] for use in G1 / VNDF PDF.
// ============================================================================

float BoundedVNDF_LowerBoundScalar(
    float2 anisotropicRoughness,
    float3 viewTS)
{
  // Stretch the view into the roughness-scaled ellipsoid space
  float3 stretched = float3(
      anisotropicRoughness.x * viewTS.x,
      anisotropicRoughness.y * viewTS.y,
      viewTS.z);
  float lenSq = dot(stretched, stretched);
  float len   = sqrt(lenSq);

  // k = 2·viewTS.z / (len + viewTS.z)
  // Gives k ≈ 1 at normal incidence, k < 1 at grazing angles.
  float a = len + viewTS.z;
  return ::renodx::math::DivideSafe(2.0 * viewTS.z, a, 1.0);
}

// ============================================================================
// 3.3  GGX Visible Normal Distribution (D_v)
// ----------------------------------------------------------------------------
// Evaluates the VNDF — the microfacet normal distribution *visible* from the
// output (view) direction.  This is the ideal importance-sampling distribution
// for GGX specular in a path tracer.
//
// D_v(h) = G1(v) · max(VdotH, 0) · D(h) / NdotV
//
// [Heitz 2014, "Importance Sampling Microfacet-Based BSDFs Using the
//  Distribution of Visible Normals"]
//
// Parameters:
//   anisotropicRoughness – float2(alphaX, alphaY)
//   TdotV, BdotV, NdotV – tangent-frame dot products with view direction
//   TdotH, BdotH, NdotH – tangent-frame dot products with half-vector
//   VdotH                – dot(view, halfVec)
//   k                    – bounded VNDF scalar (default 1.0)
//
// Returns:  D_v(h) — probability density per steradian on the hemisphere.
// ============================================================================

float GGX_VisibleNormalDistribution(
    float2 anisotropicRoughness,
    float  TdotV, float BdotV, float NdotV,
    float  TdotH, float BdotH, float NdotH,
    float  VdotH,
    float  k = 1.0)
{
  // G1 * max(VdotH, 0)
  float g1 = GGX_Shadowing_G1(anisotropicRoughness,
      TdotV, BdotV, NdotV, k);

  // Anisotropic GGX NDF — reuses §2.7a pattern but inlined for precision
  float axay = anisotropicRoughness.x * anisotropicRoughness.y;
  float3 dVec = float3(anisotropicRoughness.y * TdotH,
                        anisotropicRoughness.x * BdotH,
                        axay * NdotH);
  float dDot = dot(dVec, dVec);
  float body = ::renodx::math::DivideSafe(axay, dDot, 1e-30);
  float D = (1.0 / 3.14159265) * axay * body * body;

  float numerator = g1 * max(0.0, VdotH) * D;
  return ::renodx::math::DivideSafe(numerator, NdotV, 5e-5);
}

// ============================================================================
// 3.4  VNDF Reflection PDF
// ----------------------------------------------------------------------------
// Computes the probability density of sampling a reflected direction via VNDF
// importance sampling of GGX microfacets.
//
// pdf = D_v(h) / (4 · VdotH)
//
// This is the correct PDF for Monte Carlo weighting when the *half-vector*
// is sampled from the VNDF and then reflected to obtain the light direction.
//
// [Heitz 2014, "Importance Sampling Microfacet-Based BSDFs Using the
//  Distribution of Visible Normals"]
//
// Parameters:  same as GGX_VisibleNormalDistribution, plus optional k.
//
// Returns:  PDF value (probability per steradian in reflected-direction space).
// ============================================================================

float GGX_VNDF_ReflectionPdf(
    float2 anisotropicRoughness,
    float  TdotV, float BdotV, float NdotV,
    float  TdotH, float BdotH, float NdotH,
    float  VdotH,
    float  k = 1.0)
{
  float Dv = GGX_VisibleNormalDistribution(
      anisotropicRoughness,
      TdotV, BdotV, NdotV,
      TdotH, BdotH, NdotH,
      VdotH, k);

  return ::renodx::math::DivideSafe(Dv, 4.0 * VdotH, 5e-5);
}

// ============================================================================
// 3.5  Bounded VNDF Reflection PDF
// ----------------------------------------------------------------------------
// Same as §3.4 but automatically computes k from the view direction in
// tangent space for bounded VNDF sampling.
//
// [Eto 2023, "Bounded VNDF Sampling for Smith-GGX Reflections"]
//
// Parameters:
//   anisotropicRoughness – float2(alphaX, alphaY)
//   TdotV, BdotV, NdotV – tangent-frame view dots
//   TdotH, BdotH, NdotH – tangent-frame half-vector dots
//   VdotH                – dot(view, halfVec)
//
// Returns:  PDF value for bounded VNDF sampling.
// ============================================================================

float GGX_BoundedVNDF_ReflectionPdf(
    float2 anisotropicRoughness,
    float  TdotV, float BdotV, float NdotV,
    float  TdotH, float BdotH, float NdotH,
    float  VdotH)
{
  float k = BoundedVNDF_LowerBoundScalar(
      anisotropicRoughness,
      float3(TdotV, BdotV, NdotV));

  return GGX_VNDF_ReflectionPdf(
      anisotropicRoughness,
      TdotV, BdotV, NdotV,
      TdotH, BdotH, NdotH,
      VdotH, k);
}

// ============================================================================
// 3.6  Hanrahan Single-Scattering Diffuse Transmission
// ----------------------------------------------------------------------------
// First-order forward-scattering approximation for thin opaque surfaces.
// Models diffuse light transmission through a single virtual volume layer
// using Beer-Lambert attenuation and the Henyey-Greenstein phase function.
//
// Useful for thin translucent materials (skin, leaves, paper, wax) in a
// path tracer where rays can exit the opposite side of a thin surface.
//
// NOT usable in rasterization — requires knowledge of the transmitted ray
// direction, per-surface attenuation distance, and stochastic evaluation.
//
// [P. Hanrahan 1993, "Reflection from Layered Surfaces due to Subsurface
//  Scattering", Chapter 5.1]
//
// Parameters:
//   baseReflectivity       – F0 (Fresnel at normal incidence, RGB)
//   attenuationCoefficient – absorption per unit distance (RGB)
//   measurementDistance     – nominal thickness for attenuation (scalar)
//   singleScatterAlbedo    – scattering albedo of the volume (RGB)
//   volumetricAnisotropy   – Henyey-Greenstein g parameter [-1,1]
//   NdotV                  – dot(normal, viewDir)                 (positive)
//   negNdotL               – dot(-normal, lightDir)  [= NdotL on back face] (positive)
//   VdotL                  – dot(view, light)
//
// Returns:  RGB throughput for the single-scatter transmission path.
// ============================================================================

float3 HanrahanSingleScatterDiffuseTransmission(
    float3 baseReflectivity,
    float3 attenuationCoefficient,
    float  measurementDistance,
    float3 singleScatterAlbedo,
    float  volumetricAnisotropy,
    float  NdotV,
    float  negNdotL,
    float  VdotL)
{
  // Derive IoR from luminance of base reflectivity
  float baseReflLum = dot(baseReflectivity, float3(0.2126, 0.7152, 0.0722));
  float ior = BaseReflectivityToIoR(1.0, baseReflLum);
  float insideRelativeIoR = ior;  // ior / 1.0 (vacuum)

  // Fresnel terms for outside and inside interfaces
  // Outside: viewing from air into surface — no TIR possible, use simple Schlick
  float outsideFresnel = TranslucentSchlickFresnel(baseReflLum, NdotV);
  // Inside: exiting from denser medium — TIR is possible
  float insideFresnel  = TranslucentSchlickFresnelTIR(baseReflLum, insideRelativeIoR, negNdotL);

  // Attenuation through the thin slab from both sides
  float attDist = measurementDistance * measurementDistance;
  float3 firstAtten  = EvalBeerLambertAttenuation(attenuationCoefficient,
      attDist * ::renodx::math::DivideSafe(1.0, NdotV, 5e-5));
  float3 secondAtten = EvalBeerLambertAttenuation(attenuationCoefficient,
      attDist * ::renodx::math::DivideSafe(1.0, negNdotL, 5e-5));

  // Early out: backface or total internal reflection
  if (negNdotL < 5e-5 || insideFresnel >= 1.0)
    return float3(0.0, 0.0, 0.0);

  float phase = HenyeyGreensteinPhase(volumetricAnisotropy, VdotL);

  if ((NdotV - negNdotL) >= 5e-5)
  {
    // Standard first-order forward-scatter equation
    return singleScatterAlbedo * (1.0 - outsideFresnel) * (1.0 - insideFresnel)
         * ::renodx::math::DivideSafe(
               NdotV,
               NdotV - negNdotL,
               5e-5)
         * phase * (firstAtten - secondAtten);
  }
  else
  {
    // Derivative form: handles singularity when NdotV ≈ negNdotL
    return singleScatterAlbedo * (1.0 - outsideFresnel) * (1.0 - insideFresnel)
         * ::renodx::math::DivideSafe(
               attenuationCoefficient * attDist,
               negNdotL,
               5e-5)
         * phase * secondAtten;
  }
}

// ============================================================================
// 3.7  RDX BRDF RT — Unified Ray Tracing / Path Tracing BRDF Package
// ----------------------------------------------------------------------------
// Extends the rasterisation RDX BRDF (§2.10) with ray-tracing-specific
// outputs that require stochastic evaluation:
//
//   specularPdf  — VNDF probability density for Monte Carlo weighting
//   transmission — Hanrahan single-scatter diffuse transmission (SSS)
//
// Uses the same RDX_BRDFParams input as the raster version; the RT-specific
// fields (enableSSS, useBoundedVNDF, sss*, etc.) are read here but ignored
// by the rasterisation RDX_BRDF in §2.10.
//
// Usage:
//   RDX_BRDFParams p = RDX_DefaultParams();
//   p.N = normal;  p.V = viewDir;  p.L = lightDir;
//   p.albedo = baseColor;  p.roughness = rough;  p.metallic = metal;
//   p.useBoundedVNDF = 1.0;
//   p.enableSSS = 1.0;
//   p.sssAttenuationCoefficient = float3(0.5, 0.3, 0.1);
//   p.sssMeasurementDistance = 0.05;
//   p.sssNegNdotL = max(dot(-normal, lightDir), 0.0);
//   RDX_BRDFResult_RT r = RDX_BRDF_RT(p);
//   output = r.combined * lightColor + r.transmission * lightColor;
//
// Output fields:
//   .diffuse      — same as raster output
//   .specular     — same as raster output
//   .combined     — same as raster output
//   .specularPdf  — VNDF PDF for importance-sampled specular weighting
//   .transmission — Hanrahan SSS throughput (float3(0) when SSS disabled)
// ============================================================================

// -- 3.7a.  RT Result Struct -------------------------------------------------

struct RDX_BRDFResult_RT {
  float3 diffuse;       // Diffuse radiance  (NdotL pre-applied, pre-c₂)
  float3 specular;      // Specular radiance (NdotL pre-applied, pre-c₂)
  float3 combined;      // (diffuse + specular) × c₂
  float  specularPdf;   // VNDF probability density for MC weighting
  float3 transmission;  // Hanrahan SSS throughput (0 if disabled)
};

// -- 3.7b.  RDX BRDF RT Evaluation -------------------------------------------

RDX_BRDFResult_RT RDX_BRDF_RT(RDX_BRDFParams params)
{
  // ---- Run the full rasterisation BRDF first ------------------------------
  RDX_BRDFResult raster = RDX_BRDF(params);

  RDX_BRDFResult_RT result;
  result.diffuse  = raster.diffuse;
  result.specular = raster.specular;
  result.combined = raster.combined;

  // ---- Recompute dot products needed for RT outputs -----------------------
  float3 H     = normalize(params.V + params.L);
  float  NdotV = max(dot(params.N, params.V), 1e-5);
  float  NdotH = saturate(dot(params.N, H));
  float  VdotH = saturate(dot(params.V, H));

  float TdotH = dot(params.T, H);
  float BdotH = dot(params.B, H);
  float TdotV = dot(params.T, params.V);
  float BdotV = dot(params.B, params.V);

  // Roughness (same as raster evaluation)
  float  isoRoughness;
  float2 anisoRoughness;
  CalcRoughness(params.roughness, params.anisotropy,
                isoRoughness, anisoRoughness);

  // ---- Specular VNDF PDF --------------------------------------------------
  if (params.useBoundedVNDF > 0.0) {
    result.specularPdf = GGX_BoundedVNDF_ReflectionPdf(
        anisoRoughness,
        TdotV, BdotV, NdotV,
        TdotH, BdotH, NdotH,
        VdotH);
  } else {
    result.specularPdf = GGX_VNDF_ReflectionPdf(
        anisoRoughness,
        TdotV, BdotV, NdotV,
        TdotH, BdotH, NdotH,
        VdotH);
  }

  // ---- SSS Transmission ---------------------------------------------------
  if (params.enableSSS > 0.0) {
    float3 F0;
    if (params.useCustomF0 > 0.0)
      F0 = params.customF0;
    else
      F0 = CalcBaseReflectivity(params.albedo, params.metallic, params.opacity);

    result.transmission = HanrahanSingleScatterDiffuseTransmission(
        F0,
        params.sssAttenuationCoefficient,
        params.sssMeasurementDistance,
        params.sssSingleScatterAlbedo,
        params.sssVolumetricAnisotropy,
        NdotV,
        params.sssNegNdotL,
        dot(params.V, params.L));
  } else {
    result.transmission = float3(0.0, 0.0, 0.0);
  }

  return result;
}

}  // namespace rendering
}  // namespace renodx

#endif  // SRC_SHADERS_RENDERING_HLSL_
