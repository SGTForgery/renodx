#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_spirv_intrinsics : require
#extension GL_EXT_samplerless_texture_functions : require
layout(depth_less) out float gl_FragDepth;

// === DEBUG DEFINES — change and hot-reload via DevKit ===
// 0 = normal rendering (production path)
// 1 = visualize coverage alpha (GBuffer .w output) as grayscale albedo
// 2 = visualize depth offset (_225) as heat — blue(0) → red(max)
// 3 = visualize opacity "danger zone" — red where coverage ∈ [0.25, 0.42]
// 4 = visualize the viewing angle dot product from shadow caster's formula
//     (recomputed here for visual inspection — maps abs(dot)*5 to grayscale)
// 5 = visualize IS-FAST noise value at this pixel (frame-coherent check)
// 6 = visualize _15._m9 equivalent (opacity multiplier from UBO)
//     → since GBuffer uses _20 UBO, shows _20._m38 which is the coverage scale
// 7 = flat magenta — confirms shader is hot-loaded and active
#define DBG_GBUFFER_MODE 0

vec4 _159;
float _160;
vec4 _161;

layout(set = 0, binding = 2, std140) uniform _25_16
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _16;

layout(set = 1, binding = 0, std140) uniform _26_19
{
    layout(row_major) mat4 _m0;
    uint _m1;
    uint _m2;
    uint _m3;
    uint _m4;
} _19;

layout(set = 1, binding = 1, std140) uniform _27_20
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    vec3 _m6;
    float _m7;
    vec3 _m8;
    float _m9;
    vec3 _m10;
    float _m11;
    vec3 _m12;
    float _m13;
    vec3 _m14;
    float _m15;
    vec3 _m16;
    float _m17;
    float _m18;
    float _m19;
    float _m20;
    float _m21;
    float _m22;
    float _m23;
    float _m24;
    float _m25;
    float _m26;
    float _m27;
    float _m28;
    float _m29;
    float _m30;
    float _m31;
    float _m32;
    float _m33;
    float _m34;
    float _m35;
    float _m36;
    float _m37;
    float _m38;
    float _m39;
    float _m40;
    float _m41;
} _20;

layout(set = 0, binding = 7) uniform sampler _17;
layout(set = 0, binding = 8) uniform sampler _18;
layout(set = 1, binding = 3) uniform texture2D _21;
layout(set = 1, binding = 4) uniform texture2D _22;
layout(set = 1, binding = 5) uniform texture2D _23;
layout(set = 1, binding = 6) uniform texture2D _24;

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
layout(location = 2) in vec4 _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in vec3 _9;
layout(location = 0) out vec4 _11;
layout(location = 1) out vec4 _12;
layout(location = 2) out vec4 _13;
layout(location = 3) out vec4 _14;

