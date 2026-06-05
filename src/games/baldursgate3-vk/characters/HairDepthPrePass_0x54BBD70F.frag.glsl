#version 450
#extension GL_EXT_spirv_intrinsics : require
#extension GL_EXT_samplerless_texture_functions : require
layout(depth_less) out float gl_FragDepth;

// === DEBUG DEFINES — change and hot-reload via DevKit ===
// 0 = vanilla rendering (hard step when _12._m3 == 0, IGN+R2 otherwise)
// 1 = force ALL fragments to PASS (no discard, still writes depth offset)
// 2 = force ALL fragments to FAIL (all discard)
// 3 = vanilla hard step(0.333) ALWAYS (ignore engine stochastic flag)
// 4 = bypass depth offset (_138 = 0) — test if depth offset causes TAA issues
// 5 = bypass viewing angle term — test if angle factor oscillates with jitter
#define DBG_PREPASS_MODE 0

// Coverage boost toggle (independent of noise mode)
// 0 = no coverage boost
// 1 = Castaño/Wyman mip compensation active
#define DBG_COVERAGE_BOOST 0

layout(set = 0, binding = 0, std140) uniform _18_12
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _12;

layout(set = 0, binding = 2, std140) uniform _19_13
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _13;

layout(set = 1, binding = 1, std140) uniform _20_15
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
    float _m8;
    float _m9;
    float _m10;
    float _m11;
} _15;

layout(set = 0, binding = 7) uniform sampler _14;
layout(set = 1, binding = 3) uniform texture2D _16;
layout(set = 1, binding = 4) uniform texture2D _17;

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
layout(location = 1) in vec3 _5;
layout(location = 2) in vec3 _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in vec4 _9;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec4 _77 = gl_FragCoord;
    float _79 = 1.0 / _77.w;
    vec2 _88 = _3 * _15._m2;
    vec4 _92 = texture(sampler2D(_16, _14), _88);
    vec4 _102 = texture(sampler2D(_17, _14), _3 + vec2(fma(_92.x, 2.0, -1.0) * _15._m3));
    vec4 _103 = _102 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _108 = texture(sampler2D(_17, _14), _3);
    vec4 _109 = _108 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _117 = fma(spvNMax(vec4(ivec4(sign(_103))), vec4(ivec4(sign(_109)))), spvNMax(abs(_103), abs(_109)), vec4(0.5, 0.0, 0.0, 0.0));
    float _129 = clamp(_15._m7, 0.0, 1.0);

    // _138 = depth offset for hair strand volume sorting
#if DBG_PREPASS_MODE == 4
    // Debug: zero out depth offset to test if it causes TAA depth-rejection issues
    float _138 = 0.0;
#else
    float _138 = spvNMax((1.0 - _117.y) * mix(_15._m4 * 0.00999999977648258209228515625, _15._m5 * 0.00999999977648258209228515625, smoothstep(fma(-_129, 0.5, _15._m6), fma(_129, 0.5, _15._m6), _117.z)), 0.0);
#endif

    vec4 _166;
    if (_13._m1[3u].w != 1.0)
    {
        vec4 _156 = _77;
        _156.z = fma(_77.z, _79, _138 * (_13._m3 / (_13._m3 - _13._m4))) / (_79 + _138);
        _166 = _156;
    }
    else
    {
        vec4 _165 = _77;
        _165.z = _77.z + (_138 / (_13._m3 - _13._m4));
        _166 = _165;
    }

    // --- Opacity computation ---
    vec3 _169 = _5 * fma(float(gl_FrontFacing), 2.0, -1.0);
    mat3 _170 = mat3(_7, _169, _6);
    vec4 _181 = texture(sampler2D(_16, _14), _88);
    vec4 _188 = texture(sampler2D(_17, _14), _3 + vec2(fma(_181.x, 2.0, -1.0) * _15._m3));
    vec4 _189 = _188 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _194 = texture(sampler2D(_17, _14), _3);
    vec4 _195 = _194 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _203 = fma(spvNMax(vec4(ivec4(sign(_189))), vec4(ivec4(sign(_195)))), spvNMax(abs(_189), abs(_195)), vec4(0.5, 0.0, 0.0, 0.0));

#if DBG_PREPASS_MODE == 5
    // Debug: bypass viewing angle term — use only texture coverage * material scale
    // If this eliminates thinning, the angle term oscillates with TAA jitter
    float _217 = _203.w * fma(-_203.z, _15._m8, 1.0);
#else
    // Full opacity: coverage × angle attenuation × material
    float _217 = (_203.w * fma(-_203.z, _15._m8, 1.0)) * clamp(abs(dot(normalize(_170 * normalize(normalize(-(_8 + ((-normalize(_8)) * _138))) * _170)), normalize(_169))) * 5.0, 0.0, 1.0);
#endif

#if DBG_COVERAGE_BOOST == 1
    // Coverage-preserving alpha rescaling (Castaño / Wyman technique)
    float _uvRate = max(length(dFdx(_3)), length(dFdy(_3)));
    float _coverageBoost = clamp(1.0 + _uvRate * 8.0, 1.0, 2.5);
    _217 = clamp(_217 * _coverageBoost, 0.0, 1.0);
#endif

    // === Debug mode dispatch for alpha test ===
#if DBG_PREPASS_MODE == 1
    // Force pass: no discard, write depth offset as normal
    // This shows what the depth buffer looks like with ALL hair fragments present
#elif DBG_PREPASS_MODE == 2
    // Force fail: discard everything
    discard;
#elif DBG_PREPASS_MODE == 3
    // Force vanilla hard step regardless of engine stochastic flag
    if (step(0.33329999446868896484375, _217 * _15._m9) < 0.5)
        discard;
#else
    // Mode 0 (and 4, 5): use engine's alpha test logic
    float _248;
    if (_12._m3 != 0.0)
    {
        // IGN + R2 temporal sequence (engine's stochastic mode)
        float _ign = fract(52.9829189 * fract(0.06711056 * _166.x + 0.00583715 * _166.y));
        float _noiseVal = fract(_ign + 0.7548776662466927 * _12._m2 + _9.x);
        _248 = fma(_217, _15._m9, _noiseVal - 0.66670000553131103515625);
    }
    else
    {
        _248 = step(0.33329999446868896484375, _217 * _15._m9);
    }
    if ((_248 - 0.33329999446868896484375) < 0.0)
    {
        discard;
    }
#endif

    gl_FragDepth = _166.z;
}
