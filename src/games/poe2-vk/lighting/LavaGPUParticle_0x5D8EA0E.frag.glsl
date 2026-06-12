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
    vec4 performance_overlay_data;
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

float _267;
float _273;

layout(set = 9, binding = 0, std140) uniform type_cpass_cb
{
    mat4 breach_sphere_infos;
    mat4 env_map_rotation;
    mat4 last_view_projection_transform;
    mat4 scene_projection_transform;
    mat4 scene_projection_transform_inv;
    mat4 scene_view_projection_transform;
    mat4 scene_view_projection_transform_inv;
    mat4 scene_view_projection_transform_nopost;
    mat4 scene_view_transform;
    mat4 scene_view_transform_inv;
    mat4 worldspace_view_proj;
    mat4 worldspace_view_proj_inv;
    vec4 affliction_pos;
    vec4 affliction_radii;
    vec4 ambient_light_color;
    vec4 ambient_light_dir;
    vec4 azmeri_planar_minmax;
    vec4 blight_tex_size;
    vec4 clouds_velocity;
    vec4 cube_brightness;
    vec4 dust_color;
    vec4 flood_wave_size;
    vec4 fog_flowmap_planar_aabb;
    vec4 fog_flowmap_tex_size;
    vec4 fog_flowmap_world_size;
    vec4 frame_delta_time;
    vec4 frame_resolution;
    vec4 frame_to_dynamic_scale;
    vec4 ground_scalemove_uv;
    vec4 guiding_fog_planar_aabb;
    vec4 heightmap_tex_size;
    vec4 heightmap_world_size;
    vec4 infinite_hunger_arena_water_level;
    vec4 player_position;
    vec4 rain_fall_dir;
    vec4 ritual_planar_minmax;
    vec4 river_flowmap_planar_aabb;
    vec4 scene_planar_size;
    vec4 shoreline_coord_planar_aabb;
    vec4 shoreline_coord_tex_size;
    vec4 specular_cube_size;
    vec4 ssf_color;
    ivec4 volumetric_fx_grid_size;
    vec4 walkability_tex_size;
    vec4 water_color_open;
    vec4 water_color_terrain;
    vec4 water_wind_direction;
    vec3 ground_speed;
    uint water_use_downsampling;
    vec3 scene_camera_forward_vector;
    uint water_debug;
    vec3 scene_camera_position;
    uint use_double_sided;
    vec3 scene_camera_right_vector;
    uint use_4x_scaling;
    vec3 scene_camera_up_vector;
    uint ssgi_detail;
    vec3 ssf_layercount_thickness_turbulence;
    uint specular_cube_enabled;
    ivec3 volumetric_fx_grid_emit_pos;
    uint scene_use_parabolic_projection;
    ivec3 volumetric_fx_grid_pos;
    uint gi_self_lighting;
    ivec2 base_atlas_size;
    uint enable_mvec;
    uint diffuse_cube_enabled;
    ivec2 burn_tex_size;
    float worldspace_units_per_pixel;
    float world_map_zoom;
    ivec2 downscaled_dynamic_size;
    float water_wind_speed;
    float water_wind_intensity;
    ivec2 dynamic_size;
    float water_swell_period;
    float water_swell_intensity;
    ivec2 frame_size;
    float water_swell_height;
    float water_swell_angle;
    vec2 heightmap_world_pos;
    float water_subsurface_scattering;
    float water_refraction_index;
    vec2 mouse_pos;
    float water_reflectiveness;
    float water_height_offset;
    ivec2 sh_atlas_size;
    float water_flow_intensity;
    float water_flow_foam;
    vec2 ssf_disperse_radius_feathering;
    float water_dispersion;
    float water_directionness;
    int base_probe_spacing;
    float water_clarity;
    float water_caustics_mult;
    float tool_time;
    float clouds_fade_radius;
    float time;
    float sum_longitude;
    float ssgi_intensity;
    float clouds_intensity;
    float ssgi_debug;
    int sh_probe_spacing;
    float scene_depth_bias_scale;
    float clouds_midpoint;
    float rain_turbulence;
    float rain_intensity;
    float rain_dist;
    float clouds_post_fade;
    float rain_amount;
    int pass_type;
    int pass_downscale;
    float clouds_pre_fade;
    float numerical_normal;
    float lake_mist_intensity;
    float indirect_light_multiplier;
    float clouds_scale;
    float gi_env_occlusion;
    uint frame_index;
    float flow_to_color;
    float clouds_sharpness;
    float exposure;
    uint emulated_platform;
    float dist_to_color;
    float current_time;
    float direct_light_env_ratio;
    float depth_sampler_type;
    float debug_overlay_strength;
} cpass_cb;

layout(set = 10, binding = 0, std140) uniform type_cpipeline_cb
{
    spline5 constant_track5_1;
    spline5 constant_track5_3;
    spline5 constant_track5_2;
    spline5 constant_track5_5;
    vec4 alpha_test_desc;
    ivec4 constant_trackC_0;
    vec2 constant2_4;
    uint constant_bool_2;
    uint constant_bool_3;
    vec2 maya_scale_pivot_0;
    uint constant_bool_1;
    uint constant_bool_0;
    vec2 constant2_13;
    uint gpu_particle_dyn_culling;
    float constant1_0;
    vec2 constant2_10;
    float constant1_1;
    float constant1_2;
    vec2 constant2_9;
    float constant1_12;
    uint constantUInt1_102;
    vec2 constant2_8;
    float constant1_10;
    int constant_trackG_3;
    vec2 constant2_12;
    float constant1_9;
    int constant_trackG_2;
    vec2 constant2_11;
    int constant_trackG_1;
    int constant_trackG_0;
    vec2 constant2_7;
    float brightness_0;
    float saturation_0;
    vec2 constant2_6;
    float hue_0;
    float constant_pixel_3;
    uint frame_material_id;
    uint constantUInt1_6;
    float constant1_4;
    uint constantUInt1_4;
    uint constantUInt1_0;
    uint constantUInt1_2;
} cpipeline_cb;

layout(set = 11, binding = 0, std140) uniform type_cobject_cb
{
    uint instance_count;
    uint batch_size;
    uint padding0;
    uint padding1;
    InstanceData instances[16];
} cobject_cb;

layout(set = 1, binding = 10, std430) readonly buffer type_StructuredBuffer_LightInfo
{
    LightInfo _m0[];
} dynamic_light_infos;

layout(set = 1, binding = 25, std430) readonly buffer type_StructuredBuffer_PointLightInfo
{
    PointLightInfo _m0[];
} point_light_infos;

layout(set = 1, binding = 32, std430) readonly buffer type_StructuredBuffer_LUTData
{
    LUTData _m0[];
} spline_lut;

layout(set = 2, binding = 42, std430) readonly buffer type_StructuredBuffer_ParticleData
{
    ParticleData _m0[];
} particles_data_read;

layout(set = 2, binding = 45, std430) readonly buffer type_StructuredBuffer_ParticleEmitterData
{
    ParticleEmitterData _m0[];
} particles_emitter_data;

layout(set = 0, binding = 0) uniform sampler SamplerLinearWrap;
layout(set = 0, binding = 1) uniform sampler SamplerLinearClamp;
layout(set = 0, binding = 7) uniform sampler SamplerDynamicWrap;
layout(set = 0, binding = 8) uniform sampler SamplerLinearWrapNoBias;
layout(set = 0, binding = 9) uniform sampler SamplerLinearClampNoBias;
layout(set = 0, binding = 15) uniform samplerShadow SamplerDepth;
layout(set = 1, binding = 8) uniform textureCube diffuse_cube;
layout(set = 1, binding = 11) uniform texture2D environment_ggx_sampler;
layout(set = 1, binding = 18) uniform usamplerBuffer light_indices;
layout(set = 1, binding = 19) uniform utexture2D light_lookup;
layout(set = 1, binding = 21) uniform texture2D noise_sampler;
layout(set = 1, binding = 31) uniform textureCube specular_cube;
layout(set = 1, binding = 34) uniform texture2D tex_shadow_map_atlas;
layout(set = 2, binding = 47) uniform texture2D muddle_texture_0;
layout(set = 2, binding = 48) uniform texture2D texture_object_0;
layout(set = 2, binding = 49) uniform texture2D input_texture_0;
layout(set = 3, binding = 53) uniform texture2D tile_ground_normal_texture;

