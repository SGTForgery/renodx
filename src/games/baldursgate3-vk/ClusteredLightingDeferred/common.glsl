// ============================================================================
// RenoDX Common — GLSL shared utilities for clustered lighting uber shader
// ============================================================================

#ifndef RDX_COMMON_GLSL
#define RDX_COMMON_GLSL

// ----------------------------------------------------------------------------
// Constants
// ----------------------------------------------------------------------------
const float RDX_PI = 3.14159265358979323846;
const float RDX_INV_PI = 0.3183098733425140380859375;

// ----------------------------------------------------------------------------
// Push Constants (RenoDX injection data)
// ----------------------------------------------------------------------------
layout(push_constant) uniform RenoDXPushConstants {
    float peak_white_nits;               // 0
    float diffuse_white_nits;            // 4
    float graphics_white_nits;           // 8
    float gamma_correction;              // 12
    float tone_map_exposure;             // 16
    float tone_map_highlights;           // 20
    float tone_map_shadows;              // 24
    float tone_map_contrast;             // 28
    float tone_map_saturation;           // 32
    float tone_map_highlight_saturation; // 36
    float tone_map_dechroma;             // 40
    float tone_map_flare;                // 44
    float color_grade_strength;          // 48
    float tone_map_hue_shift;            // 52
    float tone_map_blowout;              // 56
    float custom_curve;                  // 60
    float hue_correction;                // 64
    float custom_random;                 // 68
    float custom_grain_strength;         // 72
    float custom_bloom;                  // 76
    float rendering_cubemap_mod;         // 80
    float rendering_ao_direct;           // 84
    float rendering_shadow_improvements; // 88
    float rendering_micro_shadows;       // 92
    float rendering_micro_shadows_debug; // 96
    float rendering_specular_occlusion;  // 100
    float rendering_probe_ao;            // 104
    float rendering_horizon_occlusion;   // 108
    float rendering_diffuse_brdf;        // 112
    float hero_lighting;                 // 116
    float rendering_gbuffer_improvements;// 120
    float rendering_fog_haze_aa;         // 124
    float rendering_fog_color_correction;// 128
    float rendering_isfast_noise;        // 132
    float rendering_temporal_shadows;    // 136
} pc;

// ----------------------------------------------------------------------------
// Diffuse BRDF: Hammon 2017
// Earl Hammon Jr., GDC 2017 — "PBR Diffuse Lighting for GGX+Smith Microsurfaces"
// Drop-in replacement for Disney/Burley diffuse with multi-scatter compensation.
// ----------------------------------------------------------------------------
vec3 rdx_hammon_diffuse(float NdotL, float NdotV, float NdotH, float VdotH,
                        float roughness, vec3 albedo) {
    float facing = 0.5 + 0.5 * VdotH;
    float rough = facing * (0.9 - 0.4 * facing)
                * ((0.5 + NdotH) / max(NdotH, 0.1));

    // Fresnel-weighted smooth term (pow5 approximation)
    float oneMinusNdotL = 1.0 - NdotL;
    float NdotL5 = oneMinusNdotL * oneMinusNdotL;
    NdotL5 *= NdotL5 * oneMinusNdotL;

    float oneMinusNdotV = 1.0 - NdotV;
    float NdotV5 = oneMinusNdotV * oneMinusNdotV;
    NdotV5 *= NdotV5 * oneMinusNdotV;

    float smooth_val = 1.05 * (1.0 - NdotL5) * (1.0 - NdotV5);
    float single = mix(smooth_val, rough, roughness) * RDX_INV_PI;

    // Multi-scatter approximation
    float multi = 0.1159 * roughness;

    return albedo * single + albedo * albedo * multi;
}

// ----------------------------------------------------------------------------
// Diffuse BRDF: EON (Portsmouth, Kutz, Hill — JCGT 2025)
// "A practical energy-preserving rough diffuse BRDF"
// Based on the Fujii/FON model with proper multi-scatter energy compensation.
// Adopted by OpenPBR v1.2 / MaterialX as the reference diffuse model.
// ----------------------------------------------------------------------------

// FON constants
const float RDX_FON_C1 = 0.5 - 2.0 / (3.0 * RDX_PI);
const float RDX_FON_C2 = 2.0 / 3.0 - 28.0 / (15.0 * RDX_PI);

