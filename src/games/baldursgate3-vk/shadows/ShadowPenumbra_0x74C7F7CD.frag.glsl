#version 450
#extension GL_EXT_samplerless_texture_functions : require

layout(set = 0, binding = 2, std140) uniform _8_5
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

layout(set = 1, binding = 0, std140) uniform _9_6
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    vec2 _m6;
} _6;

layout(set = 1, binding = 1) uniform texture2D _7;

layout(location = 0) out float _4;

void main()
{
    float _51 = texelFetch(_7, ivec3(int(gl_FragCoord.x), int(gl_FragCoord.y), 0).xy, 0).x * _5._m4;
    float _54 = fma(_51, 1000.0, _6._m3);
    float _105;
    if (_54 < _6._m2)
    {
        float _79;
        if (_6._m5 <= 0.0)
        {
            _79 = -clamp(abs((_6._m0 * (_6._m1 * (_54 - _6._m2))) / (_54 * (_6._m2 - _6._m1))), 0.0, 1.0);
        }
        else
        {
            _79 = 0.0;
        }
        _105 = _79;
    }
    else
    {
        float _83 = fma(_51, 1000.0, -_6._m4);
        float _104;
        if (_83 > _6._m2)
        {
            _104 = (_6._m5 >= 0.0) ? clamp(abs((_6._m0 * (_6._m1 * (_83 - _6._m2))) / (_83 * (_6._m2 - _6._m1))), 0.0, 1.0) : 0.0;
        }
        else
        {
            _104 = 0.0;
        }
        _105 = _104;
    }
    _4 = _105;
}

