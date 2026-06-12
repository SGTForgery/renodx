#include "../common.hlsl"

[[vk::binding(0, 9)]]
cbuffer type_ctime_cb : register(b0, space9)
{
    float ctime_cb_start : packoffset(c0);
    float ctime_cb_end : packoffset(c0.y);
    float ctime_cb_alpha : packoffset(c0.z);
    float ctime_cb_saturation : packoffset(c0.w);
    float4 ctime_cb_edge_colour : packoffset(c1);
    float4 ctime_cb_rot_point_offset : packoffset(c2);
    float ctime_cb_sdr_scale : packoffset(c3);
};

[[vk::binding(12, 0)]]
SamplerState SamplerLinearWrapOffsetNoBias : register(s12, space0);

[[vk::binding(0, 5)]]
Texture2D<float4> tex : register(t0, space5);

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
    float4 _54 = tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0);
    float _59 = (in_var_TEXCOORD1.z - 0.5f) + ctime_cb_rot_point_offset.x;
    float _64 = (in_var_TEXCOORD1.w - 0.5f) + ctime_cb_rot_point_offset.y;
    float _70 = float(int(sign(_59))) * max(abs(_59), 0.001000000047497451305389404296875f);
    float _76 = float(int(sign(_64))) * max(abs(_64), 0.001000000047497451305389404296875f);
    float _79 = sin(ctime_cb_start);
    float _80 = cos(ctime_cb_start);
    float _83 = (_70 * _80) - (_76 * _79);
    float _86 = (_76 * _80) + (_70 * _79);
    float _89 = atan2(_83, _86) + 3.1415927410125732421875f;
    float _92 = _89 - (step(6.283185482025146484375f, _89) * 6.283185482025146484375f);
    float _96 = ctime_cb_end - ctime_cb_start;
    float _97 = step(_96, _92);
    float _103 = 0.00999999977648258209228515625f + (0.100000001490116119384765625f * (1.0f - clamp(length(float2(_83, _86)), 0.0f, 1.0f)));
    float _108 = max(step(_92, _103), step(_96 - _92, _103) - _97);
    float4 _113 = (ctime_cb_edge_colour * _108) * _54.w;
    float4 _119 = clamp(_113 + (_54 * (1.0f - (_113.w * _108))), 0.0f.xxxx, 1.0f.xxxx);
    float4 _130 = ((in_var_COLOR0 * (_119 * (float4(ctime_cb_saturation, ctime_cb_saturation, ctime_cb_saturation, 1.0f) * _119.w))) * ctime_cb_alpha) * (step(-0.001000000047497451305389404296875f, _92) - _97);
    out_var_SV_TARGET = ApplyUIProcessing(_130.xyz, _130.w);
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