// FON directional albedo — fast rational approximation (< 0.5% error vs analytic)
float rdx_E_FON_approx(float mu, float r) {
    float mucomp = 1.0 - mu;
    // Polynomial fit coefficients (Portsmouth et al. 2025, Eq. 14)
    // GoverPi = g1*mucomp + g2*mucomp^2 + g3*mucomp^3 + g4*mucomp^4
    // g1=0.0571085289, g2=0.491881867, g3=-0.332181442, g4=0.0714429953
    float GoverPi = mucomp * (0.0571085289 + mucomp * (0.491881867 + mucomp * (-0.332181442 + mucomp * 0.0714429953)));
    return (1.0 + r * GoverPi) / (1.0 + RDX_FON_C1 * r);
}

// EON diffuse BRDF evaluation
// Inputs match rdx_hammon_diffuse_approx: NdotL, NdotV, VdotH, roughness, albedo
vec3 rdx_eon_diffuse(float NdotL, float NdotV, float VdotH,
                     float roughness, vec3 albedo) {
    float mu_i = max(NdotL, 1.0e-7);
    float mu_o = max(NdotV, 1.0e-7);

    // QON s term: s = dot(L,V) - NdotL*NdotV
    // From half-angle: dot(L,V) = 2*VdotH^2 - 1
    float LdotV = 2.0 * VdotH * VdotH - 1.0;
    float s = LdotV - mu_i * mu_o;

    // Fujii stinv term: s/max(NdotL, NdotV) when s > 0, else just s
    float stinv = s > 0.0 ? s / max(mu_i, mu_o) : s;

    // FON single-scatter lobe
    float AF = 1.0 / (1.0 + RDX_FON_C1 * roughness);
    vec3 f_ss = (albedo * RDX_INV_PI) * AF * (1.0 + roughness * stinv);

    // Multi-scatter energy compensation
    float EFo = rdx_E_FON_approx(mu_o, roughness);
    float EFi = rdx_E_FON_approx(mu_i, roughness);
    float avgEF = AF * (1.0 + RDX_FON_C2 * roughness);

    // Multi-scatter albedo with iterative re-scattering feedback
    vec3 rho_ms = (albedo * albedo) * avgEF
                / max(vec3(1.0) - albedo * max(0.0, 1.0 - avgEF), 1.0e-7);

    // Multi-scatter lobe
    vec3 f_ms = (rho_ms * RDX_INV_PI)
              * max(1.0e-7, 1.0 - EFo)
              * max(1.0e-7, 1.0 - EFi)
              / max(1.0e-7, 1.0 - avgEF);

    return f_ss + f_ms;
}

// Simplified Hammon variant for point/spot lights where VdotH is readily available
// from the energy compensation term. NdotH is approximated from NdotL + NdotV.
// Dispatches to EON when rendering_diffuse_brdf > 1.5 (mode 2).
vec3 rdx_hammon_diffuse_approx(float NdotL, float NdotV, float VdotH,
                               float roughness, vec3 albedo) {
    // Mode 2: EON diffuse (rendering_diffuse_brdf > 1.5)
    if (pc.rendering_diffuse_brdf > 1.5) {
        return rdx_eon_diffuse(NdotL, NdotV, VdotH, roughness, albedo);
    }
    // Mode 1: Hammon 2017 (rendering_diffuse_brdf > 0.5)
    // Approximate NdotH from the half-angle identity:
    // For the half vector H = normalize(L+V), NdotH ≈ sqrt((1 + NdotL*NdotV + ...) / 2)
    // Simpler: use VdotH as proxy since VdotH = LdotH for normalized vectors
    float NdotH = clamp(sqrt(0.5 + 0.5 * NdotL * NdotV + 0.5 * VdotH), 0.0, 1.0);
    return rdx_hammon_diffuse(NdotL, NdotV, NdotH, VdotH, roughness, albedo);
}

// ----------------------------------------------------------------------------
// Cubemap / IBL Modulation
// Attenuates IBL contribution based on sky visibility, roughness, and AO.
// Prevents overlit indirect lighting in occluded areas.
// ----------------------------------------------------------------------------
float rdx_cubemap_modulation(vec3 skyLight, float roughness, float aoFactor) {
    float skyLum = max(0.0, dot(skyLight, vec3(0.2126, 0.7152, 0.0722)));
    float mod_factor = smoothstep(0.0, 0.25, skyLum)
                     * mix(0.5, 1.0, clamp(roughness, 0.0, 1.0))
                     * mix(0.4, 1.0, clamp(aoFactor, 0.0, 1.0));
    return mix(0.3, 1.0, mod_factor);
}

