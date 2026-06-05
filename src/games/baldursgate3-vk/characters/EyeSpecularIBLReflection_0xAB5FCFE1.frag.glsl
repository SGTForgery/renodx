#version 450
#extension GL_EXT_spirv_intrinsics : require

layout(set = 0, binding = 0, std140) uniform _21_13
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

layout(set = 1, binding = 1, std140) uniform _22_15
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec2 _m4;
    vec2 _m5;
    float _m6;
    float _m7;
    float _m8;
    float _m9;
    float _m10;
    float _m11;
    float _m12;
    float _m13;
} _15;

layout(set = 0, binding = 7) uniform sampler _14;
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
layout(location = 5) in vec4 _8;
layout(location = 6) in vec3 _9;
layout(location = 7) in vec3 _10;
layout(location = 8) in vec3 _11;
layout(location = 0) out vec4 _12;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec3 _87 = normalize(normalize(-_7) * mat3(_6, _4, _5));
    vec2 _100 = _3 + (vec2(_87.x, -_87.z) * fma(texture(sampler2D(_16, _14), _3).w, -0.04500000178813934326171875, -0.04500000178813934326171875));
    vec4 _112 = texture(sampler2D(_16, _14), _100);
    float _114 = _112.z;
    vec2 _120 = _100 + (_15._m5 * (texture(sampler2D(_17, _14), _100 + (_15._m4 * _13._m0)).x * (_112.y * _114)));
    vec4 _123 = texture(sampler2D(_18, _14), _120);
    float _131 = _8.x * _15._m6;
    vec3 _150 = mix(_15._m0, _15._m2, vec3(_131));
    float _174 = fma(_8.x - 1.0, _15._m10, 1.0);
    vec4 _193 = texture(sampler2D(_19, _14), _100);
    vec3 _196 = (_193.wzy * 2.0) - vec3(1.0);
    vec4 _197 = vec4(_196.x, _196.y, _196.z, _193.x);
    _197.z = -_196.z;
    vec3 _203 = normalize(_197.xyz).xyz;
    vec3 _210 = normalize(mat3(_11, _9, _10) * ((-_87) + ((_203 * dot(_87, _203)) * 2.0)));
    vec3 _225 = fma(texture(sampler2D(_20, _14), vec2(fma(atan(_210.z, _210.x), 0.1591549217700958251953125, 0.5), 1.0 - fma(asin(clamp(_210.y, -1.0, 1.0)), 0.318309962749481201171875, 0.5))).xyz, vec3(0.3333333432674407958984375), (((_150 * texture(sampler2D(_17, _14), vec2(texture(sampler2D(_17, _14), _100).x) + (_100 + (vec2(0.0, 1.0) * (_13._m0 * _15._m7)))).x) * ((1.0 - mix(_15._m8, _15._m9, _8.x)) * mix(_174 * _15._m11, _15._m12, _131))) * (pow(spvNMax(abs(1.0 - (_123.y + _123.z)), 9.9999997473787516355514526367188e-05), mix(_15._m1, _15._m3, _131)) * smoothstep(1.0, 0.0, texture(sampler2D(_16, _14), _120).y))) + (_150 * ((1.0 - _114) * (_174 * _15._m13))));
    _12 = vec4(_225, 1.0);
}

