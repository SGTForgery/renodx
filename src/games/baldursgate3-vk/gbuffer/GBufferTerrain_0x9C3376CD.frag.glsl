#version 450
#extension GL_EXT_nonuniform_qualifier : require
#extension GL_EXT_spirv_intrinsics : require
#extension GL_EXT_samplerless_texture_functions : require
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

struct _24
{
    vec4 _m0;
    vec4 _m1;
    vec4 _m2;
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
    uint _m15;
    uint _m16;
    uint _m17;
    uint _m18;
};

vec4 _255;

layout(set = 0, binding = 2, std140) uniform _21_8
{
    layout(row_major) mat4 _m0;
    layout(row_major) mat4 _m1;
    layout(row_major) mat4 _m2;
    float _m3;
    float _m4;
    vec2 _m5;
    vec3 _m6;
    int _m7;
} _8;

layout(set = 4, binding = 0, std140) uniform _22_10
{
    vec4 _m0;
    vec4 _m1;
    vec4 _m2;
    vec2 _m3;
    vec2 _m4;
    uvec2 _m5;
    float _m6;
    float _m7;
} _10;

layout(set = 1, binding = 0, std140) uniform _23_13
{
    layout(row_major) mat4 _m0;
} _13;

layout(set = 1, binding = 4, std430) readonly buffer _26_17
{
    _24 _m0[];
} _17;

layout(set = 0, binding = 7) uniform sampler _9;
layout(set = 4, binding = 3) uniform texture2D _11;
layout(set = 4, binding = 4) uniform sampler _12;
layout(set = 1, binding = 1) uniform sampler _14;
layout(set = 1, binding = 2) uniform texture2DArray _15;
layout(set = 1, binding = 3) uniform texture2D _16;
layout(set = 1, binding = 5) uniform texture2D _18;
layout(set = 1, binding = 6) uniform texture2D _19;
layout(set = 2, binding = 32) uniform texture2D _20[];

layout(location = 0) in vec4 _3;
layout(location = 0) out vec4 _4;
layout(location = 1) out vec4 _5;
layout(location = 2) out vec4 _6;
layout(location = 3) out vec4 _7;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

layout(push_constant) uniform RenoDXPushConstants {
    float peak_white_nits;              // 0
    float diffuse_white_nits;           // 4
    float graphics_white_nits;          // 8
    float gamma_correction;             // 12
    float tone_map_exposure;            // 16
    float tone_map_highlights;          // 20
    float tone_map_shadows;             // 24
    float tone_map_contrast;            // 28
    float tone_map_saturation;          // 32
    float tone_map_highlight_saturation;// 36
    float tone_map_dechroma;            // 40
    float tone_map_flare;               // 44
    float color_grade_strength;         // 48
    float tone_map_hue_shift;           // 52
    float tone_map_blowout;             // 56
    float custom_curve;                 // 60
    float hue_correction;               // 64
    float custom_random;                // 68
    float custom_grain_strength;        // 72
    float custom_bloom;                 // 76
    float rendering_cubemap_mod;        // 84
    float rendering_ao_direct;          // 88
    float rendering_shadow_improvements; // 92
    float rendering_micro_shadows;       // 96
    float rendering_micro_shadows_debug; // 100
    float rendering_specular_occlusion;  // 104
    float rendering_probe_ao;           // 108
    float rendering_horizon_occlusion;  // 112
    float rendering_diffuse_brdf;       // 116
    float hero_lighting;                // 120
    float rendering_gbuffer_improvements; // 124
} pc;

