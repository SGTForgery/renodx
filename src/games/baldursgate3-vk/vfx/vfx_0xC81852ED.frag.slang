
[[vk::binding(0, 0)]]
cbuffer _30_11 : register(b0, space0)
{
    float _11_m0 : packoffset(c0);
    float _11_m1 : packoffset(c0.y);
    float _11_m2 : packoffset(c0.z);
    float _11_m3 : packoffset(c0.w);
    float _11_m4 : packoffset(c1);
    float _11_m5 : packoffset(c1.y);
    int _11_m6 : packoffset(c1.z);
    float _11_m7 : packoffset(c1.w);
};

[[vk::binding(2, 0)]]
cbuffer _31_12 : register(b2, space0)
{
    column_major float4x4 _12_m0 : packoffset(c0);
    column_major float4x4 _12_m1 : packoffset(c4);
    column_major float4x4 _12_m2 : packoffset(c8);
    float _12_m3 : packoffset(c12);
    float _12_m4 : packoffset(c12.y);
    float2 _12_m5 : packoffset(c12.z);
    float3 _12_m6 : packoffset(c13);
    int _12_m7 : packoffset(c13.w);
};

[[vk::binding(3, 0)]]
cbuffer _32_13 : register(b3, space0)
{
    float _13_m0 : packoffset(c0);
    float _13_m1 : packoffset(c0.y);
    float _13_m2 : packoffset(c0.z);
    float _13_m3 : packoffset(c0.w);
};

[[vk::binding(4, 0)]]
cbuffer _33_14 : register(b4, space0)
{
    float2 _14_m0 : packoffset(c0);
    float2 _14_m1 : packoffset(c0.z);
    uint2 _14_m2 : packoffset(c1);
    uint2 _14_m3 : packoffset(c1.z);
    uint2 _14_m4 : packoffset(c2);
    uint _14_m5 : packoffset(c2.z);
    uint _14_m6 : packoffset(c2.w);
    float2 _14_m7 : packoffset(c3);
    float2 _14_m8 : packoffset(c3.z);
    float2 _14_m9 : packoffset(c4);
    float2 _14_m10 : packoffset(c4.z);
    float2 _14_m11 : packoffset(c5);
    float2 _14_m12 : packoffset(c5.z);
    float2 _14_m13 : packoffset(c6);
    float2 _14_m14 : packoffset(c6.z);
    float2 _14_m15 : packoffset(c7);
    float2 _14_m16 : packoffset(c7.z);
    uint2 _14_m17 : packoffset(c8);
    uint2 _14_m18 : packoffset(c8.z);
    uint2 _14_m19 : packoffset(c9);
    uint2 _14_m20 : packoffset(c9.z);
    float2 _14_m21 : packoffset(c10);
    float2 _14_m22 : packoffset(c10.z);
};

[[vk::binding(26, 2)]]
cbuffer _36_21 : register(b26, space2)
{
    float _21_m0 : packoffset(c0);
    float _21_m1 : packoffset(c0.y);
    float _21_m2 : packoffset(c0.z);
    float _21_m3 : packoffset(c0.w);
    float _21_m4 : packoffset(c1);
    float _21_m5 : packoffset(c1.y);
    float _21_m6 : packoffset(c1.z);
    float _21_m7 : packoffset(c1.w);
    float4 _21_m8 : packoffset(c2);
    float4 _21_m9 : packoffset(c3);
    column_major float4x4 _21_m10[4] : packoffset(c4);
    float _21_m11 : packoffset(c20);
    float _21_m12 : packoffset(c20.y);
    float _21_m13 : packoffset(c20.z);
    uint _21_m14 : packoffset(c20.w);
    float2 _21_m15 : packoffset(c21);
    float2 _21_m16 : packoffset(c21.z);
    float3 _21_m17 : packoffset(c22);
    float _21_m18 : packoffset(c22.w);
    column_major float4x3 _21_m19 : packoffset(c23);
    float4 _21_m20[4] : packoffset(c26);
    float _21_m21 : packoffset(c30);
    float _21_m22 : packoffset(c30.y);
    float _21_m23 : packoffset(c30.z);
    float _21_m24 : packoffset(c30.w);
    uint _21_m25 : packoffset(c31);
    uint _21_m26 : packoffset(c31.y);
    float _21_m27 : packoffset(c31.z);
    float _21_m28 : packoffset(c31.w);
    float _21_m29 : packoffset(c32);
    float _21_m30 : packoffset(c32.y);
    float _21_m31 : packoffset(c32.z);
    float _21_m32 : packoffset(c32.w);
    float2 _21_m33 : packoffset(c33);
    float2 _21_m34 : packoffset(c33.z);
};

