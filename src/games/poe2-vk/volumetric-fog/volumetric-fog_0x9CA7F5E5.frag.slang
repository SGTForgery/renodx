#include "../common.hlsl"

struct InstanceData
{
    row_major float4x4 world_transform;
    row_major float4x4 prev_world_transform;
    row_major float4x4 trail_emitter_transform;
    row_major float4x4 particle_emitter_transform;
    int4 dynamic_light_indices;
    float4 particle_emitter_pos;
    float4 dynamic_WindVector;
    float3 dynamic_PlayerTrailingGhost;
    float roof_fade;
    float start_time;
    uint object_scene_index;
    float flip_tangent;
};

struct LightInfo
{
    row_major float4x4 light_matrix;
    float4 light_position;
    float4 light_direction;
    float4 light_color;
    float4 light_type;
    float4 shadow_scale;
    float4 shadow_atlas_offset_scale;
    float4 shadow_enabled;
};

struct PointLightInfo
{
    float3 position;
    float channel_index;
    float3 direction;
    float dist_threshold;
    float3 color;
    float median_radius;
    float3 padding;
    float cutoff_radius;
};

static float _191 = 0.0f;
static float4 _196 = float4(0.0f, 0.0f, 0.0f, 0.0f);

int getBayerValue(uint idx)
{
    switch (idx)
    {
        case 0:  return 0;
        case 1:  return 8;
        case 2:  return 2;
        case 3:  return 10;
        case 4:  return 12;
        case 5:  return 4;
        case 6:  return 14;
        case 7:  return 6;
        case 8:  return 3;
        case 9:  return 11;
        case 10: return 1;
        case 11: return 9;
        case 12: return 15;
        case 13: return 7;
        case 14: return 13;
        default: return 5;
    }
}

float2 getShadowOffset(int idx)
{
    switch (idx)
    {
        case 0:  return float2(0.0f, 0.0f);
        case 1:  return float2(1.0f, 0.0f);
        case 2:  return float2(0.5f, 0.865999996662139892578125f);
        case 3:  return float2(-0.5f, 0.865999996662139892578125f);
        case 4:  return float2(-1.0f, -0.0f);
        case 5:  return float2(-0.5f, -0.865999996662139892578125f);
        default: return float2(0.5f, -0.865999996662139892578125f);
    }
}

[[vk::binding(0, 3)]]
cbuffer type_cpass_cb : register(b0, space3)
{
    row_major float4x4 cpass_cb_breach_sphere_infos : packoffset(c0);
    row_major float4x4 cpass_cb_env_map_rotation : packoffset(c4);
    row_major float4x4 cpass_cb_worldspace_view_proj : packoffset(c8);
    row_major float4x4 cpass_cb_worldspace_view_proj_inv : packoffset(c12);
    row_major float4x4 cpass_cb_last_view_projection_transform : packoffset(c16);
    row_major float4x4 cpass_cb_scene_view_projection_transform : packoffset(c20);
    row_major float4x4 cpass_cb_scene_view_projection_transform_inv : packoffset(c24);
    row_major float4x4 cpass_cb_scene_view_projection_transform_nopost : packoffset(c28);
    row_major float4x4 cpass_cb_scene_view_transform : packoffset(c32);
    row_major float4x4 cpass_cb_scene_view_transform_inv : packoffset(c36);
    row_major float4x4 cpass_cb_scene_projection_transform : packoffset(c40);
    row_major float4x4 cpass_cb_scene_projection_transform_inv : packoffset(c44);
    float4 cpass_cb_player_position : packoffset(c48);
    float4 cpass_cb_specular_cube_size : packoffset(c49);
    float4 cpass_cb_cube_brightness : packoffset(c50);
    float4 cpass_cb_water_color_terrain : packoffset(c51);
    float4 cpass_cb_water_color_open : packoffset(c52);
    float4 cpass_cb_water_wind_direction : packoffset(c53);
    float4 cpass_cb_ambient_light_color : packoffset(c54);
    float4 cpass_cb_ambient_light_dir : packoffset(c55);
    float4 cpass_cb_scene_planar_size : packoffset(c56);
    float4 cpass_cb_flood_wave_size : packoffset(c57);
    float4 cpass_cb_shoreline_coord_tex_size : packoffset(c58);
    float4 cpass_cb_heightmap_world_size : packoffset(c59);
    float4 cpass_cb_heightmap_tex_size : packoffset(c60);
    float4 cpass_cb_walkability_tex_size : packoffset(c61);
    float4 cpass_cb_blight_tex_size : packoffset(c62);
    float4 cpass_cb_azmeri_planar_minmax : packoffset(c63);
    float4 cpass_cb_affliction_pos : packoffset(c64);
    float4 cpass_cb_affliction_radii : packoffset(c65);
    float4 cpass_cb_infinite_hunger_arena_water_level : packoffset(c66);
    float4 cpass_cb_frame_resolution : packoffset(c67);
    float4 cpass_cb_frame_to_dynamic_scale : packoffset(c68);
    float4 cpass_cb_rain_fall_dir : packoffset(c69);
    float4 cpass_cb_clouds_velocity : packoffset(c70);
    float4 cpass_cb_ground_scalemove_uv : packoffset(c71);
    float4 cpass_cb_dust_color : packoffset(c72);
    float4 cpass_cb_ssf_color : packoffset(c73);
    float4 cpass_cb_fog_flowmap_tex_size : packoffset(c74);
    float4 cpass_cb_fog_flowmap_world_size : packoffset(c75);
    float4 cpass_cb_fog_flowmap_planar_aabb : packoffset(c76);
    float4 cpass_cb_river_flowmap_planar_aabb : packoffset(c77);
    float4 cpass_cb_shoreline_coord_planar_aabb : packoffset(c78);
    int4 cpass_cb_volumetric_fx_grid_size : packoffset(c79);
    float4 cpass_cb_frame_delta_time : packoffset(c80);
    float3 cpass_cb_ground_speed : packoffset(c81);
    uint cpass_cb_enable_mvec : packoffset(c81.w);
    float3 cpass_cb_ssf_layercount_thickness_turbulence : packoffset(c82);
    uint cpass_cb_scene_use_parabolic_projection : packoffset(c82.w);
    int3 cpass_cb_volumetric_fx_grid_pos : packoffset(c83);
    uint cpass_cb_use_double_sided : packoffset(c83.w);
    int3 cpass_cb_volumetric_fx_grid_emit_pos : packoffset(c84);
    uint cpass_cb_ssgi_detail : packoffset(c84.w);
    float3 cpass_cb_scene_camera_position : packoffset(c85);
    uint cpass_cb_gi_self_lighting : packoffset(c85.w);
    float3 cpass_cb_scene_camera_right_vector : packoffset(c86);
    uint cpass_cb_use_4x_scaling : packoffset(c86.w);
    float3 cpass_cb_scene_camera_up_vector : packoffset(c87);
    uint cpass_cb_specular_cube_enabled : packoffset(c87.w);
    float3 cpass_cb_scene_camera_forward_vector : packoffset(c88);
    uint cpass_cb_diffuse_cube_enabled : packoffset(c88.w);
    float2 cpass_cb_heightmap_world_pos : packoffset(c89);
    uint cpass_cb_water_debug : packoffset(c89.z);
    uint cpass_cb_water_use_downsampling : packoffset(c89.w);
    int2 cpass_cb_burn_tex_size : packoffset(c90);
    uint cpass_cb_emulated_platform : packoffset(c90.z);
    float cpass_cb_debug_overlay_strength : packoffset(c90.w);
    int2 cpass_cb_frame_size : packoffset(c91);
    float cpass_cb_scene_depth_bias_scale : packoffset(c91.z);
    float cpass_cb_indirect_light_multiplier : packoffset(c91.w);
    int2 cpass_cb_dynamic_size : packoffset(c92);
    float cpass_cb_worldspace_units_per_pixel : packoffset(c92.z);
    uint cpass_cb_frame_index : packoffset(c92.w);
    int2 cpass_cb_downscaled_dynamic_size : packoffset(c93);
    float cpass_cb_exposure : packoffset(c93.z);
    float cpass_cb_ssgi_debug : packoffset(c93.w);
    float2 cpass_cb_ssf_disperse_radius_feathering : packoffset(c94);
    float cpass_cb_ssgi_intensity : packoffset(c94.z);
    float cpass_cb_gi_env_occlusion : packoffset(c94.w);
    int2 cpass_cb_sh_atlas_size : packoffset(c95);
    int cpass_cb_base_probe_spacing : packoffset(c95.z);
    int cpass_cb_sh_probe_spacing : packoffset(c95.w);
    int2 cpass_cb_base_atlas_size : packoffset(c96);
    float cpass_cb_direct_light_env_ratio : packoffset(c96.z);
    float cpass_cb_tool_time : packoffset(c96.w);
    float2 cpass_cb_mouse_pos : packoffset(c97);
    float cpass_cb_time : packoffset(c97.z);
    int cpass_cb_pass_type : packoffset(c97.w);
    float cpass_cb_water_subsurface_scattering : packoffset(c98);
    int cpass_cb_pass_downscale : packoffset(c98.y);
    float cpass_cb_clouds_post_fade : packoffset(c98.z);
    float cpass_cb_clouds_pre_fade : packoffset(c98.w);
    float cpass_cb_water_refraction_index : packoffset(c99);
    float cpass_cb_clouds_fade_radius : packoffset(c99.y);
    float cpass_cb_clouds_sharpness : packoffset(c99.z);
    float cpass_cb_clouds_midpoint : packoffset(c99.w);
    float cpass_cb_water_reflectiveness : packoffset(c100);
    float cpass_cb_clouds_intensity : packoffset(c100.y);
    float cpass_cb_clouds_scale : packoffset(c100.z);
    float cpass_cb_rain_dist : packoffset(c100.w);
    float cpass_cb_water_caustics_mult : packoffset(c101);
    float cpass_cb_rain_amount : packoffset(c101.y);
    float cpass_cb_rain_turbulence : packoffset(c101.z);
    float cpass_cb_rain_intensity : packoffset(c101.w);
    float cpass_cb_water_wind_intensity : packoffset(c102);
    float cpass_cb_lake_mist_intensity : packoffset(c102.y);
    float cpass_cb_depth_sampler_type : packoffset(c102.z);
    float cpass_cb_flow_to_color : packoffset(c102.w);
    float cpass_cb_water_wind_speed : packoffset(c103);
    float cpass_cb_dist_to_color : packoffset(c103.y);
    float cpass_cb_sum_longitude : packoffset(c103.z);
    float cpass_cb_current_time : packoffset(c103.w);
    float cpass_cb_water_directionness : packoffset(c104);
    float cpass_cb_numerical_normal : packoffset(c104.y);
    float cpass_cb_water_height_offset : packoffset(c104.z);
    float cpass_cb_water_clarity : packoffset(c104.w);
    float cpass_cb_water_swell_intensity : packoffset(c105);
    float cpass_cb_water_dispersion : packoffset(c105.y);
    float cpass_cb_water_flow_foam : packoffset(c105.z);
    float cpass_cb_water_flow_intensity : packoffset(c105.w);
    float cpass_cb_water_swell_height : packoffset(c106);
    float cpass_cb_water_swell_period : packoffset(c106.y);
    float cpass_cb_water_swell_angle : packoffset(c106.z);
};

