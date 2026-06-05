#version 450

layout(set = 0, binding = 2, std140) uniform _12_6
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _6;

layout(set = 0, binding = 3, std140) uniform _13_7
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _7;

layout(set = 0, binding = 4, std140) uniform _14_8
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
} _8;

layout(set = 0, binding = 5, std140) uniform _15_9
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    vec3 _m3;
    float _m4;
    vec2 _m5;
    vec2 _m6;
} _9;

layout(set = 1, binding = 0) uniform texture2D _10;
layout(set = 1, binding = 1) uniform sampler _11;

layout(location = 0) in vec3 _4;
layout(location = 0) out vec2 _5;

void main()
{
    vec4 _90 = vec4((_4 * textureLod(sampler2D(_10, _11), gl_FragCoord.xy * vec2(_7._m2, _7._m3), 0.0).x) + (_6._m6 - _9._m3), 1.0) * _9._m2;
    _5 = (gl_FragCoord.xy + vec2(_9._m5.x, -_9._m5.y)) - fma(fma(fma(_90.xy / vec2(_90.w), vec2(0.5, -0.5), vec2(0.5)), _8._m0, _8._m1), vec2(_7._m0, _7._m1), vec2(_9._m6.x, -_9._m6.y));
}