[[vk::binding(0, 1)]]
cbuffer _37_22 : register(b0, space1)
{
    float4 _22_m0 : packoffset(c0);
    float3 _22_m1 : packoffset(c1);
    float _22_m2 : packoffset(c1.w);
};

[[vk::binding(1, 1)]]
cbuffer _38_23 : register(b1, space1)
{
    float2 _23_m0 : packoffset(c0);
    float2 _23_m1 : packoffset(c0.z);
    float2 _23_m2 : packoffset(c1);
    float2 _23_m3 : packoffset(c1.z);
    float2 _23_m4 : packoffset(c2);
    float2 _23_m5 : packoffset(c2.z);
    float2 _23_m6 : packoffset(c3);
    float2 _23_m7 : packoffset(c3.z);
    float _23_m8 : packoffset(c4);
    float _23_m9 : packoffset(c4.y);
    float _23_m10 : packoffset(c4.z);
    float _23_m11 : packoffset(c4.w);
    float _23_m12 : packoffset(c5);
    float _23_m13 : packoffset(c5.y);
    float _23_m14 : packoffset(c5.z);
    float _23_m15 : packoffset(c5.w);
    float _23_m16 : packoffset(c6);
    float _23_m17 : packoffset(c6.y);
    float _23_m18 : packoffset(c6.z);
    float _23_m19 : packoffset(c6.w);
    float _23_m20 : packoffset(c7);
    float _23_m21 : packoffset(c7.y);
    float _23_m22 : packoffset(c7.z);
    float _23_m23 : packoffset(c7.w);
};

[[vk::binding(7, 0)]]
SamplerState _15 : register(s7, space0);
[[vk::binding(8, 0)]]
SamplerState _16 : register(s8, space0);
[[vk::binding(9, 0)]]
SamplerState _17 : register(s9, space0);
[[vk::binding(5, 2)]]
Texture2D<float4> _18 : register(t5, space2);
[[vk::binding(17, 2)]]
Texture3D<float4> _19 : register(t17, space2);
[[vk::binding(19, 2)]]
SamplerState _20 : register(s19, space2);
[[vk::binding(2, 1)]]
Texture2D<float4> _24 : register(t2, space1);
[[vk::binding(3, 1)]]
Texture2D<float4> _25 : register(t3, space1);
[[vk::binding(4, 1)]]
Texture2D<float4> _26 : register(t4, space1);
[[vk::binding(5, 1)]]
Texture2D<float4> _27 : register(t5, space1);
[[vk::binding(6, 1)]]
Texture2D<float4> _28 : register(t6, space1);
[[vk::binding(7, 1)]]
Texture2D<float4> _29 : register(t7, space1);

static float4 gl_FragCoord = (float4)0;
static float2 _4 = (float2)0;
static float2 _5 = (float2)0;
static float4 _6 = (float4)0;
static float _7 = (float)0;
static float3 _8 = (float3)0;
static float _9 = (float)0;
static float4 _10 = (float4)0;

struct SPIRV_Cross_Input
{
    float2 _4 : TEXCOORD0;
    float2 _5 : TEXCOORD1;
    float4 _6 : TEXCOORD2;
    float _7 : TEXCOORD3;
    float3 _8 : TEXCOORD4;
    float _9 : TEXCOORD5;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 _10 : SV_Target0;
};

