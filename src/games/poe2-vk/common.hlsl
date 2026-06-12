#include "./shared.h"
#include "./macleod_boynton_purity.hlsl"
#include "./psycho_test17_custom.hlsl"

// Interleaved Gradient Noise (Jimenez 2014)
// Returns a scalar in [0,1) with good spatial blue-noise properties.
float InterleavedGradientNoise(float2 pixelCoord) {
  return frac(52.9829189f * frac(mad(0.06711056f, pixelCoord.x, 0.00583715f * pixelCoord.y)));
}

// Per channel gamma correction
float3 ApplyGammaCorrectionByLuminance(float3 color_input) {
  return renodx::color::correct::GammaSafe(color_input);
}

// Processes UI shader output: neutralizes vanilla sdr_scale, applies UI gamma
// correction, scales by UI nits, and optionally hides UI for screenshots.
float4 ApplyUIProcessing(float3 color, float alpha) {
  if (RENODX_HIDE_UI == 1.f) {
    return float4(0.f, 0.f, 0.f, 0.f);
  }
  if (RENODX_SWAP_CHAIN_GAMMA_CORRECTION == 1.f) {
    color = ApplyGammaCorrectionByLuminance(color);
  }
  color *= RENODX_GRAPHICS_WHITE_NITS / 80.f;
  return float4(color, alpha);
}

float3 CorrectHueAndPurityMBGated(
    float3 target_color_bt709,
    float3 reference_color_bt709,
    float hue_strength = 1.f,
    float hue_t_ramp_start = 0.5f,
    float hue_t_ramp_end = 1.f,
    float purity_strength = 1.f,
    float curve_gamma = 1.f,
    float2 mb_white_override = float2(-1.f, -1.f),
    float t_min = 1e-6f) {
  if (purity_strength <= 0.f && hue_strength <= 0.f) {
    return target_color_bt709;
  }

  float3 target_color_bt2020 = renodx::color::bt2020::from::BT709(target_color_bt709);
  float3 reference_color_bt2020 = renodx::color::bt2020::from::BT709(reference_color_bt709);

  if (hue_strength <= 0.f) {
    float target_purity01 = renodx::color::macleod_boynton::ApplyBT2020(
                                target_color_bt2020, 1.f, 1.f, mb_white_override, t_min)
                                .purityCur01;
    float reference_purity01 = renodx::color::macleod_boynton::ApplyBT2020(
                                   reference_color_bt2020, 1.f, 1.f, mb_white_override, t_min)
                                   .purityCur01;
    float applied_purity01 = lerp(target_purity01, reference_purity01, saturate(purity_strength));
    return renodx::color::bt709::from::BT2020(
        renodx::color::macleod_boynton::ApplyBT2020(
            target_color_bt2020, applied_purity01, curve_gamma, mb_white_override, t_min)
            .rgbOut);
  }

  float3 target_lms = mul(renodx::color::macleod_boynton::XYZ_TO_LMS_2006,
                          mul(renodx::color::BT2020_TO_XYZ_MAT, target_color_bt2020));
  float target_t = target_lms.x + target_lms.y;
  if (target_t <= t_min) {
    return target_color_bt709;
  }

  float hue_blend = saturate(hue_strength) *
                    saturate(renodx::math::DivideSafe(target_t - hue_t_ramp_start,
                                                      hue_t_ramp_end - hue_t_ramp_start, 0.f));

  float target_purity01 = renodx::color::macleod_boynton::ApplyBT2020(
                              target_color_bt2020, 1.f, 1.f, mb_white_override, t_min)
                              .purityCur01;
  float reference_purity01 = renodx::color::macleod_boynton::ApplyBT2020(
                                 reference_color_bt2020, 1.f, 1.f, mb_white_override, t_min)
                                 .purityCur01;
  float applied_purity01 = lerp(target_purity01, reference_purity01, saturate(purity_strength));

  if (hue_blend <= 0.f) {
    return renodx::color::bt709::from::BT2020(
        renodx::color::macleod_boynton::ApplyBT2020(
            target_color_bt2020, applied_purity01, curve_gamma, mb_white_override, t_min)
            .rgbOut);
  }

  float3 reference_lms = mul(renodx::color::macleod_boynton::XYZ_TO_LMS_2006,
                             mul(renodx::color::BT2020_TO_XYZ_MAT, reference_color_bt2020));

  bool has_white_override = (mb_white_override.x >= 0.f && mb_white_override.y >= 0.f);
  float2 white = renodx::math::Select(has_white_override, mb_white_override, renodx::color::macleod_boynton::MB_White_D65());

  float2 target_direction = renodx::color::macleod_boynton::MB_From_LMS(target_lms) - white;
  float2 reference_direction = renodx::color::macleod_boynton::MB_From_LMS(reference_lms) - white;

  float target_len_sq = dot(target_direction, target_direction);
  float reference_len_sq = dot(reference_direction, reference_direction);

  if (target_len_sq < renodx::color::macleod_boynton::MB_NEAR_WHITE_EPSILON &&
      reference_len_sq < renodx::color::macleod_boynton::MB_NEAR_WHITE_EPSILON) {
    return renodx::color::bt709::from::BT2020(
        renodx::color::macleod_boynton::ApplyBT2020(
            target_color_bt2020, applied_purity01, curve_gamma, mb_white_override, t_min)
            .rgbOut);
  }

  float2 target_unit = renodx::math::Select(
      (target_len_sq > renodx::color::macleod_boynton::MB_NEAR_WHITE_EPSILON),
      (target_direction * rsqrt(target_len_sq)),
      float2(0.f, 0.f));
  float2 reference_unit = renodx::math::Select(
      (reference_len_sq > renodx::color::macleod_boynton::MB_NEAR_WHITE_EPSILON),
      (reference_direction * rsqrt(reference_len_sq)),
      target_unit);
  if (target_len_sq <= renodx::color::macleod_boynton::MB_NEAR_WHITE_EPSILON) {
    target_unit = reference_unit;
  }

  float2 blended_unit = lerp(target_unit, reference_unit, hue_blend);
  float blended_len_sq = dot(blended_unit, blended_unit);
  if (blended_len_sq <= renodx::color::macleod_boynton::MB_NEAR_WHITE_EPSILON) {
    blended_unit = renodx::math::Select((hue_blend >= 0.5f), reference_unit, target_unit);
    blended_len_sq = dot(blended_unit, blended_unit);
  }
  blended_unit *= rsqrt(max(blended_len_sq, 1e-20f));

  float seed_len = sqrt(max(target_len_sq, 0.f));
  if (seed_len <= 1e-6f) {
    seed_len = sqrt(max(reference_len_sq, 0.f));
  }
  seed_len = max(seed_len, 1e-6f);

  float3 seed_bt2020 = mul(
      renodx::color::XYZ_TO_BT2020_MAT,
      mul(renodx::color::macleod_boynton::LMS_TO_XYZ_2006,
          renodx::color::macleod_boynton::LMS_From_MB_T(white + blended_unit * seed_len, target_t)));

  return renodx::color::bt709::from::BT2020(
      renodx::color::macleod_boynton::ApplyBT2020(
          seed_bt2020, applied_purity01, curve_gamma, mb_white_override, t_min)
          .rgbOut);
}