layout(location = 0) flat in uint in_var_AUTO_EFMAIHMN_BABABNNF;
layout(location = 1) in vec4 in_var_AUTO_BOAEJOBF_ANHFJCCP;
layout(location = 2) in vec2 in_var_AUTO_CELDJDLE_GEBKIEDD;
layout(location = 3) in float in_var_AUTO_PIPJIEKO_CIFEPFLO;
layout(location = 4) in float in_var_AUTO_PIPJIEKO_IINFNGPI;
layout(location = 5) in float in_var_AUTO_PIPJIEKO_EIDIDJP;
layout(location = 6) in float in_var_AUTO_PIPJIEKO_LDBDDLHP;
layout(location = 8) flat in uint in_var_INSTANCEID;
layout(location = 9) in vec4 in_var_TEXCOORD0;
layout(location = 10) in vec2 in_var_TEXCOORD1;
layout(location = 11) in vec3 in_var_TEXCOORD5;
layout(location = 12) in vec3 in_var_TEXCOORD6;
layout(location = 13) in vec3 in_var_TEXCOORD7;
layout(location = 0) out vec4 out_var_SV_TARGET;
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
    vec2 _308 = unpackHalf2x16((particles_data_read._m0[in_var_AUTO_EFMAIHMN_BABABNNF].angular_velocity.y >> 16u) & 65535u);
    float _309 = _308.x;
    vec4 _318 = texture(sampler2D(muddle_texture_0, SamplerLinearWrap), (in_var_TEXCOORD1 * 1.0) + (vec2(-0.0199999995529651641845703125, 0.0199999995529651641845703125) * cpass_cb.time));
    vec2 _328 = vec2(cpipeline_cb.maya_scale_pivot_0.x, 1.0 - cpipeline_cb.maya_scale_pivot_0.y);
    vec2 _344 = ((((in_var_TEXCOORD1 + ((_318.xy - vec2(0.5)) * 0.0199999995529651641845703125)) - _328) * vec2(1.0, 0.5)) + _328) + (vec2((cpipeline_cb.constant_bool_1 != 0u) ? pow(spvNMax(abs(in_var_AUTO_BOAEJOBF_ANHFJCCP.w), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_4) : cpass_cb.time) * vec2(0.0, -0.100000001490116119384765625));
    mat3 _345 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _359 = ((vec2(textureLod(sampler2D(texture_object_0, SamplerDynamicWrap), vec4(_344, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _360 = vec3(_359.x, _359.y, vec3(0.0).z);
    vec2 _361 = _359.xy;
    _360.z = sqrt(spvNMax(1.0 - dot(_361, _361), 0.0));
    vec3 _367 = _345 * _360;
    vec4 _373 = texture(sampler2D(texture_object_0, SamplerDynamicWrap), _344);
    float _374 = _373.z;
    vec3 _379 = vec3(pow(spvNMax(abs(_374), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_367 / vec3(length(_367) + 1.0000000116860974230803549289703e-07));
    vec4 _382 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _344);
    vec3 _383 = _382.xyz;
    vec3 _385 = vec3(_382.w);
    vec3 _387 = clamp(mix(_383, vec3(0.0), _385), vec3(0.0), vec3(1.0));
    vec2 _393 = ((vec2(_373.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _394 = vec3(_393.x, _393.y, vec3(0.0).z);
    vec2 _395 = _393.xy;
    _394.z = sqrt(spvNMax(1.0 - dot(_395, _395), 0.0));
    float _401 = _373.w;
    float _410 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _411 = cos(_410);
    vec3 _426 = (((_383 * _411) + (cross(vec3(0.57735002040863037109375), _383) * sin(_410))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _383)) * (1.0 - _411))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _434 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_426, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _426, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _385), vec3(0.0), vec3(1.0));
    bool _437 = cpipeline_cb.constant_trackG_0 < 0;
    float _439 = clamp(_374, 0.0, 1.0) * 127.0;
    int _443 = int(spvNMax(trunc(_439), 0.0) + 0.5);
    int _448 = int(spvNMin(trunc(_439 + 1.0), 127.0) + 0.5);
    float _466;
    if (_437)
    {
        _466 = 0.0;
    }
    else
    {
        uint _452 = uint(cpipeline_cb.constant_trackG_0);
        int _453 = _443 / 2;
        _466 = ((_443 - 2 * (_443 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_452].value[_453] & 65535u).x : unpackHalf2x16((spline_lut._m0[_452].value[_453] >> 16u) & 65535u).x;
    }
    float _484;
    if (_437)
    {
        _484 = 0.0;
    }
    else
    {
        uint _470 = uint(cpipeline_cb.constant_trackG_0);
        int _471 = _448 / 2;
        _484 = ((_448 - 2 * (_448 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_470].value[_471] & 65535u).x : unpackHalf2x16((spline_lut._m0[_470].value[_471] >> 16u) & 65535u).x;
    }
    float _485 = fract(_439);
    bool _491 = cpipeline_cb.constant_trackG_1 < 0;
    float _509;
    if (_491)
    {
        _509 = 0.0;
    }
    else
    {
        uint _495 = uint(cpipeline_cb.constant_trackG_1);
        int _496 = _443 / 2;
        _509 = ((_443 - 2 * (_443 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_495].value[_496] & 65535u).x : unpackHalf2x16((spline_lut._m0[_495].value[_496] >> 16u) & 65535u).x;
    }
    float _527;
    if (_491)
    {
        _527 = 0.0;
    }
    else
    {
        uint _513 = uint(cpipeline_cb.constant_trackG_1);
        int _514 = _448 / 2;
        _527 = ((_448 - 2 * (_448 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_513].value[_514] & 65535u).x : unpackHalf2x16((spline_lut._m0[_513].value[_514] >> 16u) & 65535u).x;
    }
    float _536 = clamp((spvNMax(vec3(mix(_466, _484, _485), _273, _273), vec3(0.0)) + spvNMax(vec3(mix(_509, _527, _485), _273, _273), vec3(0.0))).x, 0.0, 1.0) * 127.0;
    int _541 = int(spvNMax(trunc(_536), 0.0) + 0.5);
    int _546 = int(spvNMin(trunc(_536 + 1.0), 127.0) + 0.5);
    bool _547 = cpipeline_cb.constant_trackC_0.x < 0;
    float _565;
    if (_547)
    {
        _565 = 0.0;
    }
    else
    {
        uint _551 = uint(cpipeline_cb.constant_trackC_0.x);
        int _552 = _541 / 2;
        _565 = ((_541 - 2 * (_541 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_551].value[_552] & 65535u).x : unpackHalf2x16((spline_lut._m0[_551].value[_552] >> 16u) & 65535u).x;
    }
    float _583;
    if (_547)
    {
        _583 = 0.0;
    }
    else
    {
        uint _569 = uint(cpipeline_cb.constant_trackC_0.x);
        int _570 = _546 / 2;
        _583 = ((_546 - 2 * (_546 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_569].value[_570] & 65535u).x : unpackHalf2x16((spline_lut._m0[_569].value[_570] >> 16u) & 65535u).x;
    }
    float _584 = fract(_536);
    bool _587 = cpipeline_cb.constant_trackC_0.y < 0;
    float _605;
    if (_587)
    {
        _605 = 0.0;
    }
    else
    {
        uint _591 = uint(cpipeline_cb.constant_trackC_0.y);
        int _592 = _541 / 2;
        _605 = ((_541 - 2 * (_541 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_591].value[_592] & 65535u).x : unpackHalf2x16((spline_lut._m0[_591].value[_592] >> 16u) & 65535u).x;
    }
    float _623;
    if (_587)
    {
        _623 = 0.0;
    }
    else
    {
        uint _609 = uint(cpipeline_cb.constant_trackC_0.y);
        int _610 = _546 / 2;
        _623 = ((_546 - 2 * (_546 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_609].value[_610] & 65535u).x : unpackHalf2x16((spline_lut._m0[_609].value[_610] >> 16u) & 65535u).x;
    }
    bool _626 = cpipeline_cb.constant_trackC_0.z < 0;
    float _644;
    if (_626)
    {
        _644 = 0.0;
    }
    else
    {
        uint _630 = uint(cpipeline_cb.constant_trackC_0.z);
        int _631 = _541 / 2;
        _644 = ((_541 - 2 * (_541 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_630].value[_631] & 65535u).x : unpackHalf2x16((spline_lut._m0[_630].value[_631] >> 16u) & 65535u).x;
    }
    float _662;
    if (_626)
    {
        _662 = 0.0;
    }
    else
    {
        uint _648 = uint(cpipeline_cb.constant_trackC_0.z);
        int _649 = _546 / 2;
        _662 = ((_546 - 2 * (_546 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_648].value[_649] & 65535u).x : unpackHalf2x16((spline_lut._m0[_648].value[_649] >> 16u) & 65535u).x;
    }
    bool _665 = cpipeline_cb.constant_trackC_0.w < 0;
    float _683;
    if (_665)
    {
        _683 = 0.0;
    }
    else
    {
        uint _669 = uint(cpipeline_cb.constant_trackC_0.w);
        int _670 = _541 / 2;
        _683 = ((_541 - 2 * (_541 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_669].value[_670] & 65535u).x : unpackHalf2x16((spline_lut._m0[_669].value[_670] >> 16u) & 65535u).x;
    }
    float _701;
    if (_665)
    {
        _701 = 0.0;
    }
    else
    {
        uint _687 = uint(cpipeline_cb.constant_trackC_0.w);
        int _688 = _546 / 2;
        _701 = ((_546 - 2 * (_546 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_687].value[_688] & 65535u).x : unpackHalf2x16((spline_lut._m0[_687].value[_688] >> 16u) & 65535u).x;
    }
    float _702 = mix(_683, _701, _584);
    vec3 _709 = spvNMin((vec4(mix(_565, _583, _584), mix(_605, _623, _584), mix(_644, _662, _584), _702).xyz * vec3(spvNMax(_702, 0.0))) * 5.0, vec3(100.0));
    bool _712 = cpipeline_cb.constant_trackG_2 < 0;
    float _730;
    if (_712)
    {
        _730 = 0.0;
    }
    else
    {
        uint _716 = uint(cpipeline_cb.constant_trackG_2);
        int _717 = _443 / 2;
        _730 = ((_443 - 2 * (_443 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_716].value[_717] & 65535u).x : unpackHalf2x16((spline_lut._m0[_716].value[_717] >> 16u) & 65535u).x;
    }
    float _748;
    if (_712)
    {
        _748 = 0.0;
    }
    else
    {
        uint _734 = uint(cpipeline_cb.constant_trackG_2);
        int _735 = _448 / 2;
        _748 = ((_448 - 2 * (_448 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_734].value[_735] & 65535u).x : unpackHalf2x16((spline_lut._m0[_734].value[_735] >> 16u) & 65535u).x;
    }
    uint _762 = in_var_INSTANCEID / cobject_cb.instance_count;
    float _772 = (cpipeline_cb.constant_bool_2 != 0u) ? clamp(uintBitsToFloat((uint(cobject_cb.instances[_762].synced_random_seed.x) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0) : _309;
    uvec3 _776 = (floatBitsToUint(vec3(_772, 0.0698473453521728515625, 0.64344775676727294921875)) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _777 = _776.y;
    uint _778 = _776.z;
    uint _781 = _776.x + (_777 * _778);
    uint _783 = _777 + (_778 * _781);
    uvec3 _786 = uvec3(_781, _783, _778 + (_781 * _783));
    uvec3 _788 = _786 ^ (_786 >> uvec3(16u));
    uint _789 = _788.y;
    uint _790 = _788.z;
    uint _793 = _788.x + (_789 * _790);
    uint _795 = _789 + (_790 * _793);
    vec3 _833 = vec3(0.0698473453521728515625, 0.0, 0.0);
    _833.y = _772;
    _833.z = 0.64344775676727294921875;
    uvec3 _837 = (floatBitsToUint(_833) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _838 = _837.y;
    uint _839 = _837.z;
    uint _842 = _837.x + (_838 * _839);
    uint _844 = _838 + (_839 * _842);
    uvec3 _847 = uvec3(_842, _844, _839 + (_842 * _844));
    uvec3 _849 = _847 ^ (_847 >> uvec3(16u));
    vec2 _865 = vec2(mix(cpipeline_cb.constant2_9.x, cpipeline_cb.constant2_9.y, clamp(uintBitsToFloat(((_849.x + (_849.y * _849.z)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0)));
    vec4 _907 = texture(sampler2D(tile_ground_normal_texture, SamplerLinearWrap), (cobject_cb.instances[_762].tile_ground_tiling * in_var_TEXCOORD0.xy) * cpass_cb.ground_scalemove_uv.xy);
    vec2 _914;
    if (cobject_cb.instances[_762].tile_ground_normal_swizzle == 1u)
    {
        _914 = _907.wy;
    }
    else
    {
        _914 = _907.xy;
    }
    float _932 = clamp(pow(spvNMax(abs(clamp((((in_var_AUTO_CELDJDLE_GEBKIEDD + (((vec4(_273, _914.y, _267, _267).xy - vec2(0.5)) * vec2(2.0)) * vec2(mix(cpipeline_cb.constant2_6.x, cpipeline_cb.constant2_6.y, clamp(uintBitsToFloat((_793 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (_394.xy * vec2(mix(cpipeline_cb.constant2_7.x, cpipeline_cb.constant2_7.y, clamp(uintBitsToFloat(((_790 + (_793 * _795)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (mix(mix(vec2(-1.0), vec2(0.0), vec2(cpipeline_cb.constant2_8.x)), vec2(-1.0), vec2(cpipeline_cb.constant2_8.y)) * mix(mix(_865, _865 * in_var_AUTO_CELDJDLE_GEBKIEDD, vec2(cpipeline_cb.constant2_10.x)), vec2(1.0) - in_var_AUTO_CELDJDLE_GEBKIEDD, vec2(cpipeline_cb.constant2_10.y)))).y, 0.0, 1.0)), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_9), 0.0, 1.0);
    float _933 = _932 * 127.0;
    int _937 = int(spvNMax(trunc(_933), 0.0) + 0.5);
    int _942 = int(spvNMin(trunc(_933 + 1.0), 127.0) + 0.5);
    bool _943 = cpipeline_cb.constant_trackG_3 < 0;
    float _961;
    if (_943)
    {
        _961 = 0.0;
    }
    else
    {
        uint _947 = uint(cpipeline_cb.constant_trackG_3);
        int _948 = _937 / 2;
        _961 = ((_937 - 2 * (_937 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_947].value[_948] & 65535u).x : unpackHalf2x16((spline_lut._m0[_947].value[_948] >> 16u) & 65535u).x;
    }
    float _979;
    if (_943)
    {
        _979 = 0.0;
    }
    else
    {
        uint _965 = uint(cpipeline_cb.constant_trackG_3);
        int _966 = _942 / 2;
        _979 = ((_942 - 2 * (_942 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_965].value[_966] & 65535u).x : unpackHalf2x16((spline_lut._m0[_965].value[_966] >> 16u) & 65535u).x;
    }
    float _982 = mix(_961, _979, fract(_933)) - clamp(-(((((0.2989999949932098388671875 * _393.x) + (0.58700001239776611328125 * _393.y)) - 0.5) * 2.0) * mix(cpipeline_cb.constant2_13.x, cpipeline_cb.constant2_13.y, clamp(uintBitsToFloat((_795 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))), 0.0, 1.0);
    float _990 = clamp((vec3(clamp(spvNMax(vec3(mix(_730, _748, _485), _273, _273), vec3(0.0)).x, 0.0, 1.0)) * vec3((cpipeline_cb.constant_bool_3 != 0u) ? spvNMax(_982, 0.0) : clamp(_982, 0.0, 1.0))).x, 0.0, 1.0);
    float _991 = spvNMax(0.001000000047497451305389404296875, 0.34899997711181640625);
    float _994 = clamp((2.0 / _991) - 1.0, -100000.0, 100000.0);
    float _1007 = 0.949999988079071044921875 + ((pow(clamp((1.0 - spvNMax(0.0500000007450580596923828125, _990)) * 1.0526316165924072265625, 0.0, 1.0), _994) * (-0.949999988079071044921875)) + (pow(clamp(spvNMin(0.0500000007450580596923828125, _990) * 20.0, 0.0, 1.0), _994) * 0.0500000007450580596923828125));
    float _1010 = clamp(isnan(_1007) ? 0.0500000007450580596923828125 : _1007, 0.0, 1.0);
    float _1014;
    _1014 = 0.0;
    float _1015;
    for (uint _1017 = 0u; _1017 < 1u; _1014 = _1015, _1017++)
    {
        uint _1022 = cpipeline_cb.constantUInt1_102 / 4u;
        uint _1023 = cpipeline_cb.constantUInt1_102 % 4u;
        vec4 _1052;
        if (!(((particles_emitter_data._m0[cobject_cb.instances[_762].gpu_particle_emitter].culling_tag >> 14u) & 512u) == 0u))
        {
            vec4 _1051;
            if (floatBitsToUint(cpass_cb.frame_delta_time.w) == 0u)
            {
                _1051 = vec4(_273, 0.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            else
            {
                _1051 = vec4(0.0, 1.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            _1052 = _1051;
        }
        else
        {
            _1052 = cpass_cb.frame_delta_time;
        }
        float _1060 = mix(particles_emitter_data._m0[cobject_cb.instances[_762].gpu_particle_emitter].prev_time, particles_emitter_data._m0[cobject_cb.instances[_762].gpu_particle_emitter].time, _1052.z) / particles_emitter_data._m0[cobject_cb.instances[_762].gpu_particle_emitter].emitter_duration;
        float _1061 = spvNMax(0.0, _1060);
        float _1067;
        if (((particles_emitter_data._m0[cobject_cb.instances[_762].gpu_particle_emitter].culling_tag >> 14u) & 2u) != 0u)
        {
            _1067 = fract(_1061);
        }
        else
        {
            _1067 = _1061;
        }
        float _1074 = spvNMax(cpipeline_cb.constant1_12, 9.9999997473787516355514526367188e-05);
        float _1081;
        if (abs(_1074) > 0.0)
        {
            _1081 = in_var_AUTO_PIPJIEKO_LDBDDLHP / _1074;
        }
        else
        {
            _1081 = 0.0;
        }
        float _1088;
        if (_1023 == 0u)
        {
            _1088 = _1081;
        }
        else
        {
            _1088 = (_1023 == 1u) ? clamp((abs(particles_emitter_data._m0[cobject_cb.instances[_762].gpu_particle_emitter].emitter_duration) > 0.0) ? _1060 : 0.0, 0.0, 1.0) : 0.0;
        }
        float _1096;
        if (abs(cobject_cb.instances[_762].gpu_particles_duration.x) > 0.0)
        {
            _1096 = (in_var_AUTO_PIPJIEKO_CIFEPFLO * in_var_AUTO_PIPJIEKO_EIDIDJP) / cobject_cb.instances[_762].gpu_particles_duration.x;
        }
        else
        {
            _1096 = 0.0;
        }
        float _1113;
        if (cpipeline_cb.constantUInt1_102 == 0u)
        {
            _1113 = in_var_AUTO_PIPJIEKO_CIFEPFLO;
        }
        else
        {
            float _1112;
            if (cpipeline_cb.constantUInt1_102 == 1u)
            {
                _1112 = _1067;
            }
            else
            {
                float _1111;
                if (cpipeline_cb.constantUInt1_102 == 2u)
                {
                    _1111 = in_var_AUTO_PIPJIEKO_IINFNGPI;
                }
                else
                {
                    _1111 = (cpipeline_cb.constantUInt1_102 == 3u) ? _1096 : 0.0;
                }
                _1112 = _1111;
            }
            _1113 = _1112;
        }
        if (_1022 == 0u)
        {
            _1015 = _1113;
        }
        else
        {
            _1015 = (_1022 == 1u) ? _1088 : 0.0;
        }
    }
    float _1123 = clamp(_1014, 0.0, 1.0);
    float _1133 = _1123 * _1123;
    float _1144 = spvNMax(dot(cpipeline_cb.constant_track5_5.segment_polynom[(_1123 < cpipeline_cb.constant_track5_5.time_variance.x) ? 0u : ((_1123 < cpipeline_cb.constant_track5_5.time_variance.y) ? 1u : ((_1123 < cpipeline_cb.constant_track5_5.time_variance.z) ? 2u : 3u))], vec4(_1133 * _1123, _1133, _1123, 1.0)) + (((_309 - 0.5) * 2.0) * cpipeline_cb.constant_track5_5.time_variance.w), 0.0);
    float _1151 = clamp(clamp(mix(_1010 * _1144, _1010 - (1.0 - _1144), 0.25), 0.0, 1.0) * 5.0, 0.0, 1.0);
    vec3 _1152 = _345 * _394;
    if (((_1151 - cpipeline_cb.alpha_test_desc.y) + 0.001000000047497451305389404296875) < 0.0)
    {
        discard;
    }
    vec3 _1163 = _1152 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_1152)));
    vec3 _1167 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _1168 = reflect(_1167, _1163);
    uvec4 _1181 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _1182 = _1181.x;
    uint _1183 = _1181.y;
    vec3 _1188;
    vec3 _1190;
    vec3 _1192;
    _1188 = vec3(0.0);
    _1190 = vec3(0.0);
    _1192 = vec3(0.0);
    uint _1186;
    vec3 _1189;
    vec3 _1191;
    vec3 _1193;
    for (uint _1185 = _1182, _1194 = 0u; _1194 < _1183; _1185 = _1186, _1188 = _1189, _1190 = _1191, _1192 = _1193, _1194++)
    {
        _1186 = _1185 + 1u;
        uvec4 _1200 = texelFetch(light_indices, int(_1185));
        uint _1201 = _1200.x;
        vec4 _1220;
        if (point_light_infos._m0[_1201].channel_index > (-0.5))
        {
            vec4 _1219;
            if (point_light_infos._m0[_1201].channel_index >= 2.5)
            {
                _1219 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1218;
                if (point_light_infos._m0[_1201].channel_index >= 1.5)
                {
                    _1218 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1218 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1201].channel_index >= 0.5));
                }
                _1219 = _1218;
            }
            _1220 = _1219;
        }
        else
        {
            _1220 = vec4(0.0);
        }
        vec3 _1250 = vec4(point_light_infos._m0[_1201].position, point_light_infos._m0[_1201].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1251 = length(_1250);
        vec3 _1253 = _1250 / vec3(_1251);
        vec3 _1254 = vec4(point_light_infos._m0[_1201].color, point_light_infos._m0[_1201].median_radius).xyz;
        float _1261 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1201].channel_index, 0.0, 1.0));
        float _1266 = (_1251 / (point_light_infos._m0[_1201].median_radius / _1261)) + 1.0;
        float _1267 = _1251 / (point_light_infos._m0[_1201].median_radius * sqrt(dot(abs(_1254), vec3(1.0)) * 2.0));
        float _1272 = clamp(1.0 - (((_1267 * _1267) * _1267) * _1267), 0.0, 1.0);
        vec3 _1279 = (_1254 * spvNMin(10.0, (((0.199999988079071044921875 * _1261) * _1261) * (_1272 * _1272)) / (_1266 * _1266))) * (dot(vec4(1.0), _1220) * clamp((dot(-normalize(_379), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1201].position)) - (1.0 - length(_379))) * 2.5, 0.0, 1.0));
        if (length(_1279) > 0.0)
        {
            float _1285 = clamp(dot(_1253, _1163), 0.0, 1.0);
            float _1288 = clamp(1.0 - _401, 0.0, 1.0);
            float _1290 = spvNMax(_1288 * _1288, 0.00200000009499490261077880859375);
            float _1291 = _1290 * _1290;
            vec3 _1292 = -_1167;
            vec3 _1294 = normalize(_1292 + _1253);
            float _1296 = clamp(dot(_1163, _1294), 0.0, 1.0);
            float _1300 = clamp(dot(_1292, _1294), 0.0, 1.0);
            float _1307 = _1290 * 0.5;
            float _1308 = 1.0 - _1307;
            _1189 = _1188 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1300) - 6.9831600189208984375) * _1300)), vec3(1.0), _434) * (_1291 / pow((((_1291 - 1.0) * _1296) * _1296) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1292, _1163), 0.0, 1.0) * _1308) + _1307) * ((_1285 * _1308) + _1307)))) * _1285) * vec3(0.25)) * _1279);
            _1191 = _1190 + ((_1279 * _1285) * _387.xyz);
            _1193 = _1192 + _1279;
        }
        else
        {
            _1189 = _1188;
            _1191 = _1190;
            _1193 = _1192;
        }
    }
    uvec4 _1333 = uvec4(cobject_cb.instances[_762].dynamic_light_indices);
    uint _1334 = _1333.x;
    uint _1337 = uint(dynamic_light_infos._m0[_1334].light_type.x);
    uint _1338 = _1333.y;
    uint _1341 = uint(dynamic_light_infos._m0[_1338].light_type.x);
    uint _1342 = _1333.z;
    uint _1345 = uint(dynamic_light_infos._m0[_1342].light_type.x);
    uint _1346 = _1333.w;
    uint _1349 = uint(dynamic_light_infos._m0[_1346].light_type.x);
    vec4 _1744;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1334].shadow_enabled.x > 0.0)
    {
        vec4 _1358 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1742;
        do
        {
            vec4 _1368 = dynamic_light_infos._m0[_1334].light_matrix * _1358;
            vec3 _1425;
            if (_1337 == 2u)
            {
                vec3 _1389 = _1368.xyz;
                vec3 _1391 = normalize(_1389) + vec3(0.0, 0.0, 1.0);
                float _1395 = length(_1389);
                vec3 _1398 = vec3((_1391 / vec3(_1391.z)).xy, _1395);
                float _1399 = _1368.z;
                vec3 _1411;
                if (_1399 > 0.0)
                {
                    _1411 = _1398;
                }
                else
                {
                    _1411 = vec3(normalize(_1398.xy) * 10000000.0, -_1395);
                }
                vec3 _1419 = vec3((_1411.x * 0.5) + 0.5, 0.5 - (_1411.y * 0.5), _1411.z);
                _1419.z = _1411.z * 9.9999997473787516355514526367188e-05;
                if (_1399 < 0.0)
                {
                    _1742 = 0.0;
                    break;
                }
                _1425 = _1419;
            }
            else
            {
                vec3 _1373 = _1368.xyz;
                vec3 _1385;
                if (_1337 == 1u)
                {
                    float _1377 = _1368.z;
                    vec3 _1384 = _1373;
                    _1384.z = _1377 - (((_1377 * dynamic_light_infos._m0[_1334].shadow_scale.z) + 1.0) / _1368.w);
                    _1385 = _1384;
                }
                else
                {
                    _1385 = _1373;
                }
                _1425 = _1385 / vec3(_1368.w);
            }
            float _1535;
            if (dynamic_light_infos._m0[_1334].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1517 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1425.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1425.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1425.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1425.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1334].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1425.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1425.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1334].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1425.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1425.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1334].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1425.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1425.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1334].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1425.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1425.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1334].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1535 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1334].shadow_scale.w * spvNMax(_1517, _1425.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1425.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1334].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1535 = 1.0;
            }
            vec3 _1536 = dFdx(_1425);
            vec3 _1537 = dFdy(_1425);
            vec3 _1551 = _1425 + ((normalize(cross(_1536, _1537)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _267) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw)).x);
            vec2 _1552 = dynamic_light_infos._m0[_1334].shadow_scale.xy * _1535;
            vec2 _1553 = _1551.xy;
            float _1558 = _1551.z;
            float _1637 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1553, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, _1558, 1.0).xy, _1558), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1553 + (vec2(1.0, 0.0) * _1552), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, _1558, 1.0).xy, _1558), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1553 + (vec2(0.5, 0.865999996662139892578125) * _1552), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, _1558, 1.0).xy, _1558), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1553 + (vec2(-0.5, 0.865999996662139892578125) * _1552), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, _1558, 1.0).xy, _1558), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1553 + (vec2(-1.0, -0.0) * _1552), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, _1558, 1.0).xy, _1558), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1553 + (vec2(-0.5, -0.865999996662139892578125) * _1552), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, _1558, 1.0).xy, _1558), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1553 + (vec2(0.5, -0.865999996662139892578125) * _1552), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1334].shadow_atlas_offset_scale.xy, _1558, 1.0).xy, _1558), 0.0);
            float _1638 = _1637 * 0.14285714924335479736328125;
            float _1741;
            if (_1337 == 0u)
            {
                float _1653 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1358.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1655 = transpose(dynamic_light_infos._m0[_1334].light_matrix)[2];
                float _1660 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1669;
                if (_1660 > 0.100000001490116119384765625)
                {
                    _1669 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1669 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1680 = _1358.xyz - ((_1655.xyz / vec3(_1655.z)) * 1000.0);
                float _1704 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1669, _1680), dot(normalize(vec3(-_1669.y, _1669.x, 0.0)), _1680)) + (vec2(_1660, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1653 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1711 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1712 = _1711 - 1.0;
                float _1713 = 1.0 - cpass_cb.clouds_midpoint;
                float _1720 = 2.0 - _1711;
                _1741 = _1638 * mix(1.0, clamp(clamp(_1713 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1704), 0.0, 1.0), _1712)) * pow(clamp(_1713, 0.0, 1.0), _1720)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1704), 0.0, 1.0), _1712) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1720))), 0.0, 1.0) + (_1653 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1741 = _1638;
            }
            _1742 = _1741;
            break;
        } while(false);
        vec4 _1743 = vec4(1.0);
        _1743.x = _1742;
        _1744 = _1743;
    }
    else
    {
        _1744 = vec4(1.0);
    }
    vec4 _2139;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1338].shadow_enabled.x > 0.0)
    {
        vec4 _1753 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2137;
        do
        {
            vec4 _1763 = dynamic_light_infos._m0[_1338].light_matrix * _1753;
            vec3 _1820;
            if (_1341 == 2u)
            {
                vec3 _1784 = _1763.xyz;
                vec3 _1786 = normalize(_1784) + vec3(0.0, 0.0, 1.0);
                float _1790 = length(_1784);
                vec3 _1793 = vec3((_1786 / vec3(_1786.z)).xy, _1790);
                float _1794 = _1763.z;
                vec3 _1806;
                if (_1794 > 0.0)
                {
                    _1806 = _1793;
                }
                else
                {
                    _1806 = vec3(normalize(_1793.xy) * 10000000.0, -_1790);
                }
                vec3 _1814 = vec3((_1806.x * 0.5) + 0.5, 0.5 - (_1806.y * 0.5), _1806.z);
                _1814.z = _1806.z * 9.9999997473787516355514526367188e-05;
                if (_1794 < 0.0)
                {
                    _2137 = 0.0;
                    break;
                }
                _1820 = _1814;
            }
            else
            {
                vec3 _1768 = _1763.xyz;
                vec3 _1780;
                if (_1341 == 1u)
                {
                    float _1772 = _1763.z;
                    vec3 _1779 = _1768;
                    _1779.z = _1772 - (((_1772 * dynamic_light_infos._m0[_1338].shadow_scale.z) + 1.0) / _1763.w);
                    _1780 = _1779;
                }
                else
                {
                    _1780 = _1768;
                }
                _1820 = _1780 / vec3(_1763.w);
            }
            float _1930;
            if (dynamic_light_infos._m0[_1338].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1912 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1820.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1820.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1820.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1820.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1338].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1820.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1820.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1338].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1820.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1820.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1338].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1820.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1820.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1338].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1820.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1820.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1338].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1930 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1338].shadow_scale.w * spvNMax(_1912, _1820.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1820.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1338].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1930 = 1.0;
            }
            vec3 _1931 = dFdx(_1820);
            vec3 _1932 = dFdy(_1820);
            vec3 _1946 = _1820 + ((normalize(cross(_1931, _1932)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _267) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw)).x);
            vec2 _1947 = dynamic_light_infos._m0[_1338].shadow_scale.xy * _1930;
            vec2 _1948 = _1946.xy;
            float _1953 = _1946.z;
            float _2032 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1948, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, _1953, 1.0).xy, _1953), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1948 + (vec2(1.0, 0.0) * _1947), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, _1953, 1.0).xy, _1953), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1948 + (vec2(0.5, 0.865999996662139892578125) * _1947), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, _1953, 1.0).xy, _1953), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1948 + (vec2(-0.5, 0.865999996662139892578125) * _1947), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, _1953, 1.0).xy, _1953), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1948 + (vec2(-1.0, -0.0) * _1947), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, _1953, 1.0).xy, _1953), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1948 + (vec2(-0.5, -0.865999996662139892578125) * _1947), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, _1953, 1.0).xy, _1953), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1948 + (vec2(0.5, -0.865999996662139892578125) * _1947), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1338].shadow_atlas_offset_scale.xy, _1953, 1.0).xy, _1953), 0.0);
            float _2033 = _2032 * 0.14285714924335479736328125;
            float _2136;
            if (_1341 == 0u)
            {
                float _2048 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1753.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2050 = transpose(dynamic_light_infos._m0[_1338].light_matrix)[2];
                float _2055 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2064;
                if (_2055 > 0.100000001490116119384765625)
                {
                    _2064 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2064 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2075 = _1753.xyz - ((_2050.xyz / vec3(_2050.z)) * 1000.0);
                float _2099 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2064, _2075), dot(normalize(vec3(-_2064.y, _2064.x, 0.0)), _2075)) + (vec2(_2055, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2048 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2106 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2107 = _2106 - 1.0;
                float _2108 = 1.0 - cpass_cb.clouds_midpoint;
                float _2115 = 2.0 - _2106;
                _2136 = _2033 * mix(1.0, clamp(clamp(_2108 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2099), 0.0, 1.0), _2107)) * pow(clamp(_2108, 0.0, 1.0), _2115)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2099), 0.0, 1.0), _2107) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2115))), 0.0, 1.0) + (_2048 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2136 = _2033;
            }
            _2137 = _2136;
            break;
        } while(false);
        vec4 _2138 = _1744;
        _2138.y = _2137;
        _2139 = _2138;
    }
    else
    {
        _2139 = _1744;
    }
    vec4 _2534;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1342].shadow_enabled.x > 0.0)
    {
        vec4 _2148 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2532;
        do
        {
            vec4 _2158 = dynamic_light_infos._m0[_1342].light_matrix * _2148;
            vec3 _2215;
            if (_1345 == 2u)
            {
                vec3 _2179 = _2158.xyz;
                vec3 _2181 = normalize(_2179) + vec3(0.0, 0.0, 1.0);
                float _2185 = length(_2179);
                vec3 _2188 = vec3((_2181 / vec3(_2181.z)).xy, _2185);
                float _2189 = _2158.z;
                vec3 _2201;
                if (_2189 > 0.0)
                {
                    _2201 = _2188;
                }
                else
                {
                    _2201 = vec3(normalize(_2188.xy) * 10000000.0, -_2185);
                }
                vec3 _2209 = vec3((_2201.x * 0.5) + 0.5, 0.5 - (_2201.y * 0.5), _2201.z);
                _2209.z = _2201.z * 9.9999997473787516355514526367188e-05;
                if (_2189 < 0.0)
                {
                    _2532 = 0.0;
                    break;
                }
                _2215 = _2209;
            }
            else
            {
                vec3 _2163 = _2158.xyz;
                vec3 _2175;
                if (_1345 == 1u)
                {
                    float _2167 = _2158.z;
                    vec3 _2174 = _2163;
                    _2174.z = _2167 - (((_2167 * dynamic_light_infos._m0[_1342].shadow_scale.z) + 1.0) / _2158.w);
                    _2175 = _2174;
                }
                else
                {
                    _2175 = _2163;
                }
                _2215 = _2175 / vec3(_2158.w);
            }
            float _2325;
            if (dynamic_light_infos._m0[_1342].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2307 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2215.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2215.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2215.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2215.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1342].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2215.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2215.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1342].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2215.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2215.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1342].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2215.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2215.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1342].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2215.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2215.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1342].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2325 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1342].shadow_scale.w * spvNMax(_2307, _2215.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2215.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1342].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2325 = 1.0;
            }
            vec3 _2326 = dFdx(_2215);
            vec3 _2327 = dFdy(_2215);
            vec3 _2341 = _2215 + ((normalize(cross(_2326, _2327)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _267) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw)).x);
            vec2 _2342 = dynamic_light_infos._m0[_1342].shadow_scale.xy * _2325;
            vec2 _2343 = _2341.xy;
            float _2348 = _2341.z;
            float _2427 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2343, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, _2348, 1.0).xy, _2348), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2343 + (vec2(1.0, 0.0) * _2342), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, _2348, 1.0).xy, _2348), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2343 + (vec2(0.5, 0.865999996662139892578125) * _2342), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, _2348, 1.0).xy, _2348), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2343 + (vec2(-0.5, 0.865999996662139892578125) * _2342), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, _2348, 1.0).xy, _2348), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2343 + (vec2(-1.0, -0.0) * _2342), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, _2348, 1.0).xy, _2348), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2343 + (vec2(-0.5, -0.865999996662139892578125) * _2342), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, _2348, 1.0).xy, _2348), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2343 + (vec2(0.5, -0.865999996662139892578125) * _2342), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1342].shadow_atlas_offset_scale.xy, _2348, 1.0).xy, _2348), 0.0);
            float _2428 = _2427 * 0.14285714924335479736328125;
            float _2531;
            if (_1345 == 0u)
            {
                float _2443 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2148.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2445 = transpose(dynamic_light_infos._m0[_1342].light_matrix)[2];
                float _2450 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2459;
                if (_2450 > 0.100000001490116119384765625)
                {
                    _2459 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2459 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2470 = _2148.xyz - ((_2445.xyz / vec3(_2445.z)) * 1000.0);
                float _2494 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2459, _2470), dot(normalize(vec3(-_2459.y, _2459.x, 0.0)), _2470)) + (vec2(_2450, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2443 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2501 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2502 = _2501 - 1.0;
                float _2503 = 1.0 - cpass_cb.clouds_midpoint;
                float _2510 = 2.0 - _2501;
                _2531 = _2428 * mix(1.0, clamp(clamp(_2503 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2494), 0.0, 1.0), _2502)) * pow(clamp(_2503, 0.0, 1.0), _2510)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2494), 0.0, 1.0), _2502) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2510))), 0.0, 1.0) + (_2443 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2531 = _2428;
            }
            _2532 = _2531;
            break;
        } while(false);
        vec4 _2533 = _2139;
        _2533.z = _2532;
        _2534 = _2533;
    }
    else
    {
        _2534 = _2139;
    }
    vec4 _2929;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1346].shadow_enabled.x > 0.0)
    {
        vec4 _2543 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2927;
        do
        {
            vec4 _2553 = dynamic_light_infos._m0[_1346].light_matrix * _2543;
            vec3 _2610;
            if (_1349 == 2u)
            {
                vec3 _2574 = _2553.xyz;
                vec3 _2576 = normalize(_2574) + vec3(0.0, 0.0, 1.0);
                float _2580 = length(_2574);
                vec3 _2583 = vec3((_2576 / vec3(_2576.z)).xy, _2580);
                float _2584 = _2553.z;
                vec3 _2596;
                if (_2584 > 0.0)
                {
                    _2596 = _2583;
                }
                else
                {
                    _2596 = vec3(normalize(_2583.xy) * 10000000.0, -_2580);
                }
                vec3 _2604 = vec3((_2596.x * 0.5) + 0.5, 0.5 - (_2596.y * 0.5), _2596.z);
                _2604.z = _2596.z * 9.9999997473787516355514526367188e-05;
                if (_2584 < 0.0)
                {
                    _2927 = 0.0;
                    break;
                }
                _2610 = _2604;
            }
            else
            {
                vec3 _2558 = _2553.xyz;
                vec3 _2570;
                if (_1349 == 1u)
                {
                    float _2562 = _2553.z;
                    vec3 _2569 = _2558;
                    _2569.z = _2562 - (((_2562 * dynamic_light_infos._m0[_1346].shadow_scale.z) + 1.0) / _2553.w);
                    _2570 = _2569;
                }
                else
                {
                    _2570 = _2558;
                }
                _2610 = _2570 / vec3(_2553.w);
            }
            float _2720;
            if (dynamic_light_infos._m0[_1346].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2702 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2610.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2610.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2610.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2610.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1346].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2610.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2610.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1346].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2610.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2610.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1346].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2610.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2610.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1346].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2610.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2610.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1346].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2720 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1346].shadow_scale.w * spvNMax(_2702, _2610.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2610.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1346].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2720 = 1.0;
            }
            vec3 _2721 = dFdx(_2610);
            vec3 _2722 = dFdy(_2610);
            vec3 _2736 = _2610 + ((normalize(cross(_2721, _2722)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _267) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw)).x);
            vec2 _2737 = dynamic_light_infos._m0[_1346].shadow_scale.xy * _2720;
            vec2 _2738 = _2736.xy;
            float _2743 = _2736.z;
            float _2822 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2738, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, _2743, 1.0).xy, _2743), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2738 + (vec2(1.0, 0.0) * _2737), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, _2743, 1.0).xy, _2743), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2738 + (vec2(0.5, 0.865999996662139892578125) * _2737), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, _2743, 1.0).xy, _2743), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2738 + (vec2(-0.5, 0.865999996662139892578125) * _2737), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, _2743, 1.0).xy, _2743), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2738 + (vec2(-1.0, -0.0) * _2737), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, _2743, 1.0).xy, _2743), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2738 + (vec2(-0.5, -0.865999996662139892578125) * _2737), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, _2743, 1.0).xy, _2743), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2738 + (vec2(0.5, -0.865999996662139892578125) * _2737), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1346].shadow_atlas_offset_scale.xy, _2743, 1.0).xy, _2743), 0.0);
            float _2823 = _2822 * 0.14285714924335479736328125;
            float _2926;
            if (_1349 == 0u)
            {
                float _2838 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2543.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2840 = transpose(dynamic_light_infos._m0[_1346].light_matrix)[2];
                float _2845 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2854;
                if (_2845 > 0.100000001490116119384765625)
                {
                    _2854 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2854 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2865 = _2543.xyz - ((_2840.xyz / vec3(_2840.z)) * 1000.0);
                float _2889 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2854, _2865), dot(normalize(vec3(-_2854.y, _2854.x, 0.0)), _2865)) + (vec2(_2845, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2838 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2896 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2897 = _2896 - 1.0;
                float _2898 = 1.0 - cpass_cb.clouds_midpoint;
                float _2905 = 2.0 - _2896;
                _2926 = _2823 * mix(1.0, clamp(clamp(_2898 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2889), 0.0, 1.0), _2897)) * pow(clamp(_2898, 0.0, 1.0), _2905)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2889), 0.0, 1.0), _2897) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2905))), 0.0, 1.0) + (_2838 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2926 = _2823;
            }
            _2927 = _2926;
            break;
        } while(false);
        vec4 _2928 = _2534;
        _2928.w = _2927;
        _2929 = _2928;
    }
    else
    {
        _2929 = _2534;
    }
    vec3 _2996;
    vec3 _2997;
    switch (_1337)
    {
        case 0u:
        {
            _2996 = dynamic_light_infos._m0[_1334].light_color.xyz;
            _2997 = -dynamic_light_infos._m0[_1334].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _2973 = dynamic_light_infos._m0[_1334].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2974 = length(_2973);
            vec3 _2976 = _2973 / vec3(_2974);
            _2996 = dynamic_light_infos._m0[_1334].light_color.xyz * ((1.0 - clamp(_2974 / dynamic_light_infos._m0[_1334].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1334].light_direction.xyz, _2976) - dynamic_light_infos._m0[_1334].light_direction.w) / (dynamic_light_infos._m0[_1334].light_position.w - dynamic_light_infos._m0[_1334].light_direction.w), 0.0, 1.0));
            _2997 = _2976;
            break;
        }
        case 2u:
        {
            vec3 _2941 = dynamic_light_infos._m0[_1334].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2942 = length(_2941);
            float _2954 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1334].light_position.w, 0.0, 1.0));
            float _2959 = (_2942 / (dynamic_light_infos._m0[_1334].light_color.w / _2954)) + 1.0;
            float _2960 = _2942 / (dynamic_light_infos._m0[_1334].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1334].light_color.xyz), vec3(1.0)) * 2.0));
            float _2965 = clamp(1.0 - (((_2960 * _2960) * _2960) * _2960), 0.0, 1.0);
            _2996 = dynamic_light_infos._m0[_1334].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _2954) * _2954) * (_2965 * _2965)) / (_2959 * _2959));
            _2997 = _2941 / vec3(_2942);
            break;
        }
        default:
        {
            _2996 = vec3(0.0);
            _2997 = vec3(0.0);
            break;
        }
    }
    vec3 _2999 = normalize(_379);
    vec3 _3001 = -_2999;
    float _3003 = 1.0 - length(_379);
    vec3 _3009 = _2996 * (_2929.x * clamp((dot(_3001, -_2997) - _3003) * 2.5, 0.0, 1.0));
    vec3 _3061;
    vec3 _3062;
    vec3 _3063;
    if (length(_3009) > 0.0)
    {
        float _3015 = clamp(dot(_2997, _1163), 0.0, 1.0);
        float _3018 = clamp(1.0 - _401, 0.0, 1.0);
        float _3020 = spvNMax(_3018 * _3018, 0.00200000009499490261077880859375);
        float _3021 = _3020 * _3020;
        vec3 _3022 = -_1167;
        vec3 _3024 = normalize(_3022 + _2997);
        float _3026 = clamp(dot(_1163, _3024), 0.0, 1.0);
        float _3030 = clamp(dot(_3022, _3024), 0.0, 1.0);
        float _3037 = _3020 * 0.5;
        float _3038 = 1.0 - _3037;
        _3061 = _1188 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3030) - 6.9831600189208984375) * _3030)), vec3(1.0), _434) * (_3021 / pow((((_3021 - 1.0) * _3026) * _3026) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3022, _1163), 0.0, 1.0) * _3038) + _3037) * ((_3015 * _3038) + _3037)))) * _3015) * vec3(0.25)) * _3009);
        _3062 = _1190 + ((_3009 * _3015) * _387.xyz);
        _3063 = _1192 + _3009;
    }
    else
    {
        _3061 = _1188;
        _3062 = _1190;
        _3063 = _1192;
    }
    vec3 _3130;
    vec3 _3131;
    switch (_1341)
    {
        case 0u:
        {
            _3130 = dynamic_light_infos._m0[_1338].light_color.xyz;
            _3131 = -dynamic_light_infos._m0[_1338].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3107 = dynamic_light_infos._m0[_1338].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3108 = length(_3107);
            vec3 _3110 = _3107 / vec3(_3108);
            _3130 = dynamic_light_infos._m0[_1338].light_color.xyz * ((1.0 - clamp(_3108 / dynamic_light_infos._m0[_1338].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1338].light_direction.xyz, _3110) - dynamic_light_infos._m0[_1338].light_direction.w) / (dynamic_light_infos._m0[_1338].light_position.w - dynamic_light_infos._m0[_1338].light_direction.w), 0.0, 1.0));
            _3131 = _3110;
            break;
        }
        case 2u:
        {
            vec3 _3075 = dynamic_light_infos._m0[_1338].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3076 = length(_3075);
            float _3088 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1338].light_position.w, 0.0, 1.0));
            float _3093 = (_3076 / (dynamic_light_infos._m0[_1338].light_color.w / _3088)) + 1.0;
            float _3094 = _3076 / (dynamic_light_infos._m0[_1338].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1338].light_color.xyz), vec3(1.0)) * 2.0));
            float _3099 = clamp(1.0 - (((_3094 * _3094) * _3094) * _3094), 0.0, 1.0);
            _3130 = dynamic_light_infos._m0[_1338].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3088) * _3088) * (_3099 * _3099)) / (_3093 * _3093));
            _3131 = _3075 / vec3(_3076);
            break;
        }
        default:
        {
            _3130 = vec3(0.0);
            _3131 = vec3(0.0);
            break;
        }
    }
    vec3 _3139 = _3130 * (_2929.y * clamp((dot(_3001, -_3131) - _3003) * 2.5, 0.0, 1.0));
    vec3 _3191;
    vec3 _3192;
    vec3 _3193;
    if (length(_3139) > 0.0)
    {
        float _3145 = clamp(dot(_3131, _1163), 0.0, 1.0);
        float _3148 = clamp(1.0 - _401, 0.0, 1.0);
        float _3150 = spvNMax(_3148 * _3148, 0.00200000009499490261077880859375);
        float _3151 = _3150 * _3150;
        vec3 _3152 = -_1167;
        vec3 _3154 = normalize(_3152 + _3131);
        float _3156 = clamp(dot(_1163, _3154), 0.0, 1.0);
        float _3160 = clamp(dot(_3152, _3154), 0.0, 1.0);
        float _3167 = _3150 * 0.5;
        float _3168 = 1.0 - _3167;
        _3191 = _3061 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3160) - 6.9831600189208984375) * _3160)), vec3(1.0), _434) * (_3151 / pow((((_3151 - 1.0) * _3156) * _3156) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3152, _1163), 0.0, 1.0) * _3168) + _3167) * ((_3145 * _3168) + _3167)))) * _3145) * vec3(0.25)) * _3139);
        _3192 = _3062 + ((_3139 * _3145) * _387.xyz);
        _3193 = _3063 + _3139;
    }
    else
    {
        _3191 = _3061;
        _3192 = _3062;
        _3193 = _3063;
    }
    vec3 _3260;
    vec3 _3261;
    switch (_1345)
    {
        case 0u:
        {
            _3260 = dynamic_light_infos._m0[_1342].light_color.xyz;
            _3261 = -dynamic_light_infos._m0[_1342].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3237 = dynamic_light_infos._m0[_1342].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3238 = length(_3237);
            vec3 _3240 = _3237 / vec3(_3238);
            _3260 = dynamic_light_infos._m0[_1342].light_color.xyz * ((1.0 - clamp(_3238 / dynamic_light_infos._m0[_1342].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1342].light_direction.xyz, _3240) - dynamic_light_infos._m0[_1342].light_direction.w) / (dynamic_light_infos._m0[_1342].light_position.w - dynamic_light_infos._m0[_1342].light_direction.w), 0.0, 1.0));
            _3261 = _3240;
            break;
        }
        case 2u:
        {
            vec3 _3205 = dynamic_light_infos._m0[_1342].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3206 = length(_3205);
            float _3218 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1342].light_position.w, 0.0, 1.0));
            float _3223 = (_3206 / (dynamic_light_infos._m0[_1342].light_color.w / _3218)) + 1.0;
            float _3224 = _3206 / (dynamic_light_infos._m0[_1342].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1342].light_color.xyz), vec3(1.0)) * 2.0));
            float _3229 = clamp(1.0 - (((_3224 * _3224) * _3224) * _3224), 0.0, 1.0);
            _3260 = dynamic_light_infos._m0[_1342].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3218) * _3218) * (_3229 * _3229)) / (_3223 * _3223));
            _3261 = _3205 / vec3(_3206);
            break;
        }
        default:
        {
            _3260 = vec3(0.0);
            _3261 = vec3(0.0);
            break;
        }
    }
    vec3 _3269 = _3260 * (_2929.z * clamp((dot(_3001, -_3261) - _3003) * 2.5, 0.0, 1.0));
    vec3 _3321;
    vec3 _3322;
    vec3 _3323;
    if (length(_3269) > 0.0)
    {
        float _3275 = clamp(dot(_3261, _1163), 0.0, 1.0);
        float _3278 = clamp(1.0 - _401, 0.0, 1.0);
        float _3280 = spvNMax(_3278 * _3278, 0.00200000009499490261077880859375);
        float _3281 = _3280 * _3280;
        vec3 _3282 = -_1167;
        vec3 _3284 = normalize(_3282 + _3261);
        float _3286 = clamp(dot(_1163, _3284), 0.0, 1.0);
        float _3290 = clamp(dot(_3282, _3284), 0.0, 1.0);
        float _3297 = _3280 * 0.5;
        float _3298 = 1.0 - _3297;
        _3321 = _3191 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3290) - 6.9831600189208984375) * _3290)), vec3(1.0), _434) * (_3281 / pow((((_3281 - 1.0) * _3286) * _3286) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3282, _1163), 0.0, 1.0) * _3298) + _3297) * ((_3275 * _3298) + _3297)))) * _3275) * vec3(0.25)) * _3269);
        _3322 = _3192 + ((_3269 * _3275) * _387.xyz);
        _3323 = _3193 + _3269;
    }
    else
    {
        _3321 = _3191;
        _3322 = _3192;
        _3323 = _3193;
    }
    vec3 _3390;
    vec3 _3391;
    switch (_1349)
    {
        case 0u:
        {
            _3390 = dynamic_light_infos._m0[_1346].light_color.xyz;
            _3391 = -dynamic_light_infos._m0[_1346].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3367 = dynamic_light_infos._m0[_1346].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3368 = length(_3367);
            vec3 _3370 = _3367 / vec3(_3368);
            _3390 = dynamic_light_infos._m0[_1346].light_color.xyz * ((1.0 - clamp(_3368 / dynamic_light_infos._m0[_1346].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1346].light_direction.xyz, _3370) - dynamic_light_infos._m0[_1346].light_direction.w) / (dynamic_light_infos._m0[_1346].light_position.w - dynamic_light_infos._m0[_1346].light_direction.w), 0.0, 1.0));
            _3391 = _3370;
            break;
        }
        case 2u:
        {
            vec3 _3335 = dynamic_light_infos._m0[_1346].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3336 = length(_3335);
            float _3348 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1346].light_position.w, 0.0, 1.0));
            float _3353 = (_3336 / (dynamic_light_infos._m0[_1346].light_color.w / _3348)) + 1.0;
            float _3354 = _3336 / (dynamic_light_infos._m0[_1346].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1346].light_color.xyz), vec3(1.0)) * 2.0));
            float _3359 = clamp(1.0 - (((_3354 * _3354) * _3354) * _3354), 0.0, 1.0);
            _3390 = dynamic_light_infos._m0[_1346].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3348) * _3348) * (_3359 * _3359)) / (_3353 * _3353));
            _3391 = _3335 / vec3(_3336);
            break;
        }
        default:
        {
            _3390 = vec3(0.0);
            _3391 = vec3(0.0);
            break;
        }
    }
    vec3 _3399 = _3390 * (_2929.w * clamp((dot(_3001, -_3391) - _3003) * 2.5, 0.0, 1.0));
    vec3 _3451;
    vec3 _3452;
    vec3 _3453;
    if (length(_3399) > 0.0)
    {
        float _3405 = clamp(dot(_3391, _1163), 0.0, 1.0);
        float _3408 = clamp(1.0 - _401, 0.0, 1.0);
        float _3410 = spvNMax(_3408 * _3408, 0.00200000009499490261077880859375);
        float _3411 = _3410 * _3410;
        vec3 _3412 = -_1167;
        vec3 _3414 = normalize(_3412 + _3391);
        float _3416 = clamp(dot(_1163, _3414), 0.0, 1.0);
        float _3420 = clamp(dot(_3412, _3414), 0.0, 1.0);
        float _3427 = _3410 * 0.5;
        float _3428 = 1.0 - _3427;
        _3451 = _3322 + ((_3399 * _3405) * _387.xyz);
        _3452 = _3321 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3420) - 6.9831600189208984375) * _3420)), vec3(1.0), _434) * (_3411 / pow((((_3411 - 1.0) * _3416) * _3416) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3412, _1163), 0.0, 1.0) * _3428) + _3427) * ((_3405 * _3428) + _3427)))) * _3405) * vec3(0.25)) * _3399);
        _3453 = _3323 + _3399;
    }
    else
    {
        _3451 = _3322;
        _3452 = _3321;
        _3453 = _3323;
    }
    vec3 _3557;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _3466 = clamp(_401, 0.0, 1.0);
        float _3467 = 1.0 - _3466;
        float _3468 = _3467 * _3467;
        float _3471 = clamp(exp((-2.2999999523162841796875) * _3468), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _3472 = dot(_2999, _1168);
        vec2 _3479 = vec2(_3471, 0.0);
        float _3481 = -(_3472 * _3471);
        float _3482 = sqrt(clamp(1.0 - (_3472 * _3472), 0.0, 1.0)) * _3471;
        vec2 _3483 = vec2(_3481, _3482);
        float _3492 = sqrt(clamp(1.0 - (_3471 * _3471), 0.0, 1.0));
        vec4 _3518 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_1163, -_1167)), _3466, 0.0, 0.0).xy, 0.0);
        float _3531 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _3468));
        vec3 _3556 = _3452 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_1168, 0.0)).xyz, _3531).xyz, _3531).xyz * (vec3(_3518.x) + (_434 * _3518.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3453 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * ((2.0 * (acos(clamp(_3471 / sqrt(dot(_3479, _3479)), -1.0, 1.0)) + (acos(clamp(_3481 / (_3492 * sqrt(dot(_3483, _3483))), -1.0, 1.0)) - (acos(clamp((_3481 * _3471) / (_3482 * _3492), -1.0, 1.0)) * _3471)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _3471))));
        _3557 = _3556;
    }
    else
    {
        _3557 = _3452;
    }
    vec3 _3599;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _3599 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_379, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3453 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _387.xyz) * 1.0) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _3599 = vec3(0.0);
    }
    vec3 _3604 = (_3451 * cpass_cb.indirect_light_multiplier) + (_709 * 20.0);
    vec3 _3617 = (_3451 + _709) + (_3599 + spvNMax(vec3(0.0), _3557 / vec3(spvNMax(10.0, spvNMax(_3557.x, spvNMax(_3557.y, _3557.z))) * 0.100000001490116119384765625)));
    vec4 _3618 = vec4(_3617.x, _3617.y, _3617.z, vec4(0.0).w);
    _3618.w = _1151;
    out_var_SV_TARGET = _3618;
    out_var_SV_TARGET1 = vec4(_3604, _1151);
}