void main()
{
    vec4 _275 = texture(sampler2D(_11, _14), (_3.xz + vec2(0.5)) * _10._m0.xy);
    vec3 _279 = normalize((_275.xyz * 2.0) - vec3(1.0));
    vec3 _288 = spvNMax(abs(_279) - vec3(0.5759999752044677734375), vec3(0.0));
    vec3 _295 = _288 / vec3((_288.x + _288.y) + _288.z);
    float _296 = _295.x;
    float _299 = _295.z;
    vec3 _328;
    if (spvNMax(spvNMax(_296, _295.y), _299) != 1.0)
    {
        vec3 _304 = _295;
        _304.y = 0.00999999977648258209228515625;
        vec3 _308 = _304 / vec3((_296 + 0.00999999977648258209228515625) + _299);
        float _313 = spvNMax(spvNMax(_308.x, _308.y), _308.z);
        vec3 _320 = clamp(_308 + mix(vec3(-_313), vec3(0.0), equal(_308, vec3(_313))), vec3(0.0), vec3(1.0));
        _328 = _320 / vec3((_320.x + _320.y) + _320.z);
    }
    else
    {
        _328 = _295;
    }
    vec3 _331 = mix(-_328, _328, greaterThanEqual(_279, vec3(0.0)));
    float _333 = _331.x;
    float _335 = _331.y;
    float _338 = _331.z;
    float _341 = -fma(_3.y, _10._m3.x, _10._m3.y);
    vec2 _349 = vec2(fma(_3.x, -_338, fma(_3.z, _333, _3.x * _335)), fma(_341, _328.z, fma(_341, _328.x, -(_3.z * _328.y))));
    float _351 = (_333 + _335) - _338;
    vec2 _352 = dFdx(_349);
    vec2 _353 = dFdy(_349);
    bool _354 = _328.x > 0.0;
    vec2 _356 = _3.xz * _10._m0.zw;
    vec2 _357 = _3.xz * 2.0;
    vec2 _361 = _357 + _10._m1.xy;
    ivec2 _367 = ivec3(int(_361.x), int(_361.y), 0).xy;
    uvec4 _380 = uvec4(mix(vec4(255.0), texelFetch(_18, _367, 0) * 255.0, bvec4(all(greaterThanEqual(_367, ivec2(0))) && all(lessThan(vec2(_367), _10._m1.zw)))));
    uint _381 = _380.x;
    vec4 _398;
    SPIRV_CROSS_BRANCH
    if (_381 < 64u)
    {
        vec4 _257 = textureLod(sampler2DArray(_15, _12), vec3(_356, float(_381 >> 2u)), 0.0);
        vec4 _397 = vec4(0.0);
        _397.x = _257[_381 & 3u];
        _398 = _397;
    }
    else
    {
        _398 = vec4(0.0);
    }
    uint _399 = _380.y;
    vec4 _416;
    SPIRV_CROSS_BRANCH
    if (_399 < 64u)
    {
        vec4 _258 = textureLod(sampler2DArray(_15, _12), vec3(_356, float(_399 >> 2u)), 0.0);
        vec4 _415 = _398;
        _415.y = _258[_399 & 3u];
        _416 = _415;
    }
    else
    {
        _416 = _398;
    }
    uint _417 = _380.z;
    vec4 _434;
    SPIRV_CROSS_BRANCH
    if (_417 < 64u)
    {
        vec4 _259 = textureLod(sampler2DArray(_15, _12), vec3(_356, float(_417 >> 2u)), 0.0);
        vec4 _433 = _416;
        _433.z = _259[_417 & 3u];
        _434 = _433;
    }
    else
    {
        _434 = _416;
    }
    uint _435 = _380.w;
    vec4 _452;
    SPIRV_CROSS_BRANCH
    if (_435 < 64u)
    {
        vec4 _260 = textureLod(sampler2DArray(_15, _12), vec3(_356, float(_435 >> 2u)), 0.0);
        vec4 _451 = _434;
        _451.w = _260[_435 & 3u];
        _452 = _451;
    }
    else
    {
        _452 = _434;
    }
    vec2 _456 = _357 + _10._m2.xy;
    ivec2 _462 = ivec3(int(_456.x), int(_456.y), 0).xy;
    uvec4 _475 = uvec4(mix(vec4(255.0), texelFetch(_19, _462, 0) * 255.0, bvec4(all(greaterThanEqual(_462, ivec2(0))) && all(lessThan(vec2(_462), _10._m2.zw)))));
    uint _476 = _475.x;
    vec4 _493;
    SPIRV_CROSS_BRANCH
    if (_476 < 64u)
    {
        vec4 _261 = textureLod(sampler2DArray(_15, _12), vec3(_356, float(_476 >> 2u)), 0.0);
        vec4 _492 = vec4(0.0);
        _492.x = _261[_476 & 3u];
        _493 = _492;
    }
    else
    {
        _493 = vec4(0.0);
    }
    uint _494 = _475.y;
    vec4 _511;
    SPIRV_CROSS_BRANCH
    if (_494 < 64u)
    {
        vec4 _262 = textureLod(sampler2DArray(_15, _12), vec3(_356, float(_494 >> 2u)), 0.0);
        vec4 _510 = _493;
        _510.y = _262[_494 & 3u];
        _511 = _510;
    }
    else
    {
        _511 = _493;
    }
    uint _512 = _475.z;
    vec4 _529;
    SPIRV_CROSS_BRANCH
    if (_512 < 64u)
    {
        vec4 _263 = textureLod(sampler2DArray(_15, _12), vec3(_356, float(_512 >> 2u)), 0.0);
        vec4 _528 = _511;
        _528.z = _263[_512 & 3u];
        _529 = _528;
    }
    else
    {
        _529 = _511;
    }
    uint _530 = _475.w;
    vec4 _547;
    SPIRV_CROSS_BRANCH
    if (_530 < 64u)
    {
        vec4 _264 = textureLod(sampler2DArray(_15, _12), vec3(_356, float(_530 >> 2u)), 0.0);
        vec4 _546 = _529;
        _546.w = _264[_530 & 3u];
        _547 = _546;
    }
    else
    {
        _547 = _529;
    }
    float _591;
    if (_452.x > 0.001000000047497451305389404296875)
    {
        float _564 = spvNMax(_17._m0[_381]._m7, 0.00999999977648258209228515625);
        uint _27 = uint(_17._m0[_381]._m0.x);
        vec4 _576 = mix(vec4(0.0, 0.0, 0.0, 0.5), textureGrad(nonuniformEXT(sampler2D(_20[_27], _9)), _349 * _564, _352 * _564, _353 * _564), bvec4(_17._m0[_381]._m0.x != (-1.0)));
        float _577 = _576.w;
        float _584 = (((_577 - 1.0) + _452.x) <= _17._m0[_381]._m6) ? 0.0 : (pow(abs(_577), _17._m0[_381]._m5) * _452.x);
        float _585 = _584 * _17._m0[_381]._m3;
        float _588 = (_585 > 0.00999999977648258209228515625) ? fma(_584, _17._m0[_381]._m3, _17._m0[_381]._m4) : _585;
        _591 = (_588 > 0.00999999977648258209228515625) ? _588 : (-1.0);
    }
    else
    {
        _591 = -1.0;
    }
    float _635;
    if (_452.y > 0.001000000047497451305389404296875)
    {
        float _608 = spvNMax(_17._m0[_399]._m7, 0.00999999977648258209228515625);
        uint _31 = uint(_17._m0[_399]._m0.x);
        vec4 _620 = mix(vec4(0.0, 0.0, 0.0, 0.5), textureGrad(nonuniformEXT(sampler2D(_20[_31], _9)), _349 * _608, _352 * _608, _353 * _608), bvec4(_17._m0[_399]._m0.x != (-1.0)));
        float _621 = _620.w;
        float _628 = (((_621 - 1.0) + _452.y) <= _17._m0[_399]._m6) ? 0.0 : (pow(abs(_621), _17._m0[_399]._m5) * _452.y);
        float _629 = _628 * _17._m0[_399]._m3;
        float _632 = (_629 > 0.00999999977648258209228515625) ? fma(_628, _17._m0[_399]._m3, _17._m0[_399]._m4) : _629;
        _635 = (_632 > 0.00999999977648258209228515625) ? _632 : (-1.0);
    }
    else
    {
        _635 = -1.0;
    }
    float _679;
    if (_452.z > 0.001000000047497451305389404296875)
    {
        float _652 = spvNMax(_17._m0[_417]._m7, 0.00999999977648258209228515625);
        uint _35 = uint(_17._m0[_417]._m0.x);
        vec4 _664 = mix(vec4(0.0, 0.0, 0.0, 0.5), textureGrad(nonuniformEXT(sampler2D(_20[_35], _9)), _349 * _652, _352 * _652, _353 * _652), bvec4(_17._m0[_417]._m0.x != (-1.0)));
        float _665 = _664.w;
        float _672 = (((_665 - 1.0) + _452.z) <= _17._m0[_417]._m6) ? 0.0 : (pow(abs(_665), _17._m0[_417]._m5) * _452.z);
        float _673 = _672 * _17._m0[_417]._m3;
        float _676 = (_673 > 0.00999999977648258209228515625) ? fma(_672, _17._m0[_417]._m3, _17._m0[_417]._m4) : _673;
        _679 = (_676 > 0.00999999977648258209228515625) ? _676 : (-1.0);
    }
    else
    {
        _679 = -1.0;
    }
    float _723;
    if (_452.w > 0.001000000047497451305389404296875)
    {
        float _696 = spvNMax(_17._m0[_435]._m7, 0.00999999977648258209228515625);
        uint _39 = uint(_17._m0[_435]._m0.x);
        vec4 _708 = mix(vec4(0.0, 0.0, 0.0, 0.5), textureGrad(nonuniformEXT(sampler2D(_20[_39], _9)), _349 * _696, _352 * _696, _353 * _696), bvec4(_17._m0[_435]._m0.x != (-1.0)));
        float _709 = _708.w;
        float _716 = (((_709 - 1.0) + _452.w) <= _17._m0[_435]._m6) ? 0.0 : (pow(abs(_709), _17._m0[_435]._m5) * _452.w);
        float _717 = _716 * _17._m0[_435]._m3;
        float _720 = (_717 > 0.00999999977648258209228515625) ? fma(_716, _17._m0[_435]._m3, _17._m0[_435]._m4) : _717;
        _723 = (_720 > 0.00999999977648258209228515625) ? _720 : (-1.0);
    }
    else
    {
        _723 = -1.0;
    }
    vec4 _724 = vec4(_591, _635, _679, _723);
    float _768;
    if (_547.x > 0.001000000047497451305389404296875)
    {
        float _741 = spvNMax(_17._m0[_476]._m7, 0.00999999977648258209228515625);
        uint _43 = uint(_17._m0[_476]._m0.x);
        vec4 _753 = mix(vec4(0.0, 0.0, 0.0, 0.5), textureGrad(nonuniformEXT(sampler2D(_20[_43], _9)), _349 * _741, _352 * _741, _353 * _741), bvec4(_17._m0[_476]._m0.x != (-1.0)));
        float _754 = _753.w;
        float _761 = (((_754 - 1.0) + _547.x) <= _17._m0[_476]._m6) ? 0.0 : (pow(abs(_754), _17._m0[_476]._m5) * _547.x);
        float _762 = _761 * _17._m0[_476]._m3;
        float _765 = (_762 > 0.00999999977648258209228515625) ? fma(_761, _17._m0[_476]._m3, _17._m0[_476]._m4) : _762;
        _768 = (_765 > 0.00999999977648258209228515625) ? _765 : (-1.0);
    }
    else
    {
        _768 = -1.0;
    }
    float _812;
    if (_547.y > 0.001000000047497451305389404296875)
    {
        float _785 = spvNMax(_17._m0[_494]._m7, 0.00999999977648258209228515625);
        uint _47 = uint(_17._m0[_494]._m0.x);
        vec4 _797 = mix(vec4(0.0, 0.0, 0.0, 0.5), textureGrad(nonuniformEXT(sampler2D(_20[_47], _9)), _349 * _785, _352 * _785, _353 * _785), bvec4(_17._m0[_494]._m0.x != (-1.0)));
        float _798 = _797.w;
        float _805 = (((_798 - 1.0) + _547.y) <= _17._m0[_494]._m6) ? 0.0 : (pow(abs(_798), _17._m0[_494]._m5) * _547.y);
        float _806 = _805 * _17._m0[_494]._m3;
        float _809 = (_806 > 0.00999999977648258209228515625) ? fma(_805, _17._m0[_494]._m3, _17._m0[_494]._m4) : _806;
        _812 = (_809 > 0.00999999977648258209228515625) ? _809 : (-1.0);
    }
    else
    {
        _812 = -1.0;
    }
    float _856;
    if (_547.z > 0.001000000047497451305389404296875)
    {
        float _829 = spvNMax(_17._m0[_512]._m7, 0.00999999977648258209228515625);
        uint _51 = uint(_17._m0[_512]._m0.x);
        vec4 _841 = mix(vec4(0.0, 0.0, 0.0, 0.5), textureGrad(nonuniformEXT(sampler2D(_20[_51], _9)), _349 * _829, _352 * _829, _353 * _829), bvec4(_17._m0[_512]._m0.x != (-1.0)));
        float _842 = _841.w;
        float _849 = (((_842 - 1.0) + _547.z) <= _17._m0[_512]._m6) ? 0.0 : (pow(abs(_842), _17._m0[_512]._m5) * _547.z);
        float _850 = _849 * _17._m0[_512]._m3;
        float _853 = (_850 > 0.00999999977648258209228515625) ? fma(_849, _17._m0[_512]._m3, _17._m0[_512]._m4) : _850;
        _856 = (_853 > 0.00999999977648258209228515625) ? _853 : (-1.0);
    }
    else
    {
        _856 = -1.0;
    }
    float _900;
    if (_547.w > 0.001000000047497451305389404296875)
    {
        float _873 = spvNMax(_17._m0[_530]._m7, 0.00999999977648258209228515625);
        uint _55 = uint(_17._m0[_530]._m0.x);
        vec4 _885 = mix(vec4(0.0, 0.0, 0.0, 0.5), textureGrad(nonuniformEXT(sampler2D(_20[_55], _9)), _349 * _873, _352 * _873, _353 * _873), bvec4(_17._m0[_530]._m0.x != (-1.0)));
        float _886 = _885.w;
        float _893 = (((_886 - 1.0) + _547.w) <= _17._m0[_530]._m6) ? 0.0 : (pow(abs(_886), _17._m0[_530]._m5) * _547.w);
        float _894 = _893 * _17._m0[_530]._m3;
        float _897 = (_894 > 0.00999999977648258209228515625) ? fma(_893, _17._m0[_530]._m3, _17._m0[_530]._m4) : _894;
        _900 = (_897 > 0.00999999977648258209228515625) ? _897 : (-1.0);
    }
    else
    {
        _900 = -1.0;
    }
    vec4 _901 = vec4(_768, _812, _856, _900);
    vec4 _902 = vec4(_380);
    vec4 _903 = vec4(_475);
    bvec2 _906 = greaterThan(_724.xz, _724.yw);
    bool _907 = _906.x;
    bool _909 = _906.y;
    bvec4 _911 = bvec4(_907, !_907, _909, !_909);
    vec4 _914 = mix(_724.xxzz, _724.yyww, _911);
    vec4 _917 = mix(_902.xxzz, _902.yyww, _911);
    bvec2 _920 = greaterThan(_914.xy, _914.zw);
    bool _921 = _920.x;
    bvec4 _925 = bvec4(_921, _920.y, !_921, !_920.y);
    vec4 _928 = mix(_914.xyxy, _914.zwzw, _925);
    vec4 _931 = mix(_917.xyxy, _917.zwzw, _925);
    bool _934 = _928.y > _928.z;
    bvec4 _936 = bvec4(false, _934, !_934, false);
    vec4 _939 = mix(_928.xyyw, _928.xzzw, _936);
    vec4 _942 = mix(_931.xyyw, _931.xzzw, _936);
    bvec2 _945 = greaterThan(_901.xz, _901.yw);
    bool _946 = _945.x;
    bool _948 = _945.y;
    bvec4 _950 = bvec4(_946, !_946, _948, !_948);
    vec4 _953 = mix(_901.xxzz, _901.yyww, _950);
    vec4 _956 = mix(_903.xxzz, _903.yyww, _950);
    bvec2 _959 = greaterThan(_953.xy, _953.zw);
    bool _960 = _959.x;
    bvec4 _964 = bvec4(_960, _959.y, !_960, !_959.y);
    vec4 _967 = mix(_953.xyxy, _953.zwzw, _964);
    vec4 _970 = mix(_956.xyxy, _956.zwzw, _964);
    bool _973 = _967.y > _967.z;
    bvec4 _975 = bvec4(false, _973, !_973, false);
    vec4 _985 = mix(_967.xyyw, _967.xzzw, _975).wzyx;
    vec4 _986 = mix(_970.xyyw, _970.xzzw, _975).wzyx;
    bvec4 _990 = greaterThanEqual(_939 * ((_942 * 0.001000000047497451305389404296875) + vec4(1.0)), _985 * ((_986 * 0.001000000047497451305389404296875) + vec4(1.0)));
    uvec4 _993 = uvec4(mix(_986, _942, _990));
    vec4 _1026 = spvNMax(mix(_985, _939, _990), vec4(0.0));
    bool _1029 = _10._m5.x >= 64u;
    vec3 _1040;
    if (_1029)
    {
        uvec2 _1034 = uvec2(_3.xz * 0.5) & uvec2(1u);
        _1040 = mix(vec3(0.20000000298023223876953125), vec3(0.100000001490116119384765625), bvec3(_1034.x == _1034.y));
    }
    else
    {
        _1040 = vec3(0.0);
    }
    float _1045 = _1026.x;
    float _1046 = _1026.y;
    float _1048 = _1026.z;
    float _1050 = _1026.w;
    float _1053 = clamp(1.0 - (((_1045 + _1046) + _1048) + _1050), 0.0, 1.0);
    float _1060 = spvNMax(_10._m6, 9.9999997473787516355514526367188e-06);
    vec4 _1067 = (spvNMax(vec4(0.0), (_1026 - vec4(spvNMax(spvNMax(spvNMax(spvNMax(_1045, _1046), _1048), _1050), _1053))) + vec4(_1060)) + vec4(9.9999999747524270787835121154785e-07)) * mix(mix(mix(mix(mix(mix(mix(mix(vec4(0.0), _452.xxxx, equal(_993, _380.xxxx)), _452.yyyy, equal(_993, _380.yyyy)), _452.zzzz, equal(_993, _380.zzzz)), _452.wwww, equal(_993, _380.wwww)), _547.xxxx, equal(_993, _475.xxxx)), _547.yyyy, equal(_993, _475.yyyy)), _547.zzzz, equal(_993, _475.zzzz)), _547.wwww, equal(_993, _475.wwww));
    vec4 _1077 = _1067 / vec4(fma(_1053, _1060, ((_1067.x + _1067.y) + _1067.z) + _1067.w));
    float _1078 = _1077.x;
    float _1080 = _1077.y;
    float _1082 = _1077.z;
    float _1084 = _1077.w;
    float _1086 = clamp((((1.0 - _1078) - _1080) - _1082) - _1084, 0.0, 1.0);

    // RenoDX: Laplacian-enhanced texture blend
    // Sharpen material weight distribution at blend transitions to create
    // crisper, more natural terrain material boundaries.
    // fwidth(_1077) detects the painted blend mask edges (slow-changing vs texture noise).
    if (pc.rendering_gbuffer_improvements > 0.5) {
        float rdx_grad = length(fwidth(_1077));
        float rdx_ts = smoothstep(0.05, 0.3, rdx_grad);
        float rdx_p = mix(1.0, 4.0, rdx_ts);
        float rdx_r1 = pow(_1078, rdx_p);
        float rdx_r2 = pow(_1080, rdx_p);
        float rdx_r3 = pow(_1082, rdx_p);
        float rdx_r4 = pow(_1084, rdx_p);
        float rdx_r5 = pow(_1086, rdx_p);
        float rdx_ws = rdx_r1 + rdx_r2 + rdx_r3 + rdx_r4 + rdx_r5;
        if (rdx_ws > 0.001) {
            _1078 = rdx_r1 / rdx_ws;
            _1080 = rdx_r2 / rdx_ws;
            _1082 = rdx_r3 / rdx_ws;
            _1084 = rdx_r4 / rdx_ws;
            _1086 = rdx_r5 / rdx_ws;
        }
    }

    vec3 _1087 = _1040 * _1086;
    vec3 _1088 = mix(vec3(0.0), vec3(0.0, 0.0, 1.0), bvec3(_1029)) * _1086;
    vec4 _1089 = mix(vec4(0.0), vec4(0.0, 1.0, 1.0, 0.0), bvec4(_1029)) * _1086;
    float _1091 = (_10._m5.x < 64u) ? _1086 : 0.0;
    uint _1092 = _993.x;
    vec4 _1235;
    float _1236;
    vec3 _1237;
    vec3 _1238;
    SPIRV_CROSS_BRANCH
    if (_1078 > 0.001000000047497451305389404296875)
    {
        float _1099 = spvNMax(_17._m0[_1092]._m7, 0.00999999977648258209228515625);
        uint _59 = uint(_17._m0[_1092]._m0.x);
        vec3 _1108 = textureGrad(nonuniformEXT(sampler2D(_20[_59], _9)), _349 * _1099, _352 * _1099, _353 * _1099).xyz;
        vec4 _1231;
        float _1232;
        vec3 _1233;
        vec3 _1234;
        do
        {
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1092]._m15 & 4u) != 0u)
            {
                _1231 = _1089;
                _1232 = _1078;
                _1233 = _1088;
                _1234 = _1087;
                break;
            }
            float _1136 = spvNMax(_17._m0[_1092]._m7, 0.00999999977648258209228515625);
            uint _63 = uint(_17._m0[_1092]._m0.z);
            vec2 _1140 = _349 * _1136;
            vec2 _1141 = _352 * _1136;
            vec2 _1142 = _353 * _1136;
            vec4 _1143 = textureGrad(nonuniformEXT(sampler2D(_20[_63], _9)), _1140, _1141, _1142);
            uint _67 = uint(_17._m0[_1092]._m0.y);
            vec3 _1151 = vec3(2.0 * _351, (-2.0) * _351, 2.0);
            vec3 _1153 = vec3(-_351, _351, -1.0);
            vec3 _1154 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_67], _9)), _1140, _1141, _1142).wyz, _1151, _1153);
            vec3 _1162;
            if (_354)
            {
                vec2 _1160 = vec2(-_1154.y, _1154.x);
                _1162 = vec3(_1160.x, _1160.y, _1154.z);
            }
            else
            {
                _1162 = _1154;
            }
            vec3 _1196;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1092]._m15 & 1u) != 0u)
            {
                float _1167 = spvNMax(_17._m0[_1092]._m8, 0.00999999977648258209228515625);
                uint _71 = uint(_17._m0[_1092]._m0.w);
                vec3 _1176 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_71], _9)), _349 * _1167, _352 * _1167, _353 * _1167).wyz, _1151, _1153);
                vec3 _1184;
                if (_354)
                {
                    vec2 _1182 = vec2(-_1176.y, _1176.x);
                    _1184 = vec3(_1182.x, _1182.y, _1176.z);
                }
                else
                {
                    _1184 = _1176;
                }
                float _1186 = _1162.z + 1.0;
                vec3 _1187 = _1162;
                _1187.z = _1186;
                vec2 _1190 = _1184.xy * (-_17._m0[_1092]._m9);
                vec3 _1191 = vec3(_1190.x, _1190.y, _1184.z);
                _1196 = (_1187 * dot(_1187, _1191)) - (_1191 * _1186);
            }
            else
            {
                _1196 = _1162;
            }
            vec4 _1222;
            vec3 _1223;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1092]._m15 & 2u) != 0u)
            {
                float _1203 = smoothstep(_17._m0[_1092]._m10, _17._m0[_1092]._m12, _3.w);
                vec3 _1211 = mix(mix(_17._m0[_1092]._m1.xyz, _17._m0[_1092]._m2.xyz, vec3(sqrt(smoothstep(0.0, _17._m0[_1092]._m11, _1203)))), vec3(1.0), vec3(sqrt(smoothstep(_17._m0[_1092]._m11, 1.0, _1203))));
                vec4 _1221 = _1143;
                _1221.y = _1143.y * clamp(pow(spvNMax(abs(_1211.x + _17._m0[_1092]._m13), 9.9999997473787516355514526367188e-05), _17._m0[_1092]._m14), 0.0, 1.0);
                _1222 = _1221;
                _1223 = _1108 * _1211;
            }
            else
            {
                _1222 = _1143;
                _1223 = _1108;
            }
            _1231 = _1089 + (_1222 * _1078);
            _1232 = 0.0;
            _1233 = _1088 + (normalize(_1196) * _1078);
            _1234 = _1087 + (_1223 * _1078);
            break;
        } while(false);
        _1235 = _1231;
        _1236 = _1232;
        _1237 = _1233;
        _1238 = _1234;
    }
    else
    {
        _1235 = _1089;
        _1236 = 0.0;
        _1237 = _1088;
        _1238 = _1087;
    }
    uint _1239 = _993.y;
    vec4 _1382;
    float _1383;
    vec3 _1384;
    vec3 _1385;
    SPIRV_CROSS_BRANCH
    if (_1080 > 0.001000000047497451305389404296875)
    {
        float _1245 = spvNMax(_17._m0[_1239]._m7, 0.00999999977648258209228515625);
        uint _75 = uint(_17._m0[_1239]._m0.x);
        vec3 _1254 = textureGrad(nonuniformEXT(sampler2D(_20[_75], _9)), _349 * _1245, _352 * _1245, _353 * _1245).xyz;
        vec4 _1378;
        float _1379;
        vec3 _1380;
        vec3 _1381;
        do
        {
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1239]._m15 & 4u) != 0u)
            {
                _1378 = _1235;
                _1379 = _1236 + _1080;
                _1380 = _1237;
                _1381 = _1238;
                break;
            }
            float _1283 = spvNMax(_17._m0[_1239]._m7, 0.00999999977648258209228515625);
            uint _79 = uint(_17._m0[_1239]._m0.z);
            vec2 _1287 = _349 * _1283;
            vec2 _1288 = _352 * _1283;
            vec2 _1289 = _353 * _1283;
            vec4 _1290 = textureGrad(nonuniformEXT(sampler2D(_20[_79], _9)), _1287, _1288, _1289);
            uint _83 = uint(_17._m0[_1239]._m0.y);
            vec3 _1298 = vec3(2.0 * _351, (-2.0) * _351, 2.0);
            vec3 _1300 = vec3(-_351, _351, -1.0);
            vec3 _1301 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_83], _9)), _1287, _1288, _1289).wyz, _1298, _1300);
            vec3 _1309;
            if (_354)
            {
                vec2 _1307 = vec2(-_1301.y, _1301.x);
                _1309 = vec3(_1307.x, _1307.y, _1301.z);
            }
            else
            {
                _1309 = _1301;
            }
            vec3 _1343;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1239]._m15 & 1u) != 0u)
            {
                float _1314 = spvNMax(_17._m0[_1239]._m8, 0.00999999977648258209228515625);
                uint _87 = uint(_17._m0[_1239]._m0.w);
                vec3 _1323 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_87], _9)), _349 * _1314, _352 * _1314, _353 * _1314).wyz, _1298, _1300);
                vec3 _1331;
                if (_354)
                {
                    vec2 _1329 = vec2(-_1323.y, _1323.x);
                    _1331 = vec3(_1329.x, _1329.y, _1323.z);
                }
                else
                {
                    _1331 = _1323;
                }
                float _1333 = _1309.z + 1.0;
                vec3 _1334 = _1309;
                _1334.z = _1333;
                vec2 _1337 = _1331.xy * (-_17._m0[_1239]._m9);
                vec3 _1338 = vec3(_1337.x, _1337.y, _1331.z);
                _1343 = (_1334 * dot(_1334, _1338)) - (_1338 * _1333);
            }
            else
            {
                _1343 = _1309;
            }
            vec4 _1369;
            vec3 _1370;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1239]._m15 & 2u) != 0u)
            {
                float _1350 = smoothstep(_17._m0[_1239]._m10, _17._m0[_1239]._m12, _3.w);
                vec3 _1358 = mix(mix(_17._m0[_1239]._m1.xyz, _17._m0[_1239]._m2.xyz, vec3(sqrt(smoothstep(0.0, _17._m0[_1239]._m11, _1350)))), vec3(1.0), vec3(sqrt(smoothstep(_17._m0[_1239]._m11, 1.0, _1350))));
                vec4 _1368 = _1290;
                _1368.y = _1290.y * clamp(pow(spvNMax(abs(_1358.x + _17._m0[_1239]._m13), 9.9999997473787516355514526367188e-05), _17._m0[_1239]._m14), 0.0, 1.0);
                _1369 = _1368;
                _1370 = _1254 * _1358;
            }
            else
            {
                _1369 = _1290;
                _1370 = _1254;
            }
            _1378 = _1235 + (_1369 * _1080);
            _1379 = _1236;
            _1380 = _1237 + (normalize(_1343) * _1080);
            _1381 = _1238 + (_1370 * _1080);
            break;
        } while(false);
        _1382 = _1378;
        _1383 = _1379;
        _1384 = _1380;
        _1385 = _1381;
    }
    else
    {
        _1382 = _1235;
        _1383 = _1236;
        _1384 = _1237;
        _1385 = _1238;
    }
    uint _1386 = _993.z;
    vec4 _1529;
    float _1530;
    vec3 _1531;
    vec3 _1532;
    SPIRV_CROSS_BRANCH
    if (_1082 > 0.001000000047497451305389404296875)
    {
        float _1392 = spvNMax(_17._m0[_1386]._m7, 0.00999999977648258209228515625);
        uint _91 = uint(_17._m0[_1386]._m0.x);
        vec3 _1401 = textureGrad(nonuniformEXT(sampler2D(_20[_91], _9)), _349 * _1392, _352 * _1392, _353 * _1392).xyz;
        vec4 _1525;
        float _1526;
        vec3 _1527;
        vec3 _1528;
        do
        {
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1386]._m15 & 4u) != 0u)
            {
                _1525 = _1382;
                _1526 = _1383 + _1082;
                _1527 = _1384;
                _1528 = _1385;
                break;
            }
            float _1430 = spvNMax(_17._m0[_1386]._m7, 0.00999999977648258209228515625);
            uint _95 = uint(_17._m0[_1386]._m0.z);
            vec2 _1434 = _349 * _1430;
            vec2 _1435 = _352 * _1430;
            vec2 _1436 = _353 * _1430;
            vec4 _1437 = textureGrad(nonuniformEXT(sampler2D(_20[_95], _9)), _1434, _1435, _1436);
            uint _99 = uint(_17._m0[_1386]._m0.y);
            vec3 _1445 = vec3(2.0 * _351, (-2.0) * _351, 2.0);
            vec3 _1447 = vec3(-_351, _351, -1.0);
            vec3 _1448 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_99], _9)), _1434, _1435, _1436).wyz, _1445, _1447);
            vec3 _1456;
            if (_354)
            {
                vec2 _1454 = vec2(-_1448.y, _1448.x);
                _1456 = vec3(_1454.x, _1454.y, _1448.z);
            }
            else
            {
                _1456 = _1448;
            }
            vec3 _1490;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1386]._m15 & 1u) != 0u)
            {
                float _1461 = spvNMax(_17._m0[_1386]._m8, 0.00999999977648258209228515625);
                uint _103 = uint(_17._m0[_1386]._m0.w);
                vec3 _1470 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_103], _9)), _349 * _1461, _352 * _1461, _353 * _1461).wyz, _1445, _1447);
                vec3 _1478;
                if (_354)
                {
                    vec2 _1476 = vec2(-_1470.y, _1470.x);
                    _1478 = vec3(_1476.x, _1476.y, _1470.z);
                }
                else
                {
                    _1478 = _1470;
                }
                float _1480 = _1456.z + 1.0;
                vec3 _1481 = _1456;
                _1481.z = _1480;
                vec2 _1484 = _1478.xy * (-_17._m0[_1386]._m9);
                vec3 _1485 = vec3(_1484.x, _1484.y, _1478.z);
                _1490 = (_1481 * dot(_1481, _1485)) - (_1485 * _1480);
            }
            else
            {
                _1490 = _1456;
            }
            vec4 _1516;
            vec3 _1517;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1386]._m15 & 2u) != 0u)
            {
                float _1497 = smoothstep(_17._m0[_1386]._m10, _17._m0[_1386]._m12, _3.w);
                vec3 _1505 = mix(mix(_17._m0[_1386]._m1.xyz, _17._m0[_1386]._m2.xyz, vec3(sqrt(smoothstep(0.0, _17._m0[_1386]._m11, _1497)))), vec3(1.0), vec3(sqrt(smoothstep(_17._m0[_1386]._m11, 1.0, _1497))));
                vec4 _1515 = _1437;
                _1515.y = _1437.y * clamp(pow(spvNMax(abs(_1505.x + _17._m0[_1386]._m13), 9.9999997473787516355514526367188e-05), _17._m0[_1386]._m14), 0.0, 1.0);
                _1516 = _1515;
                _1517 = _1401 * _1505;
            }
            else
            {
                _1516 = _1437;
                _1517 = _1401;
            }
            _1525 = _1382 + (_1516 * _1082);
            _1526 = _1383;
            _1527 = _1384 + (normalize(_1490) * _1082);
            _1528 = _1385 + (_1517 * _1082);
            break;
        } while(false);
        _1529 = _1525;
        _1530 = _1526;
        _1531 = _1527;
        _1532 = _1528;
    }
    else
    {
        _1529 = _1382;
        _1530 = _1383;
        _1531 = _1384;
        _1532 = _1385;
    }
    uint _1533 = _993.w;
    vec4 _1676;
    float _1677;
    vec3 _1678;
    vec3 _1679;
    SPIRV_CROSS_BRANCH
    if (_1084 > 0.001000000047497451305389404296875)
    {
        float _1539 = spvNMax(_17._m0[_1533]._m7, 0.00999999977648258209228515625);
        uint _107 = uint(_17._m0[_1533]._m0.x);
        vec3 _1548 = textureGrad(nonuniformEXT(sampler2D(_20[_107], _9)), _349 * _1539, _352 * _1539, _353 * _1539).xyz;
        vec4 _1672;
        float _1673;
        vec3 _1674;
        vec3 _1675;
        do
        {
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1533]._m15 & 4u) != 0u)
            {
                _1672 = _1529;
                _1673 = _1530 + _1084;
                _1674 = _1531;
                _1675 = _1532;
                break;
            }
            float _1577 = spvNMax(_17._m0[_1533]._m7, 0.00999999977648258209228515625);
            uint _111 = uint(_17._m0[_1533]._m0.z);
            vec2 _1581 = _349 * _1577;
            vec2 _1582 = _352 * _1577;
            vec2 _1583 = _353 * _1577;
            vec4 _1584 = textureGrad(nonuniformEXT(sampler2D(_20[_111], _9)), _1581, _1582, _1583);
            uint _115 = uint(_17._m0[_1533]._m0.y);
            vec3 _1592 = vec3(2.0 * _351, (-2.0) * _351, 2.0);
            vec3 _1594 = vec3(-_351, _351, -1.0);
            vec3 _1595 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_115], _9)), _1581, _1582, _1583).wyz, _1592, _1594);
            vec3 _1603;
            if (_354)
            {
                vec2 _1601 = vec2(-_1595.y, _1595.x);
                _1603 = vec3(_1601.x, _1601.y, _1595.z);
            }
            else
            {
                _1603 = _1595;
            }
            vec3 _1637;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1533]._m15 & 1u) != 0u)
            {
                float _1608 = spvNMax(_17._m0[_1533]._m8, 0.00999999977648258209228515625);
                uint _119 = uint(_17._m0[_1533]._m0.w);
                vec3 _1617 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_119], _9)), _349 * _1608, _352 * _1608, _353 * _1608).wyz, _1592, _1594);
                vec3 _1625;
                if (_354)
                {
                    vec2 _1623 = vec2(-_1617.y, _1617.x);
                    _1625 = vec3(_1623.x, _1623.y, _1617.z);
                }
                else
                {
                    _1625 = _1617;
                }
                float _1627 = _1603.z + 1.0;
                vec3 _1628 = _1603;
                _1628.z = _1627;
                vec2 _1631 = _1625.xy * (-_17._m0[_1533]._m9);
                vec3 _1632 = vec3(_1631.x, _1631.y, _1625.z);
                _1637 = (_1628 * dot(_1628, _1632)) - (_1632 * _1627);
            }
            else
            {
                _1637 = _1603;
            }
            vec4 _1663;
            vec3 _1664;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_1533]._m15 & 2u) != 0u)
            {
                float _1644 = smoothstep(_17._m0[_1533]._m10, _17._m0[_1533]._m12, _3.w);
                vec3 _1652 = mix(mix(_17._m0[_1533]._m1.xyz, _17._m0[_1533]._m2.xyz, vec3(sqrt(smoothstep(0.0, _17._m0[_1533]._m11, _1644)))), vec3(1.0), vec3(sqrt(smoothstep(_17._m0[_1533]._m11, 1.0, _1644))));
                vec4 _1662 = _1584;
                _1662.y = _1584.y * clamp(pow(spvNMax(abs(_1652.x + _17._m0[_1533]._m13), 9.9999997473787516355514526367188e-05), _17._m0[_1533]._m14), 0.0, 1.0);
                _1663 = _1662;
                _1664 = _1548 * _1652;
            }
            else
            {
                _1663 = _1584;
                _1664 = _1548;
            }
            _1672 = _1529 + (_1663 * _1084);
            _1673 = _1530;
            _1674 = _1531 + (normalize(_1637) * _1084);
            _1675 = _1532 + (_1664 * _1084);
            break;
        } while(false);
        _1676 = _1672;
        _1677 = _1673;
        _1678 = _1674;
        _1679 = _1675;
    }
    else
    {
        _1676 = _1529;
        _1677 = _1530;
        _1678 = _1531;
        _1679 = _1532;
    }
    vec2 _1733;
    SPIRV_CROSS_BRANCH
    if (_10._m5.y < 64u)
    {
        vec4 _1688 = vec4(clamp(_279.y, 0.0, 1.0), 0.25, _3.y, 0.75);
        vec4 _1693 = textureGather(sampler2D(_16, _12), _1688.xy);
        vec4 _1696 = textureGather(sampler2D(_16, _12), _1688.zw);
        vec2 _1701 = _1688.xz * float(uvec2(textureSize(_16, 0)).x);
        float _1705 = clamp(fract(_1701.x - 0.5), 0.0, 1.0);
        float _1709 = clamp(fract(_1701.y - 0.5), 0.0, 1.0);
        float _1712 = mix(_1693.w, _1693.z, _1705);
        float _1715 = mix(_1696.w, _1696.z, _1709);
        float _1716 = _1712 * _1715;
        float _1723 = mix(_1693.x, _1693.y, _1705) * mix(_1696.x, _1696.y, _1709);
        float _1724 = _1723 * 2.0;
        vec2 _1725 = vec2(_1716, _1724);
        float _1728 = (fma(_1712, _1715, _1724) == 0.0) ? 1.0 : _1716;
        _1725.x = _1728;
        _1733 = _1725 * (_1091 / fma(_1723, 2.0, _1728));
    }
    else
    {
        _1733 = vec2(_1091, 0.0);
    }
    vec4 _1877;
    float _1878;
    vec3 _1879;
    vec3 _1880;
    SPIRV_CROSS_BRANCH
    if (_1733.x > 0.001000000047497451305389404296875)
    {
        float _1740 = spvNMax(_17._m0[_10._m5.x]._m7, 0.00999999977648258209228515625);
        uint _123 = uint(_17._m0[_10._m5.x]._m0.x);
        vec3 _1749 = textureGrad(nonuniformEXT(sampler2D(_20[_123], _9)), _349 * _1740, _352 * _1740, _353 * _1740).xyz;
        vec4 _1873;
        float _1874;
        vec3 _1875;
        vec3 _1876;
        do
        {
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_10._m5.x]._m15 & 4u) != 0u)
            {
                _1873 = _1676;
                _1874 = _1677 + _1733.x;
                _1875 = _1678;
                _1876 = _1679;
                break;
            }
            float _1778 = spvNMax(_17._m0[_10._m5.x]._m7, 0.00999999977648258209228515625);
            uint _127 = uint(_17._m0[_10._m5.x]._m0.z);
            vec2 _1782 = _349 * _1778;
            vec2 _1783 = _352 * _1778;
            vec2 _1784 = _353 * _1778;
            vec4 _1785 = textureGrad(nonuniformEXT(sampler2D(_20[_127], _9)), _1782, _1783, _1784);
            uint _131 = uint(_17._m0[_10._m5.x]._m0.y);
            vec3 _1793 = vec3(2.0 * _351, (-2.0) * _351, 2.0);
            vec3 _1795 = vec3(-_351, _351, -1.0);
            vec3 _1796 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_131], _9)), _1782, _1783, _1784).wyz, _1793, _1795);
            vec3 _1804;
            if (_354)
            {
                vec2 _1802 = vec2(-_1796.y, _1796.x);
                _1804 = vec3(_1802.x, _1802.y, _1796.z);
            }
            else
            {
                _1804 = _1796;
            }
            vec3 _1838;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_10._m5.x]._m15 & 1u) != 0u)
            {
                float _1809 = spvNMax(_17._m0[_10._m5.x]._m8, 0.00999999977648258209228515625);
                uint _135 = uint(_17._m0[_10._m5.x]._m0.w);
                vec3 _1818 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_135], _9)), _349 * _1809, _352 * _1809, _353 * _1809).wyz, _1793, _1795);
                vec3 _1826;
                if (_354)
                {
                    vec2 _1824 = vec2(-_1818.y, _1818.x);
                    _1826 = vec3(_1824.x, _1824.y, _1818.z);
                }
                else
                {
                    _1826 = _1818;
                }
                float _1828 = _1804.z + 1.0;
                vec3 _1829 = _1804;
                _1829.z = _1828;
                vec2 _1832 = _1826.xy * (-_17._m0[_10._m5.x]._m9);
                vec3 _1833 = vec3(_1832.x, _1832.y, _1826.z);
                _1838 = (_1829 * dot(_1829, _1833)) - (_1833 * _1828);
            }
            else
            {
                _1838 = _1804;
            }
            vec4 _1864;
            vec3 _1865;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_10._m5.x]._m15 & 2u) != 0u)
            {
                float _1845 = smoothstep(_17._m0[_10._m5.x]._m10, _17._m0[_10._m5.x]._m12, _3.w);
                vec3 _1853 = mix(mix(_17._m0[_10._m5.x]._m1.xyz, _17._m0[_10._m5.x]._m2.xyz, vec3(sqrt(smoothstep(0.0, _17._m0[_10._m5.x]._m11, _1845)))), vec3(1.0), vec3(sqrt(smoothstep(_17._m0[_10._m5.x]._m11, 1.0, _1845))));
                vec4 _1863 = _1785;
                _1863.y = _1785.y * clamp(pow(spvNMax(abs(_1853.x + _17._m0[_10._m5.x]._m13), 9.9999997473787516355514526367188e-05), _17._m0[_10._m5.x]._m14), 0.0, 1.0);
                _1864 = _1863;
                _1865 = _1749 * _1853;
            }
            else
            {
                _1864 = _1785;
                _1865 = _1749;
            }
            _1873 = _1676 + (_1864 * _1733.x);
            _1874 = _1677;
            _1875 = _1678 + (normalize(_1838) * _1733.x);
            _1876 = _1679 + (_1865 * _1733.x);
            break;
        } while(false);
        _1877 = _1873;
        _1878 = _1874;
        _1879 = _1875;
        _1880 = _1876;
    }
    else
    {
        _1877 = _1676;
        _1878 = _1677;
        _1879 = _1678;
        _1880 = _1679;
    }
    vec4 _2024;
    float _2025;
    vec3 _2026;
    vec3 _2027;
    SPIRV_CROSS_BRANCH
    if (_1733.y > 0.001000000047497451305389404296875)
    {
        float _1887 = spvNMax(_17._m0[_10._m5.y]._m7, 0.00999999977648258209228515625);
        uint _139 = uint(_17._m0[_10._m5.y]._m0.x);
        vec3 _1896 = textureGrad(nonuniformEXT(sampler2D(_20[_139], _9)), _349 * _1887, _352 * _1887, _353 * _1887).xyz;
        vec4 _2020;
        float _2021;
        vec3 _2022;
        vec3 _2023;
        do
        {
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_10._m5.y]._m15 & 4u) != 0u)
            {
                _2020 = _1877;
                _2021 = _1878 + _1733.y;
                _2022 = _1880;
                _2023 = _1879;
                break;
            }
            float _1925 = spvNMax(_17._m0[_10._m5.y]._m7, 0.00999999977648258209228515625);
            uint _143 = uint(_17._m0[_10._m5.y]._m0.z);
            vec2 _1929 = _349 * _1925;
            vec2 _1930 = _352 * _1925;
            vec2 _1931 = _353 * _1925;
            vec4 _1932 = textureGrad(nonuniformEXT(sampler2D(_20[_143], _9)), _1929, _1930, _1931);
            uint _147 = uint(_17._m0[_10._m5.y]._m0.y);
            vec3 _1940 = vec3(2.0 * _351, (-2.0) * _351, 2.0);
            vec3 _1942 = vec3(-_351, _351, -1.0);
            vec3 _1943 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_147], _9)), _1929, _1930, _1931).wyz, _1940, _1942);
            vec3 _1951;
            if (_354)
            {
                vec2 _1949 = vec2(-_1943.y, _1943.x);
                _1951 = vec3(_1949.x, _1949.y, _1943.z);
            }
            else
            {
                _1951 = _1943;
            }
            vec3 _1985;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_10._m5.y]._m15 & 1u) != 0u)
            {
                float _1956 = spvNMax(_17._m0[_10._m5.y]._m8, 0.00999999977648258209228515625);
                uint _151 = uint(_17._m0[_10._m5.y]._m0.w);
                vec3 _1965 = fma(textureGrad(nonuniformEXT(sampler2D(_20[_151], _9)), _349 * _1956, _352 * _1956, _353 * _1956).wyz, _1940, _1942);
                vec3 _1973;
                if (_354)
                {
                    vec2 _1971 = vec2(-_1965.y, _1965.x);
                    _1973 = vec3(_1971.x, _1971.y, _1965.z);
                }
                else
                {
                    _1973 = _1965;
                }
                float _1975 = _1951.z + 1.0;
                vec3 _1976 = _1951;
                _1976.z = _1975;
                vec2 _1979 = _1973.xy * (-_17._m0[_10._m5.y]._m9);
                vec3 _1980 = vec3(_1979.x, _1979.y, _1973.z);
                _1985 = (_1976 * dot(_1976, _1980)) - (_1980 * _1975);
            }
            else
            {
                _1985 = _1951;
            }
            vec4 _2011;
            vec3 _2012;
            SPIRV_CROSS_BRANCH
            if ((_17._m0[_10._m5.y]._m15 & 2u) != 0u)
            {
                float _1992 = smoothstep(_17._m0[_10._m5.y]._m10, _17._m0[_10._m5.y]._m12, _3.w);
                vec3 _2000 = mix(mix(_17._m0[_10._m5.y]._m1.xyz, _17._m0[_10._m5.y]._m2.xyz, vec3(sqrt(smoothstep(0.0, _17._m0[_10._m5.y]._m11, _1992)))), vec3(1.0), vec3(sqrt(smoothstep(_17._m0[_10._m5.y]._m11, 1.0, _1992))));
                vec4 _2010 = _1932;
                _2010.y = _1932.y * clamp(pow(spvNMax(abs(_2000.x + _17._m0[_10._m5.y]._m13), 9.9999997473787516355514526367188e-05), _17._m0[_10._m5.y]._m14), 0.0, 1.0);
                _2011 = _2010;
                _2012 = _1896 * _2000;
            }
            else
            {
                _2011 = _1932;
                _2012 = _1896;
            }
            _2020 = _1877 + (_2011 * _1733.y);
            _2021 = _1878;
            _2022 = _1880 + (_2012 * _1733.y);
            _2023 = _1879 + (normalize(_1985) * _1733.y);
            break;
        } while(false);
        _2024 = _2020;
        _2025 = _2021;
        _2026 = _2022;
        _2027 = _2023;
    }
    else
    {
        _2024 = _1877;
        _2025 = _1878;
        _2026 = _1880;
        _2027 = _1879;
    }
    float _2028 = dot(_2027, _2027);
    mat3 _2041 = mat3(_13._m0[0].xyz, _13._m0[1].xyz, _13._m0[2].xyz);
    vec3 _2042 = _279 * _2041;
    vec3 _2045 = normalize(cross(_279, vec3(0.0, 0.0, 1.0))) * _2041;
    vec3 _2059 = (mat3(_2045, normalize(cross(_2045, _2042)), _2042) * (_2027 * ((_2028 > 0.001000000047497451305389404296875) ? inversesqrt(_2028) : 1.0))) * mat3(_8._m0[0].xyz, _8._m0[1].xyz, _8._m0[2].xyz);
    vec2 _2081 = (((_2059.xy / vec2(1.0 - _2059.z)) * vec2(0.562524616718292236328125)) * 0.5) + vec2(0.5);
    vec3 _2083 = clamp(_2026, vec3(0.0), vec3(1.0));
    vec4 _2084 = vec4(_2083.x, _2083.y, _2083.z, _255.w);
    _2084.w = _2024.z + _2025;
    _4 = vec4(_2081.x, _2081.y, vec4(0.0).z, vec4(0.0).w);
    _5 = _2084;
    _6 = vec4(clamp(fma(fma(-clamp(_2025 - 0.5, 0.0, 1.0), 2.0, 1.0), _2025, _2024.y), 0.0, 1.0), 0.5, clamp(_2024.x + ((_2025 < 0.5) ? 0.0 : _2025), 0.0, 1.0), float((((uint(_2025 >= 0.97500002384185791015625) & 7u) | 8u) | 0u) | 0u) * 0.0039215688593685626983642578125);
    _7 = vec4(0.0);
}

