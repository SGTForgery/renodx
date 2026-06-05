#version 450

layout(set = 0, binding = 0, std140) uniform _9_5
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _5;

layout(set = 1, binding = 1, std140) uniform _10_7
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _7;

layout(set = 0, binding = 7) uniform sampler _6;
layout(set = 1, binding = 2) uniform texture2D _8;

layout(location = 0) in vec2 _4;

void main()
{
    vec4 _52 = texture(sampler2D(_8, _6), _4);
    float _59 = smoothstep(_7._m0, clamp(_7._m0 + 0.699999988079071044921875, 0.0, 1.0), _52.w);
    float _63 = fma(_52.z - 1.0, _7._m1, 1.0);
    float _90;
    if (_5._m3 != 0.0)
    {
        _90 = fma(_59, _63, fract(dot(vec2(0.833000004291534423828125, 0.16660000383853912353515625), vec2(fract(((fma(gl_FragCoord.y, 2.0, gl_FragCoord.x) - 1.5) + (_5._m2 - 4.0 * trunc(_5._m2 / 4.0))) * 0.20000000298023223876953125), fract(fma(gl_FragCoord.x, 2.408400058746337890625, gl_FragCoord.y * 3.2534999847412109375))))) - 0.66670000553131103515625);
    }
    else
    {
        _90 = step(0.33329999446868896484375, _59 * _63);
    }
    if ((_90 - 0.33329999446868896484375) < 0.0)
    {
        discard;
    }
}

