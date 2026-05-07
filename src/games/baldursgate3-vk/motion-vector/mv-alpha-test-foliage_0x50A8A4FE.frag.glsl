#version 450

layout(set = 0, binding = 0, std140) uniform _14_7
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _7;

layout(set = 0, binding = 3, std140) uniform _15_8
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _8;

layout(set = 0, binding = 4, std140) uniform _16_9
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
} _9;

layout(set = 0, binding = 5, std140) uniform _17_10
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    vec3 _m3;
    float _m4;
    vec2 _m5;
    vec2 _m6;
} _10;

layout(set = 1, binding = 1, std140) uniform _18_12
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _12;

layout(set = 0, binding = 7) uniform sampler _11;
layout(set = 1, binding = 2) uniform texture2D _13;

layout(location = 0) in vec4 _4;
layout(location = 1) in vec2 _5;
layout(location = 0) out vec2 _6;

void main()
{
    vec4 _77 = texture(sampler2D(_13, _11), _5);
    float _84 = smoothstep(_12._m0, clamp(_12._m0 + 0.699999988079071044921875, 0.0, 1.0), _77.w);
    float _88 = fma(_77.z - 1.0, _12._m1, 1.0);
    float _115;
    if (_7._m3 != 0.0)
    {
        _115 = fma(_84, _88, fract(dot(vec2(0.833000004291534423828125, 0.16660000383853912353515625), vec2(fract(((fma(gl_FragCoord.y, 2.0, gl_FragCoord.x) - 1.5) + (_7._m2 - 4.0 * trunc(_7._m2 / 4.0))) * 0.20000000298023223876953125), fract(fma(gl_FragCoord.x, 2.408400058746337890625, gl_FragCoord.y * 3.2534999847412109375))))) - 0.66670000553131103515625);
    }
    else
    {
        _115 = step(0.33329999446868896484375, _84 * _88);
    }
    if ((_115 - 0.33329999446868896484375) < 0.0)
    {
        discard;
    }
    _6 = (gl_FragCoord.xy + vec2(_10._m5.x, -_10._m5.y)) - fma(fma(fma(_4.xy / vec2(_4.w), vec2(0.5, -0.5), vec2(0.5)), _9._m0, _9._m1), vec2(_8._m0, _8._m1), vec2(_10._m6.x, -_10._m6.y));
}