[[vk::binding(0, 4)]]
cbuffer type_cpipeline_cb : register(b0, space4)
{
    float4 cpipeline_cb_alpha_test_desc : packoffset(c0);
    float4 cpipeline_cb_constant4_2 : packoffset(c1);
    float4 cpipeline_cb_constant4_1 : packoffset(c2);
    float4 cpipeline_cb_constant4_0 : packoffset(c3);
    float4 cpipeline_cb_constant4_3 : packoffset(c4);
    float4 cpipeline_cb_constant4_4 : packoffset(c5);
    float2 cpipeline_cb_constant2_2 : packoffset(c6);
    uint cpipeline_cb_constant_bool_0 : packoffset(c6.z);
    float cpipeline_cb_mult_const_4 : packoffset(c6.w);
    float2 cpipeline_cb_constant2_1 : packoffset(c7);
    float cpipeline_cb_mult_const2_1 : packoffset(c7.z);
    float cpipeline_cb_mult_const_3 : packoffset(c7.w);
    float2 cpipeline_cb_constant2_5 : packoffset(c8);
    float cpipeline_cb_mult_const2_5 : packoffset(c8.z);
    float cpipeline_cb_mult_const2_3 : packoffset(c8.w);
    float2 cpipeline_cb_constant2_4 : packoffset(c9);
    float cpipeline_cb_constant1_0 : packoffset(c9.z);
    int cpipeline_cb_constantInt1_0 : packoffset(c9.w);
    float2 cpipeline_cb_constant2_3 : packoffset(c10);
    float cpipeline_cb_mult_const_0 : packoffset(c10.z);
    float cpipeline_cb_mult_const_2 : packoffset(c10.w);
    uint cpipeline_cb_frame_material_id : packoffset(c11);
};

[[vk::binding(0, 5)]]
cbuffer type_cobject_cb : register(b0, space5)
{
    uint cobject_cb_instance_count : packoffset(c0);
    uint cobject_cb_batch_size : packoffset(c0.y);
    uint cobject_cb_padding0 : packoffset(c0.z);
    uint cobject_cb_padding1 : packoffset(c0.w);
    InstanceData cobject_cb_instances[16] : packoffset(c1);
};

[[vk::binding(27, 2)]]
ByteAddressBuffer dynamic_light_infos : register(t27, space2);
[[vk::binding(28, 2)]]
ByteAddressBuffer point_light_data : register(t28, space2);
[[vk::binding(0, 0)]]
SamplerState SamplerLinearWrap : register(s0, space0);
[[vk::binding(1, 0)]]
SamplerState SamplerLinearClamp : register(s1, space0);
[[vk::binding(8, 0)]]
SamplerState SamplerLinearWrapNoBias : register(s8, space0);
[[vk::binding(15, 0)]]
SamplerComparisonState SamplerDepth : register(s15, space0);
[[vk::binding(18, 2)]]
TextureCube<float4> diffuse_cube : register(t18, space2);
[[vk::binding(19, 2)]]
TextureCube<float4> specular_cube : register(t19, space2);
[[vk::binding(20, 2)]]
Texture2D<float4> noise_sampler : register(t20, space2);
[[vk::binding(21, 2)]]
Texture2D<float4> tex_shadow_map_atlas : register(t21, space2);
[[vk::binding(22, 2)]]
Texture2D<float4> depth_sampler : register(t22, space2);
[[vk::binding(23, 2)]]
Texture2D<float4> texture_object_1 : register(t23, space2);
[[vk::binding(24, 2)]]
Texture2D<float4> texture_object_0 : register(t24, space2);
[[vk::binding(25, 2)]]
Texture2D<uint4> light_lookup : register(t25, space2);
[[vk::binding(26, 2)]]
Buffer<uint4> light_indices : register(t26, space2);

static float4 gl_FragCoord;
static uint in_var_INSTANCEID;
static float4 out_var_SV_TARGET;

struct SPIRV_Cross_Input
{
    nointerpolation uint in_var_INSTANCEID : TEXCOORD0;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_TARGET : SV_Target0;
};