spirv_instruction(set = "GLSL.std.450", id = 79) float spvNMin(float, float);
spirv_instruction(set = "GLSL.std.450", id = 79) vec2 spvNMin(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 79) vec3 spvNMin(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 79) vec4 spvNMin(vec4, vec4);
spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    float _166 = 1.0 / gl_FragCoord.w;
    vec2 _175 = _3 * _20._m5;
    vec4 _179 = texture(sampler2D(_21, _17), _175);
    vec4 _189 = texture(sampler2D(_22, _17), _3 + vec2(fma(_179.x, 2.0, -1.0) * _20._m7));
    vec4 _190 = _189 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _195 = texture(sampler2D(_22, _17), _3);
    vec4 _196 = _195 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _204 = fma(spvNMax(vec4(ivec4(sign(_190))), vec4(ivec4(sign(_196)))), spvNMax(abs(_190), abs(_196)), vec4(0.5, 0.0, 0.0, 0.0));
    float _216 = clamp(_20._m15, 0.0, 1.0);
    float _225 = spvNMax((1.0 - _204.y) * mix(_20._m9 * 0.00999999977648258209228515625, _20._m11 * 0.00999999977648258209228515625, smoothstep(fma(-_216, 0.5, _20._m13), fma(_216, 0.5, _20._m13), _204.z)), 0.0);
    vec4 _253;
    if (_16._m1[3u].w != 1.0)
    {
        vec4 _243;
        _243.z = fma(gl_FragCoord.z, _166, _225 * (_16._m3 / (_16._m3 - _16._m4))) / (_166 + _225);
        _253 = _243;
    }
    else
    {
        vec4 _252;
        _252.z = gl_FragCoord.z + (_225 / (_16._m3 - _16._m4));
        _253 = _252;
    }
    float _255 = fma(float(gl_FrontFacing), 2.0, -1.0);
    vec3 _257 = normalize(_5) * _255;

    // === Recompute shadow-caster-equivalent opacity for debug visualization ===
    // This mirrors the shadow caster's formula using GBuffer's available data
    // _204.w = flow map .w channel (strand coverage mask)
    // _204.z = flow map .z channel (used in opacity attenuation)
    // _20._m9 corresponds to _10._m4 in shadow caster (z-attenuation scale)
    // _20._m11 corresponds to _10._m5 in shadow caster (overall opacity scale)
    // NOTE: The shadow caster uses _10._m4 and _10._m5 from a DIFFERENT UBO (set 1, binding 1)
    //       than the GBuffer's _20 UBO. Values may differ per-material.

    // --- Compute coverage alpha (same as production) ---
    vec3 _273 = vec3(_20._m18);
    vec3 _279 = mix(_20._m4, _20._m6, _273);
    float _281 = fract(_3.y);
    float _286 = mix(_20._m19, _20._m20, _20._m18);
    float _291 = fma(-spvNMax(fma(_286, 0.800000011920928955078125, -0.75), 0.0), 4.0, 1.0);
    float _295 = fma(texture(sampler2D(_21, _17), _175).x, 2.0, -1.0);
    vec4 _301 = texture(sampler2D(_22, _17), _3 + vec2(_295 * _20._m7)) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _307 = texture(sampler2D(_22, _17), _3) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _315 = fma(spvNMax(vec4(ivec4(sign(_301))), vec4(ivec4(sign(_307)))), spvNMax(abs(_301), abs(_307)), vec4(0.5, 0.0, 0.0, 0.0));
    float _316 = _315.x;
    float _325 = -fract(_6.x + _20._m21);
    float _329 = -_286;
    float _332 = ceil(_286 * 0.800000011920928955078125);
    float _334 = clamp((-fma(_329, 0.800000011920928955078125, 1.0 - abs(fma(_325, 0.4000000059604644775390625, fma(_281, _291, -fma(_316, 2.0, -0.5)))))) * _332, 0.0, 1.0);
    vec3 _355 = mix(mix(mix(_20._m0, _20._m2, _273), _279, vec3(_334)), mix(_20._m8, _20._m10, _273), vec3(clamp((clamp(_6.z - _20._m22, 0.0, 1.0) / (1.0 - _20._m22)) * 1.5, 0.0, 1.0) * _20._m23));
    vec3 _356 = _355 * 0.5;
    float _363 = clamp(_20._m25, 0.0, 1.0);
    float _369 = smoothstep(fma(-_363, 0.5, _20._m24), fma(_363, 0.5, _20._m24), _315.z);
    float _389 = abs(1.0);
    float _390 = spvNMax(_389, 9.9999997473787516355514526367188e-06);
    vec3 _432 = _20._m14 * fma(-_20._m31, 0.800000011920928955078125, 1.0);
    vec4 _434 = texture(sampler2D(_21, _17), _3);
    float _437 = _434.w;
    vec3 _440 = _432 + (_432 * (1.0 - _437));
    float _448 = spvNMax(0.25, step(0.5, _3.y) * 0.100000001490116119384765625);
    vec2 _465 = vec2(_20._m32, _20._m33);
    vec2 _466 = vec2(1.0) - _465;
    vec2 _469 = clamp(_465, vec2(9.9999999747524270787835121154785e-07), vec2(1.0));
    vec2 _471 = clamp(_465, vec2(0.0), vec2(1.0));
    vec2 _472 = (clamp(pow(spvNMax(abs(vec2(1.0 - _434.x, 1.0) * _316), vec2(9.9999997473787516355514526367188e-05)), vec2(1.5)) - _466, vec2(0.0), vec2(1.0)) / _469) * _471;
    vec3 _477 = mix((((texture(sampler2D(_23, _17), _3).xyz * 2.0) + vec3(-1.0)) * _20._m17) + fma((mix(mix(vec3(dot(_356, vec3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875))), _356, vec3(1.2000000476837158203125)), _355, vec3(clamp(mix(_369, pow(spvNMax(abs(spvNMin(spvNMin(clamp((_3 * vec2(1.0, 2.0)).y * 2.0, 0.0, 1.0), _6.w), _369)), 9.9999997473787516355514526367188e-05), _20._m26), _20._m27), 0.0, 1.0))) * mix(1.0, 0.20000000298023223876953125 + ((_316 * 1.7999999523162841796875) / _390), _20._m28)) * mix(1.0, 0.5 + ((pow(spvNMax(abs(_315.y), 9.9999997473787516355514526367188e-05), 2.2000000476837158203125) * 1.5) / _390), _20._m29), spvNMax(vec3(0.0), fma(textureLod(sampler2D(_24, _18), vec2(_316, 0.0), 0.0).xyz - vec3(0.5), _20._m12 * _334, vec3(1.0))), vec3(_295 * _20._m30)), mix(vec3(dot(_440, vec3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875))), _440, vec3(fma(_20._m31, 2.0, 1.0))), vec3(clamp(clamp(fma(-(_20._m31 - spvNMax(0.20000000298023223876953125 * _434.y, _437)), 3.0, _448), 0.0, 1.0) * _472.y, 0.0, 1.0)));
    vec4 _501 = texture(sampler2D(_22, _17), _3 + vec2(fma(texture(sampler2D(_21, _17), _175).x, 2.0, -1.0) * _20._m7)) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _507 = texture(sampler2D(_22, _17), _3) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _515 = fma(spvNMax(vec4(ivec4(sign(_501))), vec4(ivec4(sign(_507)))), spvNMax(abs(_501), abs(_507)), vec4(0.5, 0.0, 0.0, 0.0));
    float _523 = mix(1.0, 0.5 + (((1.0 - _515.y) * 1.5) / _390), _20._m35);
    vec4 _527 = texture(sampler2D(_21, _17), _3);
    vec2 _547 = (clamp(pow(spvNMax(abs(vec2(1.0 - _527.x, 1.0) * _515.x), vec2(9.9999997473787516355514526367188e-05)), vec2(1.5)) - _466, vec2(0.0), vec2(1.0)) / _469) * _471;
    float _550 = clamp(clamp(fma(-(_20._m31 - spvNMax(0.20000000298023223876953125 * _527.y, _527.w)), 3.0, _448), 0.0, 1.0) * _547.y, 0.0, 1.0);
    float _569 = fma(texture(sampler2D(_21, _17), _175).x, 2.0, -1.0);
    vec4 _575 = texture(sampler2D(_22, _17), _3 + vec2(_569 * _20._m7)) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _581 = texture(sampler2D(_22, _17), _3) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _602 = texture(sampler2D(_21, _17), _3);
    vec4 _621 = texture(sampler2D(_22, _17), _3 + vec2(fma(texture(sampler2D(_21, _17), _175).x, 2.0, -1.0) * _20._m7)) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _627 = texture(sampler2D(_22, _17), _3) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _635 = fma(spvNMax(vec4(ivec4(sign(_621))), vec4(ivec4(sign(_627)))), spvNMax(abs(_621), abs(_627)), vec4(0.5, 0.0, 0.0, 0.0));
    float _636 = _635.x;
    vec3 _674 = normalize(mat3(_9, _7 * _255, _8) * ((vec3(0.0, 1.0, 0.0) * fma(_20._m36, fma(2.0, 1.0 - fma(spvNMax(vec4(ivec4(sign(_575))), vec4(ivec4(sign(_581)))), spvNMax(abs(_575), abs(_581)), vec4(0.5, 0.0, 0.0, 0.0)).x, -1.0), _569 * _20._m37)) + vec3(0.0, 0.0, 1.0)));
    vec3 _686 = _674 / vec3((abs(_674.x) + abs(_674.y)) + abs(_674.z));
    vec2 _690 = _686.xy;
    vec2 _702 = roundEven((clamp(mix((vec2(1.0) - abs(_686.yx)) * mix(vec2(-1.0), vec2(1.0), greaterThanEqual(_690, vec2(0.0))), _690, bvec2(_686.z >= 0.0)).xy, vec2(-1.0), vec2(1.0)) * 2047.0) + vec2(2047.0));
    float _703 = _702.y;
    float _705 = floor(_703 * 0.00390625);
    float _707 = _702.x * 0.0625;
    vec3 _714 = floor(vec3(_707, fma(fract(_707), 256.0, _705), fma(-_705, 256.0, _703))) * vec3(0.0039215688593685626983642578125);
    vec4 _715 = vec4(_714.x, _714.y, _714.z, _159.w);

    // --- Coverage alpha computation ---
    float _baseCoverage = clamp(fma(-clamp(clamp(fma(-(_20._m31 - spvNMax(0.20000000298023223876953125 * _602.y, _602.w)), 3.0, _448), 0.0, 1.0) * ((clamp(pow(spvNMax(abs(vec2(_160, 1.0) * _636), vec2(9.9999997473787516355514526367188e-05)), vec2(1.5)) - _466, vec2(0.0), vec2(1.0)) / _469) * _471).y, 0.0, 1.0), 0.300000011920928955078125, 1.0) * clamp(fma(clamp((-fma(_329, 0.800000011920928955078125, 1.0 - abs(fma(_325, 0.4000000059604644775390625, fma(_281, _291, -fma(_636, 2.0, -0.5)))))) * _332, 0.0, 1.0), fma(clamp(dot(_279, vec3(1.0)), 0.0, 1.0), 2.0, -1.0), _20._m38), 0.0, 1.0), 0.00999999977648258209228515625, 1.0);

    // Coverage-preserving alpha rescaling (Castaño / Wyman technique)
    if (pc.rendering_isfast_noise > 0.5)
    {
        float _uvRate = max(length(dFdx(_3)), length(dFdy(_3)));
        float _coverageBoost = clamp(1.0 + _uvRate * 8.0, 1.0, 2.5);
        _baseCoverage = clamp(_baseCoverage * _coverageBoost, 0.01, 1.0);
    }

    // IS-FAST jitter for temporal supersampling
    if (pc.rendering_isfast_noise > 0.5)
    {
        uint _isFastFrame = uint(pc.custom_random * 31.0);
        vec2 _isFastSample = texelFetch(isFastNoise, ivec3(ivec2(gl_FragCoord.xy) & 127, int(_isFastFrame & 31u)), 0).rg;
        float edgeness = smoothstep(0.0, 0.3, _baseCoverage) * smoothstep(1.0, 0.7, _baseCoverage);
        _baseCoverage += (_isFastSample.r - 0.5) * 0.12 * edgeness;
        _baseCoverage = clamp(_baseCoverage, 0.01, 1.0);
    }
    _715.w = _baseCoverage;

    // === DEBUG VISUALIZATION ===
