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

struct _75
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

struct _78
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

struct _82
{
    vec4 _m0;
    mat4x3 _m1;
    vec4 _m2[4];
    float _m3;
    float _m4;
    uint _m5;
    uint _m6;
};

struct _87
{
    mat4 _m0;
    vec2 _m1;
    float _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    float _m6;
};

float _364;
const vec4 _380[4] = vec4[](vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
float _400;
vec3 _401;
float _408;
vec3 _409;

layout(set = 0, binding = 0, std140) uniform _63_14
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _14;

layout(set = 0, binding = 1, std140) uniform _65_15
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
} _15;

layout(set = 0, binding = 2, std140) uniform _66_16
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

layout(set = 0, binding = 3, std140) uniform _67_17
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _17;

layout(set = 0, binding = 4, std140) uniform _68_18
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
} _18;

layout(set = 2, binding = 0, std430) readonly buffer _70_21
{
    float _m0[];
} _21;

layout(set = 2, binding = 10, std430) readonly buffer _72_25
{
    ivec4 _m0[];
} _25;

layout(set = 2, binding = 11, std430) readonly buffer _74_26
{
    int _m0[];
} _26;

layout(set = 2, binding = 12, std430) readonly buffer _77_27
{
    _75 _m0[];
} _27;

layout(set = 2, binding = 16, std430) readonly buffer _80_28
{
    layout(row_major) _78 _m0[];
} _28;

layout(set = 2, binding = 20, std430) readonly buffer _84_31
{
    layout(row_major) _82 _m0[];
} _31;

layout(set = 2, binding = 26, std140) uniform _86_37
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

layout(set = 2, binding = 27, scalar) readonly buffer _89_38
{
    layout(row_major) _87 _m0[];
} _38;

layout(set = 5, binding = 0, scalar) uniform _90_44
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

layout(set = 1, binding = 0, std140) uniform _91_49
{
    float _m0;
    uint _m1;
    uint _m2;
    uint _m3;
} _49;

layout(set = 1, binding = 1, std140) uniform _92_50
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    vec2 _m6;
    vec2 _m7;
    vec2 _m8;
    vec2 _m9;
    float _m10;
    float _m11;
    float _m12;
    float _m13;
    float _m14;
    float _m15;
    float _m16;
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
    float _m42;
    float _m43;
    float _m44;
    float _m45;
    float _m46;
    float _m47;
    float _m48;
    float _m49;
    float _m50;
    float _m51;
    float _m52;
    float _m53;
    float _m54;
    float _m55;
    float _m56;
    float _m57;
    float _m58;
    float _m59;
    float _m60;
    float _m61;
    float _m62;
    float _m63;
    float _m64;
    float _m65;
} _50;

layout(set = 0, binding = 7) uniform sampler _19;
layout(set = 0, binding = 9) uniform sampler _20;
layout(set = 2, binding = 3) uniform sampler _22;
layout(set = 2, binding = 4) uniform texture2D _23;
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
layout(set = 1, binding = 2) uniform sampler _51;
layout(set = 1, binding = 3) uniform sampler _52;
layout(set = 1, binding = 4) uniform texture2D _53;
layout(set = 1, binding = 5) uniform texture2D _54;
layout(set = 1, binding = 6) uniform texture2D _55;
layout(set = 1, binding = 7) uniform texture2D _56;
layout(set = 1, binding = 8) uniform texture2D _57;
layout(set = 1, binding = 9) uniform texture2D _58;
layout(set = 1, binding = 10) uniform texture2D _59;
layout(set = 1, binding = 11) uniform texture2D _60;
layout(set = 1, binding = 12) uniform texture2D _61;
layout(set = 1, binding = 13) uniform texture2D _62;

