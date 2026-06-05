
static float4 _150 = (float4)0;

[[vk::binding(0, 0)]]
cbuffer _35_15 : register(b0, space0)
{
    float _15_m0 : packoffset(c0);
    float _15_m1 : packoffset(c0.y);
    float _15_m2 : packoffset(c0.z);
    float _15_m3 : packoffset(c0.w);
    float _15_m4 : packoffset(c1);
    float _15_m5 : packoffset(c1.y);
    int _15_m6 : packoffset(c1.z);
    float _15_m7 : packoffset(c1.w);
};

[[vk::binding(2, 0)]]
cbuffer _36_16 : register(b2, space0)
{
    column_major float4x4 _16_m0 : packoffset(c0);
    column_major float4x4 _16_m1 : packoffset(c4);
    column_major float4x4 _16_m2 : packoffset(c8);
    float _16_m3 : packoffset(c12);
    float _16_m4 : packoffset(c12.y);
    float2 _16_m5 : packoffset(c12.z);
    float3 _16_m6 : packoffset(c13);
    int _16_m7 : packoffset(c13.w);
};

[[vk::binding(3, 0)]]
cbuffer _37_17 : register(b3, space0)
{
    float _17_m0 : packoffset(c0);
    float _17_m1 : packoffset(c0.y);
    float _17_m2 : packoffset(c0.z);
    float _17_m3 : packoffset(c0.w);
};

[[vk::binding(4, 0)]]
cbuffer _38_18 : register(b4, space0)
{
    float2 _18_m0 : packoffset(c0);
    float2 _18_m1 : packoffset(c0.z);
    uint2 _18_m2 : packoffset(c1);
    uint2 _18_m3 : packoffset(c1.z);
    uint2 _18_m4 : packoffset(c2);
    uint _18_m5 : packoffset(c2.z);
    uint _18_m6 : packoffset(c2.w);
    float2 _18_m7 : packoffset(c3);
    float2 _18_m8 : packoffset(c3.z);
    float2 _18_m9 : packoffset(c4);
    float2 _18_m10 : packoffset(c4.z);
    float2 _18_m11 : packoffset(c5);
    float2 _18_m12 : packoffset(c5.z);
    float2 _18_m13 : packoffset(c6);
    float2 _18_m14 : packoffset(c6.z);
    float2 _18_m15 : packoffset(c7);
    float2 _18_m16 : packoffset(c7.z);
    uint2 _18_m17 : packoffset(c8);
    uint2 _18_m18 : packoffset(c8.z);
    uint2 _18_m19 : packoffset(c9);
    uint2 _18_m20 : packoffset(c9.z);
    float2 _18_m21 : packoffset(c10);
    float2 _18_m22 : packoffset(c10.z);
};

[[vk::binding(0, 2)]]
ByteAddressBuffer _22 : register(t0, space2);
[[vk::binding(26, 2)]]
cbuffer _43_26 : register(b26, space2)
{
    float _26_m0 : packoffset(c0);
    float _26_m1 : packoffset(c0.y);
    float _26_m2 : packoffset(c0.z);
    float _26_m3 : packoffset(c0.w);
    float _26_m4 : packoffset(c1);
    float _26_m5 : packoffset(c1.y);
    float _26_m6 : packoffset(c1.z);
    float _26_m7 : packoffset(c1.w);
    float4 _26_m8 : packoffset(c2);
    float4 _26_m9 : packoffset(c3);
    column_major float4x4 _26_m10[4] : packoffset(c4);
    float _26_m11 : packoffset(c20);
    float _26_m12 : packoffset(c20.y);
    float _26_m13 : packoffset(c20.z);
    uint _26_m14 : packoffset(c20.w);
    float2 _26_m15 : packoffset(c21);
    float2 _26_m16 : packoffset(c21.z);
    float3 _26_m17 : packoffset(c22);
    float _26_m18 : packoffset(c22.w);
    column_major float4x3 _26_m19 : packoffset(c23);
    float4 _26_m20[4] : packoffset(c26);
    float _26_m21 : packoffset(c30);
    float _26_m22 : packoffset(c30.y);
    float _26_m23 : packoffset(c30.z);
    float _26_m24 : packoffset(c30.w);
    uint _26_m25 : packoffset(c31);
    uint _26_m26 : packoffset(c31.y);
    float _26_m27 : packoffset(c31.z);
    float _26_m28 : packoffset(c31.w);
    float _26_m29 : packoffset(c32);
    float _26_m30 : packoffset(c32.y);
    float _26_m31 : packoffset(c32.z);
    float _26_m32 : packoffset(c32.w);
    float2 _26_m33 : packoffset(c33);
    float2 _26_m34 : packoffset(c33.z);
};