struct UserGradingConfig {
  float exposure;
  float highlights;
  float shadows;
  float contrast;
  float flare;
  float saturation;
  float dechroma;
  float hue_emulation_strength;
  float highlight_saturation;
};

UserGradingConfig CreateColorGradeConfig() {
  const UserGradingConfig cg_config = {
    RENODX_TONE_MAP_EXPOSURE,                             // float exposure;
    RENODX_TONE_MAP_HIGHLIGHTS,                           // float highlights;
    RENODX_TONE_MAP_SHADOWS,                              // float shadows;
    RENODX_TONE_MAP_CONTRAST,                             // float contrast;
    0.10f * pow(RENODX_TONE_MAP_FLARE, 10.f),             // float flare;
    RENODX_TONE_MAP_SATURATION,                           // float saturation;
    RENODX_TONE_MAP_DECHROMA,                             // float dechroma;
    RENODX_TONE_MAP_HUE_SHIFT,                            // float hue_emulation_strength;
    -1.f * (RENODX_TONE_MAP_HIGHLIGHT_SATURATION - 1.f)   // float highlight_saturation;
  };
  return cg_config;
}

float Highlights(float x, float highlights, float mid_gray) {
  if (highlights == 1.f) return x;

  if (highlights > 1.f) {
    return max(x, lerp(x, mid_gray * pow(x / mid_gray, highlights), min(x, 10.f)));
  } else {  // highlights < 1.f
    x /= mid_gray;
    return lerp(x, pow(x, highlights), step(1.f, x)) * mid_gray;
  }
}

float Shadows(float x, float shadows, float mid_gray) {
  if (shadows == 1.f) return x;

  const float ratio = max(renodx::math::DivideSafe(x, mid_gray, 0.f), 0.f);
  const float base_term = x * mid_gray;
  const float base_scale = renodx::math::DivideSafe(base_term, ratio, 0.f);

  if (shadows > 1.f) {
    float raised = x * (1.f + renodx::math::DivideSafe(base_term, pow(ratio, shadows), 0.f));
    float reference = x * (1.f + base_scale);
    return max(x, x + (raised - reference));
  } else {  // shadows < 1.f
    float lowered = x * (1.f - renodx::math::DivideSafe(base_term, pow(ratio, 2.f - shadows), 0.f));
    float reference = x * (1.f - base_scale);
    return clamp(x + (lowered - reference), 0.f, x);
  }
}

