#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_scalar_block_layout : require
#extension GL_EXT_spirv_intrinsics : require
#extension GL_EXT_samplerless_texture_functions : require
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

struct _70
{
    mat4 _m0[2];
};

struct _79
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

struct _82
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

struct _86
{
    vec4 _m0;
    mat4x3 _m1;
    vec4 _m2[4];
    float _m3;
    float _m4;
    uint _m5;
    uint _m6;
};

struct _91
{
    mat4 _m0;
    vec2 _m1;
    float _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    float _m6;
};

float _354;
const vec4 _370[4] = vec4[](vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
vec3 _389;
vec3 _396;

layout(set = 0, binding = 0, std140) uniform _63_16
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _16;

layout(set = 0, binding = 1, std140) uniform _65_17
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
} _17;

layout(set = 0, binding = 2, std140) uniform _66_18
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _18;

layout(set = 0, binding = 3, std140) uniform _67_19
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _19;

layout(set = 0, binding = 4, std140) uniform _68_20
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
} _20;

layout(set = 0, binding = 12, std430) readonly buffer _72_22
{
    layout(row_major) _70 _m0[];
} _22;

layout(set = 2, binding = 0, std430) readonly buffer _74_23
{
    float _m0[];
} _23;

layout(set = 2, binding = 10, std430) readonly buffer _76_25
{
    ivec4 _m0[];
} _25;

layout(set = 2, binding = 11, std430) readonly buffer _78_26
{
    int _m0[];
} _26;

layout(set = 2, binding = 12, std430) readonly buffer _81_27
{
    _79 _m0[];
} _27;

layout(set = 2, binding = 16, std430) readonly buffer _84_28
{
    layout(row_major) _82 _m0[];
} _28;

layout(set = 2, binding = 20, std430) readonly buffer _88_31
{
    layout(row_major) _86 _m0[];
} _31;

layout(set = 2, binding = 26, std140) uniform _90_37
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

layout(set = 2, binding = 27, scalar) readonly buffer _93_38
{
    layout(row_major) _91 _m0[];
} _38;

layout(set = 5, binding = 0, scalar) uniform _94_44
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

layout(set = 1, binding = 0, std140) uniform _96_49
{
    layout(row_major) mat4 _m0;
    vec4 _m1[2];
    uint _m2;
    uint _m3;
    float _m4;
    uint _m5;
} _49;

layout(set = 1, binding = 1, std140) uniform _97_50
{
    vec4 _m0;
    vec3 _m1;
    float _m2;
    vec3 _m3;
    float _m4;
    vec3 _m5;
    float _m6;
    vec3 _m7;
    float _m8;
    vec3 _m9;
    float _m10;
    vec3 _m11;
    float _m12;
    vec3 _m13;
    float _m14;
    vec2 _m15;
    vec2 _m16;
    vec2 _m17;
    vec2 _m18;
    vec2 _m19;
    vec2 _m20;
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
    float _m42;
    float _m43;
    float _m44;
    float _m45;
    float _m46;
    float _m47;
    float _m48;
} _50;

layout(set = 0, binding = 7) uniform sampler _21;
layout(set = 2, binding = 3) uniform sampler _24;
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
layout(set = 1, binding = 3) uniform sampler _51;
layout(set = 1, binding = 5) uniform texture2D _52;
layout(set = 1, binding = 6) uniform texture2DArray _53;
layout(set = 1, binding = 7) uniform texture2D _54;
layout(set = 1, binding = 8) uniform texture2D _55;
layout(set = 1, binding = 9) uniform texture2D _56;
layout(set = 1, binding = 10) uniform texture2D _57;
layout(set = 1, binding = 11) uniform texture2DArray _58;
layout(set = 1, binding = 12) uniform texture2D _59;
layout(set = 1, binding = 13) uniform texture2D _60;
layout(set = 1, binding = 14) uniform texture2D _61;
layout(set = 1, binding = 15) uniform texture2D _62;

