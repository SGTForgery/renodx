#include "../common.hlsl"						 

[[vk::binding(0, 9)]]					 
cbuffer type_ctime_cb : register(b0, space9)
{
    float ctime_cb_time : packoffset(c0);
    row_major float4x4 ctime_cb_transform : packoffset(c1);
    float ctime_cb_sdr_scale : packoffset(c5);
    float ctime_cb_alpha : packoffset(c5.y);
    float ctime_cb_dissolve_cutoff : packoffset(c5.z);
    float ctime_cb_brightness_percent : packoffset(c5.w);
    float ctime_cb_shine_frequency_scale : packoffset(c6);
    float ctime_cb_shine_time_scale : packoffset(c6.y);
    uint ctime_cb_mask_use_localspace_uv : packoffset(c6.z);
    float4 ctime_cb_passive_graph_size : packoffset(c7);
    float4 ctime_cb_passive_graph_ss_offset_size : packoffset(c8);
    float ctime_cb_passive_graph_zoom : packoffset(c9);
    float4 ctime_cb_glow_colour : packoffset(c10);
    float4 ctime_cb_centre_uv_image_size : packoffset(c11);
    float4 ctime_cb_icon_glow_params : packoffset(c12);
    float ctime_cb_low_shine_concentration : packoffset(c13);
    float4 ctime_cb_low_shine_colour : packoffset(c14);
    float4 ctime_cb_full_shine_colour : packoffset(c15);
    float4 ctime_cb_shockwave_info[10] : packoffset(c16);
    uint ctime_cb_num_shockaves : packoffset(c26);
    float ctime_cb_distortion_intensity : packoffset(c26.y);
    float ctime_cb_phase : packoffset(c26.z);
    int ctime_cb_random : packoffset(c26.w);
};

[[vk::binding(12, 0)]]					  
SamplerState SamplerLinearWrapOffsetNoBias : register(s12, space0);

[[vk::binding(13, 0)]]					  
SamplerState SamplerLinearClampOffsetNoBias : register(s13, space0);

[[vk::binding(0, 5)]]					  
Texture2D<float4> tex : register(t0, space5);

[[vk::binding(1, 5)]]					  
Texture2D<float4> shine_map : register(t1, space5);

[[vk::binding(2, 5)]]					  
Texture2D<float4> mask_tex : register(t2, space5);

static float2 in_var_TEXCOORD0;
static float4 in_var_COLOR0;
static float4 in_var_TEXCOORD1;
static float4 in_var_COLOR1;
static float4 in_var_TEXCOORD2;
static float4 out_var_SV_TARGET;

struct SPIRV_Cross_Input
{
    float2 in_var_TEXCOORD0 : TEXCOORD0;
    float4 in_var_COLOR0 : TEXCOORD1;
    float4 in_var_TEXCOORD1 : TEXCOORD2;
    float4 in_var_COLOR1 : TEXCOORD3;
    float4 in_var_TEXCOORD2 : TEXCOORD4;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_TARGET : SV_Target0;
};

void frag_main()
{
    float _79 = (in_var_COLOR1.z * 6.283185482025146484375f) - 3.1415927410125732421875f;
    float _81 = cos(_79);
    float _82 = sin(_79);
    float4 _90 = tex.Sample(SamplerLinearClampOffsetNoBias, in_var_TEXCOORD0);
    float2 _107;
    if (ctime_cb_mask_use_localspace_uv != 0u)
    {
        _107 = in_var_TEXCOORD1.zw;
    }
    else
    {
        _107 = in_var_TEXCOORD0;
    }
    float4 _109 = mask_tex.Sample(SamplerLinearClampOffsetNoBias, _107);
    float2 _118 = (mul(in_var_TEXCOORD2.xy, float2x2(float2(_81, -_82), float2(_82, _81))) * 110.75f) * ctime_cb_shine_frequency_scale;
    float _119 = lerp(6.0f, 1.0f, in_var_COLOR1.y);
    float2 _128 = float2(1.0f, 0.0f) * ((ctime_cb_time * ctime_cb_shine_time_scale) * lerp(0.082999996840953826904296875f, 0.119999997317790985107421875f, in_var_COLOR1.y));
    float4 _161 = lerp(ctime_cb_low_shine_colour, ctime_cb_full_shine_colour, in_var_COLOR1.y.xxxx);
    float _164 = clamp((0.800000011920928955078125f * clamp(pow(abs(max(shine_map.SampleLevel(SamplerLinearWrapOffsetNoBias, float4(_118 + _128, 0.0f, _119).xy, _119).x, shine_map.SampleLevel(SamplerLinearWrapOffsetNoBias, float4((-_118) + _128, 0.0f, _119).xy, _119).x)), lerp(ctime_cb_low_shine_concentration, lerp(0.3499999940395355224609375f, 0.589999973773956298828125f, in_var_TEXCOORD1.x), in_var_COLOR1.y)), 0.0f, 1.0f)) * in_var_COLOR1.x, 0.0f, 1.0f);
    float3 _175 = pow(clamp(((3.0f * _164) * _164) - (((2.0f * _164) * _164) * _164), 0.0f, 1.0f).xxx, 1.0f.xxx / (_161.xyz + 9.9999997473787516355514526367188e-06f.xxx));
    float4 _184 = clamp(float4(_90.xyz * in_var_TEXCOORD1.x.xxx, _90.w) + (float4(_175, _161.w) * lerp(_109.x, _109.y, in_var_TEXCOORD1.x)), 0.0f.xxxx, 1.0f.xxxx) * in_var_COLOR0;
    out_var_SV_TARGET = ApplyUIProcessing(_184.xyz, _184.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_COLOR0 = stage_input.in_var_COLOR0;
    in_var_TEXCOORD1 = stage_input.in_var_TEXCOORD1;
    in_var_COLOR1 = stage_input.in_var_COLOR1;
    in_var_TEXCOORD2 = stage_input.in_var_TEXCOORD2;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_TARGET = out_var_SV_TARGET;
    return stage_output;
}