#if DBG_GBUFFER_MODE == 7
    // Mode 7: flat magenta — confirms shader is hot-loaded
    _11 = vec4(0.0);
    _12 = vec4(1.0, 0.0, 1.0, 1.0);
    _13 = vec4(0.5, 0.5, 0.0, float((5u | ((_19._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = _715;
    gl_FragDepth = _253.z;
    return;
#elif DBG_GBUFFER_MODE == 1
    // Mode 1: visualize coverage alpha as grayscale
    // Dark = low coverage (thin hair, likely to be discarded by alpha test)
    // Bright = high coverage (solid hair, always passes)
    vec3 _dbgColor = vec3(_baseCoverage);
    _11 = vec4(0.5, 0.5, 0.0, 0.0);
    _12 = vec4(_dbgColor, 1.0);
    _13 = vec4(0.5, 0.5, 0.0, float((5u | ((_19._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = _715;
    gl_FragDepth = _253.z;
    return;
#elif DBG_GBUFFER_MODE == 2
    // Mode 2: visualize depth offset _225 as heat map
    // _225 is the strand layer sorting offset — how much depth is shifted
    // Blue = 0, Green = mid, Red = high offset
    float _dbgDepthNorm = clamp(_225 * 50.0, 0.0, 1.0); // scale for visibility
    vec3 _dbgColor = mix(vec3(0.0, 0.0, 1.0), vec3(1.0, 0.0, 0.0), _dbgDepthNorm);
    _11 = vec4(0.5, 0.5, 0.0, 0.0);
    _12 = vec4(_dbgColor, 1.0);
    _13 = vec4(0.5, 0.5, 0.0, float((5u | ((_19._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = _715;
    gl_FragDepth = _253.z;
    return;
#elif DBG_GBUFFER_MODE == 3
    // Mode 3: danger zone visualization
    // Shows where coverage alpha falls in the [0.25, 0.42] band
    // RED = in danger zone (these pixels flip between pass/fail with noise)
    // GREEN = safely above 0.42 (always passes)
    // BLUE = safely below 0.25 (always fails in stochastic mode)
    // YELLOW = at exact vanilla threshold 0.333 ± 0.02
    vec3 _dbgColor;
    if (_baseCoverage >= 0.25 && _baseCoverage <= 0.42) {
        // In danger zone
        if (abs(_baseCoverage - 0.333) < 0.02)
            _dbgColor = vec3(1.0, 1.0, 0.0); // yellow = right at vanilla threshold
        else
            _dbgColor = vec3(1.0, 0.0, 0.0); // red = contested
    } else if (_baseCoverage > 0.42) {
        _dbgColor = vec3(0.0, 1.0, 0.0); // green = safe pass
    } else {
        _dbgColor = vec3(0.0, 0.0, 1.0); // blue = safe fail
    }
    _11 = vec4(0.5, 0.5, 0.0, 0.0);
    _12 = vec4(_dbgColor, 1.0);
    _13 = vec4(0.5, 0.5, 0.0, float((5u | ((_19._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = _715;
    gl_FragDepth = _253.z;
    return;
#elif DBG_GBUFFER_MODE == 4
    // Mode 4: visualize the viewing-angle dot product term
    // This is the abs(dot(tangent, view)) * 5.0 clamped to [0,1] from the shadow caster
    // Recomputed here using GBuffer's TBN and view direction
    // If this oscillates frame-to-frame (visible as shimmer), TAA jitter is the culprit
    vec3 _dbgNormal = normalize(_5) * _255;
    // We can't perfectly replicate the shadow caster's light-space view here,
    // but we can show the camera-space viewing angle which shares the same TBN
    float _dbgAngle = clamp(abs(dot(normalize(_dbgNormal), normalize(vec3(gl_FragCoord.xy / vec2(1920.0, 1080.0) * 2.0 - 1.0, 1.0)))) * 5.0, 0.0, 1.0);
    vec3 _dbgColor = vec3(_dbgAngle);
    _11 = vec4(0.5, 0.5, 0.0, 0.0);
    _12 = vec4(_dbgColor, 1.0);
    _13 = vec4(0.5, 0.5, 0.0, float((5u | ((_19._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = _715;
    gl_FragDepth = _253.z;
    return;
#elif DBG_GBUFFER_MODE == 5
    // Mode 5: visualize IS-FAST noise at this pixel
    // Shows the actual noise value used for stochastic decisions
    // Should appear as a structured blue noise pattern, NOT random static
    uint _dbgFrame = uint(pc.custom_random * 31.0);
    vec2 _dbgNoise = texelFetch(isFastNoise, ivec3(ivec2(gl_FragCoord.xy) & 127, int(_dbgFrame & 31u)), 0).rg;
    vec3 _dbgColor = vec3(_dbgNoise.r, _dbgNoise.g, 0.0);
    _11 = vec4(0.5, 0.5, 0.0, 0.0);
    _12 = vec4(_dbgColor, 1.0);
    _13 = vec4(0.5, 0.5, 0.0, float((5u | ((_19._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = _715;
    gl_FragDepth = _253.z;
    return;
#elif DBG_GBUFFER_MODE == 6
    // Mode 6: visualize _20._m38 (the coverage scale factor from UBO)
    // This is the equivalent of _15._m9 in the depth pre-pass shader
    // If < 1.0, it compresses the alpha range before threshold comparison
    // Output: grayscale value of the scale factor (expect 0.5-1.0 range)
    float _dbgScale = clamp(_20._m38, 0.0, 1.0);
    vec3 _dbgColor = vec3(_dbgScale);
    _11 = vec4(0.5, 0.5, 0.0, 0.0);
    _12 = vec4(_dbgColor, 1.0);
    _13 = vec4(0.5, 0.5, 0.0, float((5u | ((_19._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = _715;
    gl_FragDepth = _253.z;
    return;
#endif

    // === Normal rendering (Mode 0) ===
    vec2 _724 = (((_257.xy / vec2(1.0 - _257.z)) * vec2(0.562524616718292236328125)) * 0.5) + vec2(0.5);
    vec3 _726 = clamp(mix(_477, _20._m16, vec3(pow(spvNMax(abs(texture(sampler2D(_21, _17), _3).z * clamp(_472.x + _20._m32, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 2.0))), vec3(0.0), vec3(1.0));
    vec4 _727 = vec4(_726.x, _726.y, _726.z, _159.w);
    _727.w = 1.0;
    _11 = vec4(_724.x, _724.y, vec4(0.0).z, vec4(0.0).w);
    _12 = _727;
    _13 = vec4(clamp(mix(mix(fma(_20._m34, _523, _550), fma(_20._m34, _523, _550 * (-0.20000000298023223876953125)), _20._m31), 0.20000000298023223876953125, pow(spvNMax(abs(texture(sampler2D(_21, _17), _3).z * clamp(_547.x + _20._m32, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 2.0)), 0.0, 1.0), 0.5, clamp(_20._m39, 0.0, 1.0), float((5u | ((_19._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = _715;
    gl_FragDepth = _253.z;
}
