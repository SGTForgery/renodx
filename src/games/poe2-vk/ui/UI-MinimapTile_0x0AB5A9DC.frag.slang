#include "../common.hlsl"

[[vk::binding(0, 4)]]
cbuffer type_cminimap_vertex_transform_cb : register(b0, space4)
{
    float4 cminimap_vertex_transform_cb_x_basis : packoffset(c0);
    float4 cminimap_vertex_transform_cb_y_basis : packoffset(c1);
    float4 cminimap_vertex_transform_cb_z_basis : packoffset(c2);
    float4 cminimap_vertex_transform_cb_tiles_count : packoffset(c3);
    float cminimap_vertex_transform_cb_tile_world_size : packoffset(c4);
    float cminimap_vertex_transform_cb_sdr_scale : packoffset(c4.y);
    float4 cminimap_vertex_transform_cb_render_circle : packoffset(c5);
    float cminimap_vertex_transform_cb_subgraph_index : packoffset(c6);
    float4 cminimap_vertex_transform_cb_decay_map_minmax : packoffset(c7);
    float4 cminimap_vertex_transform_cb_decay_map_size : packoffset(c8);
    float4 cminimap_vertex_transform_cb_stabiliser_position : packoffset(c9);
    float cminimap_vertex_transform_cb_decay_map_time : packoffset(c10);
    float cminimap_vertex_transform_cb_creation_time : packoffset(c10.y);
    float cminimap_vertex_transform_cb_global_stability : packoffset(c10.z);
    float cminimap_vertex_transform_cb_alpha_override : packoffset(c10.w);
    float cminimap_vertex_transform_cb_ignore_visibility : packoffset(c11);
    float4 cminimap_vertex_transform_cb_poi_position : packoffset(c12);
    float4 cminimap_vertex_transform_cb_royale_damage_circle : packoffset(c13);
    float4 cminimap_vertex_transform_cb_royale_safe_circle : packoffset(c14);
};

[[vk::binding(13, 0)]]
SamplerState SamplerLinearClampOffsetNoBias : register(s13, space0);

[[vk::binding(19, 2)]]
Texture2D<float4> tilemap_sampler : register(t19, space2);

[[vk::binding(20, 2)]]
Texture2D<float4> visibility_sampler : register(t20, space2);

static float4 gl_FragCoord;
static float2 in_var_TEXCOORD1;
static float in_var_TEXCOORD3;
static float4 out_var_SV_TARGET;

struct SPIRV_Cross_Input
{
    float2 in_var_TEXCOORD1 : TEXCOORD0;
    float in_var_TEXCOORD3 : TEXCOORD2;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_TARGET : SV_Target0;
};

void frag_main()
{
    bool _54;
    if (in_var_TEXCOORD3 >= 0.0f)
    {
        _54 = in_var_TEXCOORD3 != cminimap_vertex_transform_cb_subgraph_index;
    }
    else
    {
        _54 = false;
    }
    if (_54)
    {
        discard;
    }
    if (length(gl_FragCoord.xy - cminimap_vertex_transform_cb_render_circle.xy) > cminimap_vertex_transform_cb_render_circle.z)
    {
        discard;
    }
    float4 _71 = tilemap_sampler.Sample(SamplerLinearClampOffsetNoBias, in_var_TEXCOORD1);
    float _alpha = _71.w * (lerp(clamp(visibility_sampler.Sample(SamplerLinearClampOffsetNoBias, frac(cminimap_vertex_transform_cb_poi_position.xy / cminimap_vertex_transform_cb_tiles_count.xy)).x * 2.0f, 0.0f, 1.0f), 1.0f, cminimap_vertex_transform_cb_ignore_visibility) * cminimap_vertex_transform_cb_alpha_override);
    out_var_SV_TARGET = ApplyUIProcessing(_71.xyz, _alpha);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD1 = stage_input.in_var_TEXCOORD1;
    in_var_TEXCOORD3 = stage_input.in_var_TEXCOORD3;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_TARGET = out_var_SV_TARGET;
    return stage_output;
}
