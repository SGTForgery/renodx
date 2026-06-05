#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_spirv_intrinsics : require
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

layout(set = 0, binding = 0, std140) uniform _27_11
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _11;

layout(set = 0, binding = 1, std140) uniform _29_12
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
} _12;

layout(set = 0, binding = 2, std140) uniform _30_13
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _13;

layout(set = 0, binding = 3, std140) uniform _31_14
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _14;

layout(set = 0, binding = 4, std140) uniform _32_15
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
} _15;

layout(set = 2, binding = 26, std140) uniform _35_22
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
} _22;

layout(set = 1, binding = 0, std140) uniform _36_24
{
    vec3 _m0;
    float _m1;
} _24;

layout(set = 1, binding = 1, std140) uniform _37_25
{
    vec3 _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
    float _m8;
    float _m9;
    float _m10;
    float _m11;
    float _m12;
    float _m13;
    float _m14;
    float _m15;
    float _m16;
    float _m17;
    float _m18;
    float _m19;
    float _m20;
    float _m21;
} _25;

layout(set = 0, binding = 7) uniform sampler _16;
layout(set = 0, binding = 9) uniform sampler _17;
layout(set = 2, binding = 5) uniform texture2D _18;
layout(set = 2, binding = 17) uniform texture3D _19;
layout(set = 2, binding = 18) uniform texture3D _20;
layout(set = 2, binding = 19) uniform sampler _21;
layout(set = 2, binding = 31, r32f) uniform writeonly image2D _23;
layout(set = 1, binding = 2) uniform texture2D _26;

