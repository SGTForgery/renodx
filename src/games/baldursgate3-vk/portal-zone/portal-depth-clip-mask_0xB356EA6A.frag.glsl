#version 450
#extension GL_EXT_spirv_intrinsics : require

layout(set = 0, binding = 2, std140) uniform _10_5
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _5;

layout(set = 0, binding = 6, std140) uniform _11_6
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    vec4 _m6;
    vec4 _m7;
    vec4 _m8;
    vec4 _m9;
    vec4 _m10;
} _6;

layout(set = 1, binding = 1, std140) uniform _12_8
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _8;

layout(set = 0, binding = 7) uniform sampler _7;
layout(set = 1, binding = 2) uniform texture2D _9;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _4;

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
    vec3 _51 = _4 + _5._m6;
    float _105;
    if (_8._m0 == 1.0)
    {
        float _64 = fma(texture(sampler2D(_9, _7), _3 * vec2(2.0)).x, 2.0, -1.0);
        vec3 _69 = _6._m0 - _6._m4;
        vec3 _70 = _51 - _6._m4;
        vec3 _82 = _6._m2 - _6._m4;
        _105 = spvNMin(clamp(spvNMax(fma(_64, 0.5, distance(_51, clamp(_6._m4 + (_69 * (dot(_70, _69) / dot(_69, _69))), spvNMin(_6._m4, _6._m0), spvNMax(_6._m4, _6._m0)))), 0.0) / _6._m1, 0.0, 1.0), clamp(spvNMax(fma(_64, 0.5, distance(_51, clamp(_6._m4 + (_82 * (dot(_70, _82) / dot(_82, _82))), spvNMin(_6._m4, _6._m2), spvNMax(_6._m4, _6._m2)))), 0.0) / _6._m3, 0.0, 1.0));
    }
    else
    {
        _105 = 1.0;
    }
    if ((_105 - 0.5) < 0.0)
    {
        discard;
    }
}