[[vk::binding(0, 1)]]
cbuffer _44_27 : register(b0, space1)
{
    float3 _27_m0 : packoffset(c0);
    float _27_m1 : packoffset(c0.w);
};

[[vk::binding(1, 1)]]
cbuffer _45_28 : register(b1, space1)
{
    float2 _28_m0 : packoffset(c0);
    float2 _28_m1 : packoffset(c0.z);
    float2 _28_m2 : packoffset(c1);
    float2 _28_m3 : packoffset(c1.z);
    float2 _28_m4 : packoffset(c2);
    float2 _28_m5 : packoffset(c2.z);
    float2 _28_m6 : packoffset(c3);
    float2 _28_m7 : packoffset(c3.z);
    float2 _28_m8 : packoffset(c4);
    float2 _28_m9 : packoffset(c4.z);
    float2 _28_m10 : packoffset(c5);
    float _28_m11 : packoffset(c5.z);
    float _28_m12 : packoffset(c5.w);
    float _28_m13 : packoffset(c6);
    float _28_m14 : packoffset(c6.y);
    float _28_m15 : packoffset(c6.z);
    float _28_m16 : packoffset(c6.w);
    float _28_m17 : packoffset(c7);
    float _28_m18 : packoffset(c7.y);
    float _28_m19 : packoffset(c7.z);
    float _28_m20 : packoffset(c7.w);
    float _28_m21 : packoffset(c8);
    float _28_m22 : packoffset(c8.y);
    float _28_m23 : packoffset(c8.z);
    float _28_m24 : packoffset(c8.w);
    float _28_m25 : packoffset(c9);
    float _28_m26 : packoffset(c9.y);
    float _28_m27 : packoffset(c9.z);
    float _28_m28 : packoffset(c9.w);
};

[[vk::binding(7, 0)]]
SamplerState _19 : register(s7, space0);
[[vk::binding(8, 0)]]
SamplerState _20 : register(s8, space0);
[[vk::binding(9, 0)]]
SamplerState _21 : register(s9, space0);
[[vk::binding(5, 2)]]
Texture2D<float4> _23 : register(t5, space2);
[[vk::binding(17, 2)]]
Texture3D<float4> _24 : register(t17, space2);
[[vk::binding(19, 2)]]
SamplerState _25 : register(s19, space2);
[[vk::binding(3, 1)]]
Texture2D<float4> _29 : register(t3, space1);
[[vk::binding(4, 1)]]
Texture2D<float4> _30 : register(t4, space1);
[[vk::binding(5, 1)]]
Texture2D<float4> _31 : register(t5, space1);
[[vk::binding(6, 1)]]
Texture2D<float4> _32 : register(t6, space1);
[[vk::binding(7, 1)]]
Texture2D<float4> _33 : register(t7, space1);
[[vk::binding(8, 1)]]
Texture2D<float4> _34 : register(t8, space1);

static float4 gl_FragCoord = (float4)0;
static float2 _4 = (float2)0;
static float4 _5 = (float4)0;
static float3 _6 = (float3)0;
static float _7 = (float)0;
static float3 _8 = (float3)0;
static float3 _9 = (float3)0;
static float3 _10 = (float3)0;
static float3 _11 = (float3)0;
static float4 _12 = (float4)0;
static float _13 = (float)0;
static float4 _14 = (float4)0;

struct SPIRV_Cross_Input
{
    float2 _4 : TEXCOORD0;
    float4 _5 : TEXCOORD1;
    float3 _6 : TEXCOORD2;
    float _7 : TEXCOORD3;
    float3 _8 : TEXCOORD4;
    float3 _9 : TEXCOORD5;
    float3 _10 : TEXCOORD6;
    float3 _11 : TEXCOORD7;
    float4 _12 : TEXCOORD8;
    float _13 : TEXCOORD9;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 _14 : SV_Target0;
};

