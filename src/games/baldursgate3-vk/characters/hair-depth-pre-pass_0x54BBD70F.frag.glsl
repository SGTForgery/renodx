#version 450
#extension GL_EXT_spirv_intrinsics : require
layout(depth_less) out float gl_FragDepth;

layout(set = 0, binding = 0, std140) uniform _18_12
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    int _m6;
    float _m7;
} _12;

layout(set = 0, binding = 2, std140) uniform _19_13
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

layout(set = 1, binding = 1, std140) uniform _20_15
{
    float _m0;
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
} _15;

layout(set = 0, binding = 7) uniform sampler _14;
layout(set = 1, binding = 3) uniform texture2D _16;
layout(set = 1, binding = 4) uniform texture2D _17;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _5;
layout(location = 2) in vec3 _6;
layout(location = 3) in vec3 _7;
layout(location = 4) in vec3 _8;
layout(location = 5) in vec4 _9;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec4 _77 = gl_FragCoord;
    float _79 = 1.0 / _77.w;
    vec2 _88 = _3 * _15._m2;
    vec4 _92 = texture(sampler2D(_16, _14), _88);
    vec4 _102 = texture(sampler2D(_17, _14), _3 + vec2(fma(_92.x, 2.0, -1.0) * _15._m3));
    vec4 _103 = _102 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _108 = texture(sampler2D(_17, _14), _3);
    vec4 _109 = _108 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _117 = fma(spvNMax(vec4(ivec4(sign(_103))), vec4(ivec4(sign(_109)))), spvNMax(abs(_103), abs(_109)), vec4(0.5, 0.0, 0.0, 0.0));
    float _129 = clamp(_15._m7, 0.0, 1.0);
    float _138 = spvNMax((1.0 - _117.y) * mix(_15._m4 * 0.00999999977648258209228515625, _15._m5 * 0.00999999977648258209228515625, smoothstep(fma(-_129, 0.5, _15._m6), fma(_129, 0.5, _15._m6), _117.z)), 0.0);
    vec4 _166;
    if (_13._m1[3u].w != 1.0)
    {
        vec4 _156 = _77;
        _156.z = fma(_77.z, _79, _138 * (_13._m3 / (_13._m3 - _13._m4))) / (_79 + _138);
        _166 = _156;
    }
    else
    {
        vec4 _165 = _77;
        _165.z = _77.z + (_138 / (_13._m3 - _13._m4));
        _166 = _165;
    }
    vec3 _169 = _5 * fma(float(gl_FrontFacing), 2.0, -1.0);
    mat3 _170 = mat3(_7, _169, _6);
    vec4 _181 = texture(sampler2D(_16, _14), _88);
    vec4 _188 = texture(sampler2D(_17, _14), _3 + vec2(fma(_181.x, 2.0, -1.0) * _15._m3));
    vec4 _189 = _188 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _194 = texture(sampler2D(_17, _14), _3);
    vec4 _195 = _194 - vec4(0.5, 0.0, 0.0, 0.0);
    vec4 _203 = fma(spvNMax(vec4(ivec4(sign(_189))), vec4(ivec4(sign(_195)))), spvNMax(abs(_189), abs(_195)), vec4(0.5, 0.0, 0.0, 0.0));
    float _217 = (_203.w * fma(-_203.z, _15._m8, 1.0)) * clamp(abs(dot(normalize(_170 * normalize(normalize(-(_8 + ((-normalize(_8)) * _138))) * _170)), normalize(_169))) * 5.0, 0.0, 1.0);
    float _248;
    if (_12._m3 != 0.0)
    {
        // Interleaved Gradient Noise + R2 temporal sequence
        // Replaces original low-quality 4-phase hash with pixel-frequency
        // noise and infinite temporal phases for cleaner TAA convergence.
        float _ign = fract(52.9829189 * fract(0.06711056 * _166.x + 0.00583715 * _166.y));
        float _temporalNoise = fract(_ign + 0.7548776662466927 * _12._m2 + _9.x);
        _248 = fma(_217, _15._m9, _temporalNoise - 0.66670000553131103515625);
    }
    else
    {
        _248 = step(0.33329999446868896484375, _217 * _15._m9);
    }
    if ((_248 - 0.33329999446868896484375) < 0.0)
    {
        discard;
    }
    gl_FragDepth = _166.z;
}

