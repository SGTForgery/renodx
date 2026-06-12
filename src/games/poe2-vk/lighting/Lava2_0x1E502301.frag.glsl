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

const ivec2 _289[4] = ivec2[](ivec2(0), ivec2(1, 0), ivec2(0, 1), ivec2(1));
float _301;
vec4 _302;
float _309;
vec4 _310;

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
layout(set = 1, binding = 0) uniform texture2D ambient_light_tex;
layout(set = 1, binding = 7) uniform texture2D depth_sampler;
layout(set = 1, binding = 8) uniform textureCube diffuse_cube;
layout(set = 1, binding = 11) uniform texture2D environment_ggx_sampler;
layout(set = 1, binding = 18) uniform usamplerBuffer light_indices;
layout(set = 1, binding = 19) uniform utexture2D light_lookup;
layout(set = 1, binding = 21) uniform texture2D noise_sampler;
layout(set = 1, binding = 29) uniform texture2D screenspace_shadowmap;
layout(set = 1, binding = 31) uniform textureCube specular_cube;
layout(set = 1, binding = 34) uniform texture2D tex_shadow_map_atlas;
layout(set = 2, binding = 48) uniform texture2D texture_object_0;
layout(set = 2, binding = 49) uniform texture2D input_texture_0;
layout(set = 3, binding = 53) uniform texture2D tile_ground_normal_texture;

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
    vec2 _348 = unpackHalf2x16((particles_data_read._m0[in_var_AUTO_EFMAIHMN_BABABNNF].angular_velocity.y >> 16u) & 65535u);
    float _349 = _348.x;
    vec2 _355 = vec2(cpipeline_cb.maya_scale_pivot_0.x, 1.0 - cpipeline_cb.maya_scale_pivot_0.y);
    vec2 _373 = (((in_var_TEXCOORD1 - _355) * vec2(1.0, 0.5)) + _355) + (vec2((cpipeline_cb.constant_bool_1 != 0u) ? pow(spvNMax(abs(in_var_AUTO_NHPEAEOB_ANHFJCCP.w), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_4) : cpass_cb.time) * vec2(0.0, -0.0500000007450580596923828125));
    mat3 _374 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _388 = ((vec2(textureLod(sampler2D(texture_object_0, SamplerDynamicWrap), vec4(_373, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _389 = vec3(_388.x, _388.y, vec3(0.0).z);
    vec2 _390 = _388.xy;
    _389.z = sqrt(spvNMax(1.0 - dot(_390, _390), 0.0));
    vec3 _396 = _374 * _389;
    vec4 _402 = texture(sampler2D(texture_object_0, SamplerDynamicWrap), _373);
    float _403 = _402.z;
    vec3 _408 = vec3(pow(spvNMax(abs(_403), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_396 / vec3(length(_396) + 1.0000000116860974230803549289703e-07));
    vec4 _411 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _373);
    vec3 _412 = _411.xyz;
    vec3 _414 = vec3(_411.w);
    vec3 _416 = clamp(mix(_412, vec3(0.0), _414), vec3(0.0), vec3(1.0));
    vec2 _422 = ((vec2(_402.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _423 = vec3(_422.x, _422.y, vec3(0.0).z);
    vec2 _424 = _422.xy;
    _423.z = sqrt(spvNMax(1.0 - dot(_424, _424), 0.0));
    float _430 = _402.w;
    float _439 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _440 = cos(_439);
    vec3 _455 = (((_412 * _440) + (cross(vec3(0.57735002040863037109375), _412) * sin(_439))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _412)) * (1.0 - _440))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _463 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_455, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _455, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _414), vec3(0.0), vec3(1.0));
    bool _466 = cpipeline_cb.constant_trackG_0 < 0;
    float _468 = clamp(_403, 0.0, 1.0) * 127.0;
    int _472 = int(spvNMax(trunc(_468), 0.0) + 0.5);
    int _477 = int(spvNMin(trunc(_468 + 1.0), 127.0) + 0.5);
    float _495;
    if (_466)
    {
        _495 = 0.0;
    }
    else
    {
        uint _481 = uint(cpipeline_cb.constant_trackG_0);
        int _482 = _472 / 2;
        _495 = ((_472 - 2 * (_472 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_481].value[_482] & 65535u).x : unpackHalf2x16((spline_lut._m0[_481].value[_482] >> 16u) & 65535u).x;
    }
    float _513;
    if (_466)
    {
        _513 = 0.0;
    }
    else
    {
        uint _499 = uint(cpipeline_cb.constant_trackG_0);
        int _500 = _477 / 2;
        _513 = ((_477 - 2 * (_477 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_499].value[_500] & 65535u).x : unpackHalf2x16((spline_lut._m0[_499].value[_500] >> 16u) & 65535u).x;
    }
    float _514 = fract(_468);
    bool _520 = cpipeline_cb.constant_trackG_1 < 0;
    float _538;
    if (_520)
    {
        _538 = 0.0;
    }
    else
    {
        uint _524 = uint(cpipeline_cb.constant_trackG_1);
        int _525 = _472 / 2;
        _538 = ((_472 - 2 * (_472 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_524].value[_525] & 65535u).x : unpackHalf2x16((spline_lut._m0[_524].value[_525] >> 16u) & 65535u).x;
    }
    float _556;
    if (_520)
    {
        _556 = 0.0;
    }
    else
    {
        uint _542 = uint(cpipeline_cb.constant_trackG_1);
        int _543 = _477 / 2;
        _556 = ((_477 - 2 * (_477 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_542].value[_543] & 65535u).x : unpackHalf2x16((spline_lut._m0[_542].value[_543] >> 16u) & 65535u).x;
    }
    float _565 = clamp((spvNMax(vec3(mix(_495, _513, _514), _309, _309), vec3(0.0)) + spvNMax(vec3(mix(_538, _556, _514), _309, _309), vec3(0.0))).x, 0.0, 1.0) * 127.0;
    int _570 = int(spvNMax(trunc(_565), 0.0) + 0.5);
    int _575 = int(spvNMin(trunc(_565 + 1.0), 127.0) + 0.5);
    bool _576 = cpipeline_cb.constant_trackC_0.x < 0;
    float _594;
    if (_576)
    {
        _594 = 0.0;
    }
    else
    {
        uint _580 = uint(cpipeline_cb.constant_trackC_0.x);
        int _581 = _570 / 2;
        _594 = ((_570 - 2 * (_570 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_580].value[_581] & 65535u).x : unpackHalf2x16((spline_lut._m0[_580].value[_581] >> 16u) & 65535u).x;
    }
    float _612;
    if (_576)
    {
        _612 = 0.0;
    }
    else
    {
        uint _598 = uint(cpipeline_cb.constant_trackC_0.x);
        int _599 = _575 / 2;
        _612 = ((_575 - 2 * (_575 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_598].value[_599] & 65535u).x : unpackHalf2x16((spline_lut._m0[_598].value[_599] >> 16u) & 65535u).x;
    }
    float _613 = fract(_565);
    bool _616 = cpipeline_cb.constant_trackC_0.y < 0;
    float _634;
    if (_616)
    {
        _634 = 0.0;
    }
    else
    {
        uint _620 = uint(cpipeline_cb.constant_trackC_0.y);
        int _621 = _570 / 2;
        _634 = ((_570 - 2 * (_570 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_620].value[_621] & 65535u).x : unpackHalf2x16((spline_lut._m0[_620].value[_621] >> 16u) & 65535u).x;
    }
    float _652;
    if (_616)
    {
        _652 = 0.0;
    }
    else
    {
        uint _638 = uint(cpipeline_cb.constant_trackC_0.y);
        int _639 = _575 / 2;
        _652 = ((_575 - 2 * (_575 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_638].value[_639] & 65535u).x : unpackHalf2x16((spline_lut._m0[_638].value[_639] >> 16u) & 65535u).x;
    }
    bool _655 = cpipeline_cb.constant_trackC_0.z < 0;
    float _673;
    if (_655)
    {
        _673 = 0.0;
    }
    else
    {
        uint _659 = uint(cpipeline_cb.constant_trackC_0.z);
        int _660 = _570 / 2;
        _673 = ((_570 - 2 * (_570 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_659].value[_660] & 65535u).x : unpackHalf2x16((spline_lut._m0[_659].value[_660] >> 16u) & 65535u).x;
    }
    float _691;
    if (_655)
    {
        _691 = 0.0;
    }
    else
    {
        uint _677 = uint(cpipeline_cb.constant_trackC_0.z);
        int _678 = _575 / 2;
        _691 = ((_575 - 2 * (_575 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_677].value[_678] & 65535u).x : unpackHalf2x16((spline_lut._m0[_677].value[_678] >> 16u) & 65535u).x;
    }
    bool _694 = cpipeline_cb.constant_trackC_0.w < 0;
    float _712;
    if (_694)
    {
        _712 = 0.0;
    }
    else
    {
        uint _698 = uint(cpipeline_cb.constant_trackC_0.w);
        int _699 = _570 / 2;
        _712 = ((_570 - 2 * (_570 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_698].value[_699] & 65535u).x : unpackHalf2x16((spline_lut._m0[_698].value[_699] >> 16u) & 65535u).x;
    }
    float _730;
    if (_694)
    {
        _730 = 0.0;
    }
    else
    {
        uint _716 = uint(cpipeline_cb.constant_trackC_0.w);
        int _717 = _575 / 2;
        _730 = ((_575 - 2 * (_575 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_716].value[_717] & 65535u).x : unpackHalf2x16((spline_lut._m0[_716].value[_717] >> 16u) & 65535u).x;
    }
    float _731 = mix(_712, _730, _613);
    vec3 _738 = spvNMin((vec4(mix(_594, _612, _613), mix(_634, _652, _613), mix(_673, _691, _613), _731).xyz * vec3(spvNMax(_731, 0.0))) * 5.0, vec3(100.0));
    bool _741 = cpipeline_cb.constant_trackG_2 < 0;
    float _759;
    if (_741)
    {
        _759 = 0.0;
    }
    else
    {
        uint _745 = uint(cpipeline_cb.constant_trackG_2);
        int _746 = _472 / 2;
        _759 = ((_472 - 2 * (_472 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_745].value[_746] & 65535u).x : unpackHalf2x16((spline_lut._m0[_745].value[_746] >> 16u) & 65535u).x;
    }
    float _777;
    if (_741)
    {
        _777 = 0.0;
    }
    else
    {
        uint _763 = uint(cpipeline_cb.constant_trackG_2);
        int _764 = _477 / 2;
        _777 = ((_477 - 2 * (_477 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_763].value[_764] & 65535u).x : unpackHalf2x16((spline_lut._m0[_763].value[_764] >> 16u) & 65535u).x;
    }
    vec4 _783;
    _783.w = _403;
    uint _793 = in_var_INSTANCEID / cobject_cb.instance_count;
    float _802 = clamp(uintBitsToFloat((uint(cobject_cb.instances[_793].synced_random_seed.x) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0);
    float _803 = (cpipeline_cb.constant_bool_2 != 0u) ? _802 : _349;
    uvec3 _807 = (floatBitsToUint(vec3(_803, 0.443972110748291015625, 0.2921483516693115234375)) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _808 = _807.y;
    uint _809 = _807.z;
    uint _812 = _807.x + (_808 * _809);
    uint _814 = _808 + (_809 * _812);
    uvec3 _817 = uvec3(_812, _814, _809 + (_812 * _814));
    uvec3 _819 = _817 ^ (_817 >> uvec3(16u));
    uint _820 = _819.y;
    uint _821 = _819.z;
    uint _824 = _819.x + (_820 * _821);
    uint _826 = _820 + (_821 * _824);
    float _855 = (((0.2989999949932098388671875 * _422.x) + (0.58700001239776611328125 * _422.y)) - 0.5) * 2.0;
    vec2 _863 = vec2(1.0) - in_var_AUTO_CELDJDLE_GEBKIEDD;
    vec3 _864 = vec3(0.443972110748291015625, 0.0, 0.0);
    _864.y = _803;
    _864.z = 0.2921483516693115234375;
    uvec3 _868 = (floatBitsToUint(_864) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _869 = _868.y;
    uint _870 = _868.z;
    uint _873 = _868.x + (_869 * _870);
    uint _875 = _869 + (_870 * _873);
    uvec3 _878 = uvec3(_873, _875, _870 + (_873 * _875));
    uvec3 _880 = _878 ^ (_878 >> uvec3(16u));
    vec2 _896 = vec2(mix(cpipeline_cb.constant2_9.x, cpipeline_cb.constant2_9.y, clamp(uintBitsToFloat(((_880.x + (_880.y * _880.z)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0)));
    vec2 _933 = (cobject_cb.instances[_793].tile_ground_tiling * in_var_TEXCOORD0.xy) * cpass_cb.ground_scalemove_uv.xy;
    vec4 _939 = texture(sampler2D(tile_ground_normal_texture, SamplerLinearWrap), _933);
    bool _940 = cobject_cb.instances[_793].tile_ground_normal_swizzle == 1u;
    vec2 _946;
    if (_940)
    {
        _946 = _939.wy;
    }
    else
    {
        _946 = _939.xy;
    }
    float _964 = clamp(pow(spvNMax(abs(clamp((((in_var_AUTO_CELDJDLE_GEBKIEDD + (((vec4(_309, _946.y, _301, _301).xy - vec2(0.5)) * vec2(2.0)) * vec2(mix(cpipeline_cb.constant2_6.x, cpipeline_cb.constant2_6.y, clamp(uintBitsToFloat((_824 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (_423.xy * vec2(mix(cpipeline_cb.constant2_7.x, cpipeline_cb.constant2_7.y, clamp(uintBitsToFloat(((_821 + (_824 * _826)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (mix(mix(vec2(-1.0), vec2(0.0), vec2(cpipeline_cb.constant2_8.x)), vec2(-1.0), vec2(cpipeline_cb.constant2_8.y)) * mix(mix(_896, _896 * in_var_AUTO_CELDJDLE_GEBKIEDD, vec2(cpipeline_cb.constant2_10.x)), _863, vec2(cpipeline_cb.constant2_10.y)))).y, 0.0, 1.0)), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_9), 0.0, 1.0);
    float _965 = _964 * 127.0;
    int _969 = int(spvNMax(trunc(_965), 0.0) + 0.5);
    int _974 = int(spvNMin(trunc(_965 + 1.0), 127.0) + 0.5);
    bool _975 = cpipeline_cb.constant_trackG_3 < 0;
    float _993;
    if (_975)
    {
        _993 = 0.0;
    }
    else
    {
        uint _979 = uint(cpipeline_cb.constant_trackG_3);
        int _980 = _969 / 2;
        _993 = ((_969 - 2 * (_969 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_979].value[_980] & 65535u).x : unpackHalf2x16((spline_lut._m0[_979].value[_980] >> 16u) & 65535u).x;
    }
    float _1011;
    if (_975)
    {
        _1011 = 0.0;
    }
    else
    {
        uint _997 = uint(cpipeline_cb.constant_trackG_3);
        int _998 = _974 / 2;
        _1011 = ((_974 - 2 * (_974 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_997].value[_998] & 65535u).x : unpackHalf2x16((spline_lut._m0[_997].value[_998] >> 16u) & 65535u).x;
    }
    float _1014 = mix(_993, _1011, fract(_965)) - clamp(-(_855 * mix(cpipeline_cb.constant2_13.x, cpipeline_cb.constant2_13.y, clamp(uintBitsToFloat((_826 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))), 0.0, 1.0);
    float _1029 = (cpipeline_cb.constant_bool_4 != 0u) ? _802 : _349;
    uvec3 _1033 = (floatBitsToUint(vec3(_1029, 0.17456948757171630859375, 0.19825279712677001953125)) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _1034 = _1033.y;
    uint _1035 = _1033.z;
    uint _1038 = _1033.x + (_1034 * _1035);
    uint _1040 = _1034 + (_1035 * _1038);
    uvec3 _1043 = uvec3(_1038, _1040, _1035 + (_1038 * _1040));
    uvec3 _1045 = _1043 ^ (_1043 >> uvec3(16u));
    uint _1046 = _1045.y;
    uint _1047 = _1045.z;
    uint _1050 = _1045.x + (_1046 * _1047);
    uint _1052 = _1046 + (_1047 * _1050);
    vec3 _1082 = vec3(0.17456948757171630859375, 0.0, 0.0);
    _1082.y = _1029;
    _1082.z = 0.19825279712677001953125;
    uvec3 _1086 = (floatBitsToUint(_1082) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _1087 = _1086.y;
    uint _1088 = _1086.z;
    uint _1091 = _1086.x + (_1087 * _1088);
    uint _1093 = _1087 + (_1088 * _1091);
    uvec3 _1096 = uvec3(_1091, _1093, _1088 + (_1091 * _1093));
    uvec3 _1098 = _1096 ^ (_1096 >> uvec3(16u));
    vec2 _1114 = vec2(mix(cpipeline_cb.constant2_17.x, cpipeline_cb.constant2_17.y, clamp(uintBitsToFloat(((_1098.x + (_1098.y * _1098.z)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0)));
    vec4 _1144 = texture(sampler2D(tile_ground_normal_texture, SamplerLinearWrap), _933);
    vec2 _1150;
    if (_940)
    {
        _1150 = _1144.wy;
    }
    else
    {
        _1150 = _1144.xy;
    }
    float _1168 = clamp(pow(spvNMax(abs(clamp((((in_var_AUTO_CELDJDLE_GEBKIEDD + (((vec4(_309, _1150.y, _301, _301).xy - vec2(0.5)) * vec2(2.0)) * vec2(mix(cpipeline_cb.constant2_14.x, cpipeline_cb.constant2_14.y, clamp(uintBitsToFloat((_1050 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (_423.xy * vec2(mix(cpipeline_cb.constant2_15.x, cpipeline_cb.constant2_15.y, clamp(uintBitsToFloat(((_1047 + (_1050 * _1052)) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))))) + (mix(mix(vec2(-1.0), vec2(0.0), vec2(cpipeline_cb.constant2_16.x)), vec2(-1.0), vec2(cpipeline_cb.constant2_16.y)) * mix(mix(_1114, _1114 * in_var_AUTO_CELDJDLE_GEBKIEDD, vec2(cpipeline_cb.constant2_18.x)), _863, vec2(cpipeline_cb.constant2_18.y)))).y, 0.0, 1.0)), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_11), 0.0, 1.0);
    float _1169 = _1168 * 127.0;
    int _1173 = int(spvNMax(trunc(_1169), 0.0) + 0.5);
    int _1178 = int(spvNMin(trunc(_1169 + 1.0), 127.0) + 0.5);
    bool _1179 = cpipeline_cb.constant_trackG_4 < 0;
    float _1197;
    if (_1179)
    {
        _1197 = 0.0;
    }
    else
    {
        uint _1183 = uint(cpipeline_cb.constant_trackG_4);
        int _1184 = _1173 / 2;
        _1197 = ((_1173 - 2 * (_1173 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_1183].value[_1184] & 65535u).x : unpackHalf2x16((spline_lut._m0[_1183].value[_1184] >> 16u) & 65535u).x;
    }
    float _1215;
    if (_1179)
    {
        _1215 = 0.0;
    }
    else
    {
        uint _1201 = uint(cpipeline_cb.constant_trackG_4);
        int _1202 = _1178 / 2;
        _1215 = ((_1178 - 2 * (_1178 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_1201].value[_1202] & 65535u).x : unpackHalf2x16((spline_lut._m0[_1201].value[_1202] >> 16u) & 65535u).x;
    }
    float _1218 = mix(_1197, _1215, fract(_1169)) - clamp(-(_855 * mix(cpipeline_cb.constant2_21.x, cpipeline_cb.constant2_21.y, clamp(uintBitsToFloat((_1052 >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))), 0.0, 1.0);
    float _1226 = clamp((vec3(clamp((vec3(clamp(spvNMax(vec3(mix(_759, _777, _514), _309, _309), vec3(0.0)).x, 0.0, 1.0)) + vec3((cpipeline_cb.constant_bool_3 != 0u) ? spvNMax(_1014, 0.0) : clamp(_1014, 0.0, 1.0))).x, 0.0, 1.0)) * vec3((cpipeline_cb.constant_bool_5 != 0u) ? spvNMax(_1218, 0.0) : clamp(_1218, 0.0, 1.0))).x, 0.0, 1.0);
    float _1230;
    _1230 = 0.0;
    float _1231;
    for (uint _1233 = 0u; _1233 < 1u; _1230 = _1231, _1233++)
    {
        uint _1238 = cpipeline_cb.constantUInt1_122 / 4u;
        uint _1239 = cpipeline_cb.constantUInt1_122 % 4u;
        vec4 _1268;
        if (!(((particles_emitter_data._m0[cobject_cb.instances[_793].gpu_particle_emitter].culling_tag >> 14u) & 512u) == 0u))
        {
            vec4 _1267;
            if (floatBitsToUint(cpass_cb.frame_delta_time.w) == 0u)
            {
                _1267 = vec4(_309, 0.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            else
            {
                _1267 = vec4(0.0, 1.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            _1268 = _1267;
        }
        else
        {
            _1268 = cpass_cb.frame_delta_time;
        }
        float _1276 = mix(particles_emitter_data._m0[cobject_cb.instances[_793].gpu_particle_emitter].prev_time, particles_emitter_data._m0[cobject_cb.instances[_793].gpu_particle_emitter].time, _1268.z) / particles_emitter_data._m0[cobject_cb.instances[_793].gpu_particle_emitter].emitter_duration;
        float _1277 = spvNMax(0.0, _1276);
        float _1283;
        if (((particles_emitter_data._m0[cobject_cb.instances[_793].gpu_particle_emitter].culling_tag >> 14u) & 2u) != 0u)
        {
            _1283 = fract(_1277);
        }
        else
        {
            _1283 = _1277;
        }
        float _1290 = spvNMax(cpipeline_cb.constant1_14, 9.9999997473787516355514526367188e-05);
        float _1297;
        if (abs(_1290) > 0.0)
        {
            _1297 = in_var_AUTO_PIPJIEKO_LDBDDLHP / _1290;
        }
        else
        {
            _1297 = 0.0;
        }
        float _1304;
        if (_1239 == 0u)
        {
            _1304 = _1297;
        }
        else
        {
            _1304 = (_1239 == 1u) ? clamp((abs(particles_emitter_data._m0[cobject_cb.instances[_793].gpu_particle_emitter].emitter_duration) > 0.0) ? _1276 : 0.0, 0.0, 1.0) : 0.0;
        }
        float _1312;
        if (abs(cobject_cb.instances[_793].gpu_particles_duration.x) > 0.0)
        {
            _1312 = (in_var_AUTO_PIPJIEKO_CIFEPFLO * in_var_AUTO_PIPJIEKO_EIDIDJP) / cobject_cb.instances[_793].gpu_particles_duration.x;
        }
        else
        {
            _1312 = 0.0;
        }
        float _1329;
        if (cpipeline_cb.constantUInt1_122 == 0u)
        {
            _1329 = in_var_AUTO_PIPJIEKO_CIFEPFLO;
        }
        else
        {
            float _1328;
            if (cpipeline_cb.constantUInt1_122 == 1u)
            {
                _1328 = _1283;
            }
            else
            {
                float _1327;
                if (cpipeline_cb.constantUInt1_122 == 2u)
                {
                    _1327 = in_var_AUTO_PIPJIEKO_IINFNGPI;
                }
                else
                {
                    _1327 = (cpipeline_cb.constantUInt1_122 == 3u) ? _1312 : 0.0;
                }
                _1328 = _1327;
            }
            _1329 = _1328;
        }
        if (_1238 == 0u)
        {
            _1231 = _1329;
        }
        else
        {
            _1231 = (_1238 == 1u) ? _1304 : 0.0;
        }
    }
    float _1339 = clamp(_1230, 0.0, 1.0);
    float _1349 = _1339 * _1339;
    float _1360 = spvNMax(dot(cpipeline_cb.constant_track5_5.segment_polynom[(_1339 < cpipeline_cb.constant_track5_5.time_variance.x) ? 0u : ((_1339 < cpipeline_cb.constant_track5_5.time_variance.y) ? 1u : ((_1339 < cpipeline_cb.constant_track5_5.time_variance.z) ? 2u : 3u))], vec4(_1349 * _1339, _1349, _1339, 1.0)) + (((_349 - 0.5) * 2.0) * cpipeline_cb.constant_track5_5.time_variance.w), 0.0);
    float _1365 = clamp(mix(_1226 * _1360, _1226 - (1.0 - _1360), 0.25), 0.0, 1.0);
    vec3 _1366 = _374 * _423;
    vec3 _1370 = _1366 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_1366)));
    vec3 _1374 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _1375 = reflect(_1374, _1370);
    vec4 _1378 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _302.w);
    _1378.w = 1.0;
    vec4 _1380 = cpass_cb.scene_view_projection_transform * _1378;
    vec4 _1383 = _1380 / vec4(_1380.w);
    vec2 _1386 = (_1383.xy * 0.5) + vec2(0.5);
    float _1387 = _1386.y;
    float _1388 = 1.0 - _1387;
    float _1389 = _1386.x;
    vec3 _1390 = vec3(_1389, _1388, _301);
    ivec2 _1396 = ivec2(uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)));
    vec2 _1406 = vec2(1.0) / vec2(float(uint(_1396.x) / 1u), float(uint(_1396.y) / 1u));
    bool _1422;
    if (cpass_cb.sh_probe_spacing > 0)
    {
        _1422 = cpass_cb.ssgi_intensity > 0.5;
    }
    else
    {
        _1422 = false;
    }
    vec4 _1770;
    if (_1422)
    {
        vec3 _1433 = clamp((cpass_cb.scene_view_transform * vec4(_1370, 0.0)).xyz, vec3(-1.0), vec3(1.0));
        float _1434 = _1383.z;
        ivec2 _1440 = ivec2(cpass_cb.sh_probe_spacing);
        ivec2 _1441 = ivec2(uvec2(vec2(_1396) * cpass_cb.frame_to_dynamic_scale.xy));
        vec4 _1450 = cpass_cb.scene_view_projection_transform_inv * vec4((_1389 * 2.0) - 1.0, (_1387 * 2.0) - 1.0, _1434, 1.0);
        vec3 _1454 = (_1450 / vec4(_1450.w)).xyz;
        ivec2 _1455 = _1440 / ivec2(2);
        vec2 _1456 = vec2(_1440);
        vec2 _1457 = vec2(1.0) / _1456;
        vec2 _1458 = vec2(_1455);
        vec2 _1461 = vec2(_1441);
        vec2 _1463 = vec2(1.0) / _1461;
        vec2 _1465 = (_1458 + vec2(0.5)) * _1463;
        vec2 _1466 = _1456 * _1463;
        vec2 _1468 = ((vec2(-0.5) - _1458) * _1457) + ((_1461 * _1457) * vec3(_1389, _1388, _1434).xy);
        ivec2 _1470 = ivec2(floor(_1468));
        vec3 _314[4];
        for (int _1473 = 0; _1473 < 4; _1473++)
        {
            ivec2 _1481 = _1470 + _289[_1473];
            ivec2 _1483 = _1455 + (_1440 * _1481);
            int _1484 = _1483.x;
            bool _1490;
            if (_1484 >= 0)
            {
                _1490 = _1483.y >= 0;
            }
            else
            {
                _1490 = false;
            }
            bool _1495;
            if (_1490)
            {
                _1495 = _1484 < _1441.x;
            }
            else
            {
                _1495 = false;
            }
            bool _1501;
            if (_1495)
            {
                _1501 = _1483.y < _1441.y;
            }
            else
            {
                _1501 = false;
            }
            vec4 _1509;
            if (_1501)
            {
                _1509 = texelFetch(depth_sampler, ivec3(_1484, _1483.y, 0).xy, 0);
            }
            else
            {
                _1509 = vec4(1.0);
            }
            vec2 _1513 = clamp(_1465 + (_1466 * vec2(_1481)), vec2(0.0), vec2(1.0));
            vec4 _1523 = cpass_cb.scene_view_projection_transform_inv * vec4((_1513.x * 2.0) - 1.0, ((1.0 - _1513.y) * 2.0) - 1.0, _1509.x, 1.0);
            _314[_1473] = (_1523 / vec4(_1523.w)).xyz;
        }
        vec2 _1535;
        _1535 = fract(_1468);
        for (int _1538 = 0; _1538 < 2; )
        {
            vec3 _1543 = vec3(_1535.y);
            vec3 _1544 = mix(_314[0], _314[2], _1543);
            vec3 _1546 = mix(_314[1], _314[3], _1543) - _1544;
            float _1551 = clamp(dot(_1454 - _1544, _1546) / dot(_1546, _1546), 0.0, 1.0);
            vec3 _1552 = vec3(_1551);
            vec3 _1553 = mix(_314[0], _314[1], _1552);
            vec3 _1555 = mix(_314[2], _314[3], _1552) - _1553;
            _1535 = vec2(_1551, clamp(dot(_1454 - _1553, _1555) / dot(_1555, _1555), 0.0, 1.0));
            _1538++;
            continue;
        }
        vec2 _1562 = vec2(_1470) + _1535;
        uvec2 _1569 = uvec2(textureSize(ambient_light_tex, 0));
        vec2 _1577 = vec2(1.0) / vec2(float(int(_1569.x)), float(int(_1569.y)));
        uvec2 _1579 = uvec2(ivec2(uvec2(cpass_cb.sh_atlas_size) / uvec2(2u)));
        vec2 _1584 = ((vec2(uvec2(0u) * _1579) + _1562) + vec2(0.5)) * _1577;
        vec2 _1595 = ((vec2(uvec2(1u, 0u) * _1579) + _1562) + vec2(0.5)) * _1577;
        vec2 _1606 = ((vec2(uvec2(1u) * _1579) + _1562) + vec2(0.5)) * _1577;
        vec2 _1617 = ((vec2(uvec2(0u, 1u) * _1579) + _1562) + vec2(0.5)) * _1577;
        mat4 _1625 = transpose(mat4(textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1584, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1595, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1606, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1617, 0.0, 0.0).xy, 0.0)));
        vec4 _1763;
        if (cpass_cb.gi_self_lighting != 0u)
        {
            vec4 _1737 = _1625[0];
            vec4 _1743 = _1625[1];
            vec4 _1749 = _1625[2];
            vec4 _1755 = _1625[3];
            _1763 = spvNMax(vec4(0.0), vec4(_1737.x + (dot(_1737.yzw, _1433) * 2.0), _1743.x + (dot(_1743.yzw, _1433) * 2.0), _1749.x + (dot(_1749.yzw, _1433) * 2.0), _1755.x + (dot(_1755.yzw, _1433) * 2.0)));
        }
        else
        {
            vec4 _1632 = _1625[0];
            vec3 _1633 = _1632.yzw;
            float _1634 = length(_1633);
            float _1641 = _1632.x;
            float _1643 = _1634 / spvNMax(1.0000000116860974230803549289703e-07, _1641);
            float _1644 = 2.0 * _1643;
            float _1649 = (1.0 - _1643) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1643);
            vec4 _1658 = _1625[1];
            vec3 _1659 = _1658.yzw;
            float _1660 = length(_1659);
            float _1667 = _1658.x;
            float _1669 = _1660 / spvNMax(1.0000000116860974230803549289703e-07, _1667);
            float _1670 = 2.0 * _1669;
            float _1675 = (1.0 - _1669) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1669);
            vec4 _1684 = _1625[2];
            vec3 _1685 = _1684.yzw;
            float _1686 = length(_1685);
            float _1693 = _1684.x;
            float _1695 = _1686 / spvNMax(1.0000000116860974230803549289703e-07, _1693);
            float _1696 = 2.0 * _1695;
            float _1701 = (1.0 - _1695) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1695);
            vec4 _1710 = _1625[3];
            vec3 _1711 = _1710.yzw;
            float _1712 = length(_1711);
            float _1719 = _1710.x;
            float _1721 = _1712 / spvNMax(1.0000000116860974230803549289703e-07, _1719);
            float _1722 = 2.0 * _1721;
            float _1727 = (1.0 - _1721) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1721);
            _1763 = vec4(_1641 * (_1649 + (((1.0 - _1649) * (_1644 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1633 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1634)), _1433)), 0.0, 1.0), 1.0 + _1644))), _1667 * (_1675 + (((1.0 - _1675) * (_1670 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1659 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1660)), _1433)), 0.0, 1.0), 1.0 + _1670))), _1693 * (_1701 + (((1.0 - _1701) * (_1696 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1685 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1686)), _1433)), 0.0, 1.0), 1.0 + _1696))), _1719 * (_1727 + (((1.0 - _1727) * (_1722 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1711 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1712)), _1433)), 0.0, 1.0), 1.0 + _1722))));
        }
        vec3 _1765 = _1763.xyz * 1.0;
        vec4 _1766 = vec4(_1765.x, _1765.y, _1765.z, _783.w);
        _1766.w = _403 * _1763.w;
        _1770 = _1766;
    }
    else
    {
        _1770 = vec4(vec4(0.0, 0.0, 0.0, 1.0).x, vec4(0.0, 0.0, 0.0, 1.0).y, vec4(0.0, 0.0, 0.0, 1.0).z, _783.w);
    }
    vec4 _1778 = textureLod(sampler2D(screenspace_shadowmap, SamplerLinearClamp), vec4((_1390.xy / (_1406 / cpass_cb.frame_to_dynamic_scale.xy)) * _1406, 0.0, 0.0).xy, 0.0);
    vec4 _1782 = _1770 + vec4(_1778.x * 9.9999997473787516355514526367188e-05);
    uvec4 _1795 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _1796 = _1795.x;
    uint _1797 = _1795.y;
    vec3 _1802;
    vec3 _1804;
    vec3 _1806;
    _1802 = vec3(0.0);
    _1804 = vec3(0.0);
    _1806 = vec3(0.0);
    uint _1800;
    vec3 _1803;
    vec3 _1805;
    vec3 _1807;
    for (uint _1799 = _1796, _1808 = 0u; _1808 < _1797; _1799 = _1800, _1802 = _1803, _1804 = _1805, _1806 = _1807, _1808++)
    {
        _1800 = _1799 + 1u;
        uvec4 _1814 = texelFetch(light_indices, int(_1799));
        uint _1815 = _1814.x;
        vec4 _1834;
        if (point_light_infos._m0[_1815].channel_index > (-0.5))
        {
            vec4 _1833;
            if (point_light_infos._m0[_1815].channel_index >= 2.5)
            {
                _1833 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1832;
                if (point_light_infos._m0[_1815].channel_index >= 1.5)
                {
                    _1832 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1832 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1815].channel_index >= 0.5));
                }
                _1833 = _1832;
            }
            _1834 = _1833;
        }
        else
        {
            _1834 = vec4(0.0);
        }
        vec3 _1864 = vec4(point_light_infos._m0[_1815].position, point_light_infos._m0[_1815].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1865 = length(_1864);
        vec3 _1867 = _1864 / vec3(_1865);
        vec3 _1868 = vec4(point_light_infos._m0[_1815].color, point_light_infos._m0[_1815].median_radius).xyz;
        float _1875 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1815].channel_index, 0.0, 1.0));
        float _1880 = (_1865 / (point_light_infos._m0[_1815].median_radius / _1875)) + 1.0;
        float _1881 = _1865 / (point_light_infos._m0[_1815].median_radius * sqrt(dot(abs(_1868), vec3(1.0)) * 2.0));
        float _1886 = clamp(1.0 - (((_1881 * _1881) * _1881) * _1881), 0.0, 1.0);
        vec3 _1893 = (_1868 * spvNMin(10.0, (((0.199999988079071044921875 * _1875) * _1875) * (_1886 * _1886)) / (_1880 * _1880))) * (dot(_1778, _1834) * clamp((dot(-normalize(_408), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1815].position)) - (1.0 - length(_408))) * 2.5, 0.0, 1.0));
        if (length(_1893) > 0.0)
        {
            float _1899 = clamp(dot(_1867, _1370), 0.0, 1.0);
            float _1902 = clamp(1.0 - _430, 0.0, 1.0);
            float _1904 = spvNMax(_1902 * _1902, 0.00200000009499490261077880859375);
            float _1905 = _1904 * _1904;
            vec3 _1906 = -_1374;
            vec3 _1908 = normalize(_1906 + _1867);
            float _1910 = clamp(dot(_1370, _1908), 0.0, 1.0);
            float _1914 = clamp(dot(_1906, _1908), 0.0, 1.0);
            float _1921 = _1904 * 0.5;
            float _1922 = 1.0 - _1921;
            _1803 = _1802 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1914) - 6.9831600189208984375) * _1914)), vec3(1.0), _463) * (_1905 / pow((((_1905 - 1.0) * _1910) * _1910) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1906, _1370), 0.0, 1.0) * _1922) + _1921) * ((_1899 * _1922) + _1921)))) * _1899) * vec3(0.25)) * _1893);
            _1805 = _1804 + ((_1893 * _1899) * _416.xyz);
            _1807 = _1806 + _1893;
        }
        else
        {
            _1803 = _1802;
            _1805 = _1804;
            _1807 = _1806;
        }
    }
    uvec4 _1947 = uvec4(cobject_cb.instances[_793].dynamic_light_indices);
    uint _1948 = _1947.x;
    uint _1951 = uint(dynamic_light_infos._m0[_1948].light_type.x);
    uint _1952 = _1947.y;
    uint _1955 = uint(dynamic_light_infos._m0[_1952].light_type.x);
    uint _1956 = _1947.z;
    uint _1959 = uint(dynamic_light_infos._m0[_1956].light_type.x);
    uint _1960 = _1947.w;
    uint _1963 = uint(dynamic_light_infos._m0[_1960].light_type.x);
    vec4 _2357;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1948].shadow_enabled.x > 0.0)
    {
        vec4 _1972 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2355;
        do
        {
            vec4 _1982 = dynamic_light_infos._m0[_1948].light_matrix * _1972;
            vec3 _2039;
            if (_1951 == 2u)
            {
                vec3 _2003 = _1982.xyz;
                vec3 _2005 = normalize(_2003) + vec3(0.0, 0.0, 1.0);
                float _2009 = length(_2003);
                vec3 _2012 = vec3((_2005 / vec3(_2005.z)).xy, _2009);
                float _2013 = _1982.z;
                vec3 _2025;
                if (_2013 > 0.0)
                {
                    _2025 = _2012;
                }
                else
                {
                    _2025 = vec3(normalize(_2012.xy) * 10000000.0, -_2009);
                }
                vec3 _2033 = vec3((_2025.x * 0.5) + 0.5, 0.5 - (_2025.y * 0.5), _2025.z);
                _2033.z = _2025.z * 9.9999997473787516355514526367188e-05;
                if (_2013 < 0.0)
                {
                    _2355 = 0.0;
                    break;
                }
                _2039 = _2033;
            }
            else
            {
                vec3 _1987 = _1982.xyz;
                vec3 _1999;
                if (_1951 == 1u)
                {
                    float _1991 = _1982.z;
                    vec3 _1998 = _1987;
                    _1998.z = _1991 - (((_1991 * dynamic_light_infos._m0[_1948].shadow_scale.z) + 1.0) / _1982.w);
                    _1999 = _1998;
                }
                else
                {
                    _1999 = _1987;
                }
                _2039 = _1999 / vec3(_1982.w);
            }
            float _2148;
            if (dynamic_light_infos._m0[_1948].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2130 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2039.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2039.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2039.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2039.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1948].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2039.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2039.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1948].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2039.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2039.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1948].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2039.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2039.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1948].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2039.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2039.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1948].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2148 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1948].shadow_scale.w * spvNMax(_2130, _2039.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2039.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1948].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2148 = 1.0;
            }
            vec3 _2149 = dFdx(_2039);
            vec3 _2150 = dFdy(_2039);
            vec3 _2164 = _2039 + ((normalize(cross(_2149, _2150)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _301) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw)).x);
            vec2 _2165 = dynamic_light_infos._m0[_1948].shadow_scale.xy * _2148;
            vec2 _2166 = _2164.xy;
            float _2171 = _2164.z;
            float _2250 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2166, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, _2171, 1.0).xy, _2171), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2166 + (vec2(1.0, 0.0) * _2165), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, _2171, 1.0).xy, _2171), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2166 + (vec2(0.5, 0.865999996662139892578125) * _2165), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, _2171, 1.0).xy, _2171), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2166 + (vec2(-0.5, 0.865999996662139892578125) * _2165), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, _2171, 1.0).xy, _2171), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2166 + (vec2(-1.0, -0.0) * _2165), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, _2171, 1.0).xy, _2171), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2166 + (vec2(-0.5, -0.865999996662139892578125) * _2165), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, _2171, 1.0).xy, _2171), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2166 + (vec2(0.5, -0.865999996662139892578125) * _2165), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1948].shadow_atlas_offset_scale.xy, _2171, 1.0).xy, _2171), 0.0);
            float _2251 = _2250 * 0.14285714924335479736328125;
            float _2354;
            if (_1951 == 0u)
            {
                float _2266 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1972.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2268 = transpose(dynamic_light_infos._m0[_1948].light_matrix)[2];
                float _2273 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2282;
                if (_2273 > 0.100000001490116119384765625)
                {
                    _2282 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2282 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2293 = _1972.xyz - ((_2268.xyz / vec3(_2268.z)) * 1000.0);
                float _2317 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2282, _2293), dot(normalize(vec3(-_2282.y, _2282.x, 0.0)), _2293)) + (vec2(_2273, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2266 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2324 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2325 = _2324 - 1.0;
                float _2326 = 1.0 - cpass_cb.clouds_midpoint;
                float _2333 = 2.0 - _2324;
                _2354 = _2251 * mix(1.0, clamp(clamp(_2326 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2317), 0.0, 1.0), _2325)) * pow(clamp(_2326, 0.0, 1.0), _2333)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2317), 0.0, 1.0), _2325) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2333))), 0.0, 1.0) + (_2266 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2354 = _2251;
            }
            _2355 = _2354;
            break;
        } while(false);
        vec4 _2356 = vec4(1.0);
        _2356.x = _2355;
        _2357 = _2356;
    }
    else
    {
        _2357 = vec4(1.0);
    }
    vec4 _2751;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1952].shadow_enabled.x > 0.0)
    {
        vec4 _2366 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2749;
        do
        {
            vec4 _2376 = dynamic_light_infos._m0[_1952].light_matrix * _2366;
            vec3 _2433;
            if (_1955 == 2u)
            {
                vec3 _2397 = _2376.xyz;
                vec3 _2399 = normalize(_2397) + vec3(0.0, 0.0, 1.0);
                float _2403 = length(_2397);
                vec3 _2406 = vec3((_2399 / vec3(_2399.z)).xy, _2403);
                float _2407 = _2376.z;
                vec3 _2419;
                if (_2407 > 0.0)
                {
                    _2419 = _2406;
                }
                else
                {
                    _2419 = vec3(normalize(_2406.xy) * 10000000.0, -_2403);
                }
                vec3 _2427 = vec3((_2419.x * 0.5) + 0.5, 0.5 - (_2419.y * 0.5), _2419.z);
                _2427.z = _2419.z * 9.9999997473787516355514526367188e-05;
                if (_2407 < 0.0)
                {
                    _2749 = 0.0;
                    break;
                }
                _2433 = _2427;
            }
            else
            {
                vec3 _2381 = _2376.xyz;
                vec3 _2393;
                if (_1955 == 1u)
                {
                    float _2385 = _2376.z;
                    vec3 _2392 = _2381;
                    _2392.z = _2385 - (((_2385 * dynamic_light_infos._m0[_1952].shadow_scale.z) + 1.0) / _2376.w);
                    _2393 = _2392;
                }
                else
                {
                    _2393 = _2381;
                }
                _2433 = _2393 / vec3(_2376.w);
            }
            float _2542;
            if (dynamic_light_infos._m0[_1952].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2524 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2433.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2433.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2433.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2433.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1952].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2433.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2433.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1952].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2433.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2433.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1952].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2433.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2433.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1952].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2433.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2433.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1952].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2542 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1952].shadow_scale.w * spvNMax(_2524, _2433.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2433.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1952].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2542 = 1.0;
            }
            vec3 _2543 = dFdx(_2433);
            vec3 _2544 = dFdy(_2433);
            vec3 _2558 = _2433 + ((normalize(cross(_2543, _2544)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _301) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw)).x);
            vec2 _2559 = dynamic_light_infos._m0[_1952].shadow_scale.xy * _2542;
            vec2 _2560 = _2558.xy;
            float _2565 = _2558.z;
            float _2644 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2560, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, _2565, 1.0).xy, _2565), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2560 + (vec2(1.0, 0.0) * _2559), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, _2565, 1.0).xy, _2565), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2560 + (vec2(0.5, 0.865999996662139892578125) * _2559), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, _2565, 1.0).xy, _2565), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2560 + (vec2(-0.5, 0.865999996662139892578125) * _2559), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, _2565, 1.0).xy, _2565), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2560 + (vec2(-1.0, -0.0) * _2559), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, _2565, 1.0).xy, _2565), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2560 + (vec2(-0.5, -0.865999996662139892578125) * _2559), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, _2565, 1.0).xy, _2565), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2560 + (vec2(0.5, -0.865999996662139892578125) * _2559), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1952].shadow_atlas_offset_scale.xy, _2565, 1.0).xy, _2565), 0.0);
            float _2645 = _2644 * 0.14285714924335479736328125;
            float _2748;
            if (_1955 == 0u)
            {
                float _2660 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2366.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2662 = transpose(dynamic_light_infos._m0[_1952].light_matrix)[2];
                float _2667 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2676;
                if (_2667 > 0.100000001490116119384765625)
                {
                    _2676 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2676 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2687 = _2366.xyz - ((_2662.xyz / vec3(_2662.z)) * 1000.0);
                float _2711 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2676, _2687), dot(normalize(vec3(-_2676.y, _2676.x, 0.0)), _2687)) + (vec2(_2667, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2660 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2718 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2719 = _2718 - 1.0;
                float _2720 = 1.0 - cpass_cb.clouds_midpoint;
                float _2727 = 2.0 - _2718;
                _2748 = _2645 * mix(1.0, clamp(clamp(_2720 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2711), 0.0, 1.0), _2719)) * pow(clamp(_2720, 0.0, 1.0), _2727)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2711), 0.0, 1.0), _2719) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2727))), 0.0, 1.0) + (_2660 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2748 = _2645;
            }
            _2749 = _2748;
            break;
        } while(false);
        vec4 _2750 = _2357;
        _2750.y = _2749;
        _2751 = _2750;
    }
    else
    {
        _2751 = _2357;
    }
    vec4 _3145;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1956].shadow_enabled.x > 0.0)
    {
        vec4 _2760 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _3143;
        do
        {
            vec4 _2770 = dynamic_light_infos._m0[_1956].light_matrix * _2760;
            vec3 _2827;
            if (_1959 == 2u)
            {
                vec3 _2791 = _2770.xyz;
                vec3 _2793 = normalize(_2791) + vec3(0.0, 0.0, 1.0);
                float _2797 = length(_2791);
                vec3 _2800 = vec3((_2793 / vec3(_2793.z)).xy, _2797);
                float _2801 = _2770.z;
                vec3 _2813;
                if (_2801 > 0.0)
                {
                    _2813 = _2800;
                }
                else
                {
                    _2813 = vec3(normalize(_2800.xy) * 10000000.0, -_2797);
                }
                vec3 _2821 = vec3((_2813.x * 0.5) + 0.5, 0.5 - (_2813.y * 0.5), _2813.z);
                _2821.z = _2813.z * 9.9999997473787516355514526367188e-05;
                if (_2801 < 0.0)
                {
                    _3143 = 0.0;
                    break;
                }
                _2827 = _2821;
            }
            else
            {
                vec3 _2775 = _2770.xyz;
                vec3 _2787;
                if (_1959 == 1u)
                {
                    float _2779 = _2770.z;
                    vec3 _2786 = _2775;
                    _2786.z = _2779 - (((_2779 * dynamic_light_infos._m0[_1956].shadow_scale.z) + 1.0) / _2770.w);
                    _2787 = _2786;
                }
                else
                {
                    _2787 = _2775;
                }
                _2827 = _2787 / vec3(_2770.w);
            }
            float _2936;
            if (dynamic_light_infos._m0[_1956].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2918 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2827.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2827.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2827.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2827.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1956].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2827.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2827.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1956].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2827.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2827.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1956].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2827.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2827.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1956].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2827.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2827.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1956].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2936 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1956].shadow_scale.w * spvNMax(_2918, _2827.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2827.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1956].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2936 = 1.0;
            }
            vec3 _2937 = dFdx(_2827);
            vec3 _2938 = dFdy(_2827);
            vec3 _2952 = _2827 + ((normalize(cross(_2937, _2938)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _301) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw)).x);
            vec2 _2953 = dynamic_light_infos._m0[_1956].shadow_scale.xy * _2936;
            vec2 _2954 = _2952.xy;
            float _2959 = _2952.z;
            float _3038 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2954, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, _2959, 1.0).xy, _2959), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2954 + (vec2(1.0, 0.0) * _2953), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, _2959, 1.0).xy, _2959), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2954 + (vec2(0.5, 0.865999996662139892578125) * _2953), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, _2959, 1.0).xy, _2959), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2954 + (vec2(-0.5, 0.865999996662139892578125) * _2953), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, _2959, 1.0).xy, _2959), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2954 + (vec2(-1.0, -0.0) * _2953), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, _2959, 1.0).xy, _2959), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2954 + (vec2(-0.5, -0.865999996662139892578125) * _2953), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, _2959, 1.0).xy, _2959), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2954 + (vec2(0.5, -0.865999996662139892578125) * _2953), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1956].shadow_atlas_offset_scale.xy, _2959, 1.0).xy, _2959), 0.0);
            float _3039 = _3038 * 0.14285714924335479736328125;
            float _3142;
            if (_1959 == 0u)
            {
                float _3054 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2760.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _3056 = transpose(dynamic_light_infos._m0[_1956].light_matrix)[2];
                float _3061 = length(cpass_cb.clouds_velocity.xy);
                vec3 _3070;
                if (_3061 > 0.100000001490116119384765625)
                {
                    _3070 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _3070 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _3081 = _2760.xyz - ((_3056.xyz / vec3(_3056.z)) * 1000.0);
                float _3105 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_3070, _3081), dot(normalize(vec3(-_3070.y, _3070.x, 0.0)), _3081)) + (vec2(_3061, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_3054 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _3112 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _3113 = _3112 - 1.0;
                float _3114 = 1.0 - cpass_cb.clouds_midpoint;
                float _3121 = 2.0 - _3112;
                _3142 = _3039 * mix(1.0, clamp(clamp(_3114 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _3105), 0.0, 1.0), _3113)) * pow(clamp(_3114, 0.0, 1.0), _3121)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _3105), 0.0, 1.0), _3113) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _3121))), 0.0, 1.0) + (_3054 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _3142 = _3039;
            }
            _3143 = _3142;
            break;
        } while(false);
        vec4 _3144 = _2751;
        _3144.z = _3143;
        _3145 = _3144;
    }
    else
    {
        _3145 = _2751;
    }
    vec4 _3539;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1960].shadow_enabled.x > 0.0)
    {
        vec4 _3154 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _3537;
        do
        {
            vec4 _3164 = dynamic_light_infos._m0[_1960].light_matrix * _3154;
            vec3 _3221;
            if (_1963 == 2u)
            {
                vec3 _3185 = _3164.xyz;
                vec3 _3187 = normalize(_3185) + vec3(0.0, 0.0, 1.0);
                float _3191 = length(_3185);
                vec3 _3194 = vec3((_3187 / vec3(_3187.z)).xy, _3191);
                float _3195 = _3164.z;
                vec3 _3207;
                if (_3195 > 0.0)
                {
                    _3207 = _3194;
                }
                else
                {
                    _3207 = vec3(normalize(_3194.xy) * 10000000.0, -_3191);
                }
                vec3 _3215 = vec3((_3207.x * 0.5) + 0.5, 0.5 - (_3207.y * 0.5), _3207.z);
                _3215.z = _3207.z * 9.9999997473787516355514526367188e-05;
                if (_3195 < 0.0)
                {
                    _3537 = 0.0;
                    break;
                }
                _3221 = _3215;
            }
            else
            {
                vec3 _3169 = _3164.xyz;
                vec3 _3181;
                if (_1963 == 1u)
                {
                    float _3173 = _3164.z;
                    vec3 _3180 = _3169;
                    _3180.z = _3173 - (((_3173 * dynamic_light_infos._m0[_1960].shadow_scale.z) + 1.0) / _3164.w);
                    _3181 = _3180;
                }
                else
                {
                    _3181 = _3169;
                }
                _3221 = _3181 / vec3(_3164.w);
            }
            float _3330;
            if (dynamic_light_infos._m0[_1960].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _3312 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _3221.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3221.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3221.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3221.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1960].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3221.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3221.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1960].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3221.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3221.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1960].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3221.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3221.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1960].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _3221.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3221.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1960].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _3330 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1960].shadow_scale.w * spvNMax(_3312, _3221.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_3221.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1960].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _3330 = 1.0;
            }
            vec3 _3331 = dFdx(_3221);
            vec3 _3332 = dFdy(_3221);
            vec3 _3346 = _3221 + ((normalize(cross(_3331, _3332)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _301) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw)).x);
            vec2 _3347 = dynamic_light_infos._m0[_1960].shadow_scale.xy * _3330;
            vec2 _3348 = _3346.xy;
            float _3353 = _3346.z;
            float _3432 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3348, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, _3353, 1.0).xy, _3353), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3348 + (vec2(1.0, 0.0) * _3347), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, _3353, 1.0).xy, _3353), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3348 + (vec2(0.5, 0.865999996662139892578125) * _3347), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, _3353, 1.0).xy, _3353), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3348 + (vec2(-0.5, 0.865999996662139892578125) * _3347), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, _3353, 1.0).xy, _3353), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3348 + (vec2(-1.0, -0.0) * _3347), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, _3353, 1.0).xy, _3353), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3348 + (vec2(-0.5, -0.865999996662139892578125) * _3347), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, _3353, 1.0).xy, _3353), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_3348 + (vec2(0.5, -0.865999996662139892578125) * _3347), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1960].shadow_atlas_offset_scale.xy, _3353, 1.0).xy, _3353), 0.0);
            float _3433 = _3432 * 0.14285714924335479736328125;
            float _3536;
            if (_1963 == 0u)
            {
                float _3448 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _3154.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _3450 = transpose(dynamic_light_infos._m0[_1960].light_matrix)[2];
                float _3455 = length(cpass_cb.clouds_velocity.xy);
                vec3 _3464;
                if (_3455 > 0.100000001490116119384765625)
                {
                    _3464 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _3464 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _3475 = _3154.xyz - ((_3450.xyz / vec3(_3450.z)) * 1000.0);
                float _3499 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_3464, _3475), dot(normalize(vec3(-_3464.y, _3464.x, 0.0)), _3475)) + (vec2(_3455, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_3448 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _3506 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _3507 = _3506 - 1.0;
                float _3508 = 1.0 - cpass_cb.clouds_midpoint;
                float _3515 = 2.0 - _3506;
                _3536 = _3433 * mix(1.0, clamp(clamp(_3508 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _3499), 0.0, 1.0), _3507)) * pow(clamp(_3508, 0.0, 1.0), _3515)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _3499), 0.0, 1.0), _3507) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _3515))), 0.0, 1.0) + (_3448 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _3536 = _3433;
            }
            _3537 = _3536;
            break;
        } while(false);
        vec4 _3538 = _3145;
        _3538.w = _3537;
        _3539 = _3538;
    }
    else
    {
        _3539 = _3145;
    }
    vec3 _3606;
    vec3 _3607;
    switch (_1951)
    {
        case 0u:
        {
            _3606 = dynamic_light_infos._m0[_1948].light_color.xyz;
            _3607 = -dynamic_light_infos._m0[_1948].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3583 = dynamic_light_infos._m0[_1948].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3584 = length(_3583);
            vec3 _3586 = _3583 / vec3(_3584);
            _3606 = dynamic_light_infos._m0[_1948].light_color.xyz * ((1.0 - clamp(_3584 / dynamic_light_infos._m0[_1948].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1948].light_direction.xyz, _3586) - dynamic_light_infos._m0[_1948].light_direction.w) / (dynamic_light_infos._m0[_1948].light_position.w - dynamic_light_infos._m0[_1948].light_direction.w), 0.0, 1.0));
            _3607 = _3586;
            break;
        }
        case 2u:
        {
            vec3 _3551 = dynamic_light_infos._m0[_1948].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3552 = length(_3551);
            float _3564 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1948].light_position.w, 0.0, 1.0));
            float _3569 = (_3552 / (dynamic_light_infos._m0[_1948].light_color.w / _3564)) + 1.0;
            float _3570 = _3552 / (dynamic_light_infos._m0[_1948].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1948].light_color.xyz), vec3(1.0)) * 2.0));
            float _3575 = clamp(1.0 - (((_3570 * _3570) * _3570) * _3570), 0.0, 1.0);
            _3606 = dynamic_light_infos._m0[_1948].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3564) * _3564) * (_3575 * _3575)) / (_3569 * _3569));
            _3607 = _3551 / vec3(_3552);
            break;
        }
        default:
        {
            _3606 = vec3(0.0);
            _3607 = vec3(0.0);
            break;
        }
    }
    vec3 _3609 = normalize(_408);
    vec3 _3611 = -_3609;
    float _3613 = 1.0 - length(_408);
    vec3 _3619 = _3606 * (_3539.x * clamp((dot(_3611, -_3607) - _3613) * 2.5, 0.0, 1.0));
    vec3 _3671;
    vec3 _3672;
    vec3 _3673;
    if (length(_3619) > 0.0)
    {
        float _3625 = clamp(dot(_3607, _1370), 0.0, 1.0);
        float _3628 = clamp(1.0 - _430, 0.0, 1.0);
        float _3630 = spvNMax(_3628 * _3628, 0.00200000009499490261077880859375);
        float _3631 = _3630 * _3630;
        vec3 _3632 = -_1374;
        vec3 _3634 = normalize(_3632 + _3607);
        float _3636 = clamp(dot(_1370, _3634), 0.0, 1.0);
        float _3640 = clamp(dot(_3632, _3634), 0.0, 1.0);
        float _3647 = _3630 * 0.5;
        float _3648 = 1.0 - _3647;
        _3671 = _1802 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3640) - 6.9831600189208984375) * _3640)), vec3(1.0), _463) * (_3631 / pow((((_3631 - 1.0) * _3636) * _3636) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3632, _1370), 0.0, 1.0) * _3648) + _3647) * ((_3625 * _3648) + _3647)))) * _3625) * vec3(0.25)) * _3619);
        _3672 = _1804 + ((_3619 * _3625) * _416.xyz);
        _3673 = _1806 + _3619;
    }
    else
    {
        _3671 = _1802;
        _3672 = _1804;
        _3673 = _1806;
    }
    vec3 _3740;
    vec3 _3741;
    switch (_1955)
    {
        case 0u:
        {
            _3740 = dynamic_light_infos._m0[_1952].light_color.xyz;
            _3741 = -dynamic_light_infos._m0[_1952].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3717 = dynamic_light_infos._m0[_1952].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3718 = length(_3717);
            vec3 _3720 = _3717 / vec3(_3718);
            _3740 = dynamic_light_infos._m0[_1952].light_color.xyz * ((1.0 - clamp(_3718 / dynamic_light_infos._m0[_1952].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1952].light_direction.xyz, _3720) - dynamic_light_infos._m0[_1952].light_direction.w) / (dynamic_light_infos._m0[_1952].light_position.w - dynamic_light_infos._m0[_1952].light_direction.w), 0.0, 1.0));
            _3741 = _3720;
            break;
        }
        case 2u:
        {
            vec3 _3685 = dynamic_light_infos._m0[_1952].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3686 = length(_3685);
            float _3698 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1952].light_position.w, 0.0, 1.0));
            float _3703 = (_3686 / (dynamic_light_infos._m0[_1952].light_color.w / _3698)) + 1.0;
            float _3704 = _3686 / (dynamic_light_infos._m0[_1952].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1952].light_color.xyz), vec3(1.0)) * 2.0));
            float _3709 = clamp(1.0 - (((_3704 * _3704) * _3704) * _3704), 0.0, 1.0);
            _3740 = dynamic_light_infos._m0[_1952].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3698) * _3698) * (_3709 * _3709)) / (_3703 * _3703));
            _3741 = _3685 / vec3(_3686);
            break;
        }
        default:
        {
            _3740 = vec3(0.0);
            _3741 = vec3(0.0);
            break;
        }
    }
    vec3 _3749 = _3740 * (_3539.y * clamp((dot(_3611, -_3741) - _3613) * 2.5, 0.0, 1.0));
    vec3 _3801;
    vec3 _3802;
    vec3 _3803;
    if (length(_3749) > 0.0)
    {
        float _3755 = clamp(dot(_3741, _1370), 0.0, 1.0);
        float _3758 = clamp(1.0 - _430, 0.0, 1.0);
        float _3760 = spvNMax(_3758 * _3758, 0.00200000009499490261077880859375);
        float _3761 = _3760 * _3760;
        vec3 _3762 = -_1374;
        vec3 _3764 = normalize(_3762 + _3741);
        float _3766 = clamp(dot(_1370, _3764), 0.0, 1.0);
        float _3770 = clamp(dot(_3762, _3764), 0.0, 1.0);
        float _3777 = _3760 * 0.5;
        float _3778 = 1.0 - _3777;
        _3801 = _3671 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3770) - 6.9831600189208984375) * _3770)), vec3(1.0), _463) * (_3761 / pow((((_3761 - 1.0) * _3766) * _3766) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3762, _1370), 0.0, 1.0) * _3778) + _3777) * ((_3755 * _3778) + _3777)))) * _3755) * vec3(0.25)) * _3749);
        _3802 = _3672 + ((_3749 * _3755) * _416.xyz);
        _3803 = _3673 + _3749;
    }
    else
    {
        _3801 = _3671;
        _3802 = _3672;
        _3803 = _3673;
    }
    vec3 _3870;
    vec3 _3871;
    switch (_1959)
    {
        case 0u:
        {
            _3870 = dynamic_light_infos._m0[_1956].light_color.xyz;
            _3871 = -dynamic_light_infos._m0[_1956].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3847 = dynamic_light_infos._m0[_1956].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3848 = length(_3847);
            vec3 _3850 = _3847 / vec3(_3848);
            _3870 = dynamic_light_infos._m0[_1956].light_color.xyz * ((1.0 - clamp(_3848 / dynamic_light_infos._m0[_1956].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1956].light_direction.xyz, _3850) - dynamic_light_infos._m0[_1956].light_direction.w) / (dynamic_light_infos._m0[_1956].light_position.w - dynamic_light_infos._m0[_1956].light_direction.w), 0.0, 1.0));
            _3871 = _3850;
            break;
        }
        case 2u:
        {
            vec3 _3815 = dynamic_light_infos._m0[_1956].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3816 = length(_3815);
            float _3828 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1956].light_position.w, 0.0, 1.0));
            float _3833 = (_3816 / (dynamic_light_infos._m0[_1956].light_color.w / _3828)) + 1.0;
            float _3834 = _3816 / (dynamic_light_infos._m0[_1956].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1956].light_color.xyz), vec3(1.0)) * 2.0));
            float _3839 = clamp(1.0 - (((_3834 * _3834) * _3834) * _3834), 0.0, 1.0);
            _3870 = dynamic_light_infos._m0[_1956].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3828) * _3828) * (_3839 * _3839)) / (_3833 * _3833));
            _3871 = _3815 / vec3(_3816);
            break;
        }
        default:
        {
            _3870 = vec3(0.0);
            _3871 = vec3(0.0);
            break;
        }
    }
    vec3 _3879 = _3870 * (_3539.z * clamp((dot(_3611, -_3871) - _3613) * 2.5, 0.0, 1.0));
    vec3 _3931;
    vec3 _3932;
    vec3 _3933;
    if (length(_3879) > 0.0)
    {
        float _3885 = clamp(dot(_3871, _1370), 0.0, 1.0);
        float _3888 = clamp(1.0 - _430, 0.0, 1.0);
        float _3890 = spvNMax(_3888 * _3888, 0.00200000009499490261077880859375);
        float _3891 = _3890 * _3890;
        vec3 _3892 = -_1374;
        vec3 _3894 = normalize(_3892 + _3871);
        float _3896 = clamp(dot(_1370, _3894), 0.0, 1.0);
        float _3900 = clamp(dot(_3892, _3894), 0.0, 1.0);
        float _3907 = _3890 * 0.5;
        float _3908 = 1.0 - _3907;
        _3931 = _3801 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3900) - 6.9831600189208984375) * _3900)), vec3(1.0), _463) * (_3891 / pow((((_3891 - 1.0) * _3896) * _3896) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3892, _1370), 0.0, 1.0) * _3908) + _3907) * ((_3885 * _3908) + _3907)))) * _3885) * vec3(0.25)) * _3879);
        _3932 = _3802 + ((_3879 * _3885) * _416.xyz);
        _3933 = _3803 + _3879;
    }
    else
    {
        _3931 = _3801;
        _3932 = _3802;
        _3933 = _3803;
    }
    vec3 _4000;
    vec3 _4001;
    switch (_1963)
    {
        case 0u:
        {
            _4000 = dynamic_light_infos._m0[_1960].light_color.xyz;
            _4001 = -dynamic_light_infos._m0[_1960].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3977 = dynamic_light_infos._m0[_1960].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3978 = length(_3977);
            vec3 _3980 = _3977 / vec3(_3978);
            _4000 = dynamic_light_infos._m0[_1960].light_color.xyz * ((1.0 - clamp(_3978 / dynamic_light_infos._m0[_1960].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1960].light_direction.xyz, _3980) - dynamic_light_infos._m0[_1960].light_direction.w) / (dynamic_light_infos._m0[_1960].light_position.w - dynamic_light_infos._m0[_1960].light_direction.w), 0.0, 1.0));
            _4001 = _3980;
            break;
        }
        case 2u:
        {
            vec3 _3945 = dynamic_light_infos._m0[_1960].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3946 = length(_3945);
            float _3958 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1960].light_position.w, 0.0, 1.0));
            float _3963 = (_3946 / (dynamic_light_infos._m0[_1960].light_color.w / _3958)) + 1.0;
            float _3964 = _3946 / (dynamic_light_infos._m0[_1960].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1960].light_color.xyz), vec3(1.0)) * 2.0));
            float _3969 = clamp(1.0 - (((_3964 * _3964) * _3964) * _3964), 0.0, 1.0);
            _4000 = dynamic_light_infos._m0[_1960].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3958) * _3958) * (_3969 * _3969)) / (_3963 * _3963));
            _4001 = _3945 / vec3(_3946);
            break;
        }
        default:
        {
            _4000 = vec3(0.0);
            _4001 = vec3(0.0);
            break;
        }
    }
    vec3 _4009 = _4000 * (_3539.w * clamp((dot(_3611, -_4001) - _3613) * 2.5, 0.0, 1.0));
    vec3 _4061;
    vec3 _4062;
    vec3 _4063;
    if (length(_4009) > 0.0)
    {
        float _4015 = clamp(dot(_4001, _1370), 0.0, 1.0);
        float _4018 = clamp(1.0 - _430, 0.0, 1.0);
        float _4020 = spvNMax(_4018 * _4018, 0.00200000009499490261077880859375);
        float _4021 = _4020 * _4020;
        vec3 _4022 = -_1374;
        vec3 _4024 = normalize(_4022 + _4001);
        float _4026 = clamp(dot(_1370, _4024), 0.0, 1.0);
        float _4030 = clamp(dot(_4022, _4024), 0.0, 1.0);
        float _4037 = _4020 * 0.5;
        float _4038 = 1.0 - _4037;
        _4061 = _3932 + ((_4009 * _4015) * _416.xyz);
        _4062 = _3931 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _4030) - 6.9831600189208984375) * _4030)), vec3(1.0), _463) * (_4021 / pow((((_4021 - 1.0) * _4026) * _4026) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_4022, _1370), 0.0, 1.0) * _4038) + _4037) * ((_4015 * _4038) + _4037)))) * _4015) * vec3(0.25)) * _4009);
        _4063 = _3933 + _4009;
    }
    else
    {
        _4061 = _3932;
        _4062 = _3931;
        _4063 = _3933;
    }
    vec3 _4186;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _4076 = _1782.w;
        float _4077 = clamp(_430, 0.0, 1.0);
        float _4080 = sqrt(clamp(1.0 - _4076, 0.0, 1.0));
        float _4081 = 1.0 - _4077;
        float _4082 = _4081 * _4081;
        float _4085 = clamp(exp((-2.2999999523162841796875) * _4082), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _4086 = dot(_3609, _1375);
        float _4092 = sqrt(clamp(1.0 - (_4086 * _4086), 0.0, 1.0));
        float _4094 = _4085 - (_4086 * _4080);
        float _4095 = _4092 * _4080;
        vec2 _4096 = vec2(_4094, _4095);
        float _4098 = _4080 - (_4086 * _4085);
        float _4099 = _4092 * _4085;
        vec2 _4100 = vec2(_4098, _4099);
        float _4104 = sqrt(clamp(1.0 - (_4080 * _4080), 0.0, 1.0));
        float _4121 = sqrt(clamp(1.0 - (_4085 * _4085), 0.0, 1.0));
        vec4 _4147 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_1370, -_1374)), _4077, 0.0, 0.0).xy, 0.0);
        float _4160 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _4082));
        vec3 _4185 = _4062 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_1375, 0.0)).xyz, _4160).xyz, _4160).xyz * (vec3(_4147.x) + (_463 * _4147.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_4063 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * (_4076 * ((2.0 * ((acos(clamp(_4094 / (_4104 * sqrt(dot(_4096, _4096))), -1.0, 1.0)) - (acos(clamp((_4094 * _4080) / (_4095 * _4104), -1.0, 1.0)) * _4080)) + (acos(clamp(_4098 / (_4121 * sqrt(dot(_4100, _4100))), -1.0, 1.0)) - (acos(clamp((_4098 * _4085) / (_4099 * _4121), -1.0, 1.0)) * _4085)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _4085)))));
        _4186 = _4185;
    }
    else
    {
        _4186 = _4062;
    }
    vec3 _4198 = _416.xyz;
    vec3 _4229;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _4229 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_408, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_4063 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _4198) * _1782.w) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _4229 = vec3(0.0);
    }
    vec3 _4250 = (_4061 + _738) + (((_1782.xyz * _4198) + _4229) + spvNMax(vec3(0.0), _4186 / vec3(spvNMax(10.0, spvNMax(_4186.x, spvNMax(_4186.y, _4186.z))) * 0.100000001490116119384765625)));
    vec4 _4251 = vec4(_4250.x, _4250.y, _4250.z, vec4(0.0).w);
    _4251.w = _1365;
    vec3 _4253 = in_var_TEXCOORD0.xyz - in_var_AUTO_CEOBGMGP_GEBKIEDD;
    vec4 _4256 = vec4(_4253.x, _4253.y, _4253.z, _302.w);
    _4256.w = 1.0;
    vec4 _4258 = cpass_cb.last_view_projection_transform * _4256;
    vec2 _4264 = ((_4258 / vec4(_4258.w)).xy * 0.5) + vec2(0.5);
    out_var_SV_TARGET = _4251;
    out_var_SV_TARGET2 = vec4((_4061 * cpass_cb.indirect_light_multiplier) + (_738 * 20.0), _1365);
    out_var_SV_TARGET1 = vec4(((_1390 - vec3(_4264.x, 1.0 - _4264.y, _301)) * vec3(ivec3(ivec2(uvec2((cpass_cb.frame_resolution.xy * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))), 0))).xy, 0.0, 0.0);
}

