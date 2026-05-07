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

float _331;
const vec4 _347[4] = vec4[](vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
vec3 _366;
float _373;
vec3 _374;

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

layout(set = 2, binding = 10, std430) readonly buffer _68_26
{
    ivec4 _m0[];
} _26;

layout(set = 2, binding = 11, std430) readonly buffer _70_27
{
    int _m0[];
} _27;

layout(set = 2, binding = 12, std430) readonly buffer _73_28
{
    _71 _m0[];
} _28;

layout(set = 2, binding = 16, std430) readonly buffer _76_29
{
    layout(row_major) _74 _m0[];
} _29;

layout(set = 2, binding = 20, std430) readonly buffer _80_32
{
    layout(row_major) _78 _m0[];
} _32;

layout(set = 2, binding = 26, std140) uniform _82_38
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
} _38;

layout(set = 2, binding = 27, scalar) readonly buffer _85_39
{
    layout(row_major) _83 _m0[];
} _39;

layout(set = 5, binding = 0, scalar) uniform _86_45
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
} _45;

layout(set = 1, binding = 0, std140) uniform _87_50
{
    float _m0;
    uint _m1;
    uint _m2;
    uint _m3;
} _50;

layout(set = 1, binding = 1, std140) uniform _88_51
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    vec3 _m6;
    float _m7;
    vec2 _m8;
    vec2 _m9;
    vec2 _m10;
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
} _51;

layout(set = 0, binding = 7) uniform sampler _18;
layout(set = 0, binding = 9) uniform sampler _19;
layout(set = 2, binding = 3) uniform sampler _21;
layout(set = 2, binding = 4) uniform texture2D _22;
layout(set = 2, binding = 5) uniform texture2D _23;
layout(set = 2, binding = 8) uniform texture2DArray _24;
layout(set = 2, binding = 9) uniform samplerShadow _25;
layout(set = 2, binding = 17) uniform texture3D _30;
layout(set = 2, binding = 19) uniform sampler _31;
layout(set = 2, binding = 21) uniform textureCube _33;
layout(set = 2, binding = 22) uniform textureCube _34;
layout(set = 2, binding = 23) uniform textureCube _35;
layout(set = 2, binding = 24) uniform textureCube _36;
layout(set = 2, binding = 25) uniform texture2D _37;
layout(set = 2, binding = 28) uniform texture2D _40;
layout(set = 2, binding = 29) uniform texture2D _41;
layout(set = 2, binding = 30) uniform texture2D _42;
layout(set = 2, binding = 32) uniform textureCube _43[];
layout(set = 2, binding = 32) uniform texture2D _44[];
layout(set = 5, binding = 1) uniform texture2D _46;
layout(set = 5, binding = 2) uniform texture3D _47;
layout(set = 5, binding = 4) uniform texture2D _48;
layout(set = 5, binding = 5) uniform texture2D _49;
layout(set = 1, binding = 2) uniform sampler _52;
layout(set = 1, binding = 3) uniform sampler _53;
layout(set = 1, binding = 4) uniform texture2D _54;
layout(set = 1, binding = 5) uniform texture2D _55;
layout(set = 1, binding = 6) uniform texture2D _56;
layout(set = 1, binding = 7) uniform texture2D _57;
layout(set = 1, binding = 8) uniform texture2D _58;