void frag_main()
{
    if ((1.00100004673004150390625f - cpipeline_cb_alpha_test_desc.y) < 0.0f)
    {
        discard;
    }
    bool _217 = cpipeline_cb_constant_bool_0 != 0u;
    float _224 = _217 ? cpass_cb_ssf_disperse_radius_feathering.y : cpipeline_cb_mult_const_2;
    float2 _228 = float2(cpass_cb_ssf_disperse_radius_feathering.x * 0.100000001490116119384765625f, cpass_cb_ssf_disperse_radius_feathering.x);
    bool2 _229 = _217.xx;
    float2 _230 = float2(_229.x ? _228.x : cpipeline_cb_constant2_2.x, _229.y ? _228.y : cpipeline_cb_constant2_2.y);
    bool4 _235 = _217.xxxx;
    float4 _236 = float4(_235.x ? cpass_cb_ssf_color.x : cpipeline_cb_constant4_2.x, _235.y ? cpass_cb_ssf_color.y : cpipeline_cb_constant4_2.y, _235.z ? cpass_cb_ssf_color.z : cpipeline_cb_constant4_2.z, _235.w ? cpass_cb_ssf_color.w : cpipeline_cb_constant4_2.w);
    float4 _239 = cpass_cb_ssf_color * cpipeline_cb_constant4_1;
    float4 _242 = float4(_235.x ? _239.x : cpipeline_cb_constant4_0.x, _235.y ? _239.y : cpipeline_cb_constant4_0.y, _235.z ? _239.z : cpipeline_cb_constant4_0.z, _235.w ? _239.w : cpipeline_cb_constant4_0.w);
    float _263 = (float(getBayerValue(clamp(uint((((frac(gl_FragCoord.x * 0.25f) * 4.0f) - 0.5f) + (((frac(gl_FragCoord.y * 0.25f) * 4.0f) - 0.5f) * 4.0f)) + 0.5f), 0u, 15u))) + 0.5f) * 0.0625f;
    uint2 _282 = uint2(cpass_cb_frame_resolution.xy + 0.5f.xx) / uint(cpass_cb_pass_downscale).xx;
    float2 _290 = float2(int2((float2(_282) * cpass_cb_frame_to_dynamic_scale.xy) + 0.5f.xx));
    float2 _291 = gl_FragCoord.xy / _290;
    float4 _315 = mul(float4((_291.x * 2.0f) - 1.0f, ((1.0f - _291.y) * 2.0f) - 1.0f, depth_sampler.SampleLevel(SamplerLinearClamp, float4(_291 * (_290 / float2(int2(_282))), 0.0f, -0.5f).xy, -0.5f).x, 1.0f), cpass_cb_scene_view_projection_transform_inv);
    float _322 = _230.x;
    float _323 = _230.y;
    float3 _324 = (_315 / _315.w.xxxx).xyz - cpass_cb_scene_camera_position;
    float _325 = _324.z;
    float _332;
    if (abs(_325) > 1.0000000116860974230803549289703e-07f)
    {
        _332 = 1.0f / _325;
    }
    else
    {
        _332 = 10000000.0f;
    }
    float _337 = ((-cpipeline_cb_constant2_1.x) - cpass_cb_scene_camera_position.z) * _332;
    float _341 = ((-cpipeline_cb_constant2_1.y) - cpass_cb_scene_camera_position.z) * _332;
    int _342 = max(1, cpipeline_cb_constantInt1_0);
    float _345 = ((cpass_cb_time * cpipeline_cb_mult_const_0) * float(_342)) + 0.5f;
    int _348 = -int(floor(_345));
    float _349 = frac(_345);
    float _352 = 1.0f / float(max(1, _342));
    float _355 = abs(cpipeline_cb_constant2_1.y - cpipeline_cb_constant2_1.x) * _352;
    uint _356 = uint(_342);
    float4 _358;
    _358 = float4(0.0f, 0.0f, 0.0f, 1.0f);
    float4 _359;
    int _362;
    int _361 = 0;
    uint _363 = 0u;
    for (; _363 < _356; _358 = _359, _361 = _362, _363++)
    {
        int _368 = _361 + _348;
        float _371 = (float(_361) + _349) * _352;
        float3 _378 = cpass_cb_scene_camera_position + (_324 * clamp(lerp(_337, _341, _371), 0.0f, 1.0f));
        float3 _380 = cpass_cb_scene_camera_position + (_324 * clamp(lerp(_337, _341, _371 - _352), 0.0f, 1.0f));
        float _386 = lerp(_322, _323, _371);
        uint _389 = in_var_INSTANCEID / cobject_cb_instance_count;
        float2 _392 = _378.xy;
        float2 _394 = _392 - cobject_cb_instances[_389].dynamic_PlayerTrailingGhost.xy;
        float _403;
        if (abs(_386) > 0.0f)
        {
            _403 = length(float3(_394.x, _394.y, 0.0f.xxx.z)) / _386;
        }
        else
        {
            _403 = 0.0f;
        }
        int3 _412 = int3(0, 0, 0);
        _412.x = _368;
        uint3 _415 = (uint3(_412) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
        uint _416 = _415.y;
        uint _417 = _415.z;
        uint _420 = _415.x + (_416 * _417);
        uint _422 = _416 + (_417 * _420);
        uint3 _425 = uint3(_420, _422, _417 + (_420 * _422));
        uint3 _427 = _425 ^ (_425 >> uint3(16u, 16u, 16u));
        uint _428 = _427.y;
        uint _429 = _427.z;
        uint _432 = _427.x + (_428 * _429);
        uint _434 = _428 + (_429 * _432);
        float _451 = clamp(asfloat(((_429 + (_432 * _434)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f);
        float4 _469 = texture_object_1.Sample(SamplerLinearWrap, float3(clamp(asfloat((_432 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat((_434 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), _451).xy + ((_392 * cpipeline_cb_mult_const2_3) * 0.001000000047497451305389404296875f));
        float2 _475 = ((_469 * 2.0f) - 1.0f.xxxx).xy * cpipeline_cb_mult_const2_5;
        bool _477 = abs(cpipeline_cb_constant1_0) > 0.0f;
        float _483;
        if (_477)
        {
            _483 = _475.x / cpipeline_cb_constant1_0;
        }
        else
        {
            _483 = 0.0f;
        }
        float _489;
        if (_477)
        {
            _489 = _475.y / cpipeline_cb_constant1_0;
        }
        else
        {
            _489 = 0.0f;
        }
        float2 _501 = (cobject_cb_instances[_389].dynamic_WindVector.xy * (cobject_cb_instances[_389].dynamic_WindVector.w * cpipeline_cb_mult_const_3).xx) + (float2(_483, _489) + lerp(cpipeline_cb_constant2_4, cpipeline_cb_constant2_5, _371.xx));
        float2 _510 = (cpipeline_cb_constant2_3 * cpass_cb_time.xx) + ((_392 * cpipeline_cb_mult_const2_1) * 0.001000000047497451305389404296875f);
        float _512 = float(_368);
        float2 _515 = float2(0.5f, 0.0f) + ((_451 + (cpass_cb_time * cpipeline_cb_constant1_0)) * 0.5f).xx;
        float2 _516 = frac(_515);
        float2 _202 = _516;
        float2 _201 = (floor(_515) * 2.0f) + float2(0.0f, 1.0f);
        float2 _200 = min(_516, 1.0f.xx - _516) * 2.0f;
        float _524;
        float4 _527;
        _524 = 0.0f;
        _527 = 0.0f.xxxx;
        for (int _529 = 0; _529 < 2; )
        {
            uint _533 = uint(_529);
            float3 _538 = frac(float3(_201[_533], _512, 0.0f) * float3(0.103100001811981201171875f, 0.10300000011920928955078125f, 0.097300000488758087158203125f));
            float3 _543 = _538 + dot(_538, _538.yxz + 19.1900005340576171875f.xxx).xxx;
            float2 _557 = (frac((_543.xxy + _543.yxx) * _543.zyx).xy + _510) + (_501 * ((_202[_533] * 2.0f) - 1.0f));
            _524 += (_200[_533] * _200[_533]);
            _527 += (texture_object_0.SampleLevel(SamplerLinearWrap, float4(_557, 0.0f, 0.0f).xy, 0.0f) * _200[_533]);
            _529++;
            continue;
        }
        float4 _571 = texture_object_0.SampleLevel(SamplerLinearWrap, 0.5f.xx, 10.0f);
        float4 _581;
        _581.w = clamp(clamp(dot(((_527 - _571) / sqrt(_524).xxxx) + _571, cpipeline_cb_constant4_3), 0.0f, 1.0f) - (_224 * (1.0f - clamp(_403, 0.0f, 1.0f))), 0.0f, 1.0f);
        float4 _583 = float4(1.0f.xxx.x, 1.0f.xxx.y, 1.0f.xxx.z, _581.w) * lerp(_242, _236, _371.xxxx);
        float4 _592 = float4(_378.x, _378.y, _378.z, _196.w);
        _592.w = 1.0f;
        float4 _594 = mul(_592, cpass_cb_scene_view_projection_transform);
        float2 _600 = ((_594 / _594.w.xxxx).xy * 0.5f) + 0.5f.xx;
        uint4 _609 = uint4(cobject_cb_instances[_389].dynamic_light_indices);
        uint _610 = _609.x;
        uint _613 = uint(asfloat(dynamic_light_infos.Load(_610 * 176 + 112)));
        uint _614 = _609.y;
        uint _617 = uint(asfloat(dynamic_light_infos.Load(_614 * 176 + 112)));
        uint _618 = _609.z;
        uint _621 = uint(asfloat(dynamic_light_infos.Load(_618 * 176 + 112)));
        uint _622 = _609.w;
        uint _625 = uint(asfloat(dynamic_light_infos.Load(_622 * 176 + 112)));
        float4 _827;
        [branch]
        if (asfloat(dynamic_light_infos.Load(_610 * 176 + 160)) > 0.0f)
        {
            float4 _634 = float4(_378, 1.0f);
            float4x4 _640 = float4x4(asfloat(dynamic_light_infos.Load4(_610 * 176 + 0)), asfloat(dynamic_light_infos.Load4(_610 * 176 + 16)), asfloat(dynamic_light_infos.Load4(_610 * 176 + 32)), asfloat(dynamic_light_infos.Load4(_610 * 176 + 48)));
            bool _646 = _613 == 0u;
            float4 _647 = mul(_634, _640);
            float4 _648 = mul(float4(_380, 1.0f), _640);
            float4 _667;
            float4 _668;
            if (!_646)
            {
                float _652 = _647.z;
                float4 _659 = _647;
                _659.z = _652 - (((_652 * asfloat(dynamic_light_infos.Load4(_610 * 176 + 128)).z) + 1.0f) / _647.w);
                float _660 = _648.z;
                float4 _666 = _648;
                _666.z = _660 - (((_660 * asfloat(dynamic_light_infos.Load4(_610 * 176 + 128)).z) + 1.0f) / _648.w);
                _667 = _666;
                _668 = _659;
            }
            else
            {
                _667 = _648;
                _668 = _647;
            }
            float4 _671 = _668 / _668.w.xxxx;
            float4 _674 = _667 / _667.w.xxxx;
            float _676;
            float _679;
            _676 = 0.0f;
            _679 = 0.0f;
            float _677;
            float _680;
            for (int _681 = 0; _681 < 7; _676 = _677, _679 = _680, _681++)
            {
                float4 _690 = lerp(_671, _674, ((float(_681) + _263) * 0.14285714924335479736328125f).xxxx);
                float4 _707;
                if (_646)
                {
                    float2 _699 = _690.xy + (getShadowOffset(_681) * asfloat(dynamic_light_infos.Load4(_610 * 176 + 128)).xy);
                    _707 = float4(_699.x, _699.y, _690.z, _690.w);
                }
                else
                {
                    float2 _705 = _690.xy + (getShadowOffset(_681) * 0.0030000000260770320892333984375f);
                    _707 = float4(_705.x, _705.y, _690.z, _690.w);
                }
                _680 = _679 + tex_shadow_map_atlas.SampleCmpLevelZero(SamplerDepth, ((clamp(_707.xy, 0.0f.xx, 1.0f.xx) * asfloat(dynamic_light_infos.Load4(_610 * 176 + 144)).zw) + asfloat(dynamic_light_infos.Load4(_610 * 176 + 144)).xy).xy / _707.w.xx, _707.z / _707.w);
                _677 = _676 + 1.0f;
            }
            float _824;
            if (_646)
            {
                float _736 = smoothstep(0.0f, 1.0f, clamp(1.0f - (length(cpass_cb_player_position.xy - _634.xy) / cpass_cb_clouds_fade_radius), 0.0f, 1.0f));
                float4 _738 = transpose(_640)[2];
                float _743 = length(cpass_cb_clouds_velocity.xy);
                float3 _752;
                if (_743 > 0.100000001490116119384765625f)
                {
                    _752 = normalize(float3(cpass_cb_clouds_velocity.xy, 0.0f));
                }
                else
                {
                    _752 = float3(1.0f, 0.0f, 0.0f);
                }
                float3 _763 = _634.xyz - ((_738.xyz / _738.z.xxx) * 1000.0f);
                float _787 = clamp(noise_sampler.SampleLevel(SamplerLinearWrapNoBias, float4((float2(dot(_752, _763), dot(normalize(float3(-_752.y, _752.x, 0.0f)), _763)) + (float2(_743, 0.0f) * cpass_cb_time)) * (0.001000000047497451305389404296875f * cpass_cb_clouds_scale), 0.0f, 0.0f).xy, 0.0f).w + (_736 * cpass_cb_clouds_pre_fade), 0.0f, 1.0f);
                float _794 = 2.0f / max(0.001000000047497451305389404296875f, 1.0f - cpass_cb_clouds_sharpness);
                float _795 = _794 - 1.0f;
                float _796 = 1.0f - cpass_cb_clouds_midpoint;
                float _803 = 2.0f - _794;
                _824 = _679 * lerp(1.0f, clamp(clamp(_796 + (((-pow(clamp(1.0f - max(cpass_cb_clouds_midpoint, _787), 0.0f, 1.0f), _795)) * pow(clamp(_796, 0.0f, 1.0f), _803)) + (pow(clamp(min(cpass_cb_clouds_midpoint, _787), 0.0f, 1.0f), _795) * pow(clamp(cpass_cb_clouds_midpoint, 0.0f, 1.0f), _803))), 0.0f, 1.0f) + (_736 * cpass_cb_clouds_post_fade), 0.0f, 1.0f), cpass_cb_clouds_intensity);
            }
            else
            {
                _824 = _679;
            }
            float4 _826 = 1.0f.xxxx;
            _826.x = _824 / _676;
            _827 = _826;
        }
        else
        {
            _827 = 1.0f.xxxx;
        }
        float4 _1029;
        [branch]
        if (asfloat(dynamic_light_infos.Load(_614 * 176 + 160)) > 0.0f)
        {
            float4 _836 = float4(_378, 1.0f);
            float4x4 _842 = float4x4(asfloat(dynamic_light_infos.Load4(_614 * 176 + 0)), asfloat(dynamic_light_infos.Load4(_614 * 176 + 16)), asfloat(dynamic_light_infos.Load4(_614 * 176 + 32)), asfloat(dynamic_light_infos.Load4(_614 * 176 + 48)));
            bool _848 = _617 == 0u;
            float4 _849 = mul(_836, _842);
            float4 _850 = mul(float4(_380, 1.0f), _842);
            float4 _869;
            float4 _870;
            if (!_848)
            {
                float _854 = _849.z;
                float4 _861 = _849;
                _861.z = _854 - (((_854 * asfloat(dynamic_light_infos.Load4(_614 * 176 + 128)).z) + 1.0f) / _849.w);
                float _862 = _850.z;
                float4 _868 = _850;
                _868.z = _862 - (((_862 * asfloat(dynamic_light_infos.Load4(_614 * 176 + 128)).z) + 1.0f) / _850.w);
                _869 = _868;
                _870 = _861;
            }
            else
            {
                _869 = _850;
                _870 = _849;
            }
            float4 _873 = _870 / _870.w.xxxx;
            float4 _876 = _869 / _869.w.xxxx;
            float _878;
            float _881;
            _878 = 0.0f;
            _881 = 0.0f;
            float _879;
            float _882;
            for (int _883 = 0; _883 < 7; _878 = _879, _881 = _882, _883++)
            {
                float4 _892 = lerp(_873, _876, ((float(_883) + _263) * 0.14285714924335479736328125f).xxxx);
                float4 _909;
                if (_848)
                {
                    float2 _901 = _892.xy + (getShadowOffset(_883) * asfloat(dynamic_light_infos.Load4(_614 * 176 + 128)).xy);
                    _909 = float4(_901.x, _901.y, _892.z, _892.w);
                }
                else
                {
                    float2 _907 = _892.xy + (getShadowOffset(_883) * 0.0030000000260770320892333984375f);
                    _909 = float4(_907.x, _907.y, _892.z, _892.w);
                }
                _882 = _881 + tex_shadow_map_atlas.SampleCmpLevelZero(SamplerDepth, ((clamp(_909.xy, 0.0f.xx, 1.0f.xx) * asfloat(dynamic_light_infos.Load4(_614 * 176 + 144)).zw) + asfloat(dynamic_light_infos.Load4(_614 * 176 + 144)).xy).xy / _909.w.xx, _909.z / _909.w);
                _879 = _878 + 1.0f;
            }
            float _1026;
            if (_848)
            {
                float _938 = smoothstep(0.0f, 1.0f, clamp(1.0f - (length(cpass_cb_player_position.xy - _836.xy) / cpass_cb_clouds_fade_radius), 0.0f, 1.0f));
                float4 _940 = transpose(_842)[2];
                float _945 = length(cpass_cb_clouds_velocity.xy);
                float3 _954;
                if (_945 > 0.100000001490116119384765625f)
                {
                    _954 = normalize(float3(cpass_cb_clouds_velocity.xy, 0.0f));
                }
                else
                {
                    _954 = float3(1.0f, 0.0f, 0.0f);
                }
                float3 _965 = _836.xyz - ((_940.xyz / _940.z.xxx) * 1000.0f);
                float _989 = clamp(noise_sampler.SampleLevel(SamplerLinearWrapNoBias, float4((float2(dot(_954, _965), dot(normalize(float3(-_954.y, _954.x, 0.0f)), _965)) + (float2(_945, 0.0f) * cpass_cb_time)) * (0.001000000047497451305389404296875f * cpass_cb_clouds_scale), 0.0f, 0.0f).xy, 0.0f).w + (_938 * cpass_cb_clouds_pre_fade), 0.0f, 1.0f);
                float _996 = 2.0f / max(0.001000000047497451305389404296875f, 1.0f - cpass_cb_clouds_sharpness);
                float _997 = _996 - 1.0f;
                float _998 = 1.0f - cpass_cb_clouds_midpoint;
                float _1005 = 2.0f - _996;
                _1026 = _881 * lerp(1.0f, clamp(clamp(_998 + (((-pow(clamp(1.0f - max(cpass_cb_clouds_midpoint, _989), 0.0f, 1.0f), _997)) * pow(clamp(_998, 0.0f, 1.0f), _1005)) + (pow(clamp(min(cpass_cb_clouds_midpoint, _989), 0.0f, 1.0f), _997) * pow(clamp(cpass_cb_clouds_midpoint, 0.0f, 1.0f), _1005))), 0.0f, 1.0f) + (_938 * cpass_cb_clouds_post_fade), 0.0f, 1.0f), cpass_cb_clouds_intensity);
            }
            else
            {
                _1026 = _881;
            }
            float4 _1028 = _827;
            _1028.y = _1026 / _878;
            _1029 = _1028;
        }
        else
        {
            _1029 = _827;
        }
        float4 _1231;
        [branch]
        if (asfloat(dynamic_light_infos.Load(_618 * 176 + 160)) > 0.0f)
        {
            float4 _1038 = float4(_378, 1.0f);
            float4x4 _1044 = float4x4(asfloat(dynamic_light_infos.Load4(_618 * 176 + 0)), asfloat(dynamic_light_infos.Load4(_618 * 176 + 16)), asfloat(dynamic_light_infos.Load4(_618 * 176 + 32)), asfloat(dynamic_light_infos.Load4(_618 * 176 + 48)));
            bool _1050 = _621 == 0u;
            float4 _1051 = mul(_1038, _1044);
            float4 _1052 = mul(float4(_380, 1.0f), _1044);
            float4 _1071;
            float4 _1072;
            if (!_1050)
            {
                float _1056 = _1051.z;
                float4 _1063 = _1051;
                _1063.z = _1056 - (((_1056 * asfloat(dynamic_light_infos.Load4(_618 * 176 + 128)).z) + 1.0f) / _1051.w);
                float _1064 = _1052.z;
                float4 _1070 = _1052;
                _1070.z = _1064 - (((_1064 * asfloat(dynamic_light_infos.Load4(_618 * 176 + 128)).z) + 1.0f) / _1052.w);
                _1071 = _1070;
                _1072 = _1063;
            }
            else
            {
                _1071 = _1052;
                _1072 = _1051;
            }
            float4 _1075 = _1072 / _1072.w.xxxx;
            float4 _1078 = _1071 / _1071.w.xxxx;
            float _1080;
            float _1083;
            _1080 = 0.0f;
            _1083 = 0.0f;
            float _1081;
            float _1084;
            for (int _1085 = 0; _1085 < 7; _1080 = _1081, _1083 = _1084, _1085++)
            {
                float4 _1094 = lerp(_1075, _1078, ((float(_1085) + _263) * 0.14285714924335479736328125f).xxxx);
                float4 _1111;
                if (_1050)
                {
                    float2 _1103 = _1094.xy + (getShadowOffset(_1085) * asfloat(dynamic_light_infos.Load4(_618 * 176 + 128)).xy);
                    _1111 = float4(_1103.x, _1103.y, _1094.z, _1094.w);
                }
                else
                {
                    float2 _1109 = _1094.xy + (getShadowOffset(_1085) * 0.0030000000260770320892333984375f);
                    _1111 = float4(_1109.x, _1109.y, _1094.z, _1094.w);
                }
                _1084 = _1083 + tex_shadow_map_atlas.SampleCmpLevelZero(SamplerDepth, ((clamp(_1111.xy, 0.0f.xx, 1.0f.xx) * asfloat(dynamic_light_infos.Load4(_618 * 176 + 144)).zw) + asfloat(dynamic_light_infos.Load4(_618 * 176 + 144)).xy).xy / _1111.w.xx, _1111.z / _1111.w);
                _1081 = _1080 + 1.0f;
            }
            float _1228;
            if (_1050)
            {
                float _1140 = smoothstep(0.0f, 1.0f, clamp(1.0f - (length(cpass_cb_player_position.xy - _1038.xy) / cpass_cb_clouds_fade_radius), 0.0f, 1.0f));
                float4 _1142 = transpose(_1044)[2];
                float _1147 = length(cpass_cb_clouds_velocity.xy);
                float3 _1156;
                if (_1147 > 0.100000001490116119384765625f)
                {
                    _1156 = normalize(float3(cpass_cb_clouds_velocity.xy, 0.0f));
                }
                else
                {
                    _1156 = float3(1.0f, 0.0f, 0.0f);
                }
                float3 _1167 = _1038.xyz - ((_1142.xyz / _1142.z.xxx) * 1000.0f);
                float _1191 = clamp(noise_sampler.SampleLevel(SamplerLinearWrapNoBias, float4((float2(dot(_1156, _1167), dot(normalize(float3(-_1156.y, _1156.x, 0.0f)), _1167)) + (float2(_1147, 0.0f) * cpass_cb_time)) * (0.001000000047497451305389404296875f * cpass_cb_clouds_scale), 0.0f, 0.0f).xy, 0.0f).w + (_1140 * cpass_cb_clouds_pre_fade), 0.0f, 1.0f);
                float _1198 = 2.0f / max(0.001000000047497451305389404296875f, 1.0f - cpass_cb_clouds_sharpness);
                float _1199 = _1198 - 1.0f;
                float _1200 = 1.0f - cpass_cb_clouds_midpoint;
                float _1207 = 2.0f - _1198;
                _1228 = _1083 * lerp(1.0f, clamp(clamp(_1200 + (((-pow(clamp(1.0f - max(cpass_cb_clouds_midpoint, _1191), 0.0f, 1.0f), _1199)) * pow(clamp(_1200, 0.0f, 1.0f), _1207)) + (pow(clamp(min(cpass_cb_clouds_midpoint, _1191), 0.0f, 1.0f), _1199) * pow(clamp(cpass_cb_clouds_midpoint, 0.0f, 1.0f), _1207))), 0.0f, 1.0f) + (_1140 * cpass_cb_clouds_post_fade), 0.0f, 1.0f), cpass_cb_clouds_intensity);
            }
            else
            {
                _1228 = _1083;
            }
            float4 _1230 = _1029;
            _1230.z = _1228 / _1080;
            _1231 = _1230;
        }
        else
        {
            _1231 = _1029;
        }
        float4 _1433;
        [branch]
        if (asfloat(dynamic_light_infos.Load(_622 * 176 + 160)) > 0.0f)
        {
            float4 _1240 = float4(_378, 1.0f);
            float4x4 _1246 = float4x4(asfloat(dynamic_light_infos.Load4(_622 * 176 + 0)), asfloat(dynamic_light_infos.Load4(_622 * 176 + 16)), asfloat(dynamic_light_infos.Load4(_622 * 176 + 32)), asfloat(dynamic_light_infos.Load4(_622 * 176 + 48)));
            bool _1252 = _625 == 0u;
            float4 _1253 = mul(_1240, _1246);
            float4 _1254 = mul(float4(_380, 1.0f), _1246);
            float4 _1273;
            float4 _1274;
            if (!_1252)
            {
                float _1258 = _1253.z;
                float4 _1265 = _1253;
                _1265.z = _1258 - (((_1258 * asfloat(dynamic_light_infos.Load4(_622 * 176 + 128)).z) + 1.0f) / _1253.w);
                float _1266 = _1254.z;
                float4 _1272 = _1254;
                _1272.z = _1266 - (((_1266 * asfloat(dynamic_light_infos.Load4(_622 * 176 + 128)).z) + 1.0f) / _1254.w);
                _1273 = _1272;
                _1274 = _1265;
            }
            else
            {
                _1273 = _1254;
                _1274 = _1253;
            }
            float4 _1277 = _1274 / _1274.w.xxxx;
            float4 _1280 = _1273 / _1273.w.xxxx;
            float _1282;
            float _1285;
            _1282 = 0.0f;
            _1285 = 0.0f;
            float _1283;
            float _1286;
            for (int _1287 = 0; _1287 < 7; _1282 = _1283, _1285 = _1286, _1287++)
            {
                float4 _1296 = lerp(_1277, _1280, ((float(_1287) + _263) * 0.14285714924335479736328125f).xxxx);
                float4 _1313;
                if (_1252)
                {
                    float2 _1305 = _1296.xy + (getShadowOffset(_1287) * asfloat(dynamic_light_infos.Load4(_622 * 176 + 128)).xy);
                    _1313 = float4(_1305.x, _1305.y, _1296.z, _1296.w);
                }
                else
                {
                    float2 _1311 = _1296.xy + (getShadowOffset(_1287) * 0.0030000000260770320892333984375f);
                    _1313 = float4(_1311.x, _1311.y, _1296.z, _1296.w);
                }
                _1286 = _1285 + tex_shadow_map_atlas.SampleCmpLevelZero(SamplerDepth, ((clamp(_1313.xy, 0.0f.xx, 1.0f.xx) * asfloat(dynamic_light_infos.Load4(_622 * 176 + 144)).zw) + asfloat(dynamic_light_infos.Load4(_622 * 176 + 144)).xy).xy / _1313.w.xx, _1313.z / _1313.w);
                _1283 = _1282 + 1.0f;
            }
            float _1430;
            if (_1252)
            {
                float _1342 = smoothstep(0.0f, 1.0f, clamp(1.0f - (length(cpass_cb_player_position.xy - _1240.xy) / cpass_cb_clouds_fade_radius), 0.0f, 1.0f));
                float4 _1344 = transpose(_1246)[2];
                float _1349 = length(cpass_cb_clouds_velocity.xy);
                float3 _1358;
                if (_1349 > 0.100000001490116119384765625f)
                {
                    _1358 = normalize(float3(cpass_cb_clouds_velocity.xy, 0.0f));
                }
                else
                {
                    _1358 = float3(1.0f, 0.0f, 0.0f);
                }
                float3 _1369 = _1240.xyz - ((_1344.xyz / _1344.z.xxx) * 1000.0f);
                float _1393 = clamp(noise_sampler.SampleLevel(SamplerLinearWrapNoBias, float4((float2(dot(_1358, _1369), dot(normalize(float3(-_1358.y, _1358.x, 0.0f)), _1369)) + (float2(_1349, 0.0f) * cpass_cb_time)) * (0.001000000047497451305389404296875f * cpass_cb_clouds_scale), 0.0f, 0.0f).xy, 0.0f).w + (_1342 * cpass_cb_clouds_pre_fade), 0.0f, 1.0f);
                float _1400 = 2.0f / max(0.001000000047497451305389404296875f, 1.0f - cpass_cb_clouds_sharpness);
                float _1401 = _1400 - 1.0f;
                float _1402 = 1.0f - cpass_cb_clouds_midpoint;
                float _1409 = 2.0f - _1400;
                _1430 = _1285 * lerp(1.0f, clamp(clamp(_1402 + (((-pow(clamp(1.0f - max(cpass_cb_clouds_midpoint, _1393), 0.0f, 1.0f), _1401)) * pow(clamp(_1402, 0.0f, 1.0f), _1409)) + (pow(clamp(min(cpass_cb_clouds_midpoint, _1393), 0.0f, 1.0f), _1401) * pow(clamp(cpass_cb_clouds_midpoint, 0.0f, 1.0f), _1409))), 0.0f, 1.0f) + (_1342 * cpass_cb_clouds_post_fade), 0.0f, 1.0f), cpass_cb_clouds_intensity);
            }
            else
            {
                _1430 = _1285;
            }
            float4 _1432 = _1231;
            _1432.w = _1430 / _1282;
            _1433 = _1432;
        }
        else
        {
            _1433 = _1231;
        }
        float3 _1445;
        [branch]
        if (_613 == 0u)
        {
            _1445 = asfloat(dynamic_light_infos.Load4(_610 * 176 + 96)).xyz;
        }
        else
        {
            _1445 = 0.0f.xxx;
        }
        float3 _1470;
        [branch]
        if (_613 == 1u)
        {
            float3 _1450 = asfloat(dynamic_light_infos.Load4(_610 * 176 + 64)).xyz - _378;
            float _1451 = length(_1450);
            _1470 = asfloat(dynamic_light_infos.Load4(_610 * 176 + 96)).xyz * ((1.0f - clamp(_1451 / asfloat(dynamic_light_infos.Load4(_610 * 176 + 96)).w, 0.0f, 1.0f)) * clamp((dot(-asfloat(dynamic_light_infos.Load4(_610 * 176 + 80)).xyz, _1450 / _1451.xxx) - asfloat(dynamic_light_infos.Load4(_610 * 176 + 80)).w) / (asfloat(dynamic_light_infos.Load4(_610 * 176 + 64)).w - asfloat(dynamic_light_infos.Load4(_610 * 176 + 80)).w), 0.0f, 1.0f));
        }
        else
        {
            _1470 = _1445;
        }
        float3 _1504;
        [branch]
        if (_613 == 2u)
        {
            float _1476 = length(asfloat(dynamic_light_infos.Load4(_610 * 176 + 64)).xyz - _378);
            float _1486 = lerp(7.071068286895751953125f, 100.0f, clamp(asfloat(dynamic_light_infos.Load4(_610 * 176 + 64)).w, 0.0f, 1.0f));
            float _1491 = (_1476 / (asfloat(dynamic_light_infos.Load4(_610 * 176 + 96)).w / _1486)) + 1.0f;
            float _1492 = _1476 / (asfloat(dynamic_light_infos.Load4(_610 * 176 + 96)).w * sqrt(dot(abs(asfloat(dynamic_light_infos.Load4(_610 * 176 + 96)).xyz), 1.0f.xxx) * 2.0f));
            float _1497 = clamp(1.0f - (((_1492 * _1492) * _1492) * _1492), 0.0f, 1.0f);
            _1504 = asfloat(dynamic_light_infos.Load4(_610 * 176 + 96)).xyz * min(10.0f, (((0.199999988079071044921875f * _1486) * _1486) * (_1497 * _1497)) / (_1491 * _1491));
        }
        else
        {
            _1504 = _1470;
        }
        float3 _1517;
        [branch]
        if (_617 == 0u)
        {
            _1517 = asfloat(dynamic_light_infos.Load4(_614 * 176 + 96)).xyz;
        }
        else
        {
            _1517 = 0.0f.xxx;
        }
        float3 _1542;
        [branch]
        if (_617 == 1u)
        {
            float3 _1522 = asfloat(dynamic_light_infos.Load4(_614 * 176 + 64)).xyz - _378;
            float _1523 = length(_1522);
            _1542 = asfloat(dynamic_light_infos.Load4(_614 * 176 + 96)).xyz * ((1.0f - clamp(_1523 / asfloat(dynamic_light_infos.Load4(_614 * 176 + 96)).w, 0.0f, 1.0f)) * clamp((dot(-asfloat(dynamic_light_infos.Load4(_614 * 176 + 80)).xyz, _1522 / _1523.xxx) - asfloat(dynamic_light_infos.Load4(_614 * 176 + 80)).w) / (asfloat(dynamic_light_infos.Load4(_614 * 176 + 64)).w - asfloat(dynamic_light_infos.Load4(_614 * 176 + 80)).w), 0.0f, 1.0f));
        }
        else
        {
            _1542 = _1517;
        }
        float3 _1576;
        [branch]
        if (_617 == 2u)
        {
            float _1548 = length(asfloat(dynamic_light_infos.Load4(_614 * 176 + 64)).xyz - _378);
            float _1558 = lerp(7.071068286895751953125f, 100.0f, clamp(asfloat(dynamic_light_infos.Load4(_614 * 176 + 64)).w, 0.0f, 1.0f));
            float _1563 = (_1548 / (asfloat(dynamic_light_infos.Load4(_614 * 176 + 96)).w / _1558)) + 1.0f;
            float _1564 = _1548 / (asfloat(dynamic_light_infos.Load4(_614 * 176 + 96)).w * sqrt(dot(abs(asfloat(dynamic_light_infos.Load4(_614 * 176 + 96)).xyz), 1.0f.xxx) * 2.0f));
            float _1569 = clamp(1.0f - (((_1564 * _1564) * _1564) * _1564), 0.0f, 1.0f);
            _1576 = asfloat(dynamic_light_infos.Load4(_614 * 176 + 96)).xyz * min(10.0f, (((0.199999988079071044921875f * _1558) * _1558) * (_1569 * _1569)) / (_1563 * _1563));
        }
        else
        {
            _1576 = _1542;
        }
        float3 _1590;
        [branch]
        if (_621 == 0u)
        {
            _1590 = asfloat(dynamic_light_infos.Load4(_618 * 176 + 96)).xyz;
        }
        else
        {
            _1590 = 0.0f.xxx;
        }
        float3 _1615;
        [branch]
        if (_621 == 1u)
        {
            float3 _1595 = asfloat(dynamic_light_infos.Load4(_618 * 176 + 64)).xyz - _378;
            float _1596 = length(_1595);
            _1615 = asfloat(dynamic_light_infos.Load4(_618 * 176 + 96)).xyz * ((1.0f - clamp(_1596 / asfloat(dynamic_light_infos.Load4(_618 * 176 + 96)).w, 0.0f, 1.0f)) * clamp((dot(-asfloat(dynamic_light_infos.Load4(_618 * 176 + 80)).xyz, _1595 / _1596.xxx) - asfloat(dynamic_light_infos.Load4(_618 * 176 + 80)).w) / (asfloat(dynamic_light_infos.Load4(_618 * 176 + 64)).w - asfloat(dynamic_light_infos.Load4(_618 * 176 + 80)).w), 0.0f, 1.0f));
        }
        else
        {
            _1615 = _1590;
        }
        float3 _1649;
        [branch]
        if (_621 == 2u)
        {
            float _1621 = length(asfloat(dynamic_light_infos.Load4(_618 * 176 + 64)).xyz - _378);
            float _1631 = lerp(7.071068286895751953125f, 100.0f, clamp(asfloat(dynamic_light_infos.Load4(_618 * 176 + 64)).w, 0.0f, 1.0f));
            float _1636 = (_1621 / (asfloat(dynamic_light_infos.Load4(_618 * 176 + 96)).w / _1631)) + 1.0f;
            float _1637 = _1621 / (asfloat(dynamic_light_infos.Load4(_618 * 176 + 96)).w * sqrt(dot(abs(asfloat(dynamic_light_infos.Load4(_618 * 176 + 96)).xyz), 1.0f.xxx) * 2.0f));
            float _1642 = clamp(1.0f - (((_1637 * _1637) * _1637) * _1637), 0.0f, 1.0f);
            _1649 = asfloat(dynamic_light_infos.Load4(_618 * 176 + 96)).xyz * min(10.0f, (((0.199999988079071044921875f * _1631) * _1631) * (_1642 * _1642)) / (_1636 * _1636));
        }
        else
        {
            _1649 = _1615;
        }
        float3 _1663;
        [branch]
        if (_625 == 0u)
        {
            _1663 = asfloat(dynamic_light_infos.Load4(_622 * 176 + 96)).xyz;
        }
        else
        {
            _1663 = 0.0f.xxx;
        }
        float3 _1688;
        [branch]
        if (_625 == 1u)
        {
            float3 _1668 = asfloat(dynamic_light_infos.Load4(_622 * 176 + 64)).xyz - _378;
            float _1669 = length(_1668);
            _1688 = asfloat(dynamic_light_infos.Load4(_622 * 176 + 96)).xyz * ((1.0f - clamp(_1669 / asfloat(dynamic_light_infos.Load4(_622 * 176 + 96)).w, 0.0f, 1.0f)) * clamp((dot(-asfloat(dynamic_light_infos.Load4(_622 * 176 + 80)).xyz, _1668 / _1669.xxx) - asfloat(dynamic_light_infos.Load4(_622 * 176 + 80)).w) / (asfloat(dynamic_light_infos.Load4(_622 * 176 + 64)).w - asfloat(dynamic_light_infos.Load4(_622 * 176 + 80)).w), 0.0f, 1.0f));
        }
        else
        {
            _1688 = _1663;
        }
        float3 _1722;
        [branch]
        if (_625 == 2u)
        {
            float _1694 = length(asfloat(dynamic_light_infos.Load4(_622 * 176 + 64)).xyz - _378);
            float _1704 = lerp(7.071068286895751953125f, 100.0f, clamp(asfloat(dynamic_light_infos.Load4(_622 * 176 + 64)).w, 0.0f, 1.0f));
            float _1709 = (_1694 / (asfloat(dynamic_light_infos.Load4(_622 * 176 + 96)).w / _1704)) + 1.0f;
            float _1710 = _1694 / (asfloat(dynamic_light_infos.Load4(_622 * 176 + 96)).w * sqrt(dot(abs(asfloat(dynamic_light_infos.Load4(_622 * 176 + 96)).xyz), 1.0f.xxx) * 2.0f));
            float _1715 = clamp(1.0f - (((_1710 * _1710) * _1710) * _1710), 0.0f, 1.0f);
            _1722 = asfloat(dynamic_light_infos.Load4(_622 * 176 + 96)).xyz * min(10.0f, (((0.199999988079071044921875f * _1704) * _1704) * (_1715 * _1715)) / (_1709 * _1709));
        }
        else
        {
            _1722 = _1688;
        }
        uint4 _1734 = light_lookup.Load(int3(int3((int2(float3(_600.x, 1.0f - _600.y, _191).xy * _290) * cpass_cb_pass_downscale.xx) >> int2(6, 6), 0).xy, 0));
        uint _1735 = _1734.x;
        uint _1736 = _1734.y;
        float3 _1741;
        _1741 = 0.0f.xxx;
        uint _1739;
        float3 _1742;
        for (uint _1738 = _1735, _1743 = 0u; _1743 < _1736; _1738 = _1739, _1741 = _1742, _1743++)
        {
            _1739 = _1738 + 1u;
            uint4 _1749 = light_indices.Load(_1738);
            uint _1750 = _1749.x;
            float4 _1769;
            if (asfloat(point_light_data.Load(_1750 * 64 + 12)) > (-0.5f))
            {
                float4 _1768;
                if (asfloat(point_light_data.Load(_1750 * 64 + 12)) >= 2.5f)
                {
                    _1768 = float4(0.0f, 0.0f, 0.0f, 1.0f);
                }
                else
                {
                    float4 _1767;
                    if (asfloat(point_light_data.Load(_1750 * 64 + 12)) >= 1.5f)
                    {
                        _1767 = float4(0.0f, 0.0f, 1.0f, 0.0f);
                    }
                    else
                    {
                        bool4 _1765 = (asfloat(point_light_data.Load(_1750 * 64 + 12)) >= 0.5f).xxxx;
                        _1767 = float4(_1765.x ? float4(0.0f, 1.0f, 0.0f, 0.0f).x : float4(1.0f, 0.0f, 0.0f, 0.0f).x, _1765.y ? float4(0.0f, 1.0f, 0.0f, 0.0f).y : float4(1.0f, 0.0f, 0.0f, 0.0f).y, _1765.z ? float4(0.0f, 1.0f, 0.0f, 0.0f).z : float4(1.0f, 0.0f, 0.0f, 0.0f).z, _1765.w ? float4(0.0f, 1.0f, 0.0f, 0.0f).w : float4(1.0f, 0.0f, 0.0f, 0.0f).w);
                    }
                    _1768 = _1767;
                }
                _1769 = _1768;
            }
            else
            {
                _1769 = 0.0f.xxxx;
            }
            float _1788 = length(float4(asfloat(point_light_data.Load3(_1750 * 64 + 0)), asfloat(point_light_data.Load(_1750 * 64 + 12))).xyz - _378);
            float3 _1789 = float4(asfloat(point_light_data.Load3(_1750 * 64 + 32)), asfloat(point_light_data.Load(_1750 * 64 + 44))).xyz;
            float _1796 = lerp(7.071068286895751953125f, 100.0f, clamp(asfloat(point_light_data.Load(_1750 * 64 + 12)), 0.0f, 1.0f));
            float _1801 = (_1788 / (asfloat(point_light_data.Load(_1750 * 64 + 44)) / _1796)) + 1.0f;
            float _1802 = _1788 / (asfloat(point_light_data.Load(_1750 * 64 + 44)) * sqrt(dot(abs(_1789), 1.0f.xxx) * 2.0f));
            float _1807 = clamp(1.0f - (((_1802 * _1802) * _1802) * _1802), 0.0f, 1.0f);
            _1742 = _1741 + ((_1789 * min(10.0f, (((0.199999988079071044921875f * _1796) * _1796) * (_1807 * _1807)) / (_1801 * _1801))) * dot(1.0f.xxxx, _1769));
        }
        float _1841;
        if (_361 == 0)
        {
            _1841 = clamp(2.0f * _349, 0.0f, 1.0f);
        }
        else
        {
            _1841 = 1.0f;
        }
        float _1850;
        if (_361 == (cpipeline_cb_constantInt1_0 - 1))
        {
            _1850 = _1841 * clamp(2.0f * (1.0f - _349), 0.0f, 1.0f);
        }
        else
        {
            _1850 = _1841;
        }
        float _1854 = exp(((-(_583.w * cpipeline_cb_mult_const_4)) * _1850) * (length(_378 - _380) / _355));
        float3 _1865 = (_358.xyz * _1854) + float4((_583.xyz * (((((((_1504 * _1433.x) + (_1576 * _1433.y)) + (_1649 * _1433.z)) + (_1722 * _1433.w)) + _1741) + (((1.0f.xxx * cpass_cb_cube_brightness.x) * (diffuse_cube.SampleLevel(SamplerLinearClamp, float3(0.0f, 1.0f, 0.0f), 10.0f).xyz + specular_cube.SampleLevel(SamplerLinearClamp, float3(0.0f, 1.0f, 0.0f), 10.0f).xyz)) * cpipeline_cb_constant4_4.w)) + cpipeline_cb_constant4_4.xyz)).xyz * (1.0f - _1854), _1854).xyz;
        _359 = float4(_1865.x, _1865.y, _1865.z, _358.w);
        _359.w = _358.w * _1854;
        _362 = _361 + 1;
    }
    float _1870 = 1.0f - _358.w;
    float _1874 = max(_1870, 9.9999997473787516355514526367188e-05f);
    bool _1876 = abs(_1874) > 0.0f;
    float _1881;
    if (_1876)
    {
        _1881 = _358.x / _1874;
    }
    else
    {
        _1881 = 0.0f;
    }
    float _1886;
    if (_1876)
    {
        _1886 = _358.y / _1874;
    }
    else
    {
        _1886 = 0.0f;
    }
    float _1891;
    if (_1876)
    {
        _1891 = _358.z / _1874;
    }
    else
    {
        _1891 = 0.0f;
    }
    float3 _1892 = float3(_1881, _1886, _1891);
    float4 _1893;
    _1893.w = _1870;
    out_var_SV_TARGET = float4(_1892.x, _1892.y, _1892.z, _1893.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_INSTANCEID = stage_input.in_var_INSTANCEID;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_TARGET = out_var_SV_TARGET;
    return stage_output;
}