float3 ApplyExposureContrastFlareHighlightsShadowsByLuminance(float3 untonemapped, float y, UserGradingConfig config, float mid_gray = 0.18f) {
  if (config.exposure == 1.f && config.shadows == 1.f && config.highlights == 1.f && config.contrast == 1.f && config.flare == 0.f) {
    return untonemapped;
  }
  float3 color = untonemapped;

  color *= config.exposure;

  // contrast & flare
  const float y_normalized = y / mid_gray;
  float flare = renodx::math::DivideSafe(y_normalized + config.flare, y_normalized, 1.f);
  float exponent = config.contrast * flare;
  const float y_contrasted = pow(y_normalized, exponent) * mid_gray;

  // highlights
  float y_highlighted = Highlights(y_contrasted, config.highlights, mid_gray);

  // shadows
  float y_shadowed = Shadows(y_highlighted, config.shadows, mid_gray);

  const float y_final = y_shadowed;

  color = renodx::color::correct::Luminance(color, y, y_final);

  return color;
}

float3 ApplySaturationBlowoutHueCorrectionHighlightSaturation(float3 tonemapped, float3 hue_reference_color, float y, UserGradingConfig config) {
  float3 color = tonemapped;
  if (config.saturation != 1.f || config.dechroma != 0.f || config.hue_emulation_strength != 0.f || config.highlight_saturation != 0.f) {
    if (config.hue_emulation_strength != 0.f) {
      color = CorrectHueAndPurityMBGated(
          color,
          hue_reference_color,
          config.hue_emulation_strength,
          0.5f,
          1.f,
          0.f,
          1.f);
    }

    float mb_scale = max(config.saturation, 0.f);

    if (config.dechroma != 0.f) {
      float dechroma_y = max(color.r, max(color.g, color.b));
      float dechroma_scale = lerp(1.f, 0.f, saturate(pow(dechroma_y / (10000.f / 100.f), (1.f - config.dechroma))));
      mb_scale *= max(dechroma_scale, 0.f);
    }

    if (config.highlight_saturation != 0.f) {
      float percent_max = saturate(y * 100.f / 10000.f);
      float highlight_saturation_strength = 100.f;
      float highlight_saturation_change = pow(1.f - percent_max, highlight_saturation_strength * abs(config.highlight_saturation));
      if (config.highlight_saturation < 0) {
        highlight_saturation_change = (2.f - highlight_saturation_change);
      }
      mb_scale *= max(highlight_saturation_change, 0.f);
    }

    if (abs(mb_scale - 1.f) > 1e-6f) {
      float3 color_bt2020 = renodx::color::bt2020::from::BT709(color);
      color = renodx::color::bt709::from::BT2020(
          renodx::color::macleod_boynton::ApplyScaleBT2020(color_bt2020, mb_scale)
              .rgbOut);
    }

    color = renodx::color::bt709::clamp::AP1(color);
  }
  return color;
}

struct LUTSampleResult {
  float3 graded;
  float y;
  float3 graded_ap1;
  float3 pre_lut_linear;  // raw linear scene color before LUT (for hue reference)
};

float3 PSYCHOGRADE(LUTSampleResult lut_sample) {
  float3 graded = lut_sample.graded;
  float y = lut_sample.y;
  float peak = shader_injection.peak_white_nits / shader_injection.diffuse_white_nits;

  UserGradingConfig cg_config = CreateColorGradeConfig();

  float3 output = renodx::tonemap::psycho::psychotm_test17(
      graded,
      peak,                                // peak_value
      1.f,                                 // exposure (already applied pre-LUT)
      1.f,                                 // highlights (already applied pre-LUT)
      1.f,                                 // shadows (already applied pre-LUT)
      1.f,                                 // contrast (already applied pre-LUT)
      1.f,                                 // purity_scale (saturation applied post-tonemap instead)
      0.f,                                 // bleaching_intensity
      peak * 2.f,                          // clip_point
      cg_config.hue_emulation_strength,    // hue_restore
      1.f,                                 // adaptation_contrast
      0,                                   // white_curve_mode
      1.f,                                 // cone_response_exponent
      0.18f,                               // current_adaptive_state_bt709
      0.18f,                               // current_background_state_bt709
      1.f,                                 // gamut_compression
      1);                                  // gamut_compression_mode (BT.2020 bound)

  // Post tonemap hue correction using per channel Neutwo of the PRE LUT linear
  // scene color.
  if (HUE_CORRECTION > 0.f) {
    float3 pre_lut_clamped = max(0, lut_sample.pre_lut_linear);
    float3 hue_reference = renodx::tonemap::neutwo::PerChannel(pre_lut_clamped, peak.xxx);
    output = CorrectHueAndPurityMBGated(
        output, hue_reference,
        HUE_CORRECTION,
        0.05f, 0.5f,
        0.f);
  }

  // Post tonemap saturation, dechroma, highlight saturation via MB purity scaling.
  {
    UserGradingConfig sat_config = cg_config;
    sat_config.hue_emulation_strength = 0.f;
    float y_out = renodx::color::y::from::BT709(output);
    output = ApplySaturationBlowoutHueCorrectionHighlightSaturation(
        output, 0.f, y_out, sat_config);
  }

  output = renodx::color::bt709::clamp::AP1(output);

  // Clamp to display peak to prevent overshoot from post tonemap color ops
  float psycho_max_channel = max(output.r, max(output.g, output.b));
  if (psycho_max_channel > peak) {
    output *= peak / psycho_max_channel;
  }

  return output;
}