layout(location = 0) in float _4;
layout(location = 1) in vec2 _5;
layout(location = 2) in vec3 _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in vec3 _9;
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
    vec2 _393 = vec2(_16._m2, _16._m3);
    vec2 _394 = gl_FragCoord.xy * _393;
    vec3 _397 = _6 + _15._m6;
    float _405 = -_4;
    float _411 = clamp(fma(texture(sampler2D(_23, _19), _394).x, _15._m4, _405) / spvNMax(_51._m16, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
    float _424 = spvNMax(_51._m17, 9.9999997473787516355514526367188e-05);
    float _426 = clamp(fma(texture(sampler2D(_23, _19), _394).x, _15._m4, _405) / _424, 0.0, 1.0);
    vec2 _440 = (texture(sampler2D(_54, _18), _5).xy - vec2(0.5)) * 0.5;
    vec2 _445 = _397.xz;
    vec2 _455 = (_445 * _51._m5) + vec2(_13._m0 * _51._m7);
    float _465 = _13._m0 * _51._m21;
    float _466 = fma(texture(sampler2D(_55, _52), _455).x, _51._m20, _465);
    float _469 = (fract(_466) + (-0.5)) * 2.0;
    float _470 = _51._m19 * (-0.017453290522098541259765625);
    float _471 = cos(_470);
    float _472 = sin(_470);
    mat2 _476 = mat2(vec2(_471, _472), vec2(-_472, _471));
    vec2 _477 = ((_440 * vec2(-1.0, 1.0)) * 1.0) * _476;
    vec2 _491 = (vec3(_14._m1, 0.0, _14._m3).xz * _51._m22) * _13._m0;
    float _519 = spvNMax(_51._m23, 9.9999997473787516355514526367188e-05);
    float _528 = -_51._m1;
    float _530 = -fma(length(_440), 8.0, _528);
    float _557 = clamp(pow(spvNMax(abs(mix(vec4(_373, _373, _373, texture(sampler2D(_56, _18), fma(_445, _51._m8, _477 * _469) + _491).x), vec4(_373, _373, _373, texture(sampler2D(_56, _18), fma(_445, _51._m8, _477 * ((fract(_466 + 0.5) + (-0.5)) * 2.0)) + _491).x), vec4(abs(_469))).w * fma(1.0 - clamp(fma(texture(sampler2D(_23, _19), _394).x, _15._m4, _405) / _519, 0.0, 1.0), _51._m24, fma(smoothstep(_51._m25, _51._m26, _530), _51._m27, smoothstep(_51._m28, _51._m29, _530) * _51._m30))), 9.9999997473787516355514526367188e-05), _51._m31) * _51._m32, 0.0, 1.0);
    float _566 = clamp(fma(pow(spvNMax(abs(_557), 9.9999997473787516355514526367188e-05), _51._m33), _51._m34, spvNMax(_51._m15 * fma(_411 - 1.0, 1.0 - _411, 1.0), fma(_426 - 1.0, 1.0 - _426, 1.0) * _51._m18)), 0.0, 1.0);
    float _569 = _566 * _50._m0;
    mat3 _571 = mat3(_9, _7, _8);
    vec2 _578 = (texture(sampler2D(_54, _18), _5).xy - vec2(0.5)) * 0.5;
    vec2 _580 = (_578 * vec2(-1.0, 1.0)) * 1.0;
    vec4 _584 = texture(sampler2D(_55, _52), _455);
    float _585 = _584.x;
    float _587 = fma(_13._m0, _51._m35, _585 * _51._m20);
    float _588 = fract(_587);
    vec4 _596 = texture(sampler2D(_57, _18), fma(_5, _51._m9, _580 * _588) + _491);
    vec3 _599 = (_596.wzy * 2.0) - vec3(1.0);
    vec4 _600 = vec4(_599.x, _599.y, _599.z, _596.x);
    _600.z = -_599.z;
    vec4 _613 = texture(sampler2D(_57, _18), fma(_5, _51._m9, _580 * fract(_587 + 0.5)) + _491);
    vec3 _616 = (_613.wzy * 2.0) - vec3(1.0);
    vec4 _617 = vec4(_616.x, _616.y, _616.z, _613.x);
    _617.z = -_616.z;
    float _631 = _13._m0 * _51._m36;
    float _632 = fma(_585, _51._m20, _631);
    float _633 = fract(_632);
    vec4 _641 = texture(sampler2D(_58, _18), fma(_5, _51._m10, _580 * _633) + _491);
    vec3 _644 = (_641.wzy * 2.0) - vec3(1.0);
    vec4 _645 = vec4(_644.x, _644.y, _644.z, _641.x);
    _645.z = -_644.z;
    vec4 _658 = texture(sampler2D(_58, _18), fma(_5, _51._m10, _580 * fract(_632 + 0.5)) + _491);
    vec3 _661 = (_658.wzy * 2.0) - vec3(1.0);
    vec4 _662 = vec4(_661.x, _661.y, _661.z, _658.x);
    _662.z = -_661.z;
    float _680 = fma(_585, _51._m20, _465);
    float _683 = (fract(_680) + (-0.5)) * 2.0;
    vec2 _684 = _580 * _476;
    vec4 _689 = texture(sampler2D(_56, _18), fma(_445, _51._m8, _684 * _683) + _491);
    vec3 _692 = (_689.wzy * 2.0) - vec3(1.0);
    vec4 _693 = vec4(_692.x, _692.y, _692.z, _689.x);
    _693.z = -_692.z;
    vec4 _712 = texture(sampler2D(_56, _18), fma(_445, _51._m8, _684 * ((fract(_680 + 0.5) + (-0.5)) * 2.0)) + _491);
    vec3 _715 = (_712.wzy * 2.0) - vec3(1.0);
    vec4 _716 = vec4(_715.x, _715.y, _715.z, _712.x);
    _716.z = -_715.z;
    vec4 _729 = mix(vec4(normalize(_693.xyz), _689.x), vec4(normalize(_716.xyz), _712.x), vec4(abs(_683)));
    float _740 = -fma(length(_578), 8.0, _528);
    vec3 _754 = normalize(mix(normalize(normalize(_7) * _571), normalize(mix(normalize(_600.xyz).xyz, normalize(_617.xyz).xyz, vec3(abs((_588 + (-0.5)) * 2.0))) + mix(normalize(_645.xyz).xyz, normalize(_662.xyz).xyz, vec3(abs((_633 + (-0.5)) * 2.0)))), vec3(_51._m37)) + (((vec3(1.0, 0.0, 1.0) * (_729.w * fma(1.0 - clamp(fma(texture(sampler2D(_23, _19), _394).x, _15._m4, _405) / _519, 0.0, 1.0), _51._m24, fma(smoothstep(_51._m25, _51._m26, _740), _51._m27, smoothstep(_51._m28, _51._m29, _740) * _51._m30)))) * _729.xyz) * _51._m38));
    vec3 _756 = normalize(_571 * _754);
    vec4 _760 = texture(sampler2D(_23, _19), _394);
    vec4 _781 = texture(sampler2D(_54, _18), _5);
    vec2 _784 = (_781.xy - vec2(0.5)) * 0.5;
    float _790 = fma(texture(sampler2D(_55, _52), _455).x, _51._m20, _465);
    float _793 = (fract(_790) + (-0.5)) * 2.0;
    vec2 _794 = ((_784 * vec2(-1.0, 1.0)) * 1.0) * _476;
    vec4 _818 = texture(sampler2D(_23, _19), _394);
    float _826 = -fma(length(_784), 8.0, _528);
    float _837 = clamp(pow(spvNMax(abs(mix(vec4(_373, _373, _373, texture(sampler2D(_56, _18), fma(_445, _51._m8, _794 * _793) + _491).x), vec4(_373, _373, _373, texture(sampler2D(_56, _18), fma(_445, _51._m8, _794 * ((fract(_790 + 0.5) + (-0.5)) * 2.0)) + _491).x), vec4(abs(_793))).w * fma(1.0 - clamp(fma(_818.x, _15._m4, _405) / _519, 0.0, 1.0), _51._m24, fma(smoothstep(_51._m25, _51._m26, _826), _51._m27, smoothstep(_51._m28, _51._m29, _826) * _51._m30))), 9.9999997473787516355514526367188e-05), _51._m31) * _51._m32, 0.0, 1.0);
    vec4 _843 = texture(sampler2D(_54, _18), _5);
    vec2 _846 = (_843.xy - vec2(0.5)) * 0.5;
    float _852 = fma(texture(sampler2D(_55, _52), _455).x, _51._m20, _465);
    float _855 = (fract(_852) + (-0.5)) * 2.0;
    vec2 _856 = ((_846 * vec2(-1.0, 1.0)) * 1.0) * _476;
    vec4 _880 = texture(sampler2D(_23, _19), _394);
    float _888 = -fma(length(_846), 8.0, _528);
    float _899 = clamp(pow(spvNMax(abs(mix(vec4(_373, _373, _373, texture(sampler2D(_56, _18), fma(_445, _51._m8, _856 * _855) + _491).x), vec4(_373, _373, _373, texture(sampler2D(_56, _18), fma(_445, _51._m8, _856 * ((fract(_852 + 0.5) + (-0.5)) * 2.0)) + _491).x), vec4(abs(_855))).w * fma(1.0 - clamp(fma(_880.x, _15._m4, _405) / _519, 0.0, 1.0), _51._m24, fma(smoothstep(_51._m25, _51._m26, _888), _51._m27, smoothstep(_51._m28, _51._m29, _888) * _51._m30))), 9.9999997473787516355514526367188e-05), _51._m31) * _51._m32, 0.0, 1.0);
    float _904 = mix(_51._m41, _51._m42, _899);
    vec4 _906 = texture(sampler2D(_54, _18), _5);
    vec2 _909 = (_906.xy - vec2(0.5)) * 0.5;
    float _915 = fma(texture(sampler2D(_55, _52), _455).x, _51._m20, _465);
    float _918 = (fract(_915) + (-0.5)) * 2.0;
    vec2 _919 = ((_909 * vec2(-1.0, 1.0)) * 1.0) * _476;
    vec4 _943 = texture(sampler2D(_23, _19), _394);
    float _951 = -fma(length(_909), 8.0, _528);
    float _962 = clamp(pow(spvNMax(abs(mix(vec4(_373, _373, _373, texture(sampler2D(_56, _18), fma(_445, _51._m8, _919 * _918) + _491).x), vec4(_373, _373, _373, texture(sampler2D(_56, _18), fma(_445, _51._m8, _919 * ((fract(_915 + 0.5) + (-0.5)) * 2.0)) + _491).x), vec4(abs(_918))).w * fma(1.0 - clamp(fma(_943.x, _15._m4, _405) / _519, 0.0, 1.0), _51._m24, fma(smoothstep(_51._m25, _51._m26, _951), _51._m27, smoothstep(_51._m28, _51._m29, _951) * _51._m30))), 9.9999997473787516355514526367188e-05), _51._m31) * _51._m32, 0.0, 1.0);
    float _967 = mix(_51._m43, _51._m44, _962);
    float _1365;
    if (_38._m3 > 0.0)
    {
        vec4 _983;
        float _988;
        float _989;
        vec2 _997;
        float _1003;
        float _1086;
        bool _1087;
        do
        {
            _983 = vec4(_6 + ((_756 - _7) * 0.20000000298023223876953125), 1.0);
            vec4 _984 = _983 * _38._m10[0u];
            _988 = _38._m9.x;
            _989 = 0.5 * _38._m6;
            _997 = vec2(_38._m6);
            vec2 _999 = clamp((vec2(1.0) - abs((clamp(_984.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _997, vec2(0.0), vec2(1.0));
            float _1000 = _984.z;
            _1003 = _38._m8.x;
            float _1006 = clamp((clamp(_1000, 0.0, 1.0) * _1003) / (_988 * _989), 0.0, 1.0);
            float _1009 = _999.x * _999.y;
            float _1010 = _1009 * _1006;
            SPIRV_CROSS_BRANCH
            if (_1010 > 0.0)
            {
                float _1028 = textureGrad(sampler2DArrayShadow(_24, _25), vec4(vec3(_984.xy, 0.0), fma(_38._m7 / _1003, mix(_988 / _988, _1003 / _1003, 0.75), _1000)), vec2(0.0), vec2(0.0));
                float _1085;
                SPIRV_CROSS_BRANCH
                if (((1.0 < _38._m11) && true) && (_1010 < 1.0))
                {
                    vec4 _1044 = _983 * _38._m10[1u];
                    vec2 _1055 = clamp((vec2(1.0) - abs((clamp(_1044.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _997, vec2(0.0), vec2(1.0));
                    float _1056 = _1044.z;
                    float _1084;
                    SPIRV_CROSS_BRANCH
                    if (((_1055.x * _1055.y) * clamp((clamp(_1056, 0.0, 1.0) * _38._m8.y) / (_38._m9.y * _989), 0.0, 1.0)) > 0.0)
                    {
                        _1084 = fma(_1028, _1010, fma(-_1009, _1006, 1.0) * textureGrad(sampler2DArrayShadow(_24, _25), vec4(vec3(_1044.xy, 1.0), fma(_38._m7 / _38._m8.y, mix(_38._m9.y / _988, _38._m8.y / _1003, 0.75), _1056)), vec2(0.0), vec2(0.0)));
                    }
                    else
                    {
                        _1084 = _1028 * _1010;
                    }
                    _1085 = _1084;
                }
                else
                {
                    _1085 = fma(_1028, _1010, fma(-_1009, _1006, 1.0));
                }
                _1086 = _1085;
                _1087 = true;
                break;
            }
            else
            {
                _1086 = 1.0;
                _1087 = false;
                break;
            }
            break; // unreachable workaround
        } while(false);
        float _1360;
        if ((!_1087) && (_38._m11 > 1.0))
        {
            float _1195;
            bool _1196;
            do
            {
                vec4 _1099 = _983 * _38._m10[1u];
                vec2 _1110 = clamp((vec2(1.0) - abs((clamp(_1099.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _997, vec2(0.0), vec2(1.0));
                float _1111 = _1099.z;
                float _1117 = clamp((clamp(_1111, 0.0, 1.0) * _38._m8.y) / (_38._m9.y * _989), 0.0, 1.0);
                float _1120 = _1110.x * _1110.y;
                float _1121 = _1120 * _1117;
                SPIRV_CROSS_BRANCH
                if (_1121 > 0.0)
                {
                    float _1139 = textureGrad(sampler2DArrayShadow(_24, _25), vec4(vec3(_1099.xy, 1.0), fma(_38._m7 / _38._m8.y, mix(_38._m9.y / _988, _38._m8.y / _1003, 0.75), _1111)), vec2(0.0), vec2(0.0));
                    float _1194;
                    SPIRV_CROSS_BRANCH
                    if (((2.0 < _38._m11) && true) && (_1121 < 1.0))
                    {
                        vec4 _1153 = _983 * _38._m10[2u];
                        vec2 _1164 = clamp((vec2(1.0) - abs((clamp(_1153.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _997, vec2(0.0), vec2(1.0));
                        float _1165 = _1153.z;
                        float _1193;
                        SPIRV_CROSS_BRANCH
                        if (((_1164.x * _1164.y) * clamp((clamp(_1165, 0.0, 1.0) * _38._m8.z) / (_38._m9.z * _989), 0.0, 1.0)) > 0.0)
                        {
                            _1193 = fma(_1139, _1121, fma(-_1120, _1117, 1.0) * textureGrad(sampler2DArrayShadow(_24, _25), vec4(vec3(_1153.xy, 2.0), fma(_38._m7 / _38._m8.z, mix(_38._m9.z / _988, _38._m8.z / _1003, 0.75), _1165)), vec2(0.0), vec2(0.0)));
                        }
                        else
                        {
                            _1193 = _1139 * _1121;
                        }
                        _1194 = _1193;
                    }
                    else
                    {
                        _1194 = fma(_1139, _1121, fma(-_1120, _1117, 1.0));
                    }
                    _1195 = _1194;
                    _1196 = true;
                    break;
                }
                else
                {
                    _1195 = _1086;
                    _1196 = false;
                    break;
                }
                break; // unreachable workaround
            } while(false);
            float _1359;
            if ((!_1196) && (_38._m11 > 2.0))
            {
                float _1302;
                bool _1303;
                do
                {
                    vec4 _1206 = _983 * _38._m10[2u];
                    vec2 _1217 = clamp((vec2(1.0) - abs((clamp(_1206.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _997, vec2(0.0), vec2(1.0));
                    float _1218 = _1206.z;
                    float _1224 = clamp((clamp(_1218, 0.0, 1.0) * _38._m8.z) / (_38._m9.z * _989), 0.0, 1.0);
                    float _1227 = _1217.x * _1217.y;
                    float _1228 = _1227 * _1224;
                    SPIRV_CROSS_BRANCH
                    if (_1228 > 0.0)
                    {
                        float _1246 = textureGrad(sampler2DArrayShadow(_24, _25), vec4(vec3(_1206.xy, 2.0), fma(_38._m7 / _38._m8.z, mix(_38._m9.z / _988, _38._m8.z / _1003, 0.75), _1218)), vec2(0.0), vec2(0.0));
                        float _1301;
                        SPIRV_CROSS_BRANCH
                        if (((3.0 < _38._m11) && true) && (_1228 < 1.0))
                        {
                            vec4 _1260 = _983 * _38._m10[3u];
                            vec2 _1271 = clamp((vec2(1.0) - abs((clamp(_1260.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _997, vec2(0.0), vec2(1.0));
                            float _1272 = _1260.z;
                            float _1300;
                            SPIRV_CROSS_BRANCH
                            if (((_1271.x * _1271.y) * clamp((clamp(_1272, 0.0, 1.0) * _38._m8.w) / (_38._m9.w * _989), 0.0, 1.0)) > 0.0)
                            {
                                _1300 = fma(_1246, _1228, fma(-_1227, _1224, 1.0) * textureGrad(sampler2DArrayShadow(_24, _25), vec4(vec3(_1260.xy, 3.0), fma(_38._m7 / _38._m8.w, mix(_38._m9.w / _988, _38._m8.w / _1003, 0.75), _1272)), vec2(0.0), vec2(0.0)));
                            }
                            else
                            {
                                _1300 = _1246 * _1228;
                            }
                            _1301 = _1300;
                        }
                        else
                        {
                            _1301 = fma(_1246, _1228, fma(-_1227, _1224, 1.0));
                        }
                        _1302 = _1301;
                        _1303 = true;
                        break;
                    }
                    else
                    {
                        _1302 = _1195;
                        _1303 = false;
                        break;
                    }
                    break; // unreachable workaround
                } while(false);
                float _1358;
                if ((!_1303) && (_38._m11 > 3.0))
                {
                    float _1357;
                    do
                    {
                        vec4 _1313 = _983 * _38._m10[3u];
                        vec2 _1324 = clamp((vec2(1.0) - abs((clamp(_1313.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _997, vec2(0.0), vec2(1.0));
                        float _1325 = _1313.z;
                        float _1331 = clamp((clamp(_1325, 0.0, 1.0) * _38._m8.w) / (_38._m9.w * _989), 0.0, 1.0);
                        float _1334 = _1324.x * _1324.y;
                        float _1335 = _1334 * _1331;
                        SPIRV_CROSS_BRANCH
                        if (_1335 > 0.0)
                        {
                            _1357 = fma(textureGrad(sampler2DArrayShadow(_24, _25), vec4(vec3(_1313.xy, 3.0), fma(_38._m7 / _38._m8.w, mix(_38._m9.w / _988, _38._m8.w / _1003, 0.75), _1325)), vec2(0.0), vec2(0.0)), _1335, fma(-_1334, _1331, 1.0));
                            break;
                        }
                        else
                        {
                            _1357 = _1302;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _1358 = _1357;
                }
                else
                {
                    _1358 = _1302;
                }
                _1359 = _1358;
            }
            else
            {
                _1359 = _1195;
            }
            _1360 = _1359;
        }
        else
        {
            _1360 = _1086;
        }
        _1365 = spvNMax(0.0, pow(spvNMax(abs(_1360), 9.9999997473787516355514526367188e-05), 2.2000000476837158203125));
    }
    else
    {
        _1365 = 1.0;
    }
    vec3 _1368 = mix(mix(_51._m0, _51._m2, vec3(clamp(1.0 - pow(spvNMax(abs(1.0 - clamp(fma(_760.x, _15._m4, _405) / spvNMax(_51._m39, 9.9999997473787516355514526367188e-05), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _51._m40), 0.0, 1.0))), _51._m6, vec3(_837)) * 1.0;
    vec3 _1371 = vec3(0.1599999964237213134765625 * (_904 * _904));
    vec3 _1372 = dFdx(_756);
    vec3 _1373 = dFdy(_756);
    float _1381 = spvNMax(0.0900000035762786865234375, sqrt(clamp(fma(_967, _967, spvNMin(dot(_1372, _1372) + dot(_1373, _1373), 0.180000007152557373046875)), 0.0, 1.0)));
    vec3 _1385 = normalize(-_6);
    ivec2 _1391 = ivec2(uvec2(gl_FragCoord.xy) / uvec2(_38._m25));
    vec3 _1965;
    vec3 _1966;
    vec3 _1967;
    SPIRV_CROSS_BRANCH
    if (_14._m19 > 0.0)
    {
        vec3 _1425 = vec3(0.0, 636100.0, 0.0) + _15._m6;
        float _1426 = length(_1425);
        bool _1430 = _1426 < (0.89999997615814208984375 * _45._m0);
        vec3 _1437;
        float _1438;
        if (_1430)
        {
            vec3 _1435 = _1425;
            _1435.z = _1425.z + _45._m0;
            _1437 = _1435;
            _1438 = length(_1435);
        }
        else
        {
            _1437 = _1425;
            _1438 = _1426;
        }
        float _1441 = dot(_1437 / vec3(_1438), _14._m36);
        float _1442 = _45._m0 / _1438;
        vec3 _1466 = vec3(0.0, 636100.0, 0.0) + _397;
        float _1467 = length(_1466);
        vec3 _1471 = (_1466 / vec3(_1467)) * spvNMax(_1467, 636100.0);
        vec3 _1472 = _1471 - _1425;
        float _1473 = length(_1472);
        vec3 _1475 = _1472 / vec3(_1473);
        vec3 _1485;
        vec3 _1486;
        float _1487;
        if (_1430)
        {
            vec3 _1480 = _1425;
            _1480.z = _1425.z + _45._m0;
            vec3 _1483 = _1471;
            _1483.z = _1471.z + _45._m0;
            _1485 = _1483;
            _1486 = _1480;
            _1487 = length(_1480);
        }
        else
        {
            _1485 = _1471;
            _1486 = _1425;
            _1487 = _1426;
        }
        float _1488 = dot(_1486, _1475);
        float _1497 = spvNMax((-_1488) - sqrt(fma(_45._m1, _45._m1, fma(_1488, _1488, -(_1487 * _1487)))), 0.0);
        bool _1500 = (_1497 > 0.0) && (_1497 < _1473);
        vec3 _1508;
        float _1509;
        float _1510;
        if (_1500)
        {
            _1508 = _1486 + (_1475 * _1497);
            _1509 = _1473 - _1497;
            _1510 = (_1488 + _1497) / _45._m1;
        }
        else
        {
            _1508 = _1486;
            _1509 = _1473;
            _1510 = _1488 / _1487;
        }
        float _1511 = _1500 ? _45._m1 : _1487;
        vec3 _1948;
        vec3 _1949;
        if (_1511 <= _45._m1)
        {
            float _1516 = dot(_1475, _14._m36);
            float _1518 = dot(_1508, _14._m36) / _1511;
            float _1519 = _45._m0 + 600.0;
            bool _1520 = _1511 < _1519;
            vec3 _1525;
            if (_1520)
            {
                _1525 = _1485 * (_1519 / _1511);
            }
            else
            {
                _1525 = _1485;
            }
            float _1526 = _1520 ? _1519 : _1511;
            float _1527 = length(_1525);
            float _1528 = dot(_1525, _1475);
            float _1530 = dot(_1525, _14._m36) / _1527;
            vec2 _1541 = vec2(_1510, _1510 + (_1509 / _1526));
            vec2 _1542 = _1541 * sqrt((0.5 / _45._m4) * _1526);
            vec2 _1545 = vec2(ivec2(sign(_1542)));
            vec2 _1546 = _1542 * _1542;
            float _1560 = -_1509;
            float _1562 = 2.0 * _1526;
            float _1564 = (_1509 / _1562) + _1510;
            float _1572 = _45._m0 - _1526;
            vec2 _1587 = _1541 * sqrt((0.5 / _45._m6) * _1526);
            vec2 _1590 = vec2(ivec2(sign(_1587)));
            vec2 _1591 = _1587 * _1587;
            vec3 _1621 = exp(((-_45._m5) * ((sqrt((6.283100128173828125 * _45._m4) * _1526) * exp(_1572 / _45._m4)) * (((_1545.y > _1545.x) ? exp(_1546.x) : 0.0) + dot((_1545 / ((abs(_1542) * 2.3192999362945556640625) + sqrt((_1546 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1560 / _45._m4) * _1564)), vec2(1.0, -1.0))))) - (_45._m8 * ((sqrt((6.283100128173828125 * _45._m6) * _1526) * exp(_1572 / _45._m6)) * (((_1590.y > _1590.x) ? exp(_1591.x) : 0.0) + dot((_1590 / ((abs(_1587) * 2.3192999362945556640625) + sqrt((_1591 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1560 / _45._m6) * _1564)), vec2(1.0, -1.0))))));
            vec3 _1622 = spvNMin(_1621, vec3(1.0));
            float _1623 = _45._m0 / _1526;
            float _1626 = sqrt(fma(-_1623, _1623, 1.0));
            float _1628 = _1510 - (-_1626);
            vec4 _1911;
            if (abs(_1628) < 0.0040000001899898052215576171875)
            {
                float _1736 = (-0.0040000001899898052215576171875) - _1626;
                float _1738 = fma(_1526, _1526, _1509 * _1509);
                float _1739 = _1562 * _1509;
                float _1741 = sqrt(fma(_1739, _1736, _1738));
                float _1742 = fma(_1526, _1736, _1509);
                float _1745 = -(_45._m0 * _45._m0);
                float _1747 = sqrt(fma(_45._m1, _45._m1, _1745));
                float _1749 = sqrt(fma(_1526, _1526, _1745));
                float _1750 = _1526 * _1736;
                float _1752 = -(_1526 * _1526);
                float _1754 = fma(_45._m0, _45._m0, fma(_1750, _1750, _1752));
                vec4 _1760 = vec4(-1.0, _1747 * _1747, _1747, 0.50390625);
                vec4 _1761 = mix(_1760, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1750 < 0.0) && (_1754 > 0.0)));
                float _1763 = fma(_1749 / _1747, 0.96875, 0.015625);
                float _1773 = fma(fma(_1750, _1761.x, sqrt(_1754 + _1761.y)) / (_1749 + _1761.z), 0.4921875, _1761.w);
                float _1779 = _1516 + 1.0;
                float _1781 = floor(_1779 * 3.5);
                float _1783 = fma(_1779, 3.5, -_1781);
                float _1784 = _1781 + fma(fma(atan(spvNMax(_1518, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1785 = _1784 * 0.125;
                float _1789 = 1.0 - _1783;
                float _1792 = (_1784 + 1.0) * 0.125;
                float _1799 = sqrt(fma(_1741, _1741, _1745));
                float _1803 = fma(_45._m0, _45._m0, fma(_1742, _1742, -(_1741 * _1741)));
                vec4 _1808 = mix(_1760, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1742 < 0.0) && (_1803 > 0.0)));
                float _1810 = fma(_1799 / _1747, 0.96875, 0.015625);
                float _1820 = fma(fma(_1742, _1808.x, sqrt(_1803 + _1808.y)) / (_1799 + _1808.z), 0.4921875, _1808.w);
                float _1826 = _1781 + fma(fma(atan(spvNMax(_1530, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1827 = _1826 * 0.125;
                float _1833 = (_1826 + 1.0) * 0.125;
                vec4 _1839 = _1622.xyzx;
                float _1843 = 0.0040000001899898052215576171875 - _1626;
                float _1845 = sqrt(fma(_1739, _1843, _1738));
                float _1846 = fma(_1526, _1843, _1509);
                float _1847 = _1526 * _1843;
                float _1849 = fma(_45._m0, _45._m0, fma(_1847, _1847, _1752));
                vec4 _1854 = mix(_1760, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1847 < 0.0) && (_1849 > 0.0)));
                float _1864 = fma(fma(_1847, _1854.x, sqrt(_1849 + _1854.y)) / (_1749 + _1854.z), 0.4921875, _1854.w);
                float _1875 = sqrt(fma(_1845, _1845, _1745));
                float _1879 = fma(_45._m0, _45._m0, fma(_1846, _1846, -(_1845 * _1845)));
                vec4 _1884 = mix(_1760, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1846 < 0.0) && (_1879 > 0.0)));
                float _1886 = fma(_1875 / _1747, 0.96875, 0.015625);
                float _1896 = fma(fma(_1846, _1884.x, sqrt(_1879 + _1884.y)) / (_1875 + _1884.z), 0.4921875, _1884.w);
                _1911 = mix(spvNMax(fma(-((textureLod(sampler3D(_47, _21), vec3(_1827, _1820, _1810), 0.0) * _1789) + (textureLod(sampler3D(_47, _21), vec3(_1833, _1820, _1810), 0.0) * _1783)), _1839, (textureLod(sampler3D(_47, _21), vec3(_1785, _1773, _1763), 0.0) * _1789) + (textureLod(sampler3D(_47, _21), vec3(_1792, _1773, _1763), 0.0) * _1783)), vec4(0.0)), spvNMax(fma(-((textureLod(sampler3D(_47, _21), vec3(_1827, _1896, _1886), 0.0) * _1789) + (textureLod(sampler3D(_47, _21), vec3(_1833, _1896, _1886), 0.0) * _1783)), _1839, (textureLod(sampler3D(_47, _21), vec3(_1785, _1864, _1763), 0.0) * _1789) + (textureLod(sampler3D(_47, _21), vec3(_1792, _1864, _1763), 0.0) * _1783)), vec4(0.0)), vec4((_1628 + 0.0040000001899898052215576171875) * 124.99999237060546875));
            }
            else
            {
                float _1636 = -(_45._m0 * _45._m0);
                float _1638 = sqrt(fma(_45._m1, _45._m1, _1636));
                float _1640 = sqrt(fma(_1526, _1526, _1636));
                float _1641 = _1526 * _1510;
                float _1645 = fma(_45._m0, _45._m0, fma(_1641, _1641, -(_1526 * _1526)));
                vec4 _1651 = vec4(-1.0, _1638 * _1638, _1638, 0.50390625);
                vec4 _1652 = mix(_1651, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1641 < 0.0) && (_1645 > 0.0)));
                float _1654 = fma(_1640 / _1638, 0.96875, 0.015625);
                float _1664 = fma(fma(_1641, _1652.x, sqrt(_1645 + _1652.y)) / (_1640 + _1652.z), 0.4921875, _1652.w);
                float _1670 = _1516 + 1.0;
                float _1672 = floor(_1670 * 3.5);
                float _1674 = fma(_1670, 3.5, -_1672);
                float _1675 = _1672 + fma(fma(atan(spvNMax(_1518, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1680 = 1.0 - _1674;
                float _1690 = sqrt(fma(_1527, _1527, _1636));
                float _1694 = fma(_45._m0, _45._m0, fma(_1528, _1528, -(_1527 * _1527)));
                vec4 _1699 = mix(_1651, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1528 < 0.0) && (_1694 > 0.0)));
                float _1701 = fma(_1690 / _1638, 0.96875, 0.015625);
                float _1711 = fma(fma(_1528, _1699.x, sqrt(_1694 + _1699.y)) / (_1690 + _1699.z), 0.4921875, _1699.w);
                float _1717 = _1672 + fma(fma(atan(spvNMax(_1530, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                _1911 = spvNMax(fma(-((textureLod(sampler3D(_47, _21), vec3(_1717 * 0.125, _1711, _1701), 0.0) * _1680) + (textureLod(sampler3D(_47, _21), vec3((_1717 + 1.0) * 0.125, _1711, _1701), 0.0) * _1674)), _1622.xyzx, (textureLod(sampler3D(_47, _21), vec3(_1675 * 0.125, _1664, _1654), 0.0) * _1680) + (textureLod(sampler3D(_47, _21), vec3((_1675 + 1.0) * 0.125, _1664, _1654), 0.0) * _1674)), vec4(0.0));
            }
            float _1926 = fma(_1516, _1516, 1.0);
            _1948 = _1622;
            _1949 = (_1911.xyz * (0.0596831031143665313720703125 * _1926)) + ((((_1911.xyz * (_1911.w * smoothstep(0.0, 0.0199999995529651641845703125, _1518))) / vec3(spvNMax(_1911.x, 9.9999997473787516355514526367188e-05))) * (vec3(_45._m5.x) / _45._m5)) * ((((0.119366206228733062744140625 * fma(-_45._m9, _45._m9, 1.0)) * (-pow(spvNMax(abs(abs(fma(_45._m9 * (-2.0), _1516, fma(_45._m9, _45._m9, 1.0)))), 9.9999997473787516355514526367188e-05), 1.5))) * _1926) / fma(_45._m9, _45._m9, 2.0)));
        }
        else
        {
            _1948 = vec3(1.0);
            _1949 = vec3(0.0);
        }
        vec3 _1964;
        if (_14._m35 == 0.0)
        {
            _1964 = ((mix(textureLod(sampler2D(_46, _21), vec2(atan((_1441 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_1438 - _45._m0) / (_45._m1 - _45._m0))), 0.0).xyz, vec3(0.0), bvec3(_1441 < (-sqrt(fma(-_1442, _1442, 1.0))))) * 1.0) * _14._m34) * _14._m20;
        }
        else
        {
            _1964 = _14._m2;
        }
        _1965 = _1949 * (_14._m19 * 10.0);
        _1966 = _1948;
        _1967 = _1964;
    }
    else
    {
        _1965 = vec3(0.0);
        _1966 = vec3(1.0);
        _1967 = _14._m2;
    }
    float _2051;
    SPIRV_CROSS_BRANCH
    if (_14._m21 > 0.0)
    {
        vec3 _1990 = _15._m6 + _6;
        vec3 _1997 = vec3(0.0, _14._m18.z, 0.0) + (_1990 - vec3(0.0, _14._m25, 0.0));
        float _2001 = dot(_1997, _14._m24);
        vec2 _2011 = ((((_1997 + (_14._m24 * (sqrt(fma(_2001, _2001, fma(_14._m18.z, _14._m18.z, -dot(_1997, _1997)))) - _2001))).xz * _14._m18.w) * 0.5) + vec2(0.5)) + _14._m18.xy;
        _2011.x = 1.0 - _2011.x;
        vec3 _2024 = vec3(0.0, _14._m23.z, 0.0) + (_1990 - vec3(0.0, _14._m27, 0.0));
        float _2028 = dot(_2024, _14._m26);
        vec2 _2038 = ((((_2024 + (_14._m26 * (sqrt(fma(_2028, _2028, fma(_14._m23.z, _14._m23.z, -dot(_2024, _2024)))) - _2028))).xz * _14._m23.w) * 0.5) + vec2(0.5)) + _14._m23.xy;
        _2038.x = 1.0 - _2038.x;
        _2051 = _1365 * (1.0 - clamp(smoothstep(0.0500000007450580596923828125, 0.550000011920928955078125, mix(textureLod(sampler2D(_48, _21), _2011, 0.0).x, textureLod(sampler2D(_49, _21), _2038, 0.0).x, _14._m16)) * _14._m21, 0.0, 1.0));
    }
    else
    {
        _2051 = _1365;
    }
    float _2140;
    SPIRV_CROSS_BRANCH
    if (_14._m17 > 0.0)
    {
        vec3 _2078 = _15._m6 + _6;
        vec3 _2086 = vec3(0.0, _14._m28.z, 0.0) + ((_14._m29 + _2078) - vec3(0.0, _14._m30, 0.0));
        float _2090 = dot(_2086, _14._m24);
        vec2 _2100 = ((((_2086 + (_14._m24 * (sqrt(fma(_2090, _2090, fma(_14._m28.z, _14._m28.z, -dot(_2086, _2086)))) - _2090))).xz * _14._m28.w) * 0.5) + vec2(0.5)) + _14._m28.xy;
        _2100.x = 1.0 - _2100.x;
        vec3 _2114 = vec3(0.0, _14._m31.z, 0.0) + ((_14._m32 + _2078) - vec3(0.0, _14._m33, 0.0));
        float _2118 = dot(_2114, _14._m26);
        vec2 _2128 = ((((_2114 + (_14._m26 * (sqrt(fma(_2118, _2118, fma(_14._m31.z, _14._m31.z, -dot(_2114, _2114)))) - _2118))).xz * _14._m31.w) * 0.5) + vec2(0.5)) + _14._m31.xy;
        _2128.x = 1.0 - _2128.x;
        _2140 = _2051 * (1.0 - clamp(mix(textureLod(sampler2D(_41, _21), _2100, 0.0).x, textureLod(sampler2D(_42, _21), _2128, 0.0).x, _14._m16) * _14._m17, 0.0, 1.0));
    }
    else
    {
        _2140 = _2051;
    }
    float _2147 = fract(52.98291778564453125 * fract(fma(0.067110560834407806396484375, gl_FragCoord.x, 0.005837149918079376220703125 * gl_FragCoord.y)));
    float _2154 = clamp(fma(_38._m34.y, length(_6), _38._m34.x), 0.0, 1.0);
    uint _2155 = uint(int(fma(fma(float(int(clamp(fma(log2(_4), _38._m21, _38._m22), 0.0, float(_38._m26)))), _38._m24, float(_1391.y)), _38._m23, float(_1391.x))));
    uvec4 _2158 = uvec4(_26._m0[_2155]);
    uint _2159 = _2158.x;
    uint _2160 = _2158.y;
    uint _2163 = ((_2160 >> 0u) & 4095u) + _2159;
    uint _2166 = ((_2160 >> 12u) & 4095u) + _2163;
    uint _2170 = ((_2158.z >> 0u) & 1023u) + _2166;
    float _2172 = spvNMax(dot(_756, _1385), 9.9999997473787516355514526367188e-06);
    float _2174;
    bool _2177;
    vec3 _2179;
    vec3 _2181;
    uint _2183;
    _2174 = _331;
    _2177 = false;
    _2179 = vec3(0.0);
    _2181 = vec3(0.0);
    _2183 = _2159;
    float _2175;
    bool _2178;
    vec3 _2180;
    vec3 _2182;
    for (; _2183 < _2163; _2174 = _2175, _2177 = _2178, _2179 = _2180, _2181 = _2182, _2183++)
    {
        uint _2190 = uint(_27._m0[_2183]);
        float _2208 = abs(_28._m0[_2190]._m5);
        if ((_28._m0[_2190]._m6 & (1u << (_50._m1 & 31u))) != 0u)
        {
            vec3 _2223 = _28._m0[_2190]._m0.xyz - _6;
            float _2224 = dot(_2223, _2223);
            vec3 _2227 = _2223 * inversesqrt(spvNMax(_2224, 1.0000000133514319600180897396058e-10));
            float _2228 = _28._m0[_2190]._m0.w * _28._m0[_2190]._m0.w;
            float _2466;
            bool _2467;
            vec3 _2468;
            vec3 _2469;
            if (_2224 < (1.0 / _2228))
            {
                vec3 _2233 = _1385 + _2227;
                vec3 _2237 = _2233 * inversesqrt(spvNMax(dot(_2233, _2233), 1.0000000133514319600180897396058e-10));
                float _2239 = clamp(dot(_2227, _2237), 0.0, 1.0);
                float _2241 = clamp(dot(_756, _2237), 0.0, 1.0);
                float _2243 = clamp(dot(_756, _2227), 0.0, 1.0);
                float _2244 = _2224 * _2228;
                float _2250 = pow(spvNMax(abs(clamp(fma(-_2244, _2244, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _28._m0[_2190]._m4);
                float _2260;
                if (_28._m0[_2190]._m5 < 0.0)
                {
                    _2260 = _2250 * fma(4.0, _2228, _2208);
                }
                else
                {
                    _2260 = _2250 * ((1.0 / spvNMax(_2224, 9.9999997473787516355514526367188e-05)) + _2208);
                }
                float _2262 = 0.079577468335628509521484375 * (_2243 * _2260);
                float _2397;
                bool _2398;
                float _2399;
                if ((_28._m0[_2190]._m7 & 1u) != 0u)
                {
                    uint _2287;
                    do
                    {
                        vec3 _2267 = -_2227;
                        float _2268 = dot(_2267, vec3(0.0, -0.57735025882720947265625, 0.8164966106414794921875));
                        float _2269 = dot(_2267, vec3(0.0, -0.57735025882720947265625, -0.8164966106414794921875));
                        float _2270 = dot(_2267, vec3(-0.8164966106414794921875, 0.57735025882720947265625, 0.0));
                        float _2274 = spvNMax(spvNMax(_2268, _2269), spvNMax(_2270, dot(_2267, vec3(0.8164966106414794921875, 0.57735025882720947265625, 0.0))));
                        if (_2274 == _2268)
                        {
                            _2287 = 0u;
                            break;
                        }
                        else
                        {
                            if (_2274 == _2269)
                            {
                                _2287 = 1u;
                                break;
                            }
                            else
                            {
                                if (_2274 == _2270)
                                {
                                    _2287 = 2u;
                                    break;
                                }
                                else
                                {
                                    _2287 = 3u;
                                    break;
                                }
                                break; // unreachable workaround
                            }
                            break; // unreachable workaround
                        }
                        break; // unreachable workaround
                    } while(false);
                    uint _2289 = uint(int(_28._m0[_2190]._m7 >> 2u)) + _2287;
                    float _2391;
                    bool _2392;
                    float _2393;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2243 <= 0.0) && true)
                        {
                            _2391 = _2174;
                            _2392 = _2177;
                            _2393 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2322 = _39._m0[_2289]._m0 * vec4(_6 + (_756 * ((3.5 * float(int(sign(_2243)))) * (_39._m0[_2289]._m4 * sqrt(_2224)))), 1.0);
                            vec3 _2326 = _2322.xyz / vec3(_2322.w);
                            vec2 _2329 = (_2326.xy * 0.5) + vec2(0.5);
                            _2329.y = 1.0 - _2329.y;
                            float _2338 = (_39._m0[_2289]._m5.y / _39._m0[_2289]._m6) / (_2326.z - _39._m0[_2289]._m5.x);
                            float _2343 = _2177 ? _2174 : 6.283185482025146484375;
                            float _2344 = _2147 * _2343;
                            vec2 _2345 = _39._m0[_2289]._m1 + _38._m33;
                            vec2 _2348 = (_39._m0[_2289]._m1 + vec2(_39._m0[_2289]._m2)) - _38._m33;
                            float _2350;
                            _2350 = 0.0;
                            for (int _2353 = 0; _2353 < 12; )
                            {
                                float _2358 = float(uint(_2353));
                                float _2361 = sqrt(_2358 + 0.5) * 0.288675129413604736328125;
                                float _2362 = fma(_2358, 2.3999631404876708984375, _2344);
                                vec2 _2370 = clamp(fma((vec3(cos(_2362), sin(_2362), _2361).xy * _2361) * 2.5, _38._m33, _2329), _2345, _2348);
                                vec2 _2373 = fract(fma(vec2(1.0) / _38._m33, _2370, vec2(0.5)));
                                vec4 _2379 = vec4(lessThan(vec4(_2338), textureGather(sampler2D(_40, _31), _2370)));
                                float _2382 = _2373.x;
                                _2350 += clamp(mix(mix(_2379.w, _2379.z, _2382), mix(_2379.x, _2379.y, _2382), _2373.y), 0.0, 1.0);
                                _2353++;
                                continue;
                            }
                            _2391 = _2343;
                            _2392 = _2177 ? _2177 : true;
                            _2393 = _2350 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2397 = _2391;
                    _2398 = _2392;
                    _2399 = _2262 * mix(1.0, _2393, spvNMin(_2154, _28._m0[_2190]._m8));
                }
                else
                {
                    _2397 = _2174;
                    _2398 = _2177;
                    _2399 = _2262;
                }
                vec3 _2464;
                vec3 _2465;
                if (_2243 > 0.0)
                {
                    vec3 _2405 = _28._m0[_2190]._m1.xyz * (_2399 * ((_28._m0[_2190]._m3 < 0.0) ? _20._m0[0u] : 1.0));
                    vec3 _2412 = vec3(fma((2.0 * _2239) * _2239, _1381, mix(0.0, 0.5, _1381))) - vec3(1.0);
                    float _2433 = (_1381 + 1.0) * 0.5;
                    float _2434 = _1381 * _1381;
                    float _2442 = _2433 * _2433;
                    float _2454 = _2434 * _2434;
                    float _2457 = fma(fma(_2241, _2454, -_2241), _2241, 1.0);
                    _2464 = fma(_2405, (_1371 + ((vec3(1.0) - _1371) * pow(spvNMax(abs(1.0 - _2239), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2243, sqrt(fma(fma(-_2172, _2442, _2172), _2172, _2442)), _2172 * sqrt(fma(fma(-_2243, _2442, _2243), _2243, _2442)))) * (_2454 * (0.3183098733425140380859375 / (_2457 * _2457)))), _2179);
                    _2465 = fma(_2405, _1368 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2412 * pow(spvNMax(abs(1.0 - _2243), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2412 * pow(spvNMax(abs(1.0 - _2172), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1381))), _2181);
                }
                else
                {
                    _2464 = _2179;
                    _2465 = _2181;
                }
                _2466 = _2397;
                _2467 = _2398;
                _2468 = _2464;
                _2469 = _2465;
            }
            else
            {
                _2466 = _2174;
                _2467 = _2177;
                _2468 = _2179;
                _2469 = _2181;
            }
            _2175 = _2466;
            _2178 = _2467;
            _2180 = _2468;
            _2182 = _2469;
        }
        else
        {
            _2175 = _2174;
            _2178 = _2177;
            _2180 = _2179;
            _2182 = _2181;
        }
    }
    float _2471;
    bool _2474;
    vec3 _2476;
    vec3 _2478;
    uint _2480;
    _2471 = _2174;
    _2474 = _2177;
    _2476 = _2179;
    _2478 = _2181;
    _2480 = _2183;
    float _2472;
    bool _2475;
    vec3 _2477;
    vec3 _2479;
    for (; _2480 < _2166; _2471 = _2472, _2474 = _2475, _2476 = _2477, _2478 = _2479, _2480++)
    {
        uint _2487 = uint(_27._m0[_2480]);
        float _2500 = abs(_28._m0[_2487]._m5);
        if ((_28._m0[_2487]._m6 & (1u << (_50._m1 & 31u))) != 0u)
        {
            vec3 _2518 = _28._m0[_2487]._m0.xyz - _6;
            float _2519 = dot(_2518, _2518);
            vec3 _2522 = _2518 * inversesqrt(spvNMax(_2519, 1.0000000133514319600180897396058e-10));
            float _2523 = _28._m0[_2487]._m0.w * _28._m0[_2487]._m0.w;
            float _2751;
            bool _2752;
            vec3 _2753;
            vec3 _2754;
            if (_2519 < (1.0 / _2523))
            {
                vec3 _2528 = _1385 + _2522;
                vec3 _2532 = _2528 * inversesqrt(spvNMax(dot(_2528, _2528), 1.0000000133514319600180897396058e-10));
                float _2534 = clamp(dot(_2522, _2532), 0.0, 1.0);
                float _2536 = clamp(dot(_756, _2532), 0.0, 1.0);
                float _2538 = clamp(dot(_756, _2522), 0.0, 1.0);
                float _2541 = dot(-_2522, normalize(_28._m0[_2487]._m2.xyz));
                float _2570;
                if (_2541 > _28._m0[_2487]._m1.w)
                {
                    float _2545 = _2519 * _2523;
                    float _2551 = pow(spvNMax(abs(clamp(fma(-_2545, _2545, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _28._m0[_2487]._m4);
                    float _2561;
                    if (_28._m0[_2487]._m5 < 0.0)
                    {
                        _2561 = _2551 * fma(4.0, _2523, _2500);
                    }
                    else
                    {
                        _2561 = _2551 * ((1.0 / spvNMax(_2519, 9.9999997473787516355514526367188e-05)) + _2500);
                    }
                    float _2566 = clamp((_2541 - _28._m0[_2487]._m1.w) / spvNMax(_28._m0[_2487]._m2.w - _28._m0[_2487]._m1.w, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
                    _2570 = _2538 * (_2561 * (_2566 * _2566));
                }
                else
                {
                    _2570 = 0.0;
                }
                float _2571 = 0.3183098733425140380859375 * _2570;
                float _2682;
                bool _2683;
                float _2684;
                if ((_28._m0[_2487]._m7 & 1u) != 0u)
                {
                    uint _2574 = uint(int(_28._m0[_2487]._m7 >> 2u));
                    float _2676;
                    bool _2677;
                    float _2678;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2538 <= 0.0) && true)
                        {
                            _2676 = _2471;
                            _2677 = _2474;
                            _2678 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2607 = _39._m0[_2574]._m0 * vec4(_6 + (_756 * ((3.5 * float(int(sign(_2538)))) * (_39._m0[_2574]._m4 * sqrt(_2519)))), 1.0);
                            vec3 _2611 = _2607.xyz / vec3(_2607.w);
                            vec2 _2614 = (_2611.xy * 0.5) + vec2(0.5);
                            _2614.y = 1.0 - _2614.y;
                            float _2623 = (_39._m0[_2574]._m5.y / _39._m0[_2574]._m6) / (_2611.z - _39._m0[_2574]._m5.x);
                            float _2628 = _2474 ? _2471 : 6.283185482025146484375;
                            float _2629 = _2147 * _2628;
                            vec2 _2630 = _39._m0[_2574]._m1 + _38._m33;
                            vec2 _2633 = (_39._m0[_2574]._m1 + vec2(_39._m0[_2574]._m2)) - _38._m33;
                            float _2635;
                            _2635 = 0.0;
                            for (int _2638 = 0; _2638 < 12; )
                            {
                                float _2643 = float(uint(_2638));
                                float _2646 = sqrt(_2643 + 0.5) * 0.288675129413604736328125;
                                float _2647 = fma(_2643, 2.3999631404876708984375, _2629);
                                vec2 _2655 = clamp(fma((vec3(cos(_2647), sin(_2647), _2646).xy * _2646) * 2.5, _38._m33, _2614), _2630, _2633);
                                vec2 _2658 = fract(fma(vec2(1.0) / _38._m33, _2655, vec2(0.5)));
                                vec4 _2664 = vec4(lessThan(vec4(_2623), textureGather(sampler2D(_40, _31), _2655)));
                                float _2667 = _2658.x;
                                _2635 += clamp(mix(mix(_2664.w, _2664.z, _2667), mix(_2664.x, _2664.y, _2667), _2658.y), 0.0, 1.0);
                                _2638++;
                                continue;
                            }
                            _2676 = _2628;
                            _2677 = _2474 ? _2474 : true;
                            _2678 = _2635 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2682 = _2676;
                    _2683 = _2677;
                    _2684 = _2571 * mix(1.0, _2678, spvNMin(_2154, _28._m0[_2487]._m8));
                }
                else
                {
                    _2682 = _2471;
                    _2683 = _2474;
                    _2684 = _2571;
                }
                vec3 _2749;
                vec3 _2750;
                if (_2538 > 0.0)
                {
                    vec3 _2690 = _28._m0[_2487]._m1.xyz * (_2684 * ((_28._m0[_2487]._m3 < 0.0) ? _20._m0[0u] : 1.0));
                    vec3 _2697 = vec3(fma((2.0 * _2534) * _2534, _1381, mix(0.0, 0.5, _1381))) - vec3(1.0);
                    float _2718 = (_1381 + 1.0) * 0.5;
                    float _2719 = _1381 * _1381;
                    float _2727 = _2718 * _2718;
                    float _2739 = _2719 * _2719;
                    float _2742 = fma(fma(_2536, _2739, -_2536), _2536, 1.0);
                    _2749 = fma(_2690, (_1371 + ((vec3(1.0) - _1371) * pow(spvNMax(abs(1.0 - _2534), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2538, sqrt(fma(fma(-_2172, _2727, _2172), _2172, _2727)), _2172 * sqrt(fma(fma(-_2538, _2727, _2538), _2538, _2727)))) * (_2739 * (0.3183098733425140380859375 / (_2742 * _2742)))), _2476);
                    _2750 = fma(_2690, _1368 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2697 * pow(spvNMax(abs(1.0 - _2538), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2697 * pow(spvNMax(abs(1.0 - _2172), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1381))), _2478);
                }
                else
                {
                    _2749 = _2476;
                    _2750 = _2478;
                }
                _2751 = _2682;
                _2752 = _2683;
                _2753 = _2749;
                _2754 = _2750;
            }
            else
            {
                _2751 = _2471;
                _2752 = _2474;
                _2753 = _2476;
                _2754 = _2478;
            }
            _2472 = _2751;
            _2475 = _2752;
            _2477 = _2753;
            _2479 = _2754;
        }
        else
        {
            _2472 = _2471;
            _2475 = _2474;
            _2477 = _2476;
            _2479 = _2478;
        }
    }
    vec3 _2761;
    vec3 _2763;
    _2761 = _2476;
    _2763 = _2478;
    float _2757;
    bool _2760;
    vec3 _2762;
    vec3 _2764;
    float _2756 = _2471;
    bool _2759 = _2474;
    uint _2765 = _2480;
    for (; _2765 < _2170; _2756 = _2757, _2759 = _2760, _2761 = _2762, _2763 = _2764, _2765++)
    {
        uint _2772 = uint(_27._m0[_2765]);
        int _2801 = int(_29._m0[_2772]._m1 >> 1u) - 1;
        if (((_29._m0[_2772]._m4 & 16777215u) & (1u << (_50._m1 & 31u))) != 0u)
        {
            vec3 _2812 = _29._m0[_2772]._m6 * vec4(_6, 1.0);
            float _3200;
            bool _3201;
            vec3 _3202;
            vec3 _3203;
            if (all(lessThan(abs(_2812 - vec3(0.5)), vec3(0.5))))
            {
                vec3 _2819 = _1385 + _29._m0[_2772]._m9;
                vec3 _2823 = _2819 * inversesqrt(spvNMax(dot(_2819, _2819), 1.0000000133514319600180897396058e-10));
                float _2825 = clamp(dot(_29._m0[_2772]._m9, _2823), 0.0, 1.0);
                float _2827 = clamp(dot(_756, _2823), 0.0, 1.0);
                float _2829 = clamp(dot(_756, _29._m0[_2772]._m9), 0.0, 1.0);
                int _2830 = int(_29._m0[_2772]._m4 >> 24u);
                float _2831 = _2812.z;
                vec3 _2870;
                if (_2831 < _29._m0[_2772]._m2.x)
                {
                    float _2858 = _2831 * _29._m0[_2772]._m2.z;
                    float _2861 = _2858 * _2858;
                    vec3 _2869;
                    _2869.z = dot(_347[_2830], vec4(_2858, _2861, smoothstep(0.0, 1.0, _2858), (_2861 * _2858) * fma(_2858, fma(_2858, 6.0, -15.0), 10.0)));
                    _2870 = _2869;
                }
                else
                {
                    vec3 _2856;
                    if (_2831 > _29._m0[_2772]._m2.y)
                    {
                        float _2844 = (1.0 - _2831) * _29._m0[_2772]._m2.w;
                        float _2847 = _2844 * _2844;
                        vec3 _2855;
                        _2855.z = dot(_347[_2830], vec4(_2844, _2847, smoothstep(0.0, 1.0, _2844), (_2847 * _2844) * fma(_2844, fma(_2844, 6.0, -15.0), 10.0)));
                        _2856 = _2855;
                    }
                    else
                    {
                        _2856 = vec3(0.0, 0.0, 1.0);
                    }
                    _2870 = _2856;
                }
                vec2 _2871 = _2812.xy;
                vec2 _2875 = (vec2(0.5) - abs(_2871 - vec2(0.5))) * _29._m0[_2772]._m3;
                float _2876 = _2875.x;
                vec3 _2893;
                if (_2876 < 1.0)
                {
                    float _2884 = _2876 * _2876;
                    vec3 _2892 = _2870;
                    _2892.x = dot(_347[_2830], vec4(_2876, _2884, smoothstep(0.0, 1.0, _2876), (_2884 * _2876) * fma(_2876, fma(_2876, 6.0, -15.0), 10.0)));
                    _2893 = _2892;
                }
                else
                {
                    vec3 _2881 = _2870;
                    _2881.x = 1.0;
                    _2893 = _2881;
                }
                float _2894 = _2875.y;
                vec3 _2911;
                if (_2894 < 1.0)
                {
                    float _2902 = _2894 * _2894;
                    vec3 _2910 = _2893;
                    _2910.y = dot(_347[_2830], vec4(_2894, _2902, smoothstep(0.0, 1.0, _2894), (_2902 * _2894) * fma(_2894, fma(_2894, 6.0, -15.0), 10.0)));
                    _2911 = _2910;
                }
                else
                {
                    vec3 _2899 = _2893;
                    _2899.y = 1.0;
                    _2911 = _2899;
                }
                float _2917 = _2829 * ((_2911.x * _2911.y) * _2911.z);
                float _3022;
                bool _3023;
                float _3024;
                if ((_29._m0[_2772]._m8 & 1u) != 0u)
                {
                    uint _2920 = uint(int(_29._m0[_2772]._m8 >> 2u));
                    float _3016;
                    bool _3017;
                    float _3018;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2829 <= 0.0) && true)
                        {
                            _3016 = _2756;
                            _3017 = _2759;
                            _3018 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2951 = _39._m0[_2920]._m0 * vec4(_6 + (_756 * ((3.5 * float(int(sign(_2829)))) * _39._m0[_2920]._m4)), 1.0);
                            vec2 _2954 = (_2951.xy * 0.5) + vec2(0.5);
                            _2954.y = 1.0 - _2954.y;
                            float _2963 = ((_2951.z - _39._m0[_2920]._m5.y) / _39._m0[_2920]._m5.x) / _39._m0[_2920]._m6;
                            float _2968 = _2759 ? _2756 : 6.283185482025146484375;
                            float _2969 = _2147 * _2968;
                            vec2 _2970 = _39._m0[_2920]._m1 + _38._m33;
                            vec2 _2973 = (_39._m0[_2920]._m1 + vec2(_39._m0[_2920]._m2)) - _38._m33;
                            float _2975;
                            _2975 = 0.0;
                            for (int _2978 = 0; _2978 < 12; )
                            {
                                float _2983 = float(uint(_2978));
                                float _2986 = sqrt(_2983 + 0.5) * 0.288675129413604736328125;
                                float _2987 = fma(_2983, 2.3999631404876708984375, _2969);
                                vec2 _2995 = clamp(fma((vec3(cos(_2987), sin(_2987), _2986).xy * _2986) * 2.5, _38._m33, _2954), _2970, _2973);
                                vec2 _2998 = fract(fma(vec2(1.0) / _38._m33, _2995, vec2(0.5)));
                                vec4 _3004 = vec4(lessThan(vec4(_2963), textureGather(sampler2D(_40, _31), _2995)));
                                float _3007 = _2998.x;
                                _2975 += clamp(mix(mix(_3004.w, _3004.z, _3007), mix(_3004.x, _3004.y, _3007), _2998.y), 0.0, 1.0);
                                _2978++;
                                continue;
                            }
                            _3016 = _2968;
                            _3017 = _2759 ? _2759 : true;
                            _3018 = _2975 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _3022 = _3016;
                    _3023 = _3017;
                    _3024 = _2917 * mix(1.0, _3018, spvNMin(_2154, _29._m0[_2772]._m5));
                }
                else
                {
                    _3022 = _2756;
                    _3023 = _2759;
                    _3024 = _2917;
                }
                vec3 _3065;
                if (_2801 >= 0)
                {
                    uint _3029 = gl_SubgroupInvocationID & 3u;
                    vec2 _3035 = (subgroupQuadSwapHorizontal(_2871) - _2871) * (((_3029 & 1u) != 0u) ? (-1.0) : 1.0);
                    vec2 _3041 = (subgroupQuadSwapVertical(_2871) - _2871) * (((_3029 & 2u) != 0u) ? (-1.0) : 1.0);
                    vec2 _3045 = mix(_3035, vec2(0.0), bvec2(any(isnan(_3035))));
                    vec2 _3049 = mix(_3041, vec2(0.0), bvec2(any(isnan(_3041))));
                    bvec2 _3058 = bvec2(any(greaterThan(abs(vec4(_3045, _3049)), vec4(0.015625))));
                    int _89 = _2801;
                    _3065 = _29._m0[_2772]._m0 * textureGrad(nonuniformEXT(sampler2D(_44[_89], _21)), _2871, mix(_3045, vec2(0.0), _3058), mix(_3049, vec2(0.0), _3058)).xyz;
                }
                else
                {
                    _3065 = _29._m0[_2772]._m0;
                }
                vec3 _3198;
                vec3 _3199;
                SPIRV_CROSS_BRANCH
                if ((_29._m0[_2772]._m1 & 1u) != 0u)
                {
                    vec3 _3196;
                    vec3 _3197;
                    if (_2829 > 0.0)
                    {
                        vec3 _3137 = _3065 * (_3024 * _20._m0[0u]);
                        vec3 _3144 = vec3(fma((2.0 * _2825) * _2825, _1381, mix(0.0, 0.5, _1381))) - vec3(1.0);
                        float _3165 = (_1381 + 1.0) * 0.5;
                        float _3166 = _1381 * _1381;
                        float _3174 = _3165 * _3165;
                        float _3186 = _3166 * _3166;
                        float _3189 = fma(fma(_2827, _3186, -_2827), _2827, 1.0);
                        _3196 = fma(_3137, (_1371 + ((vec3(1.0) - _1371) * pow(spvNMax(abs(1.0 - _2825), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2829, sqrt(fma(fma(-_2172, _3174, _2172), _2172, _3174)), _2172 * sqrt(fma(fma(-_2829, _3174, _2829), _2829, _3174)))) * (_3186 * (0.3183098733425140380859375 / (_3189 * _3189)))), _2761);
                        _3197 = fma(_3137, _1368 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3144 * pow(spvNMax(abs(1.0 - _2829), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3144 * pow(spvNMax(abs(1.0 - _2172), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1381))), _2763);
                    }
                    else
                    {
                        _3196 = _2761;
                        _3197 = _2763;
                    }
                    _3198 = _3196;
                    _3199 = _3197;
                }
                else
                {
                    vec3 _3131;
                    vec3 _3132;
                    if (_2829 > 0.0)
                    {
                        vec3 _3072 = _3065 * _3024;
                        vec3 _3079 = vec3(fma((2.0 * _2825) * _2825, _1381, mix(0.0, 0.5, _1381))) - vec3(1.0);
                        float _3100 = (_1381 + 1.0) * 0.5;
                        float _3101 = _1381 * _1381;
                        float _3109 = _3100 * _3100;
                        float _3121 = _3101 * _3101;
                        float _3124 = fma(fma(_2827, _3121, -_2827), _2827, 1.0);
                        _3131 = fma(_3072, (_1371 + ((vec3(1.0) - _1371) * pow(spvNMax(abs(1.0 - _2825), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_2829, sqrt(fma(fma(-_2172, _3109, _2172), _2172, _3109)), _2172 * sqrt(fma(fma(-_2829, _3109, _2829), _2829, _3109)))) * (_3121 * (0.3183098733425140380859375 / (_3124 * _3124)))), _2761);
                        _3132 = fma(_3072, _1368 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3079 * pow(spvNMax(abs(1.0 - _2829), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3079 * pow(spvNMax(abs(1.0 - _2172), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1381))), _2763);
                    }
                    else
                    {
                        _3131 = _2761;
                        _3132 = _2763;
                    }
                    _3198 = _3131;
                    _3199 = _3132;
                }
                _3200 = _3022;
                _3201 = _3023;
                _3202 = _3198;
                _3203 = _3199;
            }
            else
            {
                _3200 = _2756;
                _3201 = _2759;
                _3202 = _2761;
                _3203 = _2763;
            }
            _2757 = _3200;
            _2760 = _3201;
            _2762 = _3202;
            _2764 = _3203;
        }
        else
        {
            _2757 = _2756;
            _2760 = _2759;
            _2762 = _2761;
            _2764 = _2763;
        }
    }
    vec3 _3205 = reflect(-_1385, _756);
    vec3 _3207 = vec3(_1371.x, _1371.y, _1371.z);
    vec3 _3217 = textureLod(samplerCube(_33, _21), _756, 0.0).xyz * _38._m27;
    vec3 _3224 = textureLod(samplerCube(_34, _21), _3205, fma(_1381, 8.0, _38._m30 - 8.0)).xyz * _38._m27;
    vec3 _3249;
    vec3 _3250;
    SPIRV_CROSS_BRANCH
    if (_38._m29 > 0.0)
    {
        vec3 _3239 = vec3(_38._m29);
        _3249 = mix(_3224, textureLod(samplerCube(_36, _21), _3205, fma(_1381, 8.0, _38._m31 - 8.0)).xyz * _38._m28, _3239);
        _3250 = mix(_3217, textureLod(samplerCube(_35, _21), _756, 0.0).xyz * _38._m28, _3239);
    }
    else
    {
        _3249 = _3224;
        _3250 = _3217;
    }
    float _3251 = spvNMax(dot(_1385, _756), 0.001953125);
    vec4 _3256 = textureLod(sampler2D(_37, _31), vec2(_3251, _1381), 0.0);
    uvec4 _3267 = uvec4(_26._m0[_2155]);
    uint _3269 = _3267.y;
    uint _3279 = ((_3267.z >> 0u) & 1023u) + (((_3269 >> 12u) & 4095u) + (((_3269 >> 0u) & 4095u) + _3267.x));
    uint _3281 = (_3269 >> 24u) + _3279;
    vec3 _3283;
    vec3 _3286;
    _3283 = _3249 * ((_3207 * _3256.x) + vec3(_3256.y));
    _3286 = _3250 * (_1368 * _3256.z);
    vec3 _3284;
    vec3 _3287;
    for (uint _3288 = _3279; _3288 < _3281; _3283 = _3284, _3286 = _3287, _3288++)
    {
        uint _3295 = uint(_27._m0[_3288]);
        int _3314 = int((_32._m0[_3295]._m5 >> 1u) & 3u);
        mat3 _3318 = mat3(_32._m0[_3295]._m1[0], _32._m0[_3295]._m1[1], _32._m0[_3295]._m1[2]);
        int _3324 = (int((_32._m0[_3295]._m5 >> 3u) & 16383u) - 1) * 2;
        int _3329 = (int((_32._m0[_3295]._m5 >> 17u) & 16383u) - 1) * 2;
        int _3334 = (int((_32._m0[_3295]._m6 >> 0u) & 65535u) - 1) * 2;
        int _3339 = (int((_32._m0[_3295]._m6 >> 16u) & 65535u) - 1) * 2;
        float _3342 = (_32._m0[_3295]._m3 < 0.0) ? (-_32._m0[_3295]._m3) : 1.0;
        vec3 _3344 = _3318 * (_6 - _32._m0[_3295]._m1[3]);
        bool _3345 = int(_32._m0[_3295]._m5 & 1u) == 1;
        vec3 _3346 = abs(_3344);
        float _3349 = dot(_3344, _3344);
        if (_3345 ? any(greaterThanEqual(_3346, _32._m0[_3295]._m0.xyz)) : (_3349 >= _32._m0[_3295]._m0.y))
        {
            _3284 = _3283;
            _3287 = _3286;
            continue;
        }
        vec3 _3523;
        SPIRV_CROSS_FLATTEN
        if ((_3314 & 1) != 0)
        {
            vec3 _3359 = _3318 * _756;
            vec2 _3448;
            bool _3449;
            if (_3345)
            {
                vec2 _3443;
                bool _3447;
                do
                {
                    vec3 _3427 = (_32._m0[_3295]._m0.xyz - _3344) / _3359;
                    vec3 _3430 = ((-_32._m0[_3295]._m0.xyz) - _3344) / _3359;
                    vec3 _3431 = spvNMin(_3427, _3430);
                    vec3 _3432 = spvNMax(_3427, _3430);
                    float _3437 = spvNMax(_3431.x, spvNMax(_3431.y, _3431.z));
                    float _3442 = spvNMin(_3432.x, spvNMin(_3432.y, _3432.z));
                    _3443 = vec2(_3437, _3442);
                    if (_3437 > _3442)
                    {
                        _3447 = false;
                        break;
                    }
                    _3447 = true;
                    break;
                } while(false);
                _3448 = _3443;
                _3449 = _3447;
            }
            else
            {
                vec2 _3422;
                bool _3423;
                do
                {
                    float _3365 = dot(_3359, _3359);
                    float _3366 = dot(_3359, _3344);
                    float _3367 = 2.0 * _3366;
                    float _3368 = _3349 - _32._m0[_3295]._m0.y;
                    float _3404;
                    float _3405;
                    bool _3406;
                    do
                    {
                        float _3374 = fma(_3367, _3367, -((4.0 * _3365) * _3368));
                        float _3402;
                        float _3403;
                        if (_3374 < 0.0)
                        {
                            _3404 = 0.0;
                            _3405 = 0.0;
                            _3406 = false;
                            break;
                        }
                        else
                        {
                            if (_3374 == 0.0)
                            {
                                float _3401 = (_3366 * (-1.0)) * (1.0 / _3365);
                                _3402 = _3401;
                                _3403 = _3401;
                            }
                            else
                            {
                                float _3394;
                                if (_3367 > 0.0)
                                {
                                    _3394 = (-0.5) * fma(2.0, _3366, sqrt(_3374));
                                }
                                else
                                {
                                    _3394 = (-0.5) * fma(2.0, _3366, -sqrt(_3374));
                                }
                                _3402 = _3368 * (1.0 / _3394);
                                _3403 = _3394 * (1.0 / _3365);
                            }
                        }
                        _3404 = _3402;
                        _3405 = _3403;
                        _3406 = true;
                        break;
                    } while(false);
                    if (!_3406)
                    {
                        _3422 = vec2(0.0);
                        _3423 = false;
                        break;
                    }
                    if ((_3405 < 0.0) && (_3404 < 0.0))
                    {
                        _3422 = vec2(0.0);
                        _3423 = false;
                        break;
                    }
                    vec2 _3421;
                    if (_3405 > _3404)
                    {
                        _3421 = vec2(_3404, _3405);
                    }
                    else
                    {
                        _3421 = vec2(_3405, _3404);
                    }
                    _3422 = _3421;
                    _3423 = true;
                    break;
                } while(false);
                _3448 = _3422;
                _3449 = _3423;
            }
            vec3 _3452 = _3344 + (_3359 * _3448.y);
            float _3473;
            if (_3345)
            {
                _3473 = 1.0 - clamp(length(spvNMax(_3346 - (_32._m0[_3295]._m0.xyz - vec3(_32._m0[_3295]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_32._m0[_3295]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3473 = clamp((_32._m0[_3295]._m0.x - length(_3344)) * (1.0 / spvNMax(_32._m0[_3295]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3476 = float(_3449) * smoothstep(0.0, 1.0, _3473);
            vec4 _3518;
            SPIRV_CROSS_BRANCH
            if (_3476 > 9.9999997473787516355514526367188e-05)
            {
                float _3485 = mix(clamp((_3448.y * (1.0 / length(_3452))) * _1381, 0.0, _1381), _1381, _1381);
                vec3 _3487 = mix(_3452, _3359, vec3(_3485));
                int _93 = _3324;
                vec4 _3488 = textureLod(nonuniformEXT(samplerCube(_43[_93], _21)), _3487, 0.0);
                int _97 = _3324 + 1;
                _3488.w = textureLod(nonuniformEXT(samplerCube(_43[_97], _21)), _3487, 0.0).x;
                vec4 _3503;
                SPIRV_CROSS_BRANCH
                if (_3329 >= 0)
                {
                    int _101 = _3329;
                    vec4 _3496 = textureLod(nonuniformEXT(samplerCube(_43[_101], _21)), _3487, 0.0);
                    int _105 = _3329 + 1;
                    _3496.w = textureLod(nonuniformEXT(samplerCube(_43[_105], _21)), _3487, 0.0).x;
                    _3503 = mix(_3488, _3496, vec4(_32._m0[_3295]._m3));
                }
                else
                {
                    _3503 = _3488;
                }
                vec4 _3504 = _3503 * _3342;
                vec3 _3513 = (_3504.xyz * _32._m0[_3295]._m4).xyz * (_1368 * textureLod(sampler2D(_37, _31), vec2(_3251, _3485), 0.0).z);
                vec4 _3514 = vec4(_3513.x, _3513.y, _3513.z, _3504.w);
                _3514.w = _3504.w * _3476;
                _3518 = _3514;
            }
            else
            {
                _3518 = vec4(0.0);
            }
            _3523 = mix(_3286, _3518.xyz, vec3(_3518.w));
        }
        else
        {
            _3523 = _3286;
        }
        vec3 _3702;
        SPIRV_CROSS_FLATTEN
        if ((_3314 & 2) != 0)
        {
            vec3 _3528 = _3318 * _3205;
            vec2 _3617;
            bool _3618;
            if (_3345)
            {
                vec2 _3612;
                bool _3616;
                do
                {
                    vec3 _3596 = (_32._m0[_3295]._m0.xyz - _3344) / _3528;
                    vec3 _3599 = ((-_32._m0[_3295]._m0.xyz) - _3344) / _3528;
                    vec3 _3600 = spvNMin(_3596, _3599);
                    vec3 _3601 = spvNMax(_3596, _3599);
                    float _3606 = spvNMax(_3600.x, spvNMax(_3600.y, _3600.z));
                    float _3611 = spvNMin(_3601.x, spvNMin(_3601.y, _3601.z));
                    _3612 = vec2(_3606, _3611);
                    if (_3606 > _3611)
                    {
                        _3616 = false;
                        break;
                    }
                    _3616 = true;
                    break;
                } while(false);
                _3617 = _3612;
                _3618 = _3616;
            }
            else
            {
                vec2 _3591;
                bool _3592;
                do
                {
                    float _3534 = dot(_3528, _3528);
                    float _3535 = dot(_3528, _3344);
                    float _3536 = 2.0 * _3535;
                    float _3537 = _3349 - _32._m0[_3295]._m0.y;
                    float _3573;
                    float _3574;
                    bool _3575;
                    do
                    {
                        float _3543 = fma(_3536, _3536, -((4.0 * _3534) * _3537));
                        float _3571;
                        float _3572;
                        if (_3543 < 0.0)
                        {
                            _3573 = 0.0;
                            _3574 = 0.0;
                            _3575 = false;
                            break;
                        }
                        else
                        {
                            if (_3543 == 0.0)
                            {
                                float _3570 = (_3535 * (-1.0)) * (1.0 / _3534);
                                _3571 = _3570;
                                _3572 = _3570;
                            }
                            else
                            {
                                float _3563;
                                if (_3536 > 0.0)
                                {
                                    _3563 = (-0.5) * fma(2.0, _3535, sqrt(_3543));
                                }
                                else
                                {
                                    _3563 = (-0.5) * fma(2.0, _3535, -sqrt(_3543));
                                }
                                _3571 = _3537 * (1.0 / _3563);
                                _3572 = _3563 * (1.0 / _3534);
                            }
                        }
                        _3573 = _3571;
                        _3574 = _3572;
                        _3575 = true;
                        break;
                    } while(false);
                    if (!_3575)
                    {
                        _3591 = vec2(0.0);
                        _3592 = false;
                        break;
                    }
                    if ((_3574 < 0.0) && (_3573 < 0.0))
                    {
                        _3591 = vec2(0.0);
                        _3592 = false;
                        break;
                    }
                    vec2 _3590;
                    if (_3574 > _3573)
                    {
                        _3590 = vec2(_3573, _3574);
                    }
                    else
                    {
                        _3590 = vec2(_3574, _3573);
                    }
                    _3591 = _3590;
                    _3592 = true;
                    break;
                } while(false);
                _3617 = _3591;
                _3618 = _3592;
            }
            vec3 _3621 = _3344 + (_3528 * _3617.y);
            float _3642;
            if (_3345)
            {
                _3642 = 1.0 - clamp(length(spvNMax(_3346 - (_32._m0[_3295]._m0.xyz - vec3(_32._m0[_3295]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_32._m0[_3295]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3642 = clamp((_32._m0[_3295]._m0.x - length(_3344)) * (1.0 / spvNMax(_32._m0[_3295]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3645 = float(_3618) * smoothstep(0.0, 1.0, _3642);
            vec4 _3697;
            SPIRV_CROSS_BRANCH
            if (_3645 > 9.9999997473787516355514526367188e-05)
            {
                float _3654 = mix(clamp((_3617.y * (1.0 / length(_3621))) * _1381, 0.0, _1381), _1381, _1381);
                vec3 _3656 = mix(_3621, _3528, vec3(_3654));
                float _3657 = _3654 * 8.0;
                int _109 = _3334;
                int _113 = _3334 + 1;
                vec4 _3665 = vec4(textureLod(nonuniformEXT(samplerCube(_43[_109], _21)), _3656, _3657).xyz, textureLod(nonuniformEXT(samplerCube(_43[_113], _21)), _3656, _3657).x);
                vec4 _3679;
                SPIRV_CROSS_BRANCH
                if (_3339 >= 0)
                {
                    int _117 = _3339;
                    int _121 = _3339 + 1;
                    _3679 = mix(_3665, vec4(textureLod(nonuniformEXT(samplerCube(_43[_117], _21)), _3656, _3657).xyz, textureLod(nonuniformEXT(samplerCube(_43[_121], _21)), _3656, _3657).x), vec4(_32._m0[_3295]._m3));
                }
                else
                {
                    _3679 = _3665;
                }
                vec4 _3680 = _3679 * _3342;
                vec4 _3685 = textureLod(sampler2D(_37, _31), vec2(_3251, _3654), 0.0);
                vec3 _3692 = (_3680.xyz * _32._m0[_3295]._m4).xyz * ((_3207 * _3685.x) + vec3(_3685.y));
                vec4 _3693 = vec4(_3692.x, _3692.y, _3692.z, _3680.w);
                _3693.w = _3680.w * _3645;
                _3697 = _3693;
            }
            else
            {
                _3697 = vec4(0.0);
            }
            _3702 = mix(_3283, _3697.xyz, vec3(_3697.w));
        }
        else
        {
            _3702 = _3283;
        }
        _3284 = _3702;
        _3287 = _3523;
    }
    float _3703 = _20._m0[0u] * 100.0;
    vec3 _3707 = _1967 * (_2140 * _20._m0[0u]);
    vec3 _3710 = reflect(_1385, _756);
    float _3714 = clamp(dot(_14._m0, normalize(_1385 + _14._m0)), 0.0, 1.0);
    float _3716 = clamp(dot(_756, _14._m0), 0.0, 1.0);
    vec3 _3723 = vec3(fma((2.0 * _3714) * _3714, _1381, mix(0.0, 0.5, _1381))) - vec3(1.0);
    float _3742 = dot(_14._m0, _3710);
    vec3 _3752 = mix(_3710, normalize((_14._m0 * 0.999989449977874755859375) + (normalize(_3710 - (_14._m0 * _3742)) * 0.0045900647528469562530517578125)), bvec3(_3742 < 0.999989449977874755859375));
    vec3 _3754 = normalize(_1385 + _3752);
    float _3758 = clamp(dot(_756, _3754), 0.0, 1.0);
    float _3760 = clamp(dot(_756, _3752), 0.0, 1.0);
    float _3762 = (_1381 + 1.0) * 0.5;
    float _3763 = _1381 * _1381;
    float _3771 = _3762 * _3762;
    float _3783 = _3763 * _3763;
    float _3786 = fma(fma(_3758, _3783, -_3758), _3758, 1.0);
    vec3 _3805 = (((_2763 + ((_3707 * (_1368 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3723 * pow(spvNMax(abs(1.0 - _3716), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3723 * pow(spvNMax(abs(1.0 - _2172), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _1381))))) * _3716)) + (_2761 + ((_3707 * ((_1371 + ((vec3(1.0) - _1371) * pow(spvNMax(abs(1.0 - clamp(dot(_3752, _3754), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 5.0))) * ((0.5 / fma(_3760, sqrt(fma(fma(-_2172, _3771, _2172), _2172, _3771)), _2172 * sqrt(fma(fma(-_3760, _3771, _3760), _3760, _3771)))) * (_3783 * (0.3183098733425140380859375 / (_3786 * _3786)))))) * _3716))) * mix(1.0, 1.0, _38._m1)) + (((_3286 * _3703) + (_3283 * _3703)) * 1.0);
    vec4 _3993;
    do
    {
        if (_38._m19[3].z < 0.0)
        {
            _3993 = vec4(0.0, 0.0, 0.0, 1.0);
            break;
        }
        float _3839;
        do
        {
            if (_10 <= _38._m19[0].x)
            {
                _3839 = fma(_38._m19[2].x, _10, _38._m19[3].x);
                break;
            }
            else
            {
                _3839 = _38._m19[1].y * log2(fma(_38._m19[2].y, _10, _38._m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        vec3 _3849 = (vec3(_394 / vec2(_38._m32, _38._m18), _3839) + vec3(float(_17._m5), 0.0, 0.0)) - vec3(0.5);
        vec3 _3850 = floor(_3849);
        vec3 _3851 = _3849 - _3850;
        vec3 _3852 = vec3(1.0) - _3851;
        vec3 _3859 = fma(-((_3851 * 0.5) * _3851), vec3(2.0) - _3851, vec3(0.666666686534881591796875));
        vec3 _3866 = (_3851 * 0.16666667163372039794921875) * _3851;
        vec3 _3868 = fma((_3852 * 0.16666667163372039794921875) * _3852, _3852, _3859);
        vec3 _3875 = _38._m17 * (((_3859 / _3868) - vec3(0.5)) + _3850);
        vec3 _3879 = _38._m17 * ((((_3866 * _3851) / fma(_3866, _3851, fma(-((_3852 * 0.5) * _3852), _3851 + vec3(1.0), vec3(0.666666686534881591796875)))) + vec3(1.5)) + _3850);
        float _3887 = _3875.z;
        float _3893 = _3879.x;
        vec2 _3897 = spvNMax(_38._m15, spvNMin(_38._m16, vec2(_3893, _3875.y)));
        float _3898 = _3897.x;
        vec4 _3904 = vec4(_3868.x);
        float _3906 = _3875.x;
        vec2 _3910 = spvNMax(_38._m15, spvNMin(_38._m16, vec2(_3906, _3879.y)));
        float _3911 = _3910.x;
        vec4 _3926 = vec4(_3868.y);
        float _3931 = _3879.z;
        vec4 _3957 = mix(mix(mix(textureLod(sampler3D(_30, _31), vec3(spvNMax(_38._m15, spvNMin(_38._m16, _3879.xy)), _3931), 0.0), textureLod(sampler3D(_30, _31), vec3(_3911, _3910.y, _3931), 0.0), _3904), mix(textureLod(sampler3D(_30, _31), vec3(_3898, _3897.y, _3931), 0.0), textureLod(sampler3D(_30, _31), vec3(spvNMax(_38._m15, spvNMin(_38._m16, vec2(_3906, _3875.y))), _3931), 0.0), _3904), _3926), mix(mix(textureLod(sampler3D(_30, _31), vec3(spvNMax(_38._m15, spvNMin(_38._m16, vec2(_3893, _3879.y))), _3887), 0.0), textureLod(sampler3D(_30, _31), vec3(_3911, _3910.y, _3887), 0.0), _3904), mix(textureLod(sampler3D(_30, _31), vec3(_3898, _3897.y, _3887), 0.0), textureLod(sampler3D(_30, _31), vec3(spvNMax(_38._m15, spvNMin(_38._m16, _3875.xy)), _3887), 0.0), _3904), _3926), vec4(_3868.z)) * vec4(0.03125, 0.03125, 0.03125, 3.0517578125e-05);
        vec4 _3965;
        if (isinf(_3957.x) || isnan(_3957.x))
        {
            vec4 _3964 = _3957;
            _3964.x = 0.0;
            _3965 = _3964;
        }
        else
        {
            _3965 = _3957;
        }
        vec4 _3973;
        if (isinf(_3965.y) || isnan(_3965.y))
        {
            vec4 _3972 = _3965;
            _3972.y = 0.0;
            _3973 = _3972;
        }
        else
        {
            _3973 = _3965;
        }
        vec4 _3981;
        if (isinf(_3973.z) || isnan(_3973.z))
        {
            vec4 _3980 = _3973;
            _3980.z = 0.0;
            _3981 = _3980;
        }
        else
        {
            _3981 = _3973;
        }
        vec4 _3989;
        if (isinf(_3981.w) || isnan(_3981.w))
        {
            vec4 _3988 = _3981;
            _3988.w = 0.0;
            _3989 = _3988;
        }
        else
        {
            _3989 = _3981;
        }
        vec4 _3992 = _3989;
        _3992.w = 1.0 - _3989.w;
        _3993 = _3992;
        break;
    } while(false);
    vec2 _4003 = (((texture(sampler2D(_54, _18), _5).xy - vec2(0.5)) * 0.5) * vec2(-1.0, 1.0)) * 1.0;
    vec4 _4005 = texture(sampler2D(_55, _52), _455);
    float _4006 = _4005.x;
    float _4008 = fma(_13._m0, _51._m35, _4006 * _51._m20);
    float _4009 = fract(_4008);
    vec4 _4014 = texture(sampler2D(_57, _18), fma(_5, _51._m9, _4003 * _4009) + _491);
    vec3 _4017 = (_4014.wzy * 2.0) - vec3(1.0);
    vec4 _4018 = vec4(_4017.x, _4017.y, _4017.z, _4014.x);
    _4018.z = -_4017.z;
    vec4 _4031 = texture(sampler2D(_57, _18), fma(_5, _51._m9, _4003 * fract(_4008 + 0.5)) + _491);
    vec3 _4034 = (_4031.wzy * 2.0) - vec3(1.0);
    vec4 _4035 = vec4(_4034.x, _4034.y, _4034.z, _4031.x);
    _4035.z = -_4034.z;
    float _4047 = fma(_4006, _51._m20, _631);
    float _4048 = fract(_4047);
    vec4 _4053 = texture(sampler2D(_58, _18), fma(_5, _51._m10, _4003 * _4048) + _491);
    vec3 _4056 = (_4053.wzy * 2.0) - vec3(1.0);
    vec4 _4057 = vec4(_4056.x, _4056.y, _4056.z, _4053.x);
    _4057.z = -_4056.z;
    vec4 _4070 = texture(sampler2D(_58, _18), fma(_5, _51._m10, _4003 * fract(_4047 + 0.5)) + _491);
    vec3 _4073 = (_4070.wzy * 2.0) - vec3(1.0);
    vec4 _4074 = vec4(_4073.x, _4073.y, _4073.z, _4070.x);
    _4074.z = -_4073.z;
    float _4095 = clamp(fma(texture(sampler2D(_23, _19), _394).x, _15._m4, _405) / _424, 0.0, 1.0);
    vec2 _4102 = abs(normalize(mix(normalize(_4018.xyz).xyz, normalize(_4035.xyz).xyz, vec3(abs((_4009 + (-0.5)) * 2.0))) + mix(normalize(_4057.xyz).xyz, normalize(_4074.xyz).xyz, vec3(abs((_4048 + (-0.5)) * 2.0)))).xz) * (fma(_4095 - 1.0, 1.0 - _4095, 1.0) * _51._m45);
    vec2 _4112 = vec2(_4102.x * (_16._m1 / _16._m0), -_4102.y);
    vec2 _4120 = _393 * 0.5;
    vec2 _4121 = _17._m9 - _4120;
    vec2 _4125 = (_17._m10 + _4120) - _4121;
    vec2 _4128 = abs(fma(_4112, _17._m21, _394) - _4121) + _4125;
    vec2 _4129 = _4125 * 2.0;
    vec2 _4144 = abs(fma(gl_FragCoord.xy, _393, ((_4112 * _17._m21) * step(_10, texture(sampler2D(_23, _53), clamp(_4121 + abs((_4128 - _4129 * trunc(_4128 / _4129)) - _4125), _17._m9, _17._m10)).x)) * _50._m0) - _4121) + _4125;
    vec4 _4152 = texture(sampler2D(_22, _53), clamp(_4121 + abs((_4144 - _4129 * trunc(_4144 / _4129)) - _4125), _17._m9, _17._m10));
    // Inscatter strength: 0 = no colour cast, 1 = full game inscatter. Transmittance unchanged.
    float inscatterStrength = pc.rendering_fog_color_correction;
    vec3 _4155_composited = _3805 * _1966 + (_1965 * _20._m0[0u]) * inscatterStrength * _3993.w + _3993.xyz * inscatterStrength;
    vec3 _4155 = mix(_4152.xyz, _4155_composited, vec3(_569));
    _11 = spvNMax(vec4(_4155, fma(fma(-_566, _50._m0, 1.0), _4152.w, _569)), vec4(0.0));
}

