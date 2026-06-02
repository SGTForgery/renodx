#include "../common.hlsl"

[[vk::binding(0, 4)]]
cbuffer type_ctime_cb : register(b0, space4)
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
};

[[vk::binding(12, 0)]]
SamplerState SamplerLinearWrapOffsetNoBias : register(s12, space0);

[[vk::binding(13, 0)]]
SamplerState SamplerLinearClampOffsetNoBias : register(s13, space0);

[[vk::binding(18, 2)]]
Texture2D<float4> tex : register(t18, space2);

[[vk::binding(19, 2)]]
Texture2D<float4> noise_map : register(t19, space2);

static float2 in_var_TEXCOORD0;
static float4 out_var_SV_TARGET;

struct SPIRV_Cross_Input
{
    float2 in_var_TEXCOORD0 : TEXCOORD0;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_TARGET : SV_Target0;
};

void frag_main()
{
    float2 _73 = (in_var_TEXCOORD0 - ctime_cb_centre_uv_image_size.xy) * 1.0f;
    float2 _86 = float2((atan2(_73.y, _73.x) * 0.15915493667125701904296875f) + 0.5f, length(_73) * 2.0f) + float2(0.0f, ctime_cb_time * (-0.039999999105930328369140625f));
    float2 _89 = float2(1.0f, 0.0f) * (ctime_cb_time * 0.0350000001490116119384765625f);
    float _108 = max(noise_map.SampleLevel(SamplerLinearWrapOffsetNoBias, float4(_86 + _89, 0.0f, 1.0f).xy, 1.0f).x, noise_map.SampleLevel(SamplerLinearWrapOffsetNoBias, float4((-_86) + _89, 0.0f, 1.0f).xy, 1.0f).x);
    float2 _112 = in_var_TEXCOORD0 + ((_108 - 0.5f) * 0.000899999984540045261383056640625f).xx;
    float4 _116 = tex.Sample(SamplerLinearClampOffsetNoBias, _112);
    float3 _117 = _116.xyz;
    float _130 = dot(tex.Sample(SamplerLinearClampOffsetNoBias, _112 + (-0.0003000000142492353916168212890625f).xx).xyz, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
    float _140 = dot(tex.Sample(SamplerLinearClampOffsetNoBias, _112 + float2(0.0003000000142492353916168212890625f, -0.0003000000142492353916168212890625f)).xyz, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
    float _155 = dot(tex.Sample(SamplerLinearClampOffsetNoBias, _112 + float2(-0.0003000000142492353916168212890625f, 0.0003000000142492353916168212890625f)).xyz, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
    float _165 = dot(tex.Sample(SamplerLinearClampOffsetNoBias, _112 + 0.0003000000142492353916168212890625f.xx).xyz, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f));
    float4 _185 = clamp(pow(abs(length(float2(((((_130 + (dot(tex.Sample(SamplerLinearClampOffsetNoBias, _112 + float2(-0.0003000000142492353916168212890625f, 0.0f)).xyz, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)) * 2.0f)) + _155) - _140) - (dot(tex.Sample(SamplerLinearClampOffsetNoBias, _112 + float2(0.0003000000142492353916168212890625f, 0.0f)).xyz, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)) * 2.0f)) - _165, ((((_130 + (dot(tex.Sample(SamplerLinearClampOffsetNoBias, _112 + float2(0.0f, -0.0003000000142492353916168212890625f)).xyz, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)) * 2.0f)) + _140) - _155) - (dot(tex.Sample(SamplerLinearClampOffsetNoBias, _112 + float2(0.0f, 0.0003000000142492353916168212890625f)).xyz, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)) * 2.0f)) - _165)).xxxx), 1.2999999523162841796875f.xxxx), 0.0f.xxxx, 1.0f.xxxx);
    float _188 = _185.w;
    float3 _193 = float4(_185.xyz * 2.0f.xxx, _188).xyz;
    float4 _203 = float4(lerp(dot(_117, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, _117, 0.5f.xxx), _116.w) + ((float4(lerp(dot(_193, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, _193, 0.25f.xxx), _188) * _108) * 3.0f);
    float3 _tonemapped = _203.xyz * 2.0f;

    //RenoDX:
    if (RENODX_TONE_MAP_TYPE > 0.f) {
      _tonemapped = renodx::color::bt2020::from::BT709(_tonemapped);
      _tonemapped = renodx::tonemap::neutwo::MaxChannel(
          _tonemapped, shader_injection.peak_white_nits / shader_injection.graphics_white_nits, 65.f);
      _tonemapped = renodx::color::bt709::from::BT2020(_tonemapped);
    }
    out_var_SV_TARGET = ApplyUIProcessing(_tonemapped, _203.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_TARGET = out_var_SV_TARGET;
    return stage_output;
}