layout(location = 0) in vec2 _4;
layout(location = 1) in vec3 _5;
layout(location = 2) in vec3 _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in vec3 _9;
layout(location = 6) in vec3 _10;
layout(location = 7) in vec3 _11;
layout(location = 8) in float _12;
layout(location = 9) in float _13;
layout(location = 0) out vec4 _14;

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
    float rendering_multi_scatter;      // 80
    float rendering_cubemap_mod;        // 84
    float rendering_ao_direct;          // 88
    float rendering_shadow_improvements; // 92
    float rendering_micro_shadows;       // 96
    float rendering_micro_shadows_debug; // 100
    float csm_debug;                     // 104
    float rendering_specular_occlusion;  // 108
    float rendering_probe_ao;            // 112
    float rendering_horizon_occlusion;   // 116
    float rendering_diffuse_brdf;        // 120
    float hero_lighting;                 // 124
} pc;

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
    vec2 _418 = vec2(_19._m2, _19._m3);
    vec3 _422 = _6 + _18._m6;
    vec3 _423 = _7 + _18._m6;
    mat3 _424 = mat3(_10, _8, _9);
    vec3 _426 = normalize(-_7);
    vec3 _428 = normalize(_426 * _424);
    bool _434 = _50._m2 > 0.0;
    float _554;
    if (_434)
    {
        vec2 _459 = _49._m1[0].zw * dFdx(_4);
        vec2 _461 = _49._m1[0].zw * dFdy(_4);
        vec2 _464 = fma(fract(_4), _49._m1[0].zw, _49._m1[0].xy);
        vec2 _467 = vec2(_22._m0[_49._m3]._m0[0][2].x, _22._m0[_49._m3]._m0[0][3].x);
        vec2 _468 = _459 * _467;
        vec2 _469 = _461 * _467;
        float _470 = dot(_468, _468);
        float _471 = dot(_469, _469);
        float _474 = log2(spvNMax(_470, _471));
        float _487 = floor(spvNMin(spvNMax(fma(0.5, _474, -spvNMin(fma(0.5, _474, log2(spvNMin(_470, _471)) * (-0.5)), _22._m0[_49._m3]._m0[0][1].x)) - 0.5, 0.0), _49._m1[1].x) + 0.5);
        float _493 = abs(0.5);
        vec2 _497 = floor((_464 * vec2(_22._m0[_49._m3]._m0[0][0].w, _22._m0[_49._m3]._m0[0][0].w * _22._m0[_49._m3]._m0[0][1].w)) * pow(spvNMax(_493, 9.9999997473787516355514526367188e-05), _487));
        int _498 = int(_487);
        uint _507 = floatBitsToUint(texelFetch(_52, ivec3(int(_497.x), int(_497.y), _498).xy, _498).x);
        float _516 = abs(2.0);
        float _518 = pow(spvNMax(_516, 9.9999997473787516355514526367188e-05), float(_507 & 15u));
        vec2 _520 = vec2(_518, _518 * _22._m0[_49._m3]._m0[0][1].w);
        vec2 _525 = vec2(_22._m0[_49._m3]._m0[0][0].z, _22._m0[_49._m3]._m0[0][1].z);
        vec2 _532 = vec2(_22._m0[_49._m3]._m0[1][0].x, _22._m0[_49._m3]._m0[1][1].x);
        vec2 _544 = ((_520 * _525) * _532) * _22._m0[_49._m3]._m0[0][0].y;
        _554 = mix(textureGrad(sampler2DArray(_53, _51), vec3(fma(fma(fract(_464 * _520), _525, vec2(float((_507 >> 14u) & 1023u), float((_507 >> 4u) & 1023u))), _532, vec2(_22._m0[_49._m3]._m0[1][2].x, _22._m0[_49._m3]._m0[1][3].x)), float((_507 >> 24u) & 127u)), _459 * _544, _461 * _544), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_22._m0[_49._m3]._m0[0][2].w != 2202.0)).w;
    }
    else
    {
        _554 = texture(sampler2D(_54, _21), _4).w;
    }
    vec4 _558 = texture(sampler2D(_55, _21), _4);
    float _561 = smoothstep(0.0199999995529651641845703125, 0.0500000007450580596923828125, _554 * _558.w);
    if ((_561 - 0.00999999977648258209228515625) < 0.0)
    {
        discard;
    }
    float _567 = 1.0 - _50._m0.x;
    float _569 = abs(1.0);
    float _570 = spvNMax(_569, 9.9999997473787516355514526367188e-06);
    float _580 = _5.y / _50._m1.y;
    float _603 = ((-1.0) + ((_567 * 2.2999999523162841796875) / _570)) + clamp(length(mix(vec2(_5.x / _50._m1.x, (-1.0) + ((_580 * 2.0) / _570)), vec2(_50._m15.x + ((_580 * (_50._m15.y - _50._m15.x)) / _570)), vec2(_50._m4)) + _50._m16), 0.0, 1.0);
    float _606 = 1.0 - smoothstep(_567, 1.2000000476837158203125 - _50._m0.x, _603);
    vec2 _614 = vec2(1.0, _19._m1 / _19._m0);
    vec3 _619 = _422 - _18._m6;
    vec4 _624 = vec4(_619, 1.0) * _18._m2;
    vec2 _642 = _50._m17 * ((length(_423 - _422) / length(_5)) / sqrt(dot(_619, _619)));
    vec2 _649 = _4 * _50._m18;
    vec2 _668 = mix(((((fma(fma(gl_FragCoord.xy, _418, vec2(-0.5)) * 2.0, _614, vec2(1.0)) * 0.5) - ((_614 * (vec2(1.0, -1.0) * (_624 / vec4(_624.w)).xy)) * 0.5)) / _642) + vec2(0.5)) - (vec2(0.5) / _642), vec2(_649.x + fract(_16._m0 * _50._m6), _649.y + fract(_16._m0 * _50._m8)), vec2(_50._m10));
    float _686 = smoothstep(_567, 1.2999999523162841796875 - _50._m0.x, _603);
    float _688 = clamp(mix(pow(spvNMax(abs(clamp(_606 + smoothstep(_50._m19.x, _50._m19.y, texture(sampler2D(_56, _21), _668).x), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _50._m12), 0.0, _686), 0.0, 1.0);
    float _707 = clamp(_50._m0.w * (_561 * mix(_688, mix(0.0, mix(_50._m14, 1.0, pow(spvNMax(abs(1.0 - clamp(_428.y, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _50._m21)), _688), _50._m22)), 0.0, 1.0);
    vec3 _714 = pow(spvNMax(abs(abs(normalize(_11))), vec3(9.9999997473787516355514526367188e-05)), vec3(_50._m23));
    vec3 _717 = _714 / vec3(dot(_714, vec3(1.0)));
    float _718 = _717.x;
    vec3 _721 = _5 * _50._m24;
    vec4 _725 = texture(sampler2D(_57, _21), _721.zy);
    float _727 = _717.y;
    vec4 _730 = texture(sampler2D(_57, _21), _721.xz);
    float _732 = _717.z;
    vec4 _735 = texture(sampler2D(_57, _21), _721.xy);
    float _753 = clamp(_50._m26 + ((pow(spvNMax(abs(fma(_718, _725.x, fma(_727, _730.x, _732 * _735.x))), 9.9999997473787516355514526367188e-05), _50._m25) * (_50._m27 - _50._m26)) / _570), 0.0, 1.0);
    if (fma(_707, _753, -_50._m28) < 0.0)
    {
        discard;
    }
    vec3 _901;
    if (_434)
    {
        vec2 _797 = _49._m1[0].zw * dFdx(_4);
        vec2 _799 = _49._m1[0].zw * dFdy(_4);
        vec2 _802 = fma(fract(_4), _49._m1[0].zw, _49._m1[0].xy);
        vec2 _805 = vec2(_22._m0[_49._m3]._m0[0][2].x, _22._m0[_49._m3]._m0[0][3].x);
        vec2 _806 = _797 * _805;
        vec2 _807 = _799 * _805;
        float _808 = dot(_806, _806);
        float _809 = dot(_807, _807);
        float _812 = log2(spvNMax(_808, _809));
        float _825 = floor(spvNMin(spvNMax(fma(0.5, _812, -spvNMin(fma(0.5, _812, log2(spvNMin(_808, _809)) * (-0.5)), _22._m0[_49._m3]._m0[0][1].x)) - 0.5, 0.0), _49._m1[1].x) + 0.5);
        float _831 = abs(0.5);
        vec2 _835 = floor((_802 * vec2(_22._m0[_49._m3]._m0[0][0].w, _22._m0[_49._m3]._m0[0][0].w * _22._m0[_49._m3]._m0[0][1].w)) * pow(spvNMax(_831, 9.9999997473787516355514526367188e-05), _825));
        int _836 = int(_825);
        uint _845 = floatBitsToUint(texelFetch(_52, ivec3(int(_835.x), int(_835.y), _836).xy, _836).y);
        float _854 = abs(2.0);
        float _856 = pow(spvNMax(_854, 9.9999997473787516355514526367188e-05), float(_845 & 15u));
        vec2 _858 = vec2(_856, _856 * _22._m0[_49._m3]._m0[0][1].w);
        vec2 _863 = vec2(_22._m0[_49._m3]._m0[0][0].z, _22._m0[_49._m3]._m0[0][1].z);
        vec2 _870 = vec2(_22._m0[_49._m3]._m0[1][0].y, _22._m0[_49._m3]._m0[1][1].y);
        vec2 _882 = ((_858 * _863) * _870) * _22._m0[_49._m3]._m0[0][0].y;
        vec4 _890 = mix(textureGrad(sampler2DArray(_58, _51), vec3(fma(fma(fract(_802 * _858), _863, vec2(float((_845 >> 14u) & 1023u), float((_845 >> 4u) & 1023u))), _870, vec2(_22._m0[_49._m3]._m0[1][2].y, _22._m0[_49._m3]._m0[1][3].y)), float((_845 >> 24u) & 127u)), _797 * _882, _799 * _882), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_22._m0[_49._m3]._m0[0][2].w != 2202.0));
        vec3 _893 = (_890.wzy * 2.0) - vec3(1.0);
        vec4 _894 = vec4(_893.x, _893.y, _893.z, _890.x);
        _894.z = -_893.z;
        _901 = normalize(_894.xyz).xyz;
    }
    else
    {
        vec4 _770 = texture(sampler2D(_59, _21), _4);
        vec3 _773 = (_770.wzy * 2.0) - vec3(1.0);
        vec4 _774 = vec4(_773.x, _773.y, _773.z, _770.x);
        _774.z = -_773.z;
        _901 = normalize(_774.xyz).xyz;
    }
    vec3 _904 = _5 * _50._m29;
    vec2 _905 = _904.zy;
    vec4 _908 = texture(sampler2D(_60, _21), _905);
    vec3 _911 = (_908.wzy * 2.0) - vec3(1.0);
    vec4 _912 = vec4(_911.x, _911.y, _911.z, _908.x);
    _912.z = -_911.z;
    vec2 _920 = _904.xz;
    vec4 _922 = texture(sampler2D(_60, _21), _920);
    vec3 _925 = (_922.wzy * 2.0) - vec3(1.0);
    vec4 _926 = vec4(_925.x, _925.y, _925.z, _922.x);
    _926.z = -_925.z;
    vec2 _934 = _904.xy;
    vec4 _936 = texture(sampler2D(_60, _21), _934);
    vec3 _939 = (_936.wzy * 2.0) - vec3(1.0);
    vec4 _940 = vec4(_939.x, _939.y, _939.z, _936.x);
    _940.z = -_939.z;
    vec3 _952 = vec3(_50._m30, _50._m30, 1.0);
    float _962 = spvNMax(abs(1.0 - clamp(dot(normalize(fma(((normalize(_912.xyz).xyz * _718) + ((normalize(_926.xyz).xyz * _727) + (normalize(_940.xyz).xyz * _732))) * _952, vec3(1.0, 0.0, 1.0), _901)), _428), 0.0, 1.0)), 9.9999997473787516355514526367188e-05);
    float _1003 = mix(pow(spvNMax(abs(clamp(_606 + smoothstep(_50._m19.x, _50._m19.y, texture(sampler2D(_56, _21), _668).x), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _50._m12), 0.0, _686);
    vec3 _1149;
    if (_434)
    {
        vec2 _1045 = _49._m1[0].zw * dFdx(_4);
        vec2 _1047 = _49._m1[0].zw * dFdy(_4);
        vec2 _1050 = fma(fract(_4), _49._m1[0].zw, _49._m1[0].xy);
        vec2 _1053 = vec2(_22._m0[_49._m3]._m0[0][2].x, _22._m0[_49._m3]._m0[0][3].x);
        vec2 _1054 = _1045 * _1053;
        vec2 _1055 = _1047 * _1053;
        float _1056 = dot(_1054, _1054);
        float _1057 = dot(_1055, _1055);
        float _1060 = log2(spvNMax(_1056, _1057));
        float _1073 = floor(spvNMin(spvNMax(fma(0.5, _1060, -spvNMin(fma(0.5, _1060, log2(spvNMin(_1056, _1057)) * (-0.5)), _22._m0[_49._m3]._m0[0][1].x)) - 0.5, 0.0), _49._m1[1].x) + 0.5);
        float _1079 = abs(0.5);
        vec2 _1083 = floor((_1050 * vec2(_22._m0[_49._m3]._m0[0][0].w, _22._m0[_49._m3]._m0[0][0].w * _22._m0[_49._m3]._m0[0][1].w)) * pow(spvNMax(_1079, 9.9999997473787516355514526367188e-05), _1073));
        int _1084 = int(_1073);
        uint _1093 = floatBitsToUint(texelFetch(_52, ivec3(int(_1083.x), int(_1083.y), _1084).xy, _1084).y);
        float _1102 = abs(2.0);
        float _1104 = pow(spvNMax(_1102, 9.9999997473787516355514526367188e-05), float(_1093 & 15u));
        vec2 _1106 = vec2(_1104, _1104 * _22._m0[_49._m3]._m0[0][1].w);
        vec2 _1111 = vec2(_22._m0[_49._m3]._m0[0][0].z, _22._m0[_49._m3]._m0[0][1].z);
        vec2 _1118 = vec2(_22._m0[_49._m3]._m0[1][0].y, _22._m0[_49._m3]._m0[1][1].y);
        vec2 _1130 = ((_1106 * _1111) * _1118) * _22._m0[_49._m3]._m0[0][0].y;
        vec4 _1138 = mix(textureGrad(sampler2DArray(_58, _51), vec3(fma(fma(fract(_1050 * _1106), _1111, vec2(float((_1093 >> 14u) & 1023u), float((_1093 >> 4u) & 1023u))), _1118, vec2(_22._m0[_49._m3]._m0[1][2].y, _22._m0[_49._m3]._m0[1][3].y)), float((_1093 >> 24u) & 127u)), _1045 * _1130, _1047 * _1130), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_22._m0[_49._m3]._m0[0][2].w != 2202.0));
        vec3 _1141 = (_1138.wzy * 2.0) - vec3(1.0);
        vec4 _1142 = vec4(_1141.x, _1141.y, _1141.z, _1138.x);
        _1142.z = -_1141.z;
        _1149 = normalize(_1142.xyz).xyz;
    }
    else
    {
        vec4 _1018 = texture(sampler2D(_59, _21), _4);
        vec3 _1021 = (_1018.wzy * 2.0) - vec3(1.0);
        vec4 _1022 = vec4(_1021.x, _1021.y, _1021.z, _1018.x);
        _1022.z = -_1021.z;
        _1149 = normalize(_1022.xyz).xyz;
    }
    vec4 _1151 = texture(sampler2D(_60, _21), _905);
    vec3 _1154 = (_1151.wzy * 2.0) - vec3(1.0);
    vec4 _1155 = vec4(_1154.x, _1154.y, _1154.z, _1151.x);
    _1155.z = -_1154.z;
    vec4 _1164 = texture(sampler2D(_60, _21), _920);
    vec3 _1167 = (_1164.wzy * 2.0) - vec3(1.0);
    vec4 _1168 = vec4(_1167.x, _1167.y, _1167.z, _1164.x);
    _1168.z = -_1167.z;
    vec4 _1177 = texture(sampler2D(_60, _21), _934);
    vec3 _1180 = (_1177.wzy * 2.0) - vec3(1.0);
    vec4 _1181 = vec4(_1180.x, _1180.y, _1180.z, _1177.x);
    _1181.z = -_1180.z;
    vec3 _1195 = normalize(_424 * normalize(fma(((normalize(_1155.xyz).xyz * _718) + ((normalize(_1168.xyz).xyz * _727) + (normalize(_1181.xyz).xyz * _732))) * _952, vec3(1.0, 0.0, 1.0), _1149)));
    vec4 _1198 = texture(sampler2D(_61, _21), _905);
    vec4 _1202 = texture(sampler2D(_61, _21), _920);
    vec4 _1206 = texture(sampler2D(_61, _21), _934);
    vec3 _1210 = (_1198.xyz * _718) + ((_1202.xyz * _727) + (_1206.xyz * _732));
    vec3 _1349;
    float _1350;
    if (_434)
    {
        vec2 _1244 = _49._m1[0].zw * dFdx(_4);
        vec2 _1246 = _49._m1[0].zw * dFdy(_4);
        vec2 _1249 = fma(fract(_4), _49._m1[0].zw, _49._m1[0].xy);
        vec2 _1252 = vec2(_22._m0[_49._m3]._m0[0][2].x, _22._m0[_49._m3]._m0[0][3].x);
        vec2 _1253 = _1244 * _1252;
        vec2 _1254 = _1246 * _1252;
        float _1255 = dot(_1253, _1253);
        float _1256 = dot(_1254, _1254);
        float _1259 = log2(spvNMax(_1255, _1256));
        float _1272 = floor(spvNMin(spvNMax(fma(0.5, _1259, -spvNMin(fma(0.5, _1259, log2(spvNMin(_1255, _1256)) * (-0.5)), _22._m0[_49._m3]._m0[0][1].x)) - 0.5, 0.0), _49._m1[1].x) + 0.5);
        float _1278 = abs(0.5);
        vec2 _1282 = floor((_1249 * vec2(_22._m0[_49._m3]._m0[0][0].w, _22._m0[_49._m3]._m0[0][0].w * _22._m0[_49._m3]._m0[0][1].w)) * pow(spvNMax(_1278, 9.9999997473787516355514526367188e-05), _1272));
        int _1283 = int(_1272);
        uint _1292 = floatBitsToUint(texelFetch(_52, ivec3(int(_1282.x), int(_1282.y), _1283).xy, _1283).y);
        float _1301 = abs(2.0);
        float _1303 = pow(spvNMax(_1301, 9.9999997473787516355514526367188e-05), float(_1292 & 15u));
        vec2 _1305 = vec2(_1303, _1303 * _22._m0[_49._m3]._m0[0][1].w);
        vec2 _1310 = vec2(_22._m0[_49._m3]._m0[0][0].z, _22._m0[_49._m3]._m0[0][1].z);
        vec2 _1317 = vec2(_22._m0[_49._m3]._m0[1][0].y, _22._m0[_49._m3]._m0[1][1].y);
        vec2 _1329 = ((_1305 * _1310) * _1317) * _22._m0[_49._m3]._m0[0][0].y;
        vec4 _1337 = mix(textureGrad(sampler2DArray(_58, _51), vec3(fma(fma(fract(_1249 * _1305), _1310, vec2(float((_1292 >> 14u) & 1023u), float((_1292 >> 4u) & 1023u))), _1317, vec2(_22._m0[_49._m3]._m0[1][2].y, _22._m0[_49._m3]._m0[1][3].y)), float((_1292 >> 24u) & 127u)), _1244 * _1329, _1246 * _1329), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_22._m0[_49._m3]._m0[0][2].w != 2202.0));
        vec3 _1340 = (_1337.wzy * 2.0) - vec3(1.0);
        vec4 _1341 = vec4(_1340.x, _1340.y, _1340.z, _1337.x);
        _1341.z = -_1340.z;
        vec3 _1346 = normalize(_1341.xyz);
        _1349 = _1346.xyz;
        _1350 = _1346.z;
    }
    else
    {
        vec4 _1216 = texture(sampler2D(_59, _21), _4);
        vec3 _1219 = (_1216.wzy * 2.0) - vec3(1.0);
        vec4 _1220 = vec4(_1219.x, _1219.y, _1219.z, _1216.x);
        _1220.z = -_1219.z;
        vec3 _1225 = normalize(_1220.xyz);
        _1349 = _1225.xyz;
        _1350 = _1225.z;
    }
    vec3 _1368 = mix(_1210, mix(_1210 * (1.0 - _1350), _50._m11, vec3(pow(spvNMax(abs(1.0 - clamp(dot(_1349, _428), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _50._m37))), vec3(_50._m38));
    vec3 _1391 = mix(_1368, (pow(spvNMax(abs(mix(vec3(dot(_1368, vec3(0.2125999927520751953125, 0.715200006961822509765625, 0.072200000286102294921875))), _1368, vec3(_50._m39))), vec3(9.9999997473787516355514526367188e-05)), vec3(_50._m40)) + vec3(_50._m41)) * _50._m13, vec3(_50._m42));
    float _1412 = mix(((texture(sampler2D(_62, _21), _905).xyz * _718) + ((texture(sampler2D(_62, _21), _920).xyz * _727) + (texture(sampler2D(_62, _21), _934).xyz * _732))).x, _50._m43, _50._m44);
    float _1432 = mix(((texture(sampler2D(_62, _21), _905).xyz * _718) + ((texture(sampler2D(_62, _21), _920).xyz * _727) + (texture(sampler2D(_62, _21), _934).xyz * _732))).y, _50._m46, _50._m44);
    vec3 _1436 = _1391 * (1.0 - _1412);
    vec3 _1441 = mix(vec3(0.1599999964237213134765625 * (_50._m45 * _50._m45)), _1391, vec3(_1412));
    vec3 _1442 = dFdx(_1195);
    vec3 _1443 = dFdy(_1195);
    float _1451 = spvNMax(0.0900000035762786865234375, sqrt(clamp(fma(_1432, _1432, spvNMin(dot(_1442, _1442) + dot(_1443, _1443), 0.180000007152557373046875)), 0.0, 1.0)));
    ivec2 _1459 = ivec2(uvec2(gl_FragCoord.xy) / uvec2(_37._m25));
    vec3 _2033;
    vec3 _2034;
    vec3 _2035;
    SPIRV_CROSS_BRANCH
    if (_17._m19 > 0.0)
    {
        vec3 _1493 = vec3(0.0, 636100.0, 0.0) + _18._m6;
        float _1494 = length(_1493);
        bool _1498 = _1494 < (0.89999997615814208984375 * _44._m0);
        vec3 _1505;
        float _1506;
        if (_1498)
        {
            vec3 _1503 = _1493;
            _1503.z = _1493.z + _44._m0;
            _1505 = _1503;
            _1506 = length(_1503);
        }
        else
        {
            _1505 = _1493;
            _1506 = _1494;
        }
        float _1509 = dot(_1505 / vec3(_1506), _17._m36);
        float _1510 = _44._m0 / _1506;
        vec3 _1534 = vec3(0.0, 636100.0, 0.0) + _423;
        float _1535 = length(_1534);
        vec3 _1539 = (_1534 / vec3(_1535)) * spvNMax(_1535, 636100.0);
        vec3 _1540 = _1539 - _1493;
        float _1541 = length(_1540);
        vec3 _1543 = _1540 / vec3(_1541);
        vec3 _1553;
        vec3 _1554;
        float _1555;
        if (_1498)
        {
            vec3 _1548 = _1493;
            _1548.z = _1493.z + _44._m0;
            vec3 _1551 = _1539;
            _1551.z = _1539.z + _44._m0;
            _1553 = _1551;
            _1554 = _1548;
            _1555 = length(_1548);
        }
        else
        {
            _1553 = _1539;
            _1554 = _1493;
            _1555 = _1494;
        }
        float _1556 = dot(_1554, _1543);
        float _1565 = spvNMax((-_1556) - sqrt(fma(_44._m1, _44._m1, fma(_1556, _1556, -(_1555 * _1555)))), 0.0);
        bool _1568 = (_1565 > 0.0) && (_1565 < _1541);
        vec3 _1576;
        float _1577;
        float _1578;
        if (_1568)
        {
            _1576 = _1554 + (_1543 * _1565);
            _1577 = _1541 - _1565;
            _1578 = (_1556 + _1565) / _44._m1;
        }
        else
        {
            _1576 = _1554;
            _1577 = _1541;
            _1578 = _1556 / _1555;
        }
        float _1579 = _1568 ? _44._m1 : _1555;
        vec3 _2016;
        vec3 _2017;
        if (_1579 <= _44._m1)
        {
            float _1584 = dot(_1543, _17._m36);
            float _1586 = dot(_1576, _17._m36) / _1579;
            float _1587 = _44._m0 + 600.0;
            bool _1588 = _1579 < _1587;
            vec3 _1593;
            if (_1588)
            {
                _1593 = _1553 * (_1587 / _1579);
            }
            else
            {
                _1593 = _1553;
            }
            float _1594 = _1588 ? _1587 : _1579;
            float _1595 = length(_1593);
            float _1596 = dot(_1593, _1543);
            float _1598 = dot(_1593, _17._m36) / _1595;
            vec2 _1609 = vec2(_1578, _1578 + (_1577 / _1594));
            vec2 _1610 = _1609 * sqrt((0.5 / _44._m4) * _1594);
            vec2 _1613 = vec2(ivec2(sign(_1610)));
            vec2 _1614 = _1610 * _1610;
            float _1628 = -_1577;
            float _1630 = 2.0 * _1594;
            float _1632 = (_1577 / _1630) + _1578;
            float _1640 = _44._m0 - _1594;
            vec2 _1655 = _1609 * sqrt((0.5 / _44._m6) * _1594);
            vec2 _1658 = vec2(ivec2(sign(_1655)));
            vec2 _1659 = _1655 * _1655;
            vec3 _1689 = exp(((-_44._m5) * ((sqrt((6.283100128173828125 * _44._m4) * _1594) * exp(_1640 / _44._m4)) * (((_1613.y > _1613.x) ? exp(_1614.x) : 0.0) + dot((_1613 / ((abs(_1610) * 2.3192999362945556640625) + sqrt((_1614 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1628 / _44._m4) * _1632)), vec2(1.0, -1.0))))) - (_44._m8 * ((sqrt((6.283100128173828125 * _44._m6) * _1594) * exp(_1640 / _44._m6)) * (((_1658.y > _1658.x) ? exp(_1659.x) : 0.0) + dot((_1658 / ((abs(_1655) * 2.3192999362945556640625) + sqrt((_1659 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1628 / _44._m6) * _1632)), vec2(1.0, -1.0))))));
            vec3 _1690 = spvNMin(_1689, vec3(1.0));
            float _1691 = _44._m0 / _1594;
            float _1694 = sqrt(fma(-_1691, _1691, 1.0));
            float _1696 = _1578 - (-_1694);
            vec4 _1979;
            if (abs(_1696) < 0.0040000001899898052215576171875)
            {
                float _1804 = (-0.0040000001899898052215576171875) - _1694;
                float _1806 = fma(_1594, _1594, _1577 * _1577);
                float _1807 = _1630 * _1577;
                float _1809 = sqrt(fma(_1807, _1804, _1806));
                float _1810 = fma(_1594, _1804, _1577);
                float _1813 = -(_44._m0 * _44._m0);
                float _1815 = sqrt(fma(_44._m1, _44._m1, _1813));
                float _1817 = sqrt(fma(_1594, _1594, _1813));
                float _1818 = _1594 * _1804;
                float _1820 = -(_1594 * _1594);
                float _1822 = fma(_44._m0, _44._m0, fma(_1818, _1818, _1820));
                vec4 _1828 = vec4(-1.0, _1815 * _1815, _1815, 0.50390625);
                vec4 _1829 = mix(_1828, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1818 < 0.0) && (_1822 > 0.0)));
                float _1831 = fma(_1817 / _1815, 0.96875, 0.015625);
                float _1841 = fma(fma(_1818, _1829.x, sqrt(_1822 + _1829.y)) / (_1817 + _1829.z), 0.4921875, _1829.w);
                float _1847 = _1584 + 1.0;
                float _1849 = floor(_1847 * 3.5);
                float _1851 = fma(_1847, 3.5, -_1849);
                float _1852 = _1849 + fma(fma(atan(spvNMax(_1586, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1853 = _1852 * 0.125;
                float _1857 = 1.0 - _1851;
                float _1860 = (_1852 + 1.0) * 0.125;
                float _1867 = sqrt(fma(_1809, _1809, _1813));
                float _1871 = fma(_44._m0, _44._m0, fma(_1810, _1810, -(_1809 * _1809)));
                vec4 _1876 = mix(_1828, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1810 < 0.0) && (_1871 > 0.0)));
                float _1878 = fma(_1867 / _1815, 0.96875, 0.015625);
                float _1888 = fma(fma(_1810, _1876.x, sqrt(_1871 + _1876.y)) / (_1867 + _1876.z), 0.4921875, _1876.w);
                float _1894 = _1849 + fma(fma(atan(spvNMax(_1598, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1895 = _1894 * 0.125;
                float _1901 = (_1894 + 1.0) * 0.125;
                vec4 _1907 = _1690.xyzx;
                float _1911 = 0.0040000001899898052215576171875 - _1694;
                float _1913 = sqrt(fma(_1807, _1911, _1806));
                float _1914 = fma(_1594, _1911, _1577);
                float _1915 = _1594 * _1911;
                float _1917 = fma(_44._m0, _44._m0, fma(_1915, _1915, _1820));
                vec4 _1922 = mix(_1828, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1915 < 0.0) && (_1917 > 0.0)));
                float _1932 = fma(fma(_1915, _1922.x, sqrt(_1917 + _1922.y)) / (_1817 + _1922.z), 0.4921875, _1922.w);
                float _1943 = sqrt(fma(_1913, _1913, _1813));
                float _1947 = fma(_44._m0, _44._m0, fma(_1914, _1914, -(_1913 * _1913)));
                vec4 _1952 = mix(_1828, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1914 < 0.0) && (_1947 > 0.0)));
                float _1954 = fma(_1943 / _1815, 0.96875, 0.015625);
                float _1964 = fma(fma(_1914, _1952.x, sqrt(_1947 + _1952.y)) / (_1943 + _1952.z), 0.4921875, _1952.w);
                _1979 = mix(spvNMax(fma(-((textureLod(sampler3D(_46, _24), vec3(_1895, _1888, _1878), 0.0) * _1857) + (textureLod(sampler3D(_46, _24), vec3(_1901, _1888, _1878), 0.0) * _1851)), _1907, (textureLod(sampler3D(_46, _24), vec3(_1853, _1841, _1831), 0.0) * _1857) + (textureLod(sampler3D(_46, _24), vec3(_1860, _1841, _1831), 0.0) * _1851)), vec4(0.0)), spvNMax(fma(-((textureLod(sampler3D(_46, _24), vec3(_1895, _1964, _1954), 0.0) * _1857) + (textureLod(sampler3D(_46, _24), vec3(_1901, _1964, _1954), 0.0) * _1851)), _1907, (textureLod(sampler3D(_46, _24), vec3(_1853, _1932, _1831), 0.0) * _1857) + (textureLod(sampler3D(_46, _24), vec3(_1860, _1932, _1831), 0.0) * _1851)), vec4(0.0)), vec4((_1696 + 0.0040000001899898052215576171875) * 124.99999237060546875));
            }
            else
            {
                float _1704 = -(_44._m0 * _44._m0);
                float _1706 = sqrt(fma(_44._m1, _44._m1, _1704));
                float _1708 = sqrt(fma(_1594, _1594, _1704));
                float _1709 = _1594 * _1578;
                float _1713 = fma(_44._m0, _44._m0, fma(_1709, _1709, -(_1594 * _1594)));
                vec4 _1719 = vec4(-1.0, _1706 * _1706, _1706, 0.50390625);
                vec4 _1720 = mix(_1719, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1709 < 0.0) && (_1713 > 0.0)));
                float _1722 = fma(_1708 / _1706, 0.96875, 0.015625);
                float _1732 = fma(fma(_1709, _1720.x, sqrt(_1713 + _1720.y)) / (_1708 + _1720.z), 0.4921875, _1720.w);
                float _1738 = _1584 + 1.0;
                float _1740 = floor(_1738 * 3.5);
                float _1742 = fma(_1738, 3.5, -_1740);
                float _1743 = _1740 + fma(fma(atan(spvNMax(_1586, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1748 = 1.0 - _1742;
                float _1758 = sqrt(fma(_1595, _1595, _1704));
                float _1762 = fma(_44._m0, _44._m0, fma(_1596, _1596, -(_1595 * _1595)));
                vec4 _1767 = mix(_1719, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1596 < 0.0) && (_1762 > 0.0)));
                float _1769 = fma(_1758 / _1706, 0.96875, 0.015625);
                float _1779 = fma(fma(_1596, _1767.x, sqrt(_1762 + _1767.y)) / (_1758 + _1767.z), 0.4921875, _1767.w);
                float _1785 = _1740 + fma(fma(atan(spvNMax(_1598, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                _1979 = spvNMax(fma(-((textureLod(sampler3D(_46, _24), vec3(_1785 * 0.125, _1779, _1769), 0.0) * _1748) + (textureLod(sampler3D(_46, _24), vec3((_1785 + 1.0) * 0.125, _1779, _1769), 0.0) * _1742)), _1690.xyzx, (textureLod(sampler3D(_46, _24), vec3(_1743 * 0.125, _1732, _1722), 0.0) * _1748) + (textureLod(sampler3D(_46, _24), vec3((_1743 + 1.0) * 0.125, _1732, _1722), 0.0) * _1742)), vec4(0.0));
            }
            float _1994 = fma(_1584, _1584, 1.0);
            _2016 = _1690;
            _2017 = (_1979.xyz * (0.0596831031143665313720703125 * _1994)) + ((((_1979.xyz * (_1979.w * smoothstep(0.0, 0.0199999995529651641845703125, _1586))) / vec3(spvNMax(_1979.x, 9.9999997473787516355514526367188e-05))) * (vec3(_44._m5.x) / _44._m5)) * ((((0.119366206228733062744140625 * fma(-_44._m9, _44._m9, 1.0)) * (-pow(spvNMax(abs(abs(fma(_44._m9 * (-2.0), _1584, fma(_44._m9, _44._m9, 1.0)))), 9.9999997473787516355514526367188e-05), 1.5))) * _1994) / fma(_44._m9, _44._m9, 2.0)));
        }
        else
        {
            _2016 = vec3(1.0);
            _2017 = vec3(0.0);
        }
        vec3 _2032;
        if (_17._m35 == 0.0)
        {
            _2032 = ((mix(textureLod(sampler2D(_45, _24), vec2(atan((_1509 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_1506 - _44._m0) / (_44._m1 - _44._m0))), 0.0).xyz, vec3(0.0), bvec3(_1509 < (-sqrt(fma(-_1510, _1510, 1.0))))) * 1.0) * _17._m34) * _17._m20;
        }
        else
        {
            _2032 = _17._m2;
        }
        _2033 = _2017 * (_17._m19 * 10.0);
        _2034 = _2016;
        _2035 = _2032;
    }
    else
    {
        _2033 = vec3(0.0);
        _2034 = vec3(1.0);
        _2035 = _17._m2;
    }
    float _2118;
    SPIRV_CROSS_BRANCH
    if (_17._m21 > 0.0)
    {
        vec3 _2058 = _18._m6 + _7;
        vec3 _2065 = vec3(0.0, _17._m18.z, 0.0) + (_2058 - vec3(0.0, _17._m25, 0.0));
        float _2069 = dot(_2065, _17._m24);
        vec2 _2079 = ((((_2065 + (_17._m24 * (sqrt(fma(_2069, _2069, fma(_17._m18.z, _17._m18.z, -dot(_2065, _2065)))) - _2069))).xz * _17._m18.w) * 0.5) + vec2(0.5)) + _17._m18.xy;
        _2079.x = 1.0 - _2079.x;
        vec3 _2092 = vec3(0.0, _17._m23.z, 0.0) + (_2058 - vec3(0.0, _17._m27, 0.0));
        float _2096 = dot(_2092, _17._m26);
        vec2 _2106 = ((((_2092 + (_17._m26 * (sqrt(fma(_2096, _2096, fma(_17._m23.z, _17._m23.z, -dot(_2092, _2092)))) - _2096))).xz * _17._m23.w) * 0.5) + vec2(0.5)) + _17._m23.xy;
        _2106.x = 1.0 - _2106.x;
        _2118 = 1.0 - clamp(smoothstep(0.0500000007450580596923828125, 0.550000011920928955078125, mix(textureLod(sampler2D(_47, _24), _2079, 0.0).x, textureLod(sampler2D(_48, _24), _2106, 0.0).x, _17._m16)) * _17._m21, 0.0, 1.0);
    }
    else
    {
        _2118 = 1.0;
    }
    float _2207;
    SPIRV_CROSS_BRANCH
    if (_17._m17 > 0.0)
    {
        vec3 _2145 = _18._m6 + _7;
        vec3 _2153 = vec3(0.0, _17._m28.z, 0.0) + ((_17._m29 + _2145) - vec3(0.0, _17._m30, 0.0));
        float _2157 = dot(_2153, _17._m24);
        vec2 _2167 = ((((_2153 + (_17._m24 * (sqrt(fma(_2157, _2157, fma(_17._m28.z, _17._m28.z, -dot(_2153, _2153)))) - _2157))).xz * _17._m28.w) * 0.5) + vec2(0.5)) + _17._m28.xy;
        _2167.x = 1.0 - _2167.x;
        vec3 _2181 = vec3(0.0, _17._m31.z, 0.0) + ((_17._m32 + _2145) - vec3(0.0, _17._m33, 0.0));
        float _2185 = dot(_2181, _17._m26);
        vec2 _2195 = ((((_2181 + (_17._m26 * (sqrt(fma(_2185, _2185, fma(_17._m31.z, _17._m31.z, -dot(_2181, _2181)))) - _2185))).xz * _17._m31.w) * 0.5) + vec2(0.5)) + _17._m31.xy;
        _2195.x = 1.0 - _2195.x;
        _2207 = _2118 * (1.0 - clamp(mix(textureLod(sampler2D(_40, _24), _2167, 0.0).x, textureLod(sampler2D(_41, _24), _2195, 0.0).x, _17._m16) * _17._m17, 0.0, 1.0));
    }
    else
    {
        _2207 = _2118;
    }
    float _2214 = fract(52.98291778564453125 * fract(fma(0.067110560834407806396484375, gl_FragCoord.x, 0.005837149918079376220703125 * gl_FragCoord.y)));
    float _2221 = clamp(fma(_37._m34.y, length(_7), _37._m34.x), 0.0, 1.0);
    uint _2222 = uint(int(fma(fma(float(int(clamp(fma(log2(_12), _37._m21, _37._m22), 0.0, float(_37._m26)))), _37._m24, float(_1459.y)), _37._m23, float(_1459.x))));
    uvec4 _2225 = uvec4(_25._m0[_2222]);
    uint _2226 = _2225.x;
    uint _2227 = _2225.y;
    uint _2230 = ((_2227 >> 0u) & 4095u) + _2226;
    uint _2233 = ((_2227 >> 12u) & 4095u) + _2230;
    uint _2237 = ((_2225.z >> 0u) & 1023u) + _2233;
    float _2239 = spvNMax(dot(_1195, _426), 9.9999997473787516355514526367188e-06);
    float _2241;
    bool _2244;
    vec3 _2246;
    vec3 _2248;
    uint _2250;
    _2241 = _354;
    _2244 = false;
    _2246 = vec3(0.0);
    _2248 = vec3(0.0);
    _2250 = _2226;
    float _2242;
    bool _2245;
    vec3 _2247;
    vec3 _2249;
    for (; _2250 < _2230; _2241 = _2242, _2244 = _2245, _2246 = _2247, _2248 = _2249, _2250++)
    {
        uint _2257 = uint(_26._m0[_2250]);
        float _2275 = abs(_27._m0[_2257]._m5);
        if ((_27._m0[_2257]._m6 & (1u << (_49._m5 & 31u))) != 0u)
        {
            vec3 _2290 = _27._m0[_2257]._m0.xyz - _7;
            float _2291 = dot(_2290, _2290);
            vec3 _2294 = _2290 * inversesqrt(spvNMax(_2291, 1.0000000133514319600180897396058e-10));
            float _2295 = _27._m0[_2257]._m0.w * _27._m0[_2257]._m0.w;
            float _2533;
            bool _2534;
            vec3 _2535;
            vec3 _2536;
            if (_2291 < (1.0 / _2295))
            {
                vec3 _2300 = _426 + _2294;
                vec3 _2304 = _2300 * inversesqrt(spvNMax(dot(_2300, _2300), 1.0000000133514319600180897396058e-10));
                float _2306 = clamp(dot(_2294, _2304), 0.0, 1.0);
                float _2308 = clamp(dot(_1195, _2304), 0.0, 1.0);
                float _2310 = clamp(dot(_1195, _2294), 0.0, 1.0);
                float _2311 = _2291 * _2295;
                float _2317 = pow(spvNMax(abs(clamp(fma(-_2311, _2311, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _27._m0[_2257]._m4);
                float _2327;
                if (_27._m0[_2257]._m5 < 0.0)
                {
                    _2327 = _2317 * fma(4.0, _2295, _2275);
                }
                else
                {
                    _2327 = _2317 * ((1.0 / spvNMax(_2291, 9.9999997473787516355514526367188e-05)) + _2275);
                }
                float _2329 = 0.079577468335628509521484375 * (_2310 * _2327);
                float _2464;
                bool _2465;
                float _2466;
                if ((_27._m0[_2257]._m7 & 1u) != 0u)
                {
                    uint _2354;
                    do
                    {
                        vec3 _2334 = -_2294;
                        float _2335 = dot(_2334, vec3(0.0, -0.57735025882720947265625, 0.8164966106414794921875));
                        float _2336 = dot(_2334, vec3(0.0, -0.57735025882720947265625, -0.8164966106414794921875));
                        float _2337 = dot(_2334, vec3(-0.8164966106414794921875, 0.57735025882720947265625, 0.0));
                        float _2341 = spvNMax(spvNMax(_2335, _2336), spvNMax(_2337, dot(_2334, vec3(0.8164966106414794921875, 0.57735025882720947265625, 0.0))));
                        if (_2341 == _2335)
                        {
                            _2354 = 0u;
                            break;
                        }
                        else
                        {
                            if (_2341 == _2336)
                            {
                                _2354 = 1u;
                                break;
                            }
                            else
                            {
                                if (_2341 == _2337)
                                {
                                    _2354 = 2u;
                                    break;
                                }
                                else
                                {
                                    _2354 = 3u;
                                    break;
                                }
                                break; // unreachable workaround
                            }
                            break; // unreachable workaround
                        }
                        break; // unreachable workaround
                    } while(false);
                    uint _2356 = uint(int(_27._m0[_2257]._m7 >> 2u)) + _2354;
                    float _2458;
                    bool _2459;
                    float _2460;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2310 <= 0.0) && true)
                        {
                            _2458 = _2241;
                            _2459 = _2244;
                            _2460 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2389 = _38._m0[_2356]._m0 * vec4(_7 + (_1195 * ((3.5 * float(int(sign(_2310)))) * (_38._m0[_2356]._m4 * sqrt(_2291)))), 1.0);
                            vec3 _2393 = _2389.xyz / vec3(_2389.w);
                            vec2 _2396 = (_2393.xy * 0.5) + vec2(0.5);
                            _2396.y = 1.0 - _2396.y;
                            float _2405 = (_38._m0[_2356]._m5.y / _38._m0[_2356]._m6) / (_2393.z - _38._m0[_2356]._m5.x);
                            float _2410 = _2244 ? _2241 : 6.283185482025146484375;
                            float _2411 = _2214 * _2410;
                            vec2 _2412 = _38._m0[_2356]._m1 + _37._m33;
                            vec2 _2415 = (_38._m0[_2356]._m1 + vec2(_38._m0[_2356]._m2)) - _37._m33;
                            float _2417;
                            _2417 = 0.0;
                            for (int _2420 = 0; _2420 < 12; )
                            {
                                float _2425 = float(uint(_2420));
                                float _2428 = sqrt(_2425 + 0.5) * 0.288675129413604736328125;
                                float _2429 = fma(_2425, 2.3999631404876708984375, _2411);
                                vec2 _2437 = clamp(fma((vec3(cos(_2429), sin(_2429), _2428).xy * _2428) * 2.5, _37._m33, _2396), _2412, _2415);
                                vec2 _2440 = fract(fma(vec2(1.0) / _37._m33, _2437, vec2(0.5)));
                                vec4 _2446 = vec4(lessThan(vec4(_2405), textureGather(sampler2D(_39, _30), _2437)));
                                float _2449 = _2440.x;
                                _2417 += clamp(mix(mix(_2446.w, _2446.z, _2449), mix(_2446.x, _2446.y, _2449), _2440.y), 0.0, 1.0);
                                _2420++;
                                continue;
                            }
                            _2458 = _2410;
                            _2459 = _2244 ? _2244 : true;
                            _2460 = _2417 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2464 = _2458;
                    _2465 = _2459;
                    _2466 = _2329 * mix(1.0, _2460, spvNMin(_2221, _27._m0[_2257]._m8));
                }
                else
                {
                    _2464 = _2241;
                    _2465 = _2244;
                    _2466 = _2329;
                }
                vec3 _2531;
                vec3 _2532;
                if (_2310 > 0.0)
                {
                    vec3 _2472 = _27._m0[_2257]._m1.xyz * (_2466 * ((_27._m0[_2257]._m3 < 0.0) ? _23._m0[0u] : 1.0));
                    vec3 _2479 = vec3(fma((2.0 * _2306) * _2306, _1451, mix(0.0, 0.5, _1451))) - vec3(1.0);
                    float _2500 = (_1451 + 1.0) * 0.5;
                    float _2501 = _1451 * _1451;
                    float _2509 = _2500 * _2500;
                    float _2521 = _2501 * _2501;
                    float _2524 = fma(fma(_2308, _2521, -_2308), _2308, 1.0);
                    _2531 = fma(_2472, (_1441 + ((vec3(1.0) - _1441) * pow(spvNMax(abs(1.0 - _2306), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2310, sqrt(fma(fma(-_2239, _2509, _2239), _2239, _2509)), _2239 * sqrt(fma(fma(-_2310, _2509, _2310), _2310, _2509)))) * (_2521 * (0.3183098733425140380859375 / (_2524 * _2524)))), _2246);
                    _2532 = fma(_2472, _1436 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2479 * pow(spvNMax(abs(1.0 - _2310), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2479 * pow(spvNMax(abs(1.0 - _2239), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1451))), _2248);
                }
                else
                {
                    _2531 = _2246;
                    _2532 = _2248;
                }
                _2533 = _2464;
                _2534 = _2465;
                _2535 = _2531;
                _2536 = _2532;
            }
            else
            {
                _2533 = _2241;
                _2534 = _2244;
                _2535 = _2246;
                _2536 = _2248;
            }
            _2242 = _2533;
            _2245 = _2534;
            _2247 = _2535;
            _2249 = _2536;
        }
        else
        {
            _2242 = _2241;
            _2245 = _2244;
            _2247 = _2246;
            _2249 = _2248;
        }
    }
    float _2538;
    bool _2541;
    vec3 _2543;
    vec3 _2545;
    uint _2547;
    _2538 = _2241;
    _2541 = _2244;
    _2543 = _2246;
    _2545 = _2248;
    _2547 = _2250;
    float _2539;
    bool _2542;
    vec3 _2544;
    vec3 _2546;
    for (; _2547 < _2233; _2538 = _2539, _2541 = _2542, _2543 = _2544, _2545 = _2546, _2547++)
    {
        uint _2554 = uint(_26._m0[_2547]);
        float _2567 = abs(_27._m0[_2554]._m5);
        if ((_27._m0[_2554]._m6 & (1u << (_49._m5 & 31u))) != 0u)
        {
            vec3 _2585 = _27._m0[_2554]._m0.xyz - _7;
            float _2586 = dot(_2585, _2585);
            vec3 _2589 = _2585 * inversesqrt(spvNMax(_2586, 1.0000000133514319600180897396058e-10));
            float _2590 = _27._m0[_2554]._m0.w * _27._m0[_2554]._m0.w;
            float _2818;
            bool _2819;
            vec3 _2820;
            vec3 _2821;
            if (_2586 < (1.0 / _2590))
            {
                vec3 _2595 = _426 + _2589;
                vec3 _2599 = _2595 * inversesqrt(spvNMax(dot(_2595, _2595), 1.0000000133514319600180897396058e-10));
                float _2601 = clamp(dot(_2589, _2599), 0.0, 1.0);
                float _2603 = clamp(dot(_1195, _2599), 0.0, 1.0);
                float _2605 = clamp(dot(_1195, _2589), 0.0, 1.0);
                float _2608 = dot(-_2589, normalize(_27._m0[_2554]._m2.xyz));
                float _2637;
                if (_2608 > _27._m0[_2554]._m1.w)
                {
                    float _2612 = _2586 * _2590;
                    float _2618 = pow(spvNMax(abs(clamp(fma(-_2612, _2612, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _27._m0[_2554]._m4);
                    float _2628;
                    if (_27._m0[_2554]._m5 < 0.0)
                    {
                        _2628 = _2618 * fma(4.0, _2590, _2567);
                    }
                    else
                    {
                        _2628 = _2618 * ((1.0 / spvNMax(_2586, 9.9999997473787516355514526367188e-05)) + _2567);
                    }
                    float _2633 = clamp((_2608 - _27._m0[_2554]._m1.w) / spvNMax(_27._m0[_2554]._m2.w - _27._m0[_2554]._m1.w, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
                    _2637 = _2605 * (_2628 * (_2633 * _2633));
                }
                else
                {
                    _2637 = 0.0;
                }
                float _2638 = 0.3183098733425140380859375 * _2637;
                float _2749;
                bool _2750;
                float _2751;
                if ((_27._m0[_2554]._m7 & 1u) != 0u)
                {
                    uint _2641 = uint(int(_27._m0[_2554]._m7 >> 2u));
                    float _2743;
                    bool _2744;
                    float _2745;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2605 <= 0.0) && true)
                        {
                            _2743 = _2538;
                            _2744 = _2541;
                            _2745 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2674 = _38._m0[_2641]._m0 * vec4(_7 + (_1195 * ((3.5 * float(int(sign(_2605)))) * (_38._m0[_2641]._m4 * sqrt(_2586)))), 1.0);
                            vec3 _2678 = _2674.xyz / vec3(_2674.w);
                            vec2 _2681 = (_2678.xy * 0.5) + vec2(0.5);
                            _2681.y = 1.0 - _2681.y;
                            float _2690 = (_38._m0[_2641]._m5.y / _38._m0[_2641]._m6) / (_2678.z - _38._m0[_2641]._m5.x);
                            float _2695 = _2541 ? _2538 : 6.283185482025146484375;
                            float _2696 = _2214 * _2695;
                            vec2 _2697 = _38._m0[_2641]._m1 + _37._m33;
                            vec2 _2700 = (_38._m0[_2641]._m1 + vec2(_38._m0[_2641]._m2)) - _37._m33;
                            float _2702;
                            _2702 = 0.0;
                            for (int _2705 = 0; _2705 < 12; )
                            {
                                float _2710 = float(uint(_2705));
                                float _2713 = sqrt(_2710 + 0.5) * 0.288675129413604736328125;
                                float _2714 = fma(_2710, 2.3999631404876708984375, _2696);
                                vec2 _2722 = clamp(fma((vec3(cos(_2714), sin(_2714), _2713).xy * _2713) * 2.5, _37._m33, _2681), _2697, _2700);
                                vec2 _2725 = fract(fma(vec2(1.0) / _37._m33, _2722, vec2(0.5)));
                                vec4 _2731 = vec4(lessThan(vec4(_2690), textureGather(sampler2D(_39, _30), _2722)));
                                float _2734 = _2725.x;
                                _2702 += clamp(mix(mix(_2731.w, _2731.z, _2734), mix(_2731.x, _2731.y, _2734), _2725.y), 0.0, 1.0);
                                _2705++;
                                continue;
                            }
                            _2743 = _2695;
                            _2744 = _2541 ? _2541 : true;
                            _2745 = _2702 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2749 = _2743;
                    _2750 = _2744;
                    _2751 = _2638 * mix(1.0, _2745, spvNMin(_2221, _27._m0[_2554]._m8));
                }
                else
                {
                    _2749 = _2538;
                    _2750 = _2541;
                    _2751 = _2638;
                }
                vec3 _2816;
                vec3 _2817;
                if (_2605 > 0.0)
                {
                    vec3 _2757 = _27._m0[_2554]._m1.xyz * (_2751 * ((_27._m0[_2554]._m3 < 0.0) ? _23._m0[0u] : 1.0));
                    vec3 _2764 = vec3(fma((2.0 * _2601) * _2601, _1451, mix(0.0, 0.5, _1451))) - vec3(1.0);
                    float _2785 = (_1451 + 1.0) * 0.5;
                    float _2786 = _1451 * _1451;
                    float _2794 = _2785 * _2785;
                    float _2806 = _2786 * _2786;
                    float _2809 = fma(fma(_2603, _2806, -_2603), _2603, 1.0);
                    _2816 = fma(_2757, (_1441 + ((vec3(1.0) - _1441) * pow(spvNMax(abs(1.0 - _2601), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2605, sqrt(fma(fma(-_2239, _2794, _2239), _2239, _2794)), _2239 * sqrt(fma(fma(-_2605, _2794, _2605), _2605, _2794)))) * (_2806 * (0.3183098733425140380859375 / (_2809 * _2809)))), _2543);
                    _2817 = fma(_2757, _1436 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2764 * pow(spvNMax(abs(1.0 - _2605), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2764 * pow(spvNMax(abs(1.0 - _2239), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1451))), _2545);
                }
                else
                {
                    _2816 = _2543;
                    _2817 = _2545;
                }
                _2818 = _2749;
                _2819 = _2750;
                _2820 = _2816;
                _2821 = _2817;
            }
            else
            {
                _2818 = _2538;
                _2819 = _2541;
                _2820 = _2543;
                _2821 = _2545;
            }
            _2539 = _2818;
            _2542 = _2819;
            _2544 = _2820;
            _2546 = _2821;
        }
        else
        {
            _2539 = _2538;
            _2542 = _2541;
            _2544 = _2543;
            _2546 = _2545;
        }
    }
    vec3 _2828;
    vec3 _2830;
    _2828 = _2543;
    _2830 = _2545;
    float _2824;
    bool _2827;
    vec3 _2829;
    vec3 _2831;
    float _2823 = _2538;
    bool _2826 = _2541;
    uint _2832 = _2547;
    for (; _2832 < _2237; _2823 = _2824, _2826 = _2827, _2828 = _2829, _2830 = _2831, _2832++)
    {
        uint _2839 = uint(_26._m0[_2832]);
        int _2868 = int(_28._m0[_2839]._m1 >> 1u) - 1;
        if (((_28._m0[_2839]._m4 & 16777215u) & (1u << (_49._m5 & 31u))) != 0u)
        {
            vec3 _2879 = _28._m0[_2839]._m6 * vec4(_7, 1.0);
            float _3267;
            bool _3268;
            vec3 _3269;
            vec3 _3270;
            if (all(lessThan(abs(_2879 - vec3(0.5)), vec3(0.5))))
            {
                vec3 _2886 = _426 + _28._m0[_2839]._m9;
                vec3 _2890 = _2886 * inversesqrt(spvNMax(dot(_2886, _2886), 1.0000000133514319600180897396058e-10));
                float _2892 = clamp(dot(_28._m0[_2839]._m9, _2890), 0.0, 1.0);
                float _2894 = clamp(dot(_1195, _2890), 0.0, 1.0);
                float _2896 = clamp(dot(_1195, _28._m0[_2839]._m9), 0.0, 1.0);
                int _2897 = int(_28._m0[_2839]._m4 >> 24u);
                float _2898 = _2879.z;
                vec3 _2937;
                if (_2898 < _28._m0[_2839]._m2.x)
                {
                    float _2925 = _2898 * _28._m0[_2839]._m2.z;
                    float _2928 = _2925 * _2925;
                    vec3 _2936;
                    _2936.z = dot(_370[_2897], vec4(_2925, _2928, smoothstep(0.0, 1.0, _2925), (_2928 * _2925) * fma(_2925, fma(_2925, 6.0, -15.0), 10.0)));
                    _2937 = _2936;
                }
                else
                {
                    vec3 _2923;
                    if (_2898 > _28._m0[_2839]._m2.y)
                    {
                        float _2911 = (1.0 - _2898) * _28._m0[_2839]._m2.w;
                        float _2914 = _2911 * _2911;
                        vec3 _2922;
                        _2922.z = dot(_370[_2897], vec4(_2911, _2914, smoothstep(0.0, 1.0, _2911), (_2914 * _2911) * fma(_2911, fma(_2911, 6.0, -15.0), 10.0)));
                        _2923 = _2922;
                    }
                    else
                    {
                        _2923 = vec3(0.0, 0.0, 1.0);
                    }
                    _2937 = _2923;
                }
                vec2 _2938 = _2879.xy;
                vec2 _2942 = (vec2(0.5) - abs(_2938 - vec2(0.5))) * _28._m0[_2839]._m3;
                float _2943 = _2942.x;
                vec3 _2960;
                if (_2943 < 1.0)
                {
                    float _2951 = _2943 * _2943;
                    vec3 _2959 = _2937;
                    _2959.x = dot(_370[_2897], vec4(_2943, _2951, smoothstep(0.0, 1.0, _2943), (_2951 * _2943) * fma(_2943, fma(_2943, 6.0, -15.0), 10.0)));
                    _2960 = _2959;
                }
                else
                {
                    vec3 _2948 = _2937;
                    _2948.x = 1.0;
                    _2960 = _2948;
                }
                float _2961 = _2942.y;
                vec3 _2978;
                if (_2961 < 1.0)
                {
                    float _2969 = _2961 * _2961;
                    vec3 _2977 = _2960;
                    _2977.y = dot(_370[_2897], vec4(_2961, _2969, smoothstep(0.0, 1.0, _2961), (_2969 * _2961) * fma(_2961, fma(_2961, 6.0, -15.0), 10.0)));
                    _2978 = _2977;
                }
                else
                {
                    vec3 _2966 = _2960;
                    _2966.y = 1.0;
                    _2978 = _2966;
                }
                float _2984 = _2896 * ((_2978.x * _2978.y) * _2978.z);
                float _3089;
                bool _3090;
                float _3091;
                if ((_28._m0[_2839]._m8 & 1u) != 0u)
                {
                    uint _2987 = uint(int(_28._m0[_2839]._m8 >> 2u));
                    float _3083;
                    bool _3084;
                    float _3085;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2896 <= 0.0) && true)
                        {
                            _3083 = _2823;
                            _3084 = _2826;
                            _3085 = 0.0;
                            break;
                        }
                        else
                        {
                            vec3 _3013 = _7 + (_1195 * ((3.5 * float(int(sign(_2896)))) * _38._m0[_2987]._m4));
                            vec4 _3018 = _38._m0[_2987]._m0 * vec4(_3013, 1.0);
                            vec2 _3021 = (_3018.xy * 0.5) + vec2(0.5);
                            _3021.y = 1.0 - _3021.y;
                            float _3030 = ((_3018.z - _38._m0[_2987]._m5.y) / _38._m0[_2987]._m5.x) / _38._m0[_2987]._m6;
                            float _3035 = _2826 ? _2823 : 6.283185482025146484375;
                            float _3036 = _2214 * _3035;
                            vec2 _3037 = _38._m0[_2987]._m1 + _37._m33;
                            vec2 _3040 = (_38._m0[_2987]._m1 + vec2(_38._m0[_2987]._m2)) - _37._m33;
                            float _3042;
                            _3042 = 0.0;
                            for (int _3045 = 0; _3045 < 12; )
                            {
                                float _3050 = float(uint(_3045));
                                float _3053 = sqrt(_3050 + 0.5) * 0.288675129413604736328125;
                                float _3054 = fma(_3050, 2.3999631404876708984375, _3036);
                                vec2 _3062 = clamp(fma((vec3(cos(_3054), sin(_3054), _3053).xy * _3053) * 2.5, _37._m33, _3021), _3037, _3040);
                                vec2 _3065 = fract(fma(vec2(1.0) / _37._m33, _3062, vec2(0.5)));
                                vec4 _3071 = vec4(lessThan(vec4(_3030), textureGather(sampler2D(_39, _30), _3062)));
                                float _3074 = _3065.x;
                                _3042 += clamp(mix(mix(_3071.w, _3071.z, _3074), mix(_3071.x, _3071.y, _3074), _3065.y), 0.0, 1.0);
                                _3045++;
                                continue;
                            }
                            _3083 = _3035;
                            _3084 = _2826 ? _2826 : true;
                            _3085 = _3042 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _3089 = _3083;
                    _3090 = _3084;
                    _3091 = _2984 * mix(1.0, _3085, spvNMin(_2221, _28._m0[_2839]._m5));
                }
                else
                {
                    _3089 = _2823;
                    _3090 = _2826;
                    _3091 = _2984;
                }
                vec3 _3132;
                if (_2868 >= 0)
                {
                    uint _3096 = gl_SubgroupInvocationID & 3u;
                    vec2 _3102 = (subgroupQuadSwapHorizontal(_2938) - _2938) * (((_3096 & 1u) != 0u) ? (-1.0) : 1.0);
                    vec2 _3108 = (subgroupQuadSwapVertical(_2938) - _2938) * (((_3096 & 2u) != 0u) ? (-1.0) : 1.0);
                    vec2 _3112 = mix(_3102, vec2(0.0), bvec2(any(isnan(_3102))));
                    vec2 _3116 = mix(_3108, vec2(0.0), bvec2(any(isnan(_3108))));
                    bvec2 _3125 = bvec2(any(greaterThan(abs(vec4(_3112, _3116)), vec4(0.015625))));
                    int _98 = _2868;
                    _3132 = _28._m0[_2839]._m0 * textureGrad(nonuniformEXT(sampler2D(_43[_98], _24)), _2938, mix(_3112, vec2(0.0), _3125), mix(_3116, vec2(0.0), _3125)).xyz;
                }
                else
                {
                    _3132 = _28._m0[_2839]._m0;
                }
                vec3 _3265;
                vec3 _3266;
                SPIRV_CROSS_BRANCH
                if ((_28._m0[_2839]._m1 & 1u) != 0u)
                {
                    vec3 _3263;
                    vec3 _3264;
                    if (_2896 > 0.0)
                    {
                        vec3 _3204 = _3132 * (_3091 * _23._m0[0u]);
                        vec3 _3211 = vec3(fma((2.0 * _2892) * _2892, _1451, mix(0.0, 0.5, _1451))) - vec3(1.0);
                        float _3232 = (_1451 + 1.0) * 0.5;
                        float _3233 = _1451 * _1451;
                        float _3241 = _3232 * _3232;
                        float _3253 = _3233 * _3233;
                        float _3256 = fma(fma(_2894, _3253, -_2894), _2894, 1.0);
                        _3263 = fma(_3204, (_1441 + ((vec3(1.0) - _1441) * pow(spvNMax(abs(1.0 - _2892), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2896, sqrt(fma(fma(-_2239, _3241, _2239), _2239, _3241)), _2239 * sqrt(fma(fma(-_2896, _3241, _2896), _2896, _3241)))) * (_3253 * (0.3183098733425140380859375 / (_3256 * _3256)))), _2828);
                        _3264 = fma(_3204, _1436 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3211 * pow(spvNMax(abs(1.0 - _2896), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3211 * pow(spvNMax(abs(1.0 - _2239), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1451))), _2830);
                    }
                    else
                    {
                        _3263 = _2828;
                        _3264 = _2830;
                    }
                    _3265 = _3263;
                    _3266 = _3264;
                }
                else
                {
                    vec3 _3198;
                    vec3 _3199;
                    if (_2896 > 0.0)
                    {
                        vec3 _3139 = _3132 * _3091;
                        vec3 _3146 = vec3(fma((2.0 * _2892) * _2892, _1451, mix(0.0, 0.5, _1451))) - vec3(1.0);
                        float _3167 = (_1451 + 1.0) * 0.5;
                        float _3168 = _1451 * _1451;
                        float _3176 = _3167 * _3167;
                        float _3188 = _3168 * _3168;
                        float _3191 = fma(fma(_2894, _3188, -_2894), _2894, 1.0);
                        _3198 = fma(_3139, (_1441 + ((vec3(1.0) - _1441) * pow(spvNMax(abs(1.0 - _2892), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2896, sqrt(fma(fma(-_2239, _3176, _2239), _2239, _3176)), _2239 * sqrt(fma(fma(-_2896, _3176, _2896), _2896, _3176)))) * (_3188 * (0.3183098733425140380859375 / (_3191 * _3191)))), _2828);
                        _3199 = fma(_3139, _1436 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3146 * pow(spvNMax(abs(1.0 - _2896), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3146 * pow(spvNMax(abs(1.0 - _2239), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1451))), _2830);
                    }
                    else
                    {
                        _3198 = _2828;
                        _3199 = _2830;
                    }
                    _3265 = _3198;
                    _3266 = _3199;
                }
                _3267 = _3089;
                _3268 = _3090;
                _3269 = _3265;
                _3270 = _3266;
            }
            else
            {
                _3267 = _2823;
                _3268 = _2826;
                _3269 = _2828;
                _3270 = _2830;
            }
            _2824 = _3267;
            _2827 = _3268;
            _2829 = _3269;
            _2831 = _3270;
        }
        else
        {
            _2824 = _2823;
            _2827 = _2826;
            _2829 = _2828;
            _2831 = _2830;
        }
    }
    // Hero lighting toggle: zero all tiled local light contributions for this hero character surface
    // Mirrors deferred shader behavior which zeros all lights for material types 5/7 when hero lighting is off
    _2828 *= (pc.hero_lighting > 0.5) ? 0.5 : 1.0;
    _2830 *= (pc.hero_lighting > 0.5) ? 0.5 : 1.0;
    vec3 _3272 = reflect(-_426, _1195);
    vec3 _3274 = vec3(_1441.x, _1441.y, _1441.z);
    vec3 _3284 = textureLod(samplerCube(_32, _24), _1195, 0.0).xyz * _37._m27;
    vec3 _3291 = textureLod(samplerCube(_33, _24), _3272, fma(_1451, 8.0, _37._m30 - 8.0)).xyz * _37._m27;
    vec3 _3316;
    vec3 _3317;
    SPIRV_CROSS_BRANCH
    if (_37._m29 > 0.0)
    {
        vec3 _3306 = vec3(_37._m29);
        _3316 = mix(_3291, textureLod(samplerCube(_35, _24), _3272, fma(_1451, 8.0, _37._m31 - 8.0)).xyz * _37._m28, _3306);
        _3317 = mix(_3284, textureLod(samplerCube(_34, _24), _1195, 0.0).xyz * _37._m28, _3306);
    }
    else
    {
        _3316 = _3291;
        _3317 = _3284;
    }
    float _3318 = spvNMax(dot(_426, _1195), 0.001953125);
    vec4 _3323 = textureLod(sampler2D(_36, _30), vec2(_3318, _1451), 0.0);
    uvec4 _3334 = uvec4(_25._m0[_2222]);
    uint _3336 = _3334.y;
    uint _3346 = ((_3334.z >> 0u) & 1023u) + (((_3336 >> 12u) & 4095u) + (((_3336 >> 0u) & 4095u) + _3334.x));
    uint _3348 = (_3336 >> 24u) + _3346;
    vec3 _3350;
    vec3 _3353;
    _3350 = _3316 * ((_3274 * _3323.x) + vec3(_3323.y));
    _3353 = _3317 * (_1436 * _3323.z);
    vec3 _3351;
    vec3 _3354;
    for (uint _3355 = _3346; _3355 < _3348; _3350 = _3351, _3353 = _3354, _3355++)
    {
        uint _3362 = uint(_26._m0[_3355]);
        int _3381 = int((_31._m0[_3362]._m5 >> 1u) & 3u);
        mat3 _3385 = mat3(_31._m0[_3362]._m1[0], _31._m0[_3362]._m1[1], _31._m0[_3362]._m1[2]);
        int _3391 = (int((_31._m0[_3362]._m5 >> 3u) & 16383u) - 1) * 2;
        int _3396 = (int((_31._m0[_3362]._m5 >> 17u) & 16383u) - 1) * 2;
        int _3401 = (int((_31._m0[_3362]._m6 >> 0u) & 65535u) - 1) * 2;
        int _3406 = (int((_31._m0[_3362]._m6 >> 16u) & 65535u) - 1) * 2;
        float _3409 = (_31._m0[_3362]._m3 < 0.0) ? (-_31._m0[_3362]._m3) : 1.0;
        vec3 _3411 = _3385 * (_7 - _31._m0[_3362]._m1[3]);
        bool _3412 = int(_31._m0[_3362]._m5 & 1u) == 1;
        vec3 _3413 = abs(_3411);
        float _3416 = dot(_3411, _3411);
        if (_3412 ? any(greaterThanEqual(_3413, _31._m0[_3362]._m0.xyz)) : (_3416 >= _31._m0[_3362]._m0.y))
        {
            _3351 = _3350;
            _3354 = _3353;
            continue;
        }
        vec3 _3590;
        SPIRV_CROSS_FLATTEN
        if ((_3381 & 1) != 0)
        {
            vec3 _3426 = _3385 * _1195;
            vec2 _3515;
            bool _3516;
            if (_3412)
            {
                vec2 _3510;
                bool _3514;
                do
                {
                    vec3 _3494 = (_31._m0[_3362]._m0.xyz - _3411) / _3426;
                    vec3 _3497 = ((-_31._m0[_3362]._m0.xyz) - _3411) / _3426;
                    vec3 _3498 = spvNMin(_3494, _3497);
                    vec3 _3499 = spvNMax(_3494, _3497);
                    float _3504 = spvNMax(_3498.x, spvNMax(_3498.y, _3498.z));
                    float _3509 = spvNMin(_3499.x, spvNMin(_3499.y, _3499.z));
                    _3510 = vec2(_3504, _3509);
                    if (_3504 > _3509)
                    {
                        _3514 = false;
                        break;
                    }
                    _3514 = true;
                    break;
                } while(false);
                _3515 = _3510;
                _3516 = _3514;
            }
            else
            {
                vec2 _3489;
                bool _3490;
                do
                {
                    float _3432 = dot(_3426, _3426);
                    float _3433 = dot(_3426, _3411);
                    float _3434 = 2.0 * _3433;
                    float _3435 = _3416 - _31._m0[_3362]._m0.y;
                    float _3471;
                    float _3472;
                    bool _3473;
                    do
                    {
                        float _3441 = fma(_3434, _3434, -((4.0 * _3432) * _3435));
                        float _3469;
                        float _3470;
                        if (_3441 < 0.0)
                        {
                            _3471 = 0.0;
                            _3472 = 0.0;
                            _3473 = false;
                            break;
                        }
                        else
                        {
                            if (_3441 == 0.0)
                            {
                                float _3468 = (_3433 * (-1.0)) * (1.0 / _3432);
                                _3469 = _3468;
                                _3470 = _3468;
                            }
                            else
                            {
                                float _3461;
                                if (_3434 > 0.0)
                                {
                                    _3461 = (-0.5) * fma(2.0, _3433, sqrt(_3441));
                                }
                                else
                                {
                                    _3461 = (-0.5) * fma(2.0, _3433, -sqrt(_3441));
                                }
                                _3469 = _3435 * (1.0 / _3461);
                                _3470 = _3461 * (1.0 / _3432);
                            }
                        }
                        _3471 = _3469;
                        _3472 = _3470;
                        _3473 = true;
                        break;
                    } while(false);
                    if (!_3473)
                    {
                        _3489 = vec2(0.0);
                        _3490 = false;
                        break;
                    }
                    if ((_3472 < 0.0) && (_3471 < 0.0))
                    {
                        _3489 = vec2(0.0);
                        _3490 = false;
                        break;
                    }
                    vec2 _3488;
                    if (_3472 > _3471)
                    {
                        _3488 = vec2(_3471, _3472);
                    }
                    else
                    {
                        _3488 = vec2(_3472, _3471);
                    }
                    _3489 = _3488;
                    _3490 = true;
                    break;
                } while(false);
                _3515 = _3489;
                _3516 = _3490;
            }
            vec3 _3519 = _3411 + (_3426 * _3515.y);
            float _3540;
            if (_3412)
            {
                _3540 = 1.0 - clamp(length(spvNMax(_3413 - (_31._m0[_3362]._m0.xyz - vec3(_31._m0[_3362]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_31._m0[_3362]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3540 = clamp((_31._m0[_3362]._m0.x - length(_3411)) * (1.0 / spvNMax(_31._m0[_3362]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3543 = float(_3516) * smoothstep(0.0, 1.0, _3540);
            vec4 _3585;
            SPIRV_CROSS_BRANCH
            if (_3543 > 9.9999997473787516355514526367188e-05)
            {
                float _3552 = mix(clamp((_3515.y * (1.0 / length(_3519))) * _1451, 0.0, _1451), _1451, _1451);
                vec3 _3554 = mix(_3519, _3426, vec3(_3552));
                int _102 = _3391;
                vec4 _3555 = textureLod(nonuniformEXT(samplerCube(_42[_102], _24)), _3554, 0.0);
                int _106 = _3391 + 1;
                _3555.w = textureLod(nonuniformEXT(samplerCube(_42[_106], _24)), _3554, 0.0).x;
                vec4 _3570;
                SPIRV_CROSS_BRANCH
                if (_3396 >= 0)
                {
                    int _110 = _3396;
                    vec4 _3563 = textureLod(nonuniformEXT(samplerCube(_42[_110], _24)), _3554, 0.0);
                    int _114 = _3396 + 1;
                    _3563.w = textureLod(nonuniformEXT(samplerCube(_42[_114], _24)), _3554, 0.0).x;
                    _3570 = mix(_3555, _3563, vec4(_31._m0[_3362]._m3));
                }
                else
                {
                    _3570 = _3555;
                }
                vec4 _3571 = _3570 * _3409;
                vec3 _3580 = (_3571.xyz * _31._m0[_3362]._m4).xyz * (_1436 * textureLod(sampler2D(_36, _30), vec2(_3318, _3552), 0.0).z);
                vec4 _3581 = vec4(_3580.x, _3580.y, _3580.z, _3571.w);
                _3581.w = _3571.w * _3543;
                _3585 = _3581;
            }
            else
            {
                _3585 = vec4(0.0);
            }
            _3590 = mix(_3353, _3585.xyz, vec3(_3585.w));
        }
        else
        {
            _3590 = _3353;
        }
        vec3 _3769;
        SPIRV_CROSS_FLATTEN
        if ((_3381 & 2) != 0)
        {
            vec3 _3595 = _3385 * _3272;
            vec2 _3684;
            bool _3685;
            if (_3412)
            {
                vec2 _3679;
                bool _3683;
                do
                {
                    vec3 _3663 = (_31._m0[_3362]._m0.xyz - _3411) / _3595;
                    vec3 _3666 = ((-_31._m0[_3362]._m0.xyz) - _3411) / _3595;
                    vec3 _3667 = spvNMin(_3663, _3666);
                    vec3 _3668 = spvNMax(_3663, _3666);
                    float _3673 = spvNMax(_3667.x, spvNMax(_3667.y, _3667.z));
                    float _3678 = spvNMin(_3668.x, spvNMin(_3668.y, _3668.z));
                    _3679 = vec2(_3673, _3678);
                    if (_3673 > _3678)
                    {
                        _3683 = false;
                        break;
                    }
                    _3683 = true;
                    break;
                } while(false);
                _3684 = _3679;
                _3685 = _3683;
            }
            else
            {
                vec2 _3658;
                bool _3659;
                do
                {
                    float _3601 = dot(_3595, _3595);
                    float _3602 = dot(_3595, _3411);
                    float _3603 = 2.0 * _3602;
                    float _3604 = _3416 - _31._m0[_3362]._m0.y;
                    float _3640;
                    float _3641;
                    bool _3642;
                    do
                    {
                        float _3610 = fma(_3603, _3603, -((4.0 * _3601) * _3604));
                        float _3638;
                        float _3639;
                        if (_3610 < 0.0)
                        {
                            _3640 = 0.0;
                            _3641 = 0.0;
                            _3642 = false;
                            break;
                        }
                        else
                        {
                            if (_3610 == 0.0)
                            {
                                float _3637 = (_3602 * (-1.0)) * (1.0 / _3601);
                                _3638 = _3637;
                                _3639 = _3637;
                            }
                            else
                            {
                                float _3630;
                                if (_3603 > 0.0)
                                {
                                    _3630 = (-0.5) * fma(2.0, _3602, sqrt(_3610));
                                }
                                else
                                {
                                    _3630 = (-0.5) * fma(2.0, _3602, -sqrt(_3610));
                                }
                                _3638 = _3604 * (1.0 / _3630);
                                _3639 = _3630 * (1.0 / _3601);
                            }
                        }
                        _3640 = _3638;
                        _3641 = _3639;
                        _3642 = true;
                        break;
                    } while(false);
                    if (!_3642)
                    {
                        _3658 = vec2(0.0);
                        _3659 = false;
                        break;
                    }
                    if ((_3641 < 0.0) && (_3640 < 0.0))
                    {
                        _3658 = vec2(0.0);
                        _3659 = false;
                        break;
                    }
                    vec2 _3657;
                    if (_3641 > _3640)
                    {
                        _3657 = vec2(_3640, _3641);
                    }
                    else
                    {
                        _3657 = vec2(_3641, _3640);
                    }
                    _3658 = _3657;
                    _3659 = true;
                    break;
                } while(false);
                _3684 = _3658;
                _3685 = _3659;
            }
            vec3 _3688 = _3411 + (_3595 * _3684.y);
            float _3709;
            if (_3412)
            {
                _3709 = 1.0 - clamp(length(spvNMax(_3413 - (_31._m0[_3362]._m0.xyz - vec3(_31._m0[_3362]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_31._m0[_3362]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3709 = clamp((_31._m0[_3362]._m0.x - length(_3411)) * (1.0 / spvNMax(_31._m0[_3362]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3712 = float(_3685) * smoothstep(0.0, 1.0, _3709);
            vec4 _3764;
            SPIRV_CROSS_BRANCH
            if (_3712 > 9.9999997473787516355514526367188e-05)
            {
                float _3721 = mix(clamp((_3684.y * (1.0 / length(_3688))) * _1451, 0.0, _1451), _1451, _1451);
                vec3 _3723 = mix(_3688, _3595, vec3(_3721));
                float _3724 = _3721 * 8.0;
                int _118 = _3401;
                int _122 = _3401 + 1;
                vec4 _3732 = vec4(textureLod(nonuniformEXT(samplerCube(_42[_118], _24)), _3723, _3724).xyz, textureLod(nonuniformEXT(samplerCube(_42[_122], _24)), _3723, _3724).x);
                vec4 _3746;
                SPIRV_CROSS_BRANCH
                if (_3406 >= 0)
                {
                    int _126 = _3406;
                    int _130 = _3406 + 1;
                    _3746 = mix(_3732, vec4(textureLod(nonuniformEXT(samplerCube(_42[_126], _24)), _3723, _3724).xyz, textureLod(nonuniformEXT(samplerCube(_42[_130], _24)), _3723, _3724).x), vec4(_31._m0[_3362]._m3));
                }
                else
                {
                    _3746 = _3732;
                }
                vec4 _3747 = _3746 * _3409;
                vec4 _3752 = textureLod(sampler2D(_36, _30), vec2(_3318, _3721), 0.0);
                vec3 _3759 = (_3747.xyz * _31._m0[_3362]._m4).xyz * ((_3274 * _3752.x) + vec3(_3752.y));
                vec4 _3760 = vec4(_3759.x, _3759.y, _3759.z, _3747.w);
                _3760.w = _3747.w * _3712;
                _3764 = _3760;
            }
            else
            {
                _3764 = vec4(0.0);
            }
            _3769 = mix(_3350, _3764.xyz, vec3(_3764.w));
        }
        else
        {
            _3769 = _3350;
        }
        _3351 = _3769;
        _3354 = _3590;
    }
    float _3770 = _23._m0[0u] * 100.0;
    vec3 _3774 = (pc.hero_lighting > 0.5) ? (_2035 * (_2207 * _23._m0[0u]) * 0.5) : (_2035 * (_2207 * _23._m0[0u]));
    vec3 _3777 = reflect(_426, _1195);
    float _3781 = clamp(dot(_17._m0, normalize(_426 + _17._m0)), 0.0, 1.0);
    float _3783 = clamp(dot(_1195, _17._m0), 0.0, 1.0);
    vec3 _3790 = vec3(fma((2.0 * _3781) * _3781, _1451, mix(0.0, 0.5, _1451))) - vec3(1.0);
    float _3809 = dot(_17._m0, _3777);
    vec3 _3819 = mix(_3777, normalize((_17._m0 * 0.999989449977874755859375) + (normalize(_3777 - (_17._m0 * _3809)) * 0.0045900647528469562530517578125)), bvec3(_3809 < 0.999989449977874755859375));
    vec3 _3821 = normalize(_426 + _3819);
    float _3825 = clamp(dot(_1195, _3821), 0.0, 1.0);
    float _3827 = clamp(dot(_1195, _3819), 0.0, 1.0);
    float _3829 = (_1451 + 1.0) * 0.5;
    float _3830 = _1451 * _1451;
    float _3838 = _3829 * _3829;
    float _3850 = _3830 * _3830;
    float _3853 = fma(fma(_3825, _3850, -_3825), _3825, 1.0);
    vec3 _3872 = (((_2830 + ((_3774 * (_1436 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3790 * pow(spvNMax(abs(1.0 - _3783), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3790 * pow(spvNMax(abs(1.0 - _2239), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1451))))) * _3783)) + (_2828 + ((_3774 * ((_1441 + ((vec3(1.0) - _1441) * pow(spvNMax(abs(1.0 - clamp(dot(_3819, _3821), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_3827, sqrt(fma(fma(-_2239, _3838, _2239), _2239, _3838)), _2239 * sqrt(fma(fma(-_3827, _3838, _3827), _3827, _3838)))) * (_3850 * (0.3183098733425140380859375 / (_3853 * _3853)))))) * _3783))) * mix(1.0, 1.0, _37._m1)) + (((_3353 * _3770) + (_3350 * _3770)) * 1.0);
    vec4 _4067;
    do
    {
        if (_37._m19[3].z < 0.0)
        {
            _4067 = vec4(0.0, 0.0, 0.0, 1.0);
            break;
        }
        float _3913;
        do
        {
            if (_13 <= _37._m19[0].x)
            {
                _3913 = fma(_37._m19[2].x, _13, _37._m19[3].x);
                break;
            }
            else
            {
                _3913 = _37._m19[1].y * log2(fma(_37._m19[2].y, _13, _37._m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        vec3 _3923 = (vec3((gl_FragCoord.xy * _418) / vec2(_37._m32, _37._m18), _3913) + vec3(float(_20._m5), 0.0, 0.0)) - vec3(0.5);
        vec3 _3924 = floor(_3923);
        vec3 _3925 = _3923 - _3924;
        vec3 _3926 = vec3(1.0) - _3925;
        vec3 _3933 = fma(-((_3925 * 0.5) * _3925), vec3(2.0) - _3925, vec3(0.666666686534881591796875));
        vec3 _3940 = (_3925 * 0.16666667163372039794921875) * _3925;
        vec3 _3942 = fma((_3926 * 0.16666667163372039794921875) * _3926, _3926, _3933);
        vec3 _3949 = _37._m17 * (((_3933 / _3942) - vec3(0.5)) + _3924);
        vec3 _3953 = _37._m17 * ((((_3940 * _3925) / fma(_3940, _3925, fma(-((_3926 * 0.5) * _3926), _3925 + vec3(1.0), vec3(0.666666686534881591796875)))) + vec3(1.5)) + _3924);
        float _3961 = _3949.z;
        float _3967 = _3953.x;
        vec2 _3971 = spvNMax(_37._m15, spvNMin(_37._m16, vec2(_3967, _3949.y)));
        float _3972 = _3971.x;
        vec4 _3978 = vec4(_3942.x);
        float _3980 = _3949.x;
        vec2 _3984 = spvNMax(_37._m15, spvNMin(_37._m16, vec2(_3980, _3953.y)));
        float _3985 = _3984.x;
        vec4 _4000 = vec4(_3942.y);
        float _4005 = _3953.z;
        vec4 _4031 = mix(mix(mix(textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, _3953.xy)), _4005), 0.0), textureLod(sampler3D(_29, _30), vec3(_3985, _3984.y, _4005), 0.0), _3978), mix(textureLod(sampler3D(_29, _30), vec3(_3972, _3971.y, _4005), 0.0), textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, vec2(_3980, _3949.y))), _4005), 0.0), _3978), _4000), mix(mix(textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, vec2(_3967, _3953.y))), _3961), 0.0), textureLod(sampler3D(_29, _30), vec3(_3985, _3984.y, _3961), 0.0), _3978), mix(textureLod(sampler3D(_29, _30), vec3(_3972, _3971.y, _3961), 0.0), textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, _3949.xy)), _3961), 0.0), _3978), _4000), vec4(_3942.z)) * vec4(0.03125, 0.03125, 0.03125, 3.0517578125e-05);
        vec4 _4039;
        if (isinf(_4031.x) || isnan(_4031.x))
        {
            vec4 _4038 = _4031;
            _4038.x = 0.0;
            _4039 = _4038;
        }
        else
        {
            _4039 = _4031;
        }
        vec4 _4047;
        if (isinf(_4039.y) || isnan(_4039.y))
        {
            vec4 _4046 = _4039;
            _4046.y = 0.0;
            _4047 = _4046;
        }
        else
        {
            _4047 = _4039;
        }
        vec4 _4055;
        if (isinf(_4047.z) || isnan(_4047.z))
        {
            vec4 _4054 = _4047;
            _4054.z = 0.0;
            _4055 = _4054;
        }
        else
        {
            _4055 = _4047;
        }
        vec4 _4063;
        if (isinf(_4055.w) || isnan(_4055.w))
        {
            vec4 _4062 = _4055;
            _4062.w = 0.0;
            _4063 = _4062;
        }
        else
        {
            _4063 = _4055;
        }
        vec4 _4066 = _4063;
        _4066.w = 1.0 - _4063.w;
        _4067 = _4066;
        break;
    } while(false);
    vec3 _4070 = fma(fma(_3872, _2034, _2033 * _23._m0[0u]) + (mix(mix(vec3(0.0), mix(mix(_50._m3, _50._m5, vec3(pow(_962, _50._m31))), _50._m7 * _50._m32, vec3(pow(_962, _50._m33))), vec3(_50._m34)), _50._m9 * mix(_50._m35, _50._m35 * _50._m0.y, _50._m36), vec3(clamp(smoothstep(_50._m20.y, _50._m20.x, _1003) * _1003, 0.0, 1.0))) * float(!(_16._m1 != 0.0))), _4067.www, _4067.xyz);
    _14 = spvNMax(vec4(_4070, (_707 * _753) * _49._m4), vec4(0.0));
}

