#version 450
#extension GL_EXT_scalar_block_layout : require
#extension GL_EXT_samplerless_texture_functions : require

layout(set = 1, binding = 0, scalar) uniform _6_5
{
    vec2 _m0;
    vec2 _m1;
    uint _m2;
    uvec3 _m3;
} _5;

layout(set = 1, binding = 1) uniform texture2D _4;

layout(location = 0) out float _3;

void main()
{
    vec2 _37 = gl_FragCoord.xy - _5._m1;
    vec4 _45 = texelFetch(_4, ivec3(int(_37.x), int(_37.y), 0).xy, 0);
    float _46 = _45.x;
    float _68;
    do
    {
        if (_5._m2 != 0u)
        {
            _68 = (_46 - _5._m0.y) / _5._m0.x;
            break;
        }
        else
        {
            _68 = _5._m0.y / (_46 - _5._m0.x);
            break;
        }
        break; // unreachable workaround
    } while(false);
    _3 = (_46 == 0.0) ? 1.0 : _68;
}

