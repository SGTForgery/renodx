#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_spirv_intrinsics : require

vec4 _100;

layout(set = 0, binding = 2, std140) uniform _23_14
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _14;

layout(set = 1, binding = 0, std140) uniform _24_16
{
    uint _m0;
    uint _m1;
    uint _m2;
    uint _m3;
} _16;

layout(set = 1, binding = 1, std140) uniform _25_17
{
    vec3 _m0;
    float _m1;
    vec3 _m2;
    float _m3;
    vec3 _m4;
    float _m5;
    vec3 _m6;
    float _m7;
    vec3 _m8;
    float _m9;
    vec3 _m10;
    float _m11;
    float _m12;
    float _m13;
    float _m14;
    float _m15;
} _17;

layout(set = 0, binding = 7) uniform sampler _15;
layout(set = 1, binding = 3) uniform texture2D _18;
layout(set = 1, binding = 4) uniform texture2D _19;
layout(set = 1, binding = 5) uniform texture2D _20;
layout(set = 1, binding = 6) uniform texture2D _21;
layout(set = 1, binding = 7) uniform texture2D _22;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _4;
layout(location = 2) in vec3 _5;
layout(location = 3) in vec3 _6;
layout(location = 4) in vec3 _7;
layout(location = 5) in vec3 _8;
layout(location = 0) out vec4 _10;
layout(location = 1) out vec4 _11;
layout(location = 2) out vec4 _12;
layout(location = 3) out vec4 _13;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec4 _112 = texture(sampler2D(_18, _15), _3);
    vec3 _115 = (_112.wzy * 2.0) - vec3(1.0);
    vec4 _116 = vec4(_115.x, _115.y, _115.z, _112.x);
    _116.z = -_115.z;
    float _124 = fma(float(gl_FrontFacing), 2.0, -1.0);
    vec3 _138 = normalize(mat3(_6, _4 * _124, _5) * normalize(_116.xyz).xyz) * mat3(_14._m0[0].xyz, _14._m0[1].xyz, _14._m0[2].xyz);
    vec3 _140 = normalize(_7 * _124);
    vec4 _147 = texture(sampler2D(_20, _15), _3);
    vec3 _171 = vec3(1.0, -1.0, 1.0) * (_8 * 2.7999999523162841796875);
    vec2 _172 = _171.zy;
    vec3 _180 = pow(spvNMax(abs(abs((vec3(0.0, 0.5, 1.0) * ((texture(sampler2D(_21, _15), _3).z + (-0.5)) * 0.60000002384185791015625)) + _140)), vec3(9.9999997473787516355514526367188e-05)), vec3(160.0));
    vec3 _184 = step(vec3(0.5), _180 / vec3(dot(_180, vec3(1.0))));
    vec2 _187 = _171.xy;
    vec2 _191 = _171.xz;
    vec4 _196 = texture(sampler2D(_21, _15), ((_172 * _184.x) + (_187 * _184.z)) + (_191 * _184.y));
    vec2 _203 = vec2(_17._m3, _17._m5);
    vec4 _208 = texture(sampler2D(_18, _15), _3);
    vec3 _211 = (_208.wzy * 2.0) - vec3(1.0);
    vec4 _212 = vec4(_211.x, _211.y, _211.z, _208.x);
    _212.z = -_211.z;
    vec2 _225 = abs(vec2(0.75));
    vec2 _228 = vec2(1.0) - pow(spvNMax(_225, vec2(9.9999997473787516355514526367188e-05)), vec2(_17._m7, _17._m9));
    vec2 _241 = vec2(_17._m11, _17._m12);
    vec2 _243 = pow(spvNMax(abs(_196.yx), vec2(9.9999997473787516355514526367188e-05)), _203) * step((vec2(1.0) - clamp(vec2(clamp(normalize(_212.xyz).z, 0.0, 1.0)) + _228, vec2(0.0), vec2(1.0))) + vec2(spvNMax(9.9999997473787516355514526367188e-06, _196.z - 0.699999988079071044921875)), _241);
    vec3 _268 = pow(spvNMax(abs(abs((vec3(0.0, 0.5, 1.0) * ((texture(sampler2D(_21, _15), _3).z + (-0.5)) * 0.60000002384185791015625)) + _140)), vec3(9.9999997473787516355514526367188e-05)), vec3(160.0));
    vec3 _272 = step(vec3(0.5), _268 / vec3(dot(_268, vec3(1.0))));
    vec4 _282 = texture(sampler2D(_21, _15), ((_172 * _272.x) + (_187 * _272.z)) + (_191 * _272.y));
    vec4 _289 = texture(sampler2D(_18, _15), _3);
    vec3 _292 = (_289.wzy * 2.0) - vec3(1.0);
    vec4 _293 = vec4(_292.x, _292.y, _292.z, _289.x);
    _293.z = -_292.z;
    vec2 _310 = pow(spvNMax(abs(_282.yx), vec2(9.9999997473787516355514526367188e-05)), _203) * step((vec2(1.0) - clamp(vec2(clamp(normalize(_293.xyz).z, 0.0, 1.0)) + _228, vec2(0.0), vec2(1.0))) + vec2(spvNMax(9.9999997473787516355514526367188e-06, _282.z - 0.699999988079071044921875)), _241);
    // RenoDX: guard the stereographic normal encoding (xy / (1 - z)).
    // With BG3's top-down camera, flat floors face the camera almost exactly (z -> 1),
    // which gives Inf/NaN in the normal buffer; a zero-length normal map sample gives NaN.
    // Those pixels end up as NaN in lighting, get blown up by the bloom mips and show as
    // black squares. Keep the normal finite and just shy of the pole instead.
    vec3 rdx_n = _138;
    if (any(isnan(rdx_n)) || any(isinf(rdx_n))) {
        rdx_n = normalize(_140 * mat3(_14._m0[0].xyz, _14._m0[1].xyz, _14._m0[2].xyz));
        if (any(isnan(rdx_n)) || any(isinf(rdx_n))) rdx_n = vec3(0.0, 0.0, 1.0);
    }
    if (rdx_n.z > 0.999) {
        float rdx_l = length(rdx_n.xy);
        vec2 rdx_dir = (rdx_l > 1.0e-6) ? (rdx_n.xy / rdx_l) : vec2(1.0, 0.0);
        rdx_n = vec3(rdx_dir * sqrt(1.0 - 0.999 * 0.999), 0.999);
    }
    vec2 _337 = (((rdx_n.xy / vec2(1.0 - rdx_n.z)) * vec2(0.562524616718292236328125)) * 0.5) + vec2(0.5);
    vec3 _339 = clamp(mix(mix(texture(sampler2D(_19, _15), _3).xyz * mix(mix(mix(_17._m0, _17._m2, vec3(_147.x)), _17._m4, vec3(_147.y)), _17._m6, vec3(_147.z)), _17._m8, vec3(_243.x)), _17._m10, vec3(_243.y)), vec3(0.0), vec3(1.0));
    vec4 _340 = vec4(_339.x, _339.y, _339.z, _100.w);
    _340.w = 1.0;
    _10 = vec4(_337.x, _337.y, vec4(0.0).z, vec4(0.0).w);
    _11 = _340;
    _12 = vec4(clamp((_310.x + texture(sampler2D(_22, _15), _3).y) - _310.y, 0.0, 1.0), 0.5, clamp(texture(sampler2D(_22, _15), _3).x, 0.0, 1.0), float((4u | ((_16._m0 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _13 = vec4(float(_16._m1) * 0.0039215688593685626983642578125, 0.0, clamp(1.0 - texture(sampler2D(_22, _15), _3).z, 0.0, 1.0), 0.0);
}
