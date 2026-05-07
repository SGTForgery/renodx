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

struct _71
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

struct _74
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

struct _78
{
    vec4 _m0;
    mat4x3 _m1;
    vec4 _m2[4];
    float _m3;
    float _m4;
    uint _m5;
    uint _m6;
};

struct _83
{
    mat4 _m0;
    vec2 _m1;
    float _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    float _m6;
};

float _340;
const vec4 _356[4] = vec4[](vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
float _375;
vec3 _376;
float _383;
vec3 _384;

layout(set = 0, binding = 0, std140) uniform _59_13
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _13;

layout(set = 0, binding = 1, std140) uniform _61_14
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
} _14;

layout(set = 0, binding = 2, std140) uniform _62_15
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _15;

layout(set = 0, binding = 3, std140) uniform _63_16
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _16;

layout(set = 0, binding = 4, std140) uniform _64_17
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
} _17;

layout(set = 2, binding = 0, std430) readonly buffer _66_20
{
    float _m0[];
} _20;

layout(set = 2, binding = 10, std430) readonly buffer _68_24
{
    ivec4 _m0[];
} _24;

layout(set = 2, binding = 11, std430) readonly buffer _70_25
{
    int _m0[];
} _25;

layout(set = 2, binding = 12, std430) readonly buffer _73_26
{
    _71 _m0[];
} _26;

layout(set = 2, binding = 16, std430) readonly buffer _76_27
{
    layout(row_major) _74 _m0[];
} _27;

layout(set = 2, binding = 20, std430) readonly buffer _80_30
{
    layout(row_major) _78 _m0[];
} _30;

layout(set = 2, binding = 26, std140) uniform _82_36
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
} _36;

layout(set = 2, binding = 27, scalar) readonly buffer _85_37
{
    layout(row_major) _83 _m0[];
} _37;

layout(set = 5, binding = 0, scalar) uniform _86_43
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
} _43;

layout(set = 1, binding = 0, std140) uniform _87_48
{
    float _m0;
    uint _m1;
    uint _m2;
    uint _m3;
} _48;

layout(set = 1, binding = 1, std140) uniform _88_49
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
} _49;

layout(set = 0, binding = 7) uniform sampler _18;
layout(set = 0, binding = 9) uniform sampler _19;
layout(set = 2, binding = 3) uniform sampler _21;
layout(set = 2, binding = 4) uniform texture2D _22;
layout(set = 2, binding = 5) uniform texture2D _23;
layout(set = 2, binding = 17) uniform texture3D _28;
layout(set = 2, binding = 19) uniform sampler _29;
layout(set = 2, binding = 21) uniform textureCube _31;
layout(set = 2, binding = 22) uniform textureCube _32;
layout(set = 2, binding = 23) uniform textureCube _33;
layout(set = 2, binding = 24) uniform textureCube _34;
layout(set = 2, binding = 25) uniform texture2D _35;
layout(set = 2, binding = 28) uniform texture2D _38;
layout(set = 2, binding = 29) uniform texture2D _39;
layout(set = 2, binding = 30) uniform texture2D _40;
layout(set = 2, binding = 32) uniform textureCube _41[];
layout(set = 2, binding = 32) uniform texture2D _42[];
layout(set = 5, binding = 1) uniform texture2D _44;
layout(set = 5, binding = 2) uniform texture3D _45;
layout(set = 5, binding = 4) uniform texture2D _46;
layout(set = 5, binding = 5) uniform texture2D _47;
layout(set = 1, binding = 2) uniform sampler _50;
layout(set = 1, binding = 3) uniform sampler _51;
layout(set = 1, binding = 4) uniform texture2D _52;
layout(set = 1, binding = 5) uniform texture2D _53;
layout(set = 1, binding = 6) uniform texture2D _54;
layout(set = 1, binding = 7) uniform texture2D _55;
layout(set = 1, binding = 8) uniform texture2D _56;
layout(set = 1, binding = 9) uniform texture2D _57;
layout(set = 1, binding = 10) uniform texture2D _58;

