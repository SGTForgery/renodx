#version 450
#extension GL_EXT_spirv_intrinsics : require
#extension GL_EXT_samplerless_texture_functions : require

// === DEBUG DEFINES — change and hot-reload via DevKit ===
// 0 = vanilla rendering (hard step at 0.333)
// 1 = IS-FAST stochastic (narrow band [0.25, 0.42])
// 2 = force ALL fragments to PASS (no discard) — shows full shadow map coverage
// 3 = force ALL fragments to FAIL (all discard) — confirms shader is active
// 4 = inverted threshold: discard where vanilla PASSES (shows danger zone)
// 5 = only pass fragments in danger zone (opacity 0.25–0.42) — shows contested pixels
// 6 = force angle term to 1.0 — removes viewing angle dependency, keeps texture opacity + discard
// 7 = force mip 0 on all texture samples — eliminates mip-level oscillation as flicker source
// 8 = force opacity to constant 0.5 (above threshold) — tests if flicker is from rasterization coverage
// 9 = LOWERED THRESHOLD FIX: step(0.10, opacity) — catches most danger-zone pixels as "pass"
//     Tune the value below: lower = denser shadows + less flicker, higher = thinner + more flicker
#define DBG_SHADOW_MODE 0

// Tunable threshold for Mode 9 — adjust and hot-reload to find the sweet spot
// 0.333 = vanilla (max flicker), 0.10 = very low (almost no flicker, dense shadows)
// Try: 0.20, 0.15, 0.10
#define DBG_FIX_THRESHOLD 0.15

// Coverage boost toggle (independent of noise mode)
// 0 = no coverage boost (raw opacity values)
// 1 = Castaño/Wyman mip compensation active
#define DBG_COVERAGE_BOOST 0

layout(set = 1, binding = 1, std140) uniform _13_10
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
} _10;

layout(set = 0, binding = 7) uniform sampler _9;
layout(set = 1, binding = 3) uniform texture2D _11;
layout(set = 1, binding = 4) uniform texture2D _12;

// IS-FAST noise (128x128x32 R8G8_UNORM texture array) — injected by addon
layout(set = 3, binding = 1) uniform texture2DArray isFastNoise;

layout(push_constant) uniform RenoDXPushConstants {
    float peak_white_nits;              // 0
    float diffuse_white_nits;           // 4
    float graphics_white_nits;          // 8
    float gamma_correction;             // 12
    float tone_map_exposure;            // 16
    float tone_map_highlights;          // 20
    float tone_map_shadows;             // 24
    float tone_map_contrast;            // 28
    float tone_map_saturation;          // 32
    float tone_map_highlight_saturation;// 36
    float tone_map_dechroma;            // 40
    float tone_map_flare;               // 44
    float color_grade_strength;         // 48
    float tone_map_hue_shift;           // 52
    float tone_map_blowout;             // 56
    float custom_curve;                 // 60
    float hue_correction;               // 64
    float custom_random;                // 68
    float custom_grain_strength;        // 72
    float custom_bloom;                 // 76
    float rendering_cubemap_mod;        // 84
    float rendering_ao_direct;          // 88
    float rendering_shadow_improvements; // 92
    float rendering_micro_shadows;       // 96
    float rendering_micro_shadows_debug; // 100
    float rendering_specular_occlusion;  // 104
    float rendering_probe_ao;            // 108
    float rendering_horizon_occlusion;   // 112
    float rendering_diffuse_brdf;        // 116
    float hero_lighting;                 // 120
    float rendering_gbuffer_improvements;// 124
    float rendering_fog_haze_aa;         // 128
    float rendering_fog_color_correction;// 132
    float rendering_isfast_noise;        // 136
} pc;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _4;
layout(location = 2) in vec3 _5;
layout(location = 3) in vec3 _6;
layout(location = 4) in vec3 _7;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec3 _55 = _4 * fma(float(gl_FrontFacing), 2.0, -1.0);
    mat3 _56 = mat3(_6, _55, _5);

#if DBG_SHADOW_MODE == 7
    // Mode 7: Force mip 0 — eliminates mip-level oscillation from cascade refitting.
    // Uses textureLod with explicit LOD 0 instead of implicit-LOD texture() which
    // relies on screen-space derivatives (unstable in shadow pass due to cascade refit).
    vec4 _79 = textureLod(sampler2D(_12, _9), _3 + vec2(fma(textureLod(sampler2D(_11, _9), _3 * _10._m2, 0.0).x, 2.0, -1.0) * _10._m3), 0.0) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _85 = textureLod(sampler2D(_12, _9), _3, 0.0) - vec4(0.5, 0.0, 0.0, 0.0);
