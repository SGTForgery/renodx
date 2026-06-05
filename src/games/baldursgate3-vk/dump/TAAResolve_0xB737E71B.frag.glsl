#version 450
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
#extension GL_EXT_spirv_intrinsics : require
#extension GL_EXT_samplerless_texture_functions : require

float _100;
vec4 _101;

layout(set = 0, binding = 3, std140) uniform _17_7
{
    float _m0;
    float _m1;
    float _m2;
    float _m3;
} _7;

layout(set = 0, binding = 4, std140) uniform _18_8
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
} _8;

layout(set = 1, binding = 7, std140) uniform _19_16
{
    uint _m0;
    uint _m1;
    vec2 _m2;
    vec2 _m3;
    vec2 _m4;
    vec2 _m5;
    vec2 _m6;
} _16;

layout(set = 1, binding = 0) uniform sampler _9;
layout(set = 1, binding = 1) uniform texture2D _10;
layout(set = 1, binding = 2) uniform texture2D _11;
layout(set = 1, binding = 3) uniform texture2D _12;
layout(set = 1, binding = 4) uniform texture2D _13;
layout(set = 1, binding = 5) uniform texture2D _14;
layout(set = 1, binding = 6) uniform texture2D _15;

layout(location = 0) in vec2 _4;
layout(location = 0) out vec3 _5;
layout(location = 1) out float _6;

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
    vec3 _741;
    float _742;
    do
    {
        vec4 _110 = textureLod(sampler2D(_11, _9), _4, 0.0);
        float _111 = _110.x;
        if (_111 == 0.0)
        {
            _741 = vec3(0.0);
            _742 = 0.0;
            break;
        }
        vec4 _124 = vec4(textureLod(sampler2D(_10, _9), _4, 0.0).xyz * abs(_111), _111);
        vec2 _129 = vec2(_7._m2, _7._m3);
        vec2 _135 = clamp(fma(_129, vec2(-1.0), _4), _8._m9, _8._m10);
        vec4 _137 = textureLod(sampler2D(_11, _9), _135, 0.0);
        float _138 = _137.x;
        vec2 _145 = clamp(fma(_129, vec2(0.0, -1.0), _4), _8._m9, _8._m10);
        vec4 _147 = textureLod(sampler2D(_11, _9), _145, 0.0);
        float _148 = _147.x;
        vec2 _155 = clamp(fma(_129, vec2(1.0, -1.0), _4), _8._m9, _8._m10);
        vec4 _157 = textureLod(sampler2D(_11, _9), _155, 0.0);
        float _158 = _157.x;
        vec2 _165 = clamp(fma(_129, vec2(-1.0, 0.0), _4), _8._m9, _8._m10);
        vec4 _167 = textureLod(sampler2D(_11, _9), _165, 0.0);
        float _168 = _167.x;
        vec2 _175 = clamp(fma(_129, vec2(1.0, 0.0), _4), _8._m9, _8._m10);
        vec4 _177 = textureLod(sampler2D(_11, _9), _175, 0.0);
        float _178 = _177.x;
        vec2 _185 = clamp(fma(_129, vec2(-1.0, 1.0), _4), _8._m9, _8._m10);
        vec4 _187 = textureLod(sampler2D(_11, _9), _185, 0.0);
        float _188 = _187.x;
        vec2 _195 = clamp(fma(_129, vec2(0.0, 1.0), _4), _8._m9, _8._m10);
        vec4 _197 = textureLod(sampler2D(_11, _9), _195, 0.0);
        float _198 = _197.x;
        vec2 _205 = clamp(_4 + _129, _8._m9, _8._m10);
        vec4 _207 = textureLod(sampler2D(_11, _9), _205, 0.0);
        float _208 = _207.x;
        int _215 = int(sign(_111));
        if (_215 < 0)
        {
            if ((((((((uint(_138 < 0.0) + uint(_148 < 0.0)) + uint(_158 < 0.0)) + uint(_168 < 0.0)) + uint(_178 < 0.0)) + uint(_188 < 0.0)) + uint(_198 < 0.0)) + uint(_208 < 0.0)) < _16._m1)
            {
                _741 = vec3(0.0);
                _742 = 0.0;
                break;
            }
        }
        SPIRV_CROSS_BRANCH
        if (_16._m0 == 1u)
        {
            _741 = _124.xyz;
            _742 = _111;
            break;
        }
        vec3 _253 = _124.xyz;
        float _254 = dot(_253, vec3(1.0, 2.0, 1.0));
        float _255 = dot(_253, vec3(2.0, 0.0, -2.0));
        float _256 = dot(_253, vec3(-1.0, 2.0, -1.0));
        vec4 _257 = vec4(_254, _255, _256, _111);
        vec3 _262 = (textureLod(sampler2D(_10, _9), _135, 0.0).xyz * abs(_138)).xyz;
        vec4 _267 = mix(vec4(dot(_262, vec3(1.0, 2.0, 1.0)), dot(_262, vec3(2.0, 0.0, -2.0)), dot(_262, vec3(-1.0, 2.0, -1.0)), _138), _257, bvec4(_215 != int(sign(_138))));
        vec3 _272 = (textureLod(sampler2D(_10, _9), _145, 0.0).xyz * abs(_148)).xyz;
        vec4 _277 = mix(vec4(dot(_272, vec3(1.0, 2.0, 1.0)), dot(_272, vec3(2.0, 0.0, -2.0)), dot(_272, vec3(-1.0, 2.0, -1.0)), _148), _257, bvec4(_215 != int(sign(_148))));
        vec3 _282 = (textureLod(sampler2D(_10, _9), _155, 0.0).xyz * abs(_158)).xyz;
        vec4 _287 = mix(vec4(dot(_282, vec3(1.0, 2.0, 1.0)), dot(_282, vec3(2.0, 0.0, -2.0)), dot(_282, vec3(-1.0, 2.0, -1.0)), _158), _257, bvec4(_215 != int(sign(_158))));
        vec3 _292 = (textureLod(sampler2D(_10, _9), _165, 0.0).xyz * abs(_168)).xyz;
        vec4 _297 = mix(vec4(dot(_292, vec3(1.0, 2.0, 1.0)), dot(_292, vec3(2.0, 0.0, -2.0)), dot(_292, vec3(-1.0, 2.0, -1.0)), _168), _257, bvec4(_215 != int(sign(_168))));
        vec3 _302 = (textureLod(sampler2D(_10, _9), _175, 0.0).xyz * abs(_178)).xyz;
        vec4 _307 = mix(vec4(dot(_302, vec3(1.0, 2.0, 1.0)), dot(_302, vec3(2.0, 0.0, -2.0)), dot(_302, vec3(-1.0, 2.0, -1.0)), _178), _257, bvec4(_215 != int(sign(_178))));
        vec3 _312 = (textureLod(sampler2D(_10, _9), _185, 0.0).xyz * abs(_188)).xyz;
        vec4 _317 = mix(vec4(dot(_312, vec3(1.0, 2.0, 1.0)), dot(_312, vec3(2.0, 0.0, -2.0)), dot(_312, vec3(-1.0, 2.0, -1.0)), _188), _257, bvec4(_215 != int(sign(_188))));
        vec3 _322 = (textureLod(sampler2D(_10, _9), _195, 0.0).xyz * abs(_198)).xyz;
        vec4 _327 = mix(vec4(dot(_322, vec3(1.0, 2.0, 1.0)), dot(_322, vec3(2.0, 0.0, -2.0)), dot(_322, vec3(-1.0, 2.0, -1.0)), _198), _257, bvec4(_215 != int(sign(_198))));
        vec3 _332 = (textureLod(sampler2D(_10, _9), _205, 0.0).xyz * abs(_208)).xyz;
        vec4 _337 = mix(vec4(dot(_332, vec3(1.0, 2.0, 1.0)), dot(_332, vec3(2.0, 0.0, -2.0)), dot(_332, vec3(-1.0, 2.0, -1.0)), _208), _257, bvec4(_215 != int(sign(_208))));
        vec4 _341 = spvNMin(spvNMin(spvNMin(_277, _297), spvNMin(_257, _307)), _327);
        vec4 _345 = spvNMax(spvNMax(spvNMax(_277, _297), spvNMax(_257, _307)), _327);
        vec4 _355 = (spvNMin(_341, spvNMin(spvNMin(_267, _287), spvNMin(_317, _337))) + _341) * 0.5;
        vec4 _357 = (spvNMax(_345, spvNMax(spvNMax(_267, _287), spvNMax(_317, _337))) + _345) * 0.5;
        ivec2 _361 = ivec2(gl_FragCoord.xy);
        ivec2 _365 = ivec2(_8._m3);
        ivec2 _368 = ivec2(_8._m4);
        vec4 _374 = texelFetch(_15, ivec3(clamp(_361 + ivec2(-1), _365, _368), 0).xy, 0);
        float _375 = _374.x;
        vec4 _382 = texelFetch(_15, ivec3(clamp(_361 + ivec2(1, -1), _365, _368), 0).xy, 0);
        float _383 = _382.x;
        vec4 _389 = texelFetch(_15, ivec3(clamp(_361, _365, _368), 0).xy, 0);
        float _390 = _389.x;
        vec4 _397 = texelFetch(_15, ivec3(clamp(_361 + ivec2(-1, 1), _365, _368), 0).xy, 0);
        float _398 = _397.x;
        vec4 _405 = texelFetch(_15, ivec3(clamp(_361 + ivec2(1), _365, _368), 0).xy, 0);
        float _406 = _405.x;
        vec4 _413 = texelFetch(_15, ivec3(clamp(_361 + ivec2(0, -1), _365, _368), 0).xy, 0);
        float _414 = _413.x;
        vec4 _421 = texelFetch(_15, ivec3(clamp(_361 + ivec2(-1, 0), _365, _368), 0).xy, 0);
        float _422 = _421.x;
        vec4 _429 = texelFetch(_15, ivec3(clamp(_361 + ivec2(1, 0), _365, _368), 0).xy, 0);
        float _430 = _429.x;
        bool _439 = _383 < _375;
        float _442 = _439 ? _383 : _375;
        bool _443 = _390 < _442;
        float _446 = _443 ? _390 : _442;
        bool _447 = _398 < _446;
        float _450 = _447 ? _398 : _446;
        bool _451 = _406 < _450;
        float _454 = _451 ? _406 : _450;
        bool _455 = _414 < _454;
        float _458 = _455 ? _414 : _454;
        bool _459 = _422 < _458;
        float _462 = _459 ? _422 : _458;
        bool _463 = _430 < _462;
        vec2 _490 = fma((fma(-texelFetch(_14, ivec3(clamp(_361 + mix(mix(mix(mix(mix(mix(mix(mix(ivec2(-1), ivec2(1, -1), bvec2(_439)), ivec2(0), bvec2(_443)), ivec2(-1, 1), bvec2(_447)), ivec2(1), bvec2(_451)), ivec2(0, -1), bvec2(_455)), ivec2(-1, 0), bvec2(_459)), ivec2(1, 0), bvec2(_463)), ivec2(0, 1), bvec2(texelFetch(_15, ivec3(clamp(_361 + ivec2(0, 1), _365, _368), 0).xy, 0).x < (_463 ? _430 : _462))), _365, _368), 0).xy, 0).xy, _129, _4) - _8._m1) / _8._m0, _16._m5, _16._m6);
        if (!(all(greaterThanEqual(_490, _16._m3)) && all(lessThanEqual(_490, _16._m4))))
        {
            float _506 = -_256;
            _741 = vec4(fma(_506, 0.25, fma(_254, 0.25, _255 * 0.25)), fma(_254, 0.25, _256 * 0.25), fma(_506, 0.25, fma(_254, 0.25, _255 * (-0.25))), _100).xyz;
            _742 = _111;
            break;
        }
        vec2 _519 = vec2(_7._m0, _7._m1).xy;
        vec2 _521 = floor(fma(_519, _490, vec2(-0.5)));
        vec2 _522 = _521 + vec2(0.5);
        vec2 _524 = fma(_519, _490, vec2(-0.5) - _521);
        vec2 _525 = _129.xy;
        vec2 _527 = clamp(_525 * _522, _16._m3, _16._m4);
        vec4 _530 = textureLod(sampler2D(_13, _9), _527, 0.0);
        float _531 = _530.x;
        vec4 _532;
        _532.w = _531;
        vec4 _535 = textureLod(sampler2D(_12, _9), _527, 0.0);
        vec2 _539 = clamp(fma(_525, _522, _525 * vec2(1.0, 0.0)), _16._m3, _16._m4);
        vec4 _541 = textureLod(sampler2D(_13, _9), _539, 0.0);
        float _542 = _541.x;
        vec4 _543;
        _543.w = _542;
        vec4 _545 = textureLod(sampler2D(_12, _9), _539, 0.0);
        vec2 _549 = clamp(fma(_525, _522, _525 * vec2(0.0, 1.0)), _16._m3, _16._m4);
        vec4 _551 = textureLod(sampler2D(_13, _9), _549, 0.0);
        float _552 = _551.x;
        vec4 _553;
        _553.w = _552;
        vec4 _555 = textureLod(sampler2D(_12, _9), _549, 0.0);
        vec2 _558 = clamp(fma(_525, _522, _525), _16._m3, _16._m4);
        vec4 _560 = textureLod(sampler2D(_13, _9), _558, 0.0);
        float _561 = _560.x;
        vec4 _562;
        _562.w = _561;
        vec4 _564 = textureLod(sampler2D(_12, _9), _558, 0.0);
        float _577;
        vec4 _578;
        if (int(sign(_531)) == _215)
        {
            float _575 = (1.0 - _524.x) * (1.0 - _524.y);
            _577 = _575;
            _578 = vec4(_535.x, _535.y, _535.z, _532.w) * _575;
        }
        else
        {
            _577 = 0.0;
            _578 = vec4(0.0);
        }
        float _591;
        vec4 _592;
        if (int(sign(_542)) == _215)
        {
            float _584 = _524.x;
            float _586 = 1.0 - _524.y;
            _591 = fma(_584, _586, _577);
            _592 = _578 + (vec4(_545.x, _545.y, _545.z, _543.w) * (_584 * _586));
        }
        else
        {
            _591 = _577;
            _592 = _578;
        }
        float _605;
        vec4 _606;
        if (int(sign(_552)) == _215)
        {
            float _599 = 1.0 - _524.x;
            float _600 = _524.y;
            _605 = fma(_599, _600, _591);
            _606 = _592 + (vec4(_555.x, _555.y, _555.z, _553.w) * (_599 * _600));
        }
        else
        {
            _605 = _591;
            _606 = _592;
        }
        vec4 _618;
        float _619;
        if (int(sign(_561)) == _215)
        {
            float _612 = _524.x;
            float _613 = _524.y;
            _618 = _606 + (vec4(_564.x, _564.y, _564.z, _562.w) * (_612 * _613));
            _619 = fma(_612, _613, _605);
        }
        else
        {
            _618 = _606;
            _619 = _605;
        }
        vec4 _623 = _618 * ((_619 > 0.0) ? (1.0 / _619) : 0.0);
        vec3 _624 = _623.xyz;
        float _625 = dot(_624, vec3(1.0, 2.0, 1.0));
        float _628 = _623.w;
        vec4 _629 = vec4(_625, dot(_624, vec3(2.0, 0.0, -2.0)), dot(_624, vec3(-1.0, 2.0, -1.0)), _628);
        vec3 _630 = _629.xyz;
        vec3 _631 = _257.xyz;
        vec3 _632 = _355.xyz;
        vec3 _633 = _357.xyz;
        vec3 _637 = spvNMax(_631, spvNMax(_632, _633));
        vec3 _640 = (_637 + spvNMin(_631, spvNMin(_632, _633))) * 0.5;
        vec3 _641 = _630 - _640;
        vec3 _642 = _637 - _640;
        vec3 _643 = vec3(1.0) / (_631 - _630);
        vec3 _645 = (_642 - _641) * _643;
        vec3 _648 = ((-_642) - _641) * _643;
        float _661 = _355.w;
        float _662 = _357.w;
        float _666 = spvNMax(_111, spvNMax(_661, _662));
        float _669 = -(_666 + spvNMin(_111, spvNMin(_661, _662)));
        vec3 _674 = vec3(fma(_669, 0.5, _628));
        vec3 _675 = vec3(fma(_669, 0.5, _666) + 0.0500000007450580596923828125);
        vec3 _676 = vec3(1.0) / vec3(_111 - _628);
        vec3 _678 = (_675 - _674) * _676;
        vec3 _681 = ((-_675) - _674) * _676;
        vec4 _696 = mix(_629, _257, vec4(spvNMax(clamp(spvNMax(spvNMax(spvNMin(_645.x, _648.x), spvNMin(_645.y, _648.y)), spvNMin(_645.z, _648.z)), 0.0, 1.0), clamp(spvNMax(spvNMax(spvNMin(_678.x, _681.x), spvNMin(_678.y, _681.y)), spvNMin(_678.z, _681.z)), 0.0, 1.0))));
        float _702 = spvNMax(0.039999999105930328369140625, clamp((0.00999999977648258209228515625 * _625) / abs(_254 - _625), 0.0, 1.0));
        float _707 = 1.0 / (_696.x + 4.0);
        float _708 = 1.0 - _702;
        float _710 = _702 * (1.0 / (_254 + 4.0));
        float _712 = 1.0 / fma(_708, _707, _710);
        vec4 _717 = (_696 * ((_708 * _707) * _712)) + (_257 * (_710 * _712));
        float _718 = _717.x;
        float _719 = _717.y;
        float _721 = _717.z;
        float _724 = -_721;
        float _730 = _717.w;
        _741 = (-spvNMin(-vec4(fma(_724, 0.25, fma(_718, 0.25, _719 * 0.25)), fma(_718, 0.25, _721 * 0.25), fma(_724, 0.25, fma(_718, 0.25, _719 * (-0.25))), _730).xyz, vec3(0.0))).xyz;
        _742 = (isnan(_730) || isinf(_730)) ? 0.0 : _730;
        break;
    } while(false);
    _5 = _741;
    _6 = _742;
}

