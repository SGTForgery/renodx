#include "./shared.h"
#include "./macleod_boynton_purity.hlsl"
#include "./psycho_test17_custom.hlsl"

// Interleaved Gradient Noise (Jimenez 2014)
// Returns a scalar in [0,1) with good spatial blue-noise properties.
float InterleavedGradientNoise(float2 pixelCoord) {
  return frac(52.9829189f * frac(mad(0.06711056f, pixelCoord.x, 0.00583715f * pixelCoord.y)));
}

// Luminance-based gamma correction that preserves per-channel chrominance (hue).
float3 ApplyGammaCorrectionByLuminance(float3 color_input) {
  float y_in = renodx::color::y::from::BT709(color_input);
  float y_out = renodx::color::correct::Gamma(max(0, y_in));
  float3 color_output = renodx::color::correct::Luminance(color_input, y_in, y_out);
  return color_output;
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

float3 HueAndChrominanceOKLab(
    float3 incorrect_color, float3 reference_color,
    float hue_correct_strength = 0.f,
    float chrominance_correct_strength = 0.f,
    float saturation = 1.f) {
  if (hue_correct_strength != 0.f || chrominance_correct_strength != 0.f || saturation != 0.f) {
    float3 perceptual_new = renodx::color::oklab::from::BT709(incorrect_color);
    const float3 reference_oklab = renodx::color::oklab::from::BT709(reference_color);

    float chrominance_current = length(perceptual_new.yz);
    float chrominance_ratio = 1.f;

    if (hue_correct_strength != 0.f) {
      const float chrominance_pre = chrominance_current;
      perceptual_new.yz = lerp(perceptual_new.yz, reference_oklab.yz, hue_correct_strength);
      const float chrominancePost = length(perceptual_new.yz);
      chrominance_ratio = renodx::math::DivideSafe(chrominance_pre, chrominancePost, 1.f);
      chrominance_current = chrominancePost;
    }

    if (chrominance_correct_strength != 0.f) {
      const float reference_chrominance = length(reference_oklab.yz);
      float target_chrominance_ratio = renodx::math::DivideSafe(reference_chrominance, chrominance_current, 1.f);
      chrominance_ratio = lerp(chrominance_ratio, target_chrominance_ratio, chrominance_correct_strength);
    }
    perceptual_new.yz *= chrominance_ratio;
    perceptual_new.yz *= saturation;

    incorrect_color = renodx::color::bt709::from::OkLab(perceptual_new);
    incorrect_color = renodx::color::bt709::clamp::AP1(incorrect_color);
  }
  return incorrect_color;
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

float3 ApplyMBLowHueThenHighHueAndPurity(
    float3 target_bt709,
    float3 low_hue_reference_bt709,
    float3 high_reference_bt709,
    float high_hue_strength = 1.f,
    float hue_t_ramp_start = 0.5f,
    float hue_t_ramp_end = 1.f,
    float curve_gamma = 1.f,
    float2 mb_white_override = float2(-1.f, -1.f),
    float t_min = 1e-6f) {
  const float kNearWhiteEpsilon = renodx::color::macleod_boynton::MB_NEAR_WHITE_EPSILON;

  float3 target_bt2020 = renodx::color::bt2020::from::BT709(target_bt709);
  float3 low_reference_bt2020 = renodx::color::bt2020::from::BT709(low_hue_reference_bt709);
  float3 high_reference_bt2020 = renodx::color::bt2020::from::BT709(high_reference_bt709);

  float high_purity01 = renodx::color::macleod_boynton::ApplyBT2020(
                           high_reference_bt2020, 1.f, 1.f, mb_white_override, t_min)
                           .purityCur01;

  float3 target_lms = mul(renodx::color::macleod_boynton::XYZ_TO_LMS_2006,
                          mul(renodx::color::BT2020_TO_XYZ_MAT, target_bt2020));
  float3 low_reference_lms = mul(renodx::color::macleod_boynton::XYZ_TO_LMS_2006,
                                 mul(renodx::color::BT2020_TO_XYZ_MAT, low_reference_bt2020));
  float3 high_reference_lms = mul(renodx::color::macleod_boynton::XYZ_TO_LMS_2006,
                                  mul(renodx::color::BT2020_TO_XYZ_MAT, high_reference_bt2020));

  float target_t = target_lms.x + target_lms.y;
  if (target_t <= t_min) {
    return target_bt709;
  }

  float2 white = renodx::math::Select(
      (mb_white_override.x >= 0.f && mb_white_override.y >= 0.f),
      mb_white_override,
      renodx::color::macleod_boynton::MB_White_D65());

  float2 target_direction = renodx::color::macleod_boynton::MB_From_LMS(target_lms) - white;
  float2 low_reference_direction = renodx::color::macleod_boynton::MB_From_LMS(low_reference_lms) - white;
  float2 high_reference_direction = renodx::color::macleod_boynton::MB_From_LMS(high_reference_lms) - white;

  float target_len_sq = dot(target_direction, target_direction);
  float low_len_sq = dot(low_reference_direction, low_reference_direction);
  float high_len_sq = dot(high_reference_direction, high_reference_direction);

  float2 low_unit = float2(0.f, 0.f);
  if (low_len_sq > kNearWhiteEpsilon) {
    low_unit = low_reference_direction * rsqrt(low_len_sq);
  } else if (target_len_sq > kNearWhiteEpsilon) {
    low_unit = target_direction * rsqrt(target_len_sq);
  } else if (high_len_sq > kNearWhiteEpsilon) {
    low_unit = high_reference_direction * rsqrt(high_len_sq);
  }

  float2 high_unit = renodx::math::Select(
      (high_len_sq > kNearWhiteEpsilon),
      (high_reference_direction * rsqrt(high_len_sq)),
      low_unit);

  float hue_blend = saturate(high_hue_strength) *
                    saturate(renodx::math::DivideSafe(target_t - hue_t_ramp_start,
                                                      hue_t_ramp_end - hue_t_ramp_start, 0.f));

  float2 hue_unit = lerp(low_unit, high_unit, hue_blend);

  float hue_len_sq = dot(hue_unit, hue_unit);
  if (hue_len_sq <= kNearWhiteEpsilon) {
    return renodx::color::bt709::from::BT2020(
        renodx::color::macleod_boynton::ApplyBT2020(
            target_bt2020, high_purity01, curve_gamma, mb_white_override, t_min)
            .rgbOut);
  }

  hue_unit *= rsqrt(hue_len_sq);

  float seed_len = sqrt(max(target_len_sq, 0.f));
  if (seed_len <= 1e-6f) {
    seed_len = sqrt(max(lerp(low_len_sq, high_len_sq, hue_blend), 0.f));
  }
  seed_len = max(seed_len, 1e-6f);

  float3 seed_bt2020 = mul(
      renodx::color::XYZ_TO_BT2020_MAT,
      mul(renodx::color::macleod_boynton::LMS_TO_XYZ_2006,
          renodx::color::macleod_boynton::LMS_From_MB_T(white + hue_unit * seed_len, target_t)));

  return renodx::color::bt709::from::BT2020(
      renodx::color::macleod_boynton::ApplyBT2020(
          seed_bt2020, high_purity01, curve_gamma, mb_white_override, t_min)
          .rgbOut);
}

float3 ApplyHermiteSplineByMaxChannel(float3 input, float peak_ratio, float white_clip = 100.f) {
  float max_channel = renodx::math::Max(input);

  float mapped_peak = exp2(renodx::tonemap::HermiteSplineRolloff(log2(max_channel), log2(peak_ratio), log2(white_clip)));
  float scale = renodx::math::DivideSafe(mapped_peak, max_channel, 1.f);
  float3 tonemapped = input * scale;
  return tonemapped;
}
float3 ApplyNeutwoByMaxChannel(float3 input, float peak_ratio, float white_clip = 100.f) {
  float max_channel = renodx::math::Max(input);
  
  float mapped_peak = renodx::tonemap::Neutwo(max_channel, peak_ratio, white_clip);
  float scale = renodx::math::DivideSafe(mapped_peak, max_channel, 1.f);
  float3 tonemapped = input * scale;
  return tonemapped;
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
  float chrominance_emulation_strength;
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
    -1.f * (RENODX_TONE_MAP_HIGHLIGHT_SATURATION - 1.f),  // float highlight_saturation;
    0.f                                                    // float chrominance_emulation_strength; (disabled)
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
  if (config.saturation != 1.f || config.dechroma != 0.f || config.hue_emulation_strength != 0.f || config.chrominance_emulation_strength != 0.f || config.highlight_saturation != 0.f) {
    if (config.hue_emulation_strength != 0.f || config.chrominance_emulation_strength != 0.f) {
      color = CorrectHueAndPurityMBGated(
          color,
          hue_reference_color,
          config.hue_emulation_strength,
          0.5f,
          1.f,
          config.chrominance_emulation_strength,
          1.f);
    }

    float mb_scale = max(config.saturation, 0.f);

    if (config.dechroma != 0.f) {
      float dechroma_scale = lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - config.dechroma))));
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

    /* Disabled OKLab path (kept for reference)

    float3 perceptual_new = renodx::color::oklab::from::BT709(color);

    // hue and chrominance emulation
    if (config.hue_emulation_strength != 0.0 || config.chrominance_emulation_strength != 0.0) {
      const float3 perceptual_reference = renodx::color::oklab::from::BT709(hue_reference_color);

      float chrominance_current = length(perceptual_new.yz);
      float chrominance_ratio = 1.0;

      if (config.hue_emulation_strength != 0.0) {
        const float chrominance_pre = chrominance_current;
        perceptual_new.yz = lerp(perceptual_new.yz, perceptual_reference.yz, config.hue_emulation_strength);
        const float chrominancePost = length(perceptual_new.yz);
        chrominance_ratio = renodx::math::SafeDivision(chrominance_pre, chrominancePost, 1);
        chrominance_current = chrominancePost;
      }

      if (config.chrominance_emulation_strength != 0.0) {
        const float reference_chrominance = length(perceptual_reference.yz);
        float target_chrominance_ratio = renodx::math::SafeDivision(reference_chrominance, chrominance_current, 1);
        chrominance_ratio = lerp(chrominance_ratio, target_chrominance_ratio, config.chrominance_emulation_strength);
      }
      perceptual_new.yz *= chrominance_ratio;
    }

    // dechroma
    if (config.dechroma != 0.f) {
      perceptual_new.yz *= lerp(1.f, 0.f, saturate(pow(y / (10000.f / 100.f), (1.f - config.dechroma))));
    }

    // highlight saturation
    if (config.highlight_saturation != 0.f) {
      float percent_max = saturate(y * 100.f / 10000.f);
      // positive = 1 to 0, negative = 1 to 2
      float highlight_saturation_strength = 100.f;
      float highlight_saturation_change = pow(1.f - percent_max, highlight_saturation_strength * abs(config.highlight_saturation));
      if (config.highlight_saturation < 0) {
        highlight_saturation_change = (2.f - highlight_saturation_change);
      }

      perceptual_new.yz *= highlight_saturation_change;
    }

    // saturation
    perceptual_new.yz *= config.saturation;

    color = renodx::color::bt709::from::OkLab(perceptual_new);

    color = renodx::color::bt709::clamp::AP1(color);

    */
  }
  return color;
}

