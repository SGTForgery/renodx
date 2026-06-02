#version 450
#extension GL_EXT_spirv_intrinsics : require
#extension GL_EXT_samplerless_texture_functions : require
#if defined(GL_EXT_control_flow_attributes)
#extension GL_EXT_control_flow_attributes : require
#define SPIRV_CROSS_FLATTEN [[flatten]]
#define SPIRV_CROSS_BRANCH [[dont_flatten]]
#define SPIRV_CROSS_UNROLL [[unroll]]
#define SPIRV_CROSS_LOOP [[dont_unroll]]
#else
#define SPIRV_CROSS_FLATTEN
#define SPIRV_CROSS_BRANCH
#define SPIRV_CROSS_UNROLL
#define SPIRV_CROSS_LOOP
#endif

struct spline5
{
    vec4 segment_polynom[4];
    vec4 time_variance;
};

struct InstanceData
{
    mat4 world_transform;
    mat4 prev_world_transform;
    ivec4 dynamic_light_indices;
    ivec4 animation_matrices_indices;
    ivec4 prev_animation_matrices_indices;
    ivec4 gpu_particle_mesh_emitter_data;
    vec2 gpu_particles_duration;
    uint tile_ground_specular_metal;
    uint tile_ground_albedo_opaque;
    ivec2 synced_random_seed;
    uint tile_ground_normal_swizzle;
    float gpu_particle_burst;
    vec2 tile_ground_tiling;
    float gpu_particle_seed;
    uint gpu_particle_count;
    float start_time;
    uint gpu_particle_culling_priority;
    uint gpu_particle_pass_count;
    uint gpu_particle_emitter_id;
    float flip_tangent;
    uint gpu_particle_emitter;
    float roof_fade;
    uint object_scene_index;
};

struct LightInfo
{
    mat4 light_matrix;
    vec4 light_position;
    vec4 light_direction;
    vec4 light_color;
    vec4 light_type;
    vec4 shadow_scale;
    vec4 shadow_atlas_offset_scale;
    vec4 shadow_enabled;
};

struct PointLightInfo
{
    vec3 position;
    float channel_index;
    vec3 direction;
    float dist_threshold;
    vec3 color;
    float median_radius;
    vec3 padding;
    float cutoff_radius;
};

struct LUTData
{
    uint value[64];
};

struct ParticleData
{
    uvec2 color;
    uint size_mass;
    uint emitter_uid;
    vec3 pos;
    float phase;
    vec3 scale;
    uint bone_frac;
    uvec2 velocity;
    float custom_data;
    uint kinematic_velocity;
    uvec2 angular_velocity;
    uint spawn_uvs;
    uint emitter_phase;
    uvec2 uniform_scale;
    uvec2 along_direction;
    vec4 rotation;
};

struct ParticleEmitterData
{
    vec3 scale;
    float emitter_duration;
    vec3 last_scale;
    uint dead_time;
    vec3 inverse_scale;
    uint lock_flags;
    vec3 last_inverse_scale;
    uint speed_factor;
    vec4 rotation;
    vec4 last_rotation;
    vec3 translation;
    float time;
    vec3 last_translation;
    float prev_time;
    uint culling_aggression;
    uint bones;
    uint culling_tag;
    uint particles_start;
    uvec2 custom_data_a;
    uvec2 custom_data_b;
};

const ivec2 _288[4] = ivec2[](ivec2(0), ivec2(1, 0), ivec2(0, 1), ivec2(1));
float _300;
vec4 _301;
float _308;
vec4 _309;

layout(set = 3, binding = 0, std140) uniform type_cpass_cb
{
    mat4 breach_sphere_infos;
    mat4 env_map_rotation;
    mat4 worldspace_view_proj;
    mat4 worldspace_view_proj_inv;
    mat4 last_view_projection_transform;
    mat4 scene_view_projection_transform;
    mat4 scene_view_projection_transform_inv;
    mat4 scene_view_projection_transform_nopost;
    mat4 scene_view_transform;
    mat4 scene_view_transform_inv;
    mat4 scene_projection_transform;
    mat4 scene_projection_transform_inv;
    vec4 player_position;
    vec4 specular_cube_size;
    vec4 cube_brightness;
    vec4 water_color_terrain;
    vec4 water_color_open;
    vec4 water_wind_direction;
    vec4 ambient_light_color;
    vec4 ambient_light_dir;
    vec4 scene_planar_size;
    vec4 flood_wave_size;
    vec4 shoreline_coord_tex_size;
    vec4 heightmap_world_size;
    vec4 heightmap_tex_size;
    vec4 walkability_tex_size;
    vec4 blight_tex_size;
    vec4 azmeri_planar_minmax;
    vec4 affliction_pos;
    vec4 affliction_radii;
    vec4 infinite_hunger_arena_water_level;
    vec4 frame_resolution;
    vec4 frame_to_dynamic_scale;
    vec4 rain_fall_dir;
    vec4 clouds_velocity;
    vec4 ground_scalemove_uv;
    vec4 dust_color;
    vec4 ssf_color;
    vec4 fog_flowmap_tex_size;
    vec4 fog_flowmap_world_size;
    vec4 fog_flowmap_planar_aabb;
    vec4 river_flowmap_planar_aabb;
    vec4 shoreline_coord_planar_aabb;
    ivec4 volumetric_fx_grid_size;
    vec4 frame_delta_time;
    vec3 ground_speed;
    uint enable_mvec;
    vec3 ssf_layercount_thickness_turbulence;
    uint scene_use_parabolic_projection;
    ivec3 volumetric_fx_grid_pos;
    uint use_double_sided;
    ivec3 volumetric_fx_grid_emit_pos;
    uint ssgi_detail;
    vec3 scene_camera_position;
    uint gi_self_lighting;
    vec3 scene_camera_right_vector;
    uint use_4x_scaling;
    vec3 scene_camera_up_vector;
    uint specular_cube_enabled;
    vec3 scene_camera_forward_vector;
    uint diffuse_cube_enabled;
    vec2 heightmap_world_pos;
    uint water_debug;
    uint water_use_downsampling;
    ivec2 burn_tex_size;
    uint emulated_platform;
    float debug_overlay_strength;
    ivec2 frame_size;
    float scene_depth_bias_scale;
    float indirect_light_multiplier;
    ivec2 dynamic_size;
    float worldspace_units_per_pixel;
    uint frame_index;
    ivec2 downscaled_dynamic_size;
    float exposure;
    float ssgi_debug;
    vec2 ssf_disperse_radius_feathering;
    float ssgi_intensity;
    float gi_env_occlusion;
    ivec2 sh_atlas_size;
    int base_probe_spacing;
    int sh_probe_spacing;
    ivec2 base_atlas_size;
    float direct_light_env_ratio;
    float tool_time;
    vec2 mouse_pos;
    float time;
    int pass_type;
    float water_subsurface_scattering;
    int pass_downscale;
    float clouds_post_fade;
    float clouds_pre_fade;
    float water_refraction_index;
    float clouds_fade_radius;
    float clouds_sharpness;
    float clouds_midpoint;
    float water_reflectiveness;
    float clouds_intensity;
    float clouds_scale;
    float rain_dist;
    float water_caustics_mult;
    float rain_amount;
    float rain_turbulence;
    float rain_intensity;
    float water_wind_intensity;
    float lake_mist_intensity;
    float depth_sampler_type;
    float flow_to_color;
    float water_wind_speed;
    float dist_to_color;
    float sum_longitude;
    float current_time;
    float water_directionness;
    float numerical_normal;
    float water_height_offset;
    float water_clarity;
    float water_swell_intensity;
    float water_dispersion;
    float water_flow_foam;
    float water_flow_intensity;
    float water_swell_height;
    float water_swell_period;
    float water_swell_angle;
} cpass_cb;

layout(set = 4, binding = 0, std140) uniform type_cpipeline_cb
{
    spline5 constant_track5_0;
    spline5 constant_track5_1;
    spline5 constant_track5_4;
    spline5 constant_track5_2;
    spline5 constant_track5_5;
    vec4 alpha_test_desc;
    ivec4 constant_trackC_0;
    vec2 constant2_4;
    uint constant_bool_4;
    uint constant_bool_5;
    vec2 constant2_3;
    uint constant_bool_2;
    uint constant_bool_3;
    vec2 constant2_2;
    uint constant_bool_1;
    uint constant_bool_0;
    vec2 constant2_1;
    uint gpu_particle_dyn_culling;
    float constant1_0;
    vec2 maya_scale_pivot_0;
    float constant1_1;
    float constant1_2;
    vec2 constant2_13;
    float constant1_14;
    uint constantUInt1_122;
    vec2 constant2_10;
    float constant1_12;
    int constant_trackG_4;
    vec2 constant2_9;
    float constant1_11;
    float constant1_10;
    vec2 constant2_8;
    int constant_trackG_3;
    float constant1_9;
    vec2 constant2_12;
    int constant_trackG_2;
    int constant_trackG_1;
    vec2 constant2_11;
    int constant_trackG_0;
    float brightness_0;
    vec2 constant2_7;
    float saturation_0;
    float hue_0;
    vec2 constant2_6;
    float constant_pixel_3;
    uint constantUInt1_7;
    vec2 constant2_21;
    uint constantUInt1_6;
    float constant1_4;
    vec2 constant2_18;
    uint constantUInt1_4;
    uint constantUInt1_2;
    vec2 constant2_17;
    uint constantUInt1_0;
    uint frame_material_id;
    vec2 constant2_16;
    vec2 constant2_14;
    vec2 constant2_20;
    vec2 constant2_15;
    vec2 constant2_19;
} cpipeline_cb;

layout(set = 5, binding = 0, std140) uniform type_cobject_cb
{
    uint instance_count;
    uint batch_size;
    uint padding0;
    uint padding1;
    InstanceData instances[16];
} cobject_cb;

layout(set = 2, binding = 46, std430) readonly buffer type_StructuredBuffer_LightInfo
{
    LightInfo _m0[];
} dynamic_light_infos;

layout(set = 2, binding = 47, std430) readonly buffer type_StructuredBuffer_PointLightInfo
{
    PointLightInfo _m0[];
} point_light_infos;

layout(set = 2, binding = 48, std430) readonly buffer type_StructuredBuffer_LUTData
{
    LUTData _m0[];
} spline_lut;

layout(set = 2, binding = 49, std430) readonly buffer type_StructuredBuffer_ParticleData
{
    ParticleData _m0[];
} particles_data;

layout(set = 2, binding = 50, std430) readonly buffer type_StructuredBuffer_ParticleEmitterData
{
    ParticleEmitterData _m0[];
} particles_emitter_data;