layout(location = 0) in float _4;
layout(location = 1) in vec3 _5;
layout(location = 2) in vec3 _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in vec2 _9;
layout(location = 6) in float _10;
layout(location = 0) out vec4 _11;

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
    vec2 _403 = vec2(_16._m2, _16._m3);
    vec2 _404 = gl_FragCoord.xy * _403;
    vec3 _407 = _5 + _15._m6;
    mat3 _409 = mat3(_8, _6, _7);
    vec3 _411 = normalize(-_5);
    vec4 _417 = texture(sampler2D(_23, _19), _404);
    float _421 = -_4;
    float _427 = clamp(fma(_417.x, _15._m4, _421) / spvNMax(_49._m15, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
    vec4 _432 = texture(sampler2D(_23, _19), _404);
    float _437 = spvNMax(_49._m16, 9.9999997473787516355514526367188e-05);
    float _439 = clamp(fma(_432.x, _15._m4, _421) / _437, 0.0, 1.0);
    float _453 = spvNMax(1.0, 9.9999997473787516355514526367188e-05);
    vec3 _455 = _407 - _15._m6;
    vec3 _465 = _455 * mat3(_15._m0[0].xyz, _15._m0[1].xyz, _15._m0[2].xyz);
    float _466 = _465.z;
    vec3 _473 = vec3(_49._m19);
    vec3 _476 = normalize(normalize(_6) * _409);
    vec2 _483 = (texture(sampler2D(_52, _18), _9).xy - vec2(0.5)) * 0.5;
    vec2 _496 = ((_483 * (mix(0.5, texture(sampler2D(_54, _18), _9).z, _49._m21) * 2.0)) * vec2(-1.0, 1.0)) * _49._m22;
    vec2 _501 = _407.xz;
    vec2 _509 = (_501 * _49._m5) + vec2(_13._m0 * _49._m10);
    vec4 _513 = texture(sampler2D(_53, _50), _509);
    float _514 = _513.x;
    float _518 = fma(_13._m0, _49._m23, _514 * _49._m24);
    float _519 = fract(_518);
    vec2 _533 = (vec3(_14._m1, 0.0, _14._m3).xz * _49._m25) * _13._m0;
    vec4 _537 = texture(sampler2D(_55, _18), fma(_9, _49._m6, _496 * _519) + _533);
    vec3 _540 = (_537.wzy * 2.0) - vec3(1.0);
    vec4 _541 = vec4(_540.x, _540.y, _540.z, _537.x);
    _541.z = -_540.z;
    vec4 _554 = texture(sampler2D(_55, _18), fma(_9, _49._m6, _496 * fract(_518 + 0.5)) + _533);
    vec3 _557 = (_554.wzy * 2.0) - vec3(1.0);
    vec4 _558 = vec4(_557.x, _557.y, _557.z, _554.x);
    _558.z = -_557.z;
    float _572 = _13._m0 * _49._m26;
    float _573 = fma(_514, _49._m24, _572);
    float _574 = fract(_573);
    vec4 _582 = texture(sampler2D(_56, _18), fma(_9, _49._m7, _496 * _574) + _533);
    vec3 _585 = (_582.wzy * 2.0) - vec3(1.0);
    vec4 _586 = vec4(_585.x, _585.y, _585.z, _582.x);
    _586.z = -_585.z;
    vec4 _599 = texture(sampler2D(_56, _18), fma(_9, _49._m7, _496 * fract(_573 + 0.5)) + _533);
    vec3 _602 = (_599.wzy * 2.0) - vec3(1.0);
    vec4 _603 = vec4(_602.x, _602.y, _602.z, _599.x);
    _603.z = -_602.z;
    float _618 = _13._m0 * _49._m27;
    float _619 = fma(_514, _49._m24, _618);
    float _620 = fract(_619);
    vec4 _627 = texture(sampler2D(_55, _18), fma(_9, _49._m8, _496 * _620) + _533);
    vec3 _630 = (_627.wzy * 2.0) - vec3(1.0);
    vec4 _631 = vec4(_630.x, _630.y, _630.z, _627.x);
    _631.z = -_630.z;
    vec4 _644 = texture(sampler2D(_55, _18), fma(_9, _49._m8, _496 * fract(_619 + 0.5)) + _533);
    vec3 _647 = (_644.wzy * 2.0) - vec3(1.0);
    vec4 _648 = vec4(_647.x, _647.y, _647.z, _644.x);
    _648.z = -_647.z;
    vec3 _667 = vec3(_49._m29, _375, _49._m29);
    vec2 _673 = ((((_455 * (((fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _453) + _466) / _466)) + _15._m6) / _473) + (mix(_476, normalize((mix(normalize(_541.xyz).xyz, normalize(_558.xyz).xyz, vec3(abs((_519 + (-0.5)) * 2.0))) + mix(normalize(_586.xyz).xyz, normalize(_603.xyz).xyz, vec3(abs((_574 + (-0.5)) * 2.0)))) + (mix(normalize(_631.xyz).xyz, normalize(_648.xyz).xyz, vec3(abs((_620 + (-0.5)) * 2.0))) * _49._m28)), _667) * _49._m20)).xz;
    float _678 = fma(_13._m0 * _49._m30, 16.0, 0.0) + 9.9999997473787516355514526367188e-06;
    vec2 _680 = vec2(_678, _678 * 0.125);
    vec2 _682 = trunc(_680 - vec2(8.0) * trunc(_680 / vec2(8.0)));
    float _693 = fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _453;
    float _703 = _49._m33 * 2.0;
    float _706 = abs(_49._m31 - _49._m32);
    float _715 = 1.0 - pow(spvNMax(abs(1.0 - clamp(normalize(_411 * _409).y, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 3.0);
    float _720 = -_49._m1;
    vec3 _726 = clamp(texture(sampler2D(_57, _18), (fract(_673) + _682) * vec2(0.125)).xyz * ((clamp((spvNMin(fma(_693, -1.0, _49._m31), _693 - _49._m32) * _703) / _706, 0.0, 1.0) * _715) * clamp(-fma(length(_483), 8.0, _720), 0.0, 1.0)), vec3(0.0), vec3(1.0));
    float _735 = _13._m0 * _49._m34;
    float _736 = fma(_514, _49._m24, _735);
    float _739 = (fract(_736) + (-0.5)) * 2.0;
    float _773 = clamp(fma(pow(spvNMax(abs(mix(vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _496 * _739) + _533).x), vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _496 * ((fract(_736 + 0.5) + (-0.5)) * 2.0)) + _533).x), vec4(abs(_739))).w), 9.9999997473787516355514526367188e-05), _49._m35), _49._m36, fma(spvNMax(fma(_427 - 1.0, 1.0 - _427, 1.0), fma(_439 - 1.0, 1.0 - _439, 1.0) * _49._m17), _49._m18, spvNMax(spvNMax(_726.x, _726.y), _726.z))), 0.0, 1.0);
    float _776 = _773 * _48._m0;
    vec2 _791 = (texture(sampler2D(_52, _18), _9).xy - vec2(0.5)) * 0.5;
    vec2 _799 = ((_791 * (mix(0.5, texture(sampler2D(_54, _18), _9).z, _49._m21) * 2.0)) * vec2(-1.0, 1.0)) * _49._m22;
    vec4 _801 = texture(sampler2D(_53, _50), _509);
    float _802 = _801.x;
    float _804 = fma(_13._m0, _49._m23, _802 * _49._m24);
    float _805 = fract(_804);
    vec4 _810 = texture(sampler2D(_55, _18), fma(_9, _49._m6, _799 * _805) + _533);
    vec3 _813 = (_810.wzy * 2.0) - vec3(1.0);
    vec4 _814 = vec4(_813.x, _813.y, _813.z, _810.x);
    _814.z = -_813.z;
    vec4 _827 = texture(sampler2D(_55, _18), fma(_9, _49._m6, _799 * fract(_804 + 0.5)) + _533);
    vec3 _830 = (_827.wzy * 2.0) - vec3(1.0);
    vec4 _831 = vec4(_830.x, _830.y, _830.z, _827.x);
    _831.z = -_830.z;
    float _843 = fma(_802, _49._m24, _572);
    float _844 = fract(_843);
    vec4 _849 = texture(sampler2D(_56, _18), fma(_9, _49._m7, _799 * _844) + _533);
    vec3 _852 = (_849.wzy * 2.0) - vec3(1.0);
    vec4 _853 = vec4(_852.x, _852.y, _852.z, _849.x);
    _853.z = -_852.z;
    vec4 _866 = texture(sampler2D(_56, _18), fma(_9, _49._m7, _799 * fract(_843 + 0.5)) + _533);
    vec3 _869 = (_866.wzy * 2.0) - vec3(1.0);
    vec4 _870 = vec4(_869.x, _869.y, _869.z, _866.x);
    _870.z = -_869.z;
    float _883 = fma(_802, _49._m24, _618);
    float _884 = fract(_883);
    vec4 _889 = texture(sampler2D(_55, _18), fma(_9, _49._m8, _799 * _884) + _533);
    vec3 _892 = (_889.wzy * 2.0) - vec3(1.0);
    vec4 _893 = vec4(_892.x, _892.y, _892.z, _889.x);
    _893.z = -_892.z;
    vec4 _906 = texture(sampler2D(_55, _18), fma(_9, _49._m8, _799 * fract(_883 + 0.5)) + _533);
    vec3 _909 = (_906.wzy * 2.0) - vec3(1.0);
    vec4 _910 = vec4(_909.x, _909.y, _909.z, _906.x);
    _910.z = -_909.z;
    vec2 _928 = ((((_455 * (((fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _453) + _466) / _466)) + _15._m6) / _473) + (mix(_476, normalize((mix(normalize(_814.xyz).xyz, normalize(_831.xyz).xyz, vec3(abs((_805 + (-0.5)) * 2.0))) + mix(normalize(_853.xyz).xyz, normalize(_870.xyz).xyz, vec3(abs((_844 + (-0.5)) * 2.0)))) + (mix(normalize(_893.xyz).xyz, normalize(_910.xyz).xyz, vec3(abs((_884 + (-0.5)) * 2.0))) * _49._m28)), _667) * _49._m20)).xz;
    vec4 _933 = texture(sampler2D(_57, _18), (fract(_928) + _682) * vec2(0.125));
    float _939 = fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _453;
    vec2 _960 = (texture(sampler2D(_52, _18), _9).xy - vec2(0.5)) * 0.5;
    vec2 _968 = ((_960 * (mix(0.5, texture(sampler2D(_54, _18), _9).z, _49._m21) * 2.0)) * vec2(-1.0, 1.0)) * _49._m22;
    vec4 _970 = texture(sampler2D(_53, _50), _509);
    float _971 = _970.x;
    float _973 = fma(_13._m0, _49._m23, _971 * _49._m24);
    float _974 = fract(_973);
    vec4 _979 = texture(sampler2D(_55, _18), fma(_9, _49._m6, _968 * _974) + _533);
    vec3 _982 = (_979.wzy * 2.0) - vec3(1.0);
    vec4 _983 = vec4(_982.x, _982.y, _982.z, _979.x);
    _983.z = -_982.z;
    vec4 _996 = texture(sampler2D(_55, _18), fma(_9, _49._m6, _968 * fract(_973 + 0.5)) + _533);
    vec3 _999 = (_996.wzy * 2.0) - vec3(1.0);
    vec4 _1000 = vec4(_999.x, _999.y, _999.z, _996.x);
    _1000.z = -_999.z;
    float _1012 = fma(_971, _49._m24, _572);
    float _1013 = fract(_1012);
    vec4 _1018 = texture(sampler2D(_56, _18), fma(_9, _49._m7, _968 * _1013) + _533);
    vec3 _1021 = (_1018.wzy * 2.0) - vec3(1.0);
    vec4 _1022 = vec4(_1021.x, _1021.y, _1021.z, _1018.x);
    _1022.z = -_1021.z;
    vec4 _1035 = texture(sampler2D(_56, _18), fma(_9, _49._m7, _968 * fract(_1012 + 0.5)) + _533);
    vec3 _1038 = (_1035.wzy * 2.0) - vec3(1.0);
    vec4 _1039 = vec4(_1038.x, _1038.y, _1038.z, _1035.x);
    _1039.z = -_1038.z;
    float _1052 = fma(_971, _49._m24, _618);
    float _1053 = fract(_1052);
    vec4 _1058 = texture(sampler2D(_55, _18), fma(_9, _49._m8, _968 * _1053) + _533);
    vec3 _1061 = (_1058.wzy * 2.0) - vec3(1.0);
    vec4 _1062 = vec4(_1061.x, _1061.y, _1061.z, _1058.x);
    _1062.z = -_1061.z;
    vec4 _1075 = texture(sampler2D(_55, _18), fma(_9, _49._m8, _968 * fract(_1052 + 0.5)) + _533);
    vec3 _1078 = (_1075.wzy * 2.0) - vec3(1.0);
    vec4 _1079 = vec4(_1078.x, _1078.y, _1078.z, _1075.x);
    _1079.z = -_1078.z;
    float _1102 = spvNMax(_49._m38, 9.9999997473787516355514526367188e-05);
    float _1105 = fma(_971, _49._m24, _735);
    float _1108 = (fract(_1105) + (-0.5)) * 2.0;
    vec4 _1113 = texture(sampler2D(_58, _18), fma(_501, _49._m9, _968 * _1108) + _533);
    vec3 _1116 = (_1113.wzy * 2.0) - vec3(1.0);
    vec4 _1117 = vec4(_1116.x, _1116.y, _1116.z, _1113.x);
    _1117.z = -_1116.z;
    vec4 _1136 = texture(sampler2D(_58, _18), fma(_501, _49._m9, _968 * ((fract(_1105 + 0.5) + (-0.5)) * 2.0)) + _533);
    vec3 _1139 = (_1136.wzy * 2.0) - vec3(1.0);
    vec4 _1140 = vec4(_1139.x, _1139.y, _1139.z, _1136.x);
    _1140.z = -_1139.z;
    vec4 _1153 = mix(vec4(normalize(_1117.xyz), _1113.x), vec4(normalize(_1140.xyz), _1136.x), vec4(abs(_1108)));
    vec4 _1157 = texture(sampler2D(_54, _18), _9);
    float _1158 = _1157.x;
    float _1182 = -fma(length(_960), 8.0, _720);
    vec3 _1209 = normalize(mix(_476, normalize((mix(normalize(_983.xyz).xyz, normalize(_1000.xyz).xyz, vec3(abs((_974 + (-0.5)) * 2.0))) + mix(normalize(_1022.xyz).xyz, normalize(_1039.xyz).xyz, vec3(abs((_1013 + (-0.5)) * 2.0)))) + (mix(normalize(_1062.xyz).xyz, normalize(_1079.xyz).xyz, vec3(abs((_1053 + (-0.5)) * 2.0))) * _49._m28)), vec3(_49._m29)) + (((vec3(1.0, 0.0, 1.0) * ((clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _1102, 0.0, 1.0) * _1153.w) * fma(1.0 - clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / spvNMax(mix(_49._m39, _49._m40, clamp(_1158 * 2.0, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 0.0, 1.0), _49._m41, fma(_49._m42, clamp(fma(_1158, 2.0, -1.0), 0.0, 1.0), fma(smoothstep(_49._m43, _49._m44, _1182), _49._m45, smoothstep(_49._m46, _49._m47, _1182) * _49._m48))))) * _1153.xyz) * _49._m49));
    vec3 _1211 = normalize(_409 * _1209);
    vec4 _1213 = texture(sampler2D(_23, _19), _404);
    vec2 _1245 = (texture(sampler2D(_52, _18), _9).xy - vec2(0.5)) * 0.5;
    vec2 _1253 = ((_1245 * (mix(0.5, texture(sampler2D(_54, _18), _9).z, _49._m21) * 2.0)) * vec2(-1.0, 1.0)) * _49._m22;
    float _1257 = fma(texture(sampler2D(_53, _50), _509).x, _49._m24, _735);
    float _1260 = (fract(_1257) + (-0.5)) * 2.0;
    vec4 _1285 = texture(sampler2D(_54, _18), _9);
    float _1286 = _1285.x;
    float _1287 = _1286 * 2.0;
    float _1302 = -fma(length(_1245), 8.0, _720);
    float _1312 = abs((clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _1102, 0.0, 1.0) * mix(vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _1253 * _1260) + _533).x), vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _1253 * ((fract(_1257 + 0.5) + (-0.5)) * 2.0)) + _533).x), vec4(abs(_1260))).w) * fma(1.0 - clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / spvNMax(mix(_49._m39, _49._m40, clamp(_1287, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 0.0, 1.0), _49._m41, fma(_49._m42, clamp(fma(_1286, 2.0, -1.0), 0.0, 1.0), fma(smoothstep(_49._m43, _49._m44, _1302), _49._m45, smoothstep(_49._m46, _49._m47, _1302) * _49._m48))));
    float _1318 = clamp(pow(spvNMax(_1312, 9.9999997473787516355514526367188e-05), _49._m52) * _49._m53, 0.0, 1.0);
    vec2 _1337 = (texture(sampler2D(_52, _18), _9).xy - vec2(0.5)) * 0.5;
    vec2 _1345 = ((_1337 * (mix(0.5, texture(sampler2D(_54, _18), _9).z, _49._m21) * 2.0)) * vec2(-1.0, 1.0)) * _49._m22;
    float _1349 = fma(texture(sampler2D(_53, _50), _509).x, _49._m24, _735);
    float _1352 = (fract(_1349) + (-0.5)) * 2.0;
    vec4 _1377 = texture(sampler2D(_54, _18), _9);
    float _1378 = _1377.x;
    float _1394 = -fma(length(_1337), 8.0, _720);
    float _1402 = abs((clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _1102, 0.0, 1.0) * mix(vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _1345 * _1352) + _533).x), vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _1345 * ((fract(_1349 + 0.5) + (-0.5)) * 2.0)) + _533).x), vec4(abs(_1352))).w) * fma(1.0 - clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / spvNMax(mix(_49._m39, _49._m40, clamp(_1378 * 2.0, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 0.0, 1.0), _49._m41, fma(_49._m42, clamp(fma(_1378, 2.0, -1.0), 0.0, 1.0), fma(smoothstep(_49._m43, _49._m44, _1394), _49._m45, smoothstep(_49._m46, _49._m47, _1394) * _49._m48))));
    float _1411 = mix(_49._m55, _49._m56, clamp(pow(spvNMax(_1402, 9.9999997473787516355514526367188e-05), _49._m52) * _49._m53, 0.0, 1.0));
    vec2 _1422 = (texture(sampler2D(_52, _18), _9).xy - vec2(0.5)) * 0.5;
    vec2 _1430 = ((_1422 * (mix(0.5, texture(sampler2D(_54, _18), _9).z, _49._m21) * 2.0)) * vec2(-1.0, 1.0)) * _49._m22;
    float _1434 = fma(texture(sampler2D(_53, _50), _509).x, _49._m24, _735);
    float _1437 = (fract(_1434) + (-0.5)) * 2.0;
    vec4 _1462 = texture(sampler2D(_54, _18), _9);
    float _1463 = _1462.x;
    float _1479 = -fma(length(_1422), 8.0, _720);
    float _1487 = abs((clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _1102, 0.0, 1.0) * mix(vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _1430 * _1437) + _533).x), vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _1430 * ((fract(_1434 + 0.5) + (-0.5)) * 2.0)) + _533).x), vec4(abs(_1437))).w) * fma(1.0 - clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / spvNMax(mix(_49._m39, _49._m40, clamp(_1463 * 2.0, 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 0.0, 1.0), _49._m41, fma(_49._m42, clamp(fma(_1463, 2.0, -1.0), 0.0, 1.0), fma(smoothstep(_49._m43, _49._m44, _1479), _49._m45, smoothstep(_49._m46, _49._m47, _1479) * _49._m48))));
    float _1496 = mix(_49._m57, _49._m58, clamp(pow(spvNMax(_1487, 9.9999997473787516355514526367188e-05), _49._m52) * _49._m53, 0.0, 1.0));
    vec3 _1499 = mix(mix(_49._m0, _49._m2, vec3(clamp(1.0 - pow(spvNMax(abs(1.0 - clamp(fma(_1213.x, _15._m4, _421) / spvNMax(_49._m50, 9.9999997473787516355514526367188e-05), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _49._m51), 0.0, 1.0))), _49._m4, vec3(mix(_1318, _1287 * _1318, _49._m54))) * 1.0;
    vec3 _1502 = vec3(0.1599999964237213134765625 * (_1411 * _1411));
    vec3 _1503 = dFdx(_1211);
    vec3 _1504 = dFdy(_1211);
    float _1512 = spvNMax(0.0900000035762786865234375, sqrt(clamp(fma(_1496, _1496, spvNMin(dot(_1503, _1503) + dot(_1504, _1504), 0.180000007152557373046875)), 0.0, 1.0)));
    ivec2 _1520 = ivec2(uvec2(gl_FragCoord.xy) / uvec2(_36._m25));
    vec3 _2094;
    vec3 _2095;
    vec3 _2096;
    SPIRV_CROSS_BRANCH
    if (_14._m19 > 0.0)
    {
        vec3 _1554 = vec3(0.0, 636100.0, 0.0) + _15._m6;
        float _1555 = length(_1554);
        bool _1559 = _1555 < (0.89999997615814208984375 * _43._m0);
        vec3 _1566;
        float _1567;
        if (_1559)
        {
            vec3 _1564 = _1554;
            _1564.z = _1554.z + _43._m0;
            _1566 = _1564;
            _1567 = length(_1564);
        }
        else
        {
            _1566 = _1554;
            _1567 = _1555;
        }
        float _1570 = dot(_1566 / vec3(_1567), _14._m36);
        float _1571 = _43._m0 / _1567;
        vec3 _1595 = vec3(0.0, 636100.0, 0.0) + _407;
        float _1596 = length(_1595);
        vec3 _1600 = (_1595 / vec3(_1596)) * spvNMax(_1596, 636100.0);
        vec3 _1601 = _1600 - _1554;
        float _1602 = length(_1601);
        vec3 _1604 = _1601 / vec3(_1602);
        vec3 _1614;
        vec3 _1615;
        float _1616;
        if (_1559)
        {
            vec3 _1609 = _1554;
            _1609.z = _1554.z + _43._m0;
            vec3 _1612 = _1600;
            _1612.z = _1600.z + _43._m0;
            _1614 = _1612;
            _1615 = _1609;
            _1616 = length(_1609);
        }
        else
        {
            _1614 = _1600;
            _1615 = _1554;
            _1616 = _1555;
        }
        float _1617 = dot(_1615, _1604);
        float _1626 = spvNMax((-_1617) - sqrt(fma(_43._m1, _43._m1, fma(_1617, _1617, -(_1616 * _1616)))), 0.0);
        bool _1629 = (_1626 > 0.0) && (_1626 < _1602);
        vec3 _1637;
        float _1638;
        float _1639;
        if (_1629)
        {
            _1637 = _1615 + (_1604 * _1626);
            _1638 = _1602 - _1626;
            _1639 = (_1617 + _1626) / _43._m1;
        }
        else
        {
            _1637 = _1615;
            _1638 = _1602;
            _1639 = _1617 / _1616;
        }
        float _1640 = _1629 ? _43._m1 : _1616;
        vec3 _2077;
        vec3 _2078;
        if (_1640 <= _43._m1)
        {
            float _1645 = dot(_1604, _14._m36);
            float _1647 = dot(_1637, _14._m36) / _1640;
            float _1648 = _43._m0 + 600.0;
            bool _1649 = _1640 < _1648;
            vec3 _1654;
            if (_1649)
            {
                _1654 = _1614 * (_1648 / _1640);
            }
            else
            {
                _1654 = _1614;
            }
            float _1655 = _1649 ? _1648 : _1640;
            float _1656 = length(_1654);
            float _1657 = dot(_1654, _1604);
            float _1659 = dot(_1654, _14._m36) / _1656;
            vec2 _1670 = vec2(_1639, _1639 + (_1638 / _1655));
            vec2 _1671 = _1670 * sqrt((0.5 / _43._m4) * _1655);
            vec2 _1674 = vec2(ivec2(sign(_1671)));
            vec2 _1675 = _1671 * _1671;
            float _1689 = -_1638;
            float _1691 = 2.0 * _1655;
            float _1693 = (_1638 / _1691) + _1639;
            float _1701 = _43._m0 - _1655;
            vec2 _1716 = _1670 * sqrt((0.5 / _43._m6) * _1655);
            vec2 _1719 = vec2(ivec2(sign(_1716)));
            vec2 _1720 = _1716 * _1716;
            vec3 _1750 = exp(((-_43._m5) * ((sqrt((6.283100128173828125 * _43._m4) * _1655) * exp(_1701 / _43._m4)) * (((_1674.y > _1674.x) ? exp(_1675.x) : 0.0) + dot((_1674 / ((abs(_1671) * 2.3192999362945556640625) + sqrt((_1675 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1689 / _43._m4) * _1693)), vec2(1.0, -1.0))))) - (_43._m8 * ((sqrt((6.283100128173828125 * _43._m6) * _1655) * exp(_1701 / _43._m6)) * (((_1719.y > _1719.x) ? exp(_1720.x) : 0.0) + dot((_1719 / ((abs(_1716) * 2.3192999362945556640625) + sqrt((_1720 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1689 / _43._m6) * _1693)), vec2(1.0, -1.0))))));
            vec3 _1751 = spvNMin(_1750, vec3(1.0));
            float _1752 = _43._m0 / _1655;
            float _1755 = sqrt(fma(-_1752, _1752, 1.0));
            float _1757 = _1639 - (-_1755);
            vec4 _2040;
            if (abs(_1757) < 0.0040000001899898052215576171875)
            {
                float _1865 = (-0.0040000001899898052215576171875) - _1755;
                float _1867 = fma(_1655, _1655, _1638 * _1638);
                float _1868 = _1691 * _1638;
                float _1870 = sqrt(fma(_1868, _1865, _1867));
                float _1871 = fma(_1655, _1865, _1638);
                float _1874 = -(_43._m0 * _43._m0);
                float _1876 = sqrt(fma(_43._m1, _43._m1, _1874));
                float _1878 = sqrt(fma(_1655, _1655, _1874));
                float _1879 = _1655 * _1865;
                float _1881 = -(_1655 * _1655);
                float _1883 = fma(_43._m0, _43._m0, fma(_1879, _1879, _1881));
                vec4 _1889 = vec4(-1.0, _1876 * _1876, _1876, 0.50390625);
                vec4 _1890 = mix(_1889, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1879 < 0.0) && (_1883 > 0.0)));
                float _1892 = fma(_1878 / _1876, 0.96875, 0.015625);
                float _1902 = fma(fma(_1879, _1890.x, sqrt(_1883 + _1890.y)) / (_1878 + _1890.z), 0.4921875, _1890.w);
                float _1908 = _1645 + 1.0;
                float _1910 = floor(_1908 * 3.5);
                float _1912 = fma(_1908, 3.5, -_1910);
                float _1913 = _1910 + fma(fma(atan(spvNMax(_1647, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1914 = _1913 * 0.125;
                float _1918 = 1.0 - _1912;
                float _1921 = (_1913 + 1.0) * 0.125;
                float _1928 = sqrt(fma(_1870, _1870, _1874));
                float _1932 = fma(_43._m0, _43._m0, fma(_1871, _1871, -(_1870 * _1870)));
                vec4 _1937 = mix(_1889, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1871 < 0.0) && (_1932 > 0.0)));
                float _1939 = fma(_1928 / _1876, 0.96875, 0.015625);
                float _1949 = fma(fma(_1871, _1937.x, sqrt(_1932 + _1937.y)) / (_1928 + _1937.z), 0.4921875, _1937.w);
                float _1955 = _1910 + fma(fma(atan(spvNMax(_1659, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1956 = _1955 * 0.125;
                float _1962 = (_1955 + 1.0) * 0.125;
                vec4 _1968 = _1751.xyzx;
                float _1972 = 0.0040000001899898052215576171875 - _1755;
                float _1974 = sqrt(fma(_1868, _1972, _1867));
                float _1975 = fma(_1655, _1972, _1638);
                float _1976 = _1655 * _1972;
                float _1978 = fma(_43._m0, _43._m0, fma(_1976, _1976, _1881));
                vec4 _1983 = mix(_1889, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1976 < 0.0) && (_1978 > 0.0)));
                float _1993 = fma(fma(_1976, _1983.x, sqrt(_1978 + _1983.y)) / (_1878 + _1983.z), 0.4921875, _1983.w);
                float _2004 = sqrt(fma(_1974, _1974, _1874));
                float _2008 = fma(_43._m0, _43._m0, fma(_1975, _1975, -(_1974 * _1974)));
                vec4 _2013 = mix(_1889, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1975 < 0.0) && (_2008 > 0.0)));
                float _2015 = fma(_2004 / _1876, 0.96875, 0.015625);
                float _2025 = fma(fma(_1975, _2013.x, sqrt(_2008 + _2013.y)) / (_2004 + _2013.z), 0.4921875, _2013.w);
                _2040 = mix(spvNMax(fma(-((textureLod(sampler3D(_45, _21), vec3(_1956, _1949, _1939), 0.0) * _1918) + (textureLod(sampler3D(_45, _21), vec3(_1962, _1949, _1939), 0.0) * _1912)), _1968, (textureLod(sampler3D(_45, _21), vec3(_1914, _1902, _1892), 0.0) * _1918) + (textureLod(sampler3D(_45, _21), vec3(_1921, _1902, _1892), 0.0) * _1912)), vec4(0.0)), spvNMax(fma(-((textureLod(sampler3D(_45, _21), vec3(_1956, _2025, _2015), 0.0) * _1918) + (textureLod(sampler3D(_45, _21), vec3(_1962, _2025, _2015), 0.0) * _1912)), _1968, (textureLod(sampler3D(_45, _21), vec3(_1914, _1993, _1892), 0.0) * _1918) + (textureLod(sampler3D(_45, _21), vec3(_1921, _1993, _1892), 0.0) * _1912)), vec4(0.0)), vec4((_1757 + 0.0040000001899898052215576171875) * 124.99999237060546875));
            }
            else
            {
                float _1765 = -(_43._m0 * _43._m0);
                float _1767 = sqrt(fma(_43._m1, _43._m1, _1765));
                float _1769 = sqrt(fma(_1655, _1655, _1765));
                float _1770 = _1655 * _1639;
                float _1774 = fma(_43._m0, _43._m0, fma(_1770, _1770, -(_1655 * _1655)));
                vec4 _1780 = vec4(-1.0, _1767 * _1767, _1767, 0.50390625);
                vec4 _1781 = mix(_1780, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1770 < 0.0) && (_1774 > 0.0)));
                float _1783 = fma(_1769 / _1767, 0.96875, 0.015625);
                float _1793 = fma(fma(_1770, _1781.x, sqrt(_1774 + _1781.y)) / (_1769 + _1781.z), 0.4921875, _1781.w);
                float _1799 = _1645 + 1.0;
                float _1801 = floor(_1799 * 3.5);
                float _1803 = fma(_1799, 3.5, -_1801);
                float _1804 = _1801 + fma(fma(atan(spvNMax(_1647, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1809 = 1.0 - _1803;
                float _1819 = sqrt(fma(_1656, _1656, _1765));
                float _1823 = fma(_43._m0, _43._m0, fma(_1657, _1657, -(_1656 * _1656)));
                vec4 _1828 = mix(_1780, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1657 < 0.0) && (_1823 > 0.0)));
                float _1830 = fma(_1819 / _1767, 0.96875, 0.015625);
                float _1840 = fma(fma(_1657, _1828.x, sqrt(_1823 + _1828.y)) / (_1819 + _1828.z), 0.4921875, _1828.w);
                float _1846 = _1801 + fma(fma(atan(spvNMax(_1659, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                _2040 = spvNMax(fma(-((textureLod(sampler3D(_45, _21), vec3(_1846 * 0.125, _1840, _1830), 0.0) * _1809) + (textureLod(sampler3D(_45, _21), vec3((_1846 + 1.0) * 0.125, _1840, _1830), 0.0) * _1803)), _1751.xyzx, (textureLod(sampler3D(_45, _21), vec3(_1804 * 0.125, _1793, _1783), 0.0) * _1809) + (textureLod(sampler3D(_45, _21), vec3((_1804 + 1.0) * 0.125, _1793, _1783), 0.0) * _1803)), vec4(0.0));
            }
            float _2055 = fma(_1645, _1645, 1.0);
            _2077 = _1751;
            _2078 = (_2040.xyz * (0.0596831031143665313720703125 * _2055)) + ((((_2040.xyz * (_2040.w * smoothstep(0.0, 0.0199999995529651641845703125, _1647))) / vec3(spvNMax(_2040.x, 9.9999997473787516355514526367188e-05))) * (vec3(_43._m5.x) / _43._m5)) * ((((0.119366206228733062744140625 * fma(-_43._m9, _43._m9, 1.0)) * (-pow(spvNMax(abs(abs(fma(_43._m9 * (-2.0), _1645, fma(_43._m9, _43._m9, 1.0)))), 9.9999997473787516355514526367188e-05), 1.5))) * _2055) / fma(_43._m9, _43._m9, 2.0)));
        }
        else
        {
            _2077 = vec3(1.0);
            _2078 = vec3(0.0);
        }
        vec3 _2093;
        if (_14._m35 == 0.0)
        {
            _2093 = ((mix(textureLod(sampler2D(_44, _21), vec2(atan((_1570 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_1567 - _43._m0) / (_43._m1 - _43._m0))), 0.0).xyz, vec3(0.0), bvec3(_1570 < (-sqrt(fma(-_1571, _1571, 1.0))))) * 1.0) * _14._m34) * _14._m20;
        }
        else
        {
            _2093 = _14._m2;
        }
        _2094 = _2078 * (_14._m19 * 10.0);
        _2095 = _2077;
        _2096 = _2093;
    }
    else
    {
        _2094 = vec3(0.0);
        _2095 = vec3(1.0);
        _2096 = _14._m2;
    }
    float _2179;
    SPIRV_CROSS_BRANCH
    if (_14._m21 > 0.0)
    {
        vec3 _2119 = _15._m6 + _5;
        vec3 _2126 = vec3(0.0, _14._m18.z, 0.0) + (_2119 - vec3(0.0, _14._m25, 0.0));
        float _2130 = dot(_2126, _14._m24);
        vec2 _2140 = ((((_2126 + (_14._m24 * (sqrt(fma(_2130, _2130, fma(_14._m18.z, _14._m18.z, -dot(_2126, _2126)))) - _2130))).xz * _14._m18.w) * 0.5) + vec2(0.5)) + _14._m18.xy;
        _2140.x = 1.0 - _2140.x;
        vec3 _2153 = vec3(0.0, _14._m23.z, 0.0) + (_2119 - vec3(0.0, _14._m27, 0.0));
        float _2157 = dot(_2153, _14._m26);
        vec2 _2167 = ((((_2153 + (_14._m26 * (sqrt(fma(_2157, _2157, fma(_14._m23.z, _14._m23.z, -dot(_2153, _2153)))) - _2157))).xz * _14._m23.w) * 0.5) + vec2(0.5)) + _14._m23.xy;
        _2167.x = 1.0 - _2167.x;
        _2179 = 1.0 - clamp(smoothstep(0.0500000007450580596923828125, 0.550000011920928955078125, mix(textureLod(sampler2D(_46, _21), _2140, 0.0).x, textureLod(sampler2D(_47, _21), _2167, 0.0).x, _14._m16)) * _14._m21, 0.0, 1.0);
    }
    else
    {
        _2179 = 1.0;
    }
    float _2268;
    SPIRV_CROSS_BRANCH
    if (_14._m17 > 0.0)
    {
        vec3 _2206 = _15._m6 + _5;
        vec3 _2214 = vec3(0.0, _14._m28.z, 0.0) + ((_14._m29 + _2206) - vec3(0.0, _14._m30, 0.0));
        float _2218 = dot(_2214, _14._m24);
        vec2 _2228 = ((((_2214 + (_14._m24 * (sqrt(fma(_2218, _2218, fma(_14._m28.z, _14._m28.z, -dot(_2214, _2214)))) - _2218))).xz * _14._m28.w) * 0.5) + vec2(0.5)) + _14._m28.xy;
        _2228.x = 1.0 - _2228.x;
        vec3 _2242 = vec3(0.0, _14._m31.z, 0.0) + ((_14._m32 + _2206) - vec3(0.0, _14._m33, 0.0));
        float _2246 = dot(_2242, _14._m26);
        vec2 _2256 = ((((_2242 + (_14._m26 * (sqrt(fma(_2246, _2246, fma(_14._m31.z, _14._m31.z, -dot(_2242, _2242)))) - _2246))).xz * _14._m31.w) * 0.5) + vec2(0.5)) + _14._m31.xy;
        _2256.x = 1.0 - _2256.x;
        _2268 = _2179 * (1.0 - clamp(mix(textureLod(sampler2D(_39, _21), _2228, 0.0).x, textureLod(sampler2D(_40, _21), _2256, 0.0).x, _14._m16) * _14._m17, 0.0, 1.0));
    }
    else
    {
        _2268 = _2179;
    }
    float _2275 = fract(52.98291778564453125 * fract(fma(0.067110560834407806396484375, gl_FragCoord.x, 0.005837149918079376220703125 * gl_FragCoord.y)));
    float _2282 = clamp(fma(_36._m34.y, length(_5), _36._m34.x), 0.0, 1.0);
    uint _2283 = uint(int(fma(fma(float(int(clamp(fma(log2(_4), _36._m21, _36._m22), 0.0, float(_36._m26)))), _36._m24, float(_1520.y)), _36._m23, float(_1520.x))));
    uvec4 _2286 = uvec4(_24._m0[_2283]);
    uint _2287 = _2286.x;
    uint _2288 = _2286.y;
    uint _2291 = ((_2288 >> 0u) & 4095u) + _2287;
    uint _2294 = ((_2288 >> 12u) & 4095u) + _2291;
    uint _2298 = ((_2286.z >> 0u) & 1023u) + _2294;
    float _2300 = spvNMax(dot(_1211, _411), 9.9999997473787516355514526367188e-06);
    float _2302;
    bool _2305;
    vec3 _2307;
    vec3 _2309;
    uint _2311;
    _2302 = _340;
    _2305 = false;
    _2307 = vec3(0.0);
    _2309 = vec3(0.0);
    _2311 = _2287;
    float _2303;
    bool _2306;
    vec3 _2308;
    vec3 _2310;
    for (; _2311 < _2291; _2302 = _2303, _2305 = _2306, _2307 = _2308, _2309 = _2310, _2311++)
    {
        uint _2318 = uint(_25._m0[_2311]);
        float _2336 = abs(_26._m0[_2318]._m5);
        if ((_26._m0[_2318]._m6 & (1u << (_48._m1 & 31u))) != 0u)
        {
            vec3 _2351 = _26._m0[_2318]._m0.xyz - _5;
            float _2352 = dot(_2351, _2351);
            vec3 _2355 = _2351 * inversesqrt(spvNMax(_2352, 1.0000000133514319600180897396058e-10));
            float _2356 = _26._m0[_2318]._m0.w * _26._m0[_2318]._m0.w;
            float _2594;
            bool _2595;
            vec3 _2596;
            vec3 _2597;
            if (_2352 < (1.0 / _2356))
            {
                vec3 _2361 = _411 + _2355;
                vec3 _2365 = _2361 * inversesqrt(spvNMax(dot(_2361, _2361), 1.0000000133514319600180897396058e-10));
                float _2367 = clamp(dot(_2355, _2365), 0.0, 1.0);
                float _2369 = clamp(dot(_1211, _2365), 0.0, 1.0);
                float _2371 = clamp(dot(_1211, _2355), 0.0, 1.0);
                float _2372 = _2352 * _2356;
                float _2378 = pow(spvNMax(abs(clamp(fma(-_2372, _2372, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _26._m0[_2318]._m4);
                float _2388;
                if (_26._m0[_2318]._m5 < 0.0)
                {
                    _2388 = _2378 * fma(4.0, _2356, _2336);
                }
                else
                {
                    _2388 = _2378 * ((1.0 / spvNMax(_2352, 9.9999997473787516355514526367188e-05)) + _2336);
                }
                float _2390 = 0.079577468335628509521484375 * (_2371 * _2388);
                float _2525;
                bool _2526;
                float _2527;
                if ((_26._m0[_2318]._m7 & 1u) != 0u)
                {
                    uint _2415;
                    do
                    {
                        vec3 _2395 = -_2355;
                        float _2396 = dot(_2395, vec3(0.0, -0.57735025882720947265625, 0.8164966106414794921875));
                        float _2397 = dot(_2395, vec3(0.0, -0.57735025882720947265625, -0.8164966106414794921875));
                        float _2398 = dot(_2395, vec3(-0.8164966106414794921875, 0.57735025882720947265625, 0.0));
                        float _2402 = spvNMax(spvNMax(_2396, _2397), spvNMax(_2398, dot(_2395, vec3(0.8164966106414794921875, 0.57735025882720947265625, 0.0))));
                        if (_2402 == _2396)
                        {
                            _2415 = 0u;
                            break;
                        }
                        else
                        {
                            if (_2402 == _2397)
                            {
                                _2415 = 1u;
                                break;
                            }
                            else
                            {
                                if (_2402 == _2398)
                                {
                                    _2415 = 2u;
                                    break;
                                }
                                else
                                {
                                    _2415 = 3u;
                                    break;
                                }
                                break; // unreachable workaround
                            }
                            break; // unreachable workaround
                        }
                        break; // unreachable workaround
                    } while(false);
                    uint _2417 = uint(int(_26._m0[_2318]._m7 >> 2u)) + _2415;
                    float _2519;
                    bool _2520;
                    float _2521;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2371 <= 0.0) && true)
                        {
                            _2519 = _2302;
                            _2520 = _2305;
                            _2521 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2450 = _37._m0[_2417]._m0 * vec4(_5 + (_1211 * ((3.5 * float(int(sign(_2371)))) * (_37._m0[_2417]._m4 * sqrt(_2352)))), 1.0);
                            vec3 _2454 = _2450.xyz / vec3(_2450.w);
                            vec2 _2457 = (_2454.xy * 0.5) + vec2(0.5);
                            _2457.y = 1.0 - _2457.y;
                            float _2466 = (_37._m0[_2417]._m5.y / _37._m0[_2417]._m6) / (_2454.z - _37._m0[_2417]._m5.x);
                            float _2471 = _2305 ? _2302 : 6.283185482025146484375;
                            float _2472 = _2275 * _2471;
                            vec2 _2473 = _37._m0[_2417]._m1 + _36._m33;
                            vec2 _2476 = (_37._m0[_2417]._m1 + vec2(_37._m0[_2417]._m2)) - _36._m33;
                            float _2478;
                            _2478 = 0.0;
                            for (int _2481 = 0; _2481 < 12; )
                            {
                                float _2486 = float(uint(_2481));
                                float _2489 = sqrt(_2486 + 0.5) * 0.288675129413604736328125;
                                float _2490 = fma(_2486, 2.3999631404876708984375, _2472);
                                vec2 _2498 = clamp(fma((vec3(cos(_2490), sin(_2490), _2489).xy * _2489) * 2.5, _36._m33, _2457), _2473, _2476);
                                vec2 _2501 = fract(fma(vec2(1.0) / _36._m33, _2498, vec2(0.5)));
                                vec4 _2507 = vec4(lessThan(vec4(_2466), textureGather(sampler2D(_38, _29), _2498)));
                                float _2510 = _2501.x;
                                _2478 += clamp(mix(mix(_2507.w, _2507.z, _2510), mix(_2507.x, _2507.y, _2510), _2501.y), 0.0, 1.0);
                                _2481++;
                                continue;
                            }
                            _2519 = _2471;
                            _2520 = _2305 ? _2305 : true;
                            _2521 = _2478 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2525 = _2519;
                    _2526 = _2520;
                    _2527 = _2390 * mix(1.0, _2521, spvNMin(_2282, _26._m0[_2318]._m8));
                }
                else
                {
                    _2525 = _2302;
                    _2526 = _2305;
                    _2527 = _2390;
                }
                vec3 _2592;
                vec3 _2593;
                if (_2371 > 0.0)
                {
                    vec3 _2533 = _26._m0[_2318]._m1.xyz * (_2527 * ((_26._m0[_2318]._m3 < 0.0) ? _20._m0[0u] : 1.0));
                    vec3 _2540 = vec3(fma((2.0 * _2367) * _2367, _1512, mix(0.0, 0.5, _1512))) - vec3(1.0);
                    float _2561 = (_1512 + 1.0) * 0.5;
                    float _2562 = _1512 * _1512;
                    float _2570 = _2561 * _2561;
                    float _2582 = _2562 * _2562;
                    float _2585 = fma(fma(_2369, _2582, -_2369), _2369, 1.0);
                    _2592 = fma(_2533, (_1502 + ((vec3(1.0) - _1502) * pow(spvNMax(abs(1.0 - _2367), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2371, sqrt(fma(fma(-_2300, _2570, _2300), _2300, _2570)), _2300 * sqrt(fma(fma(-_2371, _2570, _2371), _2371, _2570)))) * (_2582 * (0.3183098733425140380859375 / (_2585 * _2585)))), _2307);
                    _2593 = fma(_2533, _1499 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2540 * pow(spvNMax(abs(1.0 - _2371), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2540 * pow(spvNMax(abs(1.0 - _2300), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1512))), _2309);
                }
                else
                {
                    _2592 = _2307;
                    _2593 = _2309;
                }
                _2594 = _2525;
                _2595 = _2526;
                _2596 = _2592;
                _2597 = _2593;
            }
            else
            {
                _2594 = _2302;
                _2595 = _2305;
                _2596 = _2307;
                _2597 = _2309;
            }
            _2303 = _2594;
            _2306 = _2595;
            _2308 = _2596;
            _2310 = _2597;
        }
        else
        {
            _2303 = _2302;
            _2306 = _2305;
            _2308 = _2307;
            _2310 = _2309;
        }
    }
    float _2599;
    bool _2602;
    vec3 _2604;
    vec3 _2606;
    uint _2608;
    _2599 = _2302;
    _2602 = _2305;
    _2604 = _2307;
    _2606 = _2309;
    _2608 = _2311;
    float _2600;
    bool _2603;
    vec3 _2605;
    vec3 _2607;
    for (; _2608 < _2294; _2599 = _2600, _2602 = _2603, _2604 = _2605, _2606 = _2607, _2608++)
    {
        uint _2615 = uint(_25._m0[_2608]);
        float _2628 = abs(_26._m0[_2615]._m5);
        if ((_26._m0[_2615]._m6 & (1u << (_48._m1 & 31u))) != 0u)
        {
            vec3 _2646 = _26._m0[_2615]._m0.xyz - _5;
            float _2647 = dot(_2646, _2646);
            vec3 _2650 = _2646 * inversesqrt(spvNMax(_2647, 1.0000000133514319600180897396058e-10));
            float _2651 = _26._m0[_2615]._m0.w * _26._m0[_2615]._m0.w;
            float _2879;
            bool _2880;
            vec3 _2881;
            vec3 _2882;
            if (_2647 < (1.0 / _2651))
            {
                vec3 _2656 = _411 + _2650;
                vec3 _2660 = _2656 * inversesqrt(spvNMax(dot(_2656, _2656), 1.0000000133514319600180897396058e-10));
                float _2662 = clamp(dot(_2650, _2660), 0.0, 1.0);
                float _2664 = clamp(dot(_1211, _2660), 0.0, 1.0);
                float _2666 = clamp(dot(_1211, _2650), 0.0, 1.0);
                float _2669 = dot(-_2650, normalize(_26._m0[_2615]._m2.xyz));
                float _2698;
                if (_2669 > _26._m0[_2615]._m1.w)
                {
                    float _2673 = _2647 * _2651;
                    float _2679 = pow(spvNMax(abs(clamp(fma(-_2673, _2673, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _26._m0[_2615]._m4);
                    float _2689;
                    if (_26._m0[_2615]._m5 < 0.0)
                    {
                        _2689 = _2679 * fma(4.0, _2651, _2628);
                    }
                    else
                    {
                        _2689 = _2679 * ((1.0 / spvNMax(_2647, 9.9999997473787516355514526367188e-05)) + _2628);
                    }
                    float _2694 = clamp((_2669 - _26._m0[_2615]._m1.w) / spvNMax(_26._m0[_2615]._m2.w - _26._m0[_2615]._m1.w, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
                    _2698 = _2666 * (_2689 * (_2694 * _2694));
                }
                else
                {
                    _2698 = 0.0;
                }
                float _2699 = 0.3183098733425140380859375 * _2698;
                float _2810;
                bool _2811;
                float _2812;
                if ((_26._m0[_2615]._m7 & 1u) != 0u)
                {
                    uint _2702 = uint(int(_26._m0[_2615]._m7 >> 2u));
                    float _2804;
                    bool _2805;
                    float _2806;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2666 <= 0.0) && true)
                        {
                            _2804 = _2599;
                            _2805 = _2602;
                            _2806 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2735 = _37._m0[_2702]._m0 * vec4(_5 + (_1211 * ((3.5 * float(int(sign(_2666)))) * (_37._m0[_2702]._m4 * sqrt(_2647)))), 1.0);
                            vec3 _2739 = _2735.xyz / vec3(_2735.w);
                            vec2 _2742 = (_2739.xy * 0.5) + vec2(0.5);
                            _2742.y = 1.0 - _2742.y;
                            float _2751 = (_37._m0[_2702]._m5.y / _37._m0[_2702]._m6) / (_2739.z - _37._m0[_2702]._m5.x);
                            float _2756 = _2602 ? _2599 : 6.283185482025146484375;
                            float _2757 = _2275 * _2756;
                            vec2 _2758 = _37._m0[_2702]._m1 + _36._m33;
                            vec2 _2761 = (_37._m0[_2702]._m1 + vec2(_37._m0[_2702]._m2)) - _36._m33;
                            float _2763;
                            _2763 = 0.0;
                            for (int _2766 = 0; _2766 < 12; )
                            {
                                float _2771 = float(uint(_2766));
                                float _2774 = sqrt(_2771 + 0.5) * 0.288675129413604736328125;
                                float _2775 = fma(_2771, 2.3999631404876708984375, _2757);
                                vec2 _2783 = clamp(fma((vec3(cos(_2775), sin(_2775), _2774).xy * _2774) * 2.5, _36._m33, _2742), _2758, _2761);
                                vec2 _2786 = fract(fma(vec2(1.0) / _36._m33, _2783, vec2(0.5)));
                                vec4 _2792 = vec4(lessThan(vec4(_2751), textureGather(sampler2D(_38, _29), _2783)));
                                float _2795 = _2786.x;
                                _2763 += clamp(mix(mix(_2792.w, _2792.z, _2795), mix(_2792.x, _2792.y, _2795), _2786.y), 0.0, 1.0);
                                _2766++;
                                continue;
                            }
                            _2804 = _2756;
                            _2805 = _2602 ? _2602 : true;
                            _2806 = _2763 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2810 = _2804;
                    _2811 = _2805;
                    _2812 = _2699 * mix(1.0, _2806, spvNMin(_2282, _26._m0[_2615]._m8));
                }
                else
                {
                    _2810 = _2599;
                    _2811 = _2602;
                    _2812 = _2699;
                }
                vec3 _2877;
                vec3 _2878;
                if (_2666 > 0.0)
                {
                    vec3 _2818 = _26._m0[_2615]._m1.xyz * (_2812 * ((_26._m0[_2615]._m3 < 0.0) ? _20._m0[0u] : 1.0));
                    vec3 _2825 = vec3(fma((2.0 * _2662) * _2662, _1512, mix(0.0, 0.5, _1512))) - vec3(1.0);
                    float _2846 = (_1512 + 1.0) * 0.5;
                    float _2847 = _1512 * _1512;
                    float _2855 = _2846 * _2846;
                    float _2867 = _2847 * _2847;
                    float _2870 = fma(fma(_2664, _2867, -_2664), _2664, 1.0);
                    _2877 = fma(_2818, (_1502 + ((vec3(1.0) - _1502) * pow(spvNMax(abs(1.0 - _2662), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2666, sqrt(fma(fma(-_2300, _2855, _2300), _2300, _2855)), _2300 * sqrt(fma(fma(-_2666, _2855, _2666), _2666, _2855)))) * (_2867 * (0.3183098733425140380859375 / (_2870 * _2870)))), _2604);
                    _2878 = fma(_2818, _1499 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2825 * pow(spvNMax(abs(1.0 - _2666), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2825 * pow(spvNMax(abs(1.0 - _2300), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1512))), _2606);
                }
                else
                {
                    _2877 = _2604;
                    _2878 = _2606;
                }
                _2879 = _2810;
                _2880 = _2811;
                _2881 = _2877;
                _2882 = _2878;
            }
            else
            {
                _2879 = _2599;
                _2880 = _2602;
                _2881 = _2604;
                _2882 = _2606;
            }
            _2600 = _2879;
            _2603 = _2880;
            _2605 = _2881;
            _2607 = _2882;
        }
        else
        {
            _2600 = _2599;
            _2603 = _2602;
            _2605 = _2604;
            _2607 = _2606;
        }
    }
    vec3 _2889;
    vec3 _2891;
    _2889 = _2604;
    _2891 = _2606;
    float _2885;
    bool _2888;
    vec3 _2890;
    vec3 _2892;
    float _2884 = _2599;
    bool _2887 = _2602;
    uint _2893 = _2608;
    for (; _2893 < _2298; _2884 = _2885, _2887 = _2888, _2889 = _2890, _2891 = _2892, _2893++)
    {
        uint _2900 = uint(_25._m0[_2893]);
        int _2929 = int(_27._m0[_2900]._m1 >> 1u) - 1;
        if (((_27._m0[_2900]._m4 & 16777215u) & (1u << (_48._m1 & 31u))) != 0u)
        {
            vec3 _2940 = _27._m0[_2900]._m6 * vec4(_5, 1.0);
            float _3328;
            bool _3329;
            vec3 _3330;
            vec3 _3331;
            if (all(lessThan(abs(_2940 - vec3(0.5)), vec3(0.5))))
            {
                vec3 _2947 = _411 + _27._m0[_2900]._m9;
                vec3 _2951 = _2947 * inversesqrt(spvNMax(dot(_2947, _2947), 1.0000000133514319600180897396058e-10));
                float _2953 = clamp(dot(_27._m0[_2900]._m9, _2951), 0.0, 1.0);
                float _2955 = clamp(dot(_1211, _2951), 0.0, 1.0);
                float _2957 = clamp(dot(_1211, _27._m0[_2900]._m9), 0.0, 1.0);
                int _2958 = int(_27._m0[_2900]._m4 >> 24u);
                float _2959 = _2940.z;
                vec3 _2998;
                if (_2959 < _27._m0[_2900]._m2.x)
                {
                    float _2986 = _2959 * _27._m0[_2900]._m2.z;
                    float _2989 = _2986 * _2986;
                    vec3 _2997;
                    _2997.z = dot(_356[_2958], vec4(_2986, _2989, smoothstep(0.0, 1.0, _2986), (_2989 * _2986) * fma(_2986, fma(_2986, 6.0, -15.0), 10.0)));
                    _2998 = _2997;
                }
                else
                {
                    vec3 _2984;
                    if (_2959 > _27._m0[_2900]._m2.y)
                    {
                        float _2972 = (1.0 - _2959) * _27._m0[_2900]._m2.w;
                        float _2975 = _2972 * _2972;
                        vec3 _2983;
                        _2983.z = dot(_356[_2958], vec4(_2972, _2975, smoothstep(0.0, 1.0, _2972), (_2975 * _2972) * fma(_2972, fma(_2972, 6.0, -15.0), 10.0)));
                        _2984 = _2983;
                    }
                    else
                    {
                        _2984 = vec3(0.0, 0.0, 1.0);
                    }
                    _2998 = _2984;
                }
                vec2 _2999 = _2940.xy;
                vec2 _3003 = (vec2(0.5) - abs(_2999 - vec2(0.5))) * _27._m0[_2900]._m3;
                float _3004 = _3003.x;
                vec3 _3021;
                if (_3004 < 1.0)
                {
                    float _3012 = _3004 * _3004;
                    vec3 _3020 = _2998;
                    _3020.x = dot(_356[_2958], vec4(_3004, _3012, smoothstep(0.0, 1.0, _3004), (_3012 * _3004) * fma(_3004, fma(_3004, 6.0, -15.0), 10.0)));
                    _3021 = _3020;
                }
                else
                {
                    vec3 _3009 = _2998;
                    _3009.x = 1.0;
                    _3021 = _3009;
                }
                float _3022 = _3003.y;
                vec3 _3039;
                if (_3022 < 1.0)
                {
                    float _3030 = _3022 * _3022;
                    vec3 _3038 = _3021;
                    _3038.y = dot(_356[_2958], vec4(_3022, _3030, smoothstep(0.0, 1.0, _3022), (_3030 * _3022) * fma(_3022, fma(_3022, 6.0, -15.0), 10.0)));
                    _3039 = _3038;
                }
                else
                {
                    vec3 _3027 = _3021;
                    _3027.y = 1.0;
                    _3039 = _3027;
                }
                float _3045 = _2957 * ((_3039.x * _3039.y) * _3039.z);
                float _3150;
                bool _3151;
                float _3152;
                if ((_27._m0[_2900]._m8 & 1u) != 0u)
                {
                    uint _3048 = uint(int(_27._m0[_2900]._m8 >> 2u));
                    float _3144;
                    bool _3145;
                    float _3146;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2957 <= 0.0) && true)
                        {
                            _3144 = _2884;
                            _3145 = _2887;
                            _3146 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _3079 = _37._m0[_3048]._m0 * vec4(_5 + (_1211 * ((3.5 * float(int(sign(_2957)))) * _37._m0[_3048]._m4)), 1.0);
                            vec2 _3082 = (_3079.xy * 0.5) + vec2(0.5);
                            _3082.y = 1.0 - _3082.y;
                            float _3091 = ((_3079.z - _37._m0[_3048]._m5.y) / _37._m0[_3048]._m5.x) / _37._m0[_3048]._m6;
                            float _3096 = _2887 ? _2884 : 6.283185482025146484375;
                            float _3097 = _2275 * _3096;
                            vec2 _3098 = _37._m0[_3048]._m1 + _36._m33;
                            vec2 _3101 = (_37._m0[_3048]._m1 + vec2(_37._m0[_3048]._m2)) - _36._m33;
                            float _3103;
                            _3103 = 0.0;
                            for (int _3106 = 0; _3106 < 12; )
                            {
                                float _3111 = float(uint(_3106));
                                float _3114 = sqrt(_3111 + 0.5) * 0.288675129413604736328125;
                                float _3115 = fma(_3111, 2.3999631404876708984375, _3097);
                                vec2 _3123 = clamp(fma((vec3(cos(_3115), sin(_3115), _3114).xy * _3114) * 2.5, _36._m33, _3082), _3098, _3101);
                                vec2 _3126 = fract(fma(vec2(1.0) / _36._m33, _3123, vec2(0.5)));
                                vec4 _3132 = vec4(lessThan(vec4(_3091), textureGather(sampler2D(_38, _29), _3123)));
                                float _3135 = _3126.x;
                                _3103 += clamp(mix(mix(_3132.w, _3132.z, _3135), mix(_3132.x, _3132.y, _3135), _3126.y), 0.0, 1.0);
                                _3106++;
                                continue;
                            }
                            _3144 = _3096;
                            _3145 = _2887 ? _2887 : true;
                            _3146 = _3103 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _3150 = _3144;
                    _3151 = _3145;
                    _3152 = _3045 * mix(1.0, _3146, spvNMin(_2282, _27._m0[_2900]._m5));
                }
                else
                {
                    _3150 = _2884;
                    _3151 = _2887;
                    _3152 = _3045;
                }
                vec3 _3193;
                if (_2929 >= 0)
                {
                    uint _3157 = gl_SubgroupInvocationID & 3u;
                    vec2 _3163 = (subgroupQuadSwapHorizontal(_2999) - _2999) * (((_3157 & 1u) != 0u) ? (-1.0) : 1.0);
                    vec2 _3169 = (subgroupQuadSwapVertical(_2999) - _2999) * (((_3157 & 2u) != 0u) ? (-1.0) : 1.0);
                    vec2 _3173 = mix(_3163, vec2(0.0), bvec2(any(isnan(_3163))));
                    vec2 _3177 = mix(_3169, vec2(0.0), bvec2(any(isnan(_3169))));
                    bvec2 _3186 = bvec2(any(greaterThan(abs(vec4(_3173, _3177)), vec4(0.015625))));
                    int _90 = _2929;
                    _3193 = _27._m0[_2900]._m0 * textureGrad(nonuniformEXT(sampler2D(_42[_90], _21)), _2999, mix(_3173, vec2(0.0), _3186), mix(_3177, vec2(0.0), _3186)).xyz;
                }
                else
                {
                    _3193 = _27._m0[_2900]._m0;
                }
                vec3 _3326;
                vec3 _3327;
                SPIRV_CROSS_BRANCH
                if ((_27._m0[_2900]._m1 & 1u) != 0u)
                {
                    vec3 _3324;
                    vec3 _3325;
                    if (_2957 > 0.0)
                    {
                        vec3 _3265 = _3193 * (_3152 * _20._m0[0u]);
                        vec3 _3272 = vec3(fma((2.0 * _2953) * _2953, _1512, mix(0.0, 0.5, _1512))) - vec3(1.0);
                        float _3293 = (_1512 + 1.0) * 0.5;
                        float _3294 = _1512 * _1512;
                        float _3302 = _3293 * _3293;
                        float _3314 = _3294 * _3294;
                        float _3317 = fma(fma(_2955, _3314, -_2955), _2955, 1.0);
                        _3324 = fma(_3265, (_1502 + ((vec3(1.0) - _1502) * pow(spvNMax(abs(1.0 - _2953), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2957, sqrt(fma(fma(-_2300, _3302, _2300), _2300, _3302)), _2300 * sqrt(fma(fma(-_2957, _3302, _2957), _2957, _3302)))) * (_3314 * (0.3183098733425140380859375 / (_3317 * _3317)))), _2889);
                        _3325 = fma(_3265, _1499 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3272 * pow(spvNMax(abs(1.0 - _2957), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3272 * pow(spvNMax(abs(1.0 - _2300), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1512))), _2891);
                    }
                    else
                    {
                        _3324 = _2889;
                        _3325 = _2891;
                    }
                    _3326 = _3324;
                    _3327 = _3325;
                }
                else
                {
                    vec3 _3259;
                    vec3 _3260;
                    if (_2957 > 0.0)
                    {
                        vec3 _3200 = _3193 * _3152;
                        vec3 _3207 = vec3(fma((2.0 * _2953) * _2953, _1512, mix(0.0, 0.5, _1512))) - vec3(1.0);
                        float _3228 = (_1512 + 1.0) * 0.5;
                        float _3229 = _1512 * _1512;
                        float _3237 = _3228 * _3228;
                        float _3249 = _3229 * _3229;
                        float _3252 = fma(fma(_2955, _3249, -_2955), _2955, 1.0);
                        _3259 = fma(_3200, (_1502 + ((vec3(1.0) - _1502) * pow(spvNMax(abs(1.0 - _2953), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2957, sqrt(fma(fma(-_2300, _3237, _2300), _2300, _3237)), _2300 * sqrt(fma(fma(-_2957, _3237, _2957), _2957, _3237)))) * (_3249 * (0.3183098733425140380859375 / (_3252 * _3252)))), _2889);
                        _3260 = fma(_3200, _1499 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3207 * pow(spvNMax(abs(1.0 - _2957), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3207 * pow(spvNMax(abs(1.0 - _2300), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1512))), _2891);
                    }
                    else
                    {
                        _3259 = _2889;
                        _3260 = _2891;
                    }
                    _3326 = _3259;
                    _3327 = _3260;
                }
                _3328 = _3150;
                _3329 = _3151;
                _3330 = _3326;
                _3331 = _3327;
            }
            else
            {
                _3328 = _2884;
                _3329 = _2887;
                _3330 = _2889;
                _3331 = _2891;
            }
            _2885 = _3328;
            _2888 = _3329;
            _2890 = _3330;
            _2892 = _3331;
        }
        else
        {
            _2885 = _2884;
            _2888 = _2887;
            _2890 = _2889;
            _2892 = _2891;
        }
    }
    vec3 _3333 = reflect(-_411, _1211);
    vec3 _3335 = vec3(_1502.x, _1502.y, _1502.z);
    vec3 _3345 = textureLod(samplerCube(_31, _21), _1211, 0.0).xyz * _36._m27;
    vec3 _3352 = textureLod(samplerCube(_32, _21), _3333, fma(_1512, 8.0, _36._m30 - 8.0)).xyz * _36._m27;
    vec3 _3377;
    vec3 _3378;
    SPIRV_CROSS_BRANCH
    if (_36._m29 > 0.0)
    {
        vec3 _3367 = vec3(_36._m29);
        _3377 = mix(_3352, textureLod(samplerCube(_34, _21), _3333, fma(_1512, 8.0, _36._m31 - 8.0)).xyz * _36._m28, _3367);
        _3378 = mix(_3345, textureLod(samplerCube(_33, _21), _1211, 0.0).xyz * _36._m28, _3367);
    }
    else
    {
        _3377 = _3352;
        _3378 = _3345;
    }
    float _3379 = spvNMax(dot(_411, _1211), 0.001953125);
    vec4 _3384 = textureLod(sampler2D(_35, _29), vec2(_3379, _1512), 0.0);
    uvec4 _3395 = uvec4(_24._m0[_2283]);
    uint _3397 = _3395.y;
    uint _3407 = ((_3395.z >> 0u) & 1023u) + (((_3397 >> 12u) & 4095u) + (((_3397 >> 0u) & 4095u) + _3395.x));
    uint _3409 = (_3397 >> 24u) + _3407;
    vec3 _3411;
    vec3 _3414;
    _3411 = _3377 * ((_3335 * _3384.x) + vec3(_3384.y));
    _3414 = _3378 * (_1499 * _3384.z);
    vec3 _3412;
    vec3 _3415;
    for (uint _3416 = _3407; _3416 < _3409; _3411 = _3412, _3414 = _3415, _3416++)
    {
        uint _3423 = uint(_25._m0[_3416]);
        int _3442 = int((_30._m0[_3423]._m5 >> 1u) & 3u);
        mat3 _3446 = mat3(_30._m0[_3423]._m1[0], _30._m0[_3423]._m1[1], _30._m0[_3423]._m1[2]);
        int _3452 = (int((_30._m0[_3423]._m5 >> 3u) & 16383u) - 1) * 2;
        int _3457 = (int((_30._m0[_3423]._m5 >> 17u) & 16383u) - 1) * 2;
        int _3462 = (int((_30._m0[_3423]._m6 >> 0u) & 65535u) - 1) * 2;
        int _3467 = (int((_30._m0[_3423]._m6 >> 16u) & 65535u) - 1) * 2;
        float _3470 = (_30._m0[_3423]._m3 < 0.0) ? (-_30._m0[_3423]._m3) : 1.0;
        vec3 _3472 = _3446 * (_5 - _30._m0[_3423]._m1[3]);
        bool _3473 = int(_30._m0[_3423]._m5 & 1u) == 1;
        vec3 _3474 = abs(_3472);
        float _3477 = dot(_3472, _3472);
        if (_3473 ? any(greaterThanEqual(_3474, _30._m0[_3423]._m0.xyz)) : (_3477 >= _30._m0[_3423]._m0.y))
        {
            _3412 = _3411;
            _3415 = _3414;
            continue;
        }
        vec3 _3651;
        SPIRV_CROSS_FLATTEN
        if ((_3442 & 1) != 0)
        {
            vec3 _3487 = _3446 * _1211;
            vec2 _3576;
            bool _3577;
            if (_3473)
            {
                vec2 _3571;
                bool _3575;
                do
                {
                    vec3 _3555 = (_30._m0[_3423]._m0.xyz - _3472) / _3487;
                    vec3 _3558 = ((-_30._m0[_3423]._m0.xyz) - _3472) / _3487;
                    vec3 _3559 = spvNMin(_3555, _3558);
                    vec3 _3560 = spvNMax(_3555, _3558);
                    float _3565 = spvNMax(_3559.x, spvNMax(_3559.y, _3559.z));
                    float _3570 = spvNMin(_3560.x, spvNMin(_3560.y, _3560.z));
                    _3571 = vec2(_3565, _3570);
                    if (_3565 > _3570)
                    {
                        _3575 = false;
                        break;
                    }
                    _3575 = true;
                    break;
                } while(false);
                _3576 = _3571;
                _3577 = _3575;
            }
            else
            {
                vec2 _3550;
                bool _3551;
                do
                {
                    float _3493 = dot(_3487, _3487);
                    float _3494 = dot(_3487, _3472);
                    float _3495 = 2.0 * _3494;
                    float _3496 = _3477 - _30._m0[_3423]._m0.y;
                    float _3532;
                    float _3533;
                    bool _3534;
                    do
                    {
                        float _3502 = fma(_3495, _3495, -((4.0 * _3493) * _3496));
                        float _3530;
                        float _3531;
                        if (_3502 < 0.0)
                        {
                            _3532 = 0.0;
                            _3533 = 0.0;
                            _3534 = false;
                            break;
                        }
                        else
                        {
                            if (_3502 == 0.0)
                            {
                                float _3529 = (_3494 * (-1.0)) * (1.0 / _3493);
                                _3530 = _3529;
                                _3531 = _3529;
                            }
                            else
                            {
                                float _3522;
                                if (_3495 > 0.0)
                                {
                                    _3522 = (-0.5) * fma(2.0, _3494, sqrt(_3502));
                                }
                                else
                                {
                                    _3522 = (-0.5) * fma(2.0, _3494, -sqrt(_3502));
                                }
                                _3530 = _3496 * (1.0 / _3522);
                                _3531 = _3522 * (1.0 / _3493);
                            }
                        }
                        _3532 = _3530;
                        _3533 = _3531;
                        _3534 = true;
                        break;
                    } while(false);
                    if (!_3534)
                    {
                        _3550 = vec2(0.0);
                        _3551 = false;
                        break;
                    }
                    if ((_3533 < 0.0) && (_3532 < 0.0))
                    {
                        _3550 = vec2(0.0);
                        _3551 = false;
                        break;
                    }
                    vec2 _3549;
                    if (_3533 > _3532)
                    {
                        _3549 = vec2(_3532, _3533);
                    }
                    else
                    {
                        _3549 = vec2(_3533, _3532);
                    }
                    _3550 = _3549;
                    _3551 = true;
                    break;
                } while(false);
                _3576 = _3550;
                _3577 = _3551;
            }
            vec3 _3580 = _3472 + (_3487 * _3576.y);
            float _3601;
            if (_3473)
            {
                _3601 = 1.0 - clamp(length(spvNMax(_3474 - (_30._m0[_3423]._m0.xyz - vec3(_30._m0[_3423]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_30._m0[_3423]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3601 = clamp((_30._m0[_3423]._m0.x - length(_3472)) * (1.0 / spvNMax(_30._m0[_3423]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3604 = float(_3577) * smoothstep(0.0, 1.0, _3601);
            vec4 _3646;
            SPIRV_CROSS_BRANCH
            if (_3604 > 9.9999997473787516355514526367188e-05)
            {
                float _3613 = mix(clamp((_3576.y * (1.0 / length(_3580))) * _1512, 0.0, _1512), _1512, _1512);
                vec3 _3615 = mix(_3580, _3487, vec3(_3613));
                int _94 = _3452;
                vec4 _3616 = textureLod(nonuniformEXT(samplerCube(_41[_94], _21)), _3615, 0.0);
                int _98 = _3452 + 1;
                _3616.w = textureLod(nonuniformEXT(samplerCube(_41[_98], _21)), _3615, 0.0).x;
                vec4 _3631;
                SPIRV_CROSS_BRANCH
                if (_3457 >= 0)
                {
                    int _102 = _3457;
                    vec4 _3624 = textureLod(nonuniformEXT(samplerCube(_41[_102], _21)), _3615, 0.0);
                    int _106 = _3457 + 1;
                    _3624.w = textureLod(nonuniformEXT(samplerCube(_41[_106], _21)), _3615, 0.0).x;
                    _3631 = mix(_3616, _3624, vec4(_30._m0[_3423]._m3));
                }
                else
                {
                    _3631 = _3616;
                }
                vec4 _3632 = _3631 * _3470;
                vec3 _3641 = (_3632.xyz * _30._m0[_3423]._m4).xyz * (_1499 * textureLod(sampler2D(_35, _29), vec2(_3379, _3613), 0.0).z);
                vec4 _3642 = vec4(_3641.x, _3641.y, _3641.z, _3632.w);
                _3642.w = _3632.w * _3604;
                _3646 = _3642;
            }
            else
            {
                _3646 = vec4(0.0);
            }
            _3651 = mix(_3414, _3646.xyz, vec3(_3646.w));
        }
        else
        {
            _3651 = _3414;
        }
        vec3 _3830;
        SPIRV_CROSS_FLATTEN
        if ((_3442 & 2) != 0)
        {
            vec3 _3656 = _3446 * _3333;
            vec2 _3745;
            bool _3746;
            if (_3473)
            {
                vec2 _3740;
                bool _3744;
                do
                {
                    vec3 _3724 = (_30._m0[_3423]._m0.xyz - _3472) / _3656;
                    vec3 _3727 = ((-_30._m0[_3423]._m0.xyz) - _3472) / _3656;
                    vec3 _3728 = spvNMin(_3724, _3727);
                    vec3 _3729 = spvNMax(_3724, _3727);
                    float _3734 = spvNMax(_3728.x, spvNMax(_3728.y, _3728.z));
                    float _3739 = spvNMin(_3729.x, spvNMin(_3729.y, _3729.z));
                    _3740 = vec2(_3734, _3739);
                    if (_3734 > _3739)
                    {
                        _3744 = false;
                        break;
                    }
                    _3744 = true;
                    break;
                } while(false);
                _3745 = _3740;
                _3746 = _3744;
            }
            else
            {
                vec2 _3719;
                bool _3720;
                do
                {
                    float _3662 = dot(_3656, _3656);
                    float _3663 = dot(_3656, _3472);
                    float _3664 = 2.0 * _3663;
                    float _3665 = _3477 - _30._m0[_3423]._m0.y;
                    float _3701;
                    float _3702;
                    bool _3703;
                    do
                    {
                        float _3671 = fma(_3664, _3664, -((4.0 * _3662) * _3665));
                        float _3699;
                        float _3700;
                        if (_3671 < 0.0)
                        {
                            _3701 = 0.0;
                            _3702 = 0.0;
                            _3703 = false;
                            break;
                        }
                        else
                        {
                            if (_3671 == 0.0)
                            {
                                float _3698 = (_3663 * (-1.0)) * (1.0 / _3662);
                                _3699 = _3698;
                                _3700 = _3698;
                            }
                            else
                            {
                                float _3691;
                                if (_3664 > 0.0)
                                {
                                    _3691 = (-0.5) * fma(2.0, _3663, sqrt(_3671));
                                }
                                else
                                {
                                    _3691 = (-0.5) * fma(2.0, _3663, -sqrt(_3671));
                                }
                                _3699 = _3665 * (1.0 / _3691);
                                _3700 = _3691 * (1.0 / _3662);
                            }
                        }
                        _3701 = _3699;
                        _3702 = _3700;
                        _3703 = true;
                        break;
                    } while(false);
                    if (!_3703)
                    {
                        _3719 = vec2(0.0);
                        _3720 = false;
                        break;
                    }
                    if ((_3702 < 0.0) && (_3701 < 0.0))
                    {
                        _3719 = vec2(0.0);
                        _3720 = false;
                        break;
                    }
                    vec2 _3718;
                    if (_3702 > _3701)
                    {
                        _3718 = vec2(_3701, _3702);
                    }
                    else
                    {
                        _3718 = vec2(_3702, _3701);
                    }
                    _3719 = _3718;
                    _3720 = true;
                    break;
                } while(false);
                _3745 = _3719;
                _3746 = _3720;
            }
            vec3 _3749 = _3472 + (_3656 * _3745.y);
            float _3770;
            if (_3473)
            {
                _3770 = 1.0 - clamp(length(spvNMax(_3474 - (_30._m0[_3423]._m0.xyz - vec3(_30._m0[_3423]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_30._m0[_3423]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3770 = clamp((_30._m0[_3423]._m0.x - length(_3472)) * (1.0 / spvNMax(_30._m0[_3423]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3773 = float(_3746) * smoothstep(0.0, 1.0, _3770);
            vec4 _3825;
            SPIRV_CROSS_BRANCH
            if (_3773 > 9.9999997473787516355514526367188e-05)
            {
                float _3782 = mix(clamp((_3745.y * (1.0 / length(_3749))) * _1512, 0.0, _1512), _1512, _1512);
                vec3 _3784 = mix(_3749, _3656, vec3(_3782));
                float _3785 = _3782 * 8.0;
                int _110 = _3462;
                int _114 = _3462 + 1;
                vec4 _3793 = vec4(textureLod(nonuniformEXT(samplerCube(_41[_110], _21)), _3784, _3785).xyz, textureLod(nonuniformEXT(samplerCube(_41[_114], _21)), _3784, _3785).x);
                vec4 _3807;
                SPIRV_CROSS_BRANCH
                if (_3467 >= 0)
                {
                    int _118 = _3467;
                    int _122 = _3467 + 1;
                    _3807 = mix(_3793, vec4(textureLod(nonuniformEXT(samplerCube(_41[_118], _21)), _3784, _3785).xyz, textureLod(nonuniformEXT(samplerCube(_41[_122], _21)), _3784, _3785).x), vec4(_30._m0[_3423]._m3));
                }
                else
                {
                    _3807 = _3793;
                }
                vec4 _3808 = _3807 * _3470;
                vec4 _3813 = textureLod(sampler2D(_35, _29), vec2(_3379, _3782), 0.0);
                vec3 _3820 = (_3808.xyz * _30._m0[_3423]._m4).xyz * ((_3335 * _3813.x) + vec3(_3813.y));
                vec4 _3821 = vec4(_3820.x, _3820.y, _3820.z, _3808.w);
                _3821.w = _3808.w * _3773;
                _3825 = _3821;
            }
            else
            {
                _3825 = vec4(0.0);
            }
            _3830 = mix(_3411, _3825.xyz, vec3(_3825.w));
        }
        else
        {
            _3830 = _3411;
        }
        _3412 = _3830;
        _3415 = _3651;
    }
    float _3831 = _20._m0[0u] * 100.0;
    vec3 _3835 = _2096 * (_2268 * _20._m0[0u]);
    vec3 _3838 = reflect(_411, _1211);
    float _3842 = clamp(dot(_14._m0, normalize(_411 + _14._m0)), 0.0, 1.0);
    float _3844 = clamp(dot(_1211, _14._m0), 0.0, 1.0);
    vec3 _3851 = vec3(fma((2.0 * _3842) * _3842, _1512, mix(0.0, 0.5, _1512))) - vec3(1.0);
    float _3870 = dot(_14._m0, _3838);
    vec3 _3880 = mix(_3838, normalize((_14._m0 * 0.999989449977874755859375) + (normalize(_3838 - (_14._m0 * _3870)) * 0.0045900647528469562530517578125)), bvec3(_3870 < 0.999989449977874755859375));
    vec3 _3882 = normalize(_411 + _3880);
    float _3886 = clamp(dot(_1211, _3882), 0.0, 1.0);
    float _3888 = clamp(dot(_1211, _3880), 0.0, 1.0);
    float _3890 = (_1512 + 1.0) * 0.5;
    float _3891 = _1512 * _1512;
    float _3899 = _3890 * _3890;
    float _3911 = _3891 * _3891;
    float _3914 = fma(fma(_3886, _3911, -_3886), _3886, 1.0);
    vec3 _3933 = (((_2891 + ((_3835 * (_1499 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3851 * pow(spvNMax(abs(1.0 - _3844), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3851 * pow(spvNMax(abs(1.0 - _2300), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1512))))) * _3844)) + (_2889 + ((_3835 * ((_1502 + ((vec3(1.0) - _1502) * pow(spvNMax(abs(1.0 - clamp(dot(_3880, _3882), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_3888, sqrt(fma(fma(-_2300, _3899, _2300), _2300, _3899)), _2300 * sqrt(fma(fma(-_3888, _3899, _3888), _3888, _3899)))) * (_3911 * (0.3183098733425140380859375 / (_3914 * _3914)))))) * _3844))) * mix(1.0, 1.0, _36._m1)) + (((_3414 * _3831) + (_3411 * _3831)) * 1.0);
    vec4 _4128;
    do
    {
        if (_36._m19[3].z < 0.0)
        {
            _4128 = vec4(0.0, 0.0, 0.0, 1.0);
            break;
        }
        float _3974;
        do
        {
            if (_10 <= _36._m19[0].x)
            {
                _3974 = fma(_36._m19[2].x, _10, _36._m19[3].x);
                break;
            }
            else
            {
                _3974 = _36._m19[1].y * log2(fma(_36._m19[2].y, _10, _36._m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        vec3 _3984 = (vec3(_404 / vec2(_36._m32, _36._m18), _3974) + vec3(float(_17._m5), 0.0, 0.0)) - vec3(0.5);
        vec3 _3985 = floor(_3984);
        vec3 _3986 = _3984 - _3985;
        vec3 _3987 = vec3(1.0) - _3986;
        vec3 _3994 = fma(-((_3986 * 0.5) * _3986), vec3(2.0) - _3986, vec3(0.666666686534881591796875));
        vec3 _4001 = (_3986 * 0.16666667163372039794921875) * _3986;
        vec3 _4003 = fma((_3987 * 0.16666667163372039794921875) * _3987, _3987, _3994);
        vec3 _4010 = _36._m17 * (((_3994 / _4003) - vec3(0.5)) + _3985);
        vec3 _4014 = _36._m17 * ((((_4001 * _3986) / fma(_4001, _3986, fma(-((_3987 * 0.5) * _3987), _3986 + vec3(1.0), vec3(0.666666686534881591796875)))) + vec3(1.5)) + _3985);
        float _4022 = _4010.z;
        float _4028 = _4014.x;
        vec2 _4032 = spvNMax(_36._m15, spvNMin(_36._m16, vec2(_4028, _4010.y)));
        float _4033 = _4032.x;
        vec4 _4039 = vec4(_4003.x);
        float _4041 = _4010.x;
        vec2 _4045 = spvNMax(_36._m15, spvNMin(_36._m16, vec2(_4041, _4014.y)));
        float _4046 = _4045.x;
        vec4 _4061 = vec4(_4003.y);
        float _4066 = _4014.z;
        vec4 _4092 = mix(mix(mix(textureLod(sampler3D(_28, _29), vec3(spvNMax(_36._m15, spvNMin(_36._m16, _4014.xy)), _4066), 0.0), textureLod(sampler3D(_28, _29), vec3(_4046, _4045.y, _4066), 0.0), _4039), mix(textureLod(sampler3D(_28, _29), vec3(_4033, _4032.y, _4066), 0.0), textureLod(sampler3D(_28, _29), vec3(spvNMax(_36._m15, spvNMin(_36._m16, vec2(_4041, _4010.y))), _4066), 0.0), _4039), _4061), mix(mix(textureLod(sampler3D(_28, _29), vec3(spvNMax(_36._m15, spvNMin(_36._m16, vec2(_4028, _4014.y))), _4022), 0.0), textureLod(sampler3D(_28, _29), vec3(_4046, _4045.y, _4022), 0.0), _4039), mix(textureLod(sampler3D(_28, _29), vec3(_4033, _4032.y, _4022), 0.0), textureLod(sampler3D(_28, _29), vec3(spvNMax(_36._m15, spvNMin(_36._m16, _4010.xy)), _4022), 0.0), _4039), _4061), vec4(_4003.z)) * vec4(0.03125, 0.03125, 0.03125, 3.0517578125e-05);
        vec4 _4100;
        if (isinf(_4092.x) || isnan(_4092.x))
        {
            vec4 _4099 = _4092;
            _4099.x = 0.0;
            _4100 = _4099;
        }
        else
        {
            _4100 = _4092;
        }
        vec4 _4108;
        if (isinf(_4100.y) || isnan(_4100.y))
        {
            vec4 _4107 = _4100;
            _4107.y = 0.0;
            _4108 = _4107;
        }
        else
        {
            _4108 = _4100;
        }
        vec4 _4116;
        if (isinf(_4108.z) || isnan(_4108.z))
        {
            vec4 _4115 = _4108;
            _4115.z = 0.0;
            _4116 = _4115;
        }
        else
        {
            _4116 = _4108;
        }
        vec4 _4124;
        if (isinf(_4116.w) || isnan(_4116.w))
        {
            vec4 _4123 = _4116;
            _4123.w = 0.0;
            _4124 = _4123;
        }
        else
        {
            _4124 = _4116;
        }
        vec4 _4127 = _4124;
        _4127.w = 1.0 - _4124.w;
        _4128 = _4127;
        break;
    } while(false);
    vec2 _4144 = ((((texture(sampler2D(_52, _18), _9).xy - vec2(0.5)) * 0.5) * (mix(0.5, texture(sampler2D(_54, _18), _9).z, _49._m21) * 2.0)) * vec2(-1.0, 1.0)) * _49._m22;
    vec4 _4146 = texture(sampler2D(_53, _50), _509);
    float _4147 = _4146.x;
    float _4149 = fma(_13._m0, _49._m23, _4147 * _49._m24);
    float _4150 = fract(_4149);
    vec4 _4155 = texture(sampler2D(_55, _18), fma(_9, _49._m6, _4144 * _4150) + _533);
    vec3 _4158 = (_4155.wzy * 2.0) - vec3(1.0);
    vec4 _4159 = vec4(_4158.x, _4158.y, _4158.z, _4155.x);
    _4159.z = -_4158.z;
    vec4 _4172 = texture(sampler2D(_55, _18), fma(_9, _49._m6, _4144 * fract(_4149 + 0.5)) + _533);
    vec3 _4175 = (_4172.wzy * 2.0) - vec3(1.0);
    vec4 _4176 = vec4(_4175.x, _4175.y, _4175.z, _4172.x);
    _4176.z = -_4175.z;
    float _4188 = fma(_4147, _49._m24, _572);
    float _4189 = fract(_4188);
    vec4 _4194 = texture(sampler2D(_56, _18), fma(_9, _49._m7, _4144 * _4189) + _533);
    vec3 _4197 = (_4194.wzy * 2.0) - vec3(1.0);
    vec4 _4198 = vec4(_4197.x, _4197.y, _4197.z, _4194.x);
    _4198.z = -_4197.z;
    vec4 _4211 = texture(sampler2D(_56, _18), fma(_9, _49._m7, _4144 * fract(_4188 + 0.5)) + _533);
    vec3 _4214 = (_4211.wzy * 2.0) - vec3(1.0);
    vec4 _4215 = vec4(_4214.x, _4214.y, _4214.z, _4211.x);
    _4215.z = -_4214.z;
    float _4228 = fma(_4147, _49._m24, _618);
    float _4229 = fract(_4228);
    vec4 _4234 = texture(sampler2D(_55, _18), fma(_9, _49._m8, _4144 * _4229) + _533);
    vec3 _4237 = (_4234.wzy * 2.0) - vec3(1.0);
    vec4 _4238 = vec4(_4237.x, _4237.y, _4237.z, _4234.x);
    _4238.z = -_4237.z;
    vec4 _4251 = texture(sampler2D(_55, _18), fma(_9, _49._m8, _4144 * fract(_4228 + 0.5)) + _533);
    vec3 _4254 = (_4251.wzy * 2.0) - vec3(1.0);
    vec4 _4255 = vec4(_4254.x, _4254.y, _4254.z, _4251.x);
    _4255.z = -_4254.z;
    float _4276 = clamp(fma(texture(sampler2D(_23, _19), _404).x, _15._m4, _421) / _437, 0.0, 1.0);
    float _4284 = fma(_4147, _49._m24, _735);
    float _4287 = (fract(_4284) + (-0.5)) * 2.0;
    vec2 _4315 = (normalize((mix(normalize(_4159.xyz).xyz, normalize(_4176.xyz).xyz, vec3(abs((_4150 + (-0.5)) * 2.0))) + mix(normalize(_4198.xyz).xyz, normalize(_4215.xyz).xyz, vec3(abs((_4189 + (-0.5)) * 2.0)))) + (mix(normalize(_4238.xyz).xyz, normalize(_4255.xyz).xyz, vec3(abs((_4229 + (-0.5)) * 2.0))) * _49._m28)).xz * (fma(_4276 - 1.0, 1.0 - _4276, 1.0) * _49._m59)) * fma(-pow(spvNMax(abs(mix(vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _4144 * _4287) + _533).x), vec4(_383, _383, _383, texture(sampler2D(_58, _18), fma(_501, _49._m9, _4144 * ((fract(_4284 + 0.5) + (-0.5)) * 2.0)) + _533).x), vec4(abs(_4287))).w), 9.9999997473787516355514526367188e-05), _49._m35), _49._m36, 1.0);
    vec2 _4325 = vec2(_4315.x * (_16._m1 / _16._m0), -_4315.y);
    vec2 _4333 = _403 * 0.5;
    vec2 _4334 = _17._m9 - _4333;
    vec2 _4338 = (_17._m10 + _4333) - _4334;
    vec2 _4341 = abs(fma(_4325, _17._m21, _404) - _4334) + _4338;
    vec2 _4342 = _4338 * 2.0;
    vec2 _4357 = abs(fma(gl_FragCoord.xy, _403, ((_4325 * _17._m21) * step(_10, texture(sampler2D(_23, _51), clamp(_4334 + abs((_4341 - _4342 * trunc(_4341 / _4342)) - _4338), _17._m9, _17._m10)).x)) * _48._m0) - _4334) + _4338;
    vec4 _4365 = texture(sampler2D(_22, _51), clamp(_4334 + abs((_4357 - _4342 * trunc(_4357 / _4342)) - _4338), _17._m9, _17._m10));
    // Inscatter strength: 0 = no colour cast, 1 = full game inscatter. Transmittance unchanged.
    float inscatterStrength = pc.rendering_fog_color_correction;
    vec3 _4368_base = _3933 * _2095 + (((_933.xyz * ((clamp((spvNMin(fma(_939, -1.0, _49._m31), _939 - _49._m32) * _703) / _706, 0.0, 1.0) * _715) * clamp(-fma(length(_791), 8.0, _720), 0.0, 1.0))) * _49._m37) * float(!(_13._m1 != 0.0)));
    vec3 _4368_composited = _4368_base + (_2094 * _20._m0[0u]) * inscatterStrength * _4128.w + _4128.xyz * inscatterStrength;
    vec3 _4368 = mix(_4365.xyz, _4368_composited, vec3(_776));
    _11 = spvNMax(vec4(_4368, fma(fma(-_773, _48._m0, 1.0), _4365.w, _776)), vec4(0.0));
}

