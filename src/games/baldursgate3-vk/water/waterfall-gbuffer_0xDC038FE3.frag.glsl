#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_spirv_intrinsics : require

vec4 _128;
float _129;

layout(set = 0, binding = 0, std140) uniform _21_15
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _15;

layout(set = 0, binding = 2, std140) uniform _22_16
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _16;

layout(set = 1, binding = 0, std140) uniform _23_18
{
    uint _m0;
    uint _m1;
    uint _m2;
    uint _m3;
} _18;

layout(set = 1, binding = 1, std140) uniform _24_19
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    vec2 _m6;
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
} _19;

layout(set = 0, binding = 7) uniform sampler _17;
layout(set = 1, binding = 2) uniform texture2D _20;

layout(location = 0) in vec3 _3;
layout(location = 1) in vec3 _4;
layout(location = 2) in vec4 _5;
layout(location = 3) in vec2 _6;
layout(location = 4) in vec3 _7;
layout(location = 5) in vec4 _8;
layout(location = 6) in vec4 _9;
layout(location = 7) in vec4 _10;
layout(location = 0) out vec4 _11;
layout(location = 1) out vec4 _12;
layout(location = 2) out vec4 _13;
layout(location = 3) out vec4 _14;

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
    float _148 = 1.0 - _6.y;
    float _149 = _148 * _148;
    vec2 _153 = (_19._m6 * (_15._m0 * 3.0)) + vec2(_5.z * _149);
    vec2 _155 = fma(_6, vec2(1.0, 0.75), _153 * vec2(0.0, 0.067500002682209014892578125));
    vec2 _164 = fma(_6, vec2(0.5, 2.0), _153 * vec2(0.0, 0.1500000059604644775390625));
    vec4 _174 = vec4(_5.x);
    vec4 _181 = vec4(_5.y);
    float _187 = _15._m0 * _19._m1;
    vec3 _199 = vec3((_6 + (vec2(0.0, 0.5) * _187)) * vec2(_19._m3, _19._m3 * _19._m5), _187);
    vec3 _203 = floor(_199 + vec3(dot(_199, vec3(0.3333333432674407958984375))));
    vec3 _207 = (_199 - _203) + vec3(dot(_203, vec3(0.16666667163372039794921875)));
    vec3 _209 = step(_207.yzx, _207);
    vec3 _211 = (vec3(1.0) - _209).zxy;
    vec3 _212 = spvNMin(_209, _211);
    vec3 _213 = spvNMax(_209, _211);
    vec3 _215 = (_207 - _212) + vec3(0.16666667163372039794921875);
    vec3 _217 = (_207 - _213) + vec3(0.3333333432674407958984375);
    vec3 _218 = _207 - vec3(0.5);
    vec3 _222 = _203 - (floor(_203 * vec3(0.00346020772121846675872802734375)) * 289.0);
    vec4 _228 = vec4(_222.z) + vec4(0.0, _212.z, _213.z, 1.0);
    vec4 _230 = (_228 * 34.0) + vec4(1.0);
    vec4 _243 = (fma(_230, _228, -(floor((_230 * _228) * vec4(0.00346020772121846675872802734375)) * 289.0)) + vec4(_222.y)) + vec4(0.0, _212.y, _213.y, 1.0);
    vec4 _245 = (_243 * 34.0) + vec4(1.0);
    vec4 _258 = (fma(_245, _243, -(floor((_245 * _243) * vec4(0.00346020772121846675872802734375)) * 289.0)) + vec4(_222.x)) + vec4(0.0, _212.x, _213.x, 1.0);
    vec4 _260 = (_258 * 34.0) + vec4(1.0);
    vec4 _266 = fma(_260, _258, -(floor((_260 * _258) * vec4(0.00346020772121846675872802734375)) * 289.0));
    vec4 _270 = _266 - (floor(_266 * vec4(0.02040816284716129302978515625)) * 49.0);
    vec4 _272 = floor(_270 * vec4(0.14285714924335479736328125));
    vec4 _278 = fma((_272 * 2.0) + vec4(0.5), vec4(0.14285714924335479736328125), vec4(-1.0));
    vec4 _281 = fma((floor(_270 - (_272 * 7.0)) * 2.0) + vec4(0.5), vec4(0.14285714924335479736328125), vec4(-1.0));
    vec4 _285 = (vec4(1.0) - abs(_278)) - abs(_281);
    vec4 _290 = vec4(_278.xy, _281.xy);
    vec4 _295 = vec4(_278.zw, _281.zw);
    vec4 _303 = -step(_285, vec4(0.0));
    vec4 _307 = fma(((floor(_290) * 2.0) + vec4(1.0)).xzyw, _303.xxyy, _290.xzyw);
    vec4 _311 = fma(((floor(_295) * 2.0) + vec4(1.0)).xzyw, _303.zzww, _295.xzyw);
    vec3 _315 = vec3(_307.xy, _285.x);
    vec3 _319 = vec3(_307.zw, _285.y);
    vec3 _323 = vec3(_311.xy, _285.z);
    vec3 _327 = vec3(_311.zw, _285.w);
    vec4 _334 = vec4(1.792842864990234375) - (vec4(dot(_315, _315), dot(_319, _319), dot(_323, _323), dot(_327, _327)) * 0.8537347316741943359375);
    vec3 _336 = _315 * _334.x;
    vec3 _338 = _319 * _334.y;
    vec3 _340 = _323 * _334.z;
    vec3 _342 = _327 * _334.w;
    vec4 _349 = spvNMax(vec4(0.60000002384185791015625) - vec4(dot(_207, _207), dot(_215, _215), dot(_217, _217), dot(_218, _218)), vec4(0.0));
    vec4 _350 = _349 * _349;
    vec4 _351 = _350 * _349;
    vec4 _352 = _350 * _350;
    float _395 = spvNMax(_5.z, fma(((((((((((_207 * ((-6.0) * _351.x)) * dot(_207, _336)) + (_336 * _352.x)) - ((_215 * (6.0 * _351.y)) * dot(_215, _338))) + (_338 * _352.y)) - ((_217 * (6.0 * _351.z)) * dot(_217, _340))) + (_340 * _352.z)) - ((_218 * (6.0 * _351.w)) * dot(_218, _342))) + (_342 * _352.w)) * 42.0).x, _19._m7, _19._m8));
    vec3 _401 = _4 + (normalize(_7) * (fma(_395, _5.y, (vec4(1.0) - ((abs(fract(_174 + vec4(_129, spvNMax((texture(sampler2D(_20, _17), _155).xyz - vec3(0.5)) * 0.449999988079071044921875, (texture(sampler2D(_20, _17), _164).xyz - vec3(0.5)) * 0.449999988079071044921875).y, _5.z, 1.0)) - vec4(0.5)) * 3.0) / _181)).y) * _19._m9));
    vec3 _425 = normalize(mix(normalize(_3), normalize(cross(dFdx(_401), dFdy(_401))), vec3(_19._m10)) * mat3(_8.xyz, _9.xyz, _10.xyz)) * mat3(_16._m0[0].xyz, _16._m0[1].xyz, _16._m0[2].xyz);
    vec4 _456 = vec4(1.0) - ((abs(fract(_174 + vec4(spvNMax((texture(sampler2D(_20, _17), _155).xyz - vec3(0.5)) * 0.449999988079071044921875, (texture(sampler2D(_20, _17), _164).xyz - vec3(0.5)) * 0.449999988079071044921875).xy, _5.z, 1.0)) - vec4(0.5)) * 3.0) / _181);
    vec4 _461 = pow(spvNMax(abs(spvNMax(_456, vec4(0.0))), vec4(9.9999997473787516355514526367188e-05)), vec4(1.5, 3.0, 0.0, 0.0)) + vec4(0.00999999977648258209228515625);
    vec2 _499 = (((_425.xy / vec2(1.0 - _425.z)) * vec2(0.562524616718292236328125)) * 0.5) + vec2(0.5);
    vec3 _501 = clamp(mix(_19._m2, _19._m4, vec3(fma(_5.y, _19._m15 * _395, spvNMax((clamp(fma(-_19._m11, _149, 1.0) * _19._m12, 0.0, 1.0) * _461.x) * _19._m13, _461.y * _19._m14) + clamp((_456.w * _5.y) * 0.100000001490116119384765625, 0.0, 1.0)))), vec3(0.0), vec3(1.0));
    vec4 _502 = vec4(_501.x, _501.y, _501.z, _128.w);
    _502.w = 1.0;
    _11 = vec4(_499.x, _499.y, vec4(0.0).z, vec4(0.0).w);
    _12 = _502;
    _13 = vec4(0.5, 0.5, 0.0, float((4u | ((_18._m0 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _14 = vec4(float(_18._m1) * 0.0039215688593685626983642578125, 0.0, 0.0, 0.0);
}

