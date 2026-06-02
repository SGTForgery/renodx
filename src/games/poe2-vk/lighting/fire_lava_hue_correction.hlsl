#ifndef SRC_GAMES_POE2_VK_FIRE_LAVA_HUE_CORRECTION_HLSL_
#define SRC_GAMES_POE2_VK_FIRE_LAVA_HUE_CORRECTION_HLSL_

#include "../shared.h"

// ============================================================================
// Local Light / Emissive Hue Correction — MB Space (Stockman-Sharp LMS + BT.2020)
// ============================================================================
// Corrects authored pink/magenta lava/fire emissive colour toward warm orange/yellow
// via MacLeod-Boynton chromaticity rotation.
//
// Adapted from Crimson Desert's IntegrateManyLightsUpsample approach.
//
// Reference fire colours in MB space (precomputed from Stockman-Sharp LMS):
//   ~2000K blackbody → warm orange, low S (blue cone), high L/(L+M)
//   Pink/magenta    → elevated S, shifted r from white
//

// BT.709 <-> XYZ matrices
static const float3x3 LAVA_BT709_TO_XYZ_MAT = float3x3(
    0.4123907993f, 0.3575843394f, 0.1804807884f,
    0.2126390059f, 0.7151686788f, 0.0721923154f,
    0.0193308187f, 0.1191947798f, 0.9505321522f);

static const float3x3 LAVA_XYZ_TO_BT709_MAT = float3x3(
    3.2409699419f, -1.5373831776f, -0.4986107603f,
    -0.9692436363f, 1.8759675015f, 0.0415550574f,
    0.0556300797f, -0.2039769589f, 1.0569715142f);

// BT.2020 <-> XYZ matrices
static const float3x3 LAVA_BT2020_TO_XYZ_MAT = float3x3(
    0.6369580483f, 0.1446169036f, 0.1688809752f,
    0.2627002120f, 0.6779980715f, 0.0593017165f,
    0.0000000000f, 0.0280726930f, 1.0609850577f);

static const float3x3 LAVA_XYZ_TO_BT2020_MAT = float3x3(
    1.7166511880f, -0.3556707838f, -0.2533662814f,
    -0.6666843518f, 1.6164812366f, 0.0157685458f,
    0.0176398574f, -0.0427706133f, 0.9421031212f);

// Stockman-Sharp LMS (CIE 170-2)
static const float3x3 LAVA_XYZ_TO_LMS_MAT = float3x3(
    0.2670502842655792f, 0.8471990148492798f, -0.03470416612462053f,
    -0.38706882411220156f, 1.165429935890458f, 0.10302286696614202f,
    0.026727793989083093f, -0.02729131667566509f, 0.5333267257603284f);

// CIE 170-2 MB weighting coefficients
static const float3 LAVA_MB_WEIGHTS = float3(0.68990272f, 0.34832189f, 0.0371597f);

// D65 white point
static const float2 LAVA_WHITE_POINT_D65 = float2(0.31272f, 0.32903f);

// Precomputed fire target direction in MB space (~2000K blackbody)
static const float2 FIRE_TARGET_MB_DIR = float2(0.91618f, -0.40076f);

float lava_DivideSafe(float dividend, float divisor, float fallback) {
  return divisor == 0.f ? fallback : (dividend / divisor);
}

float3 lava_XYZFromxyY(float3 xyY) {
  float3 xyz;
  xyz.xz = float2(xyY.x, (1.f - xyY.x - xyY.y)) / xyY.y * xyY.z;
  xyz.y = xyY.z;
  return xyz;
}

float3 lava_BT2020FromBT709(float3 bt709) {
  return mul(LAVA_XYZ_TO_BT2020_MAT, mul(LAVA_BT709_TO_XYZ_MAT, bt709));
}

float3 lava_BT709FromBT2020(float3 bt2020) {
  return mul(LAVA_XYZ_TO_BT709_MAT, mul(LAVA_BT2020_TO_XYZ_MAT, bt2020));
}

float3 lava_LMSFromBT2020(float3 bt2020) {
  float3 xyz = mul(LAVA_BT2020_TO_XYZ_MAT, bt2020);
  return mul(LAVA_XYZ_TO_LMS_MAT, xyz);
}

float3 lava_BT2020FromLMS(float3 lms) {
  // Invert LMS->XYZ inline (use precomputed inverse)
  static const float3x3 LAVA_LMS_TO_XYZ_MAT = float3x3(
      1.86006661f, -1.12948008f, 0.21989742f,
      0.36122292f, 0.63880327f, -0.00000071f,
      0.00000000f, 0.00000000f, 1.87500656f);
  float3 xyz = mul(LAVA_LMS_TO_XYZ_MAT, lms);
  return mul(LAVA_XYZ_TO_BT2020_MAT, xyz);
}

float3 lava_MB2FromLMS(float3 lms) {
  const float mb_eps = 1e-12f;
  float weighted_l = LAVA_MB_WEIGHTS.x * lms.x;
  float weighted_m = LAVA_MB_WEIGHTS.y * lms.y;
  float y_mb = weighted_l + weighted_m;
  if (y_mb <= mb_eps) return float3(0.f, 0.f, 0.f);
  float inv = lava_DivideSafe(1.f, y_mb, 0.f);
  return float3(
      weighted_l * inv,
      LAVA_MB_WEIGHTS.z * lms.z * inv,
      y_mb);
}