// ----------------------------------------------------------------------------
// Local Light Shadow Sampling — 12-tap Vogel Disk PCF
// Centralized function for all 21 inline PCF loops in the uber body.
// Debug defines at the top of clustered_uber_body.glsl control behavior.
//
// Parameters:
//   shadowAtlas   — the shadow atlas texture (set 1, binding 41)
//   shadowSampler — comparison sampler (set 1, binding 32)
//   shadowUV      — projected UV in atlas space (already flipped Y)
//   compDepth     — linearized comparison depth
//   rotation      — IGN-based rotation for this pixel (already scaled by 2PI or prior)
//   tileMin       — atlas tile min bounds + texel border
//   tileMax       — atlas tile max bounds - texel border
//   texelSize     — _21._m33 (global shadow texel size)
//   pixelCoord    — output pixel coordinate (for debug visualization imageStore)
//   outputImg0    — writeonly image for diffuse output (for debug visualization)
//   outputImg1    — writeonly image for specular output (for debug visualization)
// Returns: shadow factor [0,1] where 1 = fully lit, 0 = fully shadowed
//          returns -1.0 as sentinel for visualization modes (caller must `return`)
// ----------------------------------------------------------------------------
float rdx_shadow_pcf(texture2D shadowAtlas, sampler shadowSampler,
                     vec2 shadowUV, float compDepth, float rotation,
                     vec2 tileMin, vec2 tileMax, vec2 texelSize,
                     ivec2 pixelCoord,
                     writeonly image2D outputImg0, writeonly image2D outputImg1) {

    // Mode 4: disable all local light shadows (return fully lit)
    if (pc.rendering_temporal_shadows > 3.5 && pc.rendering_temporal_shadows < 4.5) return 1.0;

#ifdef DBG_SHADOW_VIS_UV
    vec2 uv_norm = (shadowUV - tileMin) / max((tileMax - tileMin), vec2(0.001));
    imageStore(outputImg0, pixelCoord, vec4(uv_norm, 0.0, 1.0));
    imageStore(outputImg1, pixelCoord, vec4(vec3(0.0), 1.0));
    return -1.0;
#endif

#ifdef DBG_SHADOW_VIS_DEPTH_DELTA
    float center_depth = texelFetch(shadowAtlas, ivec2(shadowUV / texelSize), 0).x;
    float delta = abs(compDepth - center_depth) * 10.0;
    imageStore(outputImg0, pixelCoord, vec4(vec3(delta), 1.0));
    imageStore(outputImg1, pixelCoord, vec4(vec3(0.0), 1.0));
    return -1.0;
#endif

#ifdef DBG_SHADOW_VIS_TILE_SIZE
    vec2 tile_extent = tileMax - tileMin;
    float tile_area = tile_extent.x * tile_extent.y * 100.0;
    imageStore(outputImg0, pixelCoord, vec4(tile_area, tile_extent, 1.0));
    imageStore(outputImg1, pixelCoord, vec4(vec3(0.0), 1.0));
    return -1.0;
#endif

#ifdef DBG_SHADOW_SINGLE_TAP
    vec4 gather = textureGather(sampler2D(shadowAtlas, shadowSampler), shadowUV);
    vec2 fr = fract(fma(vec2(1.0) / texelSize, shadowUV, vec2(0.5)));
    vec4 cmp = vec4(lessThan(vec4(compDepth), gather));
    return clamp(mix(mix(cmp.w, cmp.z, fr.x), mix(cmp.x, cmp.y, fr.x), fr.y), 0.0, 1.0);
#else
    float accum = 0.0;
    for (int i = 0; i < 12; i++) {
        float fi = float(uint(i));
        float r = sqrt(fi + 0.5) * 0.288675129413604736328125;
        float theta = fma(fi, 2.3999631404876708984375, rotation);
        vec2 sampleUV = clamp(fma((vec3(cos(theta), sin(theta), r).xy * r) * 2.5, texelSize, shadowUV), tileMin, tileMax);
        vec2 fr = fract(fma(vec2(1.0) / texelSize, sampleUV, vec2(0.5)));
        vec4 cmp = vec4(lessThan(vec4(compDepth), textureGather(sampler2D(shadowAtlas, shadowSampler), sampleUV)));
        accum += clamp(mix(mix(cmp.w, cmp.z, fr.x), mix(cmp.x, cmp.y, fr.x), fr.y), 0.0, 1.0);
    }
    return accum * 0.083333335816860198974609375;
#endif
}

#endif // RDX_COMMON_GLSL
