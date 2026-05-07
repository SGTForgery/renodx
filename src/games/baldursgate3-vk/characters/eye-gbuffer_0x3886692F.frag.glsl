#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_spirv_intrinsics : require

vec4 _115;

layout(set = 0, binding = 2, std140) uniform _22_13
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

layout(set = 1, binding = 0, std140) uniform _23_15
{
    layout(row_major) mat4 _m0;
    uint _m1;
    uint _m2;
    uint _m3;
    uint _m4;
} _15;

layout(set = 1, binding = 1, std140) uniform _24_16
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
    vec3 _m12;
    float _m13;
    vec3 _m14;
    float _m15;
    float _m16;
    float _m17;
    float _m18;
    float _m19;
} _16;

layout(set = 0, binding = 7) uniform sampler _14;
layout(set = 1, binding = 2) uniform texture2D _17;
layout(set = 1, binding = 3) uniform texture2D _18;
layout(set = 1, binding = 4) uniform texture2D _19;
layout(set = 1, binding = 5) uniform texture2D _20;
layout(set = 1, binding = 6) uniform texture2D _21;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _4;
layout(location = 2) in vec3 _5;
layout(location = 3) in vec3 _6;
layout(location = 4) in vec3 _7;
layout(location = 5) in vec4 _8;
layout(location = 0) out vec4 _9;
layout(location = 1) out vec4 _10;
layout(location = 2) out vec4 _11;
layout(location = 3) out vec4 _12;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    mat3 _123 = mat3(_6, _4, _5);
    vec3 _127 = normalize(normalize(-_7) * _123);
    vec2 _136 = vec2(_127.x, -_127.z);
    vec2 _139 = _3 + (_136 * fma(texture(sampler2D(_17, _14), _3).w, -0.04500000178813934326171875, -0.04500000178813934326171875));
    vec4 _142 = texture(sampler2D(_18, _14), _139);
    vec3 _145 = (_142.wzy * 2.0) - vec3(1.0);
    vec4 _146 = vec4(_145.x, _145.y, _145.z, _142.x);
    _146.z = -_145.z;
    float _162 = mix(_16._m1, _16._m3, _8.x);
    vec4 _168 = texture(sampler2D(_20, _14), _139);
    vec3 _171 = (_168.wzy * 2.0) - vec3(1.0);
    vec4 _172 = vec4(_171.x, _171.y, _171.z, _168.x);
    _172.z = -_171.z;
    vec3 _195 = normalize(_123 * normalize(fma(normalize(_172.xyz).xyz, vec3(1.0, 0.0, 1.0) * _16._m5, mix(normalize(_146.xyz).xyz, vec3(0.0, 1.0, 0.0), vec3(texture(sampler2D(_19, _14), _139).y * _162))))) * mat3(_13._m0[0].xyz, _13._m0[1].xyz, _13._m0[2].xyz);
    float _198 = _8.x * _16._m7;
    vec3 _203 = vec3(_198);
    float _218 = (1.0 - _8.x) * _16._m13;
    float _219 = mix(mix(_16._m9, _16._m11, _198), 2.0, _218);
    vec2 _225 = _3 + (_136 * fma(texture(sampler2D(_17, _14), _3).w, -0.04500000178813934326171875, -0.04500000178813934326171875));
    vec4 _228 = texture(sampler2D(_21, _14), _225);
    vec4 _238 = texture(sampler2D(_19, _14), _225);
    float _239 = _238.y;
    vec3 _245 = vec3(clamp(mix(_219 * _228.w, (texture(sampler2D(_19, _14), _225).x * _239) * (_239 * _219), _162), 0.0, 1.0));
    vec3 _251 = vec3(_218);
    vec3 _284 = vec3(clamp(pow(spvNMax(abs(_228.x), 9.9999997473787516355514526367188e-05), mix(mix(_16._m17, _16._m18, _198), 1.5, _218)), 0.0, 1.0));
    vec4 _289 = texture(sampler2D(_17, _14), _225);
    float _292 = _289.y * _289.z;
    vec2 _315 = _3 + (_136 * fma(texture(sampler2D(_17, _14), _3).w, -0.04500000178813934326171875, -0.04500000178813934326171875));
    vec4 _317 = texture(sampler2D(_17, _14), _315);
    vec2 _336 = (((_195.xy / vec2(1.0 - _195.z)) * vec2(0.562524616718292236328125)) * 0.5) + vec2(0.5);
    vec3 _338 = clamp(mix((mix(mix(mix(mix(_16._m0, _16._m2, _203), mix(_16._m4, _16._m6, _203), _245), mix(vec3(0.4375183880329132080078125, 0.4974044859409332275390625, 0.5221993923187255859375), vec3(0.2610599100589752197265625, 0.3551261126995086669921875, 0.3715083897113800048828125), _245), vec3(_162)), mix(vec3(0.25084018707275390625, 0.598941802978515625, 0.827725827693939208984375), vec3(0.932276785373687744140625, 0.5542271137237548828125, 0.18354900181293487548828125), _245), _251) * mix(_228.y, 1.0, _162)) * fma(-_228.z, mix(mix(_16._m15, _16._m16, _198), 0.5, _218), 1.0), mix(mix(mix(_16._m8, _16._m10, _203), mix(_16._m12, _16._m14, _203), _284), mix(vec3(0.35865390300750732421875, 0.0414518900215625762939453125, 0.0342301987111568450927734375), vec3(0.4045408070087432861328125, 0.470440208911895751953125, 0.3111805021762847900390625), _284), _251) * _292, vec3(mix(_292, 1.0 - _239, _162))), vec3(0.0), vec3(1.0));
    // RDX: Limbal darkening at iris-sclera boundary (rendering.hlsl §2.1d)
    // _8.x = iris mask [0=sclera, 1=iris]. x*(1-x)*4 peaks at the transition zone.
    _338 *= 1.0 - 0.25 * _8.x * (1.0 - _8.x) * 4.0;
    vec4 _339 = vec4(_338.x, _338.y, _338.z, _115.w);
    _339.w = pow(spvNMax(abs(texture(sampler2D(_17, _14), _3 + (_136 * fma(texture(sampler2D(_17, _14), _3).w, -0.04500000178813934326171875, -0.04500000178813934326171875))).x), 9.9999997473787516355514526367188e-05), 2.0);
    _9 = vec4(_336.x, _336.y, vec4(0.0).z, vec4(0.0).w);
    _10 = _339;
    _11 = vec4(clamp(mix(0.89999997615814208984375, 0.0, mix(_317.y * _317.z, 1.0 - texture(sampler2D(_19, _14), _315).y, _162)), 0.0, 1.0), 0.5, 0.0, float((0u | ((_15._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _12 = vec4(0.0);
}

