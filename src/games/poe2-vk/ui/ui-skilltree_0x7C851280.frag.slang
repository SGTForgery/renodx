#include "../common.hlsl"

[[vk::binding(0, 4)]]
cbuffer type_ctime_cb : register(b0, space4)
{
    float ctime_cb_time : packoffset(c0);
    float ctime_cb_sdr_scale : packoffset(c0.y);
    row_major float4x4 ctime_cb_transform : packoffset(c1);
    float ctime_cb_seed : packoffset(c5);
    float ctime_cb_effect_phase : packoffset(c5.y);
    float ctime_cb_to_base_resolution_multiplier : packoffset(c5.z);
    float ctime_cb_has_mask : packoffset(c5.w);
    float ctime_cb_has_background : packoffset(c6);
    float ctime_cb_is_div_card : packoffset(c6.y);
    float ctime_cb_line_height : packoffset(c6.z);
    float4 ctime_cb_aspect_ratio : packoffset(c7);
    float4 ctime_cb_tex_scale : packoffset(c8);
    float ctime_cb_muddle_frequency : packoffset(c9);
    float4 ctime_cb_muddle_intensity : packoffset(c10);
    float4 ctime_cb_tex_clamp : packoffset(c11);
    float4 ctime_cb_effect_params : packoffset(c12);
    float ctime_cb_shader_type : packoffset(c13);
    float ctime_cb_layers_count : packoffset(c13.y);
    float4 ctime_cb_item_size : packoffset(c14);
    float4 ctime_cb_flash_glow_color : packoffset(c15);
    float4 ctime_cb_hellscape_params : packoffset(c16);
    int ctime_cb_mask_width : packoffset(c17);
    int ctime_cb_mask_height : packoffset(c17.y);
    int ctime_cb_displacement : packoffset(c17.z);
    int ctime_cb_x_displacement : packoffset(c17.w);
    int ctime_cb_y_displacement : packoffset(c18);
    uint ctime_cb_outline : packoffset(c18.y);
    float ctime_cb_outline_max : packoffset(c18.z);
    float ctime_cb_outline_min : packoffset(c18.w);
    float4 ctime_cb_outline_colour : packoffset(c19);
    uint ctime_cb_glow : packoffset(c20);
    float4 ctime_cb_glow_info : packoffset(c21);
    float4 ctime_cb_glow_colour : packoffset(c22);
    float4 ctime_cb_layer_0_speed : packoffset(c23);
    float4 ctime_cb_layer_1_speed : packoffset(c24);
    float4 ctime_cb_layer_2_speed : packoffset(c25);
    float4 ctime_cb_layer_3_speed : packoffset(c26);
    float4 ctime_cb_tex_offset : packoffset(c27);
    uint ctime_cb_poisoned : packoffset(c28);
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
    float4 _49 = in_var_COLOR0 * lerp(1.0f.xxxx, tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0), in_var_TEXCOORD1.y.xxxx);
    float3 _50 = _49.xyz;
    float3 _ui_color = lerp(dot(_50, float3(0.300000011920928955078125f, 0.589999973773956298828125f, 0.10999999940395355224609375f)).xxx, _50, in_var_TEXCOORD1.x.xxx).xyz;
    out_var_SV_TARGET = ApplyUIProcessing(_ui_color, _49.w);
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
