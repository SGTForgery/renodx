#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_spirv_intrinsics : require
#extension GL_EXT_samplerless_texture_functions : require

struct _24
{
    mat4 _m0[2];
};

vec4 _102;

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

layout(set = 0, binding = 12, std430) readonly buffer _26_14
{
    layout(row_major) _24 _m0[];
} _14;

layout(set = 1, binding = 0, std140) uniform _28_15
{
    vec4 _m0[2];
    uint _m1;
    uint _m2;
    uint _m3;
    uint _m4;
} _15;

layout(set = 1, binding = 1, std140) uniform _29_16
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
    float _m4;
    float _m5;
    float _m6;
    float _m7;
} _16;

layout(set = 1, binding = 2) uniform sampler _17;
layout(set = 1, binding = 3) uniform texture2D _18;
layout(set = 1, binding = 4) uniform texture2DArray _19;
layout(set = 1, binding = 5) uniform texture2DArray _20;
layout(set = 1, binding = 6) uniform texture2DArray _21;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _4;
layout(location = 2) in vec3 _5;
layout(location = 3) in vec3 _6;
layout(location = 0) out vec4 _8;
layout(location = 1) out vec4 _9;
layout(location = 2) out vec4 _10;
layout(location = 3) out vec4 _11;
layout(location = 4) out vec4 _12;

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
    vec2 _126 = _15._m0[0].zw * dFdx(_3);
    vec2 _128 = _15._m0[0].zw * dFdy(_3);
    vec2 _131 = fma(fract(_3), _15._m0[0].zw, _15._m0[0].xy);
    vec2 _134 = vec2(_14._m0[_15._m1]._m0[0][2].x, _14._m0[_15._m1]._m0[0][3].x);
    vec2 _135 = _126 * _134;
    vec2 _136 = _128 * _134;
    float _137 = dot(_135, _135);
    float _138 = dot(_136, _136);
    float _141 = log2(spvNMax(_137, _138));
    float _154 = floor(spvNMin(spvNMax(fma(0.5, _141, -spvNMin(fma(0.5, _141, log2(spvNMin(_137, _138)) * (-0.5)), _14._m0[_15._m1]._m0[0][1].x)) - 0.5, 0.0), _15._m0[1].x) + 0.5);
    float _160 = abs(0.5);
    float _161 = spvNMax(_160, 9.9999997473787516355514526367188e-05);
    vec2 _164 = floor((_131 * vec2(_14._m0[_15._m1]._m0[0][0].w, _14._m0[_15._m1]._m0[0][0].w * _14._m0[_15._m1]._m0[0][1].w)) * pow(_161, _154));
    int _165 = int(_154);
    uint _174 = floatBitsToUint(texelFetch(_18, ivec3(int(_164.x), int(_164.y), _165).xy, _165).y);
    float _183 = abs(2.0);
    float _184 = spvNMax(_183, 9.9999997473787516355514526367188e-05);
    float _185 = pow(_184, float(_174 & 15u));
    vec2 _187 = vec2(_185, _185 * _14._m0[_15._m1]._m0[0][1].w);
    vec2 _192 = vec2(_14._m0[_15._m1]._m0[0][0].z, _14._m0[_15._m1]._m0[0][1].z);
    vec2 _199 = vec2(_14._m0[_15._m1]._m0[1][0].y, _14._m0[_15._m1]._m0[1][1].y);
    vec2 _211 = ((_187 * _192) * _199) * _14._m0[_15._m1]._m0[0][0].y;
    vec4 _219 = mix(textureGrad(sampler2DArray(_19, _17), vec3(fma(fma(fract(_131 * _187), _192, vec2(float((_174 >> 14u) & 1023u), float((_174 >> 4u) & 1023u))), _199, vec2(_14._m0[_15._m1]._m0[1][2].y, _14._m0[_15._m1]._m0[1][3].y)), float((_174 >> 24u) & 127u)), _126 * _211, _128 * _211), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_14._m0[_15._m1]._m0[0][2].w != 2202.0));
    vec3 _222 = (_219.wzy * 2.0) - vec3(1.0);
    vec4 _223 = vec4(_222.x, _222.y, _222.z, _219.x);
    _223.z = -_222.z;
    vec3 _245 = normalize(mat3(_6, _4 * fma(float(gl_FrontFacing), 2.0, -1.0), _5) * normalize(_223.xyz).xyz) * mat3(_13._m0[0].xyz, _13._m0[1].xyz, _13._m0[2].xyz);
    vec2 _252 = _15._m0[0].zw * dFdx(_3);
    vec2 _254 = _15._m0[0].zw * dFdy(_3);
    vec2 _257 = vec2(_14._m0[_15._m1]._m0[0][2].x, _14._m0[_15._m1]._m0[0][3].x);
    vec2 _258 = _252 * _257;
    vec2 _259 = _254 * _257;
    float _260 = dot(_258, _258);
    float _261 = dot(_259, _259);
    float _264 = log2(spvNMax(_260, _261));
    float _276 = floor(spvNMin(spvNMax(fma(0.5, _264, -spvNMin(fma(0.5, _264, log2(spvNMin(_260, _261)) * (-0.5)), _14._m0[_15._m1]._m0[0][1].x)) - 0.5, 0.0), _15._m0[1].x) + 0.5);
    vec2 _284 = floor((_131 * vec2(_14._m0[_15._m1]._m0[0][0].w, _14._m0[_15._m1]._m0[0][0].w * _14._m0[_15._m1]._m0[0][1].w)) * pow(_161, _276));
    int _285 = int(_276);
    uint _294 = floatBitsToUint(texelFetch(_18, ivec3(int(_284.x), int(_284.y), _285).xy, _285).x);
    float _303 = pow(_184, float(_294 & 15u));
    vec2 _305 = vec2(_303, _303 * _14._m0[_15._m1]._m0[0][1].w);
    vec2 _310 = vec2(_14._m0[_15._m1]._m0[0][0].z, _14._m0[_15._m1]._m0[0][1].z);
    vec2 _317 = vec2(_14._m0[_15._m1]._m0[1][0].x, _14._m0[_15._m1]._m0[1][1].x);
    vec2 _329 = ((_305 * _310) * _317) * _14._m0[_15._m1]._m0[0][0].y;
    vec2 _345 = _15._m0[0].zw * dFdx(_3);
    vec2 _347 = _15._m0[0].zw * dFdy(_3);
    vec2 _350 = vec2(_14._m0[_15._m1]._m0[0][2].x, _14._m0[_15._m1]._m0[0][3].x);
    vec2 _351 = _345 * _350;
    vec2 _352 = _347 * _350;
    float _353 = dot(_351, _351);
    float _354 = dot(_352, _352);
    float _357 = log2(spvNMax(_353, _354));
    float _369 = floor(spvNMin(spvNMax(fma(0.5, _357, -spvNMin(fma(0.5, _357, log2(spvNMin(_353, _354)) * (-0.5)), _14._m0[_15._m1]._m0[0][1].x)) - 0.5, 0.0), _15._m0[1].x) + 0.5);
    vec2 _377 = floor((_131 * vec2(_14._m0[_15._m1]._m0[0][0].w, _14._m0[_15._m1]._m0[0][0].w * _14._m0[_15._m1]._m0[0][1].w)) * pow(_161, _369));
    int _378 = int(_369);
    uint _387 = floatBitsToUint(texelFetch(_18, ivec3(int(_377.x), int(_377.y), _378).xy, _378).z);
    float _396 = pow(_184, float(_387 & 15u));
    vec2 _398 = vec2(_396, _396 * _14._m0[_15._m1]._m0[0][1].w);
    vec2 _403 = vec2(_14._m0[_15._m1]._m0[0][0].z, _14._m0[_15._m1]._m0[0][1].z);
    vec2 _410 = vec2(_14._m0[_15._m1]._m0[1][0].z, _14._m0[_15._m1]._m0[1][1].z);
    vec2 _422 = ((_398 * _403) * _410) * _14._m0[_15._m1]._m0[0][0].y;
    vec2 _439 = _15._m0[0].zw * dFdx(_3);
    vec2 _441 = _15._m0[0].zw * dFdy(_3);
    vec2 _444 = vec2(_14._m0[_15._m1]._m0[0][2].x, _14._m0[_15._m1]._m0[0][3].x);
    vec2 _445 = _439 * _444;
    vec2 _446 = _441 * _444;
    float _447 = dot(_445, _445);
    float _448 = dot(_446, _446);
    float _451 = log2(spvNMax(_447, _448));
    float _463 = floor(spvNMin(spvNMax(fma(0.5, _451, -spvNMin(fma(0.5, _451, log2(spvNMin(_447, _448)) * (-0.5)), _14._m0[_15._m1]._m0[0][1].x)) - 0.5, 0.0), _15._m0[1].x) + 0.5);
    vec2 _471 = floor((_131 * vec2(_14._m0[_15._m1]._m0[0][0].w, _14._m0[_15._m1]._m0[0][0].w * _14._m0[_15._m1]._m0[0][1].w)) * pow(_161, _463));
    int _472 = int(_463);
    uint _481 = floatBitsToUint(texelFetch(_18, ivec3(int(_471.x), int(_471.y), _472).xy, _472).z);
    float _490 = pow(_184, float(_481 & 15u));
    vec2 _492 = vec2(_490, _490 * _14._m0[_15._m1]._m0[0][1].w);
    vec2 _497 = vec2(_14._m0[_15._m1]._m0[0][0].z, _14._m0[_15._m1]._m0[0][1].z);
    vec2 _504 = vec2(_14._m0[_15._m1]._m0[1][0].z, _14._m0[_15._m1]._m0[1][1].z);
    vec2 _516 = ((_492 * _497) * _504) * _14._m0[_15._m1]._m0[0][0].y;
    vec2 _531 = _15._m0[0].zw * dFdx(_3);
    vec2 _533 = _15._m0[0].zw * dFdy(_3);
    vec2 _536 = vec2(_14._m0[_15._m1]._m0[0][2].x, _14._m0[_15._m1]._m0[0][3].x);
    vec2 _537 = _531 * _536;
    vec2 _538 = _533 * _536;
    float _539 = dot(_537, _537);
    float _540 = dot(_538, _538);
    float _543 = log2(spvNMax(_539, _540));
    float _555 = floor(spvNMin(spvNMax(fma(0.5, _543, -spvNMin(fma(0.5, _543, log2(spvNMin(_539, _540)) * (-0.5)), _14._m0[_15._m1]._m0[0][1].x)) - 0.5, 0.0), _15._m0[1].x) + 0.5);
    vec2 _563 = floor((_131 * vec2(_14._m0[_15._m1]._m0[0][0].w, _14._m0[_15._m1]._m0[0][0].w * _14._m0[_15._m1]._m0[0][1].w)) * pow(_161, _555));
    int _564 = int(_555);
    uint _573 = floatBitsToUint(texelFetch(_18, ivec3(int(_563.x), int(_563.y), _564).xy, _564).z);
    float _582 = pow(_184, float(_573 & 15u));
    vec2 _584 = vec2(_582, _582 * _14._m0[_15._m1]._m0[0][1].w);
    vec2 _589 = vec2(_14._m0[_15._m1]._m0[0][0].z, _14._m0[_15._m1]._m0[0][1].z);
    vec2 _596 = vec2(_14._m0[_15._m1]._m0[1][0].z, _14._m0[_15._m1]._m0[1][1].z);
    vec2 _608 = ((_584 * _589) * _596) * _14._m0[_15._m1]._m0[0][0].y;
    vec2 _623 = _15._m0[0].zw * dFdx(_3);
    vec2 _625 = _15._m0[0].zw * dFdy(_3);
    vec2 _628 = vec2(_14._m0[_15._m1]._m0[0][2].x, _14._m0[_15._m1]._m0[0][3].x);
    vec2 _629 = _623 * _628;
    vec2 _630 = _625 * _628;
    float _631 = dot(_629, _629);
    float _632 = dot(_630, _630);
    float _635 = log2(spvNMax(_631, _632));
    float _647 = floor(spvNMin(spvNMax(fma(0.5, _635, -spvNMin(fma(0.5, _635, log2(spvNMin(_631, _632)) * (-0.5)), _14._m0[_15._m1]._m0[0][1].x)) - 0.5, 0.0), _15._m0[1].x) + 0.5);
    vec2 _655 = floor((_131 * vec2(_14._m0[_15._m1]._m0[0][0].w, _14._m0[_15._m1]._m0[0][0].w * _14._m0[_15._m1]._m0[0][1].w)) * pow(_161, _647));
    float _657 = _655.x;
    float _661 = _655.y;
    int _673 = int(_647);
    uint _680 = floatBitsToUint(texelFetch(_18, ivec3(int(_657), int(_661), _673).xy, _673).z);
    float _689 = pow(_184, float(_680 & 15u));
    vec2 _691 = vec2(_689, _689 * _14._m0[_15._m1]._m0[0][1].w);
    vec2 _696 = vec2(_14._m0[_15._m1]._m0[0][0].z, _14._m0[_15._m1]._m0[0][1].z);
    vec2 _703 = vec2(_14._m0[_15._m1]._m0[1][0].z, _14._m0[_15._m1]._m0[1][1].z);
    vec2 _715 = ((_691 * _696) * _703) * _14._m0[_15._m1]._m0[0][0].y;
    // RenoDX: guard the stereographic normal encoding (xy / (1 - z)).
    // With BG3's top-down camera, flat floors face the camera almost exactly (z -> 1),
    // which gives Inf/NaN in the normal buffer; a zero-length normal map sample gives NaN.
    // Those pixels end up as NaN in lighting, get blown up by the bloom mips and show as
    // black squares. Keep the normal finite and just shy of the pole instead.
    vec3 rdx_n = _245;
    if (any(isnan(rdx_n)) || any(isinf(rdx_n))) {
        rdx_n = normalize(_5) * mat3(_13._m0[0].xyz, _13._m0[1].xyz, _13._m0[2].xyz);
        if (any(isnan(rdx_n)) || any(isinf(rdx_n))) rdx_n = vec3(0.0, 0.0, 1.0);
    }
    if (rdx_n.z > 0.999) {
        float rdx_l = length(rdx_n.xy);
        vec2 rdx_dir = (rdx_l > 1.0e-6) ? (rdx_n.xy / rdx_l) : vec2(1.0, 0.0);
        rdx_n = vec3(rdx_dir * sqrt(1.0 - 0.999 * 0.999), 0.999);
    }
    vec2 _740 = (((rdx_n.xy / vec2(1.0 - rdx_n.z)) * vec2(0.562524616718292236328125)) * 0.5) + vec2(0.5);
    vec3 _742 = clamp(mix(textureGrad(sampler2DArray(_20, _17), vec3(fma(fma(fract(_131 * _305), _310, vec2(float((_294 >> 14u) & 1023u), float((_294 >> 4u) & 1023u))), _317, vec2(_14._m0[_15._m1]._m0[1][2].x, _14._m0[_15._m1]._m0[1][3].x)), float((_294 >> 24u) & 127u)), _252 * _329, _254 * _329), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_14._m0[_15._m1]._m0[0][2].w != 2202.0)).xyz, vec3(0.0), vec3(1.0));
    vec4 _743 = vec4(_742.x, _742.y, _742.z, _102.w);
    _743.w = mix(textureGrad(sampler2DArray(_21, _17), vec3(fma(fma(fract(_131 * _492), _497, vec2(float((_481 >> 14u) & 1023u), float((_481 >> 4u) & 1023u))), _504, vec2(_14._m0[_15._m1]._m0[1][2].z, _14._m0[_15._m1]._m0[1][3].z)), float((_481 >> 24u) & 127u)), _439 * _516, _441 * _516), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_14._m0[_15._m1]._m0[0][2].w != 2202.0)).z;
    _8 = vec4(_740.x, _740.y, vec4(0.0).z, vec4(0.0).w);
    _9 = _743;
    _10 = vec4(clamp(mix(textureGrad(sampler2DArray(_21, _17), vec3(fma(fma(fract(_131 * _584), _589, vec2(float((_573 >> 14u) & 1023u), float((_573 >> 4u) & 1023u))), _596, vec2(_14._m0[_15._m1]._m0[1][2].z, _14._m0[_15._m1]._m0[1][3].z)), float((_573 >> 24u) & 127u)), _531 * _608, _533 * _608), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_14._m0[_15._m1]._m0[0][2].w != 2202.0)).y, 0.0, 1.0), clamp(_16._m5, 0.0, 1.0), clamp(mix(textureGrad(sampler2DArray(_21, _17), vec3(fma(fma(fract(_131 * _398), _403, vec2(float((_387 >> 14u) & 1023u), float((_387 >> 4u) & 1023u))), _410, vec2(_14._m0[_15._m1]._m0[1][2].z, _14._m0[_15._m1]._m0[1][3].z)), float((_387 >> 24u) & 127u)), _345 * _422, _347 * _422), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_14._m0[_15._m1]._m0[0][2].w != 2202.0)).x, 0.0, 1.0), float((4u | ((_15._m2 & 7u) << 4u)) | 0u) * 0.0039215688593685626983642578125);
    _11 = vec4(float(_15._m3) * 0.0039215688593685626983642578125, 0.0, clamp(mix(textureGrad(sampler2DArray(_21, _17), vec3(fma(fma(fract(_131 * _691), _696, vec2(float((_680 >> 14u) & 1023u), float((_680 >> 4u) & 1023u))), _703, vec2(_14._m0[_15._m1]._m0[1][2].z, _14._m0[_15._m1]._m0[1][3].z)), float((_680 >> 24u) & 127u)), _623 * _715, _625 * _715), vec4(1.0, 0.0, 0.0, 1.0), bvec4(_14._m0[_15._m1]._m0[0][2].w != 2202.0)).w, 0.0, 1.0), 0.0);
    _12 = vec4(_657 - 256.0 * trunc(_657 / 256.0), fma(_661 - 32.0 * trunc(_661 / 32.0), 8.0, floor(_657 * 0.00390625)), fma(_647 - 4.0 * trunc(_647 / 4.0), 64.0, floor(_661 * 0.03125)), fma(_14._m0[_15._m1]._m0[0][3].w, 4.0, floor(_647 * 0.25))) * 0.0039215688593685626983642578125;
}