void frag_main()
{
    float2 _172 = gl_FragCoord.xy * float2(_17_m2, _17_m3);
    float3 _177 = normalize(mul(float3x3(_10, _8, _9), normalize(-_11)));
    float _179 = 1.0f - _4.y;
    float _193 = _179 * _29.Sample(_19, mad(_4, _28_m3, _28_m4 * _15_m0)).x;
    float _195 = step(_193, _5.w);
    float _223 = 1.0f - _28_m15;
    float _229 = 1.0f - clamp(smoothstep(_28_m14 + _223, _223, _179 * pow(max(abs(_30.Sample(_19, mad(_4, _28_m5, _28_m6 * _15_m0)).x), 9.9999997473787516355514526367188e-05f), _28_m13)), 0.0f, 1.0f);
    float _249 = clamp((length(_16_m6 - (_6 + _16_m6)) - _28_m17) / (_28_m18 - _28_m17), 0.0f, 1.0f);
    float4 _283 = _32.SampleLevel(_20, float2(pow(max(abs(1.0f - clamp(_177.y, 0.0f, 1.0f)), 9.9999997473787516355514526367188e-05f), 1.0f), 0.0f), 0.0f);
    float3 _292 = _33.SampleLevel(_20, float2(mad(1.0f - clamp(smoothstep(_5.w + 0.100000001490116119384765625f, _5.w - 0.100000001490116119384765625f, _193), 0.0f, 1.0f), _28_m21, _283.z), 0.0f), 0.0f).xyz;
    float2 _336 = _4 + (float2(_177.x, -_177.z) * (-0.17000000178813934326171875f));
    float _340 = _336.x;
    float _343 = _336.y;
    float _346 = _15_m0 * _28_m26;
    float4 _366 = _34.Sample(_19, mad(_28_m8, _336, _28_m7 * _15_m0) + float2(_340 + (sin(fmod(mad(_28_m9.x, _343, _346), 6.28318023681640625f)) / _28_m10.x), _343 + (sin(fmod(mad(_28_m9.y, _340, _346), 6.28318023681640625f)) / _28_m10.y)));
    float _367 = _366.x;
    float _depth_fade = clamp(mad(_23.Sample(_21, _172).x, _16_m4, -_7) / max(_28_m20, 9.9999997473787516355514526367188e-05f), 0.0f, 1.0f);
    // Transparent surfaces (water) don't write depth, so depth_fade can't soften the
    // dome's geometric bottom edge against water. Apply a vertical gradient fade at the
    // base of the dome using _179 (= 1 - uv.y, which is 0 at the dome's bottom rim).
    float _bottom_fade = smoothstep(0.0f, 0.12f, _179);
    float _edge_fade = min(_depth_fade, _bottom_fade);
    float3 _383 = (mad(_292 * lerp(0.0f, mad(mad(abs(mad(frac(mad(_15_m0, 0.134000003337860107421875f, mad(_34.Sample(_19, float2(7.0f, 3.0f) * _4).y, 2.5f, _12.x)) + 0.5f), 2.0f, -1.0f)), -0.5f, 0.5f), _12.x, pow(max(abs(_12.x), 9.9999997473787516355514526367188e-05f), 3.0f)), _28_m22), float3(1.06099998950958251953125f, 1.1381771564483642578125f, 1.2999999523162841796875f), ((_292 * lerp(1.0f, pow(max(abs(lerp(_283.x, _283.y, lerp(1.0f, _12.z, _28_m23))), 9.9999997473787516355514526367188e-05f), _28_m24), _28_m25)) * lerp(1.0f, pow(max(abs(lerp(_367, _366.y * _367, 1.0f - _367)), 9.9999997473787516355514526367188e-05f), 3.0f), 0.64999997615814208984375f)) * 2.0f) * _28_m27) * lerp(1.0f, _249, _28_m19);
    float4 _556;
    do
    {
        if (_26_m19[3].z < 0.0f)
        {
            _556 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            break;
        }
        float _425;
        do
        {
            if (_13 <= _26_m19[0].x)
            {
                _425 = mad(_26_m19[2].x, _13, _26_m19[3].x);
                break;
            }
            else
            {
                _425 = _26_m19[1].y * log2(mad(_26_m19[2].y, _13, _26_m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        float3 _436 = (float3(_172 / float2(_26_m32, _26_m18), _425) + float3(float(_18_m5), 0.0f, 0.0f)) - 0.5f.xxx;
        float3 _437 = floor(_436);
        float3 _438 = _436 - _437;
        float3 _439 = 1.0f.xxx - _438;
        float3 _446 = mad(-((_438 * 0.5f) * _438), 2.0f.xxx - _438, 0.666666686534881591796875f.xxx);
        float3 _453 = (_438 * 0.16666667163372039794921875f) * _438;
        float3 _455 = mad((_439 * 0.16666667163372039794921875f) * _439, _439, _446);
        float3 _462 = _26_m17 * (((_446 / _455) - 0.5f.xxx) + _437);
        float3 _466 = _26_m17 * ((((_453 * _438) / mad(_453, _438, mad(-((_439 * 0.5f) * _439), _438 + 1.0f.xxx, 0.666666686534881591796875f.xxx))) + 1.5f.xxx) + _437);
        float _474 = _462.z;
        float _480 = _466.x;
        float2 _484 = max(_26_m15, min(_26_m16, float2(_480, _462.y)));
        float _485 = _484.x;
        float4 _491 = _455.x.xxxx;
        float _493 = _462.x;
        float2 _497 = max(_26_m15, min(_26_m16, float2(_493, _466.y)));
        float _498 = _497.x;
        float4 _513 = _455.y.xxxx;
        float _518 = _466.z;
        float4 _544 = lerp(lerp(lerp(_24.SampleLevel(_25, float3(max(_26_m15, min(_26_m16, _466.xy)), _518), 0.0f), _24.SampleLevel(_25, float3(_498, _497.y, _518), 0.0f), _491), lerp(_24.SampleLevel(_25, float3(_485, _484.y, _518), 0.0f), _24.SampleLevel(_25, float3(max(_26_m15, min(_26_m16, float2(_493, _462.y))), _518), 0.0f), _491), _513), lerp(lerp(_24.SampleLevel(_25, float3(max(_26_m15, min(_26_m16, float2(_480, _466.y))), _474), 0.0f), _24.SampleLevel(_25, float3(_498, _497.y, _474), 0.0f), _491), lerp(_24.SampleLevel(_25, float3(_485, _484.y, _474), 0.0f), _24.SampleLevel(_25, float3(max(_26_m15, min(_26_m16, _462.xy)), _474), 0.0f), _491), _513), _455.z.xxxx) * float4(0.03125f, 0.03125f, 0.03125f, 3.0517578125e-05f);
        float4 _552;
        if (isinf(_544.w) || isnan(_544.w))
        {
            float4 _551;
            _551.w = 0.0f;
            _552 = _551;
        }
        else
        {
            _552 = _544;
        }
        float4 _555;
        _555.w = 1.0f - _552.w;
        _556 = _555;
        break;
    } while(false);
    _14 = max(float4(((lerp((((_31.SampleLevel(_20, float2(_229, 0.0f), 0.0f).xyz * _229) * _28_m16) + _383) * _edge_fade * mad(clamp(step(_193, _5.w + _28_m11) - _195, 0.0f, 1.0f), _28_m12, _195), 0.0f.xxx, ((1.0f - _249) * floor(_28_m19)).xxx) * asfloat(_22.Load(0))) * _556.www) * _27_m1, _27_m1 * _edge_fade), 0.0f.xxxx);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    _4 = stage_input._4;
    _5 = stage_input._5;
    _6 = stage_input._6;
    _7 = stage_input._7;
    _8 = stage_input._8;
    _9 = stage_input._9;
    _10 = stage_input._10;
    _11 = stage_input._11;
    _12 = stage_input._12;
    _13 = stage_input._13;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._14 = _14;
    return stage_output;
}

