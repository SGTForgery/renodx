#version 450
#extension GL_EXT_spirv_intrinsics : require

layout(set = 1, binding = 1, std140) uniform _13_10
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
} _10;

layout(set = 0, binding = 7) uniform sampler _9;
layout(set = 1, binding = 3) uniform texture2D _11;
layout(set = 1, binding = 4) uniform texture2D _12;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _4;
layout(location = 2) in vec3 _5;
layout(location = 3) in vec3 _6;
layout(location = 4) in vec3 _7;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec3 _55 = _4 * fma(float(gl_FrontFacing), 2.0, -1.0);
    mat3 _56 = mat3(_6, _55, _5);
    vec4 _79 = texture(sampler2D(_12, _9), _3 + vec2(fma(texture(sampler2D(_11, _9), _3 * _10._m2).x, 2.0, -1.0) * _10._m3)) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _85 = texture(sampler2D(_12, _9), _3) - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _93 = fma(spvNMax(vec4(ivec4(sign(_79))), vec4(ivec4(sign(_85)))), spvNMax(abs(_79), abs(_85)), vec4(0.5, 0.0, 0.0, 0.0));
    if ((step(0.33329999446868896484375, ((_93.w * fma(-_93.z, _10._m4, 1.0)) * clamp(abs(dot(normalize(_56 * normalize(normalize(-_7) * _56)), normalize(_55))) * 5.0, 0.0, 1.0)) * _10._m5) - 0.33329999446868896484375) < 0.0)
    {
        discard;
    }
}