float3 lava_LMSFromMB2(float3 mb2) {
  float l_coord = mb2.x;
  float s_coord = mb2.y;
  float y = max(mb2.z, 0.f);
  float L = lava_DivideSafe(l_coord * y, LAVA_MB_WEIGHTS.x, 0.f);
  float M = lava_DivideSafe((1.f - l_coord) * y, LAVA_MB_WEIGHTS.y, 0.f);
  float S = lava_DivideSafe(s_coord * y, LAVA_MB_WEIGHTS.z, 0.f);
  return float3(L, M, S);
}

float2 lava_WhiteD65Chromaticity() {
  float3 d65_xyz = lava_XYZFromxyY(float3(LAVA_WHITE_POINT_D65, 1.f));
  float3 d65_lms = mul(LAVA_XYZ_TO_LMS_MAT, d65_xyz);
  return lava_MB2FromLMS(d65_lms).xy;
}

// Gamut compress by adding white in LMS (pulls negatives into valid BT.2020 range)
float3 lava_GamutCompressAddWhiteBT2020(float3 lms) {
  const float mb_near_white_eps = 1e-14f;
  const float interval_max = 1e30f;
  const float eps = 1e-20f;

  float t = lms.x + lms.y;
  if (t <= 1e-6f) return lms;

  float2 white = lava_WhiteD65Chromaticity();
  float2 mb0 = lava_MB2FromLMS(lms).xy;
  float2 direction = mb0 - white;
  if (dot(direction, direction) < mb_near_white_eps) return lms;

  // Reconstruct white-at-T and input-at-T in BT.2020
  float3 lms_white = lava_LMSFromMB2(float3(white, t));
  float3 bt2020_white = lava_BT2020FromLMS(lms_white);
  float3 bt2020_input = lava_BT2020FromLMS(lms);
  float3 ray_a = bt2020_input - bt2020_white;

  // Find max t along ray where all BT.2020 channels >= 0
  float t_hi = interval_max;
  [unroll]
  for (int ch = 0; ch < 3; ch++) {
    float a_ch = ray_a[ch];
    float b_ch = bt2020_white[ch];
    if (abs(a_ch) < eps) {
      if (b_ch < 0.f) { t_hi = 0.f; break; }
    } else {
      float t0 = -b_ch / a_ch;
      if (a_ch > 0.f) { /* lo = t0 */ }
      else { t_hi = min(t_hi, t0); }
    }
  }

  float t_max = max(0.f, t_hi);
  if (t_max >= 1.f) return lms;  // Already in gamut

  // Add white to bring into gamut
  float white_ratio = max(lava_DivideSafe(1.f - t_max, t_max, 0.f), 0.f);
  float white_add = t * white_ratio;
  float3 white_unit_lms = lava_LMSFromMB2(float3(white, 1.f));
  return lms + white_unit_lms * white_add;
}

// ============================================================================
// Main entry point: Apply hue correction + saturation to emissive/lava color
// ============================================================================
//
// hue_strength: 0 = no hue change, 1 = fully rotate to fire target direction.
// purity_scale: 1 = unchanged, >1 = more saturated, <1 = desaturated.
// Input/output: BT.709 linear, scene-referred (HDR values > 1.0 OK).
float3 ApplyLavaHueCorrection(float3 color_bt709, float hue_strength, float purity_scale) {
  const float kEps = 1e-6f;
  const float kNearWhiteEps = 1e-14f;

  if (hue_strength <= 0.f && abs(purity_scale - 1.f) <= kEps) {
    return color_bt709;
  }

  // BT.709 → BT.2020 → Stockman-Sharp LMS
  float3 bt2020 = lava_BT2020FromBT709(color_bt709);
  float3 lms = lava_LMSFromBT2020(bt2020);

  // Pre-correct gamut (pull any negatives into valid range)
  lms = lava_GamutCompressAddWhiteBT2020(lms);

  float3 mb = lava_MB2FromLMS(lms);
  float2 white = lava_WhiteD65Chromaticity();

  float2 color_offset = mb.xy - white;
  float color_dist_sq = dot(color_offset, color_offset);

  // Near-achromatic: nothing to rotate
  if (color_dist_sq <= kNearWhiteEps) {
    return color_bt709;
  }

  float color_radius = sqrt(color_dist_sq);
  float2 color_dir = color_offset * rsqrt(color_dist_sq);

  // Hue rotation: blend current MB direction toward fire target direction
  float hue_blend = saturate(hue_strength);
  float2 blended_dir = lerp(color_dir, FIRE_TARGET_MB_DIR, hue_blend);
  float blended_len_sq = dot(blended_dir, blended_dir);
  if (blended_len_sq <= kNearWhiteEps) {
    blended_dir = color_dir;
  } else {
    blended_dir *= rsqrt(blended_len_sq);
  }

  // Reconstruct MB chromaticity at same radius (preserves purity distance)
  float final_radius = color_radius;

  // Optional purity scaling
  if (abs(purity_scale - 1.f) > kEps) {
    final_radius *= max(purity_scale, 0.f);
  }

  float2 mb_corrected_xy = white + blended_dir * final_radius;
  float3 mb_corrected = float3(mb_corrected_xy, mb.z);

  // MB → LMS → gamut compress → BT.2020 → BT.709
  float3 lms_corrected = lava_LMSFromMB2(mb_corrected);
  lms_corrected = lava_GamutCompressAddWhiteBT2020(lms_corrected);
  float3 bt2020_corrected = lava_BT2020FromLMS(lms_corrected);
  return max(lava_BT709FromBT2020(bt2020_corrected), 0.f);
}

#endif  // SRC_GAMES_POE2_VK_FIRE_LAVA_HUE_CORRECTION_HLSL_