layout(location = 0) in float _4;
layout(location = 1) in vec3 _5;
layout(location = 2) in vec3 _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in vec2 _9;
layout(location = 6) in vec2 _10;
layout(location = 7) in float _11;
layout(location = 0) out vec4 _12;

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
    vec2 _429 = vec2(_17._m2, _17._m3);
    vec2 _430 = gl_FragCoord.xy * _429;
    vec3 _433 = _5 + _16._m6;
    mat3 _435 = mat3(_8, _6, _7);
    vec3 _437 = normalize(-_5);
    float _447 = -_4;
    float _453 = clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / spvNMax(_50._m16, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
    float _463 = spvNMax(_50._m17, 9.9999997473787516355514526367188e-05);
    float _465 = clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _463, 0.0, 1.0);
    float _479 = spvNMax(1.0, 9.9999997473787516355514526367188e-05);
    vec3 _481 = _433 - _16._m6;
    vec3 _491 = _481 * mat3(_16._m0[0].xyz, _16._m0[1].xyz, _16._m0[2].xyz);
    float _492 = _491.z;
    vec3 _499 = vec3(_50._m20);
    vec3 _502 = normalize(normalize(_6) * _435);
    vec4 _506 = texture(sampler2D(_53, _19), _9);
    vec2 _515 = ((_506.xy - vec2(0.5)) * 0.5) * (mix(0.5, _506.z, _50._m1) * 2.0);
    vec2 _519 = (_515 * vec2(-1.0, 1.0)) * _50._m22;
    vec2 _524 = _433.xz;
    vec2 _532 = (_524 * _50._m10) + vec2(_14._m0 * _50._m11);
    vec4 _536 = texture(sampler2D(_54, _51), _532);
    float _537 = _536.x;
    float _541 = fma(_14._m0, _50._m23, _537 * _50._m24);
    float _542 = fract(_541);
    vec2 _556 = (vec3(_15._m1, 0.0, _15._m3).xz * _50._m25) * _14._m0;
    vec4 _560 = texture(sampler2D(_55, _19), fma(_9, _50._m6, _519 * _542) + _556);
    vec3 _563 = (_560.wzy * 2.0) - vec3(1.0);
    vec4 _564 = vec4(_563.x, _563.y, _563.z, _560.x);
    _564.z = -_563.z;
    vec4 _577 = texture(sampler2D(_55, _19), fma(_9, _50._m6, _519 * fract(_541 + 0.5)) + _556);
    vec3 _580 = (_577.wzy * 2.0) - vec3(1.0);
    vec4 _581 = vec4(_580.x, _580.y, _580.z, _577.x);
    _581.z = -_580.z;
    float _595 = _14._m0 * _50._m26;
    float _596 = fma(_537, _50._m24, _595);
    float _597 = fract(_596);
    vec4 _605 = texture(sampler2D(_56, _19), fma(_9, _50._m7, _519 * _597) + _556);
    vec3 _608 = (_605.wzy * 2.0) - vec3(1.0);
    vec4 _609 = vec4(_608.x, _608.y, _608.z, _605.x);
    _609.z = -_608.z;
    vec4 _622 = texture(sampler2D(_56, _19), fma(_9, _50._m7, _519 * fract(_596 + 0.5)) + _556);
    vec3 _625 = (_622.wzy * 2.0) - vec3(1.0);
    vec4 _626 = vec4(_625.x, _625.y, _625.z, _622.x);
    _626.z = -_625.z;
    float _641 = _14._m0 * _50._m27;
    float _642 = fma(_537, _50._m24, _641);
    float _643 = fract(_642);
    vec4 _650 = texture(sampler2D(_55, _19), fma(_9, _50._m8, _519 * _643) + _556);
    vec3 _653 = (_650.wzy * 2.0) - vec3(1.0);
    vec4 _654 = vec4(_653.x, _653.y, _653.z, _650.x);
    _654.z = -_653.z;
    vec4 _667 = texture(sampler2D(_55, _19), fma(_9, _50._m8, _519 * fract(_642 + 0.5)) + _556);
    vec3 _670 = (_667.wzy * 2.0) - vec3(1.0);
    vec4 _671 = vec4(_670.x, _670.y, _670.z, _667.x);
    _671.z = -_670.z;
    vec3 _690 = vec3(_50._m29, _400, _50._m29);
    vec2 _696 = ((((_481 * (((fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _479) + _492) / _492)) + _16._m6) / _499) + (mix(_502, normalize((mix(normalize(_564.xyz).xyz, normalize(_581.xyz).xyz, vec3(abs((_542 + (-0.5)) * 2.0))) + mix(normalize(_609.xyz).xyz, normalize(_626.xyz).xyz, vec3(abs((_597 + (-0.5)) * 2.0)))) + (mix(normalize(_654.xyz).xyz, normalize(_671.xyz).xyz, vec3(abs((_643 + (-0.5)) * 2.0))) * _50._m28)), _690) * _50._m21)).xz;
    float _701 = fma(_14._m0 * _50._m30, 16.0, 0.0) + 9.9999997473787516355514526367188e-06;
    vec2 _703 = vec2(_701, _701 * 0.125);
    vec2 _705 = trunc(_703 - vec2(8.0) * trunc(_703 / vec2(8.0)));
    float _716 = fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _479;
    float _726 = _50._m33 * 2.0;
    float _729 = abs(_50._m31 - _50._m32);
    float _738 = 1.0 - pow(spvNMax(abs(1.0 - clamp(normalize(_437 * _435).y, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 3.0);
    float _743 = -_50._m3;
    vec3 _749 = clamp(texture(sampler2D(_57, _19), (fract(_696) + _705) * vec2(0.125)).xyz * ((clamp((spvNMin(fma(_716, -1.0, _50._m31), _716 - _50._m32) * _726) / _729, 0.0, 1.0) * _738) * clamp(-fma(length(_515), 8.0, _743), 0.0, 1.0)), vec3(0.0), vec3(1.0));
    float _760 = _14._m0 * _50._m35;
    float _761 = fma(_537, _50._m24, _760);
    float _764 = (fract(_761) + (-0.5)) * 2.0;
    float _765 = _50._m34 * (-0.017453290522098541259765625);
    float _766 = cos(_765);
    float _767 = sin(_765);
    mat2 _771 = mat2(vec2(_766, _767), vec2(-_767, _766));
    vec2 _772 = _519 * _771;
    vec4 _780 = texture(sampler2D(_58, _19), fma(_524, _50._m9, _772 * _764) + _556);
    vec4 _791 = texture(sampler2D(_58, _19), fma(_524, _50._m9, _772 * ((fract(_761 + 0.5) + (-0.5)) * 2.0)) + _556);
    float _806 = clamp(fma(pow(spvNMax(abs(mix(vec4(_408, _408, _408, _780.x), vec4(_408, _408, _408, _791.x), vec4(abs(_764))).w), 9.9999997473787516355514526367188e-05), _50._m36), _50._m37, fma(spvNMax(fma(_453 - 1.0, 1.0 - _453, 1.0), fma(_465 - 1.0, 1.0 - _465, 1.0) * _50._m18), _50._m19, spvNMax(spvNMax(_749.x, _749.y), _749.z))), 0.0, 1.0);
    float _809 = _806 * _49._m0;
    vec4 _821 = texture(sampler2D(_53, _19), _9);
    vec2 _828 = ((_821.xy - vec2(0.5)) * 0.5) * (mix(0.5, _821.z, _50._m1) * 2.0);
    vec2 _830 = (_828 * vec2(-1.0, 1.0)) * _50._m22;
    vec4 _832 = texture(sampler2D(_54, _51), _532);
    float _833 = _832.x;
    float _835 = fma(_14._m0, _50._m23, _833 * _50._m24);
    float _836 = fract(_835);
    vec4 _841 = texture(sampler2D(_55, _19), fma(_9, _50._m6, _830 * _836) + _556);
    vec3 _844 = (_841.wzy * 2.0) - vec3(1.0);
    vec4 _845 = vec4(_844.x, _844.y, _844.z, _841.x);
    _845.z = -_844.z;
    vec4 _858 = texture(sampler2D(_55, _19), fma(_9, _50._m6, _830 * fract(_835 + 0.5)) + _556);
    vec3 _861 = (_858.wzy * 2.0) - vec3(1.0);
    vec4 _862 = vec4(_861.x, _861.y, _861.z, _858.x);
    _862.z = -_861.z;
    float _874 = fma(_833, _50._m24, _595);
    float _875 = fract(_874);
    vec4 _880 = texture(sampler2D(_56, _19), fma(_9, _50._m7, _830 * _875) + _556);
    vec3 _883 = (_880.wzy * 2.0) - vec3(1.0);
    vec4 _884 = vec4(_883.x, _883.y, _883.z, _880.x);
    _884.z = -_883.z;
    vec4 _897 = texture(sampler2D(_56, _19), fma(_9, _50._m7, _830 * fract(_874 + 0.5)) + _556);
    vec3 _900 = (_897.wzy * 2.0) - vec3(1.0);
    vec4 _901 = vec4(_900.x, _900.y, _900.z, _897.x);
    _901.z = -_900.z;
    float _914 = fma(_833, _50._m24, _641);
    float _915 = fract(_914);
    vec4 _920 = texture(sampler2D(_55, _19), fma(_9, _50._m8, _830 * _915) + _556);
    vec3 _923 = (_920.wzy * 2.0) - vec3(1.0);
    vec4 _924 = vec4(_923.x, _923.y, _923.z, _920.x);
    _924.z = -_923.z;
    vec4 _937 = texture(sampler2D(_55, _19), fma(_9, _50._m8, _830 * fract(_914 + 0.5)) + _556);
    vec3 _940 = (_937.wzy * 2.0) - vec3(1.0);
    vec4 _941 = vec4(_940.x, _940.y, _940.z, _937.x);
    _941.z = -_940.z;
    vec2 _959 = ((((_481 * (((fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _479) + _492) / _492)) + _16._m6) / _499) + (mix(_502, normalize((mix(normalize(_845.xyz).xyz, normalize(_862.xyz).xyz, vec3(abs((_836 + (-0.5)) * 2.0))) + mix(normalize(_884.xyz).xyz, normalize(_901.xyz).xyz, vec3(abs((_875 + (-0.5)) * 2.0)))) + (mix(normalize(_924.xyz).xyz, normalize(_941.xyz).xyz, vec3(abs((_915 + (-0.5)) * 2.0))) * _50._m28)), _690) * _50._m21)).xz;
    vec4 _964 = texture(sampler2D(_57, _19), (fract(_959) + _705) * vec2(0.125));
    float _970 = fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _479;
    vec4 _988 = texture(sampler2D(_53, _19), _9);
    vec2 _996 = ((_988.xy - vec2(0.5)) * 0.5) * (mix(0.5, _988.z, _50._m1) * 2.0);
    vec2 _998 = (_996 * vec2(-1.0, 1.0)) * _50._m22;
    vec4 _1000 = texture(sampler2D(_54, _51), _532);
    float _1001 = _1000.x;
    float _1003 = fma(_14._m0, _50._m23, _1001 * _50._m24);
    float _1004 = fract(_1003);
    vec4 _1009 = texture(sampler2D(_55, _19), fma(_9, _50._m6, _998 * _1004) + _556);
    vec3 _1012 = (_1009.wzy * 2.0) - vec3(1.0);
    vec4 _1013 = vec4(_1012.x, _1012.y, _1012.z, _1009.x);
    _1013.z = -_1012.z;
    vec4 _1026 = texture(sampler2D(_55, _19), fma(_9, _50._m6, _998 * fract(_1003 + 0.5)) + _556);
    vec3 _1029 = (_1026.wzy * 2.0) - vec3(1.0);
    vec4 _1030 = vec4(_1029.x, _1029.y, _1029.z, _1026.x);
    _1030.z = -_1029.z;
    float _1042 = fma(_1001, _50._m24, _595);
    float _1043 = fract(_1042);
    vec4 _1048 = texture(sampler2D(_56, _19), fma(_9, _50._m7, _998 * _1043) + _556);
    vec3 _1051 = (_1048.wzy * 2.0) - vec3(1.0);
    vec4 _1052 = vec4(_1051.x, _1051.y, _1051.z, _1048.x);
    _1052.z = -_1051.z;
    vec4 _1065 = texture(sampler2D(_56, _19), fma(_9, _50._m7, _998 * fract(_1042 + 0.5)) + _556);
    vec3 _1068 = (_1065.wzy * 2.0) - vec3(1.0);
    vec4 _1069 = vec4(_1068.x, _1068.y, _1068.z, _1065.x);
    _1069.z = -_1068.z;
    float _1082 = fma(_1001, _50._m24, _641);
    float _1083 = fract(_1082);
    vec4 _1088 = texture(sampler2D(_55, _19), fma(_9, _50._m8, _998 * _1083) + _556);
    vec3 _1091 = (_1088.wzy * 2.0) - vec3(1.0);
    vec4 _1092 = vec4(_1091.x, _1091.y, _1091.z, _1088.x);
    _1092.z = -_1091.z;
    vec4 _1105 = texture(sampler2D(_55, _19), fma(_9, _50._m8, _998 * fract(_1082 + 0.5)) + _556);
    vec3 _1108 = (_1105.wzy * 2.0) - vec3(1.0);
    vec4 _1109 = vec4(_1108.x, _1108.y, _1108.z, _1105.x);
    _1109.z = -_1108.z;
    float _1132 = spvNMax(_50._m39, 9.9999997473787516355514526367188e-05);
    float _1135 = fma(_1001, _50._m24, _760);
    float _1138 = (fract(_1135) + (-0.5)) * 2.0;
    vec2 _1139 = _998 * _771;
    vec4 _1144 = texture(sampler2D(_58, _19), fma(_524, _50._m9, _1139 * _1138) + _556);
    vec3 _1147 = (_1144.wzy * 2.0) - vec3(1.0);
    vec4 _1148 = vec4(_1147.x, _1147.y, _1147.z, _1144.x);
    _1148.z = -_1147.z;
    vec4 _1167 = texture(sampler2D(_58, _19), fma(_524, _50._m9, _1139 * ((fract(_1135 + 0.5) + (-0.5)) * 2.0)) + _556);
    vec3 _1170 = (_1167.wzy * 2.0) - vec3(1.0);
    vec4 _1171 = vec4(_1170.x, _1170.y, _1170.z, _1167.x);
    _1171.z = -_1170.z;
    vec4 _1184 = mix(vec4(normalize(_1148.xyz), _1144.x), vec4(normalize(_1171.xyz), _1167.x), vec4(abs(_1138)));
    float _1204 = -fma(length(_996), 8.0, _743);
    vec3 _1230 = normalize(mix(_502, normalize((mix(normalize(_1013.xyz).xyz, normalize(_1030.xyz).xyz, vec3(abs((_1004 + (-0.5)) * 2.0))) + mix(normalize(_1052.xyz).xyz, normalize(_1069.xyz).xyz, vec3(abs((_1043 + (-0.5)) * 2.0)))) + (mix(normalize(_1092.xyz).xyz, normalize(_1109.xyz).xyz, vec3(abs((_1083 + (-0.5)) * 2.0))) * _50._m28)), vec3(_50._m29)) + (((vec3(1.0, 0.0, 1.0) * ((clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _1132, 0.0, 1.0) * _1184.w) * fma(1.0 - clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / spvNMax(mix(_50._m40, _50._m41, _988.w), 9.9999997473787516355514526367188e-05), 0.0, 1.0), _50._m42, fma(smoothstep(_50._m43, _50._m44, _1204), _50._m45, smoothstep(_50._m46, _50._m47, _1204) * _50._m48)))) * _1184.xyz) * _50._m49));
    vec2 _1231 = _9 * 10.0;
    vec4 _1234 = texture(sampler2D(_59, _19), _1231);
    vec4 _1239 = texture(sampler2D(_60, _19), _9);
    vec2 _1243 = ((_1239.xy * 2.0) + vec2(-1.0)) * 0.5;
    float _1245 = fract(_14._m0 * 0.20000000298023223876953125);
    vec2 _1248 = fma(vec2(-20.0, 5.0), _10, vec2(0.20000000298023223876953125, 0.0500000007450580596923828125) * _14._m0);
    vec2 _1250 = vec2(_1234.x * 0.02500000037252902984619140625);
    vec4 _1253 = texture(sampler2D(_60, _19), _1250 + ((_1243 * _1245) + _1248));
    float _1255 = fma(_14._m0, 0.20000000298023223876953125, 0.5);
    float _1256 = fract(_1255);
    vec4 _1261 = texture(sampler2D(_60, _19), _1250 + ((_1243 * _1256) + _1248));
    float _1266 = abs(fma(fract(_1255 + 0.5), 2.0, -1.0));
    vec2 _1281 = fma(_10, vec2(1.0, 0.699999988079071044921875), (vec2(-0.0500000007450580596923828125, 0.00999999977648258209228515625) * _50._m51) * _14._m0);
    vec4 _1284 = texture(sampler2D(_61, _19), _1281);
    vec3 _1294 = normalize(_435 * mix(_1230, _1230 + (((fma(mix(_1253.xyz, _1261.xyz, vec3(_1266)).xzy, vec3(2.0, 0.0, 2.0), vec3(-1.0, 0.0, -1.0)) * 3.0) + vec3(0.0, 1.0, 0.0)) * _50._m50), vec3(smoothstep(_50._m52, _50._m53, _1284.x))));
    vec4 _1296 = texture(sampler2D(_24, _20), _430);
    vec4 _1325 = texture(sampler2D(_53, _19), _9);
    vec2 _1333 = ((_1325.xy - vec2(0.5)) * 0.5) * (mix(0.5, _1325.z, _50._m1) * 2.0);
    float _1339 = fma(texture(sampler2D(_54, _51), _532).x, _50._m24, _760);
    float _1342 = (fract(_1339) + (-0.5)) * 2.0;
    vec2 _1343 = ((_1333 * vec2(-1.0, 1.0)) * _50._m22) * _771;
    vec4 _1364 = mix(vec4(_408, _408, _408, texture(sampler2D(_58, _19), fma(_524, _50._m9, _1343 * _1342) + _556).x), vec4(_408, _408, _408, texture(sampler2D(_58, _19), fma(_524, _50._m9, _1343 * ((fract(_1339 + 0.5) + (-0.5)) * 2.0)) + _556).x), vec4(abs(_1342)));
    float _1365 = _1364.w;
    float _1378 = -fma(length(_1333), 8.0, _743);
    float _1395 = smoothstep(_50._m52, _50._m53, texture(sampler2D(_61, _19), _1281).x);
    vec2 _1405 = ((texture(sampler2D(_60, _19), _9).xy * 2.0) + vec2(-1.0)) * 0.5;
    vec2 _1408 = vec2(texture(sampler2D(_59, _19), _1231).x * 0.02500000037252902984619140625);
    float _1420 = mix(texture(sampler2D(_62, _19), _1408 + ((_1405 * _1245) + _1248)).x, texture(sampler2D(_62, _19), _1408 + ((_1405 * _1256) + _1248)).x, _1266);
    float _1432 = clamp(fma(pow(spvNMax(abs((clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _1132, 0.0, 1.0) * _1365) * fma(1.0 - clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / spvNMax(mix(_50._m40, _50._m41, _1325.w), 9.9999997473787516355514526367188e-05), 0.0, 1.0), _50._m42, fma(smoothstep(_50._m43, _50._m44, _1378), _50._m45, smoothstep(_50._m46, _50._m47, _1378) * _50._m48))), 9.9999997473787516355514526367188e-05), _50._m56), _50._m57, clamp(pow(spvNMax(abs(fma(_1395, _1420, (_1395 * _1420) * (_50._m58 * _1365))), 9.9999997473787516355514526367188e-05), 2.5), 0.0, 1.0)), 0.0, 1.0);
    vec4 _1444 = texture(sampler2D(_53, _19), _9);
    vec2 _1452 = ((_1444.xy - vec2(0.5)) * 0.5) * (mix(0.5, _1444.z, _50._m1) * 2.0);
    float _1458 = fma(texture(sampler2D(_54, _51), _532).x, _50._m24, _760);
    float _1461 = (fract(_1458) + (-0.5)) * 2.0;
    vec2 _1462 = ((_1452 * vec2(-1.0, 1.0)) * _50._m22) * _771;
    vec4 _1483 = mix(vec4(_408, _408, _408, texture(sampler2D(_58, _19), fma(_524, _50._m9, _1462 * _1461) + _556).x), vec4(_408, _408, _408, texture(sampler2D(_58, _19), fma(_524, _50._m9, _1462 * ((fract(_1458 + 0.5) + (-0.5)) * 2.0)) + _556).x), vec4(abs(_1461)));
    float _1484 = _1483.w;
    float _1497 = -fma(length(_1452), 8.0, _743);
    float _1510 = smoothstep(_50._m52, _50._m53, texture(sampler2D(_61, _19), _1281).x);
    vec2 _1520 = ((texture(sampler2D(_60, _19), _9).xy * 2.0) + vec2(-1.0)) * 0.5;
    vec2 _1523 = vec2(texture(sampler2D(_59, _19), _1231).x * 0.02500000037252902984619140625);
    float _1534 = mix(texture(sampler2D(_62, _19), _1523 + ((_1520 * _1245) + _1248)).x, texture(sampler2D(_62, _19), _1523 + ((_1520 * _1256) + _1248)).x, _1266);
    float _1544 = clamp(fma(pow(spvNMax(abs((clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _1132, 0.0, 1.0) * _1484) * fma(1.0 - clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / spvNMax(mix(_50._m40, _50._m41, _1444.w), 9.9999997473787516355514526367188e-05), 0.0, 1.0), _50._m42, fma(smoothstep(_50._m43, _50._m44, _1497), _50._m45, smoothstep(_50._m46, _50._m47, _1497) * _50._m48))), 9.9999997473787516355514526367188e-05), _50._m56), _50._m57, clamp(pow(spvNMax(abs(fma(_1510, _1534, (_1510 * _1534) * (_50._m58 * _1484))), 9.9999997473787516355514526367188e-05), 2.5), 0.0, 1.0)), 0.0, 1.0);
    float _1549 = mix(_50._m59, _50._m60, _1544);
    vec4 _1557 = texture(sampler2D(_53, _19), _9);
    vec2 _1565 = ((_1557.xy - vec2(0.5)) * 0.5) * (mix(0.5, _1557.z, _50._m1) * 2.0);
    float _1571 = fma(texture(sampler2D(_54, _51), _532).x, _50._m24, _760);
    float _1574 = (fract(_1571) + (-0.5)) * 2.0;
    vec2 _1575 = ((_1565 * vec2(-1.0, 1.0)) * _50._m22) * _771;
    vec4 _1596 = mix(vec4(_408, _408, _408, texture(sampler2D(_58, _19), fma(_524, _50._m9, _1575 * _1574) + _556).x), vec4(_408, _408, _408, texture(sampler2D(_58, _19), fma(_524, _50._m9, _1575 * ((fract(_1571 + 0.5) + (-0.5)) * 2.0)) + _556).x), vec4(abs(_1574)));
    float _1597 = _1596.w;
    float _1610 = -fma(length(_1565), 8.0, _743);
    float _1623 = smoothstep(_50._m52, _50._m53, texture(sampler2D(_61, _19), _1281).x);
    vec2 _1633 = ((texture(sampler2D(_60, _19), _9).xy * 2.0) + vec2(-1.0)) * 0.5;
    vec2 _1636 = vec2(texture(sampler2D(_59, _19), _1231).x * 0.02500000037252902984619140625);
    float _1647 = mix(texture(sampler2D(_62, _19), _1636 + ((_1633 * _1245) + _1248)).x, texture(sampler2D(_62, _19), _1636 + ((_1633 * _1256) + _1248)).x, _1266);
    float _1657 = clamp(fma(pow(spvNMax(abs((clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _1132, 0.0, 1.0) * _1597) * fma(1.0 - clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / spvNMax(mix(_50._m40, _50._m41, _1557.w), 9.9999997473787516355514526367188e-05), 0.0, 1.0), _50._m42, fma(smoothstep(_50._m43, _50._m44, _1610), _50._m45, smoothstep(_50._m46, _50._m47, _1610) * _50._m48))), 9.9999997473787516355514526367188e-05), _50._m56), _50._m57, clamp(pow(spvNMax(abs(fma(_1623, _1647, (_1623 * _1647) * (_50._m58 * _1597))), 9.9999997473787516355514526367188e-05), 2.5), 0.0, 1.0)), 0.0, 1.0);
    float _1662 = mix(_50._m61, _50._m62, _1657);
    vec3 _1665 = mix(mix(_50._m0, _50._m2, vec3(clamp(1.0 - pow(spvNMax(abs(1.0 - clamp(fma(_1296.x, _16._m4, _447) / spvNMax(_50._m54, 9.9999997473787516355514526367188e-05), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _50._m55), 0.0, 1.0))), _50._m4, vec3(_1432)) * 1.0;
    vec3 _1668 = vec3(0.1599999964237213134765625 * (_1549 * _1549));
    vec3 _1669 = dFdx(_1294);
    vec3 _1670 = dFdy(_1294);
    float _1678 = spvNMax(0.0900000035762786865234375, sqrt(clamp(fma(_1662, _1662, spvNMin(dot(_1669, _1669) + dot(_1670, _1670), 0.180000007152557373046875)), 0.0, 1.0)));
    ivec2 _1686 = ivec2(uvec2(gl_FragCoord.xy) / uvec2(_37._m25));
    vec3 _2260;
    vec3 _2261;
    vec3 _2262;
    SPIRV_CROSS_BRANCH
    if (_15._m19 > 0.0)
    {
        vec3 _1720 = vec3(0.0, 636100.0, 0.0) + _16._m6;
        float _1721 = length(_1720);
        bool _1725 = _1721 < (0.89999997615814208984375 * _44._m0);
        vec3 _1732;
        float _1733;
        if (_1725)
        {
            vec3 _1730 = _1720;
            _1730.z = _1720.z + _44._m0;
            _1732 = _1730;
            _1733 = length(_1730);
        }
        else
        {
            _1732 = _1720;
            _1733 = _1721;
        }
        float _1736 = dot(_1732 / vec3(_1733), _15._m36);
        float _1737 = _44._m0 / _1733;
        vec3 _1761 = vec3(0.0, 636100.0, 0.0) + _433;
        float _1762 = length(_1761);
        vec3 _1766 = (_1761 / vec3(_1762)) * spvNMax(_1762, 636100.0);
        vec3 _1767 = _1766 - _1720;
        float _1768 = length(_1767);
        vec3 _1770 = _1767 / vec3(_1768);
        vec3 _1780;
        vec3 _1781;
        float _1782;
        if (_1725)
        {
            vec3 _1775 = _1720;
            _1775.z = _1720.z + _44._m0;
            vec3 _1778 = _1766;
            _1778.z = _1766.z + _44._m0;
            _1780 = _1778;
            _1781 = _1775;
            _1782 = length(_1775);
        }
        else
        {
            _1780 = _1766;
            _1781 = _1720;
            _1782 = _1721;
        }
        float _1783 = dot(_1781, _1770);
        float _1792 = spvNMax((-_1783) - sqrt(fma(_44._m1, _44._m1, fma(_1783, _1783, -(_1782 * _1782)))), 0.0);
        bool _1795 = (_1792 > 0.0) && (_1792 < _1768);
        vec3 _1803;
        float _1804;
        float _1805;
        if (_1795)
        {
            _1803 = _1781 + (_1770 * _1792);
            _1804 = _1768 - _1792;
            _1805 = (_1783 + _1792) / _44._m1;
        }
        else
        {
            _1803 = _1781;
            _1804 = _1768;
            _1805 = _1783 / _1782;
        }
        float _1806 = _1795 ? _44._m1 : _1782;
        vec3 _2243;
        vec3 _2244;
        if (_1806 <= _44._m1)
        {
            float _1811 = dot(_1770, _15._m36);
            float _1813 = dot(_1803, _15._m36) / _1806;
            float _1814 = _44._m0 + 600.0;
            bool _1815 = _1806 < _1814;
            vec3 _1820;
            if (_1815)
            {
                _1820 = _1780 * (_1814 / _1806);
            }
            else
            {
                _1820 = _1780;
            }
            float _1821 = _1815 ? _1814 : _1806;
            float _1822 = length(_1820);
            float _1823 = dot(_1820, _1770);
            float _1825 = dot(_1820, _15._m36) / _1822;
            vec2 _1836 = vec2(_1805, _1805 + (_1804 / _1821));
            vec2 _1837 = _1836 * sqrt((0.5 / _44._m4) * _1821);
            vec2 _1840 = vec2(ivec2(sign(_1837)));
            vec2 _1841 = _1837 * _1837;
            float _1855 = -_1804;
            float _1857 = 2.0 * _1821;
            float _1859 = (_1804 / _1857) + _1805;
            float _1867 = _44._m0 - _1821;
            vec2 _1882 = _1836 * sqrt((0.5 / _44._m6) * _1821);
            vec2 _1885 = vec2(ivec2(sign(_1882)));
            vec2 _1886 = _1882 * _1882;
            vec3 _1916 = exp(((-_44._m5) * ((sqrt((6.283100128173828125 * _44._m4) * _1821) * exp(_1867 / _44._m4)) * (((_1840.y > _1840.x) ? exp(_1841.x) : 0.0) + dot((_1840 / ((abs(_1837) * 2.3192999362945556640625) + sqrt((_1841 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1855 / _44._m4) * _1859)), vec2(1.0, -1.0))))) - (_44._m8 * ((sqrt((6.283100128173828125 * _44._m6) * _1821) * exp(_1867 / _44._m6)) * (((_1885.y > _1885.x) ? exp(_1886.x) : 0.0) + dot((_1885 / ((abs(_1882) * 2.3192999362945556640625) + sqrt((_1886 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1855 / _44._m6) * _1859)), vec2(1.0, -1.0))))));
            vec3 _1917 = spvNMin(_1916, vec3(1.0));
            float _1918 = _44._m0 / _1821;
            float _1921 = sqrt(fma(-_1918, _1918, 1.0));
            float _1923 = _1805 - (-_1921);
            vec4 _2206;
            if (abs(_1923) < 0.0040000001899898052215576171875)
            {
                float _2031 = (-0.0040000001899898052215576171875) - _1921;
                float _2033 = fma(_1821, _1821, _1804 * _1804);
                float _2034 = _1857 * _1804;
                float _2036 = sqrt(fma(_2034, _2031, _2033));
                float _2037 = fma(_1821, _2031, _1804);
                float _2040 = -(_44._m0 * _44._m0);
                float _2042 = sqrt(fma(_44._m1, _44._m1, _2040));
                float _2044 = sqrt(fma(_1821, _1821, _2040));
                float _2045 = _1821 * _2031;
                float _2047 = -(_1821 * _1821);
                float _2049 = fma(_44._m0, _44._m0, fma(_2045, _2045, _2047));
                vec4 _2055 = vec4(-1.0, _2042 * _2042, _2042, 0.50390625);
                vec4 _2056 = mix(_2055, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_2045 < 0.0) && (_2049 > 0.0)));
                float _2058 = fma(_2044 / _2042, 0.96875, 0.015625);
                float _2068 = fma(fma(_2045, _2056.x, sqrt(_2049 + _2056.y)) / (_2044 + _2056.z), 0.4921875, _2056.w);
                float _2074 = _1811 + 1.0;
                float _2076 = floor(_2074 * 3.5);
                float _2078 = fma(_2074, 3.5, -_2076);
                float _2079 = _2076 + fma(fma(atan(spvNMax(_1813, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _2080 = _2079 * 0.125;
                float _2084 = 1.0 - _2078;
                float _2087 = (_2079 + 1.0) * 0.125;
                float _2094 = sqrt(fma(_2036, _2036, _2040));
                float _2098 = fma(_44._m0, _44._m0, fma(_2037, _2037, -(_2036 * _2036)));
                vec4 _2103 = mix(_2055, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_2037 < 0.0) && (_2098 > 0.0)));
                float _2105 = fma(_2094 / _2042, 0.96875, 0.015625);
                float _2115 = fma(fma(_2037, _2103.x, sqrt(_2098 + _2103.y)) / (_2094 + _2103.z), 0.4921875, _2103.w);
                float _2121 = _2076 + fma(fma(atan(spvNMax(_1825, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _2122 = _2121 * 0.125;
                float _2128 = (_2121 + 1.0) * 0.125;
                vec4 _2134 = _1917.xyzx;
                float _2138 = 0.0040000001899898052215576171875 - _1921;
                float _2140 = sqrt(fma(_2034, _2138, _2033));
                float _2141 = fma(_1821, _2138, _1804);
                float _2142 = _1821 * _2138;
                float _2144 = fma(_44._m0, _44._m0, fma(_2142, _2142, _2047));
                vec4 _2149 = mix(_2055, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_2142 < 0.0) && (_2144 > 0.0)));
                float _2159 = fma(fma(_2142, _2149.x, sqrt(_2144 + _2149.y)) / (_2044 + _2149.z), 0.4921875, _2149.w);
                float _2170 = sqrt(fma(_2140, _2140, _2040));
                float _2174 = fma(_44._m0, _44._m0, fma(_2141, _2141, -(_2140 * _2140)));
                vec4 _2179 = mix(_2055, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_2141 < 0.0) && (_2174 > 0.0)));
                float _2181 = fma(_2170 / _2042, 0.96875, 0.015625);
                float _2191 = fma(fma(_2141, _2179.x, sqrt(_2174 + _2179.y)) / (_2170 + _2179.z), 0.4921875, _2179.w);
                _2206 = mix(spvNMax(fma(-((textureLod(sampler3D(_46, _22), vec3(_2122, _2115, _2105), 0.0) * _2084) + (textureLod(sampler3D(_46, _22), vec3(_2128, _2115, _2105), 0.0) * _2078)), _2134, (textureLod(sampler3D(_46, _22), vec3(_2080, _2068, _2058), 0.0) * _2084) + (textureLod(sampler3D(_46, _22), vec3(_2087, _2068, _2058), 0.0) * _2078)), vec4(0.0)), spvNMax(fma(-((textureLod(sampler3D(_46, _22), vec3(_2122, _2191, _2181), 0.0) * _2084) + (textureLod(sampler3D(_46, _22), vec3(_2128, _2191, _2181), 0.0) * _2078)), _2134, (textureLod(sampler3D(_46, _22), vec3(_2080, _2159, _2058), 0.0) * _2084) + (textureLod(sampler3D(_46, _22), vec3(_2087, _2159, _2058), 0.0) * _2078)), vec4(0.0)), vec4((_1923 + 0.0040000001899898052215576171875) * 124.99999237060546875));
            }
            else
            {
                float _1931 = -(_44._m0 * _44._m0);
                float _1933 = sqrt(fma(_44._m1, _44._m1, _1931));
                float _1935 = sqrt(fma(_1821, _1821, _1931));
                float _1936 = _1821 * _1805;
                float _1940 = fma(_44._m0, _44._m0, fma(_1936, _1936, -(_1821 * _1821)));
                vec4 _1946 = vec4(-1.0, _1933 * _1933, _1933, 0.50390625);
                vec4 _1947 = mix(_1946, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1936 < 0.0) && (_1940 > 0.0)));
                float _1949 = fma(_1935 / _1933, 0.96875, 0.015625);
                float _1959 = fma(fma(_1936, _1947.x, sqrt(_1940 + _1947.y)) / (_1935 + _1947.z), 0.4921875, _1947.w);
                float _1965 = _1811 + 1.0;
                float _1967 = floor(_1965 * 3.5);
                float _1969 = fma(_1965, 3.5, -_1967);
                float _1970 = _1967 + fma(fma(atan(spvNMax(_1813, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1975 = 1.0 - _1969;
                float _1985 = sqrt(fma(_1822, _1822, _1931));
                float _1989 = fma(_44._m0, _44._m0, fma(_1823, _1823, -(_1822 * _1822)));
                vec4 _1994 = mix(_1946, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1823 < 0.0) && (_1989 > 0.0)));
                float _1996 = fma(_1985 / _1933, 0.96875, 0.015625);
                float _2006 = fma(fma(_1823, _1994.x, sqrt(_1989 + _1994.y)) / (_1985 + _1994.z), 0.4921875, _1994.w);
                float _2012 = _1967 + fma(fma(atan(spvNMax(_1825, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                _2206 = spvNMax(fma(-((textureLod(sampler3D(_46, _22), vec3(_2012 * 0.125, _2006, _1996), 0.0) * _1975) + (textureLod(sampler3D(_46, _22), vec3((_2012 + 1.0) * 0.125, _2006, _1996), 0.0) * _1969)), _1917.xyzx, (textureLod(sampler3D(_46, _22), vec3(_1970 * 0.125, _1959, _1949), 0.0) * _1975) + (textureLod(sampler3D(_46, _22), vec3((_1970 + 1.0) * 0.125, _1959, _1949), 0.0) * _1969)), vec4(0.0));
            }
            float _2221 = fma(_1811, _1811, 1.0);
            _2243 = _1917;
            _2244 = (_2206.xyz * (0.0596831031143665313720703125 * _2221)) + ((((_2206.xyz * (_2206.w * smoothstep(0.0, 0.0199999995529651641845703125, _1813))) / vec3(spvNMax(_2206.x, 9.9999997473787516355514526367188e-05))) * (vec3(_44._m5.x) / _44._m5)) * ((((0.119366206228733062744140625 * fma(-_44._m9, _44._m9, 1.0)) * (-pow(spvNMax(abs(abs(fma(_44._m9 * (-2.0), _1811, fma(_44._m9, _44._m9, 1.0)))), 9.9999997473787516355514526367188e-05), 1.5))) * _2221) / fma(_44._m9, _44._m9, 2.0)));
        }
        else
        {
            _2243 = vec3(1.0);
            _2244 = vec3(0.0);
        }
        vec3 _2259;
        if (_15._m35 == 0.0)
        {
            _2259 = ((mix(textureLod(sampler2D(_45, _22), vec2(atan((_1736 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_1733 - _44._m0) / (_44._m1 - _44._m0))), 0.0).xyz, vec3(0.0), bvec3(_1736 < (-sqrt(fma(-_1737, _1737, 1.0))))) * 1.0) * _15._m34) * _15._m20;
        }
        else
        {
            _2259 = _15._m2;
        }
        _2260 = _2244 * (_15._m19 * 10.0);
        _2261 = _2243;
        _2262 = _2259;
    }
    else
    {
        _2260 = vec3(0.0);
        _2261 = vec3(1.0);
        _2262 = _15._m2;
    }
    float _2345;
    SPIRV_CROSS_BRANCH
    if (_15._m21 > 0.0)
    {
        vec3 _2285 = _16._m6 + _5;
        vec3 _2292 = vec3(0.0, _15._m18.z, 0.0) + (_2285 - vec3(0.0, _15._m25, 0.0));
        float _2296 = dot(_2292, _15._m24);
        vec2 _2306 = ((((_2292 + (_15._m24 * (sqrt(fma(_2296, _2296, fma(_15._m18.z, _15._m18.z, -dot(_2292, _2292)))) - _2296))).xz * _15._m18.w) * 0.5) + vec2(0.5)) + _15._m18.xy;
        _2306.x = 1.0 - _2306.x;
        vec3 _2319 = vec3(0.0, _15._m23.z, 0.0) + (_2285 - vec3(0.0, _15._m27, 0.0));
        float _2323 = dot(_2319, _15._m26);
        vec2 _2333 = ((((_2319 + (_15._m26 * (sqrt(fma(_2323, _2323, fma(_15._m23.z, _15._m23.z, -dot(_2319, _2319)))) - _2323))).xz * _15._m23.w) * 0.5) + vec2(0.5)) + _15._m23.xy;
        _2333.x = 1.0 - _2333.x;
        _2345 = 1.0 - clamp(smoothstep(0.0500000007450580596923828125, 0.550000011920928955078125, mix(textureLod(sampler2D(_47, _22), _2306, 0.0).x, textureLod(sampler2D(_48, _22), _2333, 0.0).x, _15._m16)) * _15._m21, 0.0, 1.0);
    }
    else
    {
        _2345 = 1.0;
    }
    float _2434;
    SPIRV_CROSS_BRANCH
    if (_15._m17 > 0.0)
    {
        vec3 _2372 = _16._m6 + _5;
        vec3 _2380 = vec3(0.0, _15._m28.z, 0.0) + ((_15._m29 + _2372) - vec3(0.0, _15._m30, 0.0));
        float _2384 = dot(_2380, _15._m24);
        vec2 _2394 = ((((_2380 + (_15._m24 * (sqrt(fma(_2384, _2384, fma(_15._m28.z, _15._m28.z, -dot(_2380, _2380)))) - _2384))).xz * _15._m28.w) * 0.5) + vec2(0.5)) + _15._m28.xy;
        _2394.x = 1.0 - _2394.x;
        vec3 _2408 = vec3(0.0, _15._m31.z, 0.0) + ((_15._m32 + _2372) - vec3(0.0, _15._m33, 0.0));
        float _2412 = dot(_2408, _15._m26);
        vec2 _2422 = ((((_2408 + (_15._m26 * (sqrt(fma(_2412, _2412, fma(_15._m31.z, _15._m31.z, -dot(_2408, _2408)))) - _2412))).xz * _15._m31.w) * 0.5) + vec2(0.5)) + _15._m31.xy;
        _2422.x = 1.0 - _2422.x;
        _2434 = _2345 * (1.0 - clamp(mix(textureLod(sampler2D(_40, _22), _2394, 0.0).x, textureLod(sampler2D(_41, _22), _2422, 0.0).x, _15._m16) * _15._m17, 0.0, 1.0));
    }
    else
    {
        _2434 = _2345;
    }
    float _2441 = fract(52.98291778564453125 * fract(fma(0.067110560834407806396484375, gl_FragCoord.x, 0.005837149918079376220703125 * gl_FragCoord.y)));
    float _2448 = clamp(fma(_37._m34.y, length(_5), _37._m34.x), 0.0, 1.0);
    uint _2449 = uint(int(fma(fma(float(int(clamp(fma(log2(_4), _37._m21, _37._m22), 0.0, float(_37._m26)))), _37._m24, float(_1686.y)), _37._m23, float(_1686.x))));
    uvec4 _2452 = uvec4(_25._m0[_2449]);
    uint _2453 = _2452.x;
    uint _2454 = _2452.y;
    uint _2457 = ((_2454 >> 0u) & 4095u) + _2453;
    uint _2460 = ((_2454 >> 12u) & 4095u) + _2457;
    uint _2464 = ((_2452.z >> 0u) & 1023u) + _2460;
    float _2466 = spvNMax(dot(_1294, _437), 9.9999997473787516355514526367188e-06);
    float _2468;
    bool _2471;
    vec3 _2473;
    vec3 _2475;
    uint _2477;
    _2468 = _364;
    _2471 = false;
    _2473 = vec3(0.0);
    _2475 = vec3(0.0);
    _2477 = _2453;
    float _2469;
    bool _2472;
    vec3 _2474;
    vec3 _2476;
    for (; _2477 < _2457; _2468 = _2469, _2471 = _2472, _2473 = _2474, _2475 = _2476, _2477++)
    {
        uint _2484 = uint(_26._m0[_2477]);
        float _2502 = abs(_27._m0[_2484]._m5);
        if ((_27._m0[_2484]._m6 & (1u << (_49._m1 & 31u))) != 0u)
        {
            vec3 _2517 = _27._m0[_2484]._m0.xyz - _5;
            float _2518 = dot(_2517, _2517);
            vec3 _2521 = _2517 * inversesqrt(spvNMax(_2518, 1.0000000133514319600180897396058e-10));
            float _2522 = _27._m0[_2484]._m0.w * _27._m0[_2484]._m0.w;
            float _2760;
            bool _2761;
            vec3 _2762;
            vec3 _2763;
            if (_2518 < (1.0 / _2522))
            {
                vec3 _2527 = _437 + _2521;
                vec3 _2531 = _2527 * inversesqrt(spvNMax(dot(_2527, _2527), 1.0000000133514319600180897396058e-10));
                float _2533 = clamp(dot(_2521, _2531), 0.0, 1.0);
                float _2535 = clamp(dot(_1294, _2531), 0.0, 1.0);
                float _2537 = clamp(dot(_1294, _2521), 0.0, 1.0);
                float _2538 = _2518 * _2522;
                float _2544 = pow(spvNMax(abs(clamp(fma(-_2538, _2538, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _27._m0[_2484]._m4);
                float _2554;
                if (_27._m0[_2484]._m5 < 0.0)
                {
                    _2554 = _2544 * fma(4.0, _2522, _2502);
                }
                else
                {
                    _2554 = _2544 * ((1.0 / spvNMax(_2518, 9.9999997473787516355514526367188e-05)) + _2502);
                }
                float _2556 = 0.079577468335628509521484375 * (_2537 * _2554);
                float _2691;
                bool _2692;
                float _2693;
                if ((_27._m0[_2484]._m7 & 1u) != 0u)
                {
                    uint _2581;
                    do
                    {
                        vec3 _2561 = -_2521;
                        float _2562 = dot(_2561, vec3(0.0, -0.57735025882720947265625, 0.8164966106414794921875));
                        float _2563 = dot(_2561, vec3(0.0, -0.57735025882720947265625, -0.8164966106414794921875));
                        float _2564 = dot(_2561, vec3(-0.8164966106414794921875, 0.57735025882720947265625, 0.0));
                        float _2568 = spvNMax(spvNMax(_2562, _2563), spvNMax(_2564, dot(_2561, vec3(0.8164966106414794921875, 0.57735025882720947265625, 0.0))));
                        if (_2568 == _2562)
                        {
                            _2581 = 0u;
                            break;
                        }
                        else
                        {
                            if (_2568 == _2563)
                            {
                                _2581 = 1u;
                                break;
                            }
                            else
                            {
                                if (_2568 == _2564)
                                {
                                    _2581 = 2u;
                                    break;
                                }
                                else
                                {
                                    _2581 = 3u;
                                    break;
                                }
                                break; // unreachable workaround
                            }
                            break; // unreachable workaround
                        }
                        break; // unreachable workaround
                    } while(false);
                    uint _2583 = uint(int(_27._m0[_2484]._m7 >> 2u)) + _2581;
                    float _2685;
                    bool _2686;
                    float _2687;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2537 <= 0.0) && true)
                        {
                            _2685 = _2468;
                            _2686 = _2471;
                            _2687 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2616 = _38._m0[_2583]._m0 * vec4(_5 + (_1294 * ((3.5 * float(int(sign(_2537)))) * (_38._m0[_2583]._m4 * sqrt(_2518)))), 1.0);
                            vec3 _2620 = _2616.xyz / vec3(_2616.w);
                            vec2 _2623 = (_2620.xy * 0.5) + vec2(0.5);
                            _2623.y = 1.0 - _2623.y;
                            float _2632 = (_38._m0[_2583]._m5.y / _38._m0[_2583]._m6) / (_2620.z - _38._m0[_2583]._m5.x);
                            float _2637 = _2471 ? _2468 : 6.283185482025146484375;
                            float _2638 = _2441 * _2637;
                            vec2 _2639 = _38._m0[_2583]._m1 + _37._m33;
                            vec2 _2642 = (_38._m0[_2583]._m1 + vec2(_38._m0[_2583]._m2)) - _37._m33;
                            float _2644;
                            _2644 = 0.0;
                            for (int _2647 = 0; _2647 < 12; )
                            {
                                float _2652 = float(uint(_2647));
                                float _2655 = sqrt(_2652 + 0.5) * 0.288675129413604736328125;
                                float _2656 = fma(_2652, 2.3999631404876708984375, _2638);
                                vec2 _2664 = clamp(fma((vec3(cos(_2656), sin(_2656), _2655).xy * _2655) * 2.5, _37._m33, _2623), _2639, _2642);
                                vec2 _2667 = fract(fma(vec2(1.0) / _37._m33, _2664, vec2(0.5)));
                                vec4 _2673 = vec4(lessThan(vec4(_2632), textureGather(sampler2D(_39, _30), _2664)));
                                float _2676 = _2667.x;
                                _2644 += clamp(mix(mix(_2673.w, _2673.z, _2676), mix(_2673.x, _2673.y, _2676), _2667.y), 0.0, 1.0);
                                _2647++;
                                continue;
                            }
                            _2685 = _2637;
                            _2686 = _2471 ? _2471 : true;
                            _2687 = _2644 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2691 = _2685;
                    _2692 = _2686;
                    _2693 = _2556 * mix(1.0, _2687, spvNMin(_2448, _27._m0[_2484]._m8));
                }
                else
                {
                    _2691 = _2468;
                    _2692 = _2471;
                    _2693 = _2556;
                }
                vec3 _2758;
                vec3 _2759;
                if (_2537 > 0.0)
                {
                    vec3 _2699 = _27._m0[_2484]._m1.xyz * (_2693 * ((_27._m0[_2484]._m3 < 0.0) ? _21._m0[0u] : 1.0));
                    vec3 _2706 = vec3(fma((2.0 * _2533) * _2533, _1678, mix(0.0, 0.5, _1678))) - vec3(1.0);
                    float _2727 = (_1678 + 1.0) * 0.5;
                    float _2728 = _1678 * _1678;
                    float _2736 = _2727 * _2727;
                    float _2748 = _2728 * _2728;
                    float _2751 = fma(fma(_2535, _2748, -_2535), _2535, 1.0);
                    _2758 = fma(_2699, (_1668 + ((vec3(1.0) - _1668) * pow(spvNMax(abs(1.0 - _2533), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2537, sqrt(fma(fma(-_2466, _2736, _2466), _2466, _2736)), _2466 * sqrt(fma(fma(-_2537, _2736, _2537), _2537, _2736)))) * (_2748 * (0.3183098733425140380859375 / (_2751 * _2751)))), _2473);
                    _2759 = fma(_2699, _1665 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2706 * pow(spvNMax(abs(1.0 - _2537), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2706 * pow(spvNMax(abs(1.0 - _2466), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1678))), _2475);
                }
                else
                {
                    _2758 = _2473;
                    _2759 = _2475;
                }
                _2760 = _2691;
                _2761 = _2692;
                _2762 = _2758;
                _2763 = _2759;
            }
            else
            {
                _2760 = _2468;
                _2761 = _2471;
                _2762 = _2473;
                _2763 = _2475;
            }
            _2469 = _2760;
            _2472 = _2761;
            _2474 = _2762;
            _2476 = _2763;
        }
        else
        {
            _2469 = _2468;
            _2472 = _2471;
            _2474 = _2473;
            _2476 = _2475;
        }
    }
    float _2765;
    bool _2768;
    vec3 _2770;
    vec3 _2772;
    uint _2774;
    _2765 = _2468;
    _2768 = _2471;
    _2770 = _2473;
    _2772 = _2475;
    _2774 = _2477;
    float _2766;
    bool _2769;
    vec3 _2771;
    vec3 _2773;
    for (; _2774 < _2460; _2765 = _2766, _2768 = _2769, _2770 = _2771, _2772 = _2773, _2774++)
    {
        uint _2781 = uint(_26._m0[_2774]);
        float _2794 = abs(_27._m0[_2781]._m5);
        if ((_27._m0[_2781]._m6 & (1u << (_49._m1 & 31u))) != 0u)
        {
            vec3 _2812 = _27._m0[_2781]._m0.xyz - _5;
            float _2813 = dot(_2812, _2812);
            vec3 _2816 = _2812 * inversesqrt(spvNMax(_2813, 1.0000000133514319600180897396058e-10));
            float _2817 = _27._m0[_2781]._m0.w * _27._m0[_2781]._m0.w;
            float _3045;
            bool _3046;
            vec3 _3047;
            vec3 _3048;
            if (_2813 < (1.0 / _2817))
            {
                vec3 _2822 = _437 + _2816;
                vec3 _2826 = _2822 * inversesqrt(spvNMax(dot(_2822, _2822), 1.0000000133514319600180897396058e-10));
                float _2828 = clamp(dot(_2816, _2826), 0.0, 1.0);
                float _2830 = clamp(dot(_1294, _2826), 0.0, 1.0);
                float _2832 = clamp(dot(_1294, _2816), 0.0, 1.0);
                float _2835 = dot(-_2816, normalize(_27._m0[_2781]._m2.xyz));
                float _2864;
                if (_2835 > _27._m0[_2781]._m1.w)
                {
                    float _2839 = _2813 * _2817;
                    float _2845 = pow(spvNMax(abs(clamp(fma(-_2839, _2839, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _27._m0[_2781]._m4);
                    float _2855;
                    if (_27._m0[_2781]._m5 < 0.0)
                    {
                        _2855 = _2845 * fma(4.0, _2817, _2794);
                    }
                    else
                    {
                        _2855 = _2845 * ((1.0 / spvNMax(_2813, 9.9999997473787516355514526367188e-05)) + _2794);
                    }
                    float _2860 = clamp((_2835 - _27._m0[_2781]._m1.w) / spvNMax(_27._m0[_2781]._m2.w - _27._m0[_2781]._m1.w, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
                    _2864 = _2832 * (_2855 * (_2860 * _2860));
                }
                else
                {
                    _2864 = 0.0;
                }
                float _2865 = 0.3183098733425140380859375 * _2864;
                float _2976;
                bool _2977;
                float _2978;
                if ((_27._m0[_2781]._m7 & 1u) != 0u)
                {
                    uint _2868 = uint(int(_27._m0[_2781]._m7 >> 2u));
                    float _2970;
                    bool _2971;
                    float _2972;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2832 <= 0.0) && true)
                        {
                            _2970 = _2765;
                            _2971 = _2768;
                            _2972 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2901 = _38._m0[_2868]._m0 * vec4(_5 + (_1294 * ((3.5 * float(int(sign(_2832)))) * (_38._m0[_2868]._m4 * sqrt(_2813)))), 1.0);
                            vec3 _2905 = _2901.xyz / vec3(_2901.w);
                            vec2 _2908 = (_2905.xy * 0.5) + vec2(0.5);
                            _2908.y = 1.0 - _2908.y;
                            float _2917 = (_38._m0[_2868]._m5.y / _38._m0[_2868]._m6) / (_2905.z - _38._m0[_2868]._m5.x);
                            float _2922 = _2768 ? _2765 : 6.283185482025146484375;
                            float _2923 = _2441 * _2922;
                            vec2 _2924 = _38._m0[_2868]._m1 + _37._m33;
                            vec2 _2927 = (_38._m0[_2868]._m1 + vec2(_38._m0[_2868]._m2)) - _37._m33;
                            float _2929;
                            _2929 = 0.0;
                            for (int _2932 = 0; _2932 < 12; )
                            {
                                float _2937 = float(uint(_2932));
                                float _2940 = sqrt(_2937 + 0.5) * 0.288675129413604736328125;
                                float _2941 = fma(_2937, 2.3999631404876708984375, _2923);
                                vec2 _2949 = clamp(fma((vec3(cos(_2941), sin(_2941), _2940).xy * _2940) * 2.5, _37._m33, _2908), _2924, _2927);
                                vec2 _2952 = fract(fma(vec2(1.0) / _37._m33, _2949, vec2(0.5)));
                                vec4 _2958 = vec4(lessThan(vec4(_2917), textureGather(sampler2D(_39, _30), _2949)));
                                float _2961 = _2952.x;
                                _2929 += clamp(mix(mix(_2958.w, _2958.z, _2961), mix(_2958.x, _2958.y, _2961), _2952.y), 0.0, 1.0);
                                _2932++;
                                continue;
                            }
                            _2970 = _2922;
                            _2971 = _2768 ? _2768 : true;
                            _2972 = _2929 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2976 = _2970;
                    _2977 = _2971;
                    _2978 = _2865 * mix(1.0, _2972, spvNMin(_2448, _27._m0[_2781]._m8));
                }
                else
                {
                    _2976 = _2765;
                    _2977 = _2768;
                    _2978 = _2865;
                }
                vec3 _3043;
                vec3 _3044;
                if (_2832 > 0.0)
                {
                    vec3 _2984 = _27._m0[_2781]._m1.xyz * (_2978 * ((_27._m0[_2781]._m3 < 0.0) ? _21._m0[0u] : 1.0));
                    vec3 _2991 = vec3(fma((2.0 * _2828) * _2828, _1678, mix(0.0, 0.5, _1678))) - vec3(1.0);
                    float _3012 = (_1678 + 1.0) * 0.5;
                    float _3013 = _1678 * _1678;
                    float _3021 = _3012 * _3012;
                    float _3033 = _3013 * _3013;
                    float _3036 = fma(fma(_2830, _3033, -_2830), _2830, 1.0);
                    _3043 = fma(_2984, (_1668 + ((vec3(1.0) - _1668) * pow(spvNMax(abs(1.0 - _2828), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2832, sqrt(fma(fma(-_2466, _3021, _2466), _2466, _3021)), _2466 * sqrt(fma(fma(-_2832, _3021, _2832), _2832, _3021)))) * (_3033 * (0.3183098733425140380859375 / (_3036 * _3036)))), _2770);
                    _3044 = fma(_2984, _1665 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2991 * pow(spvNMax(abs(1.0 - _2832), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2991 * pow(spvNMax(abs(1.0 - _2466), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1678))), _2772);
                }
                else
                {
                    _3043 = _2770;
                    _3044 = _2772;
                }
                _3045 = _2976;
                _3046 = _2977;
                _3047 = _3043;
                _3048 = _3044;
            }
            else
            {
                _3045 = _2765;
                _3046 = _2768;
                _3047 = _2770;
                _3048 = _2772;
            }
            _2766 = _3045;
            _2769 = _3046;
            _2771 = _3047;
            _2773 = _3048;
        }
        else
        {
            _2766 = _2765;
            _2769 = _2768;
            _2771 = _2770;
            _2773 = _2772;
        }
    }
    vec3 _3055;
    vec3 _3057;
    _3055 = _2770;
    _3057 = _2772;
    float _3051;
    bool _3054;
    vec3 _3056;
    vec3 _3058;
    float _3050 = _2765;
    bool _3053 = _2768;
    uint _3059 = _2774;
    for (; _3059 < _2464; _3050 = _3051, _3053 = _3054, _3055 = _3056, _3057 = _3058, _3059++)
    {
        uint _3066 = uint(_26._m0[_3059]);
        int _3095 = int(_28._m0[_3066]._m1 >> 1u) - 1;
        if (((_28._m0[_3066]._m4 & 16777215u) & (1u << (_49._m1 & 31u))) != 0u)
        {
            vec3 _3106 = _28._m0[_3066]._m6 * vec4(_5, 1.0);
            float _3494;
            bool _3495;
            vec3 _3496;
            vec3 _3497;
            if (all(lessThan(abs(_3106 - vec3(0.5)), vec3(0.5))))
            {
                vec3 _3113 = _437 + _28._m0[_3066]._m9;
                vec3 _3117 = _3113 * inversesqrt(spvNMax(dot(_3113, _3113), 1.0000000133514319600180897396058e-10));
                float _3119 = clamp(dot(_28._m0[_3066]._m9, _3117), 0.0, 1.0);
                float _3121 = clamp(dot(_1294, _3117), 0.0, 1.0);
                float _3123 = clamp(dot(_1294, _28._m0[_3066]._m9), 0.0, 1.0);
                int _3124 = int(_28._m0[_3066]._m4 >> 24u);
                float _3125 = _3106.z;
                vec3 _3164;
                if (_3125 < _28._m0[_3066]._m2.x)
                {
                    float _3152 = _3125 * _28._m0[_3066]._m2.z;
                    float _3155 = _3152 * _3152;
                    vec3 _3163;
                    _3163.z = dot(_380[_3124], vec4(_3152, _3155, smoothstep(0.0, 1.0, _3152), (_3155 * _3152) * fma(_3152, fma(_3152, 6.0, -15.0), 10.0)));
                    _3164 = _3163;
                }
                else
                {
                    vec3 _3150;
                    if (_3125 > _28._m0[_3066]._m2.y)
                    {
                        float _3138 = (1.0 - _3125) * _28._m0[_3066]._m2.w;
                        float _3141 = _3138 * _3138;
                        vec3 _3149;
                        _3149.z = dot(_380[_3124], vec4(_3138, _3141, smoothstep(0.0, 1.0, _3138), (_3141 * _3138) * fma(_3138, fma(_3138, 6.0, -15.0), 10.0)));
                        _3150 = _3149;
                    }
                    else
                    {
                        _3150 = vec3(0.0, 0.0, 1.0);
                    }
                    _3164 = _3150;
                }
                vec2 _3165 = _3106.xy;
                vec2 _3169 = (vec2(0.5) - abs(_3165 - vec2(0.5))) * _28._m0[_3066]._m3;
                float _3170 = _3169.x;
                vec3 _3187;
                if (_3170 < 1.0)
                {
                    float _3178 = _3170 * _3170;
                    vec3 _3186 = _3164;
                    _3186.x = dot(_380[_3124], vec4(_3170, _3178, smoothstep(0.0, 1.0, _3170), (_3178 * _3170) * fma(_3170, fma(_3170, 6.0, -15.0), 10.0)));
                    _3187 = _3186;
                }
                else
                {
                    vec3 _3175 = _3164;
                    _3175.x = 1.0;
                    _3187 = _3175;
                }
                float _3188 = _3169.y;
                vec3 _3205;
                if (_3188 < 1.0)
                {
                    float _3196 = _3188 * _3188;
                    vec3 _3204 = _3187;
                    _3204.y = dot(_380[_3124], vec4(_3188, _3196, smoothstep(0.0, 1.0, _3188), (_3196 * _3188) * fma(_3188, fma(_3188, 6.0, -15.0), 10.0)));
                    _3205 = _3204;
                }
                else
                {
                    vec3 _3193 = _3187;
                    _3193.y = 1.0;
                    _3205 = _3193;
                }
                float _3211 = _3123 * ((_3205.x * _3205.y) * _3205.z);
                float _3316;
                bool _3317;
                float _3318;
                if ((_28._m0[_3066]._m8 & 1u) != 0u)
                {
                    uint _3214 = uint(int(_28._m0[_3066]._m8 >> 2u));
                    float _3310;
                    bool _3311;
                    float _3312;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_3123 <= 0.0) && true)
                        {
                            _3310 = _3050;
                            _3311 = _3053;
                            _3312 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _3245 = _38._m0[_3214]._m0 * vec4(_5 + (_1294 * ((3.5 * float(int(sign(_3123)))) * _38._m0[_3214]._m4)), 1.0);
                            vec2 _3248 = (_3245.xy * 0.5) + vec2(0.5);
                            _3248.y = 1.0 - _3248.y;
                            float _3257 = ((_3245.z - _38._m0[_3214]._m5.y) / _38._m0[_3214]._m5.x) / _38._m0[_3214]._m6;
                            float _3262 = _3053 ? _3050 : 6.283185482025146484375;
                            float _3263 = _2441 * _3262;
                            vec2 _3264 = _38._m0[_3214]._m1 + _37._m33;
                            vec2 _3267 = (_38._m0[_3214]._m1 + vec2(_38._m0[_3214]._m2)) - _37._m33;
                            float _3269;
                            _3269 = 0.0;
                            for (int _3272 = 0; _3272 < 12; )
                            {
                                float _3277 = float(uint(_3272));
                                float _3280 = sqrt(_3277 + 0.5) * 0.288675129413604736328125;
                                float _3281 = fma(_3277, 2.3999631404876708984375, _3263);
                                vec2 _3289 = clamp(fma((vec3(cos(_3281), sin(_3281), _3280).xy * _3280) * 2.5, _37._m33, _3248), _3264, _3267);
                                vec2 _3292 = fract(fma(vec2(1.0) / _37._m33, _3289, vec2(0.5)));
                                vec4 _3298 = vec4(lessThan(vec4(_3257), textureGather(sampler2D(_39, _30), _3289)));
                                float _3301 = _3292.x;
                                _3269 += clamp(mix(mix(_3298.w, _3298.z, _3301), mix(_3298.x, _3298.y, _3301), _3292.y), 0.0, 1.0);
                                _3272++;
                                continue;
                            }
                            _3310 = _3262;
                            _3311 = _3053 ? _3053 : true;
                            _3312 = _3269 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _3316 = _3310;
                    _3317 = _3311;
                    _3318 = _3211 * mix(1.0, _3312, spvNMin(_2448, _28._m0[_3066]._m5));
                }
                else
                {
                    _3316 = _3050;
                    _3317 = _3053;
                    _3318 = _3211;
                }
                vec3 _3359;
                if (_3095 >= 0)
                {
                    uint _3323 = gl_SubgroupInvocationID & 3u;
                    vec2 _3329 = (subgroupQuadSwapHorizontal(_3165) - _3165) * (((_3323 & 1u) != 0u) ? (-1.0) : 1.0);
                    vec2 _3335 = (subgroupQuadSwapVertical(_3165) - _3165) * (((_3323 & 2u) != 0u) ? (-1.0) : 1.0);
                    vec2 _3339 = mix(_3329, vec2(0.0), bvec2(any(isnan(_3329))));
                    vec2 _3343 = mix(_3335, vec2(0.0), bvec2(any(isnan(_3335))));
                    bvec2 _3352 = bvec2(any(greaterThan(abs(vec4(_3339, _3343)), vec4(0.015625))));
                    int _94 = _3095;
                    _3359 = _28._m0[_3066]._m0 * textureGrad(nonuniformEXT(sampler2D(_43[_94], _22)), _3165, mix(_3339, vec2(0.0), _3352), mix(_3343, vec2(0.0), _3352)).xyz;
                }
                else
                {
                    _3359 = _28._m0[_3066]._m0;
                }
                vec3 _3492;
                vec3 _3493;
                SPIRV_CROSS_BRANCH
                if ((_28._m0[_3066]._m1 & 1u) != 0u)
                {
                    vec3 _3490;
                    vec3 _3491;
                    if (_3123 > 0.0)
                    {
                        vec3 _3431 = _3359 * (_3318 * _21._m0[0u]);
                        vec3 _3438 = vec3(fma((2.0 * _3119) * _3119, _1678, mix(0.0, 0.5, _1678))) - vec3(1.0);
                        float _3459 = (_1678 + 1.0) * 0.5;
                        float _3460 = _1678 * _1678;
                        float _3468 = _3459 * _3459;
                        float _3480 = _3460 * _3460;
                        float _3483 = fma(fma(_3121, _3480, -_3121), _3121, 1.0);
                        _3490 = fma(_3431, (_1668 + ((vec3(1.0) - _1668) * pow(spvNMax(abs(1.0 - _3119), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_3123, sqrt(fma(fma(-_2466, _3468, _2466), _2466, _3468)), _2466 * sqrt(fma(fma(-_3123, _3468, _3123), _3123, _3468)))) * (_3480 * (0.3183098733425140380859375 / (_3483 * _3483)))), _3055);
                        _3491 = fma(_3431, _1665 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3438 * pow(spvNMax(abs(1.0 - _3123), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3438 * pow(spvNMax(abs(1.0 - _2466), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1678))), _3057);
                    }
                    else
                    {
                        _3490 = _3055;
                        _3491 = _3057;
                    }
                    _3492 = _3490;
                    _3493 = _3491;
                }
                else
                {
                    vec3 _3425;
                    vec3 _3426;
                    if (_3123 > 0.0)
                    {
                        vec3 _3366 = _3359 * _3318;
                        vec3 _3373 = vec3(fma((2.0 * _3119) * _3119, _1678, mix(0.0, 0.5, _1678))) - vec3(1.0);
                        float _3394 = (_1678 + 1.0) * 0.5;
                        float _3395 = _1678 * _1678;
                        float _3403 = _3394 * _3394;
                        float _3415 = _3395 * _3395;
                        float _3418 = fma(fma(_3121, _3415, -_3121), _3121, 1.0);
                        _3425 = fma(_3366, (_1668 + ((vec3(1.0) - _1668) * pow(spvNMax(abs(1.0 - _3119), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_3123, sqrt(fma(fma(-_2466, _3403, _2466), _2466, _3403)), _2466 * sqrt(fma(fma(-_3123, _3403, _3123), _3123, _3403)))) * (_3415 * (0.3183098733425140380859375 / (_3418 * _3418)))), _3055);
                        _3426 = fma(_3366, _1665 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3373 * pow(spvNMax(abs(1.0 - _3123), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3373 * pow(spvNMax(abs(1.0 - _2466), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1678))), _3057);
                    }
                    else
                    {
                        _3425 = _3055;
                        _3426 = _3057;
                    }
                    _3492 = _3425;
                    _3493 = _3426;
                }
                _3494 = _3316;
                _3495 = _3317;
                _3496 = _3492;
                _3497 = _3493;
            }
            else
            {
                _3494 = _3050;
                _3495 = _3053;
                _3496 = _3055;
                _3497 = _3057;
            }
            _3051 = _3494;
            _3054 = _3495;
            _3056 = _3496;
            _3058 = _3497;
        }
        else
        {
            _3051 = _3050;
            _3054 = _3053;
            _3056 = _3055;
            _3058 = _3057;
        }
    }
    vec3 _3499 = reflect(-_437, _1294);
    vec3 _3501 = vec3(_1668.x, _1668.y, _1668.z);
    vec3 _3511 = textureLod(samplerCube(_32, _22), _1294, 0.0).xyz * _37._m27;
    vec3 _3518 = textureLod(samplerCube(_33, _22), _3499, fma(_1678, 8.0, _37._m30 - 8.0)).xyz * _37._m27;
    vec3 _3543;
    vec3 _3544;
    SPIRV_CROSS_BRANCH
    if (_37._m29 > 0.0)
    {
        vec3 _3533 = vec3(_37._m29);
        _3543 = mix(_3518, textureLod(samplerCube(_35, _22), _3499, fma(_1678, 8.0, _37._m31 - 8.0)).xyz * _37._m28, _3533);
        _3544 = mix(_3511, textureLod(samplerCube(_34, _22), _1294, 0.0).xyz * _37._m28, _3533);
    }
    else
    {
        _3543 = _3518;
        _3544 = _3511;
    }
    float _3545 = spvNMax(dot(_437, _1294), 0.001953125);
    vec4 _3550 = textureLod(sampler2D(_36, _30), vec2(_3545, _1678), 0.0);
    uvec4 _3561 = uvec4(_25._m0[_2449]);
    uint _3563 = _3561.y;
    uint _3573 = ((_3561.z >> 0u) & 1023u) + (((_3563 >> 12u) & 4095u) + (((_3563 >> 0u) & 4095u) + _3561.x));
    uint _3575 = (_3563 >> 24u) + _3573;
    vec3 _3577;
    vec3 _3580;
    _3577 = _3543 * ((_3501 * _3550.x) + vec3(_3550.y));
    _3580 = _3544 * (_1665 * _3550.z);
    vec3 _3578;
    vec3 _3581;
    for (uint _3582 = _3573; _3582 < _3575; _3577 = _3578, _3580 = _3581, _3582++)
    {
        uint _3589 = uint(_26._m0[_3582]);
        int _3608 = int((_31._m0[_3589]._m5 >> 1u) & 3u);
        mat3 _3612 = mat3(_31._m0[_3589]._m1[0], _31._m0[_3589]._m1[1], _31._m0[_3589]._m1[2]);
        int _3618 = (int((_31._m0[_3589]._m5 >> 3u) & 16383u) - 1) * 2;
        int _3623 = (int((_31._m0[_3589]._m5 >> 17u) & 16383u) - 1) * 2;
        int _3628 = (int((_31._m0[_3589]._m6 >> 0u) & 65535u) - 1) * 2;
        int _3633 = (int((_31._m0[_3589]._m6 >> 16u) & 65535u) - 1) * 2;
        float _3636 = (_31._m0[_3589]._m3 < 0.0) ? (-_31._m0[_3589]._m3) : 1.0;
        vec3 _3638 = _3612 * (_5 - _31._m0[_3589]._m1[3]);
        bool _3639 = int(_31._m0[_3589]._m5 & 1u) == 1;
        vec3 _3640 = abs(_3638);
        float _3643 = dot(_3638, _3638);
        if (_3639 ? any(greaterThanEqual(_3640, _31._m0[_3589]._m0.xyz)) : (_3643 >= _31._m0[_3589]._m0.y))
        {
            _3578 = _3577;
            _3581 = _3580;
            continue;
        }
        vec3 _3817;
        SPIRV_CROSS_FLATTEN
        if ((_3608 & 1) != 0)
        {
            vec3 _3653 = _3612 * _1294;
            vec2 _3742;
            bool _3743;
            if (_3639)
            {
                vec2 _3737;
                bool _3741;
                do
                {
                    vec3 _3721 = (_31._m0[_3589]._m0.xyz - _3638) / _3653;
                    vec3 _3724 = ((-_31._m0[_3589]._m0.xyz) - _3638) / _3653;
                    vec3 _3725 = spvNMin(_3721, _3724);
                    vec3 _3726 = spvNMax(_3721, _3724);
                    float _3731 = spvNMax(_3725.x, spvNMax(_3725.y, _3725.z));
                    float _3736 = spvNMin(_3726.x, spvNMin(_3726.y, _3726.z));
                    _3737 = vec2(_3731, _3736);
                    if (_3731 > _3736)
                    {
                        _3741 = false;
                        break;
                    }
                    _3741 = true;
                    break;
                } while(false);
                _3742 = _3737;
                _3743 = _3741;
            }
            else
            {
                vec2 _3716;
                bool _3717;
                do
                {
                    float _3659 = dot(_3653, _3653);
                    float _3660 = dot(_3653, _3638);
                    float _3661 = 2.0 * _3660;
                    float _3662 = _3643 - _31._m0[_3589]._m0.y;
                    float _3698;
                    float _3699;
                    bool _3700;
                    do
                    {
                        float _3668 = fma(_3661, _3661, -((4.0 * _3659) * _3662));
                        float _3696;
                        float _3697;
                        if (_3668 < 0.0)
                        {
                            _3698 = 0.0;
                            _3699 = 0.0;
                            _3700 = false;
                            break;
                        }
                        else
                        {
                            if (_3668 == 0.0)
                            {
                                float _3695 = (_3660 * (-1.0)) * (1.0 / _3659);
                                _3696 = _3695;
                                _3697 = _3695;
                            }
                            else
                            {
                                float _3688;
                                if (_3661 > 0.0)
                                {
                                    _3688 = (-0.5) * fma(2.0, _3660, sqrt(_3668));
                                }
                                else
                                {
                                    _3688 = (-0.5) * fma(2.0, _3660, -sqrt(_3668));
                                }
                                _3696 = _3662 * (1.0 / _3688);
                                _3697 = _3688 * (1.0 / _3659);
                            }
                        }
                        _3698 = _3696;
                        _3699 = _3697;
                        _3700 = true;
                        break;
                    } while(false);
                    if (!_3700)
                    {
                        _3716 = vec2(0.0);
                        _3717 = false;
                        break;
                    }
                    if ((_3699 < 0.0) && (_3698 < 0.0))
                    {
                        _3716 = vec2(0.0);
                        _3717 = false;
                        break;
                    }
                    vec2 _3715;
                    if (_3699 > _3698)
                    {
                        _3715 = vec2(_3698, _3699);
                    }
                    else
                    {
                        _3715 = vec2(_3699, _3698);
                    }
                    _3716 = _3715;
                    _3717 = true;
                    break;
                } while(false);
                _3742 = _3716;
                _3743 = _3717;
            }
            vec3 _3746 = _3638 + (_3653 * _3742.y);
            float _3767;
            if (_3639)
            {
                _3767 = 1.0 - clamp(length(spvNMax(_3640 - (_31._m0[_3589]._m0.xyz - vec3(_31._m0[_3589]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_31._m0[_3589]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3767 = clamp((_31._m0[_3589]._m0.x - length(_3638)) * (1.0 / spvNMax(_31._m0[_3589]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3770 = float(_3743) * smoothstep(0.0, 1.0, _3767);
            vec4 _3812;
            SPIRV_CROSS_BRANCH
            if (_3770 > 9.9999997473787516355514526367188e-05)
            {
                float _3779 = mix(clamp((_3742.y * (1.0 / length(_3746))) * _1678, 0.0, _1678), _1678, _1678);
                vec3 _3781 = mix(_3746, _3653, vec3(_3779));
                int _98 = _3618;
                vec4 _3782 = textureLod(nonuniformEXT(samplerCube(_42[_98], _22)), _3781, 0.0);
                int _102 = _3618 + 1;
                _3782.w = textureLod(nonuniformEXT(samplerCube(_42[_102], _22)), _3781, 0.0).x;
                vec4 _3797;
                SPIRV_CROSS_BRANCH
                if (_3623 >= 0)
                {
                    int _106 = _3623;
                    vec4 _3790 = textureLod(nonuniformEXT(samplerCube(_42[_106], _22)), _3781, 0.0);
                    int _110 = _3623 + 1;
                    _3790.w = textureLod(nonuniformEXT(samplerCube(_42[_110], _22)), _3781, 0.0).x;
                    _3797 = mix(_3782, _3790, vec4(_31._m0[_3589]._m3));
                }
                else
                {
                    _3797 = _3782;
                }
                vec4 _3798 = _3797 * _3636;
                vec3 _3807 = (_3798.xyz * _31._m0[_3589]._m4).xyz * (_1665 * textureLod(sampler2D(_36, _30), vec2(_3545, _3779), 0.0).z);
                vec4 _3808 = vec4(_3807.x, _3807.y, _3807.z, _3798.w);
                _3808.w = _3798.w * _3770;
                _3812 = _3808;
            }
            else
            {
                _3812 = vec4(0.0);
            }
            _3817 = mix(_3580, _3812.xyz, vec3(_3812.w));
        }
        else
        {
            _3817 = _3580;
        }
        vec3 _3996;
        SPIRV_CROSS_FLATTEN
        if ((_3608 & 2) != 0)
        {
            vec3 _3822 = _3612 * _3499;
            vec2 _3911;
            bool _3912;
            if (_3639)
            {
                vec2 _3906;
                bool _3910;
                do
                {
                    vec3 _3890 = (_31._m0[_3589]._m0.xyz - _3638) / _3822;
                    vec3 _3893 = ((-_31._m0[_3589]._m0.xyz) - _3638) / _3822;
                    vec3 _3894 = spvNMin(_3890, _3893);
                    vec3 _3895 = spvNMax(_3890, _3893);
                    float _3900 = spvNMax(_3894.x, spvNMax(_3894.y, _3894.z));
                    float _3905 = spvNMin(_3895.x, spvNMin(_3895.y, _3895.z));
                    _3906 = vec2(_3900, _3905);
                    if (_3900 > _3905)
                    {
                        _3910 = false;
                        break;
                    }
                    _3910 = true;
                    break;
                } while(false);
                _3911 = _3906;
                _3912 = _3910;
            }
            else
            {
                vec2 _3885;
                bool _3886;
                do
                {
                    float _3828 = dot(_3822, _3822);
                    float _3829 = dot(_3822, _3638);
                    float _3830 = 2.0 * _3829;
                    float _3831 = _3643 - _31._m0[_3589]._m0.y;
                    float _3867;
                    float _3868;
                    bool _3869;
                    do
                    {
                        float _3837 = fma(_3830, _3830, -((4.0 * _3828) * _3831));
                        float _3865;
                        float _3866;
                        if (_3837 < 0.0)
                        {
                            _3867 = 0.0;
                            _3868 = 0.0;
                            _3869 = false;
                            break;
                        }
                        else
                        {
                            if (_3837 == 0.0)
                            {
                                float _3864 = (_3829 * (-1.0)) * (1.0 / _3828);
                                _3865 = _3864;
                                _3866 = _3864;
                            }
                            else
                            {
                                float _3857;
                                if (_3830 > 0.0)
                                {
                                    _3857 = (-0.5) * fma(2.0, _3829, sqrt(_3837));
                                }
                                else
                                {
                                    _3857 = (-0.5) * fma(2.0, _3829, -sqrt(_3837));
                                }
                                _3865 = _3831 * (1.0 / _3857);
                                _3866 = _3857 * (1.0 / _3828);
                            }
                        }
                        _3867 = _3865;
                        _3868 = _3866;
                        _3869 = true;
                        break;
                    } while(false);
                    if (!_3869)
                    {
                        _3885 = vec2(0.0);
                        _3886 = false;
                        break;
                    }
                    if ((_3868 < 0.0) && (_3867 < 0.0))
                    {
                        _3885 = vec2(0.0);
                        _3886 = false;
                        break;
                    }
                    vec2 _3884;
                    if (_3868 > _3867)
                    {
                        _3884 = vec2(_3867, _3868);
                    }
                    else
                    {
                        _3884 = vec2(_3868, _3867);
                    }
                    _3885 = _3884;
                    _3886 = true;
                    break;
                } while(false);
                _3911 = _3885;
                _3912 = _3886;
            }
            vec3 _3915 = _3638 + (_3822 * _3911.y);
            float _3936;
            if (_3639)
            {
                _3936 = 1.0 - clamp(length(spvNMax(_3640 - (_31._m0[_3589]._m0.xyz - vec3(_31._m0[_3589]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_31._m0[_3589]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3936 = clamp((_31._m0[_3589]._m0.x - length(_3638)) * (1.0 / spvNMax(_31._m0[_3589]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3939 = float(_3912) * smoothstep(0.0, 1.0, _3936);
            vec4 _3991;
            SPIRV_CROSS_BRANCH
            if (_3939 > 9.9999997473787516355514526367188e-05)
            {
                float _3948 = mix(clamp((_3911.y * (1.0 / length(_3915))) * _1678, 0.0, _1678), _1678, _1678);
                vec3 _3950 = mix(_3915, _3822, vec3(_3948));
                float _3951 = _3948 * 8.0;
                int _114 = _3628;
                int _118 = _3628 + 1;
                vec4 _3959 = vec4(textureLod(nonuniformEXT(samplerCube(_42[_114], _22)), _3950, _3951).xyz, textureLod(nonuniformEXT(samplerCube(_42[_118], _22)), _3950, _3951).x);
                vec4 _3973;
                SPIRV_CROSS_BRANCH
                if (_3633 >= 0)
                {
                    int _122 = _3633;
                    int _126 = _3633 + 1;
                    _3973 = mix(_3959, vec4(textureLod(nonuniformEXT(samplerCube(_42[_122], _22)), _3950, _3951).xyz, textureLod(nonuniformEXT(samplerCube(_42[_126], _22)), _3950, _3951).x), vec4(_31._m0[_3589]._m3));
                }
                else
                {
                    _3973 = _3959;
                }
                vec4 _3974 = _3973 * _3636;
                vec4 _3979 = textureLod(sampler2D(_36, _30), vec2(_3545, _3948), 0.0);
                vec3 _3986 = (_3974.xyz * _31._m0[_3589]._m4).xyz * ((_3501 * _3979.x) + vec3(_3979.y));
                vec4 _3987 = vec4(_3986.x, _3986.y, _3986.z, _3974.w);
                _3987.w = _3974.w * _3939;
                _3991 = _3987;
            }
            else
            {
                _3991 = vec4(0.0);
            }
            _3996 = mix(_3577, _3991.xyz, vec3(_3991.w));
        }
        else
        {
            _3996 = _3577;
        }
        _3578 = _3996;
        _3581 = _3817;
    }
    float _3997 = _21._m0[0u] * 100.0;
    vec3 _4001 = _2262 * (_2434 * _21._m0[0u]);
    vec3 _4004 = reflect(_437, _1294);
    float _4008 = clamp(dot(_15._m0, normalize(_437 + _15._m0)), 0.0, 1.0);
    float _4010 = clamp(dot(_1294, _15._m0), 0.0, 1.0);
    vec3 _4017 = vec3(fma((2.0 * _4008) * _4008, _1678, mix(0.0, 0.5, _1678))) - vec3(1.0);
    float _4036 = dot(_15._m0, _4004);
    vec3 _4046 = mix(_4004, normalize((_15._m0 * 0.999989449977874755859375) + (normalize(_4004 - (_15._m0 * _4036)) * 0.0045900647528469562530517578125)), bvec3(_4036 < 0.999989449977874755859375));
    vec3 _4048 = normalize(_437 + _4046);
    float _4052 = clamp(dot(_1294, _4048), 0.0, 1.0);
    float _4054 = clamp(dot(_1294, _4046), 0.0, 1.0);
    float _4056 = (_1678 + 1.0) * 0.5;
    float _4057 = _1678 * _1678;
    float _4065 = _4056 * _4056;
    float _4077 = _4057 * _4057;
    float _4080 = fma(fma(_4052, _4077, -_4052), _4052, 1.0);
    vec3 _4099 = (((_3057 + ((_4001 * (_1665 * (0.3183098733425140380859375 * (((vec3(1.0) + (_4017 * pow(spvNMax(abs(1.0 - _4010), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_4017 * pow(spvNMax(abs(1.0 - _2466), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1678))))) * _4010)) + (_3055 + ((_4001 * ((_1668 + ((vec3(1.0) - _1668) * pow(spvNMax(abs(1.0 - clamp(dot(_4046, _4048), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_4054, sqrt(fma(fma(-_2466, _4065, _2466), _2466, _4065)), _2466 * sqrt(fma(fma(-_4054, _4065, _4054), _4054, _4065)))) * (_4077 * (0.3183098733425140380859375 / (_4080 * _4080)))))) * _4010))) * mix(1.0, 1.0, _37._m1)) + (((_3580 * _3997) + (_3577 * _3997)) * 1.0);
    vec4 _4294;
    do
    {
        if (_37._m19[3].z < 0.0)
        {
            _4294 = vec4(0.0, 0.0, 0.0, 1.0);
            break;
        }
        float _4140;
        do
        {
            if (_11 <= _37._m19[0].x)
            {
                _4140 = fma(_37._m19[2].x, _11, _37._m19[3].x);
                break;
            }
            else
            {
                _4140 = _37._m19[1].y * log2(fma(_37._m19[2].y, _11, _37._m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        vec3 _4150 = (vec3(_430 / vec2(_37._m32, _37._m18), _4140) + vec3(float(_18._m5), 0.0, 0.0)) - vec3(0.5);
        vec3 _4151 = floor(_4150);
        vec3 _4152 = _4150 - _4151;
        vec3 _4153 = vec3(1.0) - _4152;
        vec3 _4160 = fma(-((_4152 * 0.5) * _4152), vec3(2.0) - _4152, vec3(0.666666686534881591796875));
        vec3 _4167 = (_4152 * 0.16666667163372039794921875) * _4152;
        vec3 _4169 = fma((_4153 * 0.16666667163372039794921875) * _4153, _4153, _4160);
        vec3 _4176 = _37._m17 * (((_4160 / _4169) - vec3(0.5)) + _4151);
        vec3 _4180 = _37._m17 * ((((_4167 * _4152) / fma(_4167, _4152, fma(-((_4153 * 0.5) * _4153), _4152 + vec3(1.0), vec3(0.666666686534881591796875)))) + vec3(1.5)) + _4151);
        float _4188 = _4176.z;
        float _4194 = _4180.x;
        vec2 _4198 = spvNMax(_37._m15, spvNMin(_37._m16, vec2(_4194, _4176.y)));
        float _4199 = _4198.x;
        vec4 _4205 = vec4(_4169.x);
        float _4207 = _4176.x;
        vec2 _4211 = spvNMax(_37._m15, spvNMin(_37._m16, vec2(_4207, _4180.y)));
        float _4212 = _4211.x;
        vec4 _4227 = vec4(_4169.y);
        float _4232 = _4180.z;
        vec4 _4258 = mix(mix(mix(textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, _4180.xy)), _4232), 0.0), textureLod(sampler3D(_29, _30), vec3(_4212, _4211.y, _4232), 0.0), _4205), mix(textureLod(sampler3D(_29, _30), vec3(_4199, _4198.y, _4232), 0.0), textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, vec2(_4207, _4176.y))), _4232), 0.0), _4205), _4227), mix(mix(textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, vec2(_4194, _4180.y))), _4188), 0.0), textureLod(sampler3D(_29, _30), vec3(_4212, _4211.y, _4188), 0.0), _4205), mix(textureLod(sampler3D(_29, _30), vec3(_4199, _4198.y, _4188), 0.0), textureLod(sampler3D(_29, _30), vec3(spvNMax(_37._m15, spvNMin(_37._m16, _4176.xy)), _4188), 0.0), _4205), _4227), vec4(_4169.z)) * vec4(0.03125, 0.03125, 0.03125, 3.0517578125e-05);
        vec4 _4266;
        if (isinf(_4258.x) || isnan(_4258.x))
        {
            vec4 _4265 = _4258;
            _4265.x = 0.0;
            _4266 = _4265;
        }
        else
        {
            _4266 = _4258;
        }
        vec4 _4274;
        if (isinf(_4266.y) || isnan(_4266.y))
        {
            vec4 _4273 = _4266;
            _4273.y = 0.0;
            _4274 = _4273;
        }
        else
        {
            _4274 = _4266;
        }
        vec4 _4282;
        if (isinf(_4274.z) || isnan(_4274.z))
        {
            vec4 _4281 = _4274;
            _4281.z = 0.0;
            _4282 = _4281;
        }
        else
        {
            _4282 = _4274;
        }
        vec4 _4290;
        if (isinf(_4282.w) || isnan(_4282.w))
        {
            vec4 _4289 = _4282;
            _4289.w = 0.0;
            _4290 = _4289;
        }
        else
        {
            _4290 = _4282;
        }
        vec4 _4293 = _4290;
        _4293.w = 1.0 - _4290.w;
        _4294 = _4293;
        break;
    } while(false);
    vec4 _4299 = texture(sampler2D(_53, _19), _9);
    vec2 _4308 = ((((_4299.xy - vec2(0.5)) * 0.5) * (mix(0.5, _4299.z, _50._m1) * 2.0)) * vec2(-1.0, 1.0)) * _50._m22;
    vec4 _4310 = texture(sampler2D(_54, _51), _532);
    float _4311 = _4310.x;
    float _4313 = fma(_14._m0, _50._m23, _4311 * _50._m24);
    float _4314 = fract(_4313);
    vec4 _4319 = texture(sampler2D(_55, _19), fma(_9, _50._m6, _4308 * _4314) + _556);
    vec3 _4322 = (_4319.wzy * 2.0) - vec3(1.0);
    vec4 _4323 = vec4(_4322.x, _4322.y, _4322.z, _4319.x);
    _4323.z = -_4322.z;
    vec4 _4336 = texture(sampler2D(_55, _19), fma(_9, _50._m6, _4308 * fract(_4313 + 0.5)) + _556);
    vec3 _4339 = (_4336.wzy * 2.0) - vec3(1.0);
    vec4 _4340 = vec4(_4339.x, _4339.y, _4339.z, _4336.x);
    _4340.z = -_4339.z;
    float _4352 = fma(_4311, _50._m24, _595);
    float _4353 = fract(_4352);
    vec4 _4358 = texture(sampler2D(_56, _19), fma(_9, _50._m7, _4308 * _4353) + _556);
    vec3 _4361 = (_4358.wzy * 2.0) - vec3(1.0);
    vec4 _4362 = vec4(_4361.x, _4361.y, _4361.z, _4358.x);
    _4362.z = -_4361.z;
    vec4 _4375 = texture(sampler2D(_56, _19), fma(_9, _50._m7, _4308 * fract(_4352 + 0.5)) + _556);
    vec3 _4378 = (_4375.wzy * 2.0) - vec3(1.0);
    vec4 _4379 = vec4(_4378.x, _4378.y, _4378.z, _4375.x);
    _4379.z = -_4378.z;
    float _4392 = fma(_4311, _50._m24, _641);
    float _4393 = fract(_4392);
    vec4 _4398 = texture(sampler2D(_55, _19), fma(_9, _50._m8, _4308 * _4393) + _556);
    vec3 _4401 = (_4398.wzy * 2.0) - vec3(1.0);
    vec4 _4402 = vec4(_4401.x, _4401.y, _4401.z, _4398.x);
    _4402.z = -_4401.z;
    vec4 _4415 = texture(sampler2D(_55, _19), fma(_9, _50._m8, _4308 * fract(_4392 + 0.5)) + _556);
    vec3 _4418 = (_4415.wzy * 2.0) - vec3(1.0);
    vec4 _4419 = vec4(_4418.x, _4418.y, _4418.z, _4415.x);
    _4419.z = -_4418.z;
    float _4440 = clamp(fma(texture(sampler2D(_24, _20), _430).x, _16._m4, _447) / _463, 0.0, 1.0);
    float _4448 = fma(_4311, _50._m24, _760);
    float _4451 = (fract(_4448) + (-0.5)) * 2.0;
    vec2 _4452 = _4308 * _771;
    vec2 _4480 = (normalize((mix(normalize(_4323.xyz).xyz, normalize(_4340.xyz).xyz, vec3(abs((_4314 + (-0.5)) * 2.0))) + mix(normalize(_4362.xyz).xyz, normalize(_4379.xyz).xyz, vec3(abs((_4353 + (-0.5)) * 2.0)))) + (mix(normalize(_4402.xyz).xyz, normalize(_4419.xyz).xyz, vec3(abs((_4393 + (-0.5)) * 2.0))) * _50._m28)).xz * (fma(_4440 - 1.0, 1.0 - _4440, 1.0) * _50._m63)) * fma(-pow(spvNMax(abs(mix(vec4(_408, _408, _408, texture(sampler2D(_58, _19), fma(_524, _50._m9, _4452 * _4451) + _556).x), vec4(_408, _408, _408, texture(sampler2D(_58, _19), fma(_524, _50._m9, _4452 * ((fract(_4448 + 0.5) + (-0.5)) * 2.0)) + _556).x), vec4(abs(_4451))).w), 9.9999997473787516355514526367188e-05), _50._m36), _50._m37, 1.0);
    vec2 _4490 = vec2(_4480.x * (_17._m1 / _17._m0), -_4480.y);
    vec2 _4498 = _429 * 0.5;
    vec2 _4499 = _18._m9 - _4498;
    vec2 _4503 = (_18._m10 + _4498) - _4499;
    vec2 _4506 = abs(fma(_4490, _18._m21, _430) - _4499) + _4503;
    vec2 _4507 = _4503 * 2.0;
    vec2 _4522 = abs(fma(gl_FragCoord.xy, _429, ((_4490 * _18._m21) * step(_11, texture(sampler2D(_24, _52), clamp(_4499 + abs((_4506 - _4507 * trunc(_4506 / _4507)) - _4503), _18._m9, _18._m10)).x)) * _49._m0) - _4499) + _4503;
    vec4 _4530 = texture(sampler2D(_23, _52), clamp(_4499 + abs((_4522 - _4507 * trunc(_4522 / _4507)) - _4503), _18._m9, _18._m10));
    vec3 _4533 = mix(_4530.xyz, fma(fma(_4099, _2261, _2260 * _21._m0[0u]) + (((_964.xyz * ((clamp((spvNMin(fma(_970, -1.0, _50._m31), _970 - _50._m32) * _726) / _729, 0.0, 1.0) * _738) * clamp(-fma(length(_828), 8.0, _743), 0.0, 1.0))) * _50._m38) * float(!(_14._m1 != 0.0))), _4294.www, _4294.xyz), vec3(_809));
    _12 = spvNMax(vec4(_4533, fma(fma(-_806, _49._m0, 1.0), _4530.w, _809)), vec4(0.0));
}