void frag_main()
{
    float2 _147 = gl_FragCoord.xy * float2(_13_m2, _13_m3);
    float4 _172 = frac((float4(_5.y, 1.0f - _5.y, frac(_5.y.xx + float2(135.0f, 913.0f))) * 812.0f) + _6);
    float2 _182 = mad(_4, _23_m1, _172.yw + (_23_m0 * _11_m0));
    float2 _188 = mad(_4, _23_m3, _23_m2 * _11_m0);
    float2 _198 = (((_25.Sample(_15, _188).xy + (-0.5f).xx) * 2.0f) * float2(-1.0f, 1.0f)) * _23_m9;
    float _202 = mad(_23_m10, _11_m0, _172.z);
    float _203 = frac(_202);
    float2 _208 = (float2(_203, frac(_202 + 0.5f)) * 2.0f) - 1.0f.xx;
    float _209 = _208.x;
    float2 _210 = _198 * _209;
    float _216 = _208.y;
    float2 _217 = _198 * _216;
    float _225 = abs(mad(frac(_203 + 1.0f), 2.0f, -1.0f));
    float _226 = lerp(_26.Sample(_15, _182 + _210).x, _26.Sample(_15, _182 + _217).x, _225);
    float2 _234 = mad(_4, _23_m5, _172.zx + (_23_m4 * _11_m0));
    float4 _261 = _18.Sample(_17, _147);
    // Clamp the depth-fade exponent to linear (1.0) — the original power curve
    // amplifies sub-pixel depth variation into large opacity swings each frame,
    // which manifests as shimmering/artefacting across the VFX surface.
    float _depth_fade_linear = clamp(mad(_261.x, _12_m4, -_7) / max(_23_m14, 9.9999997473787516355514526367188e-05f), 0.0f, 1.0f);
    float _293 = clamp(((pow(max(abs(clamp(pow(max(abs(_24.Sample(_15, _4).x), 9.9999997473787516355514526367188e-05f), _23_m8), 0.0f, 1.0f) * lerp(_226, (lerp(_26.Sample(_15, _234 + _210).x, _26.Sample(_15, _234 + _217).x, _225) * _226) * 2.0f, _23_m11)), 9.9999997473787516355514526367188e-05f), _23_m12) * _23_m13) * _depth_fade_linear) * lerp(1.0f, clamp((length((_8 + _12_m6) - _12_m6) - _23_m16) / (_23_m17 - _23_m16), 0.0f, 1.0f), floor(_23_m18)), 0.0f, 1.0f);
    if ((_293 - _23_m19) < 0.0f)
    {
        discard;
    }
    float4 _313 = _27.Sample(_15, mad(_4, _23_m7, _23_m6 * _11_m0));
    float2 _331 = (((_25.Sample(_15, _188).xy + (-0.5f).xx) * 2.0f) * float2(-1.0f, 1.0f)) * _23_m9;
    float2 _332 = _331 * _209;
    float2 _337 = _331 * _216;
    float _342 = lerp(_26.Sample(_15, _182 + _332).x, _26.Sample(_15, _182 + _337).x, _225);
    float4 _345 = _26.Sample(_15, _234 + _332);
    float4 _349 = _26.Sample(_15, _234 + _337);
    float4 _569;
    do
    {
        if (_21_m19[3].z < 0.0f)
        {
            _569 = float4(0.0f, 0.0f, 0.0f, 1.0f);
            break;
        }
        float _414;
        do
        {
            if (_9 <= _21_m19[0].x)
            {
                _414 = mad(_21_m19[2].x, _9, _21_m19[3].x);
                break;
            }
            else
            {
                _414 = _21_m19[1].y * log2(mad(_21_m19[2].y, _9, _21_m19[3].y));
                break;
            }
            break; // unreachable workaround
        } while(false);
        float3 _425 = (float3(_147 / float2(_21_m32, _21_m18), _414) + float3(float(_14_m5), 0.0f, 0.0f)) - 0.5f.xxx;
        float3 _426 = floor(_425);
        float3 _427 = _425 - _426;
        float3 _428 = 1.0f.xxx - _427;
        float3 _435 = mad(-((_427 * 0.5f) * _427), 2.0f.xxx - _427, 0.666666686534881591796875f.xxx);
        float3 _442 = (_427 * 0.16666667163372039794921875f) * _427;
        float3 _444 = mad((_428 * 0.16666667163372039794921875f) * _428, _428, _435);
        float3 _451 = _21_m17 * (((_435 / _444) - 0.5f.xxx) + _426);
        float3 _455 = _21_m17 * ((((_442 * _427) / mad(_442, _427, mad(-((_428 * 0.5f) * _428), _427 + 1.0f.xxx, 0.666666686534881591796875f.xxx))) + 1.5f.xxx) + _426);
        float _463 = _451.z;
        float _469 = _455.x;
        float2 _473 = max(_21_m15, min(_21_m16, float2(_469, _451.y)));
        float _474 = _473.x;
        float4 _480 = _444.x.xxxx;
        float _482 = _451.x;
        float2 _486 = max(_21_m15, min(_21_m16, float2(_482, _455.y)));
        float _487 = _486.x;
        float4 _502 = _444.y.xxxx;
        float _507 = _455.z;
        float4 _533 = lerp(lerp(lerp(_19.SampleLevel(_20, float3(max(_21_m15, min(_21_m16, _455.xy)), _507), 0.0f), _19.SampleLevel(_20, float3(_487, _486.y, _507), 0.0f), _480), lerp(_19.SampleLevel(_20, float3(_474, _473.y, _507), 0.0f), _19.SampleLevel(_20, float3(max(_21_m15, min(_21_m16, float2(_482, _451.y))), _507), 0.0f), _480), _502), lerp(lerp(_19.SampleLevel(_20, float3(max(_21_m15, min(_21_m16, float2(_469, _455.y))), _463), 0.0f), _19.SampleLevel(_20, float3(_487, _486.y, _463), 0.0f), _480), lerp(_19.SampleLevel(_20, float3(_474, _473.y, _463), 0.0f), _19.SampleLevel(_20, float3(max(_21_m15, min(_21_m16, _451.xy)), _463), 0.0f), _480), _502), _444.z.xxxx) * float4(0.03125f, 0.03125f, 0.03125f, 3.0517578125e-05f);
        float4 _541;
        if (isinf(_533.x) || isnan(_533.x))
        {
            float4 _540 = _533;
            _540.x = 0.0f;
            _541 = _540;
        }
        else
        {
            _541 = _533;
        }
        float4 _549;
        if (isinf(_541.y) || isnan(_541.y))
        {
            float4 _548 = _541;
            _548.y = 0.0f;
            _549 = _548;
        }
        else
        {
            _549 = _541;
        }
        float4 _557;
        if (isinf(_549.z) || isnan(_549.z))
        {
            float4 _556 = _549;
            _556.z = 0.0f;
            _557 = _556;
        }
        else
        {
            _557 = _549;
        }
        float4 _565;
        if (isinf(_557.w) || isnan(_557.w))
        {
            float4 _564 = _557;
            _564.w = 0.0f;
            _565 = _564;
        }
        else
        {
            _565 = _557;
        }
        float4 _568 = _565;
        _568.w = 1.0f - _565.w;
        _569 = _568;
        break;
    } while(false);
    _10 = max(float4(mad(pow(max(abs(_29.SampleLevel(_16, float2(clamp(pow(max(abs(_28.SampleLevel(_16, float2((1.0f - _4.y) + lerp(0.0f, (_313.x + (-0.5f)) * 2.0f, 0.0199999995529651641845703125f), 0.0f), 0.0f).x * lerp(1.0f, lerp(_342, (lerp(_345.x, _349.x, _225) * _342) * 2.0f, _23_m11), _23_m21)), 9.9999997473787516355514526367188e-05f), 5.0f), 0.0f, 1.0f), 0.0f), 0.0f).xyz * _23_m20), 9.9999997473787516355514526367188e-05f.xxx), _23_m22.xxx) * float(!(_11_m1 != 0.0f)), _569.www, _569.xyz), _293 * _22_m2), 0.0f.xxxx);
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
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._10 = _10;
    return stage_output;
}

