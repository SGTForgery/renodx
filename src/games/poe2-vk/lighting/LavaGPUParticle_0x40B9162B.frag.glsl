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

float _269;
float _275;

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

layout(set = 5, binding = 0, std140) uniform type_cobject_cb
{
    uint instance_count;
    uint batch_size;
    uint padding0;
    uint padding1;
    InstanceData instances[16];
} cobject_cb;

layout(set = 2, binding = 42, std430) readonly buffer type_StructuredBuffer_LightInfo
{
    LightInfo _m0[];
} dynamic_light_infos;

layout(set = 2, binding = 43, std430) readonly buffer type_StructuredBuffer_PointLightInfo
{
    PointLightInfo _m0[];
} point_light_infos;

layout(set = 2, binding = 44, std430) readonly buffer type_StructuredBuffer_LUTData
{
    LUTData _m0[];
} spline_lut;

layout(set = 2, binding = 45, std430) readonly buffer type_StructuredBuffer_ParticleData
{
    ParticleData _m0[];
} particles_data;

layout(set = 2, binding = 46, std430) readonly buffer type_StructuredBuffer_ParticleEmitterData
{
    ParticleEmitterData _m0[];
} particles_emitter_data;

layout(set = 0, binding = 0) uniform sampler SamplerLinearWrap;
layout(set = 0, binding = 1) uniform sampler SamplerLinearClamp;
layout(set = 0, binding = 7) uniform sampler SamplerDynamicWrap;
layout(set = 0, binding = 8) uniform sampler SamplerLinearWrapNoBias;
layout(set = 0, binding = 9) uniform sampler SamplerLinearClampNoBias;
layout(set = 0, binding = 15) uniform samplerShadow SamplerDepth;
layout(set = 2, binding = 31) uniform textureCube diffuse_cube;
layout(set = 2, binding = 32) uniform textureCube specular_cube;
layout(set = 2, binding = 33) uniform texture2D environment_ggx_sampler;
layout(set = 2, binding = 34) uniform texture2D noise_sampler;
layout(set = 2, binding = 35) uniform texture2D tex_shadow_map_atlas;
layout(set = 2, binding = 36) uniform texture2D muddle_texture_0;
layout(set = 2, binding = 37) uniform texture2D texture_object_0;
layout(set = 2, binding = 38) uniform texture2D input_texture_0;
layout(set = 2, binding = 39) uniform texture2D tile_ground_normal_texture;
layout(set = 2, binding = 40) uniform utexture2D light_lookup;
layout(set = 2, binding = 41) uniform usamplerBuffer light_indices;

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
    vec2 _310 = unpackHalf2x16((particles_data._m0[in_var_AUTO_EFMAIHMN_BABABNNF].angular_velocity.y >> 16u) & 65535u);
    float _311 = _310.x;
    vec4 _320 = texture(sampler2D(muddle_texture_0, SamplerLinearWrap), (in_var_TEXCOORD1 * 1.0) + (vec2(-0.0199999995529651641845703125, 0.0199999995529651641845703125) * cpass_cb.time));
    vec2 _330 = vec2(cpipeline_cb.maya_scale_pivot_0.x, 1.0 - cpipeline_cb.maya_scale_pivot_0.y);
    vec2 _346 = ((((in_var_TEXCOORD1 + ((_320.xy - vec2(0.5)) * 0.0199999995529651641845703125)) - _330) * vec2(1.0, 0.5)) + _330) + (vec2((cpipeline_cb.constant_bool_1 != 0u) ? pow(spvNMax(abs(in_var_AUTO_BOAEJOBF_ANHFJCCP.w), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_4) : cpass_cb.time) * vec2(0.0, -0.100000001490116119384765625));
    mat3 _347 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _361 = ((vec2(textureLod(sampler2D(texture_object_0, SamplerDynamicWrap), vec4(_346, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _362 = vec3(_361.x, _361.y, vec3(0.0).z);
    vec2 _363 = _361.xy;
    _362.z = sqrt(spvNMax(1.0 - dot(_363, _363), 0.0));
    vec3 _369 = _347 * _362;
    vec4 _375 = texture(sampler2D(texture_object_0, SamplerDynamicWrap), _346);
    float _376 = _375.z;
    vec3 _381 = vec3(pow(spvNMax(abs(_376), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_369 / vec3(length(_369) + 1.0000000116860974230803549289703e-07));
    vec4 _384 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _346);
    vec3 _385 = _384.xyz;
    vec3 _387 = vec3(_384.w);
    vec3 _389 = clamp(mix(_385, vec3(0.0), _387), vec3(0.0), vec3(1.0));
    vec2 _395 = ((vec2(_375.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _396 = vec3(_395.x, _395.y, vec3(0.0).z);
    vec2 _397 = _395.xy;
    _396.z = sqrt(spvNMax(1.0 - dot(_397, _397), 0.0));
    float _403 = _375.w;
    float _412 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _413 = cos(_412);
    vec3 _428 = (((_385 * _413) + (cross(vec3(0.57735002040863037109375), _385) * sin(_412))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _385)) * (1.0 - _413))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _436 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_428, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _428, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _387), vec3(0.0), vec3(1.0));
    bool _439 = cpipeline_cb.constant_trackG_0 < 0;
    float _441 = clamp(_376, 0.0, 1.0) * 127.0;
    int _445 = int(spvNMax(trunc(_441), 0.0) + 0.5);
    int _450 = int(spvNMin(trunc(_441 + 1.0), 127.0) + 0.5);
    float _468;
    if (_439)
    {
        _468 = 0.0;
    }
    else
    {
        uint _454 = uint(cpipeline_cb.constant_trackG_0);
        int _455 = _445 / 2;
        _468 = ((_445 - 2 * (_445 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_454].value[_455] & 65535u).x : unpackHalf2x16((spline_lut._m0[_454].value[_455] >> 16u) & 65535u).x;
    }
    float _486;
    if (_439)
    {
        _486 = 0.0;
    }
    else
    {
        uint _472 = uint(cpipeline_cb.constant_trackG_0);
        int _473 = _450 / 2;
        _486 = ((_450 - 2 * (_450 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_472].value[_473] & 65535u).x : unpackHalf2x16((spline_lut._m0[_472].value[_473] >> 16u) & 65535u).x;
    }
    float _487 = fract(_441);
    bool _493 = cpipeline_cb.constant_trackG_1 < 0;
    float _511;
    if (_493)
    {
        _511 = 0.0;
    }
    else
    {
        uint _497 = uint(cpipeline_cb.constant_trackG_1);
        int _498 = _445 / 2;
        _511 = ((_445 - 2 * (_445 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_497].value[_498] & 65535u).x : unpackHalf2x16((spline_lut._m0[_497].value[_498] >> 16u) & 65535u).x;
    }
    float _529;
    if (_493)
    {
        _529 = 0.0;
    }
    else
    {
        uint _515 = uint(cpipeline_cb.constant_trackG_1);
        int _516 = _450 / 2;
        _529 = ((_450 - 2 * (_450 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_515].value[_516] & 65535u).x : unpackHalf2x16((spline_lut._m0[_515].value[_516] >> 16u) & 65535u).x;
    }
    float _538 = clamp((spvNMax(vec3(mix(_468, _486, _487), _275, _275), vec3(0.0)) + spvNMax(vec3(mix(_511, _529, _487), _275, _275), vec3(0.0))).x, 0.0, 1.0) * 127.0;
    int _543 = int(spvNMax(trunc(_538), 0.0) + 0.5);
    int _548 = int(spvNMin(trunc(_538 + 1.0), 127.0) + 0.5);
    bool _549 = cpipeline_cb.constant_trackC_0.x < 0;
    float _567;
    if (_549)
    {
        _567 = 0.0;
    }
    else
    {
        uint _553 = uint(cpipeline_cb.constant_trackC_0.x);
        int _554 = _543 / 2;
        _567 = ((_543 - 2 * (_543 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_553].value[_554] & 65535u).x : unpackHalf2x16((spline_lut._m0[_553].value[_554] >> 16u) & 65535u).x;
    }
    float _585;
    if (_549)
    {
        _585 = 0.0;
    }
    else
    {
        uint _571 = uint(cpipeline_cb.constant_trackC_0.x);
        int _572 = _548 / 2;
        _585 = ((_548 - 2 * (_548 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_571].value[_572] & 65535u).x : unpackHalf2x16((spline_lut._m0[_571].value[_572] >> 16u) & 65535u).x;
    }
    float _586 = fract(_538);
    bool _589 = cpipeline_cb.constant_trackC_0.y < 0;
    float _607;
    if (_589)
    {
        _607 = 0.0;
    }
    else
    {
        uint _593 = uint(cpipeline_cb.constant_trackC_0.y);
        int _594 = _543 / 2;
        _607 = ((_543 - 2 * (_543 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_593].value[_594] & 65535u).x : unpackHalf2x16((spline_lut._m0[_593].value[_594] >> 16u) & 65535u).x;
    }
    float _625;
    if (_589)
    {
        _625 = 0.0;
    }
    else
    {
        uint _611 = uint(cpipeline_cb.constant_trackC_0.y);
        int _612 = _548 / 2;
        _625 = ((_548 - 2 * (_548 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_611].value[_612] & 65535u).x : unpackHalf2x16((spline_lut._m0[_611].value[_612] >> 16u) & 65535u).x;
    }
    bool _628 = cpipeline_cb.constant_trackC_0.z < 0;
    float _646;
    if (_628)
    {
        _646 = 0.0;
    }
    else
    {
        uint _632 = uint(cpipeline_cb.constant_trackC_0.z);
        int _633 = _543 / 2;
        _646 = ((_543 - 2 * (_543 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_632].value[_633] & 65535u).x : unpackHalf2x16((spline_lut._m0[_632].value[_633] >> 16u) & 65535u).x;
    }
    float _664;
    if (_628)
    {
        _664 = 0.0;
    }
    else
    {
        uint _650 = uint(cpipeline_cb.constant_trackC_0.z);
        int _651 = _548 / 2;
        _664 = ((_548 - 2 * (_548 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_650].value[_651] & 65535u).x : unpackHalf2x16((spline_lut._m0[_650].value[_651] >> 16u) & 65535u).x;
    }
    bool _667 = cpipeline_cb.constant_trackC_0.w < 0;
    float _685;
    if (_667)
    {
        _685 = 0.0;
    }
    else
    {
        uint _671 = uint(cpipeline_cb.constant_trackC_0.w);
        int _672 = _543 / 2;
        _685 = ((_543 - 2 * (_543 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_671].value[_672] & 65535u).x : unpackHalf2x16((spline_lut._m0[_671].value[_672] >> 16u) & 65535u).x;
    }
    float _703;
    if (_667)
    {
        _703 = 0.0;
    }
    else
    {
        uint _689 = uint(cpipeline_cb.constant_trackC_0.w);
        int _690 = _548 / 2;
        _703 = ((_548 - 2 * (_548 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_689].value[_690] & 65535u).x : unpackHalf2x16((spline_lut._m0[_689].value[_690] >> 16u) & 65535u).x;
    }
    float _704 = mix(_685, _703, _586);
    vec3 _711 = spvNMin((vec4(mix(_567, _585, _586), mix(_607, _625, _586), mix(_646, _664, _586), _704).xyz * vec3(spvNMax(_704, 0.0))) * 5.0, vec3(100.0));
    bool _714 = cpipeline_cb.constant_trackG_2 < 0;
    float _732;
    if (_714)
    {
        _732 = 0.0;
    }
    else
    {
        uint _718 = uint(cpipeline_cb.constant_trackG_2);
        int _719 = _445 / 2;
        _732 = ((_445 - 2 * (_445 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_718].value[_719] & 65535u).x : unpackHalf2x16((spline_lut._m0[_718].value[_719] >> 16u) & 65535u).x;
    }
    float _750;
    if (_714)
    {
        _750 = 0.0;
    }
    else
    {
        uint _736 = uint(cpipeline_cb.constant_trackG_2);
        int _737 = _450 / 2;
        _750 = ((_450 - 2 * (_450 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_736].value[_737] & 65535u).x : unpackHalf2x16((spline_lut._m0[_736].value[_737] >> 16u) & 65535u).x;
    }
    uint _764 = in_var_INSTANCEID / cobject_cb.instance_count;
    float _774 = (cpipeline_cb.constant_bool_2 != 0u) ? clamp(uintBitsToFloat((uint(cobject_cb.instances[_764].synced_random_seed.x) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0) : _311;
    uvec3 _778 = (floatBitsToUint(vec3(_774, 0.0698473453521728515625, 0.64344775676727294921875)) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _779 = _778.y;
    uint _780 = _778.z;
    uint _783 = _778.x + (_779 * _780);
    uint _785 = _779 + (_780 * _783);
    uvec3 _788 = uvec3(_783, _785, _780 + (_783 * _785));
    uvec3 _790 = _788 ^ (_788 >> uvec3(16u));
    uint _791 = _790.y;
    uint _792 = _790.z;
    uint _795 = _790.x + (_791 * _792);
    uint _797 = _791 + (_792 * _795);
    vec3 _835 = vec3(0.0698473453521728515625, 0.0, 0.0);
    _835.y = _774;
    _835.z = 0.64344775676727294921875;
    uvec3 _839 = (floatBitsToUint(_835) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _840 = _839.y;
    uint _841 = _839.z;
    uint _844 = _839.x + (_840 * _841);
    uint _846 = _840 + (_841 * _844);
    uvec3 _849 = uvec3(_844, _846, _841 + (_844 * _846));
    uvec3 _851 = _849 ^ (_849 >> uvec3(16u));
    vec2 _867 = vec2(mix(cpipeline_cb.constant2_9.x, cpipeline_cb.constant2_9.y, clamp(uintBitsToFloat(((_851.x + (_851.y * _851.z)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0)));
    vec4 _909 = texture(sampler2D(tile_ground_normal_texture, SamplerLinearWrap), (cobject_cb.instances[_764].tile_ground_tiling * in_var_TEXCOORD0.xy) * cpass_cb.ground_scalemove_uv.xy);
    vec2 _916;
    if (cobject_cb.instances[_764].tile_ground_normal_swizzle == 1u)
    {
        _916 = _909.wy;
    }
    else
    {
        _916 = _909.xy;
    }
    float _934 = clamp(pow(spvNMax(abs(clamp((((in_var_AUTO_CELDJDLE_GEBKIEDD + (((vec4(_275, _916.y, _269, _269).xy - vec2(0.5)) * vec2(2.0)) * vec2(mix(cpipeline_cb.constant2_6.x, cpipeline_cb.constant2_6.y, clamp(uintBitsToFloat((_795 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (_396.xy * vec2(mix(cpipeline_cb.constant2_7.x, cpipeline_cb.constant2_7.y, clamp(uintBitsToFloat(((_792 + (_795 * _797)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (mix(mix(vec2(-1.0), vec2(0.0), vec2(cpipeline_cb.constant2_8.x)), vec2(-1.0), vec2(cpipeline_cb.constant2_8.y)) * mix(mix(_867, _867 * in_var_AUTO_CELDJDLE_GEBKIEDD, vec2(cpipeline_cb.constant2_10.x)), vec2(1.0) - in_var_AUTO_CELDJDLE_GEBKIEDD, vec2(cpipeline_cb.constant2_10.y)))).y, 0.0, 1.0)), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_9), 0.0, 1.0);
    float _935 = _934 * 127.0;
    int _939 = int(spvNMax(trunc(_935), 0.0) + 0.5);
    int _944 = int(spvNMin(trunc(_935 + 1.0), 127.0) + 0.5);
    bool _945 = cpipeline_cb.constant_trackG_3 < 0;
    float _963;
    if (_945)
    {
        _963 = 0.0;
    }
    else
    {
        uint _949 = uint(cpipeline_cb.constant_trackG_3);
        int _950 = _939 / 2;
        _963 = ((_939 - 2 * (_939 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_949].value[_950] & 65535u).x : unpackHalf2x16((spline_lut._m0[_949].value[_950] >> 16u) & 65535u).x;
    }
    float _981;
    if (_945)
    {
        _981 = 0.0;
    }
    else
    {
        uint _967 = uint(cpipeline_cb.constant_trackG_3);
        int _968 = _944 / 2;
        _981 = ((_944 - 2 * (_944 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_967].value[_968] & 65535u).x : unpackHalf2x16((spline_lut._m0[_967].value[_968] >> 16u) & 65535u).x;
    }
    float _984 = mix(_963, _981, fract(_935)) - clamp(-(((((0.2989999949932098388671875 * _395.x) + (0.58700001239776611328125 * _395.y)) - 0.5) * 2.0) * mix(cpipeline_cb.constant2_13.x, cpipeline_cb.constant2_13.y, clamp(uintBitsToFloat((_797 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))), 0.0, 1.0);
    float _992 = clamp((vec3(clamp(spvNMax(vec3(mix(_732, _750, _487), _275, _275), vec3(0.0)).x, 0.0, 1.0)) * vec3((cpipeline_cb.constant_bool_3 != 0u) ? spvNMax(_984, 0.0) : clamp(_984, 0.0, 1.0))).x, 0.0, 1.0);
    float _993 = spvNMax(0.001000000047497451305389404296875, 0.34899997711181640625);
    float _996 = clamp((2.0 / _993) - 1.0, -100000.0, 100000.0);
    float _1009 = 0.949999988079071044921875 + ((pow(clamp((1.0 - spvNMax(0.0500000007450580596923828125, _992)) * 1.0526316165924072265625, 0.0, 1.0), _996) * (-0.949999988079071044921875)) + (pow(clamp(spvNMin(0.0500000007450580596923828125, _992) * 20.0, 0.0, 1.0), _996) * 0.0500000007450580596923828125));
    float _1012 = clamp(isnan(_1009) ? 0.0500000007450580596923828125 : _1009, 0.0, 1.0);
    float _1016;
    _1016 = 0.0;
    float _1017;
    for (uint _1019 = 0u; _1019 < 1u; _1016 = _1017, _1019++)
    {
        uint _1024 = cpipeline_cb.constantUInt1_102 / 4u;
        uint _1025 = cpipeline_cb.constantUInt1_102 % 4u;
        vec4 _1054;
        if (!(((particles_emitter_data._m0[cobject_cb.instances[_764].gpu_particle_emitter].culling_tag >> 14u) & 512u) == 0u))
        {
            vec4 _1053;
            if (floatBitsToUint(cpass_cb.frame_delta_time.w) == 0u)
            {
                _1053 = vec4(_275, 0.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            else
            {
                _1053 = vec4(0.0, 1.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            _1054 = _1053;
        }
        else
        {
            _1054 = cpass_cb.frame_delta_time;
        }
        float _1062 = mix(particles_emitter_data._m0[cobject_cb.instances[_764].gpu_particle_emitter].prev_time, particles_emitter_data._m0[cobject_cb.instances[_764].gpu_particle_emitter].time, _1054.z) / particles_emitter_data._m0[cobject_cb.instances[_764].gpu_particle_emitter].emitter_duration;
        float _1063 = spvNMax(0.0, _1062);
        float _1069;
        if (((particles_emitter_data._m0[cobject_cb.instances[_764].gpu_particle_emitter].culling_tag >> 14u) & 2u) != 0u)
        {
            _1069 = fract(_1063);
        }
        else
        {
            _1069 = _1063;
        }
        float _1076 = spvNMax(cpipeline_cb.constant1_12, 9.9999997473787516355514526367188e-05);
        float _1083;
        if (abs(_1076) > 0.0)
        {
            _1083 = in_var_AUTO_PIPJIEKO_LDBDDLHP / _1076;
        }
        else
        {
            _1083 = 0.0;
        }
        float _1090;
        if (_1025 == 0u)
        {
            _1090 = _1083;
        }
        else
        {
            _1090 = (_1025 == 1u) ? clamp((abs(particles_emitter_data._m0[cobject_cb.instances[_764].gpu_particle_emitter].emitter_duration) > 0.0) ? _1062 : 0.0, 0.0, 1.0) : 0.0;
        }
        float _1098;
        if (abs(cobject_cb.instances[_764].gpu_particles_duration.x) > 0.0)
        {
            _1098 = (in_var_AUTO_PIPJIEKO_CIFEPFLO * in_var_AUTO_PIPJIEKO_EIDIDJP) / cobject_cb.instances[_764].gpu_particles_duration.x;
        }
        else
        {
            _1098 = 0.0;
        }
        float _1115;
        if (cpipeline_cb.constantUInt1_102 == 0u)
        {
            _1115 = in_var_AUTO_PIPJIEKO_CIFEPFLO;
        }
        else
        {
            float _1114;
            if (cpipeline_cb.constantUInt1_102 == 1u)
            {
                _1114 = _1069;
            }
            else
            {
                float _1113;
                if (cpipeline_cb.constantUInt1_102 == 2u)
                {
                    _1113 = in_var_AUTO_PIPJIEKO_IINFNGPI;
                }
                else
                {
                    _1113 = (cpipeline_cb.constantUInt1_102 == 3u) ? _1098 : 0.0;
                }
                _1114 = _1113;
            }
            _1115 = _1114;
        }
        if (_1024 == 0u)
        {
            _1017 = _1115;
        }
        else
        {
            _1017 = (_1024 == 1u) ? _1090 : 0.0;
        }
    }
    float _1125 = clamp(_1016, 0.0, 1.0);
    float _1135 = _1125 * _1125;
    float _1146 = spvNMax(dot(cpipeline_cb.constant_track5_5.segment_polynom[(_1125 < cpipeline_cb.constant_track5_5.time_variance.x) ? 0u : ((_1125 < cpipeline_cb.constant_track5_5.time_variance.y) ? 1u : ((_1125 < cpipeline_cb.constant_track5_5.time_variance.z) ? 2u : 3u))], vec4(_1135 * _1125, _1135, _1125, 1.0)) + (((_311 - 0.5) * 2.0) * cpipeline_cb.constant_track5_5.time_variance.w), 0.0);
    float _1153 = clamp(clamp(mix(_1012 * _1146, _1012 - (1.0 - _1146), 0.25), 0.0, 1.0) * 5.0, 0.0, 1.0);
    vec3 _1154 = _347 * _396;
    if (((_1153 - cpipeline_cb.alpha_test_desc.y) + 0.001000000047497451305389404296875) < 0.0)
    {
        discard;
    }
    vec3 _1165 = _1154 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_1154)));
    vec3 _1169 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _1170 = reflect(_1169, _1165);
    uvec4 _1183 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _1184 = _1183.x;
    uint _1185 = _1183.y;
    vec3 _1190;
    vec3 _1192;
    vec3 _1194;
    _1190 = vec3(0.0);
    _1192 = vec3(0.0);
    _1194 = vec3(0.0);
    uint _1188;
    vec3 _1191;
    vec3 _1193;
    vec3 _1195;
    for (uint _1187 = _1184, _1196 = 0u; _1196 < _1185; _1187 = _1188, _1190 = _1191, _1192 = _1193, _1194 = _1195, _1196++)
    {
        _1188 = _1187 + 1u;
        uvec4 _1202 = texelFetch(light_indices, int(_1187));
        uint _1203 = _1202.x;
        vec4 _1222;
        if (point_light_infos._m0[_1203].channel_index > (-0.5))
        {
            vec4 _1221;
            if (point_light_infos._m0[_1203].channel_index >= 2.5)
            {
                _1221 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1220;
                if (point_light_infos._m0[_1203].channel_index >= 1.5)
                {
                    _1220 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1220 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1203].channel_index >= 0.5));
                }
                _1221 = _1220;
            }
            _1222 = _1221;
        }
        else
        {
            _1222 = vec4(0.0);
        }
        vec3 _1252 = vec4(point_light_infos._m0[_1203].position, point_light_infos._m0[_1203].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1253 = length(_1252);
        vec3 _1255 = _1252 / vec3(_1253);
        vec3 _1256 = vec4(point_light_infos._m0[_1203].color, point_light_infos._m0[_1203].median_radius).xyz;
        float _1263 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1203].channel_index, 0.0, 1.0));
        float _1268 = (_1253 / (point_light_infos._m0[_1203].median_radius / _1263)) + 1.0;
        float _1269 = _1253 / (point_light_infos._m0[_1203].median_radius * sqrt(dot(abs(_1256), vec3(1.0)) * 2.0));
        float _1274 = clamp(1.0 - (((_1269 * _1269) * _1269) * _1269), 0.0, 1.0);
        vec3 _1281 = (_1256 * spvNMin(10.0, (((0.199999988079071044921875 * _1263) * _1263) * (_1274 * _1274)) / (_1268 * _1268))) * (dot(vec4(1.0), _1222) * clamp((dot(-normalize(_381), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1203].position)) - (1.0 - length(_381))) * 2.5, 0.0, 1.0));
        if (length(_1281) > 0.0)
        {
            float _1287 = clamp(dot(_1255, _1165), 0.0, 1.0);
            float _1290 = clamp(1.0 - _403, 0.0, 1.0);
            float _1292 = spvNMax(_1290 * _1290, 0.00200000009499490261077880859375);
            float _1293 = _1292 * _1292;
            vec3 _1294 = -_1169;
            vec3 _1296 = normalize(_1294 + _1255);
            float _1298 = clamp(dot(_1165, _1296), 0.0, 1.0);
            float _1302 = clamp(dot(_1294, _1296), 0.0, 1.0);
            float _1309 = _1292 * 0.5;
            float _1310 = 1.0 - _1309;
            _1191 = _1190 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1302) - 6.9831600189208984375) * _1302)), vec3(1.0), _436) * (_1293 / pow((((_1293 - 1.0) * _1298) * _1298) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1294, _1165), 0.0, 1.0) * _1310) + _1309) * ((_1287 * _1310) + _1309)))) * _1287) * vec3(0.25)) * _1281);
            _1193 = _1192 + ((_1281 * _1287) * _389.xyz);
            _1195 = _1194 + _1281;
        }
        else
        {
            _1191 = _1190;
            _1193 = _1192;
            _1195 = _1194;
        }
    }
    uvec4 _1335 = uvec4(cobject_cb.instances[_764].dynamic_light_indices);
    uint _1336 = _1335.x;
    uint _1339 = uint(dynamic_light_infos._m0[_1336].light_type.x);
    uint _1340 = _1335.y;
    uint _1343 = uint(dynamic_light_infos._m0[_1340].light_type.x);
    uint _1344 = _1335.z;
    uint _1347 = uint(dynamic_light_infos._m0[_1344].light_type.x);
    uint _1348 = _1335.w;
    uint _1351 = uint(dynamic_light_infos._m0[_1348].light_type.x);
    vec4 _1731;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1336].shadow_enabled.x > 0.0)
    {
        vec4 _1360 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1729;
        do
        {
            vec4 _1370 = dynamic_light_infos._m0[_1336].light_matrix * _1360;
            vec3 _1427;
            if (_1339 == 2u)
            {
                vec3 _1391 = _1370.xyz;
                vec3 _1393 = normalize(_1391) + vec3(0.0, 0.0, 1.0);
                float _1397 = length(_1391);
                vec3 _1400 = vec3((_1393 / vec3(_1393.z)).xy, _1397);
                float _1401 = _1370.z;
                vec3 _1413;
                if (_1401 > 0.0)
                {
                    _1413 = _1400;
                }
                else
                {
                    _1413 = vec3(normalize(_1400.xy) * 10000000.0, -_1397);
                }
                vec3 _1421 = vec3((_1413.x * 0.5) + 0.5, 0.5 - (_1413.y * 0.5), _1413.z);
                _1421.z = _1413.z * 9.9999997473787516355514526367188e-05;
                if (_1401 < 0.0)
                {
                    _1729 = 0.0;
                    break;
                }
                _1427 = _1421;
            }
            else
            {
                vec3 _1375 = _1370.xyz;
                vec3 _1387;
                if (_1339 == 1u)
                {
                    float _1379 = _1370.z;
                    vec3 _1386 = _1375;
                    _1386.z = _1379 - (((_1379 * dynamic_light_infos._m0[_1336].shadow_scale.z) + 1.0) / _1370.w);
                    _1387 = _1386;
                }
                else
                {
                    _1387 = _1375;
                }
                _1427 = _1387 / vec3(_1370.w);
            }
            float _1537;
            if (dynamic_light_infos._m0[_1336].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1519 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1427.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1427.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1427.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1427.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1336].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1427.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1427.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1336].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1427.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1427.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1336].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1427.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1427.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1336].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1427.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1427.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1336].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1537 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1336].shadow_scale.w * spvNMax(_1519, _1427.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1427.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1336].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1537 = 1.0;
            }
            vec2 _1538 = dynamic_light_infos._m0[_1336].shadow_scale.xy * _1537;
            float _1624 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1427.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, _1427.z, 1.0).xy, _1427.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1427.xy + (vec2(1.0, 0.0) * _1538), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, _1427.z, 1.0).xy, _1427.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1427.xy + (vec2(0.5, 0.865999996662139892578125) * _1538), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, _1427.z, 1.0).xy, _1427.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1427.xy + (vec2(-0.5, 0.865999996662139892578125) * _1538), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, _1427.z, 1.0).xy, _1427.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1427.xy + (vec2(-1.0, -0.0) * _1538), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, _1427.z, 1.0).xy, _1427.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1427.xy + (vec2(-0.5, -0.865999996662139892578125) * _1538), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, _1427.z, 1.0).xy, _1427.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1427.xy + (vec2(0.5, -0.865999996662139892578125) * _1538), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1336].shadow_atlas_offset_scale.xy, _1427.z, 1.0).xy, _1427.z), 0.0);
            float _1625 = _1624 * 0.14285714924335479736328125;
            float _1728;
            if (_1339 == 0u)
            {
                float _1640 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1360.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1642 = transpose(dynamic_light_infos._m0[_1336].light_matrix)[2];
                float _1647 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1656;
                if (_1647 > 0.100000001490116119384765625)
                {
                    _1656 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1656 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1667 = _1360.xyz - ((_1642.xyz / vec3(_1642.z)) * 1000.0);
                float _1691 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1656, _1667), dot(normalize(vec3(-_1656.y, _1656.x, 0.0)), _1667)) + (vec2(_1647, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1640 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1698 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1699 = _1698 - 1.0;
                float _1700 = 1.0 - cpass_cb.clouds_midpoint;
                float _1707 = 2.0 - _1698;
                _1728 = _1625 * mix(1.0, clamp(clamp(_1700 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1691), 0.0, 1.0), _1699)) * pow(clamp(_1700, 0.0, 1.0), _1707)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1691), 0.0, 1.0), _1699) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1707))), 0.0, 1.0) + (_1640 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1728 = _1625;
            }
            _1729 = _1728;
            break;
        } while(false);
        vec4 _1730 = vec4(1.0);
        _1730.x = _1729;
        _1731 = _1730;
    }
    else
    {
        _1731 = vec4(1.0);
    }
    vec4 _2111;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1340].shadow_enabled.x > 0.0)
    {
        vec4 _1740 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2109;
        do
        {
            vec4 _1750 = dynamic_light_infos._m0[_1340].light_matrix * _1740;
            vec3 _1807;
            if (_1343 == 2u)
            {
                vec3 _1771 = _1750.xyz;
                vec3 _1773 = normalize(_1771) + vec3(0.0, 0.0, 1.0);
                float _1777 = length(_1771);
                vec3 _1780 = vec3((_1773 / vec3(_1773.z)).xy, _1777);
                float _1781 = _1750.z;
                vec3 _1793;
                if (_1781 > 0.0)
                {
                    _1793 = _1780;
                }
                else
                {
                    _1793 = vec3(normalize(_1780.xy) * 10000000.0, -_1777);
                }
                vec3 _1801 = vec3((_1793.x * 0.5) + 0.5, 0.5 - (_1793.y * 0.5), _1793.z);
                _1801.z = _1793.z * 9.9999997473787516355514526367188e-05;
                if (_1781 < 0.0)
                {
                    _2109 = 0.0;
                    break;
                }
                _1807 = _1801;
            }
            else
            {
                vec3 _1755 = _1750.xyz;
                vec3 _1767;
                if (_1343 == 1u)
                {
                    float _1759 = _1750.z;
                    vec3 _1766 = _1755;
                    _1766.z = _1759 - (((_1759 * dynamic_light_infos._m0[_1340].shadow_scale.z) + 1.0) / _1750.w);
                    _1767 = _1766;
                }
                else
                {
                    _1767 = _1755;
                }
                _1807 = _1767 / vec3(_1750.w);
            }
            float _1917;
            if (dynamic_light_infos._m0[_1340].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1899 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1807.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1807.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1807.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1807.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1340].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1807.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1807.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1340].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1807.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1807.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1340].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1807.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1807.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1340].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1807.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1807.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1340].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1917 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1340].shadow_scale.w * spvNMax(_1899, _1807.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1807.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1340].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1917 = 1.0;
            }
            vec2 _1918 = dynamic_light_infos._m0[_1340].shadow_scale.xy * _1917;
            float _2004 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1807.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, _1807.z, 1.0).xy, _1807.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1807.xy + (vec2(1.0, 0.0) * _1918), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, _1807.z, 1.0).xy, _1807.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1807.xy + (vec2(0.5, 0.865999996662139892578125) * _1918), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, _1807.z, 1.0).xy, _1807.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1807.xy + (vec2(-0.5, 0.865999996662139892578125) * _1918), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, _1807.z, 1.0).xy, _1807.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1807.xy + (vec2(-1.0, -0.0) * _1918), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, _1807.z, 1.0).xy, _1807.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1807.xy + (vec2(-0.5, -0.865999996662139892578125) * _1918), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, _1807.z, 1.0).xy, _1807.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1807.xy + (vec2(0.5, -0.865999996662139892578125) * _1918), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1340].shadow_atlas_offset_scale.xy, _1807.z, 1.0).xy, _1807.z), 0.0);
            float _2005 = _2004 * 0.14285714924335479736328125;
            float _2108;
            if (_1343 == 0u)
            {
                float _2020 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1740.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2022 = transpose(dynamic_light_infos._m0[_1340].light_matrix)[2];
                float _2027 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2036;
                if (_2027 > 0.100000001490116119384765625)
                {
                    _2036 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2036 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2047 = _1740.xyz - ((_2022.xyz / vec3(_2022.z)) * 1000.0);
                float _2071 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2036, _2047), dot(normalize(vec3(-_2036.y, _2036.x, 0.0)), _2047)) + (vec2(_2027, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2020 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2078 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2079 = _2078 - 1.0;
                float _2080 = 1.0 - cpass_cb.clouds_midpoint;
                float _2087 = 2.0 - _2078;
                _2108 = _2005 * mix(1.0, clamp(clamp(_2080 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2071), 0.0, 1.0), _2079)) * pow(clamp(_2080, 0.0, 1.0), _2087)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2071), 0.0, 1.0), _2079) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2087))), 0.0, 1.0) + (_2020 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2108 = _2005;
            }
            _2109 = _2108;
            break;
        } while(false);
        vec4 _2110 = _1731;
        _2110.y = _2109;
        _2111 = _2110;
    }
    else
    {
        _2111 = _1731;
    }
    vec4 _2491;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1344].shadow_enabled.x > 0.0)
    {
        vec4 _2120 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2489;
        do
        {
            vec4 _2130 = dynamic_light_infos._m0[_1344].light_matrix * _2120;
            vec3 _2187;
            if (_1347 == 2u)
            {
                vec3 _2151 = _2130.xyz;
                vec3 _2153 = normalize(_2151) + vec3(0.0, 0.0, 1.0);
                float _2157 = length(_2151);
                vec3 _2160 = vec3((_2153 / vec3(_2153.z)).xy, _2157);
                float _2161 = _2130.z;
                vec3 _2173;
                if (_2161 > 0.0)
                {
                    _2173 = _2160;
                }
                else
                {
                    _2173 = vec3(normalize(_2160.xy) * 10000000.0, -_2157);
                }
                vec3 _2181 = vec3((_2173.x * 0.5) + 0.5, 0.5 - (_2173.y * 0.5), _2173.z);
                _2181.z = _2173.z * 9.9999997473787516355514526367188e-05;
                if (_2161 < 0.0)
                {
                    _2489 = 0.0;
                    break;
                }
                _2187 = _2181;
            }
            else
            {
                vec3 _2135 = _2130.xyz;
                vec3 _2147;
                if (_1347 == 1u)
                {
                    float _2139 = _2130.z;
                    vec3 _2146 = _2135;
                    _2146.z = _2139 - (((_2139 * dynamic_light_infos._m0[_1344].shadow_scale.z) + 1.0) / _2130.w);
                    _2147 = _2146;
                }
                else
                {
                    _2147 = _2135;
                }
                _2187 = _2147 / vec3(_2130.w);
            }
            float _2297;
            if (dynamic_light_infos._m0[_1344].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2279 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2187.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2187.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2187.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2187.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1344].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2187.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2187.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1344].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2187.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2187.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1344].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2187.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2187.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1344].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2187.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2187.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1344].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2297 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1344].shadow_scale.w * spvNMax(_2279, _2187.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2187.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1344].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2297 = 1.0;
            }
            vec2 _2298 = dynamic_light_infos._m0[_1344].shadow_scale.xy * _2297;
            float _2384 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2187.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, _2187.z, 1.0).xy, _2187.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2187.xy + (vec2(1.0, 0.0) * _2298), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, _2187.z, 1.0).xy, _2187.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2187.xy + (vec2(0.5, 0.865999996662139892578125) * _2298), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, _2187.z, 1.0).xy, _2187.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2187.xy + (vec2(-0.5, 0.865999996662139892578125) * _2298), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, _2187.z, 1.0).xy, _2187.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2187.xy + (vec2(-1.0, -0.0) * _2298), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, _2187.z, 1.0).xy, _2187.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2187.xy + (vec2(-0.5, -0.865999996662139892578125) * _2298), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, _2187.z, 1.0).xy, _2187.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2187.xy + (vec2(0.5, -0.865999996662139892578125) * _2298), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1344].shadow_atlas_offset_scale.xy, _2187.z, 1.0).xy, _2187.z), 0.0);
            float _2385 = _2384 * 0.14285714924335479736328125;
            float _2488;
            if (_1347 == 0u)
            {
                float _2400 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2120.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2402 = transpose(dynamic_light_infos._m0[_1344].light_matrix)[2];
                float _2407 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2416;
                if (_2407 > 0.100000001490116119384765625)
                {
                    _2416 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2416 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2427 = _2120.xyz - ((_2402.xyz / vec3(_2402.z)) * 1000.0);
                float _2451 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2416, _2427), dot(normalize(vec3(-_2416.y, _2416.x, 0.0)), _2427)) + (vec2(_2407, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2400 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2458 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2459 = _2458 - 1.0;
                float _2460 = 1.0 - cpass_cb.clouds_midpoint;
                float _2467 = 2.0 - _2458;
                _2488 = _2385 * mix(1.0, clamp(clamp(_2460 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2451), 0.0, 1.0), _2459)) * pow(clamp(_2460, 0.0, 1.0), _2467)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2451), 0.0, 1.0), _2459) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2467))), 0.0, 1.0) + (_2400 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2488 = _2385;
            }
            _2489 = _2488;
            break;
        } while(false);
        vec4 _2490 = _2111;
        _2490.z = _2489;
        _2491 = _2490;
    }
    else
    {
        _2491 = _2111;
    }
    vec4 _2871;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1348].shadow_enabled.x > 0.0)
    {
        vec4 _2500 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2869;
        do
        {
            vec4 _2510 = dynamic_light_infos._m0[_1348].light_matrix * _2500;
            vec3 _2567;
            if (_1351 == 2u)
            {
                vec3 _2531 = _2510.xyz;
                vec3 _2533 = normalize(_2531) + vec3(0.0, 0.0, 1.0);
                float _2537 = length(_2531);
                vec3 _2540 = vec3((_2533 / vec3(_2533.z)).xy, _2537);
                float _2541 = _2510.z;
                vec3 _2553;
                if (_2541 > 0.0)
                {
                    _2553 = _2540;
                }
                else
                {
                    _2553 = vec3(normalize(_2540.xy) * 10000000.0, -_2537);
                }
                vec3 _2561 = vec3((_2553.x * 0.5) + 0.5, 0.5 - (_2553.y * 0.5), _2553.z);
                _2561.z = _2553.z * 9.9999997473787516355514526367188e-05;
                if (_2541 < 0.0)
                {
                    _2869 = 0.0;
                    break;
                }
                _2567 = _2561;
            }
            else
            {
                vec3 _2515 = _2510.xyz;
                vec3 _2527;
                if (_1351 == 1u)
                {
                    float _2519 = _2510.z;
                    vec3 _2526 = _2515;
                    _2526.z = _2519 - (((_2519 * dynamic_light_infos._m0[_1348].shadow_scale.z) + 1.0) / _2510.w);
                    _2527 = _2526;
                }
                else
                {
                    _2527 = _2515;
                }
                _2567 = _2527 / vec3(_2510.w);
            }
            float _2677;
            if (dynamic_light_infos._m0[_1348].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2659 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2567.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2567.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2567.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2567.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1348].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2567.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2567.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1348].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2567.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2567.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1348].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2567.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2567.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1348].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2567.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2567.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1348].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2677 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1348].shadow_scale.w * spvNMax(_2659, _2567.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2567.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1348].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2677 = 1.0;
            }
            vec2 _2678 = dynamic_light_infos._m0[_1348].shadow_scale.xy * _2677;
            float _2764 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2567.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, _2567.z, 1.0).xy, _2567.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2567.xy + (vec2(1.0, 0.0) * _2678), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, _2567.z, 1.0).xy, _2567.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2567.xy + (vec2(0.5, 0.865999996662139892578125) * _2678), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, _2567.z, 1.0).xy, _2567.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2567.xy + (vec2(-0.5, 0.865999996662139892578125) * _2678), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, _2567.z, 1.0).xy, _2567.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2567.xy + (vec2(-1.0, -0.0) * _2678), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, _2567.z, 1.0).xy, _2567.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2567.xy + (vec2(-0.5, -0.865999996662139892578125) * _2678), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, _2567.z, 1.0).xy, _2567.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2567.xy + (vec2(0.5, -0.865999996662139892578125) * _2678), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1348].shadow_atlas_offset_scale.xy, _2567.z, 1.0).xy, _2567.z), 0.0);
            float _2765 = _2764 * 0.14285714924335479736328125;
            float _2868;
            if (_1351 == 0u)
            {
                float _2780 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2500.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2782 = transpose(dynamic_light_infos._m0[_1348].light_matrix)[2];
                float _2787 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2796;
                if (_2787 > 0.100000001490116119384765625)
                {
                    _2796 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2796 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2807 = _2500.xyz - ((_2782.xyz / vec3(_2782.z)) * 1000.0);
                float _2831 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2796, _2807), dot(normalize(vec3(-_2796.y, _2796.x, 0.0)), _2807)) + (vec2(_2787, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2780 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2838 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2839 = _2838 - 1.0;
                float _2840 = 1.0 - cpass_cb.clouds_midpoint;
                float _2847 = 2.0 - _2838;
                _2868 = _2765 * mix(1.0, clamp(clamp(_2840 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2831), 0.0, 1.0), _2839)) * pow(clamp(_2840, 0.0, 1.0), _2847)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2831), 0.0, 1.0), _2839) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2847))), 0.0, 1.0) + (_2780 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2868 = _2765;
            }
            _2869 = _2868;
            break;
        } while(false);
        vec4 _2870 = _2491;
        _2870.w = _2869;
        _2871 = _2870;
    }
    else
    {
        _2871 = _2491;
    }
    vec3 _2938;
    vec3 _2939;
    switch (_1339)
    {
        case 0u:
        {
            _2938 = dynamic_light_infos._m0[_1336].light_color.xyz;
            _2939 = -dynamic_light_infos._m0[_1336].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _2915 = dynamic_light_infos._m0[_1336].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2916 = length(_2915);
            vec3 _2918 = _2915 / vec3(_2916);
            _2938 = dynamic_light_infos._m0[_1336].light_color.xyz * ((1.0 - clamp(_2916 / dynamic_light_infos._m0[_1336].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1336].light_direction.xyz, _2918) - dynamic_light_infos._m0[_1336].light_direction.w) / (dynamic_light_infos._m0[_1336].light_position.w - dynamic_light_infos._m0[_1336].light_direction.w), 0.0, 1.0));
            _2939 = _2918;
            break;
        }
        case 2u:
        {
            vec3 _2883 = dynamic_light_infos._m0[_1336].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2884 = length(_2883);
            float _2896 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1336].light_position.w, 0.0, 1.0));
            float _2901 = (_2884 / (dynamic_light_infos._m0[_1336].light_color.w / _2896)) + 1.0;
            float _2902 = _2884 / (dynamic_light_infos._m0[_1336].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1336].light_color.xyz), vec3(1.0)) * 2.0));
            float _2907 = clamp(1.0 - (((_2902 * _2902) * _2902) * _2902), 0.0, 1.0);
            _2938 = dynamic_light_infos._m0[_1336].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _2896) * _2896) * (_2907 * _2907)) / (_2901 * _2901));
            _2939 = _2883 / vec3(_2884);
            break;
        }
        default:
        {
            _2938 = vec3(0.0);
            _2939 = vec3(0.0);
            break;
        }
    }
    vec3 _2941 = normalize(_381);
    vec3 _2943 = -_2941;
    float _2945 = 1.0 - length(_381);
    vec3 _2951 = _2938 * (_2871.x * clamp((dot(_2943, -_2939) - _2945) * 2.5, 0.0, 1.0));
    vec3 _3003;
    vec3 _3004;
    vec3 _3005;
    if (length(_2951) > 0.0)
    {
        float _2957 = clamp(dot(_2939, _1165), 0.0, 1.0);
        float _2960 = clamp(1.0 - _403, 0.0, 1.0);
        float _2962 = spvNMax(_2960 * _2960, 0.00200000009499490261077880859375);
        float _2963 = _2962 * _2962;
        vec3 _2964 = -_1169;
        vec3 _2966 = normalize(_2964 + _2939);
        float _2968 = clamp(dot(_1165, _2966), 0.0, 1.0);
        float _2972 = clamp(dot(_2964, _2966), 0.0, 1.0);
        float _2979 = _2962 * 0.5;
        float _2980 = 1.0 - _2979;
        _3003 = _1190 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _2972) - 6.9831600189208984375) * _2972)), vec3(1.0), _436) * (_2963 / pow((((_2963 - 1.0) * _2968) * _2968) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_2964, _1165), 0.0, 1.0) * _2980) + _2979) * ((_2957 * _2980) + _2979)))) * _2957) * vec3(0.25)) * _2951);
        _3004 = _1192 + ((_2951 * _2957) * _389.xyz);
        _3005 = _1194 + _2951;
    }
    else
    {
        _3003 = _1190;
        _3004 = _1192;
        _3005 = _1194;
    }
    vec3 _3072;
    vec3 _3073;
    switch (_1343)
    {
        case 0u:
        {
            _3072 = dynamic_light_infos._m0[_1340].light_color.xyz;
            _3073 = -dynamic_light_infos._m0[_1340].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3049 = dynamic_light_infos._m0[_1340].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3050 = length(_3049);
            vec3 _3052 = _3049 / vec3(_3050);
            _3072 = dynamic_light_infos._m0[_1340].light_color.xyz * ((1.0 - clamp(_3050 / dynamic_light_infos._m0[_1340].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1340].light_direction.xyz, _3052) - dynamic_light_infos._m0[_1340].light_direction.w) / (dynamic_light_infos._m0[_1340].light_position.w - dynamic_light_infos._m0[_1340].light_direction.w), 0.0, 1.0));
            _3073 = _3052;
            break;
        }
        case 2u:
        {
            vec3 _3017 = dynamic_light_infos._m0[_1340].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3018 = length(_3017);
            float _3030 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1340].light_position.w, 0.0, 1.0));
            float _3035 = (_3018 / (dynamic_light_infos._m0[_1340].light_color.w / _3030)) + 1.0;
            float _3036 = _3018 / (dynamic_light_infos._m0[_1340].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1340].light_color.xyz), vec3(1.0)) * 2.0));
            float _3041 = clamp(1.0 - (((_3036 * _3036) * _3036) * _3036), 0.0, 1.0);
            _3072 = dynamic_light_infos._m0[_1340].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3030) * _3030) * (_3041 * _3041)) / (_3035 * _3035));
            _3073 = _3017 / vec3(_3018);
            break;
        }
        default:
        {
            _3072 = vec3(0.0);
            _3073 = vec3(0.0);
            break;
        }
    }
    vec3 _3081 = _3072 * (_2871.y * clamp((dot(_2943, -_3073) - _2945) * 2.5, 0.0, 1.0));
    vec3 _3133;
    vec3 _3134;
    vec3 _3135;
    if (length(_3081) > 0.0)
    {
        float _3087 = clamp(dot(_3073, _1165), 0.0, 1.0);
        float _3090 = clamp(1.0 - _403, 0.0, 1.0);
        float _3092 = spvNMax(_3090 * _3090, 0.00200000009499490261077880859375);
        float _3093 = _3092 * _3092;
        vec3 _3094 = -_1169;
        vec3 _3096 = normalize(_3094 + _3073);
        float _3098 = clamp(dot(_1165, _3096), 0.0, 1.0);
        float _3102 = clamp(dot(_3094, _3096), 0.0, 1.0);
        float _3109 = _3092 * 0.5;
        float _3110 = 1.0 - _3109;
        _3133 = _3003 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3102) - 6.9831600189208984375) * _3102)), vec3(1.0), _436) * (_3093 / pow((((_3093 - 1.0) * _3098) * _3098) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3094, _1165), 0.0, 1.0) * _3110) + _3109) * ((_3087 * _3110) + _3109)))) * _3087) * vec3(0.25)) * _3081);
        _3134 = _3004 + ((_3081 * _3087) * _389.xyz);
        _3135 = _3005 + _3081;
    }
    else
    {
        _3133 = _3003;
        _3134 = _3004;
        _3135 = _3005;
    }
    vec3 _3202;
    vec3 _3203;
    switch (_1347)
    {
        case 0u:
        {
            _3202 = dynamic_light_infos._m0[_1344].light_color.xyz;
            _3203 = -dynamic_light_infos._m0[_1344].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3179 = dynamic_light_infos._m0[_1344].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3180 = length(_3179);
            vec3 _3182 = _3179 / vec3(_3180);
            _3202 = dynamic_light_infos._m0[_1344].light_color.xyz * ((1.0 - clamp(_3180 / dynamic_light_infos._m0[_1344].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1344].light_direction.xyz, _3182) - dynamic_light_infos._m0[_1344].light_direction.w) / (dynamic_light_infos._m0[_1344].light_position.w - dynamic_light_infos._m0[_1344].light_direction.w), 0.0, 1.0));
            _3203 = _3182;
            break;
        }
        case 2u:
        {
            vec3 _3147 = dynamic_light_infos._m0[_1344].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3148 = length(_3147);
            float _3160 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1344].light_position.w, 0.0, 1.0));
            float _3165 = (_3148 / (dynamic_light_infos._m0[_1344].light_color.w / _3160)) + 1.0;
            float _3166 = _3148 / (dynamic_light_infos._m0[_1344].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1344].light_color.xyz), vec3(1.0)) * 2.0));
            float _3171 = clamp(1.0 - (((_3166 * _3166) * _3166) * _3166), 0.0, 1.0);
            _3202 = dynamic_light_infos._m0[_1344].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3160) * _3160) * (_3171 * _3171)) / (_3165 * _3165));
            _3203 = _3147 / vec3(_3148);
            break;
        }
        default:
        {
            _3202 = vec3(0.0);
            _3203 = vec3(0.0);
            break;
        }
    }
    vec3 _3211 = _3202 * (_2871.z * clamp((dot(_2943, -_3203) - _2945) * 2.5, 0.0, 1.0));
    vec3 _3263;
    vec3 _3264;
    vec3 _3265;
    if (length(_3211) > 0.0)
    {
        float _3217 = clamp(dot(_3203, _1165), 0.0, 1.0);
        float _3220 = clamp(1.0 - _403, 0.0, 1.0);
        float _3222 = spvNMax(_3220 * _3220, 0.00200000009499490261077880859375);
        float _3223 = _3222 * _3222;
        vec3 _3224 = -_1169;
        vec3 _3226 = normalize(_3224 + _3203);
        float _3228 = clamp(dot(_1165, _3226), 0.0, 1.0);
        float _3232 = clamp(dot(_3224, _3226), 0.0, 1.0);
        float _3239 = _3222 * 0.5;
        float _3240 = 1.0 - _3239;
        _3263 = _3133 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3232) - 6.9831600189208984375) * _3232)), vec3(1.0), _436) * (_3223 / pow((((_3223 - 1.0) * _3228) * _3228) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3224, _1165), 0.0, 1.0) * _3240) + _3239) * ((_3217 * _3240) + _3239)))) * _3217) * vec3(0.25)) * _3211);
        _3264 = _3134 + ((_3211 * _3217) * _389.xyz);
        _3265 = _3135 + _3211;
    }
    else
    {
        _3263 = _3133;
        _3264 = _3134;
        _3265 = _3135;
    }
    vec3 _3332;
    vec3 _3333;
    switch (_1351)
    {
        case 0u:
        {
            _3332 = dynamic_light_infos._m0[_1348].light_color.xyz;
            _3333 = -dynamic_light_infos._m0[_1348].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3309 = dynamic_light_infos._m0[_1348].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3310 = length(_3309);
            vec3 _3312 = _3309 / vec3(_3310);
            _3332 = dynamic_light_infos._m0[_1348].light_color.xyz * ((1.0 - clamp(_3310 / dynamic_light_infos._m0[_1348].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1348].light_direction.xyz, _3312) - dynamic_light_infos._m0[_1348].light_direction.w) / (dynamic_light_infos._m0[_1348].light_position.w - dynamic_light_infos._m0[_1348].light_direction.w), 0.0, 1.0));
            _3333 = _3312;
            break;
        }
        case 2u:
        {
            vec3 _3277 = dynamic_light_infos._m0[_1348].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3278 = length(_3277);
            float _3290 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1348].light_position.w, 0.0, 1.0));
            float _3295 = (_3278 / (dynamic_light_infos._m0[_1348].light_color.w / _3290)) + 1.0;
            float _3296 = _3278 / (dynamic_light_infos._m0[_1348].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1348].light_color.xyz), vec3(1.0)) * 2.0));
            float _3301 = clamp(1.0 - (((_3296 * _3296) * _3296) * _3296), 0.0, 1.0);
            _3332 = dynamic_light_infos._m0[_1348].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3290) * _3290) * (_3301 * _3301)) / (_3295 * _3295));
            _3333 = _3277 / vec3(_3278);
            break;
        }
        default:
        {
            _3332 = vec3(0.0);
            _3333 = vec3(0.0);
            break;
        }
    }
    vec3 _3341 = _3332 * (_2871.w * clamp((dot(_2943, -_3333) - _2945) * 2.5, 0.0, 1.0));
    vec3 _3393;
    vec3 _3394;
    vec3 _3395;
    if (length(_3341) > 0.0)
    {
        float _3347 = clamp(dot(_3333, _1165), 0.0, 1.0);
        float _3350 = clamp(1.0 - _403, 0.0, 1.0);
        float _3352 = spvNMax(_3350 * _3350, 0.00200000009499490261077880859375);
        float _3353 = _3352 * _3352;
        vec3 _3354 = -_1169;
        vec3 _3356 = normalize(_3354 + _3333);
        float _3358 = clamp(dot(_1165, _3356), 0.0, 1.0);
        float _3362 = clamp(dot(_3354, _3356), 0.0, 1.0);
        float _3369 = _3352 * 0.5;
        float _3370 = 1.0 - _3369;
        _3393 = _3264 + ((_3341 * _3347) * _389.xyz);
        _3394 = _3263 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3362) - 6.9831600189208984375) * _3362)), vec3(1.0), _436) * (_3353 / pow((((_3353 - 1.0) * _3358) * _3358) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3354, _1165), 0.0, 1.0) * _3370) + _3369) * ((_3347 * _3370) + _3369)))) * _3347) * vec3(0.25)) * _3341);
        _3395 = _3265 + _3341;
    }
    else
    {
        _3393 = _3264;
        _3394 = _3263;
        _3395 = _3265;
    }
    vec3 _3499;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _3408 = clamp(_403, 0.0, 1.0);
        float _3409 = 1.0 - _3408;
        float _3410 = _3409 * _3409;
        float _3413 = clamp(exp((-2.2999999523162841796875) * _3410), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _3414 = dot(_2941, _1170);
        vec2 _3421 = vec2(_3413, 0.0);
        float _3423 = -(_3414 * _3413);
        float _3424 = sqrt(clamp(1.0 - (_3414 * _3414), 0.0, 1.0)) * _3413;
        vec2 _3425 = vec2(_3423, _3424);
        float _3434 = sqrt(clamp(1.0 - (_3413 * _3413), 0.0, 1.0));
        vec4 _3460 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_1165, -_1169)), _3408, 0.0, 0.0).xy, 0.0);
        float _3473 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _3410));
        vec3 _3498 = _3394 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_1170, 0.0)).xyz, _3473).xyz, _3473).xyz * (vec3(_3460.x) + (_436 * _3460.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3395 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * ((2.0 * (acos(clamp(_3413 / sqrt(dot(_3421, _3421)), -1.0, 1.0)) + (acos(clamp(_3423 / (_3434 * sqrt(dot(_3425, _3425))), -1.0, 1.0)) - (acos(clamp((_3423 * _3413) / (_3424 * _3434), -1.0, 1.0)) * _3413)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _3413))));
        _3499 = _3498;
    }
    else
    {
        _3499 = _3394;
    }
    vec3 _3541;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _3541 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_381, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3395 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _389.xyz) * 1.0) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _3541 = vec3(0.0);
    }
    vec3 _3546 = (_3393 * cpass_cb.indirect_light_multiplier) + (_711 * 20.0);
    vec3 _3559 = (_3393 + _711) + (_3541 + spvNMax(vec3(0.0), _3499 / vec3(spvNMax(10.0, spvNMax(_3499.x, spvNMax(_3499.y, _3499.z))) * 0.100000001490116119384765625)));
    vec4 _3560 = vec4(_3559.x, _3559.y, _3559.z, vec4(0.0).w);
    _3560.w = _1153;
    out_var_SV_TARGET = _3560;
    out_var_SV_TARGET1 = vec4(_3546, _1153);
}

