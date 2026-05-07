#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_scalar_block_layout : require
#extension GL_EXT_spirv_intrinsics : require
#if defined(GL_EXT_control_flow_attributes)
#extension GL_EXT_control_flow_attributes : require
#define SPIRV_CROSS_FLATTEN [[flatten]]
#define SPIRV_CROSS_BRANCH [[dont_flatten]]
#define SPIRV_CROSS_UNROLL [[unroll]]
#define SPIRV_CROSS_LOOP [[dont_unroll]]
#else
#define SPIRV_CROSS_FLATTEN
#define SPIRV_CROSS_BRANCH
#define SPIRV_CROSS_UNROLL
#define SPIRV_CROSS_LOOP
#endif
#extension GL_KHR_shader_subgroup_basic : require
#extension GL_KHR_shader_subgroup_quad : require

struct _66
{
    vec4 _m0;
    vec4 _m1;
    vec4 _m2;
    float _m3;
    float _m4;
    float _m5;
    uint _m6;
    uint _m7;
    float _m8;
    ivec2 _m9;
};

struct _69
{
    vec3 _m0;
    uint _m1;
    vec4 _m2;
    vec2 _m3;
    uint _m4;
    float _m5;
    mat4x3 _m6;
    vec3 _m7;
    uint _m8;
    vec3 _m9;
    float _m10;
};

struct _73
{
    vec4 _m0;
    mat4x3 _m1;
    vec4 _m2[4];
    float _m3;
    float _m4;
    uint _m5;
    uint _m6;
};

struct _78
{
    mat4 _m0;
    vec2 _m1;
    float _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    float _m6;
};

float _315;
const vec4 _332[4] = vec4[](vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
vec3 _352;
vec3 _359;

layout(set = 0, binding = 0, std140) uniform _54_15
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _15;

layout(set = 0, binding = 1, std140) uniform _56_16
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    layout(row_major) mat4 _m6;
    vec4 _m7[3];
    vec4 _m8;
    vec4 _m9;
    float _m10;
    float _m11;
    float _m12;
    float _m13;
    float _m14;
    float _m15;
    float _m16;
    float _m17;
    vec4 _m18;
    float _m19;
    float _m20;
    float _m21;
    float _m22;
    vec4 _m23;
    vec3 _m24;
    float _m25;
    vec3 _m26;
    float _m27;
    vec4 _m28;
    vec3 _m29;
    float _m30;
    vec4 _m31;
    vec3 _m32;
    float _m33;
    vec3 _m34;
    float _m35;
    vec3 _m36;
    float _m37;
} _16;

layout(set = 0, binding = 2, std140) uniform _57_17
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _17;

layout(set = 0, binding = 3, std140) uniform _58_18
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _18;

layout(set = 0, binding = 4, std140) uniform _59_19
{
    vec2 _m0;
    vec2 _m1;
    uvec2 _m2;
    uvec2 _m3;
    uvec2 _m4;
    uint _m5;
    uint _m6;
    vec2 _m7;
    vec2 _m8;
    vec2 _m9;
    vec2 _m10;
    vec2 _m11;
    vec2 _m12;
    vec2 _m13;
    vec2 _m14;
    vec2 _m15;
    vec2 _m16;
    uvec2 _m17;
    uvec2 _m18;
    uvec2 _m19;
    uvec2 _m20;
    vec2 _m21;
    vec2 _m22;
} _19;

layout(set = 2, binding = 0, std430) readonly buffer _61_22
{
    float _m0[];
} _22;

layout(set = 2, binding = 10, std430) readonly buffer _63_25
{
    ivec4 _m0[];
} _25;

layout(set = 2, binding = 11, std430) readonly buffer _65_26
{
    int _m0[];
} _26;

layout(set = 2, binding = 12, std430) readonly buffer _68_27
{
    _66 _m0[];
} _27;

layout(set = 2, binding = 16, std430) readonly buffer _71_28
{
    layout(row_major) _69 _m0[];
} _28;

layout(set = 2, binding = 20, std430) readonly buffer _75_31
{
    layout(row_major) _73 _m0[];
} _31;

layout(set = 2, binding = 26, std140) uniform _77_37
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
    vec4 _m8;
    vec4 _m9;
    layout(row_major) mat4 _m10[4];
    float _m11;
    float _m12;
    float _m13;
    uint _m14;
    vec2 _m15;
    vec2 _m16;
    vec3 _m17;
    float _m18;
    layout(row_major) mat4x3 _m19;
    vec4 _m20[4];
    float _m21;
    float _m22;
    float _m23;
    float _m24;
    uint _m25;
    uint _m26;
    float _m27;
    float _m28;
    float _m29;
    float _m30;
    float _m31;
    float _m32;
    vec2 _m33;
    vec2 _m34;
} _37;

layout(set = 2, binding = 27, scalar) readonly buffer _80_38
{
    layout(row_major) _78 _m0[];
} _38;

layout(set = 5, binding = 0, scalar) uniform _81_44
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    vec3 _m5;
    float _m6;
    vec3 _m7;
    vec3 _m8;
    float _m9;
} _44;

layout(set = 1, binding = 0, std140) uniform _82_49
{
    float _m0;
    uint _m1;
    uint _m2;
    uint _m3;
} _49;

layout(set = 1, binding = 1, std140) uniform _83_50
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    float _m6;
    float _m7;
    float _m8;
    float _m9;
} _50;

layout(set = 0, binding = 7) uniform sampler _20;
layout(set = 0, binding = 9) uniform sampler _21;
layout(set = 2, binding = 3) uniform sampler _23;
layout(set = 2, binding = 5) uniform texture2D _24;
layout(set = 2, binding = 17) uniform texture3D _29;
layout(set = 2, binding = 19) uniform sampler _30;
layout(set = 2, binding = 21) uniform textureCube _32;
layout(set = 2, binding = 22) uniform textureCube _33;
layout(set = 2, binding = 23) uniform textureCube _34;
layout(set = 2, binding = 24) uniform textureCube _35;
layout(set = 2, binding = 25) uniform texture2D _36;
layout(set = 2, binding = 28) uniform texture2D _39;
layout(set = 2, binding = 29) uniform texture2D _40;
layout(set = 2, binding = 30) uniform texture2D _41;
layout(set = 2, binding = 32) uniform textureCube _42[];
layout(set = 2, binding = 32) uniform texture2D _43[];
layout(set = 5, binding = 1) uniform texture2D _45;
layout(set = 5, binding = 2) uniform texture3D _46;
layout(set = 5, binding = 4) uniform texture2D _47;
layout(set = 5, binding = 5) uniform texture2D _48;
layout(set = 1, binding = 2) uniform texture2D _51;
layout(set = 1, binding = 3) uniform texture2D _52;
layout(set = 1, binding = 4) uniform texture2D _53;

layout(location = 0) in vec4 _4;
layout(location = 1) in float _5;
layout(location = 2) in vec3 _6;
layout(location = 3) in vec2 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in vec3 _9;
layout(location = 6) in vec3 _10;
layout(location = 7) in vec3 _11;
layout(location = 8) in float _12;
layout(location = 0) out vec4 _13;

spirv_instruction(set = "GLSL.std.450", id = 79) float spvNMin(float, float);
spirv_instruction(set = "GLSL.std.450", id = 79) vec2 spvNMin(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 79) vec3 spvNMin(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 79) vec4 spvNMin(vec4, vec4);
spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

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
    float rendering_multi_scatter;       // 80
    float rendering_cubemap_mod;         // 84
    float rendering_ao_direct;           // 88
    float rendering_shadow_improvements; // 92
    float rendering_micro_shadows;       // 96
    float rendering_micro_shadows_debug; // 100
    float csm_debug;                     // 104
    float rendering_specular_occlusion;  // 108
    float rendering_probe_ao;            // 112
    float rendering_horizon_occlusion;   // 116
    float rendering_hammon_diffuse;      // 120
    float hero_lighting;                 // 124
    float rendering_gbuffer_improvements; // 128
    float rendering_fog_haze_aa;         // 132
    float rendering_fog_color_correction; // 136
} pc;

