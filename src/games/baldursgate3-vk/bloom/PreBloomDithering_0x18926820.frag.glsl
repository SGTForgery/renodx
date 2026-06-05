#version 450

layout(set = 0, binding = 3, std140) uniform _11_5
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _5;

layout(set = 0, binding = 4, std140) uniform _12_6
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
} _6;

layout(set = 1, binding = 0, std140) uniform _13_10
{
    float _m0;
    float _m1;
    vec2 _m2;
} _10;

layout(set = 1, binding = 1) uniform sampler _7;
layout(set = 1, binding = 2) uniform texture2D _8;
layout(set = 1, binding = 3) uniform texture2D _9;

layout(location = 0) in vec2 _3;
layout(location = 0) out vec4 _4;

void main()
{
    vec2 _60 = ((vec2(2.0) * vec2(_5._m2, _5._m3)) * _10._m2) * _6._m15;
    float _71 = _60.x;
    float _72 = -_71;
    float _73 = _60.y;
    float _81 = -_73;
    vec4 _136 = ((((((((((textureLod(sampler2D(_9, _7), clamp(_3 * _6._m15, _6._m11, _6._m12), 0.0) * 0.25) + (textureLod(sampler2D(_9, _7), clamp(fma(_3, _6._m15, vec2(_72, _73)), _6._m11, _6._m12), 0.0) * 0.0625)) + (textureLod(sampler2D(_9, _7), clamp(fma(_3, _6._m15, vec2(_72, _81)), _6._m11, _6._m12), 0.0) * 0.0625)) + (textureLod(sampler2D(_9, _7), clamp(fma(_3, _6._m15, vec2(_71, _81)), _6._m11, _6._m12), 0.0) * 0.0625)) + (textureLod(sampler2D(_9, _7), clamp(fma(_3, _6._m15, _60), _6._m11, _6._m12), 0.0) * 0.0625)) + (textureLod(sampler2D(_9, _7), clamp(fma(_3, _6._m15, vec2(_72, 0.0)), _6._m11, _6._m12), 0.0) * 0.125)) + (textureLod(sampler2D(_9, _7), clamp(fma(_3, _6._m15, vec2(0.0, _81)), _6._m11, _6._m12), 0.0) * 0.125)) + (textureLod(sampler2D(_9, _7), clamp(fma(_3, _6._m15, vec2(_71, 0.0)), _6._m11, _6._m12), 0.0) * 0.125)) + (textureLod(sampler2D(_9, _7), clamp(fma(_3, _6._m15, vec2(0.0, _73)), _6._m11, _6._m12), 0.0) * 0.125)) * _10._m0) + textureLod(sampler2D(_8, _7), _3, 0.0);
    _4 = _136;
}