layout(set = 0, binding = 0) uniform sampler SamplerLinearWrap;
layout(set = 0, binding = 1) uniform sampler SamplerLinearClamp;
layout(set = 0, binding = 7) uniform sampler SamplerDynamicWrap;
layout(set = 0, binding = 8) uniform sampler SamplerLinearWrapNoBias;
layout(set = 0, binding = 9) uniform sampler SamplerLinearClampNoBias;
layout(set = 0, binding = 15) uniform samplerShadow SamplerDepth;
layout(set = 2, binding = 33) uniform textureCube diffuse_cube;
layout(set = 2, binding = 34) uniform textureCube specular_cube;
layout(set = 2, binding = 35) uniform texture2D environment_ggx_sampler;
layout(set = 2, binding = 36) uniform texture2D ambient_light_tex;
layout(set = 2, binding = 37) uniform texture2D screenspace_shadowmap;
layout(set = 2, binding = 38) uniform texture2D noise_sampler;
layout(set = 2, binding = 39) uniform texture2D tex_shadow_map_atlas;
layout(set = 2, binding = 40) uniform texture2D depth_sampler;
layout(set = 2, binding = 41) uniform texture2D texture_object_0;
layout(set = 2, binding = 42) uniform texture2D input_texture_0;
layout(set = 2, binding = 43) uniform texture2D tile_ground_normal_texture;
layout(set = 2, binding = 44) uniform utexture2D light_lookup;
layout(set = 2, binding = 45) uniform usamplerBuffer light_indices;

layout(location = 0) flat in uint in_var_AUTO_EFMAIHMN_BABABNNF;
layout(location = 1) in vec4 in_var_AUTO_NHPEAEOB_ANHFJCCP;
layout(location = 2) in vec2 in_var_AUTO_CELDJDLE_GEBKIEDD;
layout(location = 4) in float in_var_AUTO_PIPJIEKO_CIFEPFLO;
layout(location = 5) in float in_var_AUTO_PIPJIEKO_IINFNGPI;
layout(location = 6) in float in_var_AUTO_PIPJIEKO_EIDIDJP;
layout(location = 7) in float in_var_AUTO_PIPJIEKO_LDBDDLHP;
layout(location = 8) in vec3 in_var_AUTO_CEOBGMGP_GEBKIEDD;
layout(location = 11) flat in uint in_var_INSTANCEID;
layout(location = 12) in vec4 in_var_TEXCOORD0;
layout(location = 13) in vec2 in_var_TEXCOORD1;
layout(location = 14) in vec3 in_var_TEXCOORD5;
layout(location = 15) in vec3 in_var_TEXCOORD6;
layout(location = 16) in vec3 in_var_TEXCOORD7;
layout(location = 0) out vec4 out_var_SV_TARGET;
layout(location = 2) out vec4 out_var_SV_TARGET2;
layout(location = 1) out vec4 out_var_SV_TARGET1;

