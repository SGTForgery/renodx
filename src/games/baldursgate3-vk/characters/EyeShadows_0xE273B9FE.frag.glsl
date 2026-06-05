#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_scalar_block_layout : require
#extension GL_EXT_spirv_intrinsics : require

// RDX DEBUG: 0 = off, 1 = _rdxShadowMin, 2 = _1586 (eyelid), 3 = _rdxOcc (combined)
#define RDX_DEBUG 0
#if defined(GL_EXT_control_flow_attributes)
#extension GL_EXT_control_flow_attributes : require
#define SPIRV_CROSS_FLATTEN [[flatten]]
#define SPIRV_CROSS_BRANCH [[dont_flatten]]
#define SPIRV_CROSS_UNROLL [[unroll]]
#define SPIRV_CROSS_LOOP [[dont_unroll]]
#else
#define SPIRV_CROSS_FLATTEN
#define SPIRV_CROSS_BRANCH
#define SPIRV_CROSS_UNROLL
#define SPIRV_CROSS_LOOP
#endif
#extension GL_KHR_shader_subgroup_basic : require
#extension GL_KHR_shader_subgroup_quad : require

struct _62
{
    vec4 _m0;
    vec4 _m1;
    vec4 _m2;
    float _m3;
    float _m4;
    float _m5;
    uint _m6;
    uint _m7;
    float _m8;
    ivec2 _m9;
};

struct _65
{
    vec3 _m0;
    uint _m1;
    vec4 _m2;
    vec2 _m3;
    uint _m4;
    float _m5;
    mat4x3 _m6;
    vec3 _m7;
    uint _m8;
    vec3 _m9;
    float _m10;
};

struct _69
{
    vec4 _m0;
    mat4x3 _m1;
    vec4 _m2[4];
    float _m3;
    float _m4;
    uint _m5;
    uint _m6;
};

struct _74
{
    mat4 _m0;
    vec2 _m1;
    float _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    float _m6;
};

float _308;
const vec4 _324[4] = vec4[](vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
vec3 _342;
vec3 _349;

layout(set = 0, binding = 1, std140) uniform _52_14
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    layout(row_major) mat4 _m6;
    vec4 _m7[3];
    vec4 _m8;
    vec4 _m9;
    float _m10;
    float _m11;
    float _m12;
    float _m13;
    float _m14;
    float _m15;
    float _m16;
    float _m17;
    vec4 _m18;
    float _m19;
    float _m20;
    float _m21;
    float _m22;
    vec4 _m23;
    vec3 _m24;
    float _m25;
    vec3 _m26;
    float _m27;
    vec4 _m28;
    vec3 _m29;
    float _m30;
    vec4 _m31;
    vec3 _m32;
    float _m33;
    vec3 _m34;
    float _m35;
    vec3 _m36;
    float _m37;
} _14;

layout(set = 0, binding = 2, std140) uniform _53_15
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _15;

layout(set = 0, binding = 3, std140) uniform _54_16
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _16;

layout(set = 0, binding = 4, std140) uniform _55_17
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
} _17;

layout(set = 2, binding = 0, std430) readonly buffer _57_19
{
    float _m0[];
} _19;

layout(set = 2, binding = 10, std430) readonly buffer _59_23
{
    ivec4 _m0[];
} _23;

layout(set = 2, binding = 11, std430) readonly buffer _61_24
{
    int _m0[];
} _24;

layout(set = 2, binding = 12, std430) readonly buffer _64_25
{
    _62 _m0[];
} _25;

layout(set = 2, binding = 16, std430) readonly buffer _67_26
{
    layout(row_major) _65 _m0[];
} _26;

layout(set = 2, binding = 20, std430) readonly buffer _71_29
{
    layout(row_major) _69 _m0[];
} _29;

layout(set = 2, binding = 26, std140) uniform _73_35
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
    vec4 _m8;
    vec4 _m9;
    layout(row_major) mat4 _m10[4];
    float _m11;
    float _m12;
    float _m13;
    uint _m14;
    vec2 _m15;
    vec2 _m16;
    vec3 _m17;
    float _m18;
    layout(row_major) mat4x3 _m19;
    vec4 _m20[4];
    float _m21;
    float _m22;
    float _m23;
    float _m24;
    uint _m25;
    uint _m26;
    float _m27;
    float _m28;
    float _m29;
    float _m30;
    float _m31;
    float _m32;
    vec2 _m33;
    vec2 _m34;
} _35;

layout(set = 2, binding = 27, scalar) readonly buffer _76_36
{
    layout(row_major) _74 _m0[];
} _36;

layout(set = 5, binding = 0, scalar) uniform _77_42
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    vec3 _m5;
    float _m6;
    vec3 _m7;
    vec3 _m8;
    float _m9;
} _42;

layout(set = 1, binding = 0, std140) uniform _78_47
{
    layout(row_major) mat4 _m0;
    uint _m1;
    float _m2;
    uint _m3;
    uint _m4;
} _47;

layout(set = 1, binding = 1, std140) uniform _79_48
{
    vec3 _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
} _48;

layout(set = 0, binding = 7) uniform sampler _18;
layout(set = 2, binding = 3) uniform sampler _20;
layout(set = 2, binding = 8) uniform texture2DArray _21;
layout(set = 2, binding = 9) uniform samplerShadow _22;
layout(set = 2, binding = 17) uniform texture3D _27;
layout(set = 2, binding = 19) uniform sampler _28;
layout(set = 2, binding = 21) uniform textureCube _30;
layout(set = 2, binding = 22) uniform textureCube _31;
layout(set = 2, binding = 23) uniform textureCube _32;
layout(set = 2, binding = 24) uniform textureCube _33;
layout(set = 2, binding = 25) uniform texture2D _34;
layout(set = 2, binding = 28) uniform texture2D _37;
layout(set = 2, binding = 29) uniform texture2D _38;
layout(set = 2, binding = 30) uniform texture2D _39;
layout(set = 2, binding = 32) uniform textureCube _40[];
layout(set = 2, binding = 32) uniform texture2D _41[];
layout(set = 5, binding = 1) uniform texture2D _43;
layout(set = 5, binding = 2) uniform texture3D _44;
layout(set = 5, binding = 4) uniform texture2D _45;
layout(set = 5, binding = 5) uniform texture2D _46;
layout(set = 1, binding = 2) uniform texture2D _49;
layout(set = 1, binding = 3) uniform texture2D _50;

