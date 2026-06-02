#include "../common.hlsl"

[[vk::binding(0, 4)]]
cbuffer type_ctime_cb : register(b0, space4)
{
    float ctime_cb_poison_intensity : packoffset(c0);
    float ctime_cb_shocked_intensity : packoffset(c0.y);
    float ctime_cb_time : packoffset(c0.z);
    float ctime_cb_seed : packoffset(c0.w);
    float ctime_cb_phase : packoffset(c1);
    float ctime_cb_cutoff : packoffset(c1.y);
    float ctime_cb_sdr_scale : packoffset(c1.z);
};

[[vk::binding(12, 0)]]
SamplerState SamplerLinearWrapOffsetNoBias : register(s12, space0);

[[vk::binding(20, 2)]]
Texture2D<float4> tex : register(t20, space2);

[[vk::binding(21, 2)]]
Texture2D<float4> muddle_tex : register(t21, space2);

static float2 in_var_TEXCOORD0;
static float4 in_var_COLOR0;
static float4 in_var_TEXCOORD1;
static float4 out_var_SV_TARGET;

struct SPIRV_Cross_Input
{
    float2 in_var_TEXCOORD0 : TEXCOORD0;
    float4 in_var_COLOR0 : TEXCOORD1;
    float4 in_var_TEXCOORD1 : TEXCOORD2;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_TARGET : SV_Target0;
};

void frag_main()
{
    float4 _93 = tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0);
    float4 _97 = in_var_COLOR0 * lerp(1.0f.xxxx, _93, in_var_TEXCOORD1.y.xxxx);
    float3 _98 = _97.xyz;
    float3 _103 = lerp(dot(_98, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, _98, in_var_TEXCOORD1.x.xxx);
    float _106 = lerp(0.0f, 1.5f, ctime_cb_poison_intensity);
    float _107 = cos(_106);
    float3 _117 = ((_103 * _107) + (cross(0.57735002040863037109375f.xxx, _103) * sin(_106))) + ((0.57735002040863037109375f.xxx * dot(0.57735002040863037109375f.xxx, _103)) * (1.0f - _107));
    float _123 = ctime_cb_time + ctime_cb_seed;
    float2 _127 = (in_var_TEXCOORD0 * 1.0f) + float2(0.0f, _123 * 0.666666686534881591796875f);
    float2 _130 = float2(0.5f, 0.0f) + (_123 * 2.5f).xx;
    float2 _131 = frac(_130);
    float2 _84 = (floor(_130) * 2.0f) + float2(0.0f, 1.0f);
    float2 _83 = min(_131, 1.0f.xx - _131) * 2.0f;
    float _139;
    float4 _142;
    _139 = 0.0f;
    _142 = 0.0f.xxxx;
    for (int _144 = 0; _144 < 2; )
    {
        uint _148 = uint(_144);
        float3 _153 = frac(float3(_84[_148], 0.0f, 0.0f) * float3(0.103100001811981201171875f, 0.10300000011920928955078125f, 0.097300000488758087158203125f));
        float3 _158 = _153 + dot(_153, _153.yxz + 19.1900005340576171875f.xxx).xxx;
        float3 _164 = frac((_158.xxy + _158.yxx) * _158.zyx);
        float _166 = _164.x * 6.283185482025146484375f;
        float _167 = cos(_166);
        float _168 = sin(_166);
        _139 += (_83[_148] * _83[_148]);
        _142 += (muddle_tex.Sample(SamplerLinearWrapOffsetNoBias, mul(_127, float2x2(float2(_167, -_168), float2(_168, _167))) + _164.yz) * _83[_148]);
        _144++;
        continue;
    }
    float2 _194 = in_var_TEXCOORD0 + ((clamp((((_142 - 0.5f.xxxx) / sqrt(_139).xxxx) + 0.5f.xxxx).xy, 0.0f.xx, 1.0f.xx) - 0.5f.xx) * 0.579999983310699462890625f);
    float4 _202 = tex.SampleLevel(SamplerLinearWrapOffsetNoBias, float4(clamp(_194, 0.0f.xx, 1.0f.xx), 0.0f, 0.0f).xy, 0.0f) * 1.39999997615814208984375f;
    float _206 = clamp(pow(dot(_202, 1.0f.xxxx), 5.0f) * 0.0199999995529651641845703125f, 0.0f, 1.0f);
    float _216 = _202.w;
    float4 _230 = tex.Sample(SamplerLinearWrapOffsetNoBias, _194);
    float2 _240 = (_194 * 1.5f) + float2(0.0f, _123 * (-2.0f));
    float2 _243 = float2(0.5f, 0.0f) + (_123 * 1.5f).xx;
    float2 _244 = frac(_243);
    float2 _86 = (floor(_243) * 2.0f) + float2(0.0f, 1.0f);
    float2 _85 = min(_244, 1.0f.xx - _244) * 2.0f;
    float _252;
    float4 _255;
    _252 = 0.0f;
    _255 = 0.0f.xxxx;
    for (int _257 = 0; _257 < 2; )
    {
        uint _261 = uint(_257);
        float3 _266 = frac(float3(_86[_261], 0.0f, 0.0f) * float3(0.103100001811981201171875f, 0.10300000011920928955078125f, 0.097300000488758087158203125f));
        float3 _271 = _266 + dot(_266, _266.yxz + 19.1900005340576171875f.xxx).xxx;
        float3 _277 = frac((_271.xxy + _271.yxx) * _271.zyx);
        float _279 = _277.x * 6.283185482025146484375f;
        float _280 = cos(_279);
        float _281 = sin(_279);
        _252 += (_85[_261] * _85[_261]);
        _255 += (muddle_tex.Sample(SamplerLinearWrapOffsetNoBias, mul(_240, float2x2(float2(_280, -_281), float2(_281, _280))) + _277.yz) * _85[_261]);
        _257++;
        continue;
    }
    float4 _314 = ((((float4(pow(clamp(((3.0f * _206) * _206) - (((2.0f * _206) * _206) * _206), 0.0f, 1.0f).xxx, float3(0.999989986419677734375f, 0.6666622161865234375f, 0.1999996006488800048828125f)) * _216, _216) * 10.0f) * pow(clamp(_230.w - tex.SampleLevel(SamplerLinearWrapOffsetNoBias, float4(_194, 0.0f, 3.0f).xy, 3.0f).w, 0.0f, 1.0f), 0.20000000298023223876953125f)) * clamp((pow(dot(((_255 - 0.5f.xxxx) / sqrt(_252).xxxx) + 0.5f.xxxx, 1.0f.xxxx), 4.0f) * 0.100000001490116119384765625f) - 1.2999999523162841796875f, 0.0f, 1.0f).xxxx) * _93.w) * ctime_cb_shocked_intensity;
    float4 _322 = float4(_117.x, _117.y, _117.z, _97.w) + float4(_314.xyz * 1.0f, _314.w);
    out_var_SV_TARGET = ApplyUIProcessing(_322.xyz, _322.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_COLOR0 = stage_input.in_var_COLOR0;
    in_var_TEXCOORD1 = stage_input.in_var_TEXCOORD1;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_TARGET = out_var_SV_TARGET;
    return stage_output;
}