void main()
{
    vec2 _381 = gl_FragCoord.xy * vec2(_18._m2, _18._m3);
    vec4 _391 = texture(sampler2D(_24, _21), _381);
    float _395 = -_5;
    float _399 = spvNMax(_50._m6, 9.9999997473787516355514526367188e-05);
    float _401 = clamp(fma(_391.x, _17._m4, _395) / _399, 0.0, 1.0);
    vec2 _413 = normalize((normalize(_6) * mat3(_17._m0[0].xyz, _17._m0[1].xyz, _17._m0[2].xyz)).xz);
    float _414 = _413.y;
    vec3 _424 = (_8 + _17._m6) * 0.001000000047497451305389404296875;
    vec2 _430 = pow(spvNMax(abs(_7), vec2(9.9999997473787516355514526367188e-05)), vec2(1.0, 0.949999988079071044921875)) + vec2(dot(_424.xz * _424.y, vec2(1.0)));
    float _435 = _15._m0 * _50._m1;
    vec2 _437 = _430 + (vec2(-0.100000001490116119384765625, 1.0) * _435);
    vec4 _441 = texture(sampler2D(_51, _20), _437);
    float _446 = _414 + 1.0;
    vec2 _450 = (_430 + vec2(0.300000011920928955078125)) + (vec2(0.100000001490116119384765625, 1.0) * _435);
    float _467 = mix((1.0 - _4.x) * ((_401 * (-_414)) * _50._m7), clamp(clamp(_441.x * mix(1.0, 1.0 - (spvNMax(spvNMax(1.0 - _401, _4.x), _446) / spvNMax(_441.xyz, texture(sampler2D(_51, _20), _450).xyz).x), _50._m3), 0.0, 1.0) * _50._m8, 0.0, 1.0), _50._m3);
    if ((_467 - 0.001000000047497451305389404296875) < 0.0)
    {
        discard;
    }
    vec4 _477 = texture(sampler2D(_52, _20), _437);
    vec3 _480 = (_477.wzy * 2.0) - vec3(1.0);
    vec4 _481 = vec4(_480.x, _480.y, _480.z, _477.x);
    _481.z = -_480.z;
    vec4 _490 = texture(sampler2D(_53, _20), _437);
    vec3 _493 = (_490.wzy * 2.0) - vec3(1.0);
    vec4 _494 = vec4(_493.x, _493.y, _493.z, _490.x);
    _494.z = -_493.z;
    vec3 _509 = normalize(mat3(_10, _6, _9) * mix(vec3(0.0, 1.0, 0.0), mix(normalize(_481.xyz).xyz, normalize(_494.xyz).xyz, vec3(_50._m3)), vec3(_50._m9)));
    vec4 _513 = texture(sampler2D(_51, _20), _437);
    vec3 _542 = mix(_50._m0, _50._m4, vec3(_50._m3 * clamp(_513.x * mix(1.0, 1.0 - (spvNMax(spvNMax(1.0 - clamp(fma(texture(sampler2D(_24, _21), _381).x, _17._m4, _395) / _399, 0.0, 1.0), _4.x), _446) / spvNMax(_513.xyz, texture(sampler2D(_51, _20), _450).xyz).x), _50._m3), 0.0, 1.0))) * 1.0;
    vec3 _543 = dFdx(_509);
    vec3 _544 = dFdy(_509);
    float _551 = spvNMax(0.0900000035762786865234375, sqrt(clamp(spvNMin(dot(_543, _543) + dot(_544, _544), 0.180000007152557373046875), 0.0, 1.0)));
    vec3 _555 = normalize(-_11);
    ivec2 _562 = ivec2(uvec2(gl_FragCoord.xy) / uvec2(_37._m25));
    vec3 _1136;
    vec3 _1137;
    vec3 _1138;
    SPIRV_CROSS_BRANCH
    if (_16._m19 > 0.0)
    {
        vec3 _596 = vec3(0.0, 636100.0, 0.0) + _17._m6;
        float _597 = length(_596);
        bool _601 = _597 < (0.89999997615814208984375 * _44._m0);
        vec3 _608;
        float _609;
        if (_601)
        {
            vec3 _606 = _596;
            _606.z = _596.z + _44._m0;
            _608 = _606;
            _609 = length(_606);
        }
        else
        {
            _608 = _596;
            _609 = _597;
        }
        float _612 = dot(_608 / vec3(_609), _16._m36);
        float _613 = _44._m0 / _609;
        vec3 _637 = vec3(0.0, 636100.0, 0.0) + (_11 + _17._m6);
        float _638 = length(_637);
        vec3 _642 = (_637 / vec3(_638)) * spvNMax(_638, 636100.0);
        vec3 _643 = _642 - _596;
        float _644 = length(_643);
        vec3 _646 = _643 / vec3(_644);
        vec3 _656;
        vec3 _657;
        float _658;
        if (_601)
        {
            vec3 _651 = _596;
            _651.z = _596.z + _44._m0;
            vec3 _654 = _642;
            _654.z = _642.z + _44._m0;
            _656 = _654;
            _657 = _651;
            _658 = length(_651);
        }
        else
        {
            _656 = _642;
            _657 = _596;
            _658 = _597;
        }
        float _659 = dot(_657, _646);
        float _668 = spvNMax((-_659) - sqrt(fma(_44._m1, _44._m1, fma(_659, _659, -(_658 * _658)))), 0.0);
        bool _671 = (_668 > 0.0) && (_668 < _644);
        vec3 _679;
        float _680;
        float _681;
        if (_671)
        {
            _679 = _657 + (_646 * _668);
            _680 = _644 - _668;
            _681 = (_659 + _668) / _44._m1;
        }
        else
        {
            _679 = _657;
            _680 = _644;
            _681 = _659 / _658;
        }
        float _682 = _671 ? _44._m1 : _658;
        vec3 _1119;
        vec3 _1120;
        if (_682 <= _44._m1)
        {
            float _687 = dot(_646, _16._m36);
            float _689 = dot(_679, _16._m36) / _682;
            float _690 = _44._m0 + 600.0;
            bool _691 = _682 < _690;
            vec3 _696;
            if (_691)
            {
                _696 = _656 * (_690 / _682);
            }
            else
            {
                _696 = _656;
            }
            float _697 = _691 ? _690 : _682;
            float _698 = length(_696);
            float _699 = dot(_696, _646);
            float _701 = dot(_696, _16._m36) / _698;
            vec2 _712 = vec2(_681, _681 + (_680 / _697));
            vec2 _713 = _712 * sqrt((0.5 / _44._m4) * _697);
            vec2 _716 = vec2(ivec2(sign(_713)));
            vec2 _717 = _713 * _713;
            float _731 = -_680;
            float _733 = 2.0 * _697;
            float _735 = (_680 / _733) + _681;
            float _743 = _44._m0 - _697;
            vec2 _758 = _712 * sqrt((0.5 / _44._m6) * _697);
            vec2 _761 = vec2(ivec2(sign(_758)));
            vec2 _762 = _758 * _758;
            vec3 _792 = exp(((-_44._m5) * ((sqrt((6.283100128173828125 * _44._m4) * _697) * exp(_743 / _44._m4)) * (((_716.y > _716.x) ? exp(_717.x) : 0.0) + dot((_716 / ((abs(_713) * 2.3192999362945556640625) + sqrt((_717 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_731 / _44._m4) * _735)), vec2(1.0, -1.0))))) - (_44._m8 * ((sqrt((6.283100128173828125 * _44._m6) * _697) * exp(_743 / _44._m6)) * (((_761.y > _761.x) ? exp(_762.x) : 0.0) + dot((_761 / ((abs(_758) * 2.3192999362945556640625) + sqrt((_762 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_731 / _44._m6) * _735)), vec2(1.0, -1.0))))));
            vec3 _793 = spvNMin(_792, vec3(1.0));
            float _794 = _44._m0 / _697;
            float _797 = sqrt(fma(-_794, _794, 1.0));
            float _799 = _681 - (-_797);
            vec4 _1082;
            if (abs(_799) < 0.0040000001899898052215576171875)
            {
                float _907 = (-0.0040000001899898052215576171875) - _797;
                float _909 = fma(_697, _697, _680 * _680);
                float _910 = _733 * _680;
                float _912 = sqrt(fma(_910, _907, _909));
                float _913 = fma(_697, _907, _680);
                float _916 = -(_44._m0 * _44._m0);
                float _918 = sqrt(fma(_44._m1, _44._m1, _916));
                float _920 = sqrt(fma(_697, _697, _916));
                float _921 = _697 * _907;
                float _923 = -(_697 * _697);
                float _925 = fma(_44._m0, _44._m0, fma(_921, _921, _923));
                vec4 _931 = vec4(-1.0, _918 * _918, _918, 0.50390625);
                vec4 _932 = mix(_931, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_921 < 0.0) && (_925 > 0.0)));
                float _934 = fma(_920 / _918, 0.96875, 0.015625);
                float _944 = fma(fma(_921, _932.x, sqrt(_925 + _932.y)) / (_920 + _932.z), 0.4921875, _932.w);
                float _950 = _687 + 1.0;
                float _952 = floor(_950 * 3.5);
                float _954 = fma(_950, 3.5, -_952);
                float _955 = _952 + fma(fma(atan(spvNMax(_689, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _956 = _955 * 0.125;
                float _960 = 1.0 - _954;
                float _963 = (_955 + 1.0) * 0.125;
                float _970 = sqrt(fma(_912, _912, _916));
                float _974 = fma(_44._m0, _44._m0, fma(_913, _913, -(_912 * _912)));
                vec4 _979 = mix(_931, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_913 < 0.0) && (_974 > 0.0)));
                float _981 = fma(_970 / _918, 0.96875, 0.015625);
                float _991 = fma(fma(_913, _979.x, sqrt(_974 + _979.y)) / (_970 + _979.z), 0.4921875, _979.w);
                float _997 = _952 + fma(fma(atan(spvNMax(_701, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _998 = _997 * 0.125;
                float _1004 = (_997 + 1.0) * 0.125;
                vec4 _1010 = _793.xyzx;
                float _1014 = 0.0040000001899898052215576171875 - _797;
                float _1016 = sqrt(fma(_910, _1014, _909));
                float _1017 = fma(_697, _1014, _680);
                float _1018 = _697 * _1014;
                float _1020 = fma(_44._m0, _44._m0, fma(_1018, _1018, _923));
                vec4 _1025 = mix(_931, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1018 < 0.0) && (_1020 > 0.0)));
                float _1035 = fma(fma(_1018, _1025.x, sqrt(_1020 + _1025.y)) / (_920 + _1025.z), 0.4921875, _1025.w);
                float _1046 = sqrt(fma(_1016, _1016, _916));
                float _1050 = fma(_44._m0, _44._m0, fma(_1017, _1017, -(_1016 * _1016)));
                vec4 _1055 = mix(_931, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1017 < 0.0) && (_1050 > 0.0)));
                float _1057 = fma(_1046 / _918, 0.96875, 0.015625);
                float _1067 = fma(fma(_1017, _1055.x, sqrt(_1050 + _1055.y)) / (_1046 + _1055.z), 0.4921875, _1055.w);
                _1082 = mix(spvNMax(fma(-((textureLod(sampler3D(_46, _23), vec3(_998, _991, _981), 0.0) * _960) + (textureLod(sampler3D(_46, _23), vec3(_1004, _991, _981), 0.0) * _954)), _1010, (textureLod(sampler3D(_46, _23), vec3(_956, _944, _934), 0.0) * _960) + (textureLod(sampler3D(_46, _23), vec3(_963, _944, _934), 0.0) * _954)), vec4(0.0)), spvNMax(fma(-((textureLod(sampler3D(_46, _23), vec3(_998, _1067, _1057), 0.0) * _960) + (textureLod(sampler3D(_46, _23), vec3(_1004, _1067, _1057), 0.0) * _954)), _1010, (textureLod(sampler3D(_46, _23), vec3(_956, _1035, _934), 0.0) * _960) + (textureLod(sampler3D(_46, _23), vec3(_963, _1035, _934), 0.0) * _954)), vec4(0.0)), vec4((_799 + 0.0040000001899898052215576171875) * 124.99999237060546875));
            }
            else
            {
                float _807 = -(_44._m0 * _44._m0);
                float _809 = sqrt(fma(_44._m1, _44._m1, _807));
                float _811 = sqrt(fma(_697, _697, _807));
                float _812 = _697 * _681;
                float _816 = fma(_44._m0, _44._m0, fma(_812, _812, -(_697 * _697)));
                vec4 _822 = vec4(-1.0, _809 * _809, _809, 0.50390625);
                vec4 _823 = mix(_822, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_812 < 0.0) && (_816 > 0.0)));
                float _825 = fma(_811 / _809, 0.96875, 0.015625);
                float _835 = fma(fma(_812, _823.x, sqrt(_816 + _823.y)) / (_811 + _823.z), 0.4921875, _823.w);
                float _841 = _687 + 1.0;
                float _843 = floor(_841 * 3.5);
                float _845 = fma(_841, 3.5, -_843);
                float _846 = _843 + fma(fma(atan(spvNMax(_689, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _851 = 1.0 - _845;
                float _861 = sqrt(fma(_698, _698, _807));
                float _865 = fma(_44._m0, _44._m0, fma(_699, _699, -(_698 * _698)));
                vec4 _870 = mix(_822, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_699 < 0.0) && (_865 > 0.0)));
                float _872 = fma(_861 / _809, 0.96875, 0.015625);
                float _882 = fma(fma(_699, _870.x, sqrt(_865 + _870.y)) / (_861 + _870.z), 0.4921875, _870.w);
                float _888 = _843 + fma(fma(atan(spvNMax(_701, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                _1082 = spvNMax(fma(-((textureLod(sampler3D(_46, _23), vec3(_888 * 0.125, _882, _872), 0.0) * _851) + (textureLod(sampler3D(_46, _23), vec3((_888 + 1.0) * 0.125, _882, _872), 0.0) * _845)), _793.xyzx, (textureLod(sampler3D(_46, _23), vec3(_846 * 0.125, _835, _825), 0.0) * _851) + (textureLod(sampler3D(_46, _23), vec3((_846 + 1.0) * 0.125, _835, _825), 0.0) * _845)), vec4(0.0));
            }
            float _1097 = fma(_687, _687, 1.0);
            _1119 = _793;
            _1120 = (_1082.xyz * (0.0596831031143665313720703125 * _1097)) + ((((_1082.xyz * (_1082.w * smoothstep(0.0, 0.0199999995529651641845703125, _689))) / vec3(spvNMax(_1082.x, 9.9999997473787516355514526367188e-05))) * (vec3(_44._m5.x) / _44._m5)) * ((((0.119366206228733062744140625 * fma(-_44._m9, _44._m9, 1.0)) * (-pow(spvNMax(abs(abs(fma(_44._m9 * (-2.0), _687, fma(_44._m9, _44._m9, 1.0)))), 9.9999997473787516355514526367188e-05), 1.5))) * _1097) / fma(_44._m9, _44._m9, 2.0)));
        }
        else
        {
            _1119 = vec3(1.0);
            _1120 = vec3(0.0);
        }
        vec3 _1135;
        if (_16._m35 == 0.0)
        {
            _1135 = ((mix(textureLod(sampler2D(_45, _23), vec2(atan((_612 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_609 - _44._m0) / (_44._m1 - _44._m0))), 0.0).xyz, vec3(0.0), bvec3(_612 < (-sqrt(fma(-_613, _613, 1.0))))) * 1.0) * _16._m34) * _16._m20;
        }
        else
        {
            _1135 = _16._m2;
        }
        _1136 = _1120 * (_16._m19 * 10.0);
        _1137 = _1119;
        _1138 = _1135;
    }
    else
    {
        _1136 = vec3(0.0);
        _1137 = vec3(1.0);
        _1138 = _16._m2;
    }
    float _1221;
    SPIRV_CROSS_BRANCH
    if (_16._m21 > 0.0)
    {
        vec3 _1161 = _17._m6 + _11;
        vec3 _1168 = vec3(0.0, _16._m18.z, 0.0) + (_1161 - vec3(0.0, _16._m25, 0.0));
        float _1172 = dot(_1168, _16._m24);
        vec2 _1182 = ((((_1168 + (_16._m24 * (sqrt(fma(_1172, _1172, fma(_16._m18.z, _16._m18.z, -dot(_1168, _1168)))) - _1172))).xz * _16._m18.w) * 0.5) + vec2(0.5)) + _16._m18.xy;
        _1182.x = 1.0 - _1182.x;
        vec3 _1195 = vec3(0.0, _16._m23.z, 0.0) + (_1161 - vec3(0.0, _16._m27, 0.0));
        float _1199 = dot(_1195, _16._m26);
        vec2 _1209 = ((((_1195 + (_16._m26 * (sqrt(fma(_1199, _1199, fma(_16._m23.z, _16._m23.z, -dot(_1195, _1195)))) - _1199))).xz * _16._m23.w) * 0.5) + vec2(0.5)) + _16._m23.xy;
        _1209.x = 1.0 - _1209.x;
        _1221 = 1.0 - clamp(smoothstep(0.0500000007450580596923828125, 0.550000011920928955078125, mix(textureLod(sampler2D(_47, _23), _1182, 0.0).x, textureLod(sampler2D(_48, _23), _1209, 0.0).x, _16._m16)) * _16._m21, 0.0, 1.0);
    }
    else
    {
        _1221 = 1.0;
    }
    float _1310;
    SPIRV_CROSS_BRANCH
    if (_16._m17 > 0.0)
    {
        vec3 _1248 = _17._m6 + _11;
        vec3 _1256 = vec3(0.0, _16._m28.z, 0.0) + ((_16._m29 + _1248) - vec3(0.0, _16._m30, 0.0));
        float _1260 = dot(_1256, _16._m24);
        vec2 _1270 = ((((_1256 + (_16._m24 * (sqrt(fma(_1260, _1260, fma(_16._m28.z, _16._m28.z, -dot(_1256, _1256)))) - _1260))).xz * _16._m28.w) * 0.5) + vec2(0.5)) + _16._m28.xy;
        _1270.x = 1.0 - _1270.x;
        vec3 _1284 = vec3(0.0, _16._m31.z, 0.0) + ((_16._m32 + _1248) - vec3(0.0, _16._m33, 0.0));
        float _1288 = dot(_1284, _16._m26);
        vec2 _1298 = ((((_1284 + (_16._m26 * (sqrt(fma(_1288, _1288, fma(_16._m31.z, _16._m31.z, -dot(_1284, _1284)))) - _1288))).xz * _16._m31.w) * 0.5) + vec2(0.5)) + _16._m31.xy;
        _1298.x = 1.0 - _1298.x;
        _1310 = _1221 * (1.0 - clamp(mix(textureLod(sampler2D(_40, _23), _1270, 0.0).x, textureLod(sampler2D(_41, _23), _1298, 0.0).x, _16._m16) * _16._m17, 0.0, 1.0));
    }
    else
    {
        _1310 = _1221;
    }
    float _1317 = fract(52.98291778564453125 * fract(fma(0.067110560834407806396484375, gl_FragCoord.x, 0.005837149918079376220703125 * gl_FragCoord.y)));
    float _1324 = clamp(fma(_37._m34.y, length(_11), _37._m34.x), 0.0, 1.0);
    uint _1325 = uint(int(fma(fma(float(int(clamp(fma(log2(_5), _37._m21, _37._m22), 0.0, float(_37._m26)))), _37._m24, float(_562.y)), _37._m23, float(_562.x))));
    uvec4 _1328 = uvec4(_25._m0[_1325]);
    uint _1329 = _1328.x;
    uint _1330 = _1328.y;
    uint _1333 = ((_1330 >> 0u) & 4095u) + _1329;
    uint _1336 = ((_1330 >> 12u) & 4095u) + _1333;
    uint _1340 = ((_1328.z >> 0u) & 1023u) + _1336;
    float _1342 = spvNMax(dot(_509, _555), 9.9999997473787516355514526367188e-06);
    float _1344;
    bool _1347;
    vec3 _1349;
    vec3 _1351;
    uint _1353;
    _1344 = _315;
    _1347 = false;
    _1349 = vec3(0.0);
    _1351 = vec3(0.0);
    _1353 = _1329;
    float _1345;
    bool _1348;
    vec3 _1350;
    vec3 _1352;
    for (; _1353 < _1333; _1344 = _1345, _1347 = _1348, _1349 = _1350, _1351 = _1352, _1353++)
    {
        uint _1360 = uint(_26._m0[_1353]);
        float _1378 = abs(_27._m0[_1360]._m5);
        if ((_27._m0[_1360]._m6 & (1u << (_49._m1 & 31u))) != 0u)
        {
            vec3 _1393 = _27._m0[_1360]._m0.xyz - _11;
            float _1394 = dot(_1393, _1393);
            vec3 _1397 = _1393 * inversesqrt(spvNMax(_1394, 1.0000000133514319600180897396058e-10));
            float _1398 = _27._m0[_1360]._m0.w * _27._m0[_1360]._m0.w;
            float _1635;
            bool _1636;
            vec3 _1637;
            vec3 _1638;
            if (_1394 < (1.0 / _1398))
            {
                vec3 _1403 = _555 + _1397;
                vec3 _1407 = _1403 * inversesqrt(spvNMax(dot(_1403, _1403), 1.0000000133514319600180897396058e-10));
                float _1409 = clamp(dot(_1397, _1407), 0.0, 1.0);
                float _1411 = clamp(dot(_509, _1407), 0.0, 1.0);
                float _1413 = clamp(dot(_509, _1397), 0.0, 1.0);
                float _1414 = _1394 * _1398;
                float _1420 = pow(spvNMax(abs(clamp(fma(-_1414, _1414, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _27._m0[_1360]._m4);
                float _1430;
                if (_27._m0[_1360]._m5 < 0.0)
                {
                    _1430 = _1420 * fma(4.0, _1398, _1378);
                }
                else
                {
                    _1430 = _1420 * ((1.0 / spvNMax(_1394, 9.9999997473787516355514526367188e-05)) + _1378);
                }
                float _1432 = 0.079577468335628509521484375 * (_1413 * _1430);
                float _1567;
                bool _1568;
                float _1569;
                if ((_27._m0[_1360]._m7 & 1u) != 0u)
                {
                    uint _1457;
                    do
                    {
                        vec3 _1437 = -_1397;
                        float _1438 = dot(_1437, vec3(0.0, -0.57735025882720947265625, 0.8164966106414794921875));
                        float _1439 = dot(_1437, vec3(0.0, -0.57735025882720947265625, -0.8164966106414794921875));
                        float _1440 = dot(_1437, vec3(-0.8164966106414794921875, 0.57735025882720947265625, 0.0));
                        float _1444 = spvNMax(spvNMax(_1438, _1439), spvNMax(_1440, dot(_1437, vec3(0.8164966106414794921875, 0.57735025882720947265625, 0.0))));
                        if (_1444 == _1438)
                        {
                            _1457 = 0u;
                            break;
                        }
                        else
                        {
                            if (_1444 == _1439)
                            {
                                _1457 = 1u;
                                break;
                            }
                            else
                            {
                                if (_1444 == _1440)
                                {
                                    _1457 = 2u;
                                    break;
                                }
                                else
                                {
                                    _1457 = 3u;
                                    break;
                                }
                                break; // unreachable workaround
                            }
                            break; // unreachable workaround
                        }
                        break; // unreachable workaround
                    } while(false);
                    uint _1459 = uint(int(_27._m0[_1360]._m7 >> 2u)) + _1457;
                    float _1561;
                    bool _1562;
                    float _1563;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_1413 <= 0.0) && true)
                        {
                            _1561 = _1344;
                            _1562 = _1347;
                            _1563 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _1492 = _38._m0[_1459]._m0 * vec4(_11 + (_509 * ((3.5 * float(int(sign(_1413)))) * (_38._m0[_1459]._m4 * sqrt(_1394)))), 1.0);
                            vec3 _1496 = _1492.xyz / vec3(_1492.w);
                            vec2 _1499 = (_1496.xy * 0.5) + vec2(0.5);
                            _1499.y = 1.0 - _1499.y;
                            float _1508 = (_38._m0[_1459]._m5.y / _38._m0[_1459]._m6) / (_1496.z - _38._m0[_1459]._m5.x);
                            float _1513 = _1347 ? _1344 : 6.283185482025146484375;
                            float _1514 = _1317 * _1513;
                            vec2 _1515 = _38._m0[_1459]._m1 + _37._m33;
                            vec2 _1518 = (_38._m0[_1459]._m1 + vec2(_38._m0[_1459]._m2)) - _37._m33;
                            float _1520;
                            _1520 = 0.0;
                            for (int _1523 = 0; _1523 < 12; )
                            {
                                float _1528 = float(uint(_1523));
                                float _1531 = sqrt(_1528 + 0.5) * 0.288675129413604736328125;
                                float _1532 = fma(_1528, 2.3999631404876708984375, _1514);
                                vec2 _1540 = clamp(fma((vec3(cos(_1532), sin(_1532), _1531).xy * _1531) * 2.5, _37._m33, _1499), _1515, _1518);
                                vec2 _1543 = fract(fma(vec2(1.0) / _37._m33, _1540, vec2(0.5)));
                                vec4 _1549 = vec4(lessThan(vec4(_1508), textureGather(sampler2D(_39, _30), _1540)));
                                float _1552 = _1543.x;
                                _1520 += clamp(mix(mix(_1549.w, _1549.z, _1552), mix(_1549.x, _1549.y, _1552), _1543.y), 0.0, 1.0);
                                _1523++;
                                continue;
                            }
                            _1561 = _1513;
                            _1562 = _1347 ? _1347 : true;
                            _1563 = _1520 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _1567 = _1561;
                    _1568 = _1562;
                    _1569 = _1432 * mix(1.0, _1563, spvNMin(_1324, _27._m0[_1360]._m8));
                }
                else
                {
                    _1567 = _1344;
                    _1568 = _1347;
                    _1569 = _1432;
                }
                vec3 _1633;
                vec3 _1634;
                if (_1413 > 0.0)
                {
                    vec3 _1575 = _27._m0[_1360]._m1.xyz * (_1569 * ((_27._m0[_1360]._m3 < 0.0) ? _22._m0[0u] : 1.0));
                    vec3 _1582 = vec3(fma((2.0 * _1409) * _1409, _551, mix(0.0, 0.5, _551))) - vec3(1.0);
                    float _1603 = (_551 + 1.0) * 0.5;
                    float _1604 = _551 * _551;
                    float _1611 = _1603 * _1603;
                    float _1623 = _1604 * _1604;
                    float _1626 = fma(fma(_1411, _1623, -_1411), _1411, 1.0);
                    _1633 = fma(_1575, (vec3(0.01959999836981296539306640625) + (vec3(0.980400025844573974609375) * pow(spvNMax(abs(1.0 - _1409), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_1413, sqrt(fma(fma(-_1342, _1611, _1342), _1342, _1611)), _1342 * sqrt(fma(fma(-_1413, _1611, _1413), _1413, _1611)))) * (_1623 * (0.3183098733425140380859375 / (_1626 * _1626)))), _1349);
                    _1634 = fma(_1575, _542 * (0.3183098733425140380859375 * (((vec3(1.0) + (_1582 * pow(spvNMax(abs(1.0 - _1413), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_1582 * pow(spvNMax(abs(1.0 - _1342), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _551))), _1351);
                }
                else
                {
                    _1633 = _1349;
                    _1634 = _1351;
                }
                _1635 = _1567;
                _1636 = _1568;
                _1637 = _1633;
                _1638 = _1634;
            }
            else
            {
                _1635 = _1344;
                _1636 = _1347;
                _1637 = _1349;
                _1638 = _1351;
            }
            _1345 = _1635;
            _1348 = _1636;
            _1350 = _1637;
            _1352 = _1638;
        }
        else
        {
            _1345 = _1344;
            _1348 = _1347;
            _1350 = _1349;
            _1352 = _1351;
        }
    }
    float _1640;
    bool _1643;
    vec3 _1645;
    vec3 _1647;
    uint _1649;
    _1640 = _1344;
    _1643 = _1347;
    _1645 = _1349;
    _1647 = _1351;
    _1649 = _1353;
    float _1641;
    bool _1644;
    vec3 _1646;
    vec3 _1648;
    for (; _1649 < _1336; _1640 = _1641, _1643 = _1644, _1645 = _1646, _1647 = _1648, _1649++)
    {
        uint _1656 = uint(_26._m0[_1649]);
        float _1669 = abs(_27._m0[_1656]._m5);
        if ((_27._m0[_1656]._m6 & (1u << (_49._m1 & 31u))) != 0u)
        {
            vec3 _1687 = _27._m0[_1656]._m0.xyz - _11;
            float _1688 = dot(_1687, _1687);
            vec3 _1691 = _1687 * inversesqrt(spvNMax(_1688, 1.0000000133514319600180897396058e-10));
            float _1692 = _27._m0[_1656]._m0.w * _27._m0[_1656]._m0.w;
            float _1919;
            bool _1920;
            vec3 _1921;
            vec3 _1922;
            if (_1688 < (1.0 / _1692))
            {
                vec3 _1697 = _555 + _1691;
                vec3 _1701 = _1697 * inversesqrt(spvNMax(dot(_1697, _1697), 1.0000000133514319600180897396058e-10));
                float _1703 = clamp(dot(_1691, _1701), 0.0, 1.0);
                float _1705 = clamp(dot(_509, _1701), 0.0, 1.0);
                float _1707 = clamp(dot(_509, _1691), 0.0, 1.0);
                float _1710 = dot(-_1691, normalize(_27._m0[_1656]._m2.xyz));
                float _1739;
                if (_1710 > _27._m0[_1656]._m1.w)
                {
                    float _1714 = _1688 * _1692;
                    float _1720 = pow(spvNMax(abs(clamp(fma(-_1714, _1714, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _27._m0[_1656]._m4);
                    float _1730;
                    if (_27._m0[_1656]._m5 < 0.0)
                    {
                        _1730 = _1720 * fma(4.0, _1692, _1669);
                    }
                    else
                    {
                        _1730 = _1720 * ((1.0 / spvNMax(_1688, 9.9999997473787516355514526367188e-05)) + _1669);
                    }
                    float _1735 = clamp((_1710 - _27._m0[_1656]._m1.w) / spvNMax(_27._m0[_1656]._m2.w - _27._m0[_1656]._m1.w, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
                    _1739 = _1707 * (_1730 * (_1735 * _1735));
                }
                else
                {
                    _1739 = 0.0;
                }
                float _1740 = 0.3183098733425140380859375 * _1739;
                float _1851;
                bool _1852;
                float _1853;
                if ((_27._m0[_1656]._m7 & 1u) != 0u)
                {
                    uint _1743 = uint(int(_27._m0[_1656]._m7 >> 2u));
                    float _1845;
                    bool _1846;
                    float _1847;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_1707 <= 0.0) && true)
                        {
                            _1845 = _1640;
                            _1846 = _1643;
                            _1847 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _1776 = _38._m0[_1743]._m0 * vec4(_11 + (_509 * ((3.5 * float(int(sign(_1707)))) * (_38._m0[_1743]._m4 * sqrt(_1688)))), 1.0);
                            vec3 _1780 = _1776.xyz / vec3(_1776.w);
                            vec2 _1783 = (_1780.xy * 0.5) + vec2(0.5);
                            _1783.y = 1.0 - _1783.y;
                            float _1792 = (_38._m0[_1743]._m5.y / _38._m0[_1743]._m6) / (_1780.z - _38._m0[_1743]._m5.x);
                            float _1797 = _1643 ? _1640 : 6.283185482025146484375;
                            float _1798 = _1317 * _1797;
                            vec2 _1799 = _38._m0[_1743]._m1 + _37._m33;
                            vec2 _1802 = (_38._m0[_1743]._m1 + vec2(_38._m0[_1743]._m2)) - _37._m33;
                            float _1804;
                            _1804 = 0.0;
                            for (int _1807 = 0; _1807 < 12; )
                            {
                                float _1812 = float(uint(_1807));
                                float _1815 = sqrt(_1812 + 0.5) * 0.288675129413604736328125;
                                float _1816 = fma(_1812, 2.3999631404876708984375, _1798);
                                vec2 _1824 = clamp(fma((vec3(cos(_1816), sin(_1816), _1815).xy * _1815) * 2.5, _37._m33, _1783), _1799, _1802);
                                vec2 _1827 = fract(fma(vec2(1.0) / _37._m33, _1824, vec2(0.5)));
                                vec4 _1833 = vec4(lessThan(vec4(_1792), textureGather(sampler2D(_39, _30), _1824)));
                                float _1836 = _1827.x;
                                _1804 += clamp(mix(mix(_1833.w, _1833.z, _1836), mix(_1833.x, _1833.y, _1836), _1827.y), 0.0, 1.0);
                                _1807++;
                                continue;
                            }
                            _1845 = _1797;
                            _1846 = _1643 ? _1643 : true;
                            _1847 = _1804 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _1851 = _1845;
                    _1852 = _1846;
                    _1853 = _1740 * mix(1.0, _1847, spvNMin(_1324, _27._m0[_1656]._m8));
                }
                else
                {
                    _1851 = _1640;
                    _1852 = _1643;
                    _1853 = _1740;
                }
                vec3 _1917;
                vec3 _1918;
                if (_1707 > 0.0)
                {
                    vec3 _1859 = _27._m0[_1656]._m1.xyz * (_1853 * ((_27._m0[_1656]._m3 < 0.0) ? _22._m0[0u] : 1.0));
                    vec3 _1866 = vec3(fma((2.0 * _1703) * _1703, _551, mix(0.0, 0.5, _551))) - vec3(1.0);
                    float _1887 = (_551 + 1.0) * 0.5;
                    float _1888 = _551 * _551;
                    float _1895 = _1887 * _1887;
                    float _1907 = _1888 * _1888;
                    float _1910 = fma(fma(_1705, _1907, -_1705), _1705, 1.0);
                    _1917 = fma(_1859, (vec3(0.01959999836981296539306640625) + (vec3(0.980400025844573974609375) * pow(spvNMax(abs(1.0 - _1703), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_1707, sqrt(fma(fma(-_1342, _1895, _1342), _1342, _1895)), _1342 * sqrt(fma(fma(-_1707, _1895, _1707), _1707, _1895)))) * (_1907 * (0.3183098733425140380859375 / (_1910 * _1910)))), _1645);
                    _1918 = fma(_1859, _542 * (0.3183098733425140380859375 * (((vec3(1.0) + (_1866 * pow(spvNMax(abs(1.0 - _1707), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_1866 * pow(spvNMax(abs(1.0 - _1342), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _551))), _1647);
                }
                else
                {
                    _1917 = _1645;
                    _1918 = _1647;
                }
                _1919 = _1851;
                _1920 = _1852;
                _1921 = _1917;
                _1922 = _1918;
            }
            else
            {
                _1919 = _1640;
                _1920 = _1643;
                _1921 = _1645;
                _1922 = _1647;
            }
            _1641 = _1919;
            _1644 = _1920;
            _1646 = _1921;
            _1648 = _1922;
        }
        else
        {
            _1641 = _1640;
            _1644 = _1643;
            _1646 = _1645;
            _1648 = _1647;
        }
    }
    vec3 _1929;
    vec3 _1931;
    _1929 = _1645;
    _1931 = _1647;
    float _1925;
    bool _1928;
    vec3 _1930;
    vec3 _1932;
    float _1924 = _1640;
    bool _1927 = _1643;
    uint _1933 = _1649;
    for (; _1933 < _1340; _1924 = _1925, _1927 = _1928, _1929 = _1930, _1931 = _1932, _1933++)
    {
        uint _1940 = uint(_26._m0[_1933]);
        int _1969 = int(_28._m0[_1940]._m1 >> 1u) - 1;
        if (((_28._m0[_1940]._m4 & 16777215u) & (1u << (_49._m1 & 31u))) != 0u)
        {
            vec3 _1980 = _28._m0[_1940]._m6 * vec4(_11, 1.0);
            float _2366;
            bool _2367;
            vec3 _2368;
            vec3 _2369;
            if (all(lessThan(abs(_1980 - vec3(0.5)), vec3(0.5))))
            {
                vec3 _1987 = _555 + _28._m0[_1940]._m9;
                vec3 _1991 = _1987 * inversesqrt(spvNMax(dot(_1987, _1987), 1.0000000133514319600180897396058e-10));
                float _1993 = clamp(dot(_28._m0[_1940]._m9, _1991), 0.0, 1.0);
                float _1995 = clamp(dot(_509, _1991), 0.0, 1.0);
                float _1997 = clamp(dot(_509, _28._m0[_1940]._m9), 0.0, 1.0);
                int _1998 = int(_28._m0[_1940]._m4 >> 24u);
                float _1999 = _1980.z;
                vec3 _2038;
                if (_1999 < _28._m0[_1940]._m2.x)
                {
                    float _2026 = _1999 * _28._m0[_1940]._m2.z;
                    float _2029 = _2026 * _2026;
                    vec3 _2037;
                    _2037.z = dot(_332[_1998], vec4(_2026, _2029, smoothstep(0.0, 1.0, _2026), (_2029 * _2026) * fma(_2026, fma(_2026, 6.0, -15.0), 10.0)));
                    _2038 = _2037;
                }
                else
                {
                    vec3 _2024;
                    if (_1999 > _28._m0[_1940]._m2.y)
                    {
                        float _2012 = (1.0 - _1999) * _28._m0[_1940]._m2.w;
                        float _2015 = _2012 * _2012;
                        vec3 _2023;
                        _2023.z = dot(_332[_1998], vec4(_2012, _2015, smoothstep(0.0, 1.0, _2012), (_2015 * _2012) * fma(_2012, fma(_2012, 6.0, -15.0), 10.0)));
                        _2024 = _2023;
                    }
                    else
                    {
                        _2024 = vec3(0.0, 0.0, 1.0);
                    }
                    _2038 = _2024;
                }
                vec2 _2039 = _1980.xy;
                vec2 _2043 = (vec2(0.5) - abs(_2039 - vec2(0.5))) * _28._m0[_1940]._m3;
                float _2044 = _2043.x;
                vec3 _2061;
                if (_2044 < 1.0)
                {
                    float _2052 = _2044 * _2044;
                    vec3 _2060 = _2038;
                    _2060.x = dot(_332[_1998], vec4(_2044, _2052, smoothstep(0.0, 1.0, _2044), (_2052 * _2044) * fma(_2044, fma(_2044, 6.0, -15.0), 10.0)));
                    _2061 = _2060;
                }
                else
                {
                    vec3 _2049 = _2038;
                    _2049.x = 1.0;
                    _2061 = _2049;
                }
                float _2062 = _2043.y;
                vec3 _2079;
                if (_2062 < 1.0)
                {
                    float _2070 = _2062 * _2062;
                    vec3 _2078 = _2061;
                    _2078.y = dot(_332[_1998], vec4(_2062, _2070, smoothstep(0.0, 1.0, _2062), (_2070 * _2062) * fma(_2062, fma(_2062, 6.0, -15.0), 10.0)));
                    _2079 = _2078;
                }
                else
                {
                    vec3 _2067 = _2061;
                    _2067.y = 1.0;
                    _2079 = _2067;
                }
                float _2085 = _1997 * ((_2079.x * _2079.y) * _2079.z);
                float _2190;
                bool _2191;
                float _2192;
                if ((_28._m0[_1940]._m8 & 1u) != 0u)
                {
                    uint _2088 = uint(int(_28._m0[_1940]._m8 >> 2u));
                    float _2184;
                    bool _2185;
                    float _2186;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_1997 <= 0.0) && true)
                        {
                            _2184 = _1924;
                            _2185 = _1927;
                            _2186 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2119 = _38._m0[_2088]._m0 * vec4(_11 + (_509 * ((3.5 * float(int(sign(_1997)))) * _38._m0[_2088]._m4)), 1.0);
                            vec2 _2122 = (_2119.xy * 0.5) + vec2(0.5);
                            _2122.y = 1.0 - _2122.y;
                            float _2131 = ((_2119.z - _38._m0[_2088]._m5.y) / _38._m0[_2088]._m5.x) / _38._m0[_2088]._m6;
                            float _2136 = _1927 ? _1924 : 6.283185482025146484375;
                            float _2137 = _1317 * _2136;
                            vec2 _2138 = _38._m0[_2088]._m1 + _37._m33;
                            vec2 _2141 = (_38._m0[_2088]._m1 + vec2(_38._m0[_2088]._m2)) - _37._m33;
                            float _2143;
                            _2143 = 0.0;
                            for (int _2146 = 0; _2146 < 12; )
                            {
                                float _2151 = float(uint(_2146));
                                float _2154 = sqrt(_2151 + 0.5) * 0.288675129413604736328125;
                                float _2155 = fma(_2151, 2.3999631404876708984375, _2137);
                                vec2 _2163 = clamp(fma((vec3(cos(_2155), sin(_2155), _2154).xy * _2154) * 2.5, _37._m33, _2122), _2138, _2141);
                                vec2 _2166 = fract(fma(vec2(1.0) / _37._m33, _2163, vec2(0.5)));
                                vec4 _2172 = vec4(lessThan(vec4(_2131), textureGather(sampler2D(_39, _30), _2163)));
                                float _2175 = _2166.x;
                                _2143 += clamp(mix(mix(_2172.w, _2172.z, _2175), mix(_2172.x, _2172.y, _2175), _2166.y), 0.0, 1.0);
                                _2146++;
                                continue;
                            }
                            _2184 = _2136;
                            _2185 = _1927 ? _1927 : true;
                            _2186 = _2143 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2190 = _2184;
                    _2191 = _2185;
                    _2192 = _2085 * mix(1.0, _2186, spvNMin(_1324, _28._m0[_1940]._m5));
                }
                else
                {
                    _2190 = _1924;
                    _2191 = _1927;
                    _2192 = _2085;
                }
                vec3 _2233;
                if (_1969 >= 0)
                {
                    uint _2197 = gl_SubgroupInvocationID & 3u;
                    vec2 _2203 = (subgroupQuadSwapHorizontal(_2039) - _2039) * (((_2197 & 1u) != 0u) ? (-1.0) : 1.0);
                    vec2 _2209 = (subgroupQuadSwapVertical(_2039) - _2039) * (((_2197 & 2u) != 0u) ? (-1.0) : 1.0);
                    vec2 _2213 = mix(_2203, vec2(0.0), bvec2(any(isnan(_2203))));
                    vec2 _2217 = mix(_2209, vec2(0.0), bvec2(any(isnan(_2209))));
                    bvec2 _2226 = bvec2(any(greaterThan(abs(vec4(_2213, _2217)), vec4(0.015625))));
                    int _84 = _1969;
                    _2233 = _28._m0[_1940]._m0 * textureGrad(nonuniformEXT(sampler2D(_43[_84], _23)), _2039, mix(_2213, vec2(0.0), _2226), mix(_2217, vec2(0.0), _2226)).xyz;
                }
                else
                {
                    _2233 = _28._m0[_1940]._m0;
                }
                vec3 _2364;
                vec3 _2365;
                SPIRV_CROSS_BRANCH
                if ((_28._m0[_1940]._m1 & 1u) != 0u)
                {
                    vec3 _2362;
                    vec3 _2363;
                    if (_1997 > 0.0)
                    {
                        vec3 _2304 = _2233 * (_2192 * _22._m0[0u]);
                        vec3 _2311 = vec3(fma((2.0 * _1993) * _1993, _551, mix(0.0, 0.5, _551))) - vec3(1.0);
                        float _2332 = (_551 + 1.0) * 0.5;
                        float _2333 = _551 * _551;
                        float _2340 = _2332 * _2332;
                        float _2352 = _2333 * _2333;
                        float _2355 = fma(fma(_1995, _2352, -_1995), _1995, 1.0);
                        _2362 = fma(_2304, (vec3(0.01959999836981296539306640625) + (vec3(0.980400025844573974609375) * pow(spvNMax(abs(1.0 - _1993), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_1997, sqrt(fma(fma(-_1342, _2340, _1342), _1342, _2340)), _1342 * sqrt(fma(fma(-_1997, _2340, _1997), _1997, _2340)))) * (_2352 * (0.3183098733425140380859375 / (_2355 * _2355)))), _1929);
                        _2363 = fma(_2304, _542 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2311 * pow(spvNMax(abs(1.0 - _1997), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2311 * pow(spvNMax(abs(1.0 - _1342), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _551))), _1931);
                    }
                    else
                    {
                        _2362 = _1929;
                        _2363 = _1931;
                    }
                    _2364 = _2362;
                    _2365 = _2363;
                }
                else
                {
                    vec3 _2298;
                    vec3 _2299;
                    if (_1997 > 0.0)
                    {
                        vec3 _2240 = _2233 * _2192;
                        vec3 _2247 = vec3(fma((2.0 * _1993) * _1993, _551, mix(0.0, 0.5, _551))) - vec3(1.0);
                        float _2268 = (_551 + 1.0) * 0.5;
                        float _2269 = _551 * _551;
                        float _2276 = _2268 * _2268;
                        float _2288 = _2269 * _2269;
                        float _2291 = fma(fma(_1995, _2288, -_1995), _1995, 1.0);
                        _2298 = fma(_2240, (vec3(0.01959999836981296539306640625) + (vec3(0.980400025844573974609375) * pow(spvNMax(abs(1.0 - _1993), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_1997, sqrt(fma(fma(-_1342, _2276, _1342), _1342, _2276)), _1342 * sqrt(fma(fma(-_1997, _2276, _1997), _1997, _2276)))) * (_2288 * (0.3183098733425140380859375 / (_2291 * _2291)))), _1929);
                        _2299 = fma(_2240, _542 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2247 * pow(spvNMax(abs(1.0 - _1997), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2247 * pow(spvNMax(abs(1.0 - _1342), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _551))), _1931);
                    }
                    else
                    {
                        _2298 = _1929;
                        _2299 = _1931;
                    }
                    _2364 = _2298;
                    _2365 = _2299;
                }
                _2366 = _2190;
                _2367 = _2191;
                _2368 = _2364;
                _2369 = _2365;
            }
            else
            {
                _2366 = _1924;
                _2367 = _1927;
                _2368 = _1929;
                _2369 = _1931;
            }
            _1925 = _2366;
            _1928 = _2367;
            _1930 = _2368;
            _1932 = _2369;
        }
        else
        {
            _1925 = _1924;
            _1928 = _1927;
            _1930 = _1929;
            _1932 = _1931;
        }
    }
    vec3 _2371 = reflect(-_555, _509);
    vec3 _2383 = textureLod(samplerCube(_32, _23), _509, 0.0).xyz * _37._m27;
    vec3 _2390 = textureLod(samplerCube(_33, _23), _2371, fma(_551, 8.0, _37._m30 - 8.0)).xyz * _37._m27;
    vec3 _2415;
    vec3 _2416;
    SPIRV_CROSS_BRANCH
    if (_37._m29 > 0.0)
    {
        vec3 _2405 = vec3(_37._m29);
        _2415 = mix(_2390, textureLod(samplerCube(_35, _23), _2371, fma(_551, 8.0, _37._m31 - 8.0)).xyz * _37._m28, _2405);
        _2416 = mix(_2383, textureLod(samplerCube(_34, _23), _509, 0.0).xyz * _37._m28, _2405);
    }
    else
    {
        _2415 = _2390;
        _2416 = _2383;
    }
    float _2417 = spvNMax(dot(_555, _509), 0.001953125);
    vec4 _2422 = textureLod(sampler2D(_36, _30), vec2(_2417, _551), 0.0);
    uvec4 _2433 = uvec4(_25._m0[_1325]);
    uint _2435 = _2433.y;
    uint _2445 = ((_2433.z >> 0u) & 1023u) + (((_2435 >> 12u) & 4095u) + (((_2435 >> 0u) & 4095u) + _2433.x));
    uint _2447 = (_2435 >> 24u) + _2445;
    vec3 _2449;
    vec3 _2452;
    _2449 = _2415 * ((vec3(vec3(0.01959999836981296539306640625).x, vec3(0.01959999836981296539306640625).y, vec3(0.01959999836981296539306640625).z) * _2422.x) + vec3(_2422.y));
    _2452 = _2416 * (_542 * _2422.z);
    vec3 _2450;
    vec3 _2453;
    for (uint _2454 = _2445; _2454 < _2447; _2449 = _2450, _2452 = _2453, _2454++)
    {
        uint _2461 = uint(_26._m0[_2454]);
        int _2480 = int((_31._m0[_2461]._m5 >> 1u) & 3u);
        mat3 _2484 = mat3(_31._m0[_2461]._m1[0], _31._m0[_2461]._m1[1], _31._m0[_2461]._m1[2]);
        int _2490 = (int((_31._m0[_2461]._m5 >> 3u) & 16383u) - 1) * 2;
        int _2495 = (int((_31._m0[_2461]._m5 >> 17u) & 16383u) - 1) * 2;
        int _2500 = (int((_31._m0[_2461]._m6 >> 0u) & 65535u) - 1) * 2;
        int _2505 = (int((_31._m0[_2461]._m6 >> 16u) & 65535u) - 1) * 2;
        float _2508 = (_31._m0[_2461]._m3 < 0.0) ? (-_31._m0[_2461]._m3) : 1.0;
        vec3 _2510 = _2484 * (_11 - _31._m0[_2461]._m1[3]);
        bool _2511 = int(_31._m0[_2461]._m5 & 1u) == 1;
        vec3 _2512 = abs(_2510);
        float _2515 = dot(_2510, _2510);
        if (_2511 ? any(greaterThanEqual(_2512, _31._m0[_2461]._m0.xyz)) : (_2515 >= _31._m0[_2461]._m0.y))
        {
            _2450 = _2449;
            _2453 = _2452;
            continue;
        }
        vec3 _2689;
        SPIRV_CROSS_FLATTEN
        if ((_2480 & 1) != 0)
        {
            vec3 _2525 = _2484 * _509;
            vec2 _2614;
            bool _2615;
            if (_2511)
            {
                vec2 _2609;
                bool _2613;
                do
                {
                    vec3 _2593 = (_31._m0[_2461]._m0.xyz - _2510) / _2525;
                    vec3 _2596 = ((-_31._m0[_2461]._m0.xyz) - _2510) / _2525;
                    vec3 _2597 = spvNMin(_2593, _2596);
                    vec3 _2598 = spvNMax(_2593, _2596);
                    float _2603 = spvNMax(_2597.x, spvNMax(_2597.y, _2597.z));
                    float _2608 = spvNMin(_2598.x, spvNMin(_2598.y, _2598.z));
                    _2609 = vec2(_2603, _2608);
                    if (_2603 > _2608)
                    {
                        _2613 = false;
                        break;
                    }
                    _2613 = true;
                    break;
                } while(false);
                _2614 = _2609;
                _2615 = _2613;
            }
            else
            {
                vec2 _2588;
                bool _2589;
                do
                {
                    float _2531 = dot(_2525, _2525);
                    float _2532 = dot(_2525, _2510);
                    float _2533 = 2.0 * _2532;
                    float _2534 = _2515 - _31._m0[_2461]._m0.y;
                    float _2570;
                    float _2571;
                    bool _2572;
                    do
                    {
                        float _2540 = fma(_2533, _2533, -((4.0 * _2531) * _2534));
                        float _2568;
                        float _2569;
                        if (_2540 < 0.0)
                        {
                            _2570 = 0.0;
                            _2571 = 0.0;
                            _2572 = false;
                            break;
                        }
                        else
                        {
                            if (_2540 == 0.0)
                            {
                                float _2567 = (_2532 * (-1.0)) * (1.0 / _2531);
                                _2568 = _2567;
                                _2569 = _2567;
                            }
                            else
                            {
                                float _2560;
                                if (_2533 > 0.0)
                                {
                                    _2560 = (-0.5) * fma(2.0, _2532, sqrt(_2540));
                                }
                                else
                                {
                                    _2560 = (-0.5) * fma(2.0, _2532, -sqrt(_2540));
                                }
                                _2568 = _2534 * (1.0 / _2560);
                                _2569 = _2560 * (1.0 / _2531);
                            }
                        }
                        _2570 = _2568;
                        _2571 = _2569;
                        _2572 = true;
                        break;
                    } while(false);
                    if (!_2572)
                    {
                        _2588 = vec2(0.0);
                        _2589 = false;
                        break;
                    }
                    if ((_2571 < 0.0) && (_2570 < 0.0))
                    {
                        _2588 = vec2(0.0);
                        _2589 = false;
                        break;
                    }
                    vec2 _2587;
                    if (_2571 > _2570)
                    {
                        _2587 = vec2(_2570, _2571);
                    }
                    else
                    {
                        _2587 = vec2(_2571, _2570);
                    }
                    _2588 = _2587;
                    _2589 = true;
                    break;
                } while(false);
                _2614 = _2588;
                _2615 = _2589;
            }
            vec3 _2618 = _2510 + (_2525 * _2614.y);
            float _2639;
            if (_2511)
            {
                _2639 = 1.0 - clamp(length(spvNMax(_2512 - (_31._m0[_2461]._m0.xyz - vec3(_31._m0[_2461]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_31._m0[_2461]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _2639 = clamp((_31._m0[_2461]._m0.x - length(_2510)) * (1.0 / spvNMax(_31._m0[_2461]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _2642 = float(_2615) * smoothstep(0.0, 1.0, _2639);
            vec4 _2684;
            SPIRV_CROSS_BRANCH
            if (_2642 > 9.9999997473787516355514526367188e-05)
            {
                float _2651 = mix(clamp((_2614.y * (1.0 / length(_2618))) * _551, 0.0, _551), _551, _551);
                vec3 _2653 = mix(_2618, _2525, vec3(_2651));
                int _88 = _2490;
                vec4 _2654 = textureLod(nonuniformEXT(samplerCube(_42[_88], _23)), _2653, 0.0);
                int _92 = _2490 + 1;
                _2654.w = textureLod(nonuniformEXT(samplerCube(_42[_92], _23)), _2653, 0.0).x;
                vec4 _2669;
                SPIRV_CROSS_BRANCH
                if (_2495 >= 0)
                {
                    int _96 = _2495;
                    vec4 _2662 = textureLod(nonuniformEXT(samplerCube(_42[_96], _23)), _2653, 0.0);
                    int _100 = _2495 + 1;
                    _2662.w = textureLod(nonuniformEXT(samplerCube(_42[_100], _23)), _2653, 0.0).x;
                    _2669 = mix(_2654, _2662, vec4(_31._m0[_2461]._m3));
                }
                else
                {
                    _2669 = _2654;
                }
                vec4 _2670 = _2669 * _2508;
                vec3 _2679 = (_2670.xyz * _31._m0[_2461]._m4).xyz * (_542 * textureLod(sampler2D(_36, _30), vec2(_2417, _2651), 0.0).z);
                vec4 _2680 = vec4(_2679.x, _2679.y, _2679.z, _2670.w);
                _2680.w = _2670.w * _2642;
                _2684 = _2680;
            }
            else
            {
                _2684 = vec4(0.0);
            }
            _2689 = mix(_2452, _2684.xyz, vec3(_2684.w));
        }
        else
        {
            _2689 = _2452;
        }
        vec3 _2868;
        SPIRV_CROSS_FLATTEN
        if ((_2480 & 2) != 0)
        {
            vec3 _2694 = _2484 * _2371;
            vec2 _2783;
            bool _2784;
            if (_2511)
            {
                vec2 _2778;
                bool _2782;
                do
                {
                    vec3 _2762 = (_31._m0[_2461]._m0.xyz - _2510) / _2694;
                    vec3 _2765 = ((-_31._m0[_2461]._m0.xyz) - _2510) / _2694;
                    vec3 _2766 = spvNMin(_2762, _2765);
                    vec3 _2767 = spvNMax(_2762, _2765);
                    float _2772 = spvNMax(_2766.x, spvNMax(_2766.y, _2766.z));
                    float _2777 = spvNMin(_2767.x, spvNMin(_2767.y, _2767.z));
                    _2778 = vec2(_2772, _2777);
                    if (_2772 > _2777)
                    {
                        _2782 = false;
                        break;
                    }
                    _2782 = true;
                    break;
                } while(false);
                _2783 = _2778;
                _2784 = _2782;
            }
            else
            {
                vec2 _2757;
                bool _2758;
                do
                {
                    float _2700 = dot(_2694, _2694);
                    float _2701 = dot(_2694, _2510);
                    float _2702 = 2.0 * _2701;
                    float _2703 = _2515 - _31._m0[_2461]._m0.y;
                    float _2739;
                    float _2740;
                    bool _2741;
                    do
                    {
                        float _2709 = fma(_2702, _2702, -((4.0 * _2700) * _2703));
                        float _2737;
                        float _2738;
                        if (_2709 < 0.0)
                        {
                            _2739 = 0.0;
                            _2740 = 0.0;
                            _2741 = false;
                            break;
                        }
                        else
                        {
                            if (_2709 == 0.0)
                            {
                                float _2736 = (_2701 * (-1.0)) * (1.0 / _2700);
                                _2737 = _2736;
                                _2738 = _2736;
                            }
                            else
                            {
                                float _2729;
                                if (_2702 > 0.0)
                                {
                                    _2729 = (-0.5) * fma(2.0, _2701, sqrt(_2709));
                                }
                                else
                                {
                                    _2729 = (-0.5) * fma(2.0, _2701, -sqrt(_2709));
                                }
                                _2737 = _2703 * (1.0 / _2729);
                                _2738 = _2729 * (1.0 / _2700);
                            }
                        }
                        _2739 = _2737;
                        _2740 = _2738;
                        _2741 = true;
                        break;
                    } while(false);
                    if (!_2741)
                    {
                        _2757 = vec2(0.0);
                        _2758 = false;
                        break;
                    }
                    if ((_2740 < 0.0) && (_2739 < 0.0))
                    {
                        _2757 = vec2(0.0);
                        _2758 = false;
                        break;
                    }
                    vec2 _2756;
                    if (_2740 > _2739)
                    {
                        _2756 = vec2(_2739, _2740);
                    }
                    else
                    {
                        _2756 = vec2(_2740, _2739);
                    }
                    _2757 = _2756;
                    _2758 = true;
                    break;
                } while(false);
                _2783 = _2757;
                _2784 = _2758;
            }
            vec3 _2787 = _2510 + (_2694 * _2783.y);
            float _2808;
            if (_2511)
            {
                _2808 = 1.0 - clamp(length(spvNMax(_2512 - (_31._m0[_2461]._m0.xyz - vec3(_31._m0[_2461]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_31._m0[_2461]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _2808 = clamp((_31._m0[_2461]._m0.x - length(_2510)) * (1.0 / spvNMax(_31._m0[_2461]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _2811 = float(_2784) * smoothstep(0.0, 1.0, _2808);
            vec4 _2863;
            SPIRV_CROSS_BRANCH
            if (_2811 > 9.9999997473787516355514526367188e-05)
            {
                float _2820 = mix(clamp((_2783.y * (1.0 / length(_2787))) * _551, 0.0, _551), _551, _551);
                vec3 _2822 = mix(_2787, _2694, vec3(_2820));
                float _2823 = _2820 * 8.0;
                int _104 = _2500;
                int _108 = _2500 + 1;
                vec4 _2831 = vec4(textureLod(nonuniformEXT(samplerCube(_42[_104], _23)), _2822, _2823).xyz, textureLod(nonuniformEXT(samplerCube(_42[_108], _23)), _2822, _2823).x);
                vec4 _2845;
                SPIRV_CROSS_BRANCH
                if (_2505 >= 0)
                {
                    int _112 = _2505;
                    int _116 = _2505 + 1;
                    _2845 = mix(_2831, vec4(textureLod(nonuniformEXT(samplerCube(_42[_112], _23)), _2822, _2823).xyz, textureLod(nonuniformEXT(samplerCube(_42[_116], _23)), _2822, _2823).x), vec4(_31._m0[_2461]._m3));
                }
                else
                {
                    _2845 = _2831;
                }
                vec4 _2846 = _2845 * _2508;
                vec4 _2851 = textureLod(sampler2D(_36, _30), vec2(_2417, _2820), 0.0);
                vec3 _2858 = (_2846.xyz * _31._m0[_2461]._m4).xyz * ((vec3(vec3(0.01959999836981296539306640625).x, vec3(0.01959999836981296539306640625).y, vec3(0.01959999836981296539306640625).z) * _2851.x) + vec3(_2851.y));
                vec4 _2859 = vec4(_2858.x, _2858.y, _2858.z, _2846.w);
                _2859.w = _2846.w * _2811;
                _2863 = _2859;
            }
            else
            {
                _2863 = vec4(0.0);
            }
            _2868 = mix(_2449, _2863.xyz, vec3(_2863.w));
        }
        else
        {
            _2868 = _2449;
        }
        _2450 = _2868;
        _2453 = _2689;
    }
    float _2869 = _22._m0[0u] * 100.0;
    vec3 _2873 = _1138 * (_1310 * _22._m0[0u]);
    vec3 _2876 = reflect(_555, _509);
    float _2880 = clamp(dot(_16._m0, normalize(_555 + _16._m0)), 0.0, 1.0);
    float _2882 = clamp(dot(_509, _16._m0), 0.0, 1.0);
    vec3 _2889 = vec3(fma((2.0 * _2880) * _2880, _551, mix(0.0, 0.5, _551))) - vec3(1.0);
    float _2908 = dot(_16._m0, _2876);
    vec3 _2918 = mix(_2876, normalize((_16._m0 * 0.999989449977874755859375) + (normalize(_2876 - (_16._m0 * _2908)) * 0.0045900647528469562530517578125)), bvec3(_2908 < 0.999989449977874755859375));
    vec3 _2920 = normalize(_555 + _2918);
    float _2924 = clamp(dot(_509, _2920), 0.0, 1.0);
    float _2926 = clamp(dot(_509, _2918), 0.0, 1.0);
    float _2928 = (_551 + 1.0) * 0.5;
    float _2929 = _551 * _551;
    float _2936 = _2928 * _2928;
    float _2948 = _2929 * _2929;
    float _2951 = fma(fma(_2924, _2948, -_2924), _2924, 1.0);
    vec3 _2970 = (((_1931 + ((_2873 * (_542 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2889 * pow(spvNMax(abs(1.0 - _2882), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2889 * pow(spvNMax(abs(1.0 - _1342), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _551))))) * _2882)) + (_1929 + ((_2873 * ((vec3(0.01959999836981296539306640625) + (vec3(0.980400025844573974609375) * pow(spvNMax(abs(1.0 - clamp(dot(_2918, _2920), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2926, sqrt(fma(fma(-_1342, _2936, _1342), _1342, _2936)), _1342 * sqrt(fma(fma(-_2926, _2936, _2926), _2926, _2936)))) * (_2948 * (0.3183098733425140380859375 / (_2951 * _2951)))))) * _2882))) * mix(1.0, 1.0, _37._m1)) + (((_2452 * _2869) + (_2449 * _2869)) * 1.0);
    vec4 _3158;
    do
    {
        if (_37._m19[3].z < 0.0)
        {
            _3158 = vec4(0.0, 0.0, 0.0, 1.0);
            break;
        }
        float _3004;
        do
        {
            if (_12 <= _37._m19[0].x)
            {
                _3004 = fma(_37._m19[2].x, _12, _37._m19[3].x);
                break;
            }
            else
            {
                _3004 = _37._m19[1].y * log2(fma(_37._m19[2].y, _12, _37._m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        vec3 _3014 = (vec3(_381 / vec2(_37._m32, _37._m18), _3004) + vec3(float(_19._m5), 0.0, 0.0)) - vec3(0.5);
        vec3 _3015 = floor(_3014);
        vec3 _3016 = _3014 - _3015;
        vec3 _3017 = vec3(1.0) - _3016;
        vec3 _3024 = fma(-((_3016 * 0.5) * _3016), vec3(2.0) - _3016, vec3(0.666666686534881591796875));
        vec3 _3031 = (_3016 * 0.16666667163372039794921875) * _3016;
        vec3 _3033 = fma((_3017 * 0.16666667163372039794921875) * _3017, _3017, _3024);
        vec3 _3040 = _37._m17 * (((_3024 / _3033) - vec3(0.5)) + _3015);
        vec3 _3044 = _37._m17 * ((((_3031 * _3016) / fma(_3031, _3016, fma(-((_3017 * 0.5) * _3017), _3016 + vec3(1.0), vec3(0.666666686534881591796875)))) + vec3(1.5)) + _3015);
        float _3052 = _3040.z;
        float _3058 = _3044.x;
        vec2 _3062 = spvNMax(_37._m15, spvNMin(_37._m16, vec2(_3058, _3040.y)));
        float _3063 = _3062.x;
        vec4 _3069 = vec4(_3033.x);
        float _3071 = _3040.x;
        vec2 _3075 = spvNMax(_37._m15, spvNMin(_37._m16, vec2(_3071, _3044.y)));
        float _3076 = _3075.x;
        vec4 _3091 = vec4(_3033.y);
        float _3096 = _3044.z;
        vec4 _3122 = mix(mix(mix(textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, _3044.xy)), _3096), 0.0), textureLod(sampler3D(_29, _30), vec3(_3076, _3075.y, _3096), 0.0), _3069), mix(textureLod(sampler3D(_29, _30), vec3(_3063, _3062.y, _3096), 0.0), textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, vec2(_3071, _3040.y))), _3096), 0.0), _3069), _3091), mix(mix(textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, vec2(_3058, _3044.y))), _3052), 0.0), textureLod(sampler3D(_29, _30), vec3(_3076, _3075.y, _3052), 0.0), _3069), mix(textureLod(sampler3D(_29, _30), vec3(_3063, _3062.y, _3052), 0.0), textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, _3040.xy)), _3052), 0.0), _3069), _3091), vec4(_3033.z)) * vec4(0.03125, 0.03125, 0.03125, 3.0517578125e-05);
        vec4 _3130;
        if (isinf(_3122.x) || isnan(_3122.x))
        {
            vec4 _3129 = _3122;
            _3129.x = 0.0;
            _3130 = _3129;
        }
        else
        {
            _3130 = _3122;
        }
        vec4 _3138;
        if (isinf(_3130.y) || isnan(_3130.y))
        {
            vec4 _3137 = _3130;
            _3137.y = 0.0;
            _3138 = _3137;
        }
        else
        {
            _3138 = _3130;
        }
        vec4 _3146;
        if (isinf(_3138.z) || isnan(_3138.z))
        {
            vec4 _3145 = _3138;
            _3145.z = 0.0;
            _3146 = _3145;
        }
        else
        {
            _3146 = _3138;
        }
        vec4 _3154;
        if (isinf(_3146.w) || isnan(_3146.w))
        {
            vec4 _3153 = _3146;
            _3153.w = 0.0;
            _3154 = _3153;
        }
        else
        {
            _3154 = _3146;
        }
        vec4 _3157 = _3154;
        _3157.w = 1.0 - _3154.w;
        _3158 = _3157;
        break;
    } while(false);
    // Inscatter strength: 0 = no colour cast, 1 = full game inscatter. Transmittance unchanged.
    float inscatterStrength = pc.rendering_fog_color_correction;
    vec3 _13_composited = fma(_2970, _1137, (_1136 * _22._m0[0u]) * inscatterStrength) * _3158.www + _3158.xyz * inscatterStrength;
    _13 = spvNMax(vec4(_13_composited, _467 * _49._m0), vec4(0.0));
}

