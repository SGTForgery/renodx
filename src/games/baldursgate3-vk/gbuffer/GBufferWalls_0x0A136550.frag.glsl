#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_spirv_intrinsics : require

float _76;
vec4 _77;

layout(set = 0, binding = 2, std140) uniform _21_12
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _12;

layout(set = 1, binding = 0, std140) uniform _22_14
{
    uint _m0;
    uint _m1;
    uint _m2;
    uint _m3;
} _14;

layout(set = 1, binding = 1, std140) uniform _23_15
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
} _15;

layout(set = 0, binding = 7) uniform sampler _13;
layout(set = 1, binding = 2) uniform texture2D _16;
layout(set = 1, binding = 3) uniform texture2D _17;
layout(set = 1, binding = 4) uniform texture2D _18;
layout(set = 1, binding = 5) uniform texture2D _19;
layout(set = 1, binding = 6) uniform texture2D _20;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _4;
layout(location = 2) in vec3 _5;
layout(location = 3) in vec3 _6;
layout(location = 4) in vec3 _7;
layout(location = 0) out vec4 _8;
layout(location = 1) out vec4 _9;
layout(location = 2) out vec4 _10;
layout(location = 3) out vec4 _11;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec3 _86 = vec3(1.0, 0.0, -1.0) * _15._m0;
    vec2 _89 = _3 * vec2(2.0);
    vec4 _91 = texture(sampler2D(_16, _13), _89);
    vec3 _94 = (_91.wzy * 2.0) - vec3(1.0);
    vec4 _95 = vec4(_94.x, _94.y, _94.z, _91.x);
    _95.z = -_94.z;
    vec2 _104 = _3 * _15._m1;
    vec4 _112 = texture(sampler2D(_18, _13), _104);
    vec3 _115 = (_112.wzy * 2.0) - vec3(1.0);
    vec4 _116 = vec4(_115.x, _115.y, _115.z, _112.x);
    _116.z = -_115.z;
    mat3 _125 = mat3(_6, _4, _5);
    vec3 _137 = normalize(_125 * normalize(fma(_86, normalize(_95.xyz).xyz * texture(sampler2D(_17, _13), _104).w, normalize(_116.xyz).xyz))) * mat3(_12._m0[0].xyz, _12._m0[1].xyz, _12._m0[2].xyz);
    vec4 _156 = texture(sampler2D(_16, _13), _89);
    vec3 _159 = (_156.wzy * 2.0) - vec3(1.0);
    vec4 _160 = vec4(_159.x, _159.y, _159.z, _156.x);
    _160.z = -_159.z;
    vec4 _168 = texture(sampler2D(_17, _13), _104);
    float _169 = _168.w;
    vec4 _172 = texture(sampler2D(_18, _13), _104);
    vec3 _175 = (_172.wzy * 2.0) - vec3(1.0);
    vec4 _176 = vec4(_175.x, _175.y, _175.z, _172.x);
    _176.z = -_175.z;
    vec2 _239 = (((_137.xy / vec2(1.0 - _137.z)) * vec2(0.562524616718292236328125)) * 0.5) + vec2(0.5);
    vec3 _241 = clamp(mix(vec4(texture(sampler2D(_19, _13), _104).xyz, _76).xyz, texture(sampler2D(_20, _13), _3 * vec2(20.0)).xyz, vec3((pow(spvNMax(abs(1.0 - clamp(dot(normalize(fma(_86, normalize(_160.xyz).xyz * _169, normalize(_176.xyz).xyz)), normalize(normalize(-_7) * _125)), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 1.0) * _169) * _15._m2)), vec3(0.0), vec3(1.0));
    vec4 _242 = vec4(_241.x, _241.y, _241.z, _77.w);
    _242.w = texture(sampler2D(_17, _13), _104).z;
    _8 = vec4(_239.x, _239.y, vec4(0.0).z, vec4(0.0).w);
    _9 = _242;
    // FIX: Material type changed from 4 to 0. These are thick opaque meshes, not thin/double-sided.
    // Type 4 causes CSMResolve to invert shadow bias direction → shadow acne on walls/floors.
    _10 = vec4(clamp(texture(sampler2D(_17, _13), _104).y, 0.0, 1.0), clamp(mix(_15._m3, _15._m4, texture(sampler2D(_17, _13), _104).w), 0.0, 1.0), clamp(texture(sampler2D(_17, _13), _104).x, 0.0, 1.0), float(((0u | uint(int(_14._m1 != 0u) << 3)) | ((_14._m0 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _11 = vec4(float(_14._m2) * 0.0039215688593685626983642578125, 0.0, clamp(mix(_15._m5, 2.0, 1.0 - texture(sampler2D(_17, _13), _104).w), 0.0, 1.0), 0.0);
}