layout(location = 0) in vec2 _4;
layout(location = 1) in vec3 _5;
layout(location = 2) in vec3 _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in float _9;
layout(location = 6) in float _10;
layout(location = 0) out vec4 _12;

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
    vec4 _367 = texture(sampler2D(_49, _18), _4);
    float _368 = _367.x;
    float _369 = _367.y;
    vec4 _388 = texture(sampler2D(_50, _18), _4);
    vec3 _391 = (_388.wzy * 2.0) - vec3(1.0);
    vec4 _392 = vec4(_391.x, _391.y, _391.z, _388.x);
    _392.z = -_391.z;
    vec3 _404 = normalize(mat3(_7, _5 * fma(float(gl_FrontFacing), 2.0, -1.0), _6) * normalize(_392.xyz).xyz);
    vec4 _406 = texture(sampler2D(_49, _18), _4);
    float _810;
    if (_35._m3 > 0.0)
    {
        vec4 _428;
        float _433;
        float _434;
        vec2 _442;
        float _448;
        float _531;
        bool _532;
        do
        {
            _428 = vec4(_8, 1.0);
            vec4 _429 = _428 * _35._m10[0u];
            _433 = _35._m9.x;
            _434 = 0.5 * _35._m6;
            _442 = vec2(_35._m6);
            vec2 _444 = clamp((vec2(1.0) - abs((clamp(_429.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _442, vec2(0.0), vec2(1.0));
            float _445 = _429.z;
            _448 = _35._m8.x;
            float _451 = clamp((clamp(_445, 0.0, 1.0) * _448) / (_433 * _434), 0.0, 1.0);
            float _454 = _444.x * _444.y;
            float _455 = _454 * _451;
            SPIRV_CROSS_BRANCH
            if (_455 > 0.0)
            {
                float _473 = textureGrad(sampler2DArrayShadow(_21, _22), vec4(vec3(_429.xy, 0.0), fma(_35._m7 / _448, mix(_433 / _433, _448 / _448, 0.75), _445)), vec2(0.0), vec2(0.0));
                float _530;
                SPIRV_CROSS_BRANCH
                if (((1.0 < _35._m11) && true) && (_455 < 1.0))
                {
                    vec4 _489 = _428 * _35._m10[1u];
                    vec2 _500 = clamp((vec2(1.0) - abs((clamp(_489.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _442, vec2(0.0), vec2(1.0));
                    float _501 = _489.z;
                    float _529;
                    SPIRV_CROSS_BRANCH
                    if (((_500.x * _500.y) * clamp((clamp(_501, 0.0, 1.0) * _35._m8.y) / (_35._m9.y * _434), 0.0, 1.0)) > 0.0)
                    {
                        _529 = fma(_473, _455, fma(-_454, _451, 1.0) * textureGrad(sampler2DArrayShadow(_21, _22), vec4(vec3(_489.xy, 1.0), fma(_35._m7 / _35._m8.y, mix(_35._m9.y / _433, _35._m8.y / _448, 0.75), _501)), vec2(0.0), vec2(0.0)));
                    }
                    else
                    {
                        _529 = _473 * _455;
                    }
                    _530 = _529;
                }
                else
                {
                    _530 = fma(_473, _455, fma(-_454, _451, 1.0));
                }
                _531 = _530;
                _532 = true;
                break;
            }
            else
            {
                _531 = 1.0;
                _532 = false;
                break;
            }
            break; // unreachable workaround
        } while(false);
        float _805;
        if ((!_532) && (_35._m11 > 1.0))
        {
            float _640;
            bool _641;
            do
            {
                vec4 _544 = _428 * _35._m10[1u];
                vec2 _555 = clamp((vec2(1.0) - abs((clamp(_544.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _442, vec2(0.0), vec2(1.0));
                float _556 = _544.z;
                float _562 = clamp((clamp(_556, 0.0, 1.0) * _35._m8.y) / (_35._m9.y * _434), 0.0, 1.0);
                float _565 = _555.x * _555.y;
                float _566 = _565 * _562;
                SPIRV_CROSS_BRANCH
                if (_566 > 0.0)
                {
                    float _584 = textureGrad(sampler2DArrayShadow(_21, _22), vec4(vec3(_544.xy, 1.0), fma(_35._m7 / _35._m8.y, mix(_35._m9.y / _433, _35._m8.y / _448, 0.75), _556)), vec2(0.0), vec2(0.0));
                    float _639;
                    SPIRV_CROSS_BRANCH
                    if (((2.0 < _35._m11) && true) && (_566 < 1.0))
                    {
                        vec4 _598 = _428 * _35._m10[2u];
                        vec2 _609 = clamp((vec2(1.0) - abs((clamp(_598.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _442, vec2(0.0), vec2(1.0));
                        float _610 = _598.z;
                        float _638;
                        SPIRV_CROSS_BRANCH
                        if (((_609.x * _609.y) * clamp((clamp(_610, 0.0, 1.0) * _35._m8.z) / (_35._m9.z * _434), 0.0, 1.0)) > 0.0)
                        {
                            _638 = fma(_584, _566, fma(-_565, _562, 1.0) * textureGrad(sampler2DArrayShadow(_21, _22), vec4(vec3(_598.xy, 2.0), fma(_35._m7 / _35._m8.z, mix(_35._m9.z / _433, _35._m8.z / _448, 0.75), _610)), vec2(0.0), vec2(0.0)));
                        }
                        else
                        {
                            _638 = _584 * _566;
                        }
                        _639 = _638;
                    }
                    else
                    {
                        _639 = fma(_584, _566, fma(-_565, _562, 1.0));
                    }
                    _640 = _639;
                    _641 = true;
                    break;
                }
                else
                {
                    _640 = _531;
                    _641 = false;
                    break;
                }
                break; // unreachable workaround
            } while(false);
            float _804;
            if ((!_641) && (_35._m11 > 2.0))
            {
                float _747;
                bool _748;
                do
                {
                    vec4 _651 = _428 * _35._m10[2u];
                    vec2 _662 = clamp((vec2(1.0) - abs((clamp(_651.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _442, vec2(0.0), vec2(1.0));
                    float _663 = _651.z;
                    float _669 = clamp((clamp(_663, 0.0, 1.0) * _35._m8.z) / (_35._m9.z * _434), 0.0, 1.0);
                    float _672 = _662.x * _662.y;
                    float _673 = _672 * _669;
                    SPIRV_CROSS_BRANCH
                    if (_673 > 0.0)
                    {
                        float _691 = textureGrad(sampler2DArrayShadow(_21, _22), vec4(vec3(_651.xy, 2.0), fma(_35._m7 / _35._m8.z, mix(_35._m9.z / _433, _35._m8.z / _448, 0.75), _663)), vec2(0.0), vec2(0.0));
                        float _746;
                        SPIRV_CROSS_BRANCH
                        if (((3.0 < _35._m11) && true) && (_673 < 1.0))
                        {
                            vec4 _705 = _428 * _35._m10[3u];
                            vec2 _716 = clamp((vec2(1.0) - abs((clamp(_705.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _442, vec2(0.0), vec2(1.0));
                            float _717 = _705.z;
                            float _745;
                            SPIRV_CROSS_BRANCH
                            if (((_716.x * _716.y) * clamp((clamp(_717, 0.0, 1.0) * _35._m8.w) / (_35._m9.w * _434), 0.0, 1.0)) > 0.0)
                            {
                                _745 = fma(_691, _673, fma(-_672, _669, 1.0) * textureGrad(sampler2DArrayShadow(_21, _22), vec4(vec3(_705.xy, 3.0), fma(_35._m7 / _35._m8.w, mix(_35._m9.w / _433, _35._m8.w / _448, 0.75), _717)), vec2(0.0), vec2(0.0)));
                            }
                            else
                            {
                                _745 = _691 * _673;
                            }
                            _746 = _745;
                        }
                        else
                        {
                            _746 = fma(_691, _673, fma(-_672, _669, 1.0));
                        }
                        _747 = _746;
                        _748 = true;
                        break;
                    }
                    else
                    {
                        _747 = _640;
                        _748 = false;
                        break;
                    }
                    break; // unreachable workaround
                } while(false);
                float _803;
                if ((!_748) && (_35._m11 > 3.0))
                {
                    float _802;
                    do
                    {
                        vec4 _758 = _428 * _35._m10[3u];
                        vec2 _769 = clamp((vec2(1.0) - abs((clamp(_758.xy, vec2(0.0), vec2(1.0)) * 2.0) - vec2(1.0))) / _442, vec2(0.0), vec2(1.0));
                        float _770 = _758.z;
                        float _776 = clamp((clamp(_770, 0.0, 1.0) * _35._m8.w) / (_35._m9.w * _434), 0.0, 1.0);
                        float _779 = _769.x * _769.y;
                        float _780 = _779 * _776;
                        SPIRV_CROSS_BRANCH
                        if (_780 > 0.0)
                        {
                            _802 = fma(textureGrad(sampler2DArrayShadow(_21, _22), vec4(vec3(_758.xy, 3.0), fma(_35._m7 / _35._m8.w, mix(_35._m9.w / _433, _35._m8.w / _448, 0.75), _770)), vec2(0.0), vec2(0.0)), _780, fma(-_779, _776, 1.0));
                            break;
                        }
                        else
                        {
                            _802 = _747;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _803 = _802;
                }
                else
                {
                    _803 = _747;
                }
                _804 = _803;
            }
            else
            {
                _804 = _640;
            }
            _805 = _804;
        }
        else
        {
            _805 = _531;
        }
        _810 = spvNMax(0.0, pow(spvNMax(abs(_805), 9.9999997473787516355514526367188e-05), 2.2000000476837158203125));
    }
    else
    {
        _810 = 1.0;
    }
    float _rdxShadowMin = _810;
    vec3 _813 = ((_48._m0 * _406.x) * (_406.z * _48._m3)) * 1.0;
    vec3 _814 = dFdx(_404);
    vec3 _815 = dFdy(_404);
    float _823 = spvNMax(0.0900000035762786865234375, sqrt(clamp(1.0 + spvNMin(dot(_814, _814) + dot(_815, _815), 0.180000007152557373046875), 0.0, 1.0)));
    vec3 _827 = normalize(-_8);
    ivec2 _837 = ivec2(uvec2(gl_FragCoord.xy) / uvec2(_35._m25));
    vec3 _1411;
    vec3 _1412;
    vec3 _1413;
    SPIRV_CROSS_BRANCH
    if (_14._m19 > 0.0)
    {
        vec3 _871 = vec3(0.0, 636100.0, 0.0) + _15._m6;
        float _872 = length(_871);
        bool _876 = _872 < (0.89999997615814208984375 * _42._m0);
        vec3 _883;
        float _884;
        if (_876)
        {
            vec3 _881 = _871;
            _881.z = _871.z + _42._m0;
            _883 = _881;
            _884 = length(_881);
        }
        else
        {
            _883 = _871;
            _884 = _872;
        }
        float _887 = dot(_883 / vec3(_884), _14._m36);
        float _888 = _42._m0 / _884;
        vec3 _912 = vec3(0.0, 636100.0, 0.0) + (_8 + _15._m6);
        float _913 = length(_912);
        vec3 _917 = (_912 / vec3(_913)) * spvNMax(_913, 636100.0);
        vec3 _918 = _917 - _871;
        float _919 = length(_918);
        vec3 _921 = _918 / vec3(_919);
        vec3 _931;
        vec3 _932;
        float _933;
        if (_876)
        {
            vec3 _926 = _871;
            _926.z = _871.z + _42._m0;
            vec3 _929 = _917;
            _929.z = _917.z + _42._m0;
            _931 = _929;
            _932 = _926;
            _933 = length(_926);
        }
        else
        {
            _931 = _917;
            _932 = _871;
            _933 = _872;
        }
        float _934 = dot(_932, _921);
        float _943 = spvNMax((-_934) - sqrt(fma(_42._m1, _42._m1, fma(_934, _934, -(_933 * _933)))), 0.0);
        bool _946 = (_943 > 0.0) && (_943 < _919);
        vec3 _954;
        float _955;
        float _956;
        if (_946)
        {
            _954 = _932 + (_921 * _943);
            _955 = _919 - _943;
            _956 = (_934 + _943) / _42._m1;
        }
        else
        {
            _954 = _932;
            _955 = _919;
            _956 = _934 / _933;
        }
        float _957 = _946 ? _42._m1 : _933;
        vec3 _1394;
        vec3 _1395;
        if (_957 <= _42._m1)
        {
            float _962 = dot(_921, _14._m36);
            float _964 = dot(_954, _14._m36) / _957;
            float _965 = _42._m0 + 600.0;
            bool _966 = _957 < _965;
            vec3 _971;
            if (_966)
            {
                _971 = _931 * (_965 / _957);
            }
            else
            {
                _971 = _931;
            }
            float _972 = _966 ? _965 : _957;
            float _973 = length(_971);
            float _974 = dot(_971, _921);
            float _976 = dot(_971, _14._m36) / _973;
            vec2 _987 = vec2(_956, _956 + (_955 / _972));
            vec2 _988 = _987 * sqrt((0.5 / _42._m4) * _972);
            vec2 _991 = vec2(ivec2(sign(_988)));
            vec2 _992 = _988 * _988;
            float _1006 = -_955;
            float _1008 = 2.0 * _972;
            float _1010 = (_955 / _1008) + _956;
            float _1018 = _42._m0 - _972;
            vec2 _1033 = _987 * sqrt((0.5 / _42._m6) * _972);
            vec2 _1036 = vec2(ivec2(sign(_1033)));
            vec2 _1037 = _1033 * _1033;
            vec3 _1067 = exp(((-_42._m5) * ((sqrt((6.283100128173828125 * _42._m4) * _972) * exp(_1018 / _42._m4)) * (((_991.y > _991.x) ? exp(_992.x) : 0.0) + dot((_991 / ((abs(_988) * 2.3192999362945556640625) + sqrt((_992 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1006 / _42._m4) * _1010)), vec2(1.0, -1.0))))) - (_42._m8 * ((sqrt((6.283100128173828125 * _42._m6) * _972) * exp(_1018 / _42._m6)) * (((_1036.y > _1036.x) ? exp(_1037.x) : 0.0) + dot((_1036 / ((abs(_1033) * 2.3192999362945556640625) + sqrt((_1037 * 1.519999980926513671875) + vec2(4.0)))) * vec2(1.0, exp((_1006 / _42._m6) * _1010)), vec2(1.0, -1.0))))));
            vec3 _1068 = spvNMin(_1067, vec3(1.0));
            float _1069 = _42._m0 / _972;
            float _1072 = sqrt(fma(-_1069, _1069, 1.0));
            float _1074 = _956 - (-_1072);
            vec4 _1357;
            if (abs(_1074) < 0.0040000001899898052215576171875)
            {
                float _1182 = (-0.0040000001899898052215576171875) - _1072;
                float _1184 = fma(_972, _972, _955 * _955);
                float _1185 = _1008 * _955;
                float _1187 = sqrt(fma(_1185, _1182, _1184));
                float _1188 = fma(_972, _1182, _955);
                float _1191 = -(_42._m0 * _42._m0);
                float _1193 = sqrt(fma(_42._m1, _42._m1, _1191));
                float _1195 = sqrt(fma(_972, _972, _1191));
                float _1196 = _972 * _1182;
                float _1198 = -(_972 * _972);
                float _1200 = fma(_42._m0, _42._m0, fma(_1196, _1196, _1198));
                vec4 _1206 = vec4(-1.0, _1193 * _1193, _1193, 0.50390625);
                vec4 _1207 = mix(_1206, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1196 < 0.0) && (_1200 > 0.0)));
                float _1209 = fma(_1195 / _1193, 0.96875, 0.015625);
                float _1219 = fma(fma(_1196, _1207.x, sqrt(_1200 + _1207.y)) / (_1195 + _1207.z), 0.4921875, _1207.w);
                float _1225 = _962 + 1.0;
                float _1227 = floor(_1225 * 3.5);
                float _1229 = fma(_1225, 3.5, -_1227);
                float _1230 = _1227 + fma(fma(atan(spvNMax(_964, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1231 = _1230 * 0.125;
                float _1235 = 1.0 - _1229;
                float _1238 = (_1230 + 1.0) * 0.125;
                float _1245 = sqrt(fma(_1187, _1187, _1191));
                float _1249 = fma(_42._m0, _42._m0, fma(_1188, _1188, -(_1187 * _1187)));
                vec4 _1254 = mix(_1206, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1188 < 0.0) && (_1249 > 0.0)));
                float _1256 = fma(_1245 / _1193, 0.96875, 0.015625);
                float _1266 = fma(fma(_1188, _1254.x, sqrt(_1249 + _1254.y)) / (_1245 + _1254.z), 0.4921875, _1254.w);
                float _1272 = _1227 + fma(fma(atan(spvNMax(_976, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1273 = _1272 * 0.125;
                float _1279 = (_1272 + 1.0) * 0.125;
                vec4 _1285 = _1068.xyzx;
                float _1289 = 0.0040000001899898052215576171875 - _1072;
                float _1291 = sqrt(fma(_1185, _1289, _1184));
                float _1292 = fma(_972, _1289, _955);
                float _1293 = _972 * _1289;
                float _1295 = fma(_42._m0, _42._m0, fma(_1293, _1293, _1198));
                vec4 _1300 = mix(_1206, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1293 < 0.0) && (_1295 > 0.0)));
                float _1310 = fma(fma(_1293, _1300.x, sqrt(_1295 + _1300.y)) / (_1195 + _1300.z), 0.4921875, _1300.w);
                float _1321 = sqrt(fma(_1291, _1291, _1191));
                float _1325 = fma(_42._m0, _42._m0, fma(_1292, _1292, -(_1291 * _1291)));
                vec4 _1330 = mix(_1206, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1292 < 0.0) && (_1325 > 0.0)));
                float _1332 = fma(_1321 / _1193, 0.96875, 0.015625);
                float _1342 = fma(fma(_1292, _1330.x, sqrt(_1325 + _1330.y)) / (_1321 + _1330.z), 0.4921875, _1330.w);
                _1357 = mix(spvNMax(fma(-((textureLod(sampler3D(_44, _20), vec3(_1273, _1266, _1256), 0.0) * _1235) + (textureLod(sampler3D(_44, _20), vec3(_1279, _1266, _1256), 0.0) * _1229)), _1285, (textureLod(sampler3D(_44, _20), vec3(_1231, _1219, _1209), 0.0) * _1235) + (textureLod(sampler3D(_44, _20), vec3(_1238, _1219, _1209), 0.0) * _1229)), vec4(0.0)), spvNMax(fma(-((textureLod(sampler3D(_44, _20), vec3(_1273, _1342, _1332), 0.0) * _1235) + (textureLod(sampler3D(_44, _20), vec3(_1279, _1342, _1332), 0.0) * _1229)), _1285, (textureLod(sampler3D(_44, _20), vec3(_1231, _1310, _1209), 0.0) * _1235) + (textureLod(sampler3D(_44, _20), vec3(_1238, _1310, _1209), 0.0) * _1229)), vec4(0.0)), vec4((_1074 + 0.0040000001899898052215576171875) * 124.99999237060546875));
            }
            else
            {
                float _1082 = -(_42._m0 * _42._m0);
                float _1084 = sqrt(fma(_42._m1, _42._m1, _1082));
                float _1086 = sqrt(fma(_972, _972, _1082));
                float _1087 = _972 * _956;
                float _1091 = fma(_42._m0, _42._m0, fma(_1087, _1087, -(_972 * _972)));
                vec4 _1097 = vec4(-1.0, _1084 * _1084, _1084, 0.50390625);
                vec4 _1098 = mix(_1097, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_1087 < 0.0) && (_1091 > 0.0)));
                float _1100 = fma(_1086 / _1084, 0.96875, 0.015625);
                float _1110 = fma(fma(_1087, _1098.x, sqrt(_1091 + _1098.y)) / (_1086 + _1098.z), 0.4921875, _1098.w);
                float _1116 = _962 + 1.0;
                float _1118 = floor(_1116 * 3.5);
                float _1120 = fma(_1116, 3.5, -_1118);
                float _1121 = _1118 + fma(fma(atan(spvNMax(_964, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                float _1126 = 1.0 - _1120;
                float _1136 = sqrt(fma(_973, _973, _1082));
                float _1140 = fma(_42._m0, _42._m0, fma(_974, _974, -(_973 * _973)));
                vec4 _1145 = mix(_1097, vec4(1.0, 0.0, 0.0, 0.49609375), bvec4((_974 < 0.0) && (_1140 > 0.0)));
                float _1147 = fma(_1136 / _1084, 0.96875, 0.015625);
                float _1157 = fma(fma(_974, _1145.x, sqrt(_1140 + _1145.y)) / (_1136 + _1145.z), 0.4921875, _1145.w);
                float _1163 = _1118 + fma(fma(atan(spvNMax(_976, -0.19750000536441802978515625) * 5.3496246337890625), 0.90909087657928466796875, 0.7400000095367431640625), 0.484375, 0.015625);
                _1357 = spvNMax(fma(-((textureLod(sampler3D(_44, _20), vec3(_1163 * 0.125, _1157, _1147), 0.0) * _1126) + (textureLod(sampler3D(_44, _20), vec3((_1163 + 1.0) * 0.125, _1157, _1147), 0.0) * _1120)), _1068.xyzx, (textureLod(sampler3D(_44, _20), vec3(_1121 * 0.125, _1110, _1100), 0.0) * _1126) + (textureLod(sampler3D(_44, _20), vec3((_1121 + 1.0) * 0.125, _1110, _1100), 0.0) * _1120)), vec4(0.0));
            }
            float _1372 = fma(_962, _962, 1.0);
            _1394 = _1068;
            _1395 = (_1357.xyz * (0.0596831031143665313720703125 * _1372)) + ((((_1357.xyz * (_1357.w * smoothstep(0.0, 0.0199999995529651641845703125, _964))) / vec3(spvNMax(_1357.x, 9.9999997473787516355514526367188e-05))) * (vec3(_42._m5.x) / _42._m5)) * ((((0.119366206228733062744140625 * fma(-_42._m9, _42._m9, 1.0)) * (-pow(spvNMax(abs(abs(fma(_42._m9 * (-2.0), _962, fma(_42._m9, _42._m9, 1.0)))), 9.9999997473787516355514526367188e-05), 1.5))) * _1372) / fma(_42._m9, _42._m9, 2.0)));
        }
        else
        {
            _1394 = vec3(1.0);
            _1395 = vec3(0.0);
        }
        vec3 _1410;
        if (_14._m35 == 0.0)
        {
            _1410 = ((mix(textureLod(sampler2D(_43, _20), vec2(atan((_887 + 0.1500000059604644775390625) * 12.26210498809814453125) * 0.666666686534881591796875, sqrt((_884 - _42._m0) / (_42._m1 - _42._m0))), 0.0).xyz, vec3(0.0), bvec3(_887 < (-sqrt(fma(-_888, _888, 1.0))))) * 1.0) * _14._m34) * _14._m20;
        }
        else
        {
            _1410 = _14._m2;
        }
        _1411 = _1395 * (_14._m19 * 10.0);
        _1412 = _1394;
        _1413 = _1410;
    }
    else
    {
        _1411 = vec3(0.0);
        _1412 = vec3(1.0);
        _1413 = _14._m2;
    }
    float _1497;
    SPIRV_CROSS_BRANCH
    if (_14._m21 > 0.0)
    {
        vec3 _1436 = _15._m6 + _8;
        vec3 _1443 = vec3(0.0, _14._m18.z, 0.0) + (_1436 - vec3(0.0, _14._m25, 0.0));
        float _1447 = dot(_1443, _14._m24);
        vec2 _1457 = ((((_1443 + (_14._m24 * (sqrt(fma(_1447, _1447, fma(_14._m18.z, _14._m18.z, -dot(_1443, _1443)))) - _1447))).xz * _14._m18.w) * 0.5) + vec2(0.5)) + _14._m18.xy;
        _1457.x = 1.0 - _1457.x;
        vec3 _1470 = vec3(0.0, _14._m23.z, 0.0) + (_1436 - vec3(0.0, _14._m27, 0.0));
        float _1474 = dot(_1470, _14._m26);
        vec2 _1484 = ((((_1470 + (_14._m26 * (sqrt(fma(_1474, _1474, fma(_14._m23.z, _14._m23.z, -dot(_1470, _1470)))) - _1474))).xz * _14._m23.w) * 0.5) + vec2(0.5)) + _14._m23.xy;
        _1484.x = 1.0 - _1484.x;
        _1497 = _810 * (1.0 - clamp(smoothstep(0.0500000007450580596923828125, 0.550000011920928955078125, mix(textureLod(sampler2D(_45, _20), _1457, 0.0).x, textureLod(sampler2D(_46, _20), _1484, 0.0).x, _14._m16)) * _14._m21, 0.0, 1.0));
    }
    else
    {
        _1497 = _810;
    }
    float _1586;
    SPIRV_CROSS_BRANCH
    if (_14._m17 > 0.0)
    {
        vec3 _1524 = _15._m6 + _8;
        vec3 _1532 = vec3(0.0, _14._m28.z, 0.0) + ((_14._m29 + _1524) - vec3(0.0, _14._m30, 0.0));
        float _1536 = dot(_1532, _14._m24);
        vec2 _1546 = ((((_1532 + (_14._m24 * (sqrt(fma(_1536, _1536, fma(_14._m28.z, _14._m28.z, -dot(_1532, _1532)))) - _1536))).xz * _14._m28.w) * 0.5) + vec2(0.5)) + _14._m28.xy;
        _1546.x = 1.0 - _1546.x;
        vec3 _1560 = vec3(0.0, _14._m31.z, 0.0) + ((_14._m32 + _1524) - vec3(0.0, _14._m33, 0.0));
        float _1564 = dot(_1560, _14._m26);
        vec2 _1574 = ((((_1560 + (_14._m26 * (sqrt(fma(_1564, _1564, fma(_14._m31.z, _14._m31.z, -dot(_1560, _1560)))) - _1564))).xz * _14._m31.w) * 0.5) + vec2(0.5)) + _14._m31.xy;
        _1574.x = 1.0 - _1574.x;
        _1586 = _1497 * (1.0 - clamp(mix(textureLod(sampler2D(_38, _20), _1546, 0.0).x, textureLod(sampler2D(_39, _20), _1574, 0.0).x, _14._m16) * _14._m17, 0.0, 1.0));
    }
    else
    {
        _1586 = _1497;
    }
    float _1593 = fract(52.98291778564453125 * fract(fma(0.067110560834407806396484375, gl_FragCoord.x, 0.005837149918079376220703125 * gl_FragCoord.y)));
    float _1600 = clamp(fma(_35._m34.y, length(_8), _35._m34.x), 0.0, 1.0);
    uint _1601 = uint(int(fma(fma(float(int(clamp(fma(log2(_9), _35._m21, _35._m22), 0.0, float(_35._m26)))), _35._m24, float(_837.y)), _35._m23, float(_837.x))));
    uvec4 _1604 = uvec4(_23._m0[_1601]);
    uint _1605 = _1604.x;
    uint _1606 = _1604.y;
    uint _1609 = ((_1606 >> 0u) & 4095u) + _1605;
    uint _1612 = ((_1606 >> 12u) & 4095u) + _1609;
    uint _1616 = ((_1604.z >> 0u) & 1023u) + _1612;
    float _1618 = spvNMax(dot(_404, _827), 9.9999997473787516355514526367188e-06);
    float _1620;
    bool _1623;
    vec3 _1625;
    vec3 _1627;
    uint _1629;
    _1620 = _308;
    _1623 = false;
    _1625 = vec3(0.0);
    _1627 = vec3(0.0);
    _1629 = _1605;
    float _1621;
    bool _1624;
    vec3 _1626;
    vec3 _1628;
    for (; _1629 < _1609; _1620 = _1621, _1623 = _1624, _1625 = _1626, _1627 = _1628, _1629++)
    {
        uint _1636 = uint(_24._m0[_1629]);
        float _1654 = abs(_25._m0[_1636]._m5);
        if ((_25._m0[_1636]._m6 & (1u << (_47._m3 & 31u))) != 0u)
        {
            vec3 _1669 = _25._m0[_1636]._m0.xyz - _8;
            float _1670 = dot(_1669, _1669);
            vec3 _1673 = _1669 * inversesqrt(spvNMax(_1670, 1.0000000133514319600180897396058e-10));
            float _1674 = _25._m0[_1636]._m0.w * _25._m0[_1636]._m0.w;
            float _1910;
            bool _1911;
            vec3 _1912;
            vec3 _1913;
            if (_1670 < (1.0 / _1674))
            {
                vec3 _1679 = _827 + _1673;
                vec3 _1683 = _1679 * inversesqrt(spvNMax(dot(_1679, _1679), 1.0000000133514319600180897396058e-10));
                float _1685 = clamp(dot(_1673, _1683), 0.0, 1.0);
                float _1687 = clamp(dot(_404, _1683), 0.0, 1.0);
                float _1689 = clamp(dot(_404, _1673), 0.0, 1.0);
                float _1690 = _1670 * _1674;
                float _1696 = pow(spvNMax(abs(clamp(fma(-_1690, _1690, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _25._m0[_1636]._m4);
                float _1706;
                if (_25._m0[_1636]._m5 < 0.0)
                {
                    _1706 = _1696 * fma(4.0, _1674, _1654);
                }
                else
                {
                    _1706 = _1696 * ((1.0 / spvNMax(_1670, 9.9999997473787516355514526367188e-05)) + _1654);
                }
                float _1708 = 0.079577468335628509521484375 * (_1689 * _1706);
                float _1843;
                bool _1844;
                float _1845;
                if ((_25._m0[_1636]._m7 & 1u) != 0u)
                {
                    uint _1733;
                    do
                    {
                        vec3 _1713 = -_1673;
                        float _1714 = dot(_1713, vec3(0.0, -0.57735025882720947265625, 0.8164966106414794921875));
                        float _1715 = dot(_1713, vec3(0.0, -0.57735025882720947265625, -0.8164966106414794921875));
                        float _1716 = dot(_1713, vec3(-0.8164966106414794921875, 0.57735025882720947265625, 0.0));
                        float _1720 = spvNMax(spvNMax(_1714, _1715), spvNMax(_1716, dot(_1713, vec3(0.8164966106414794921875, 0.57735025882720947265625, 0.0))));
                        if (_1720 == _1714)
                        {
                            _1733 = 0u;
                            break;
                        }
                        else
                        {
                            if (_1720 == _1715)
                            {
                                _1733 = 1u;
                                break;
                            }
                            else
                            {
                                if (_1720 == _1716)
                                {
                                    _1733 = 2u;
                                    break;
                                }
                                else
                                {
                                    _1733 = 3u;
                                    break;
                                }
                                break; // unreachable workaround
                            }
                            break; // unreachable workaround
                        }
                        break; // unreachable workaround
                    } while(false);
                    uint _1735 = uint(int(_25._m0[_1636]._m7 >> 2u)) + _1733;
                    float _1837;
                    bool _1838;
                    float _1839;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_1689 <= 0.0) && true)
                        {
                            _1837 = _1620;
                            _1838 = _1623;
                            _1839 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _1768 = _36._m0[_1735]._m0 * vec4(_8 + (_404 * ((3.5 * float(int(sign(_1689)))) * (_36._m0[_1735]._m4 * sqrt(_1670)))), 1.0);
                            vec3 _1772 = _1768.xyz / vec3(_1768.w);
                            vec2 _1775 = (_1772.xy * 0.5) + vec2(0.5);
                            _1775.y = 1.0 - _1775.y;
                            float _1784 = (_36._m0[_1735]._m5.y / _36._m0[_1735]._m6) / (_1772.z - _36._m0[_1735]._m5.x);
                            float _1789 = _1623 ? _1620 : 6.283185482025146484375;
                            float _1790 = _1593 * _1789;
                            vec2 _1791 = _36._m0[_1735]._m1 + _35._m33;
                            vec2 _1794 = (_36._m0[_1735]._m1 + vec2(_36._m0[_1735]._m2)) - _35._m33;
                            float _1796;
                            _1796 = 0.0;
                            for (int _1799 = 0; _1799 < 12; )
                            {
                                float _1804 = float(uint(_1799));
                                float _1807 = sqrt(_1804 + 0.5) * 0.288675129413604736328125;
                                float _1808 = fma(_1804, 2.3999631404876708984375, _1790);
                                vec2 _1816 = clamp(fma((vec3(cos(_1808), sin(_1808), _1807).xy * _1807) * 2.5, _35._m33, _1775), _1791, _1794);
                                vec2 _1819 = fract(fma(vec2(1.0) / _35._m33, _1816, vec2(0.5)));
                                vec4 _1825 = vec4(lessThan(vec4(_1784), textureGather(sampler2D(_37, _28), _1816)));
                                float _1828 = _1819.x;
                                _1796 += clamp(mix(mix(_1825.w, _1825.z, _1828), mix(_1825.x, _1825.y, _1828), _1819.y), 0.0, 1.0);
                                _1799++;
                                continue;
                            }
                            _1837 = _1789;
                            _1838 = _1623 ? _1623 : true;
                            _1839 = _1796 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _1843 = _1837;
                    _1844 = _1838;
                    _1845 = _1708 * mix(1.0, _1839, spvNMin(_1600, _25._m0[_1636]._m8));
                    if (_1689 > 0.0) _rdxShadowMin = min(_rdxShadowMin, _1839);
                }
                else
                {
                    _1843 = _1620;
                    _1844 = _1623;
                    _1845 = _1708;
                }
                vec3 _1908;
                vec3 _1909;
                if (_1689 > 0.0)
                {
                    vec3 _1851 = _25._m0[_1636]._m1.xyz * (_1845 * ((_25._m0[_1636]._m3 < 0.0) ? _19._m0[0u] : 1.0));
                    vec3 _1858 = vec3(fma((2.0 * _1685) * _1685, _823, mix(0.0, 0.5, _823))) - vec3(1.0);
                    float _1879 = (_823 + 1.0) * 0.5;
                    float _1880 = _823 * _823;
                    float _1886 = _1879 * _1879;
                    float _1898 = _1880 * _1880;
                    float _1901 = fma(fma(_1687, _1898, -_1687), _1687, 1.0);
                    _1908 = fma(_1851, (vec3(1.0) * pow(spvNMax(abs(1.0 - _1685), 9.9999997473787516355514526367188e-05), 5.0)) * ((0.5 / fma(_1689, sqrt(fma(fma(-_1618, _1886, _1618), _1618, _1886)), _1618 * sqrt(fma(fma(-_1689, _1886, _1689), _1689, _1886)))) * (_1898 * (0.3183098733425140380859375 / (_1901 * _1901)))), _1625);
                    _1909 = fma(_1851, _813 * (0.3183098733425140380859375 * (((vec3(1.0) + (_1858 * pow(spvNMax(abs(1.0 - _1689), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_1858 * pow(spvNMax(abs(1.0 - _1618), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _823))), _1627);
                }
                else
                {
                    _1908 = _1625;
                    _1909 = _1627;
                }
                _1910 = _1843;
                _1911 = _1844;
                _1912 = _1908;
                _1913 = _1909;
            }
            else
            {
                _1910 = _1620;
                _1911 = _1623;
                _1912 = _1625;
                _1913 = _1627;
            }
            _1621 = _1910;
            _1624 = _1911;
            _1626 = _1912;
            _1628 = _1913;
        }
        else
        {
            _1621 = _1620;
            _1624 = _1623;
            _1626 = _1625;
            _1628 = _1627;
        }
    }
    float _1915;
    bool _1918;
    vec3 _1920;
    vec3 _1922;
    uint _1924;
    _1915 = _1620;
    _1918 = _1623;
    _1920 = _1625;
    _1922 = _1627;
    _1924 = _1629;
    float _1916;
    bool _1919;
    vec3 _1921;
    vec3 _1923;
    for (; _1924 < _1612; _1915 = _1916, _1918 = _1919, _1920 = _1921, _1922 = _1923, _1924++)
    {
        uint _1931 = uint(_24._m0[_1924]);
        float _1944 = abs(_25._m0[_1931]._m5);
        if ((_25._m0[_1931]._m6 & (1u << (_47._m3 & 31u))) != 0u)
        {
            vec3 _1962 = _25._m0[_1931]._m0.xyz - _8;
            float _1963 = dot(_1962, _1962);
            vec3 _1966 = _1962 * inversesqrt(spvNMax(_1963, 1.0000000133514319600180897396058e-10));
            float _1967 = _25._m0[_1931]._m0.w * _25._m0[_1931]._m0.w;
            float _2193;
            bool _2194;
            vec3 _2195;
            vec3 _2196;
            if (_1963 < (1.0 / _1967))
            {
                vec3 _1972 = _827 + _1966;
                vec3 _1976 = _1972 * inversesqrt(spvNMax(dot(_1972, _1972), 1.0000000133514319600180897396058e-10));
                float _1978 = clamp(dot(_1966, _1976), 0.0, 1.0);
                float _1980 = clamp(dot(_404, _1976), 0.0, 1.0);
                float _1982 = clamp(dot(_404, _1966), 0.0, 1.0);
                float _1985 = dot(-_1966, normalize(_25._m0[_1931]._m2.xyz));
                float _2014;
                if (_1985 > _25._m0[_1931]._m1.w)
                {
                    float _1989 = _1963 * _1967;
                    float _1995 = pow(spvNMax(abs(clamp(fma(-_1989, _1989, 1.0), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), _25._m0[_1931]._m4);
                    float _2005;
                    if (_25._m0[_1931]._m5 < 0.0)
                    {
                        _2005 = _1995 * fma(4.0, _1967, _1944);
                    }
                    else
                    {
                        _2005 = _1995 * ((1.0 / spvNMax(_1963, 9.9999997473787516355514526367188e-05)) + _1944);
                    }
                    float _2010 = clamp((_1985 - _25._m0[_1931]._m1.w) / spvNMax(_25._m0[_1931]._m2.w - _25._m0[_1931]._m1.w, 9.9999997473787516355514526367188e-05), 0.0, 1.0);
                    _2014 = _1982 * (_2005 * (_2010 * _2010));
                }
                else
                {
                    _2014 = 0.0;
                }
                float _2015 = 0.3183098733425140380859375 * _2014;
                float _2126;
                bool _2127;
                float _2128;
                if ((_25._m0[_1931]._m7 & 1u) != 0u)
                {
                    uint _2018 = uint(int(_25._m0[_1931]._m7 >> 2u));
                    float _2120;
                    bool _2121;
                    float _2122;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_1982 <= 0.0) && true)
                        {
                            _2120 = _1915;
                            _2121 = _1918;
                            _2122 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2051 = _36._m0[_2018]._m0 * vec4(_8 + (_404 * ((3.5 * float(int(sign(_1982)))) * (_36._m0[_2018]._m4 * sqrt(_1963)))), 1.0);
                            vec3 _2055 = _2051.xyz / vec3(_2051.w);
                            vec2 _2058 = (_2055.xy * 0.5) + vec2(0.5);
                            _2058.y = 1.0 - _2058.y;
                            float _2067 = (_36._m0[_2018]._m5.y / _36._m0[_2018]._m6) / (_2055.z - _36._m0[_2018]._m5.x);
                            float _2072 = _1918 ? _1915 : 6.283185482025146484375;
                            float _2073 = _1593 * _2072;
                            vec2 _2074 = _36._m0[_2018]._m1 + _35._m33;
                            vec2 _2077 = (_36._m0[_2018]._m1 + vec2(_36._m0[_2018]._m2)) - _35._m33;
                            float _2079;
                            _2079 = 0.0;
                            for (int _2082 = 0; _2082 < 12; )
                            {
                                float _2087 = float(uint(_2082));
                                float _2090 = sqrt(_2087 + 0.5) * 0.288675129413604736328125;
                                float _2091 = fma(_2087, 2.3999631404876708984375, _2073);
                                vec2 _2099 = clamp(fma((vec3(cos(_2091), sin(_2091), _2090).xy * _2090) * 2.5, _35._m33, _2058), _2074, _2077);
                                vec2 _2102 = fract(fma(vec2(1.0) / _35._m33, _2099, vec2(0.5)));
                                vec4 _2108 = vec4(lessThan(vec4(_2067), textureGather(sampler2D(_37, _28), _2099)));
                                float _2111 = _2102.x;
                                _2079 += clamp(mix(mix(_2108.w, _2108.z, _2111), mix(_2108.x, _2108.y, _2111), _2102.y), 0.0, 1.0);
                                _2082++;
                                continue;
                            }
                            _2120 = _2072;
                            _2121 = _1918 ? _1918 : true;
                            _2122 = _2079 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2126 = _2120;
                    _2127 = _2121;
                    _2128 = _2015 * mix(1.0, _2122, spvNMin(_1600, _25._m0[_1931]._m8));
                    if (_1982 > 0.0) _rdxShadowMin = min(_rdxShadowMin, _2122);
                }
                else
                {
                    _2126 = _1915;
                    _2127 = _1918;
                    _2128 = _2015;
                }
                vec3 _2191;
                vec3 _2192;
                if (_1982 > 0.0)
                {
                    vec3 _2134 = _25._m0[_1931]._m1.xyz * (_2128 * ((_25._m0[_1931]._m3 < 0.0) ? _19._m0[0u] : 1.0));
                    vec3 _2141 = vec3(fma((2.0 * _1978) * _1978, _823, mix(0.0, 0.5, _823))) - vec3(1.0);
                    float _2162 = (_823 + 1.0) * 0.5;
                    float _2163 = _823 * _823;
                    float _2169 = _2162 * _2162;
                    float _2181 = _2163 * _2163;
                    float _2184 = fma(fma(_1980, _2181, -_1980), _1980, 1.0);
                    _2191 = fma(_2134, (vec3(1.0) * pow(spvNMax(abs(1.0 - _1978), 9.9999997473787516355514526367188e-05), 5.0)) * ((0.5 / fma(_1982, sqrt(fma(fma(-_1618, _2169, _1618), _1618, _2169)), _1618 * sqrt(fma(fma(-_1982, _2169, _1982), _1982, _2169)))) * (_2181 * (0.3183098733425140380859375 / (_2184 * _2184)))), _1920);
                    _2192 = fma(_2134, _813 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2141 * pow(spvNMax(abs(1.0 - _1982), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2141 * pow(spvNMax(abs(1.0 - _1618), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _823))), _1922);
                }
                else
                {
                    _2191 = _1920;
                    _2192 = _1922;
                }
                _2193 = _2126;
                _2194 = _2127;
                _2195 = _2191;
                _2196 = _2192;
            }
            else
            {
                _2193 = _1915;
                _2194 = _1918;
                _2195 = _1920;
                _2196 = _1922;
            }
            _1916 = _2193;
            _1919 = _2194;
            _1921 = _2195;
            _1923 = _2196;
        }
        else
        {
            _1916 = _1915;
            _1919 = _1918;
            _1921 = _1920;
            _1923 = _1922;
        }
    }
    vec3 _2203;
    vec3 _2205;
    _2203 = _1920;
    _2205 = _1922;
    float _2199;
    bool _2202;
    vec3 _2204;
    vec3 _2206;
    float _2198 = _1915;
    bool _2201 = _1918;
    uint _2207 = _1924;
    for (; _2207 < _1616; _2198 = _2199, _2201 = _2202, _2203 = _2204, _2205 = _2206, _2207++)
    {
        uint _2214 = uint(_24._m0[_2207]);
        int _2243 = int(_26._m0[_2214]._m1 >> 1u) - 1;
        if (((_26._m0[_2214]._m4 & 16777215u) & (1u << (_47._m3 & 31u))) != 0u)
        {
            vec3 _2254 = _26._m0[_2214]._m6 * vec4(_8, 1.0);
            float _2638;
            bool _2639;
            vec3 _2640;
            vec3 _2641;
            if (all(lessThan(abs(_2254 - vec3(0.5)), vec3(0.5))))
            {
                vec3 _2261 = _827 + _26._m0[_2214]._m9;
                vec3 _2265 = _2261 * inversesqrt(spvNMax(dot(_2261, _2261), 1.0000000133514319600180897396058e-10));
                float _2267 = clamp(dot(_26._m0[_2214]._m9, _2265), 0.0, 1.0);
                float _2269 = clamp(dot(_404, _2265), 0.0, 1.0);
                float _2271 = clamp(dot(_404, _26._m0[_2214]._m9), 0.0, 1.0);
                int _2272 = int(_26._m0[_2214]._m4 >> 24u);
                float _2273 = _2254.z;
                vec3 _2312;
                if (_2273 < _26._m0[_2214]._m2.x)
                {
                    float _2300 = _2273 * _26._m0[_2214]._m2.z;
                    float _2303 = _2300 * _2300;
                    vec3 _2311;
                    _2311.z = dot(_324[_2272], vec4(_2300, _2303, smoothstep(0.0, 1.0, _2300), (_2303 * _2300) * fma(_2300, fma(_2300, 6.0, -15.0), 10.0)));
                    _2312 = _2311;
                }
                else
                {
                    vec3 _2298;
                    if (_2273 > _26._m0[_2214]._m2.y)
                    {
                        float _2286 = (1.0 - _2273) * _26._m0[_2214]._m2.w;
                        float _2289 = _2286 * _2286;
                        vec3 _2297;
                        _2297.z = dot(_324[_2272], vec4(_2286, _2289, smoothstep(0.0, 1.0, _2286), (_2289 * _2286) * fma(_2286, fma(_2286, 6.0, -15.0), 10.0)));
                        _2298 = _2297;
                    }
                    else
                    {
                        _2298 = vec3(0.0, 0.0, 1.0);
                    }
                    _2312 = _2298;
                }
                vec2 _2313 = _2254.xy;
                vec2 _2317 = (vec2(0.5) - abs(_2313 - vec2(0.5))) * _26._m0[_2214]._m3;
                float _2318 = _2317.x;
                vec3 _2335;
                if (_2318 < 1.0)
                {
                    float _2326 = _2318 * _2318;
                    vec3 _2334 = _2312;
                    _2334.x = dot(_324[_2272], vec4(_2318, _2326, smoothstep(0.0, 1.0, _2318), (_2326 * _2318) * fma(_2318, fma(_2318, 6.0, -15.0), 10.0)));
                    _2335 = _2334;
                }
                else
                {
                    vec3 _2323 = _2312;
                    _2323.x = 1.0;
                    _2335 = _2323;
                }
                float _2336 = _2317.y;
                vec3 _2353;
                if (_2336 < 1.0)
                {
                    float _2344 = _2336 * _2336;
                    vec3 _2352 = _2335;
                    _2352.y = dot(_324[_2272], vec4(_2336, _2344, smoothstep(0.0, 1.0, _2336), (_2344 * _2336) * fma(_2336, fma(_2336, 6.0, -15.0), 10.0)));
                    _2353 = _2352;
                }
                else
                {
                    vec3 _2341 = _2335;
                    _2341.y = 1.0;
                    _2353 = _2341;
                }
                float _2359 = _2271 * ((_2353.x * _2353.y) * _2353.z);
                float _2464;
                bool _2465;
                float _2466;
                if ((_26._m0[_2214]._m8 & 1u) != 0u)
                {
                    uint _2362 = uint(int(_26._m0[_2214]._m8 >> 2u));
                    float _2458;
                    bool _2459;
                    float _2460;
                    do
                    {
                        SPIRV_CROSS_BRANCH
                        if ((_2271 <= 0.0) && true)
                        {
                            _2458 = _2198;
                            _2459 = _2201;
                            _2460 = 0.0;
                            break;
                        }
                        else
                        {
                            vec4 _2393 = _36._m0[_2362]._m0 * vec4(_8 + (_404 * ((3.5 * float(int(sign(_2271)))) * _36._m0[_2362]._m4)), 1.0);
                            vec2 _2396 = (_2393.xy * 0.5) + vec2(0.5);
                            _2396.y = 1.0 - _2396.y;
                            float _2405 = ((_2393.z - _36._m0[_2362]._m5.y) / _36._m0[_2362]._m5.x) / _36._m0[_2362]._m6;
                            float _2410 = _2201 ? _2198 : 6.283185482025146484375;
                            float _2411 = _1593 * _2410;
                            vec2 _2412 = _36._m0[_2362]._m1 + _35._m33;
                            vec2 _2415 = (_36._m0[_2362]._m1 + vec2(_36._m0[_2362]._m2)) - _35._m33;
                            float _2417;
                            _2417 = 0.0;
                            for (int _2420 = 0; _2420 < 12; )
                            {
                                float _2425 = float(uint(_2420));
                                float _2428 = sqrt(_2425 + 0.5) * 0.288675129413604736328125;
                                float _2429 = fma(_2425, 2.3999631404876708984375, _2411);
                                vec2 _2437 = clamp(fma((vec3(cos(_2429), sin(_2429), _2428).xy * _2428) * 2.5, _35._m33, _2396), _2412, _2415);
                                vec2 _2440 = fract(fma(vec2(1.0) / _35._m33, _2437, vec2(0.5)));
                                vec4 _2446 = vec4(lessThan(vec4(_2405), textureGather(sampler2D(_37, _28), _2437)));
                                float _2449 = _2440.x;
                                _2417 += clamp(mix(mix(_2446.w, _2446.z, _2449), mix(_2446.x, _2446.y, _2449), _2440.y), 0.0, 1.0);
                                _2420++;
                                continue;
                            }
                            _2458 = _2410;
                            _2459 = _2201 ? _2201 : true;
                            _2460 = _2417 * 0.083333335816860198974609375;
                            break;
                        }
                        break; // unreachable workaround
                    } while(false);
                    _2464 = _2458;
                    _2465 = _2459;
                    _2466 = _2359 * mix(1.0, _2460, spvNMin(_1600, _26._m0[_2214]._m5));
                    if (_2271 > 0.0) _rdxShadowMin = min(_rdxShadowMin, _2460);
                }
                else
                {
                    _2464 = _2198;
                    _2465 = _2201;
                    _2466 = _2359;
                }
                vec3 _2507;
                if (_2243 >= 0)
                {
                    uint _2471 = gl_SubgroupInvocationID & 3u;
                    vec2 _2477 = (subgroupQuadSwapHorizontal(_2313) - _2313) * (((_2471 & 1u) != 0u) ? (-1.0) : 1.0);
                    vec2 _2483 = (subgroupQuadSwapVertical(_2313) - _2313) * (((_2471 & 2u) != 0u) ? (-1.0) : 1.0);
                    vec2 _2487 = mix(_2477, vec2(0.0), bvec2(any(isnan(_2477))));
                    vec2 _2491 = mix(_2483, vec2(0.0), bvec2(any(isnan(_2483))));
                    bvec2 _2500 = bvec2(any(greaterThan(abs(vec4(_2487, _2491)), vec4(0.015625))));
                    int _80 = _2243;
                    _2507 = _26._m0[_2214]._m0 * textureGrad(nonuniformEXT(sampler2D(_41[_80], _20)), _2313, mix(_2487, vec2(0.0), _2500), mix(_2491, vec2(0.0), _2500)).xyz;
                }
                else
                {
                    _2507 = _26._m0[_2214]._m0;
                }
                vec3 _2636;
                vec3 _2637;
                SPIRV_CROSS_BRANCH
                if ((_26._m0[_2214]._m1 & 1u) != 0u)
                {
                    vec3 _2634;
                    vec3 _2635;
                    if (_2271 > 0.0)
                    {
                        vec3 _2577 = _2507 * (_2466 * _19._m0[0u]);
                        vec3 _2584 = vec3(fma((2.0 * _2267) * _2267, _823, mix(0.0, 0.5, _823))) - vec3(1.0);
                        float _2605 = (_823 + 1.0) * 0.5;
                        float _2606 = _823 * _823;
                        float _2612 = _2605 * _2605;
                        float _2624 = _2606 * _2606;
                        float _2627 = fma(fma(_2269, _2624, -_2269), _2269, 1.0);
                        _2634 = fma(_2577, (vec3(1.0) * pow(spvNMax(abs(1.0 - _2267), 9.9999997473787516355514526367188e-05), 5.0)) * ((0.5 / fma(_2271, sqrt(fma(fma(-_1618, _2612, _1618), _1618, _2612)), _1618 * sqrt(fma(fma(-_2271, _2612, _2271), _2271, _2612)))) * (_2624 * (0.3183098733425140380859375 / (_2627 * _2627)))), _2203);
                        _2635 = fma(_2577, _813 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2584 * pow(spvNMax(abs(1.0 - _2271), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2584 * pow(spvNMax(abs(1.0 - _1618), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _823))), _2205);
                    }
                    else
                    {
                        _2634 = _2203;
                        _2635 = _2205;
                    }
                    _2636 = _2634;
                    _2637 = _2635;
                }
                else
                {
                    vec3 _2571;
                    vec3 _2572;
                    if (_2271 > 0.0)
                    {
                        vec3 _2514 = _2507 * _2466;
                        vec3 _2521 = vec3(fma((2.0 * _2267) * _2267, _823, mix(0.0, 0.5, _823))) - vec3(1.0);
                        float _2542 = (_823 + 1.0) * 0.5;
                        float _2543 = _823 * _823;
                        float _2549 = _2542 * _2542;
                        float _2561 = _2543 * _2543;
                        float _2564 = fma(fma(_2269, _2561, -_2269), _2269, 1.0);
                        _2571 = fma(_2514, (vec3(1.0) * pow(spvNMax(abs(1.0 - _2267), 9.9999997473787516355514526367188e-05), 5.0)) * ((0.5 / fma(_2271, sqrt(fma(fma(-_1618, _2549, _1618), _1618, _2549)), _1618 * sqrt(fma(fma(-_2271, _2549, _2271), _2271, _2549)))) * (_2561 * (0.3183098733425140380859375 / (_2564 * _2564)))), _2203);
                        _2572 = fma(_2514, _813 * (0.3183098733425140380859375 * (((vec3(1.0) + (_2521 * pow(spvNMax(abs(1.0 - _2271), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_2521 * pow(spvNMax(abs(1.0 - _1618), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _823))), _2205);
                    }
                    else
                    {
                        _2571 = _2203;
                        _2572 = _2205;
                    }
                    _2636 = _2571;
                    _2637 = _2572;
                }
                _2638 = _2464;
                _2639 = _2465;
                _2640 = _2636;
                _2641 = _2637;
            }
            else
            {
                _2638 = _2198;
                _2639 = _2201;
                _2640 = _2203;
                _2641 = _2205;
            }
            _2199 = _2638;
            _2202 = _2639;
            _2204 = _2640;
            _2206 = _2641;
        }
        else
        {
            _2199 = _2198;
            _2202 = _2201;
            _2204 = _2203;
            _2206 = _2205;
        }
    }
    vec3 _2643 = reflect(-_827, _404);
    vec3 _2655 = textureLod(samplerCube(_30, _20), _404, 0.0).xyz * _35._m27;
    vec3 _2662 = textureLod(samplerCube(_31, _20), _2643, fma(_823, 8.0, _35._m30 - 8.0)).xyz * _35._m27;
    vec3 _2687;
    vec3 _2688;
    SPIRV_CROSS_BRANCH
    if (_35._m29 > 0.0)
    {
        vec3 _2677 = vec3(_35._m29);
        _2687 = mix(_2662, textureLod(samplerCube(_33, _20), _2643, fma(_823, 8.0, _35._m31 - 8.0)).xyz * _35._m28, _2677);
        _2688 = mix(_2655, textureLod(samplerCube(_32, _20), _404, 0.0).xyz * _35._m28, _2677);
    }
    else
    {
        _2687 = _2662;
        _2688 = _2655;
    }
    float _2689 = spvNMax(dot(_827, _404), 0.001953125);
    vec4 _2694 = textureLod(sampler2D(_34, _28), vec2(_2689, _823), 0.0);
    uvec4 _2705 = uvec4(_23._m0[_1601]);
    uint _2707 = _2705.y;
    uint _2717 = ((_2705.z >> 0u) & 1023u) + (((_2707 >> 12u) & 4095u) + (((_2707 >> 0u) & 4095u) + _2705.x));
    uint _2719 = (_2707 >> 24u) + _2717;
    vec3 _2721;
    vec3 _2724;
    _2721 = _2687 * ((vec3(vec3(0.0).x, vec3(0.0).y, vec3(0.0).z) * _2694.x) + vec3(_2694.y));
    _2724 = _2688 * (_813 * _2694.z);
    vec3 _2722;
    vec3 _2725;
    for (uint _2726 = _2717; _2726 < _2719; _2721 = _2722, _2724 = _2725, _2726++)
    {
        uint _2733 = uint(_24._m0[_2726]);
        int _2752 = int((_29._m0[_2733]._m5 >> 1u) & 3u);
        mat3 _2756 = mat3(_29._m0[_2733]._m1[0], _29._m0[_2733]._m1[1], _29._m0[_2733]._m1[2]);
        int _2762 = (int((_29._m0[_2733]._m5 >> 3u) & 16383u) - 1) * 2;
        int _2767 = (int((_29._m0[_2733]._m5 >> 17u) & 16383u) - 1) * 2;
        int _2772 = (int((_29._m0[_2733]._m6 >> 0u) & 65535u) - 1) * 2;
        int _2777 = (int((_29._m0[_2733]._m6 >> 16u) & 65535u) - 1) * 2;
        float _2780 = (_29._m0[_2733]._m3 < 0.0) ? (-_29._m0[_2733]._m3) : 1.0;
        vec3 _2782 = _2756 * (_8 - _29._m0[_2733]._m1[3]);
        bool _2783 = int(_29._m0[_2733]._m5 & 1u) == 1;
        vec3 _2784 = abs(_2782);
        float _2787 = dot(_2782, _2782);
        if (_2783 ? any(greaterThanEqual(_2784, _29._m0[_2733]._m0.xyz)) : (_2787 >= _29._m0[_2733]._m0.y))
        {
            _2722 = _2721;
            _2725 = _2724;
            continue;
        }
        vec3 _2961;
        SPIRV_CROSS_FLATTEN
        if ((_2752 & 1) != 0)
        {
            vec3 _2797 = _2756 * _404;
            vec2 _2886;
            bool _2887;
            if (_2783)
            {
                vec2 _2881;
                bool _2885;
                do
                {
                    vec3 _2865 = (_29._m0[_2733]._m0.xyz - _2782) / _2797;
                    vec3 _2868 = ((-_29._m0[_2733]._m0.xyz) - _2782) / _2797;
                    vec3 _2869 = spvNMin(_2865, _2868);
                    vec3 _2870 = spvNMax(_2865, _2868);
                    float _2875 = spvNMax(_2869.x, spvNMax(_2869.y, _2869.z));
                    float _2880 = spvNMin(_2870.x, spvNMin(_2870.y, _2870.z));
                    _2881 = vec2(_2875, _2880);
                    if (_2875 > _2880)
                    {
                        _2885 = false;
                        break;
                    }
                    _2885 = true;
                    break;
                } while(false);
                _2886 = _2881;
                _2887 = _2885;
            }
            else
            {
                vec2 _2860;
                bool _2861;
                do
                {
                    float _2803 = dot(_2797, _2797);
                    float _2804 = dot(_2797, _2782);
                    float _2805 = 2.0 * _2804;
                    float _2806 = _2787 - _29._m0[_2733]._m0.y;
                    float _2842;
                    float _2843;
                    bool _2844;
                    do
                    {
                        float _2812 = fma(_2805, _2805, -((4.0 * _2803) * _2806));
                        float _2840;
                        float _2841;
                        if (_2812 < 0.0)
                        {
                            _2842 = 0.0;
                            _2843 = 0.0;
                            _2844 = false;
                            break;
                        }
                        else
                        {
                            if (_2812 == 0.0)
                            {
                                float _2839 = (_2804 * (-1.0)) * (1.0 / _2803);
                                _2840 = _2839;
                                _2841 = _2839;
                            }
                            else
                            {
                                float _2832;
                                if (_2805 > 0.0)
                                {
                                    _2832 = (-0.5) * fma(2.0, _2804, sqrt(_2812));
                                }
                                else
                                {
                                    _2832 = (-0.5) * fma(2.0, _2804, -sqrt(_2812));
                                }
                                _2840 = _2806 * (1.0 / _2832);
                                _2841 = _2832 * (1.0 / _2803);
                            }
                        }
                        _2842 = _2840;
                        _2843 = _2841;
                        _2844 = true;
                        break;
                    } while(false);
                    if (!_2844)
                    {
                        _2860 = vec2(0.0);
                        _2861 = false;
                        break;
                    }
                    if ((_2843 < 0.0) && (_2842 < 0.0))
                    {
                        _2860 = vec2(0.0);
                        _2861 = false;
                        break;
                    }
                    vec2 _2859;
                    if (_2843 > _2842)
                    {
                        _2859 = vec2(_2842, _2843);
                    }
                    else
                    {
                        _2859 = vec2(_2843, _2842);
                    }
                    _2860 = _2859;
                    _2861 = true;
                    break;
                } while(false);
                _2886 = _2860;
                _2887 = _2861;
            }
            vec3 _2890 = _2782 + (_2797 * _2886.y);
            float _2911;
            if (_2783)
            {
                _2911 = 1.0 - clamp(length(spvNMax(_2784 - (_29._m0[_2733]._m0.xyz - vec3(_29._m0[_2733]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_29._m0[_2733]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _2911 = clamp((_29._m0[_2733]._m0.x - length(_2782)) * (1.0 / spvNMax(_29._m0[_2733]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _2914 = float(_2887) * smoothstep(0.0, 1.0, _2911);
            vec4 _2956;
            SPIRV_CROSS_BRANCH
            if (_2914 > 9.9999997473787516355514526367188e-05)
            {
                float _2923 = mix(clamp((_2886.y * (1.0 / length(_2890))) * _823, 0.0, _823), _823, _823);
                vec3 _2925 = mix(_2890, _2797, vec3(_2923));
                int _84 = _2762;
                vec4 _2926 = textureLod(nonuniformEXT(samplerCube(_40[_84], _20)), _2925, 0.0);
                int _88 = _2762 + 1;
                _2926.w = textureLod(nonuniformEXT(samplerCube(_40[_88], _20)), _2925, 0.0).x;
                vec4 _2941;
                SPIRV_CROSS_BRANCH
                if (_2767 >= 0)
                {
                    int _92 = _2767;
                    vec4 _2934 = textureLod(nonuniformEXT(samplerCube(_40[_92], _20)), _2925, 0.0);
                    int _96 = _2767 + 1;
                    _2934.w = textureLod(nonuniformEXT(samplerCube(_40[_96], _20)), _2925, 0.0).x;
                    _2941 = mix(_2926, _2934, vec4(_29._m0[_2733]._m3));
                }
                else
                {
                    _2941 = _2926;
                }
                vec4 _2942 = _2941 * _2780;
                vec3 _2951 = (_2942.xyz * _29._m0[_2733]._m4).xyz * (_813 * textureLod(sampler2D(_34, _28), vec2(_2689, _2923), 0.0).z);
                vec4 _2952 = vec4(_2951.x, _2951.y, _2951.z, _2942.w);
                _2952.w = _2942.w * _2914;
                _2956 = _2952;
            }
            else
            {
                _2956 = vec4(0.0);
            }
            _2961 = mix(_2724, _2956.xyz, vec3(_2956.w));
        }
        else
        {
            _2961 = _2724;
        }
        vec3 _3140;
        SPIRV_CROSS_FLATTEN
        if ((_2752 & 2) != 0)
        {
            vec3 _2966 = _2756 * _2643;
            vec2 _3055;
            bool _3056;
            if (_2783)
            {
                vec2 _3050;
                bool _3054;
                do
                {
                    vec3 _3034 = (_29._m0[_2733]._m0.xyz - _2782) / _2966;
                    vec3 _3037 = ((-_29._m0[_2733]._m0.xyz) - _2782) / _2966;
                    vec3 _3038 = spvNMin(_3034, _3037);
                    vec3 _3039 = spvNMax(_3034, _3037);
                    float _3044 = spvNMax(_3038.x, spvNMax(_3038.y, _3038.z));
                    float _3049 = spvNMin(_3039.x, spvNMin(_3039.y, _3039.z));
                    _3050 = vec2(_3044, _3049);
                    if (_3044 > _3049)
                    {
                        _3054 = false;
                        break;
                    }
                    _3054 = true;
                    break;
                } while(false);
                _3055 = _3050;
                _3056 = _3054;
            }
            else
            {
                vec2 _3029;
                bool _3030;
                do
                {
                    float _2972 = dot(_2966, _2966);
                    float _2973 = dot(_2966, _2782);
                    float _2974 = 2.0 * _2973;
                    float _2975 = _2787 - _29._m0[_2733]._m0.y;
                    float _3011;
                    float _3012;
                    bool _3013;
                    do
                    {
                        float _2981 = fma(_2974, _2974, -((4.0 * _2972) * _2975));
                        float _3009;
                        float _3010;
                        if (_2981 < 0.0)
                        {
                            _3011 = 0.0;
                            _3012 = 0.0;
                            _3013 = false;
                            break;
                        }
                        else
                        {
                            if (_2981 == 0.0)
                            {
                                float _3008 = (_2973 * (-1.0)) * (1.0 / _2972);
                                _3009 = _3008;
                                _3010 = _3008;
                            }
                            else
                            {
                                float _3001;
                                if (_2974 > 0.0)
                                {
                                    _3001 = (-0.5) * fma(2.0, _2973, sqrt(_2981));
                                }
                                else
                                {
                                    _3001 = (-0.5) * fma(2.0, _2973, -sqrt(_2981));
                                }
                                _3009 = _2975 * (1.0 / _3001);
                                _3010 = _3001 * (1.0 / _2972);
                            }
                        }
                        _3011 = _3009;
                        _3012 = _3010;
                        _3013 = true;
                        break;
                    } while(false);
                    if (!_3013)
                    {
                        _3029 = vec2(0.0);
                        _3030 = false;
                        break;
                    }
                    if ((_3012 < 0.0) && (_3011 < 0.0))
                    {
                        _3029 = vec2(0.0);
                        _3030 = false;
                        break;
                    }
                    vec2 _3028;
                    if (_3012 > _3011)
                    {
                        _3028 = vec2(_3011, _3012);
                    }
                    else
                    {
                        _3028 = vec2(_3012, _3011);
                    }
                    _3029 = _3028;
                    _3030 = true;
                    break;
                } while(false);
                _3055 = _3029;
                _3056 = _3030;
            }
            vec3 _3059 = _2782 + (_2966 * _3055.y);
            float _3080;
            if (_2783)
            {
                _3080 = 1.0 - clamp(length(spvNMax(_2784 - (_29._m0[_2733]._m0.xyz - vec3(_29._m0[_2733]._m0.w)), vec3(0.0))) * (1.0 / spvNMax(_29._m0[_2733]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            else
            {
                _3080 = clamp((_29._m0[_2733]._m0.x - length(_2782)) * (1.0 / spvNMax(_29._m0[_2733]._m0.w, 9.9999997473787516355514526367188e-05)), 0.0, 1.0);
            }
            float _3083 = float(_3056) * smoothstep(0.0, 1.0, _3080);
            vec4 _3135;
            SPIRV_CROSS_BRANCH
            if (_3083 > 9.9999997473787516355514526367188e-05)
            {
                float _3092 = mix(clamp((_3055.y * (1.0 / length(_3059))) * _823, 0.0, _823), _823, _823);
                vec3 _3094 = mix(_3059, _2966, vec3(_3092));
                float _3095 = _3092 * 8.0;
                int _100 = _2772;
                int _104 = _2772 + 1;
                vec4 _3103 = vec4(textureLod(nonuniformEXT(samplerCube(_40[_100], _20)), _3094, _3095).xyz, textureLod(nonuniformEXT(samplerCube(_40[_104], _20)), _3094, _3095).x);
                vec4 _3117;
                SPIRV_CROSS_BRANCH
                if (_2777 >= 0)
                {
                    int _108 = _2777;
                    int _112 = _2777 + 1;
                    _3117 = mix(_3103, vec4(textureLod(nonuniformEXT(samplerCube(_40[_108], _20)), _3094, _3095).xyz, textureLod(nonuniformEXT(samplerCube(_40[_112], _20)), _3094, _3095).x), vec4(_29._m0[_2733]._m3));
                }
                else
                {
                    _3117 = _3103;
                }
                vec4 _3118 = _3117 * _2780;
                vec4 _3123 = textureLod(sampler2D(_34, _28), vec2(_2689, _3092), 0.0);
                vec3 _3130 = (_3118.xyz * _29._m0[_2733]._m4).xyz * ((vec3(vec3(0.0).x, vec3(0.0).y, vec3(0.0).z) * _3123.x) + vec3(_3123.y));
                vec4 _3131 = vec4(_3130.x, _3130.y, _3130.z, _3118.w);
                _3131.w = _3118.w * _3083;
                _3135 = _3131;
            }
            else
            {
                _3135 = vec4(0.0);
            }
            _3140 = mix(_2721, _3135.xyz, vec3(_3135.w));
        }
        else
        {
            _3140 = _2721;
        }
        _2722 = _3140;
        _2725 = _2961;
    }
    float _3141 = _19._m0[0u] * 100.0;
    // RDX: Aggregate shadow-based IBL occlusion (rendering.hlsl §2.1b principle)
    // _rdxShadowMin tracks minimum shadow across CSM + all per-light shadow
    // maps (point, spot, volume).  Captures hair-shadowcaster occlusion that
    // eyelid-only shadows (_1586) miss in indoor / no-sun scenarios.
    float _rdxOcc = min(_rdxShadowMin, _1586);
    _2721 *= mix(0.08, 1.0, _rdxOcc);
    _2724 *= mix(0.35, 1.0, _rdxOcc);
    vec3 _3145 = _1413 * (_1586 * _19._m0[0u]);
    vec3 _3148 = reflect(_827, _404);
    float _3152 = clamp(dot(_14._m0, normalize(_827 + _14._m0)), 0.0, 1.0);
    float _3154 = clamp(dot(_404, _14._m0), 0.0, 1.0);
    vec3 _3161 = vec3(fma((2.0 * _3152) * _3152, _823, mix(0.0, 0.5, _823))) - vec3(1.0);
    float _3180 = dot(_14._m0, _3148);
    vec3 _3190 = mix(_3148, normalize((_14._m0 * 0.999989449977874755859375) + (normalize(_3148 - (_14._m0 * _3180)) * 0.0045900647528469562530517578125)), bvec3(_3180 < 0.999989449977874755859375));
    vec3 _3192 = normalize(_827 + _3190);
    float _3196 = clamp(dot(_404, _3192), 0.0, 1.0);
    float _3198 = clamp(dot(_404, _3190), 0.0, 1.0);
    float _3200 = (_823 + 1.0) * 0.5;
    float _3201 = _823 * _823;
    float _3207 = _3200 * _3200;
    float _3219 = _3201 * _3201;
    float _3222 = fma(fma(_3196, _3219, -_3196), _3196, 1.0);
    vec3 _3241 = (((_2205 + ((_3145 * (_813 * (0.3183098733425140380859375 * (((vec3(1.0) + (_3161 * pow(spvNMax(abs(1.0 - _3154), 9.9999997473787516355514526367188e-05), 5.0))).x * (vec3(1.0) + (_3161 * pow(spvNMax(abs(1.0 - _1618), 9.9999997473787516355514526367188e-05), 5.0))).x) * mix(1.0, 0.662251651287078857421875, _823))))) * _3154)) + (_2203 + ((_3145 * ((vec3(1.0) * pow(spvNMax(abs(1.0 - clamp(dot(_3190, _3192), 0.0, 1.0)), 9.9999997473787516355514526367188e-05), 5.0)) * ((0.5 / fma(_3198, sqrt(fma(fma(-_1618, _3207, _1618), _1618, _3207)), _1618 * sqrt(fma(fma(-_3198, _3207, _3198), _3198, _3207)))) * (_3219 * (0.3183098733425140380859375 / (_3222 * _3222)))))) * _3154))) * mix(1.0, 1.0, _35._m1)) + (((_2724 * _3141) + (_2721 * _3141)) * 1.0);
    vec4 _3435;
    do
    {
        if (_35._m19[3].z < 0.0)
        {
            _3435 = vec4(0.0, 0.0, 0.0, 1.0);
            break;
        }
        float _3281;
        do
        {
            if (_10 <= _35._m19[0].x)
            {
                _3281 = fma(_35._m19[2].x, _10, _35._m19[3].x);
                break;
            }
            else
            {
                _3281 = _35._m19[1].y * log2(fma(_35._m19[2].y, _10, _35._m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        vec3 _3291 = (vec3((gl_FragCoord.xy * vec2(_16._m2, _16._m3)) / vec2(_35._m32, _35._m18), _3281) + vec3(float(_17._m5), 0.0, 0.0)) - vec3(0.5);
        vec3 _3292 = floor(_3291);
        vec3 _3293 = _3291 - _3292;
        vec3 _3294 = vec3(1.0) - _3293;
        vec3 _3301 = fma(-((_3293 * 0.5) * _3293), vec3(2.0) - _3293, vec3(0.666666686534881591796875));
        vec3 _3308 = (_3293 * 0.16666667163372039794921875) * _3293;
        vec3 _3310 = fma((_3294 * 0.16666667163372039794921875) * _3294, _3294, _3301);
        vec3 _3317 = _35._m17 * (((_3301 / _3310) - vec3(0.5)) + _3292);
        vec3 _3321 = _35._m17 * ((((_3308 * _3293) / fma(_3308, _3293, fma(-((_3294 * 0.5) * _3294), _3293 + vec3(1.0), vec3(0.666666686534881591796875)))) + vec3(1.5)) + _3292);
        float _3329 = _3317.z;
        float _3335 = _3321.x;
        vec2 _3339 = spvNMax(_35._m15, spvNMin(_35._m16, vec2(_3335, _3317.y)));
        float _3340 = _3339.x;
        vec4 _3346 = vec4(_3310.x);
        float _3348 = _3317.x;
        vec2 _3352 = spvNMax(_35._m15, spvNMin(_35._m16, vec2(_3348, _3321.y)));
        float _3353 = _3352.x;
        vec4 _3368 = vec4(_3310.y);
        float _3373 = _3321.z;
        vec4 _3399 = mix(mix(mix(textureLod(sampler3D(_27, _28), vec3(spvNMax(_35._m15, spvNMin(_35._m16, _3321.xy)), _3373), 0.0), textureLod(sampler3D(_27, _28), vec3(_3353, _3352.y, _3373), 0.0), _3346), mix(textureLod(sampler3D(_27, _28), vec3(_3340, _3339.y, _3373), 0.0), textureLod(sampler3D(_27, _28), vec3(spvNMax(_35._m15, spvNMin(_35._m16, vec2(_3348, _3317.y))), _3373), 0.0), _3346), _3368), mix(mix(textureLod(sampler3D(_27, _28), vec3(spvNMax(_35._m15, spvNMin(_35._m16, vec2(_3335, _3321.y))), _3329), 0.0), textureLod(sampler3D(_27, _28), vec3(_3353, _3352.y, _3329), 0.0), _3346), mix(textureLod(sampler3D(_27, _28), vec3(_3340, _3339.y, _3329), 0.0), textureLod(sampler3D(_27, _28), vec3(spvNMax(_35._m15, spvNMin(_35._m16, _3317.xy)), _3329), 0.0), _3346), _3368), vec4(_3310.z)) * vec4(0.03125, 0.03125, 0.03125, 3.0517578125e-05);
        vec4 _3407;
        if (isinf(_3399.x) || isnan(_3399.x))
        {
            vec4 _3406 = _3399;
            _3406.x = 0.0;
            _3407 = _3406;
        }
        else
        {
            _3407 = _3399;
        }
        vec4 _3415;
        if (isinf(_3407.y) || isnan(_3407.y))
        {
            vec4 _3414 = _3407;
            _3414.y = 0.0;
            _3415 = _3414;
        }
        else
        {
            _3415 = _3407;
        }
        vec4 _3423;
        if (isinf(_3415.z) || isnan(_3415.z))
        {
            vec4 _3422 = _3415;
            _3422.z = 0.0;
            _3423 = _3422;
        }
        else
        {
            _3423 = _3415;
        }
        vec4 _3431;
        if (isinf(_3423.w) || isnan(_3423.w))
        {
            vec4 _3430 = _3423;
            _3430.w = 0.0;
            _3431 = _3430;
        }
        else
        {
            _3431 = _3423;
        }
        vec4 _3434 = _3431;
        _3434.w = 1.0 - _3431.w;
        _3435 = _3434;
        break;
    } while(false);
    _12 = spvNMax(vec4(fma(fma(_3241, _1412, _1411 * _19._m0[0u]), _3435.www, _3435.xyz), fma((1.0 - _368) * _369, _48._m1, pow(spvNMax(abs(_369 * _368), 9.9999997473787516355514526367188e-05), (1.0 - _48._m2) * 2.0)) * _47._m2), vec4(0.0));
#if RDX_DEBUG == 1
    _12 = vec4(vec3(_rdxShadowMin), 1.0);  // white = fully lit, black = fully shadowed by any light
#elif RDX_DEBUG == 2
    _12 = vec4(vec3(_1586), 1.0);  // eyelid/brow shadow only
#elif RDX_DEBUG == 3
    _12 = vec4(vec3(_rdxOcc), 1.0);  // combined min(shadowMin, eyelid)
#endif
}