struct LUTSampleResult {
  float3 graded;
  float y;
  float3 graded_ap1;
  float3 pre_lut_linear;  // raw linear scene color before LUT (for hue reference)
};

LUTSampleResult LUTSAMPLE(
    SamplerState lut_sampler,
    float3 lut_size,
    Texture2D<float4> lut_texture,
    float3 sample_input) {
  [branch]
  if (shader_injection.tone_map_type != 0.f) {
    UserGradingConfig cg_config = CreateColorGradeConfig();
    float sample_input_y = renodx::color::y::from::BT709(sample_input);
    sample_input = ApplyExposureContrastFlareHighlightsShadowsByLuminance(
        sample_input, sample_input_y, cg_config);
  }

  renodx::lut::Config lut_config = renodx::lut::config::Create(
      lut_sampler,
      shader_injection.color_grade_strength,
      0.f,
      renodx::lut::config::type::ARRI_C1000_NO_CUT,
      renodx::lut::config::type::LINEAR,
      lut_size);

  LUTSampleResult result;
  result.graded = renodx::lut::Sample(lut_texture, lut_config, sample_input);
  result.y = renodx::color::y::from::BT709(result.graded);
  result.graded_ap1 = renodx::color::ap1::from::BT709(result.graded);
  return result;
}

float3 SDRGRADE(LUTSampleResult lut_sample) {
  float3 graded = lut_sample.graded;
  float3 graded_ap1 = lut_sample.graded_ap1;
  float y = lut_sample.y;

  float3 hue_chrominance_reference_color =
      renodx::color::bt709::from::AP1(renodx::tonemap::ReinhardPiecewise(graded_ap1, 2.f, 1.0f));

  UserGradingConfig cg_config;
  cg_config.saturation = 1.f;
  cg_config.dechroma = .1f;
  cg_config.hue_emulation_strength = 1.f;
  cg_config.chrominance_emulation_strength = .5f;
  cg_config.highlight_saturation = 0.f;

  float3 output = ApplySaturationBlowoutHueCorrectionHighlightSaturation(
      graded, hue_chrominance_reference_color, y, cg_config);
  output = renodx::color::bt2020::from::BT709(output);
  output = renodx::tonemap::neutwo::MaxChannel(output, 1.0f, 2.0f);
  output = renodx::color::bt709::from::BT2020(output);
  return output;
}

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
      cg_config.chrominance_emulation_strength,  // bleaching_intensity
      peak * 2.f,                          // clip_point
      cg_config.hue_emulation_strength,    // hue_restore
      1.f,                                 // adaptation_contrast
      0,                                   // white_curve_mode
      1.f,                                 // cone_response_exponent
      0.18f,                               // current_adaptive_state_bt709
      0.18f,                               // current_background_state_bt709
      1.f,                                 // gamut_compression
      1);                                  // gamut_compression_mode (BT.2020 bound)

  // Post-tonemap hue correction using per-channel Neutwo of the PRE-LUT linear
  // scene color. This matches BG3-VK's approach where the hue reference is
  // computed from the raw scene color (_84), not the LUT-graded output.
  // The LUT may shift hue (making fire more pink), so using post-LUT color
  // as the reference source would give a pink reference — defeating the purpose.
  // Uses lower t_ramp (0.05, 0.5) because after tonemapping, values are compressed
  // to display range — the standard (0.5, 1.0) ramp would miss most pixels.
  if (HUE_CORRECTION > 0.f || cg_config.chrominance_emulation_strength > 0.f) {
    float3 pre_lut_clamped = max(0, lut_sample.pre_lut_linear);
    if (HUE_CORRECTION > 0.f) {
      float3 hue_reference = renodx::tonemap::neutwo::PerChannel(pre_lut_clamped, peak.xxx);
      output = CorrectHueAndPurityMBGated(
          output, hue_reference,
          HUE_CORRECTION,
          0.05f, 0.5f,
          0.f);
    }
    // Purity restoration: Psycho's per-cone compression desaturates more than
    // max-channel Neutwo. Blend purity toward max-channel Neutwo reference
    // to restore saturation in highlights (same approach as BG3-VK).
    if (cg_config.chrominance_emulation_strength > 0.f) {
      float3 purity_reference = renodx::tonemap::neutwo::MaxChannel(pre_lut_clamped, peak);
      output = CorrectHueAndPurityMBGated(
          output, purity_reference,
          0.f,           // no hue from this reference
          0.05f, 0.5f,
          cg_config.chrominance_emulation_strength);
    }
  }

  // Post-tonemap saturation, dechroma, highlight saturation via MB purity scaling.
  // Applied here (not inside Psycho) to avoid out-of-gamut breakup from
  // oversaturation before the Naka-Rushton compression.
  {
    UserGradingConfig sat_config = cg_config;
    sat_config.hue_emulation_strength = 0.f;
    sat_config.chrominance_emulation_strength = 0.f;
    float y_out = renodx::color::y::from::BT709(output);
    output = ApplySaturationBlowoutHueCorrectionHighlightSaturation(
        output, 0.f, y_out, sat_config);
  }

  output = renodx::color::bt709::clamp::AP1(output);

  // Clamp to display peak to prevent overshoot from post-tonemap color ops
  float psycho_max_channel = max(output.r, max(output.g, output.b));
  if (psycho_max_channel > peak) {
    output *= peak / psycho_max_channel;
  }

  return output;
}