#elif DBG_SHADOW_MODE == 8
    // Mode 8: Force opacity to constant 0.5 — removes ALL texture/angle dependency.
    // Every fragment that gets rasterized will pass the 0.333 threshold.
    // This is functionally similar to Mode 2, but still goes through the discard path.
    // If flicker PERSISTS → the rasterization coverage itself changes frame-to-frame
    //   (different fragments exist each frame due to shadow frustum sub-texel shift).
    // If flicker STOPS → same as Mode 2 (expected: major reduction).
    vec2 _constUV = vec2(0.5, 0.5);
    vec4 _79 = textureLod(sampler2D(_12, _9), _constUV + vec2(fma(textureLod(sampler2D(_11, _9), _constUV * _10._m2, 0.0).x, 2.0, -1.0) * _10._m3), 0.0) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _85 = textureLod(sampler2D(_12, _9), _constUV, 0.0) - vec4(0.5, 0.0, 0.0, 0.0);
#else
    vec4 _79 = texture(sampler2D(_12, _9), _3 + vec2(fma(texture(sampler2D(_11, _9), _3 * _10._m2).x, 2.0, -1.0) * _10._m3)) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _85 = texture(sampler2D(_12, _9), _3) - vec4(0.5, 0.0, 0.0, 0.0);
#endif
    vec4 _93 = fma(spvNMax(vec4(ivec4(sign(_79))), vec4(ivec4(sign(_85)))), spvNMax(abs(_79), abs(_85)), vec4(0.5, 0.0, 0.0, 0.0));

    // Hair opacity: strand coverage × viewing angle factor × material scale
    float _opacity = ((_93.w * fma(-_93.z, _10._m4, 1.0)) * clamp(abs(dot(normalize(_56 * normalize(normalize(-_7) * _56)), normalize(_55))) * 5.0, 0.0, 1.0)) * _10._m5;

#if DBG_SHADOW_MODE == 6
    // Mode 6: Force angle term to 1.0 — removes ONLY the viewing angle dependency.
    // Keeps texture-derived coverage (_93.w), z-attenuation (fma(-_93.z, ...)), and material scale (_10._m5).
    // If flicker STOPS → the angle term oscillates frame-to-frame (light-space TBN instability).
    // If flicker PERSISTS → the texture sampling itself is unstable.
    _opacity = (_93.w * fma(-_93.z, _10._m4, 1.0)) * _10._m5;
#endif

#if DBG_SHADOW_MODE == 8
    // Mode 8: Force opacity to constant 0.5 — above threshold, all rasterized fragments pass.
    // This isolates whether the flicker is from rasterization coverage changing per frame.
    _opacity = 0.5;
#endif

#if DBG_COVERAGE_BOOST == 1
    // Coverage-preserving alpha rescaling (Castaño / Wyman technique)
    float _uvRate = max(length(dFdx(_3)), length(dFdy(_3)));
    float _coverageBoost = clamp(1.0 + _uvRate * 8.0, 1.0, 2.5);
    _opacity = clamp(_opacity * _coverageBoost, 0.0, 1.0);
#endif

    // === Debug mode dispatch ===
#if DBG_SHADOW_MODE == 2
    // Force pass: all fragments write to shadow depth — no discard
    return;
#elif DBG_SHADOW_MODE == 3
    // Force fail: all fragments discard — shadow map will be empty for hair
    discard;
#elif DBG_SHADOW_MODE == 4
    // Inverted: discard where vanilla would PASS (show what vanilla kills)
    if (_opacity >= 0.33329999446868896484375)
        discard;
    return;
#elif DBG_SHADOW_MODE == 5
    // Danger zone only: pass ONLY fragments with opacity in [0.25, 0.42]
    if (_opacity < 0.25 || _opacity > 0.42)
        discard;
    return;
#elif DBG_SHADOW_MODE == 1
    // IS-FAST stochastic alpha test (narrow band)
    {
        uint _isFastFrame = uint(pc.custom_random * 31.0);
        float _noise = texelFetch(isFastNoise, ivec3(ivec2(gl_FragCoord.xy) & 127, int(_isFastFrame & 31u)), 0).r;
        float _threshold = mix(0.25, 0.42, _noise);
        if (_opacity < _threshold)
            discard;
    }
#elif DBG_SHADOW_MODE == 9
    // Mode 9: Lowered threshold fix — the practical solution.
    // Root cause: sub-texel UV interpolation shifts from shadow frustum refitting cause
    // opacity values to oscillate around 0.333. By lowering the threshold, we move the
    // "danger zone" to a range where fewer pixels live, reducing visible flicker.
    if (_opacity < DBG_FIX_THRESHOLD)
        discard;
#else
    // Mode 0 and Mode 6: Vanilla — hard binary cutoff at 0.333
    // (Mode 6 differs only in the opacity computation above, not the threshold)
    if (step(0.33329999446868896484375, _opacity) < 0.5)
        discard;
#endif
}
