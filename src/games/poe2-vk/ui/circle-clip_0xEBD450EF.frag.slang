#include "../common.hlsl"

[[vk::binding(0, 4)]]
cbuffer type_ctime_cb : register(b0, space4)
{
    float ctime_cb_sdr_scale : packoffset(c0);
    float ctime_cb_clip_radius : packoffset(c0.y);
};

[[vk::binding(12, 0)]]
SamplerState SamplerLinearWrapOffsetNoBias : register(s12, space0);

[[vk::binding(20, 2)]]
Texture2D<float4> tex : register(t20, space2);

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
    float4 _52 = in_var_COLOR0 * lerp(1.0f.xxxx, tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0), in_var_TEXCOORD1.y.xxxx);
    float3 _53 = _52.xyz;
    float3 _58 = lerp(dot(_53, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, _53, in_var_TEXCOORD1.x.xxx);
    float4 _59 = float4(_58.x, _58.y, _58.z, _52.w);
    bool4 _71 = (sqrt(pow(in_var_TEXCOORD0.x - 0.5f, 2.0f) + pow(in_var_TEXCOORD0.y - 0.5f, 2.0f)) > ctime_cb_clip_radius).xxxx;
    float4 _72 = float4(_71.x ? 0.0f.xxxx.x : _59.x, _71.y ? 0.0f.xxxx.y : _59.y, _71.z ? 0.0f.xxxx.z : _59.z, _71.w ? 0.0f.xxxx.w : _59.w);
    out_var_SV_TARGET = ApplyUIProcessing(_72.xyz, _72.w);
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