layout(location = 0) in vec4 _4;
layout(location = 1) in vec2 _5;
layout(location = 2) in float _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in float _9;
layout(location = 0) out vec4 _10;

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
    vec2 _148 = gl_FragCoord.xy * vec2(_14._m2, _14._m3);
    float _154 = _25._m1 * 0.0174532942473888397216796875;
    float _155 = cos(_154);
    float _156 = sin(_154);
    vec2 _167 = mix(_5, ((_5 + vec2(-0.5)) * mat2(vec2(_155, _156), vec2(-_156, _155))) + vec2(0.5), vec2(_25._m2));
    vec4 _171 = texture(sampler2D(_26, _16), _167);
    float _196 = fma(abs(fma(fract(fma(_11._m0, _25._m5, 0.5)), 2.0, -1.0)), 1.0 - _25._m6, _25._m6);
    float _233 = clamp((((_4.w * (mix(pow(spvNMax(abs(_171.x), 9.9999997473787516355514526367188e-05), _25._m3), pow(spvNMax(abs(_171.w), 9.9999997473787516355514526367188e-05), _25._m3), _25._m4) * _196)) * clamp(fma(texture(sampler2D(_18, _17), _148).x, _13._m4, -_6) / spvNMax(_25._m7, 9.9999997473787516355514526367188e-05), 0.0, 1.0)) * mix(1.0, clamp((length(_13._m6 - (_7 + _13._m6)) - _25._m8) / (_25._m9 - _25._m8), 0.0, 1.0), floor(_25._m10))) * _25._m11, 0.0, 1.0);
    if ((_233 - _25._m12) < 0.0)
    {
        discard;
    }
    float _249;
    float _242 = _233 * _24._m1;
    vec3 _244 = normalize(-_8);
    vec3 _355;
    do
    {
        _249 = _22._m19[3].z;
        SPIRV_CROSS_BRANCH
        if (_9 < _249)
        {
            float _323;
            do
            {
                if (_9 <= _22._m19[0].x)
                {
                    _323 = fma(_22._m19[2].x, _9, _22._m19[3].x);
                    break;
                }
                else
                {
                    _323 = _22._m19[1].y * log2(fma(_22._m19[2].y, _9, _22._m19[3].y));
                    break;
                }
                break; // unreachable workaround
            } while(false);
            _355 = textureLod(sampler3D(_20, _21), vec3(spvNMax(_22._m15, spvNMin(_22._m16, (vec3(_148 / vec2(_22._m32, _22._m18), _323).xy + vec2(float(_15._m5), 0.0)) * _22._m17.xy)), _323 * _22._m17.z), 0.0).xyz * 0.03125;
            break;
        }
        else
        {
            vec3 _270 = _244.yzx * (0.48860251903533935546875 * _22._m13);
            _355 = spvNMax(vec3(0.0), (((_22._m20[0].xyz * 0.2820948064327239990234375) + (_22._m20[1].xyz * _270.x)) + (_22._m20[2].xyz * _270.y)) + (_22._m20[3].xyz * _270.z)) + (_12._m2 * (fma(-_22._m13, _22._m13, 1.0) / (12.56637096405029296875 * pow(spvNMax(abs(fma(2.0 * _22._m13, -dot(_12._m0, _244), fma(_22._m13, _22._m13, 1.0))), 9.9999997473787516355514526367188e-05), 1.5))));
            break;
        }
        break; // unreachable workaround
    } while(false);
    vec4 _357 = texture(sampler2D(_26, _16), _167);
    vec3 _378 = mix(_4.xyz, (mix(vec3(pow(spvNMax(abs(_357.x), 9.9999997473787516355514526367188e-05), _25._m13)), pow(spvNMax(abs(_357.xyz), vec3(9.9999997473787516355514526367188e-05)), vec3(_25._m13)), vec3(_25._m4)) * _196) * _4.xyz, vec3(_25._m14));
    vec4 _589;
    do
    {
        if (_249 < 0.0)
        {
            _589 = vec4(0.0, 0.0, 0.0, 1.0);
            break;
        }
        float _434;
        do
        {
            if (_9 <= _22._m19[0].x)
            {
                _434 = fma(_22._m19[2].x, _9, _22._m19[3].x);
                break;
            }
            else
            {
                _434 = _22._m19[1].y * log2(fma(_22._m19[2].y, _9, _22._m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        vec3 _445 = (vec3(_148 / vec2(_22._m32, _22._m18), _434) + vec3(float(_15._m5), 0.0, 0.0)) - vec3(0.5);
        vec3 _446 = floor(_445);
        vec3 _447 = _445 - _446;
        vec3 _448 = vec3(1.0) - _447;
        vec3 _455 = fma(-((_447 * 0.5) * _447), vec3(2.0) - _447, vec3(0.666666686534881591796875));
        vec3 _462 = (_447 * 0.16666667163372039794921875) * _447;
        vec3 _464 = fma((_448 * 0.16666667163372039794921875) * _448, _448, _455);
        vec3 _471 = _22._m17 * (((_455 / _464) - vec3(0.5)) + _446);
        vec3 _475 = _22._m17 * ((((_462 * _447) / fma(_462, _447, fma(-((_448 * 0.5) * _448), _447 + vec3(1.0), vec3(0.666666686534881591796875)))) + vec3(1.5)) + _446);
        float _483 = _471.z;
        float _489 = _475.x;
        vec2 _493 = spvNMax(_22._m15, spvNMin(_22._m16, vec2(_489, _471.y)));
        float _494 = _493.x;
        vec4 _500 = vec4(_464.x);
        float _502 = _471.x;
        vec2 _506 = spvNMax(_22._m15, spvNMin(_22._m16, vec2(_502, _475.y)));
        float _507 = _506.x;
        vec4 _522 = vec4(_464.y);
        float _527 = _475.z;
        vec4 _553 = mix(mix(mix(textureLod(sampler3D(_19, _21), vec3(spvNMax(_22._m15, spvNMin(_22._m16, _475.xy)), _527), 0.0), textureLod(sampler3D(_19, _21), vec3(_507, _506.y, _527), 0.0), _500), mix(textureLod(sampler3D(_19, _21), vec3(_494, _493.y, _527), 0.0), textureLod(sampler3D(_19, _21), vec3(spvNMax(_22._m15, spvNMin(_22._m16, vec2(_502, _471.y))), _527), 0.0), _500), _522), mix(mix(textureLod(sampler3D(_19, _21), vec3(spvNMax(_22._m15, spvNMin(_22._m16, vec2(_489, _475.y))), _483), 0.0), textureLod(sampler3D(_19, _21), vec3(_507, _506.y, _483), 0.0), _500), mix(textureLod(sampler3D(_19, _21), vec3(_494, _493.y, _483), 0.0), textureLod(sampler3D(_19, _21), vec3(spvNMax(_22._m15, spvNMin(_22._m16, _471.xy)), _483), 0.0), _500), _522), vec4(_464.z)) * vec4(0.03125, 0.03125, 0.03125, 3.0517578125e-05);
        vec4 _561;
        if (isinf(_553.x) || isnan(_553.x))
        {
            vec4 _560 = _553;
            _560.x = 0.0;
            _561 = _560;
        }
        else
        {
            _561 = _553;
        }
        vec4 _569;
        if (isinf(_561.y) || isnan(_561.y))
        {
            vec4 _568 = _561;
            _568.y = 0.0;
            _569 = _568;
        }
        else
        {
            _569 = _561;
        }
        vec4 _577;
        if (isinf(_569.z) || isnan(_569.z))
        {
            vec4 _576 = _569;
            _576.z = 0.0;
            _577 = _576;
        }
        else
        {
            _577 = _569;
        }
        vec4 _585;
        if (isinf(_577.w) || isnan(_577.w))
        {
            vec4 _584 = _577;
            _584.w = 0.0;
            _585 = _584;
        }
        else
        {
            _585 = _577;
        }
        vec4 _588 = _585;
        _588.w = 1.0 - _585.w;
        _589 = _588;
        break;
    } while(false);
    if (_242 > 0.1500000059604644775390625)
    {
        imageStore(_23, ivec2(uvec2(gl_FragCoord.xy)), vec4(_9));
    }
    _10 = spvNMax(vec4(fma(mix(mix(_378, _25._m0, vec3(_25._m15)), (pow(spvNMax(abs(_355), vec3(9.9999997473787516355514526367188e-05)), vec3(_25._m16)) + vec3(_25._m17)) * _378, vec3(_25._m18)) * float(!(_11._m1 != 0.0)), _589.www, _589.xyz), _242), vec4(0.0));
}