spirv_instruction(set = "GLSL.std.450", id = 79) float spvNMin(float, float);
spirv_instruction(set = "GLSL.std.450", id = 79) vec2 spvNMin(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 79) vec3 spvNMin(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 79) vec4 spvNMin(vec4, vec4);
spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec2 _347 = unpackHalf2x16((particles_data._m0[in_var_AUTO_EFMAIHMN_BABABNNF].angular_velocity.y >> 16u) & 65535u);
    float _348 = _347.x;
    vec2 _354 = vec2(cpipeline_cb.maya_scale_pivot_0.x, 1.0 - cpipeline_cb.maya_scale_pivot_0.y);
    vec2 _372 = (((in_var_TEXCOORD1 - _354) * vec2(1.0, 0.5)) + _354) + (vec2((cpipeline_cb.constant_bool_1 != 0u) ? pow(spvNMax(abs(in_var_AUTO_NHPEAEOB_ANHFJCCP.w), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_4) : cpass_cb.time) * vec2(0.0, -0.0500000007450580596923828125));
    mat3 _373 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _387 = ((vec2(textureLod(sampler2D(texture_object_0, SamplerDynamicWrap), vec4(_372, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _388 = vec3(_387.x, _387.y, vec3(0.0).z);
    vec2 _389 = _387.xy;
    _388.z = sqrt(spvNMax(1.0 - dot(_389, _389), 0.0));
    vec3 _395 = _373 * _388;
    vec4 _401 = texture(sampler2D(texture_object_0, SamplerDynamicWrap), _372);
    float _402 = _401.z;
    vec3 _407 = vec3(pow(spvNMax(abs(_402), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_395 / vec3(length(_395) + 1.0000000116860974230803549289703e-07));
    vec4 _410 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _372);
    vec3 _411 = _410.xyz;
    vec3 _413 = vec3(_410.w);
    vec3 _415 = clamp(mix(_411, vec3(0.0), _413), vec3(0.0), vec3(1.0));
    vec2 _421 = ((vec2(_401.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _422 = vec3(_421.x, _421.y, vec3(0.0).z);
    vec2 _423 = _421.xy;
    _422.z = sqrt(spvNMax(1.0 - dot(_423, _423), 0.0));
    float _429 = _401.w;
    float _438 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _439 = cos(_438);
    vec3 _454 = (((_411 * _439) + (cross(vec3(0.57735002040863037109375), _411) * sin(_438))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _411)) * (1.0 - _439))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _462 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_454, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _454, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _413), vec3(0.0), vec3(1.0));
    bool _465 = cpipeline_cb.constant_trackG_0 < 0;
    float _467 = clamp(_402, 0.0, 1.0) * 127.0;
    int _471 = int(spvNMax(trunc(_467), 0.0) + 0.5);
    int _476 = int(spvNMin(trunc(_467 + 1.0), 127.0) + 0.5);
    float _494;
    if (_465)
    {
        _494 = 0.0;
    }
    else
    {
        uint _480 = uint(cpipeline_cb.constant_trackG_0);
        int _481 = _471 / 2;
        _494 = ((_471 - 2 * (_471 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_480].value[_481] & 65535u).x : unpackHalf2x16((spline_lut._m0[_480].value[_481] >> 16u) & 65535u).x;
    }
    float _512;
    if (_465)
    {
        _512 = 0.0;
    }
    else
    {
        uint _498 = uint(cpipeline_cb.constant_trackG_0);
        int _499 = _476 / 2;
        _512 = ((_476 - 2 * (_476 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_498].value[_499] & 65535u).x : unpackHalf2x16((spline_lut._m0[_498].value[_499] >> 16u) & 65535u).x;
    }
    float _513 = fract(_467);
    bool _519 = cpipeline_cb.constant_trackG_1 < 0;
    float _537;
    if (_519)
    {
        _537 = 0.0;
    }
    else
    {
        uint _523 = uint(cpipeline_cb.constant_trackG_1);
        int _524 = _471 / 2;
        _537 = ((_471 - 2 * (_471 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_523].value[_524] & 65535u).x : unpackHalf2x16((spline_lut._m0[_523].value[_524] >> 16u) & 65535u).x;
    }
    float _555;
    if (_519)
    {
        _555 = 0.0;
    }
    else
    {
        uint _541 = uint(cpipeline_cb.constant_trackG_1);
        int _542 = _476 / 2;
        _555 = ((_476 - 2 * (_476 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_541].value[_542] & 65535u).x : unpackHalf2x16((spline_lut._m0[_541].value[_542] >> 16u) & 65535u).x;
    }
    float _564 = clamp((spvNMax(vec3(mix(_494, _512, _513), _308, _308), vec3(0.0)) + spvNMax(vec3(mix(_537, _555, _513), _308, _308), vec3(0.0))).x, 0.0, 1.0) * 127.0;
    int _569 = int(spvNMax(trunc(_564), 0.0) + 0.5);
    int _574 = int(spvNMin(trunc(_564 + 1.0), 127.0) + 0.5);
    bool _575 = cpipeline_cb.constant_trackC_0.x < 0;
    float _593;
    if (_575)
    {
        _593 = 0.0;
    }
    else
    {
        uint _579 = uint(cpipeline_cb.constant_trackC_0.x);
        int _580 = _569 / 2;
        _593 = ((_569 - 2 * (_569 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_579].value[_580] & 65535u).x : unpackHalf2x16((spline_lut._m0[_579].value[_580] >> 16u) & 65535u).x;
    }
    float _611;
    if (_575)
    {
        _611 = 0.0;
    }
    else
    {
        uint _597 = uint(cpipeline_cb.constant_trackC_0.x);
        int _598 = _574 / 2;
        _611 = ((_574 - 2 * (_574 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_597].value[_598] & 65535u).x : unpackHalf2x16((spline_lut._m0[_597].value[_598] >> 16u) & 65535u).x;
    }
    float _612 = fract(_564);
    bool _615 = cpipeline_cb.constant_trackC_0.y < 0;
    float _633;
    if (_615)
    {
        _633 = 0.0;
    }
    else
    {
        uint _619 = uint(cpipeline_cb.constant_trackC_0.y);
        int _620 = _569 / 2;
        _633 = ((_569 - 2 * (_569 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_619].value[_620] & 65535u).x : unpackHalf2x16((spline_lut._m0[_619].value[_620] >> 16u) & 65535u).x;
    }
    float _651;
    if (_615)
    {
        _651 = 0.0;
    }
    else
    {
        uint _637 = uint(cpipeline_cb.constant_trackC_0.y);
        int _638 = _574 / 2;
        _651 = ((_574 - 2 * (_574 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_637].value[_638] & 65535u).x : unpackHalf2x16((spline_lut._m0[_637].value[_638] >> 16u) & 65535u).x;
    }
    bool _654 = cpipeline_cb.constant_trackC_0.z < 0;
    float _672;
    if (_654)
    {
        _672 = 0.0;
    }
    else
    {
        uint _658 = uint(cpipeline_cb.constant_trackC_0.z);
        int _659 = _569 / 2;
        _672 = ((_569 - 2 * (_569 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_658].value[_659] & 65535u).x : unpackHalf2x16((spline_lut._m0[_658].value[_659] >> 16u) & 65535u).x;
    }
    float _690;
    if (_654)
    {
        _690 = 0.0;
    }
    else
    {
        uint _676 = uint(cpipeline_cb.constant_trackC_0.z);
        int _677 = _574 / 2;
        _690 = ((_574 - 2 * (_574 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_676].value[_677] & 65535u).x : unpackHalf2x16((spline_lut._m0[_676].value[_677] >> 16u) & 65535u).x;
    }
    bool _693 = cpipeline_cb.constant_trackC_0.w < 0;
    float _711;
    if (_693)
    {
        _711 = 0.0;
    }
    else
    {
        uint _697 = uint(cpipeline_cb.constant_trackC_0.w);
        int _698 = _569 / 2;
        _711 = ((_569 - 2 * (_569 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_697].value[_698] & 65535u).x : unpackHalf2x16((spline_lut._m0[_697].value[_698] >> 16u) & 65535u).x;
    }
    float _729;
    if (_693)
    {
        _729 = 0.0;
    }
    else
    {
        uint _715 = uint(cpipeline_cb.constant_trackC_0.w);
        int _716 = _574 / 2;
        _729 = ((_574 - 2 * (_574 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_715].value[_716] & 65535u).x : unpackHalf2x16((spline_lut._m0[_715].value[_716] >> 16u) & 65535u).x;
    }
    float _730 = mix(_711, _729, _612);
    vec3 _737 = spvNMin((vec4(mix(_593, _611, _612), mix(_633, _651, _612), mix(_672, _690, _612), _730).xyz * vec3(spvNMax(_730, 0.0))) * 5.0, vec3(100.0));
    bool _740 = cpipeline_cb.constant_trackG_2 < 0;
    float _758;
    if (_740)
    {
        _758 = 0.0;
    }
    else
    {
        uint _744 = uint(cpipeline_cb.constant_trackG_2);
        int _745 = _471 / 2;
        _758 = ((_471 - 2 * (_471 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_744].value[_745] & 65535u).x : unpackHalf2x16((spline_lut._m0[_744].value[_745] >> 16u) & 65535u).x;
    }
    float _776;
    if (_740)
    {
        _776 = 0.0;
    }
    else
    {
        uint _762 = uint(cpipeline_cb.constant_trackG_2);
        int _763 = _476 / 2;
        _776 = ((_476 - 2 * (_476 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_762].value[_763] & 65535u).x : unpackHalf2x16((spline_lut._m0[_762].value[_763] >> 16u) & 65535u).x;
    }
    vec4 _782;
    _782.w = _402;
    uint _792 = in_var_INSTANCEID / cobject_cb.instance_count;
    float _801 = clamp(uintBitsToFloat((uint(cobject_cb.instances[_792].synced_random_seed.x) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0);
    float _802 = (cpipeline_cb.constant_bool_2 != 0u) ? _801 : _348;
    uvec3 _806 = (floatBitsToUint(vec3(_802, 0.443972110748291015625, 0.2921483516693115234375)) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _807 = _806.y;
    uint _808 = _806.z;
    uint _811 = _806.x + (_807 * _808);
    uint _813 = _807 + (_808 * _811);
    uvec3 _816 = uvec3(_811, _813, _808 + (_811 * _813));
    uvec3 _818 = _816 ^ (_816 >> uvec3(16u));
    uint _819 = _818.y;
    uint _820 = _818.z;
    uint _823 = _818.x + (_819 * _820);
    uint _825 = _819 + (_820 * _823);
    float _854 = (((0.2989999949932098388671875 * _421.x) + (0.58700001239776611328125 * _421.y)) - 0.5) * 2.0;
    vec2 _862 = vec2(1.0) - in_var_AUTO_CELDJDLE_GEBKIEDD;
    vec3 _863 = vec3(0.443972110748291015625, 0.0, 0.0);
    _863.y = _802;
    _863.z = 0.2921483516693115234375;
    uvec3 _867 = (floatBitsToUint(_863) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _868 = _867.y;
    uint _869 = _867.z;
    uint _872 = _867.x + (_868 * _869);
    uint _874 = _868 + (_869 * _872);
    uvec3 _877 = uvec3(_872, _874, _869 + (_872 * _874));
    uvec3 _879 = _877 ^ (_877 >> uvec3(16u));
    vec2 _895 = vec2(mix(cpipeline_cb.constant2_9.x, cpipeline_cb.constant2_9.y, clamp(uintBitsToFloat(((_879.x + (_879.y * _879.z)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0)));
    vec2 _932 = (cobject_cb.instances[_792].tile_ground_tiling * in_var_TEXCOORD0.xy) * cpass_cb.ground_scalemove_uv.xy;
    vec4 _938 = texture(sampler2D(tile_ground_normal_texture, SamplerLinearWrap), _932);
    bool _939 = cobject_cb.instances[_792].tile_ground_normal_swizzle == 1u;
    vec2 _945;
    if (_939)
    {
        _945 = _938.wy;
    }
    else
    {
        _945 = _938.xy;
    }
    float _963 = clamp(pow(spvNMax(abs(clamp((((in_var_AUTO_CELDJDLE_GEBKIEDD + (((vec4(_308, _945.y, _300, _300).xy - vec2(0.5)) * vec2(2.0)) * vec2(mix(cpipeline_cb.constant2_6.x, cpipeline_cb.constant2_6.y, clamp(uintBitsToFloat((_823 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (_422.xy * vec2(mix(cpipeline_cb.constant2_7.x, cpipeline_cb.constant2_7.y, clamp(uintBitsToFloat(((_820 + (_823 * _825)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (mix(mix(vec2(-1.0), vec2(0.0), vec2(cpipeline_cb.constant2_8.x)), vec2(-1.0), vec2(cpipeline_cb.constant2_8.y)) * mix(mix(_895, _895 * in_var_AUTO_CELDJDLE_GEBKIEDD, vec2(cpipeline_cb.constant2_10.x)), _862, vec2(cpipeline_cb.constant2_10.y)))).y, 0.0, 1.0)), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_9), 0.0, 1.0);
    float _964 = _963 * 127.0;
    int _968 = int(spvNMax(trunc(_964), 0.0) + 0.5);
    int _973 = int(spvNMin(trunc(_964 + 1.0), 127.0) + 0.5);
    bool _974 = cpipeline_cb.constant_trackG_3 < 0;
    float _992;
    if (_974)
    {
        _992 = 0.0;
    }
    else
    {
        uint _978 = uint(cpipeline_cb.constant_trackG_3);
        int _979 = _968 / 2;
        _992 = ((_968 - 2 * (_968 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_978].value[_979] & 65535u).x : unpackHalf2x16((spline_lut._m0[_978].value[_979] >> 16u) & 65535u).x;
    }
    float _1010;
    if (_974)
    {
        _1010 = 0.0;
    }
    else
    {
        uint _996 = uint(cpipeline_cb.constant_trackG_3);
        int _997 = _973 / 2;
        _1010 = ((_973 - 2 * (_973 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_996].value[_997] & 65535u).x : unpackHalf2x16((spline_lut._m0[_996].value[_997] >> 16u) & 65535u).x;
    }
    float _1013 = mix(_992, _1010, fract(_964)) - clamp(-(_854 * mix(cpipeline_cb.constant2_13.x, cpipeline_cb.constant2_13.y, clamp(uintBitsToFloat((_825 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))), 0.0, 1.0);
    float _1028 = (cpipeline_cb.constant_bool_4 != 0u) ? _801 : _348;
    uvec3 _1032 = (floatBitsToUint(vec3(_1028, 0.17456948757171630859375, 0.19825279712677001953125)) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _1033 = _1032.y;
    uint _1034 = _1032.z;
    uint _1037 = _1032.x + (_1033 * _1034);
    uint _1039 = _1033 + (_1034 * _1037);
    uvec3 _1042 = uvec3(_1037, _1039, _1034 + (_1037 * _1039));
    uvec3 _1044 = _1042 ^ (_1042 >> uvec3(16u));
    uint _1045 = _1044.y;
    uint _1046 = _1044.z;
    uint _1049 = _1044.x + (_1045 * _1046);
    uint _1051 = _1045 + (_1046 * _1049);
    vec3 _1081 = vec3(0.17456948757171630859375, 0.0, 0.0);
    _1081.y = _1028;
    _1081.z = 0.19825279712677001953125;
    uvec3 _1085 = (floatBitsToUint(_1081) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _1086 = _1085.y;
    uint _1087 = _1085.z;
    uint _1090 = _1085.x + (_1086 * _1087);
    uint _1092 = _1086 + (_1087 * _1090);
    uvec3 _1095 = uvec3(_1090, _1092, _1087 + (_1090 * _1092));
    uvec3 _1097 = _1095 ^ (_1095 >> uvec3(16u));
    vec2 _1113 = vec2(mix(cpipeline_cb.constant2_17.x, cpipeline_cb.constant2_17.y, clamp(uintBitsToFloat(((_1097.x + (_1097.y * _1097.z)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0)));
    vec4 _1143 = texture(sampler2D(tile_ground_normal_texture, SamplerLinearWrap), _932);
    vec2 _1149;
    if (_939)
    {
        _1149 = _1143.wy;
    }
    else
    {
        _1149 = _1143.xy;
    }
    float _1167 = clamp(pow(spvNMax(abs(clamp((((in_var_AUTO_CELDJDLE_GEBKIEDD + (((vec4(_308, _1149.y, _300, _300).xy - vec2(0.5)) * vec2(2.0)) * vec2(mix(cpipeline_cb.constant2_14.x, cpipeline_cb.constant2_14.y, clamp(uintBitsToFloat((_1049 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (_422.xy * vec2(mix(cpipeline_cb.constant2_15.x, cpipeline_cb.constant2_15.y, clamp(uintBitsToFloat(((_1046 + (_1049 * _1051)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (mix(mix(vec2(-1.0), vec2(0.0), vec2(cpipeline_cb.constant2_16.x)), vec2(-1.0), vec2(cpipeline_cb.constant2_16.y)) * mix(mix(_1113, _1113 * in_var_AUTO_CELDJDLE_GEBKIEDD, vec2(cpipeline_cb.constant2_18.x)), _862, vec2(cpipeline_cb.constant2_18.y)))).y, 0.0, 1.0)), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_11), 0.0, 1.0);
    float _1168 = _1167 * 127.0;
    int _1172 = int(spvNMax(trunc(_1168), 0.0) + 0.5);
    int _1177 = int(spvNMin(trunc(_1168 + 1.0), 127.0) + 0.5);
    bool _1178 = cpipeline_cb.constant_trackG_4 < 0;
    float _1196;
    if (_1178)
    {
        _1196 = 0.0;
    }
    else
    {
        uint _1182 = uint(cpipeline_cb.constant_trackG_4);
        int _1183 = _1172 / 2;
        _1196 = ((_1172 - 2 * (_1172 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_1182].value[_1183] & 65535u).x : unpackHalf2x16((spline_lut._m0[_1182].value[_1183] >> 16u) & 65535u).x;
    }
    float _1214;
    if (_1178)
    {
        _1214 = 0.0;
    }
    else
    {
        uint _1200 = uint(cpipeline_cb.constant_trackG_4);
        int _1201 = _1177 / 2;
        _1214 = ((_1177 - 2 * (_1177 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_1200].value[_1201] & 65535u).x : unpackHalf2x16((spline_lut._m0[_1200].value[_1201] >> 16u) & 65535u).x;
    }
    float _1217 = mix(_1196, _1214, fract(_1168)) - clamp(-(_854 * mix(cpipeline_cb.constant2_21.x, cpipeline_cb.constant2_21.y, clamp(uintBitsToFloat((_1051 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))), 0.0, 1.0);
    float _1225 = clamp((vec3(clamp((vec3(clamp(spvNMax(vec3(mix(_758, _776, _513), _308, _308), vec3(0.0)).x, 0.0, 1.0)) + vec3((cpipeline_cb.constant_bool_3 != 0u) ? spvNMax(_1013, 0.0) : clamp(_1013, 0.0, 1.0))).x, 0.0, 1.0)) * vec3((cpipeline_cb.constant_bool_5 != 0u) ? spvNMax(_1217, 0.0) : clamp(_1217, 0.0, 1.0))).x, 0.0, 1.0);
    float _1229;
    _1229 = 0.0;
    float _1230;
    for (uint _1232 = 0u; _1232 < 1u; _1229 = _1230, _1232++)
    {
        uint _1237 = cpipeline_cb.constantUInt1_122 / 4u;
        uint _1238 = cpipeline_cb.constantUInt1_122 % 4u;
        vec4 _1267;
        if (!(((particles_emitter_data._m0[cobject_cb.instances[_792].gpu_particle_emitter].culling_tag >> 14u) & 512u) == 0u))
        {
            vec4 _1266;
            if (floatBitsToUint(cpass_cb.frame_delta_time.w) == 0u)
            {
                _1266 = vec4(_308, 0.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            else
            {
                _1266 = vec4(0.0, 1.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            _1267 = _1266;
        }
        else
        {
            _1267 = cpass_cb.frame_delta_time;
        }
        float _1275 = mix(particles_emitter_data._m0[cobject_cb.instances[_792].gpu_particle_emitter].prev_time, particles_emitter_data._m0[cobject_cb.instances[_792].gpu_particle_emitter].time, _1267.z) / particles_emitter_data._m0[cobject_cb.instances[_792].gpu_particle_emitter].emitter_duration;
        float _1276 = spvNMax(0.0, _1275);
        float _1282;
        if (((particles_emitter_data._m0[cobject_cb.instances[_792].gpu_particle_emitter].culling_tag >> 14u) & 2u) != 0u)
        {
            _1282 = fract(_1276);
        }
        else
        {
            _1282 = _1276;
        }
        float _1289 = spvNMax(cpipeline_cb.constant1_14, 9.9999997473787516355514526367188e-05);
        float _1296;
        if (abs(_1289) > 0.0)
        {
            _1296 = in_var_AUTO_PIPJIEKO_LDBDDLHP / _1289;
        }
        else
        {
            _1296 = 0.0;
        }
        float _1303;
        if (_1238 == 0u)
        {
            _1303 = _1296;
        }
        else
        {
            _1303 = (_1238 == 1u) ? clamp((abs(particles_emitter_data._m0[cobject_cb.instances[_792].gpu_particle_emitter].emitter_duration) > 0.0) ? _1275 : 0.0, 0.0, 1.0) : 0.0;
        }
        float _1311;
        if (abs(cobject_cb.instances[_792].gpu_particles_duration.x) > 0.0)
        {
            _1311 = (in_var_AUTO_PIPJIEKO_CIFEPFLO * in_var_AUTO_PIPJIEKO_EIDIDJP) / cobject_cb.instances[_792].gpu_particles_duration.x;
        }
        else
        {
            _1311 = 0.0;
        }
        float _1328;
        if (cpipeline_cb.constantUInt1_122 == 0u)
        {
            _1328 = in_var_AUTO_PIPJIEKO_CIFEPFLO;
        }
        else
        {
            float _1327;
            if (cpipeline_cb.constantUInt1_122 == 1u)
            {
                _1327 = _1282;
            }
            else
            {
                float _1326;
                if (cpipeline_cb.constantUInt1_122 == 2u)
                {
                    _1326 = in_var_AUTO_PIPJIEKO_IINFNGPI;
                }
                else
                {
                    _1326 = (cpipeline_cb.constantUInt1_122 == 3u) ? _1311 : 0.0;
                }
                _1327 = _1326;
            }
            _1328 = _1327;
        }
        if (_1237 == 0u)
        {
            _1230 = _1328;
        }
        else
        {
            _1230 = (_1237 == 1u) ? _1303 : 0.0;
        }
    }
    float _1338 = clamp(_1229, 0.0, 1.0);
    float _1348 = _1338 * _1338;
    float _1359 = spvNMax(dot(cpipeline_cb.constant_track5_5.segment_polynom[(_1338 < cpipeline_cb.constant_track5_5.time_variance.x) ? 0u : ((_1338 < cpipeline_cb.constant_track5_5.time_variance.y) ? 1u : ((_1338 < cpipeline_cb.constant_track5_5.time_variance.z) ? 2u : 3u))], vec4(_1348 * _1338, _1348, _1338, 1.0)) + (((_348 - 0.5) * 2.0) * cpipeline_cb.constant_track5_5.time_variance.w), 0.0);
    float _1364 = clamp(mix(_1225 * _1359, _1225 - (1.0 - _1359), 0.25), 0.0, 1.0);
    vec3 _1365 = _373 * _422;
    vec3 _1369 = _1365 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_1365)));
    vec3 _1373 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _1374 = reflect(_1373, _1369);
    vec4 _1377 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _301.w);
    _1377.w = 1.0;
    vec4 _1379 = cpass_cb.scene_view_projection_transform * _1377;
    vec4 _1382 = _1379 / vec4(_1379.w);
    vec2 _1385 = (_1382.xy * 0.5) + vec2(0.5);
    float _1386 = _1385.y;
    float _1387 = 1.0 - _1386;
    float _1388 = _1385.x;
    vec3 _1389 = vec3(_1388, _1387, _300);
    ivec2 _1395 = ivec2(uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)));
    vec2 _1405 = vec2(1.0) / vec2(float(uint(_1395.x) / 1u), float(uint(_1395.y) / 1u));
    bool _1421;
    if (cpass_cb.sh_probe_spacing > 0)
    {
        _1421 = cpass_cb.ssgi_intensity > 0.5;
    }
    else
    {
        _1421 = false;
    }
    vec4 _1769;
    if (_1421)
    {
        vec3 _1432 = clamp((cpass_cb.scene_view_transform * vec4(_1369, 0.0)).xyz, vec3(-1.0), vec3(1.0));
        float _1433 = _1382.z;
        ivec2 _1439 = ivec2(cpass_cb.sh_probe_spacing);
        ivec2 _1440 = ivec2(uvec2(vec2(_1395) * cpass_cb.frame_to_dynamic_scale.xy));
        vec4 _1449 = cpass_cb.scene_view_projection_transform_inv * vec4((_1388 * 2.0) - 1.0, (_1386 * 2.0) - 1.0, _1433, 1.0);
        vec3 _1453 = (_1449 / vec4(_1449.w)).xyz;
        ivec2 _1454 = _1439 / ivec2(2);
        vec2 _1455 = vec2(_1439);
        vec2 _1456 = vec2(1.0) / _1455;
        vec2 _1457 = vec2(_1454);
        vec2 _1460 = vec2(_1440);
        vec2 _1462 = vec2(1.0) / _1460;
        vec2 _1464 = (_1457 + vec2(0.5)) * _1462;
        vec2 _1465 = _1455 * _1462;
        vec2 _1467 = ((vec2(-0.5) - _1457) * _1456) + ((_1460 * _1456) * vec3(_1388, _1387, _1433).xy);
        ivec2 _1469 = ivec2(floor(_1467));
        vec3 _313[4];
        for (int _1472 = 0; _1472 < 4; _1472++)
        {
            ivec2 _1480 = _1469 + _288[_1472];
            ivec2 _1482 = _1454 + (_1439 * _1480);
            int _1483 = _1482.x;
            bool _1489;
            if (_1483 >= 0)
            {
                _1489 = _1482.y >= 0;
            }
            else
            {
                _1489 = false;
            }
            bool _1494;
            if (_1489)
            {
                _1494 = _1483 < _1440.x;
            }
            else
            {
                _1494 = false;
            }
            bool _1500;
            if (_1494)
            {
                _1500 = _1482.y < _1440.y;
            }
            else
            {
                _1500 = false;
            }
            vec4 _1508;
            if (_1500)
            {
                _1508 = texelFetch(depth_sampler, ivec3(_1483, _1482.y, 0).xy, 0);
            }
            else
            {
                _1508 = vec4(1.0);
            }
            vec2 _1512 = clamp(_1464 + (_1465 * vec2(_1480)), vec2(0.0), vec2(1.0));
            vec4 _1522 = cpass_cb.scene_view_projection_transform_inv * vec4((_1512.x * 2.0) - 1.0, ((1.0 - _1512.y) * 2.0) - 1.0, _1508.x, 1.0);
            _313[_1472] = (_1522 / vec4(_1522.w)).xyz;
        }
        vec2 _1534;
        _1534 = fract(_1467);
        for (int _1537 = 0; _1537 < 2; )
        {
            vec3 _1542 = vec3(_1534.y);
            vec3 _1543 = mix(_313[0], _313[2], _1542);
            vec3 _1545 = mix(_313[1], _313[3], _1542) - _1543;
            float _1550 = clamp(dot(_1453 - _1543, _1545) / dot(_1545, _1545), 0.0, 1.0);
            vec3 _1551 = vec3(_1550);
            vec3 _1552 = mix(_313[0], _313[1], _1551);
            vec3 _1554 = mix(_313[2], _313[3], _1551) - _1552;
            _1534 = vec2(_1550, clamp(dot(_1453 - _1552, _1554) / dot(_1554, _1554), 0.0, 1.0));
            _1537++;
            continue;
        }
        vec2 _1561 = vec2(_1469) + _1534;
        uvec2 _1568 = uvec2(textureSize(ambient_light_tex, 0));
        vec2 _1576 = vec2(1.0) / vec2(float(int(_1568.x)), float(int(_1568.y)));
        uvec2 _1578 = uvec2(ivec2(uvec2(cpass_cb.sh_atlas_size) / uvec2(2u)));
        vec2 _1583 = ((vec2(uvec2(0u) * _1578) + _1561) + vec2(0.5)) * _1576;
        vec2 _1594 = ((vec2(uvec2(1u, 0u) * _1578) + _1561) + vec2(0.5)) * _1576;
        vec2 _1605 = ((vec2(uvec2(1u) * _1578) + _1561) + vec2(0.5)) * _1576;
        vec2 _1616 = ((vec2(uvec2(0u, 1u) * _1578) + _1561) + vec2(0.5)) * _1576;
        mat4 _1624 = transpose(mat4(textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1583, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1594, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1605, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1616, 0.0, 0.0).xy, 0.0)));
        vec4 _1762;
        if (cpass_cb.gi_self_lighting != 0u)
        {
            vec4 _1736 = _1624[0];
            vec4 _1742 = _1624[1];
            vec4 _1748 = _1624[2];
            vec4 _1754 = _1624[3];
            _1762 = spvNMax(vec4(0.0), vec4(_1736.x + (dot(_1736.yzw, _1432) * 2.0), _1742.x + (dot(_1742.yzw, _1432) * 2.0), _1748.x + (dot(_1748.yzw, _1432) * 2.0), _1754.x + (dot(_1754.yzw, _1432) * 2.0)));
        }
        else
        {
            vec4 _1631 = _1624[0];
            vec3 _1632 = _1631.yzw;
            float _1633 = length(_1632);
            float _1640 = _1631.x;
            float _1642 = _1633 / spvNMax(1.0000000116860974230803549289703e-07, _1640);
            float _1643 = 2.0 * _1642;
            float _1648 = (1.0 - _1642) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1642);
            vec4 _1657 = _1624[1];
            vec3 _1658 = _1657.yzw;
            float _1659 = length(_1658);
            float _1666 = _1657.x;
            float _1668 = _1659 / spvNMax(1.0000000116860974230803549289703e-07, _1666);
            float _1669 = 2.0 * _1668;
            float _1674 = (1.0 - _1668) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1668);
            vec4 _1683 = _1624[2];
            vec3 _1684 = _1683.yzw;
            float _1685 = length(_1684);
            float _1692 = _1683.x;
            float _1694 = _1685 / spvNMax(1.0000000116860974230803549289703e-07, _1692);
            float _1695 = 2.0 * _1694;
            float _1700 = (1.0 - _1694) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1694);
            vec4 _1709 = _1624[3];
            vec3 _1710 = _1709.yzw;
            float _1711 = length(_1710);
            float _1718 = _1709.x;
            float _1720 = _1711 / spvNMax(1.0000000116860974230803549289703e-07, _1718);
            float _1721 = 2.0 * _1720;
            float _1726 = (1.0 - _1720) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1720);
            _1762 = vec4(_1640 * (_1648 + (((1.0 - _1648) * (_1643 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1632 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1633)), _1432)), 0.0, 1.0), 1.0 + _1643))), _1666 * (_1674 + (((1.0 - _1674) * (_1669 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1658 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1659)), _1432)), 0.0, 1.0), 1.0 + _1669))), _1692 * (_1700 + (((1.0 - _1700) * (_1695 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1684 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1685)), _1432)), 0.0, 1.0), 1.0 + _1695))), _1718 * (_1726 + (((1.0 - _1726) * (_1721 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1710 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1711)), _1432)), 0.0, 1.0), 1.0 + _1721))));
        }
        vec3 _1764 = _1762.xyz * 1.0;
        vec4 _1765 = vec4(_1764.x, _1764.y, _1764.z, _782.w);
        _1765.w = _402 * _1762.w;
        _1769 = _1765;
    }
    else
    {
        _1769 = vec4(vec4(0.0, 0.0, 0.0, 1.0).x, vec4(0.0, 0.0, 0.0, 1.0).y, vec4(0.0, 0.0, 0.0, 1.0).z, _782.w);
    }
    vec4 _1777 = textureLod(sampler2D(screenspace_shadowmap, SamplerLinearClamp), vec4((_1389.xy / (_1405 / cpass_cb.frame_to_dynamic_scale.xy)) * _1405, 0.0, 0.0).xy, 0.0);
    vec4 _1781 = _1769 + vec4(_1777.x * 9.9999997473787516355514526367188e-05);
    uvec4 _1794 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _1795 = _1794.x;
    uint _1796 = _1794.y;
    vec3 _1801;
    vec3 _1803;
    vec3 _1805;
    _1801 = vec3(0.0);
    _1803 = vec3(0.0);
    _1805 = vec3(0.0);
    uint _1799;
    vec3 _1802;
    vec3 _1804;
    vec3 _1806;
    for (uint _1798 = _1795, _1807 = 0u; _1807 < _1796; _1798 = _1799, _1801 = _1802, _1803 = _1804, _1805 = _1806, _1807++)
    {
        _1799 = _1798 + 1u;
        uvec4 _1813 = texelFetch(light_indices, int(_1798));
        uint _1814 = _1813.x;
        vec4 _1833;
        if (point_light_infos._m0[_1814].channel_index > (-0.5))
        {
            vec4 _1832;
            if (point_light_infos._m0[_1814].channel_index >= 2.5)
            {
                _1832 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1831;
                if (point_light_infos._m0[_1814].channel_index >= 1.5)
                {
                    _1831 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1831 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1814].channel_index >= 0.5));
                }
                _1832 = _1831;
            }
            _1833 = _1832;
        }
        else
        {
            _1833 = vec4(0.0);
        }
        vec3 _1863 = vec4(point_light_infos._m0[_1814].position, point_light_infos._m0[_1814].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1864 = length(_1863);
        vec3 _1866 = _1863 / vec3(_1864);
        vec3 _1867 = vec4(point_light_infos._m0[_1814].color, point_light_infos._m0[_1814].median_radius).xyz;
        float _1874 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1814].channel_index, 0.0, 1.0));
        float _1879 = (_1864 / (point_light_infos._m0[_1814].median_radius / _1874)) + 1.0;
        float _1880 = _1864 / (point_light_infos._m0[_1814].median_radius * sqrt(dot(abs(_1867), vec3(1.0)) * 2.0));
        float _1885 = clamp(1.0 - (((_1880 * _1880) * _1880) * _1880), 0.0, 1.0);
        vec3 _1892 = (_1867 * spvNMin(10.0, (((0.199999988079071044921875 * _1874) * _1874) * (_1885 * _1885)) / (_1879 * _1879))) * (dot(_1777, _1833) * clamp((dot(-normalize(_407), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1814].position)) - (1.0 - length(_407))) * 2.5, 0.0, 1.0));
        if (length(_1892) > 0.0)
        {
            float _1898 = clamp(dot(_1866, _1369), 0.0, 1.0);
            float _1901 = clamp(1.0 - _429, 0.0, 1.0);
            float _1903 = spvNMax(_1901 * _1901, 0.00200000009499490261077880859375);
            float _1904 = _1903 * _1903;
            vec3 _1905 = -_1373;
            vec3 _1907 = normalize(_1905 + _1866);
            float _1909 = clamp(dot(_1369, _1907), 0.0, 1.0);
            float _1913 = clamp(dot(_1905, _1907), 0.0, 1.0);
            float _1920 = _1903 * 0.5;
            float _1921 = 1.0 - _1920;
            _1802 = _1801 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1913) - 6.9831600189208984375) * _1913)), vec3(1.0), _462) * (_1904 / pow((((_1904 - 1.0) * _1909) * _1909) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1905, _1369), 0.0, 1.0) * _1921) + _1920) * ((_1898 * _1921) + _1920)))) * _1898) * vec3(0.25)) * _1892);
            _1804 = _1803 + ((_1892 * _1898) * _415.xyz);
            _1806 = _1805 + _1892;
        }
        else
        {
            _1802 = _1801;
            _1804 = _1803;
            _1806 = _1805;
        }
    }
    uvec4 _1946 = uvec4(cobject_cb.instances[_792].dynamic_light_indices);
    uint _1947 = _1946.x;
    uint _1950 = uint(dynamic_light_infos._m0[_1947].light_type.x);
    uint _1951 = _1946.y;
    uint _1954 = uint(dynamic_light_infos._m0[_1951].light_type.x);
    uint _1955 = _1946.z;
    uint _1958 = uint(dynamic_light_infos._m0[_1955].light_type.x);
    uint _1959 = _1946.w;
    uint _1962 = uint(dynamic_light_infos._m0[_1959].light_type.x);
    vec4 _2341;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1947].shadow_enabled.x > 0.0)
    {
        vec4 _1971 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2339;
        do
        {
            vec4 _1981 = dynamic_light_infos._m0[_1947].light_matrix * _1971;
            vec3 _2038;
            if (_1950 == 2u)
            {
                vec3 _2002 = _1981.xyz;
                vec3 _2004 = normalize(_2002) + vec3(0.0, 0.0, 1.0);
                float _2008 = length(_2002);
                vec3 _2011 = vec3((_2004 / vec3(_2004.z)).xy, _2008);
                float _2012 = _1981.z;
                vec3 _2024;
                if (_2012 > 0.0)
                {
                    _2024 = _2011;
                }
                else
                {
                    _2024 = vec3(normalize(_2011.xy) * 10000000.0, -_2008);
                }
                vec3 _2032 = vec3((_2024.x * 0.5) + 0.5, 0.5 - (_2024.y * 0.5), _2024.z);
                _2032.z = _2024.z * 9.9999997473787516355514526367188e-05;
                if (_2012 < 0.0)
                {
                    _2339 = 0.0;
                    break;
                }
                _2038 = _2032;
            }
            else
            {
                vec3 _1986 = _1981.xyz;
                vec3 _1998;
                if (_1950 == 1u)
                {
                    float _1990 = _1981.z;
                    vec3 _1997 = _1986;
                    _1997.z = _1990 - (((_1990 * dynamic_light_infos._m0[_1947].shadow_scale.z) + 1.0) / _1981.w);
                    _1998 = _1997;
                }
                else
                {
                    _1998 = _1986;
                }
                _2038 = _1998 / vec3(_1981.w);
            }
            float _2147;
            if (dynamic_light_infos._m0[_1947].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2129 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2038.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2038.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2038.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2038.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1947].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2038.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2038.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1947].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2038.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2038.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1947].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2038.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2038.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1947].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2038.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2038.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1947].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2147 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1947].shadow_scale.w * spvNMax(_2129, _2038.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2038.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1947].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2147 = 1.0;
            }
            vec2 _2148 = dynamic_light_infos._m0[_1947].shadow_scale.xy * _2147;
            float _2234 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2038.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, _2038.z, 1.0).xy, _2038.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2038.xy + (vec2(1.0, 0.0) * _2148), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, _2038.z, 1.0).xy, _2038.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2038.xy + (vec2(0.5, 0.865999996662139892578125) * _2148), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, _2038.z, 1.0).xy, _2038.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2038.xy + (vec2(-0.5, 0.865999996662139892578125) * _2148), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, _2038.z, 1.0).xy, _2038.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2038.xy + (vec2(-1.0, -0.0) * _2148), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, _2038.z, 1.0).xy, _2038.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2038.xy + (vec2(-0.5, -0.865999996662139892578125) * _2148), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, _2038.z, 1.0).xy, _2038.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2038.xy + (vec2(0.5, -0.865999996662139892578125) * _2148), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1947].shadow_atlas_offset_scale.xy, _2038.z, 1.0).xy, _2038.z), 0.0);
            float _2235 = _2234 * 0.14285714924335479736328125;
            float _2338;
            if (_1950 == 0u)
            {
                float _2250 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1971.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2252 = transpose(dynamic_light_infos._m0[_1947].light_matrix)[2];
                float _2257 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2266;
                if (_2257 > 0.100000001490116119384765625)
                {
                    _2266 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2266 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2277 = _1971.xyz - ((_2252.xyz / vec3(_2252.z)) * 1000.0);
                float _2301 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2266, _2277), dot(normalize(vec3(-_2266.y, _2266.x, 0.0)), _2277)) + (vec2(_2257, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2250 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2308 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2309 = _2308 - 1.0;
                float _2310 = 1.0 - cpass_cb.clouds_midpoint;
                float _2317 = 2.0 - _2308;
                _2338 = _2235 * mix(1.0, clamp(clamp(_2310 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2301), 0.0, 1.0), _2309)) * pow(clamp(_2310, 0.0, 1.0), _2317)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2301), 0.0, 1.0), _2309) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2317))), 0.0, 1.0) + (_2250 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2338 = _2235;
            }
            _2339 = _2338;
            break;
        } while(false);
        vec4 _2340 = vec4(1.0);
        _2340.x = _2339;
        _2341 = _2340;
    }
    else
    {
        _2341 = vec4(1.0);
    }
    vec4 _2720;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1951].shadow_enabled.x > 0.0)
    {
        vec4 _2350 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2718;
        do
        {
            vec4 _2360 = dynamic_light_infos._m0[_1951].light_matrix * _2350;
            vec3 _2417;
            if (_1954 == 2u)
            {
                vec3 _2381 = _2360.xyz;
                vec3 _2383 = normalize(_2381) + vec3(0.0, 0.0, 1.0);
                float _2387 = length(_2381);
                vec3 _2390 = vec3((_2383 / vec3(_2383.z)).xy, _2387);
                float _2391 = _2360.z;
                vec3 _2403;
                if (_2391 > 0.0)
                {
                    _2403 = _2390;
                }
                else
                {
                    _2403 = vec3(normalize(_2390.xy) * 10000000.0, -_2387);
                }
                vec3 _2411 = vec3((_2403.x * 0.5) + 0.5, 0.5 - (_2403.y * 0.5), _2403.z);
                _2411.z = _2403.z * 9.9999997473787516355514526367188e-05;
                if (_2391 < 0.0)
                {
                    _2718 = 0.0;
                    break;
                }
                _2417 = _2411;
            }
            else
            {
                vec3 _2365 = _2360.xyz;
                vec3 _2377;
                if (_1954 == 1u)
                {
                    float _2369 = _2360.z;
                    vec3 _2376 = _2365;
                    _2376.z = _2369 - (((_2369 * dynamic_light_infos._m0[_1951].shadow_scale.z) + 1.0) / _2360.w);
                    _2377 = _2376;
                }
                else
                {
                    _2377 = _2365;
                }
                _2417 = _2377 / vec3(_2360.w);
            }
            float _2526;
            if (dynamic_light_infos._m0[_1951].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2508 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1951].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1951].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1951].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1951].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1951].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2526 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1951].shadow_scale.w * spvNMax(_2508, _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1951].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2526 = 1.0;
            }
            vec2 _2527 = dynamic_light_infos._m0[_1951].shadow_scale.xy * _2526;
            float _2613 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2417.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, _2417.z, 1.0).xy, _2417.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2417.xy + (vec2(1.0, 0.0) * _2527), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, _2417.z, 1.0).xy, _2417.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2417.xy + (vec2(0.5, 0.865999996662139892578125) * _2527), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, _2417.z, 1.0).xy, _2417.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2417.xy + (vec2(-0.5, 0.865999996662139892578125) * _2527), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, _2417.z, 1.0).xy, _2417.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2417.xy + (vec2(-1.0, -0.0) * _2527), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, _2417.z, 1.0).xy, _2417.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2417.xy + (vec2(-0.5, -0.865999996662139892578125) * _2527), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, _2417.z, 1.0).xy, _2417.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2417.xy + (vec2(0.5, -0.865999996662139892578125) * _2527), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1951].shadow_atlas_offset_scale.xy, _2417.z, 1.0).xy, _2417.z), 0.0);
            float _2614 = _2613 * 0.14285714924335479736328125;
            float _2717;
            if (_1954 == 0u)
            {
                float _2629 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2350.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2631 = transpose(dynamic_light_infos._m0[_1951].light_matrix)[2];
                float _2636 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2645;
                if (_2636 > 0.100000001490116119384765625)
                {
                    _2645 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2645 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2656 = _2350.xyz - ((_2631.xyz / vec3(_2631.z)) * 1000.0);
                float _2680 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2645, _2656), dot(normalize(vec3(-_2645.y, _2645.x, 0.0)), _2656)) + (vec2(_2636, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2629 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2687 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2688 = _2687 - 1.0;
                float _2689 = 1.0 - cpass_cb.clouds_midpoint;
                float _2696 = 2.0 - _2687;
                _2717 = _2614 * mix(1.0, clamp(clamp(_2689 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2680), 0.0, 1.0), _2688)) * pow(clamp(_2689, 0.0, 1.0), _2696)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2680), 0.0, 1.0), _2688) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2696))), 0.0, 1.0) + (_2629 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2717 = _2614;
            }
            _2718 = _2717;
            break;
        } while(false);
        vec4 _2719 = _2341;
        _2719.y = _2718;
        _2720 = _2719;
    }
    else
    {
        _2720 = _2341;
    }
    vec4 _3099;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1955].shadow_enabled.x > 0.0)
    {
        vec4 _2729 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _3097;
        do
        {
            vec4 _2739 = dynamic_light_infos._m0[_1955].light_matrix * _2729;
            vec3 _2796;
            if (_1958 == 2u)
            {
                vec3 _2760 = _2739.xyz;
                vec3 _2762 = normalize(_2760) + vec3(0.0, 0.0, 1.0);
                float _2766 = length(_2760);
                vec3 _2769 = vec3((_2762 / vec3(_2762.z)).xy, _2766);
                float _2770 = _2739.z;
                vec3 _2782;
                if (_2770 > 0.0)
                {
                    _2782 = _2769;
                }
                else
                {
                    _2782 = vec3(normalize(_2769.xy) * 10000000.0, -_2766);
                }
                vec3 _2790 = vec3((_2782.x * 0.5) + 0.5, 0.5 - (_2782.y * 0.5), _2782.z);
                _2790.z = _2782.z * 9.9999997473787516355514526367188e-05;
                if (_2770 < 0.0)
                {
                    _3097 = 0.0;
                    break;
                }
                _2796 = _2790;
            }
            else
            {
                vec3 _2744 = _2739.xyz;
                vec3 _2756;
                if (_1958 == 1u)
                {
                    float _2748 = _2739.z;
                    vec3 _2755 = _2744;
                    _2755.z = _2748 - (((_2748 * dynamic_light_infos._m0[_1955].shadow_scale.z) + 1.0) / _2739.w);
                    _2756 = _2755;
                }
                else
                {
                    _2756 = _2744;
                }
                _2796 = _2756 / vec3(_2739.w);
            }
            float _2905;
            if (dynamic_light_infos._m0[_1955].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2887 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2796.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2796.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2796.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2796.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1955].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2796.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2796.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1955].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2796.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2796.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1955].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2796.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2796.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1955].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2796.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2796.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1955].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2905 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1955].shadow_scale.w * spvNMax(_2887, _2796.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2796.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1955].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2905 = 1.0;
            }
            vec2 _2906 = dynamic_light_infos._m0[_1955].shadow_scale.xy * _2905;
            float _2992 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2796.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, _2796.z, 1.0).xy, _2796.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2796.xy + (vec2(1.0, 0.0) * _2906), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, _2796.z, 1.0).xy, _2796.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2796.xy + (vec2(0.5, 0.865999996662139892578125) * _2906), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, _2796.z, 1.0).xy, _2796.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2796.xy + (vec2(-0.5, 0.865999996662139892578125) * _2906), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, _2796.z, 1.0).xy, _2796.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2796.xy + (vec2(-1.0, -0.0) * _2906), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, _2796.z, 1.0).xy, _2796.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2796.xy + (vec2(-0.5, -0.865999996662139892578125) * _2906), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, _2796.z, 1.0).xy, _2796.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2796.xy + (vec2(0.5, -0.865999996662139892578125) * _2906), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1955].shadow_atlas_offset_scale.xy, _2796.z, 1.0).xy, _2796.z), 0.0);
            float _2993 = _2992 * 0.14285714924335479736328125;
            float _3096;
            if (_1958 == 0u)
            {
                float _3008 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2729.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _3010 = transpose(dynamic_light_infos._m0[_1955].light_matrix)[2];
                float _3015 = length(cpass_cb.clouds_velocity.xy);
                vec3 _3024;
                if (_3015 > 0.100000001490116119384765625)
                {
                    _3024 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _3024 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _3035 = _2729.xyz - ((_3010.xyz / vec3(_3010.z)) * 1000.0);
                float _3059 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_3024, _3035), dot(normalize(vec3(-_3024.y, _3024.x, 0.0)), _3035)) + (vec2(_3015, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_3008 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _3066 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _3067 = _3066 - 1.0;
                float _3068 = 1.0 - cpass_cb.clouds_midpoint;
                float _3075 = 2.0 - _3066;
                _3096 = _2993 * mix(1.0, clamp(clamp(_3068 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _3059), 0.0, 1.0), _3067)) * pow(clamp(_3068, 0.0, 1.0), _3075)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _3059), 0.0, 1.0), _3067) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _3075))), 0.0, 1.0) + (_3008 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _3096 = _2993;
            }
            _3097 = _3096;
            break;
        } while(false);
        vec4 _3098 = _2720;
        _3098.z = _3097;
        _3099 = _3098;
    }
    else
    {
        _3099 = _2720;
    }
    vec4 _3478;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1959].shadow_enabled.x > 0.0)
    {
        vec4 _3108 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _3476;
        do
        {
            vec4 _3118 = dynamic_light_infos._m0[_1959].light_matrix * _3108;
            vec3 _3175;
            if (_1962 == 2u)
            {
                vec3 _3139 = _3118.xyz;
                vec3 _3141 = normalize(_3139) + vec3(0.0, 0.0, 1.0);
                float _3145 = length(_3139);
                vec3 _3148 = vec3((_3141 / vec3(_3141.z)).xy, _3145);
                float _3149 = _3118.z;
                vec3 _3161;
                if (_3149 > 0.0)
                {
                    _3161 = _3148;
                }
                else
                {
                    _3161 = vec3(normalize(_3148.xy) * 10000000.0, -_3145);
                }
                vec3 _3169 = vec3((_3161.x * 0.5) + 0.5, 0.5 - (_3161.y * 0.5), _3161.z);
                _3169.z = _3161.z * 9.9999997473787516355514526367188e-05;
                if (_3149 < 0.0)
                {
                    _3476 = 0.0;
                    break;
                }
                _3175 = _3169;
            }
            else
            {
                vec3 _3123 = _3118.xyz;
                vec3 _3135;
                if (_1962 == 1u)
                {
                    float _3127 = _3118.z;
                    vec3 _3134 = _3123;
                    _3134.z = _3127 - (((_3127 * dynamic_light_infos._m0[_1959].shadow_scale.z) + 1.0) / _3118.w);
                    _3135 = _3134;
                }
                else
                {
                    _3135 = _3123;
                }
                _3175 = _3135 / vec3(_3118.w);
            }
            float _3284;
            if (dynamic_light_infos._m0[_1959].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _3266 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _3175.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3175.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3175.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3175.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1959].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3175.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3175.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1959].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3175.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3175.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1959].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3175.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3175.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1959].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3175.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3175.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1959].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _3284 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1959].shadow_scale.w * spvNMax(_3266, _3175.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3175.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1959].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _3284 = 1.0;
            }
            vec2 _3285 = dynamic_light_infos._m0[_1959].shadow_scale.xy * _3284;
            float _3371 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3175.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, _3175.z, 1.0).xy, _3175.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3175.xy + (vec2(1.0, 0.0) * _3285), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, _3175.z, 1.0).xy, _3175.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3175.xy + (vec2(0.5, 0.865999996662139892578125) * _3285), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, _3175.z, 1.0).xy, _3175.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3175.xy + (vec2(-0.5, 0.865999996662139892578125) * _3285), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, _3175.z, 1.0).xy, _3175.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3175.xy + (vec2(-1.0, -0.0) * _3285), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, _3175.z, 1.0).xy, _3175.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3175.xy + (vec2(-0.5, -0.865999996662139892578125) * _3285), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, _3175.z, 1.0).xy, _3175.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3175.xy + (vec2(0.5, -0.865999996662139892578125) * _3285), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1959].shadow_atlas_offset_scale.xy, _3175.z, 1.0).xy, _3175.z), 0.0);
            float _3372 = _3371 * 0.14285714924335479736328125;
            float _3475;
            if (_1962 == 0u)
            {
                float _3387 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _3108.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _3389 = transpose(dynamic_light_infos._m0[_1959].light_matrix)[2];
                float _3394 = length(cpass_cb.clouds_velocity.xy);
                vec3 _3403;
                if (_3394 > 0.100000001490116119384765625)
                {
                    _3403 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _3403 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _3414 = _3108.xyz - ((_3389.xyz / vec3(_3389.z)) * 1000.0);
                float _3438 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_3403, _3414), dot(normalize(vec3(-_3403.y, _3403.x, 0.0)), _3414)) + (vec2(_3394, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_3387 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _3445 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _3446 = _3445 - 1.0;
                float _3447 = 1.0 - cpass_cb.clouds_midpoint;
                float _3454 = 2.0 - _3445;
                _3475 = _3372 * mix(1.0, clamp(clamp(_3447 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _3438), 0.0, 1.0), _3446)) * pow(clamp(_3447, 0.0, 1.0), _3454)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _3438), 0.0, 1.0), _3446) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _3454))), 0.0, 1.0) + (_3387 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _3475 = _3372;
            }
            _3476 = _3475;
            break;
        } while(false);
        vec4 _3477 = _3099;
        _3477.w = _3476;
        _3478 = _3477;
    }
    else
    {
        _3478 = _3099;
    }
    vec3 _3545;
    vec3 _3546;
    switch (_1950)
    {
        case 0u:
        {
            _3545 = dynamic_light_infos._m0[_1947].light_color.xyz;
            _3546 = -dynamic_light_infos._m0[_1947].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3522 = dynamic_light_infos._m0[_1947].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3523 = length(_3522);
            vec3 _3525 = _3522 / vec3(_3523);
            _3545 = dynamic_light_infos._m0[_1947].light_color.xyz * ((1.0 - clamp(_3523 / dynamic_light_infos._m0[_1947].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1947].light_direction.xyz, _3525) - dynamic_light_infos._m0[_1947].light_direction.w) / (dynamic_light_infos._m0[_1947].light_position.w - dynamic_light_infos._m0[_1947].light_direction.w), 0.0, 1.0));
            _3546 = _3525;
            break;
        }
        case 2u:
        {
            vec3 _3490 = dynamic_light_infos._m0[_1947].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3491 = length(_3490);
            float _3503 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1947].light_position.w, 0.0, 1.0));
            float _3508 = (_3491 / (dynamic_light_infos._m0[_1947].light_color.w / _3503)) + 1.0;
            float _3509 = _3491 / (dynamic_light_infos._m0[_1947].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1947].light_color.xyz), vec3(1.0)) * 2.0));
            float _3514 = clamp(1.0 - (((_3509 * _3509) * _3509) * _3509), 0.0, 1.0);
            _3545 = dynamic_light_infos._m0[_1947].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3503) * _3503) * (_3514 * _3514)) / (_3508 * _3508));
            _3546 = _3490 / vec3(_3491);
            break;
        }
        default:
        {
            _3545 = vec3(0.0);
            _3546 = vec3(0.0);
            break;
        }
    }
    vec3 _3548 = normalize(_407);
    vec3 _3550 = -_3548;
    float _3552 = 1.0 - length(_407);
    vec3 _3558 = _3545 * (_3478.x * clamp((dot(_3550, -_3546) - _3552) * 2.5, 0.0, 1.0));
    vec3 _3610;
    vec3 _3611;
    vec3 _3612;
    if (length(_3558) > 0.0)
    {
        float _3564 = clamp(dot(_3546, _1369), 0.0, 1.0);
        float _3567 = clamp(1.0 - _429, 0.0, 1.0);
        float _3569 = spvNMax(_3567 * _3567, 0.00200000009499490261077880859375);
        float _3570 = _3569 * _3569;
        vec3 _3571 = -_1373;
        vec3 _3573 = normalize(_3571 + _3546);
        float _3575 = clamp(dot(_1369, _3573), 0.0, 1.0);
        float _3579 = clamp(dot(_3571, _3573), 0.0, 1.0);
        float _3586 = _3569 * 0.5;
        float _3587 = 1.0 - _3586;
        _3610 = _1801 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3579) - 6.9831600189208984375) * _3579)), vec3(1.0), _462) * (_3570 / pow((((_3570 - 1.0) * _3575) * _3575) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3571, _1369), 0.0, 1.0) * _3587) + _3586) * ((_3564 * _3587) + _3586)))) * _3564) * vec3(0.25)) * _3558);
        _3611 = _1803 + ((_3558 * _3564) * _415.xyz);
        _3612 = _1805 + _3558;
    }
    else
    {
        _3610 = _1801;
        _3611 = _1803;
        _3612 = _1805;
    }
    vec3 _3679;
    vec3 _3680;
    switch (_1954)
    {
        case 0u:
        {
            _3679 = dynamic_light_infos._m0[_1951].light_color.xyz;
            _3680 = -dynamic_light_infos._m0[_1951].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3656 = dynamic_light_infos._m0[_1951].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3657 = length(_3656);
            vec3 _3659 = _3656 / vec3(_3657);
            _3679 = dynamic_light_infos._m0[_1951].light_color.xyz * ((1.0 - clamp(_3657 / dynamic_light_infos._m0[_1951].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1951].light_direction.xyz, _3659) - dynamic_light_infos._m0[_1951].light_direction.w) / (dynamic_light_infos._m0[_1951].light_position.w - dynamic_light_infos._m0[_1951].light_direction.w), 0.0, 1.0));
            _3680 = _3659;
            break;
        }
        case 2u:
        {
            vec3 _3624 = dynamic_light_infos._m0[_1951].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3625 = length(_3624);
            float _3637 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1951].light_position.w, 0.0, 1.0));
            float _3642 = (_3625 / (dynamic_light_infos._m0[_1951].light_color.w / _3637)) + 1.0;
            float _3643 = _3625 / (dynamic_light_infos._m0[_1951].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1951].light_color.xyz), vec3(1.0)) * 2.0));
            float _3648 = clamp(1.0 - (((_3643 * _3643) * _3643) * _3643), 0.0, 1.0);
            _3679 = dynamic_light_infos._m0[_1951].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3637) * _3637) * (_3648 * _3648)) / (_3642 * _3642));
            _3680 = _3624 / vec3(_3625);
            break;
        }
        default:
        {
            _3679 = vec3(0.0);
            _3680 = vec3(0.0);
            break;
        }
    }
    vec3 _3688 = _3679 * (_3478.y * clamp((dot(_3550, -_3680) - _3552) * 2.5, 0.0, 1.0));
    vec3 _3740;
    vec3 _3741;
    vec3 _3742;
    if (length(_3688) > 0.0)
    {
        float _3694 = clamp(dot(_3680, _1369), 0.0, 1.0);
        float _3697 = clamp(1.0 - _429, 0.0, 1.0);
        float _3699 = spvNMax(_3697 * _3697, 0.00200000009499490261077880859375);
        float _3700 = _3699 * _3699;
        vec3 _3701 = -_1373;
        vec3 _3703 = normalize(_3701 + _3680);
        float _3705 = clamp(dot(_1369, _3703), 0.0, 1.0);
        float _3709 = clamp(dot(_3701, _3703), 0.0, 1.0);
        float _3716 = _3699 * 0.5;
        float _3717 = 1.0 - _3716;
        _3740 = _3610 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3709) - 6.9831600189208984375) * _3709)), vec3(1.0), _462) * (_3700 / pow((((_3700 - 1.0) * _3705) * _3705) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3701, _1369), 0.0, 1.0) * _3717) + _3716) * ((_3694 * _3717) + _3716)))) * _3694) * vec3(0.25)) * _3688);
        _3741 = _3611 + ((_3688 * _3694) * _415.xyz);
        _3742 = _3612 + _3688;
    }
    else
    {
        _3740 = _3610;
        _3741 = _3611;
        _3742 = _3612;
    }
    vec3 _3809;
    vec3 _3810;
    switch (_1958)
    {
        case 0u:
        {
            _3809 = dynamic_light_infos._m0[_1955].light_color.xyz;
            _3810 = -dynamic_light_infos._m0[_1955].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3786 = dynamic_light_infos._m0[_1955].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3787 = length(_3786);
            vec3 _3789 = _3786 / vec3(_3787);
            _3809 = dynamic_light_infos._m0[_1955].light_color.xyz * ((1.0 - clamp(_3787 / dynamic_light_infos._m0[_1955].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1955].light_direction.xyz, _3789) - dynamic_light_infos._m0[_1955].light_direction.w) / (dynamic_light_infos._m0[_1955].light_position.w - dynamic_light_infos._m0[_1955].light_direction.w), 0.0, 1.0));
            _3810 = _3789;
            break;
        }
        case 2u:
        {
            vec3 _3754 = dynamic_light_infos._m0[_1955].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3755 = length(_3754);
            float _3767 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1955].light_position.w, 0.0, 1.0));
            float _3772 = (_3755 / (dynamic_light_infos._m0[_1955].light_color.w / _3767)) + 1.0;
            float _3773 = _3755 / (dynamic_light_infos._m0[_1955].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1955].light_color.xyz), vec3(1.0)) * 2.0));
            float _3778 = clamp(1.0 - (((_3773 * _3773) * _3773) * _3773), 0.0, 1.0);
            _3809 = dynamic_light_infos._m0[_1955].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3767) * _3767) * (_3778 * _3778)) / (_3772 * _3772));
            _3810 = _3754 / vec3(_3755);
            break;
        }
        default:
        {
            _3809 = vec3(0.0);
            _3810 = vec3(0.0);
            break;
        }
    }
    vec3 _3818 = _3809 * (_3478.z * clamp((dot(_3550, -_3810) - _3552) * 2.5, 0.0, 1.0));
    vec3 _3870;
    vec3 _3871;
    vec3 _3872;
    if (length(_3818) > 0.0)
    {
        float _3824 = clamp(dot(_3810, _1369), 0.0, 1.0);
        float _3827 = clamp(1.0 - _429, 0.0, 1.0);
        float _3829 = spvNMax(_3827 * _3827, 0.00200000009499490261077880859375);
        float _3830 = _3829 * _3829;
        vec3 _3831 = -_1373;
        vec3 _3833 = normalize(_3831 + _3810);
        float _3835 = clamp(dot(_1369, _3833), 0.0, 1.0);
        float _3839 = clamp(dot(_3831, _3833), 0.0, 1.0);
        float _3846 = _3829 * 0.5;
        float _3847 = 1.0 - _3846;
        _3870 = _3740 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3839) - 6.9831600189208984375) * _3839)), vec3(1.0), _462) * (_3830 / pow((((_3830 - 1.0) * _3835) * _3835) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3831, _1369), 0.0, 1.0) * _3847) + _3846) * ((_3824 * _3847) + _3846)))) * _3824) * vec3(0.25)) * _3818);
        _3871 = _3741 + ((_3818 * _3824) * _415.xyz);
        _3872 = _3742 + _3818;
    }
    else
    {
        _3870 = _3740;
        _3871 = _3741;
        _3872 = _3742;
    }
    vec3 _3939;
    vec3 _3940;
    switch (_1962)
    {
        case 0u:
        {
            _3939 = dynamic_light_infos._m0[_1959].light_color.xyz;
            _3940 = -dynamic_light_infos._m0[_1959].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3916 = dynamic_light_infos._m0[_1959].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3917 = length(_3916);
            vec3 _3919 = _3916 / vec3(_3917);
            _3939 = dynamic_light_infos._m0[_1959].light_color.xyz * ((1.0 - clamp(_3917 / dynamic_light_infos._m0[_1959].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1959].light_direction.xyz, _3919) - dynamic_light_infos._m0[_1959].light_direction.w) / (dynamic_light_infos._m0[_1959].light_position.w - dynamic_light_infos._m0[_1959].light_direction.w), 0.0, 1.0));
            _3940 = _3919;
            break;
        }
        case 2u:
        {
            vec3 _3884 = dynamic_light_infos._m0[_1959].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3885 = length(_3884);
            float _3897 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1959].light_position.w, 0.0, 1.0));
            float _3902 = (_3885 / (dynamic_light_infos._m0[_1959].light_color.w / _3897)) + 1.0;
            float _3903 = _3885 / (dynamic_light_infos._m0[_1959].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1959].light_color.xyz), vec3(1.0)) * 2.0));
            float _3908 = clamp(1.0 - (((_3903 * _3903) * _3903) * _3903), 0.0, 1.0);
            _3939 = dynamic_light_infos._m0[_1959].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3897) * _3897) * (_3908 * _3908)) / (_3902 * _3902));
            _3940 = _3884 / vec3(_3885);
            break;
        }
        default:
        {
            _3939 = vec3(0.0);
            _3940 = vec3(0.0);
            break;
        }
    }
    vec3 _3948 = _3939 * (_3478.w * clamp((dot(_3550, -_3940) - _3552) * 2.5, 0.0, 1.0));
    vec3 _4000;
    vec3 _4001;
    vec3 _4002;
    if (length(_3948) > 0.0)
    {
        float _3954 = clamp(dot(_3940, _1369), 0.0, 1.0);
        float _3957 = clamp(1.0 - _429, 0.0, 1.0);
        float _3959 = spvNMax(_3957 * _3957, 0.00200000009499490261077880859375);
        float _3960 = _3959 * _3959;
        vec3 _3961 = -_1373;
        vec3 _3963 = normalize(_3961 + _3940);
        float _3965 = clamp(dot(_1369, _3963), 0.0, 1.0);
        float _3969 = clamp(dot(_3961, _3963), 0.0, 1.0);
        float _3976 = _3959 * 0.5;
        float _3977 = 1.0 - _3976;
        _4000 = _3871 + ((_3948 * _3954) * _415.xyz);
        _4001 = _3870 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3969) - 6.9831600189208984375) * _3969)), vec3(1.0), _462) * (_3960 / pow((((_3960 - 1.0) * _3965) * _3965) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3961, _1369), 0.0, 1.0) * _3977) + _3976) * ((_3954 * _3977) + _3976)))) * _3954) * vec3(0.25)) * _3948);
        _4002 = _3872 + _3948;
    }
    else
    {
        _4000 = _3871;
        _4001 = _3870;
        _4002 = _3872;
    }
    vec3 _4125;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _4015 = _1781.w;
        float _4016 = clamp(_429, 0.0, 1.0);
        float _4019 = sqrt(clamp(1.0 - _4015, 0.0, 1.0));
        float _4020 = 1.0 - _4016;
        float _4021 = _4020 * _4020;
        float _4024 = clamp(exp((-2.2999999523162841796875) * _4021), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _4025 = dot(_3548, _1374);
        float _4031 = sqrt(clamp(1.0 - (_4025 * _4025), 0.0, 1.0));
        float _4033 = _4024 - (_4025 * _4019);
        float _4034 = _4031 * _4019;
        vec2 _4035 = vec2(_4033, _4034);
        float _4037 = _4019 - (_4025 * _4024);
        float _4038 = _4031 * _4024;
        vec2 _4039 = vec2(_4037, _4038);
        float _4043 = sqrt(clamp(1.0 - (_4019 * _4019), 0.0, 1.0));
        float _4060 = sqrt(clamp(1.0 - (_4024 * _4024), 0.0, 1.0));
        vec4 _4086 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_1369, -_1373)), _4016, 0.0, 0.0).xy, 0.0);
        float _4099 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _4021));
        vec3 _4124 = _4001 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_1374, 0.0)).xyz, _4099).xyz, _4099).xyz * (vec3(_4086.x) + (_462 * _4086.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_4002 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * (_4015 * ((2.0 * ((acos(clamp(_4033 / (_4043 * sqrt(dot(_4035, _4035))), -1.0, 1.0)) - (acos(clamp((_4033 * _4019) / (_4034 * _4043), -1.0, 1.0)) * _4019)) + (acos(clamp(_4037 / (_4060 * sqrt(dot(_4039, _4039))), -1.0, 1.0)) - (acos(clamp((_4037 * _4024) / (_4038 * _4060), -1.0, 1.0)) * _4024)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _4024)))));
        _4125 = _4124;
    }
    else
    {
        _4125 = _4001;
    }
    vec3 _4137 = _415.xyz;
    vec3 _4168;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _4168 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_407, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_4002 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _4137) * _1781.w) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _4168 = vec3(0.0);
    }
    vec3 _4189 = (_4000 + _737) + (((_1781.xyz * _4137) + _4168) + spvNMax(vec3(0.0), _4125 / vec3(spvNMax(10.0, spvNMax(_4125.x, spvNMax(_4125.y, _4125.z))) * 0.100000001490116119384765625)));
    vec4 _4190 = vec4(_4189.x, _4189.y, _4189.z, vec4(0.0).w);
    _4190.w = _1364;
    vec3 _4192 = in_var_TEXCOORD0.xyz - in_var_AUTO_CEOBGMGP_GEBKIEDD;
    vec4 _4195 = vec4(_4192.x, _4192.y, _4192.z, _301.w);
    _4195.w = 1.0;
    vec4 _4197 = cpass_cb.last_view_projection_transform * _4195;
    vec2 _4203 = ((_4197 / vec4(_4197.w)).xy * 0.5) + vec2(0.5);
    out_var_SV_TARGET = _4190;
    out_var_SV_TARGET2 = vec4((_4000 * cpass_cb.indirect_light_multiplier) + (_737 * 20.0), _1364);
    out_var_SV_TARGET1 = vec4(((_1389 - vec3(_4203.x, 1.0 - _4203.y, _300)) * vec3(ivec3(ivec2(uvec2((cpass_cb.frame_resolution.xy * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))), 0))).xy, 0.0, 0.0);
}

