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
    float gpu_particle_burst;
    float gpu_particle_seed;
    float start_time;
    uint gpu_particle_count;
    uint gpu_particle_culling_priority;
    uint gpu_particle_pass_count;
    float flip_tangent;
    uint gpu_particle_emitter_id;
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

const vec4 _251[4] = vec4[](vec4(0.0, 0.0, 0.0, 1.0), vec4(0.0, 0.0, 0.0, 1.0), vec4(0.0, 0.0, 0.0, 1.0), vec4(0.0, 0.0, 0.0, 1.0));
const ivec2 _257[4] = ivec2[](ivec2(0), ivec2(1, 0), ivec2(0, 1), ivec2(1));
float _267;
vec4 _268;
float _272;
vec4 _273;

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
    vec4 alpha_test_desc;
    ivec4 constant_trackC_0;
    vec2 maya_scale_pivot_0;
    uint constant_bool_0;
    uint gpu_particle_dyn_culling;
    uint frame_material_id;
    float constant1_0;
    float constant1_1;
    float constant1_8;
    uint constantUInt1_0;
    uint constantUInt1_80;
    float constant1_7;
    int constant_trackG_2;
    uint constantUInt1_2;
    int constant_trackG_1;
    int constant_trackG_0;
    float brightness_0;
    float constant1_2;
    float saturation_0;
    float hue_0;
    float constant_pixel_3;
} cpipeline_cb;

layout(set = 5, binding = 0, std140) uniform type_cobject_cb
{
    uint instance_count;
    uint batch_size;
    uint padding0;
    uint padding1;
    InstanceData instances[16];
} cobject_cb;

layout(set = 2, binding = 44, std430) readonly buffer type_StructuredBuffer_LightInfo
{
    LightInfo _m0[];
} dynamic_light_infos;

layout(set = 2, binding = 45, std430) readonly buffer type_StructuredBuffer_PointLightInfo
{
    PointLightInfo _m0[];
} point_light_infos;

layout(set = 2, binding = 46, std430) readonly buffer type_StructuredBuffer_LUTData
{
    LUTData _m0[];
} spline_lut;

layout(set = 2, binding = 47, std430) readonly buffer type_StructuredBuffer_ParticleEmitterData
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
layout(set = 2, binding = 34) uniform texture2D ambient_light_tex;
layout(set = 2, binding = 35) uniform texture2D screenspace_shadowmap;
layout(set = 2, binding = 36) uniform texture2D noise_sampler;
layout(set = 2, binding = 37) uniform texture2D tex_shadow_map_atlas;
layout(set = 2, binding = 38) uniform texture2D depth_sampler;
layout(set = 2, binding = 39) uniform texture2D muddle_texture_0;
layout(set = 2, binding = 40) uniform texture2D texture_object_0;
layout(set = 2, binding = 41) uniform texture2D input_texture_0;
layout(set = 2, binding = 42) uniform utexture2D light_lookup;
layout(set = 2, binding = 43) uniform usamplerBuffer light_indices;

layout(location = 1) in vec4 in_var_AUTO_FBMBEBGD_ANHFJCCP;
layout(location = 2) in float in_var_AUTO_PIPJIEKO_CIFEPFLO;
layout(location = 3) in float in_var_AUTO_PIPJIEKO_IINFNGPI;
layout(location = 4) in float in_var_AUTO_PIPJIEKO_EIDIDJP;
layout(location = 5) in float in_var_AUTO_PIPJIEKO_LDBDDLHP;
layout(location = 6) in vec3 in_var_AUTO_CEOBGMGP_GEBKIEDD;
layout(location = 9) flat in uint in_var_INSTANCEID;
layout(location = 10) in vec4 in_var_TEXCOORD0;
layout(location = 11) in vec2 in_var_TEXCOORD1;
layout(location = 12) in vec3 in_var_TEXCOORD5;
layout(location = 13) in vec3 in_var_TEXCOORD6;
layout(location = 14) in vec3 in_var_TEXCOORD7;
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
    vec4 _313 = texture(sampler2D(muddle_texture_0, SamplerLinearWrap), (in_var_TEXCOORD1 * 1.0) + (vec2(-0.0199999995529651641845703125, 0.0199999995529651641845703125) * cpass_cb.time));
    vec2 _323 = vec2(cpipeline_cb.maya_scale_pivot_0.x, 1.0 - cpipeline_cb.maya_scale_pivot_0.y);
    vec2 _339 = ((((in_var_TEXCOORD1 + ((_313.xy - vec2(0.5)) * 0.0199999995529651641845703125)) - _323) * vec2(0.5)) + _323) + (vec2((cpipeline_cb.constant_bool_0 != 0u) ? pow(spvNMax(abs(in_var_AUTO_FBMBEBGD_ANHFJCCP.w), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_2) : cpass_cb.time) * vec2(0.0, -0.100000001490116119384765625));
    mat3 _340 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _354 = ((vec2(textureLod(sampler2D(texture_object_0, SamplerDynamicWrap), vec4(_339, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _355 = vec3(_354.x, _354.y, vec3(0.0).z);
    vec2 _356 = _354.xy;
    _355.z = sqrt(spvNMax(1.0 - dot(_356, _356), 0.0));
    vec3 _362 = _340 * _355;
    vec4 _368 = texture(sampler2D(texture_object_0, SamplerDynamicWrap), _339);
    float _369 = _368.z;
    vec3 _374 = vec3(pow(spvNMax(abs(_369), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_362 / vec3(length(_362) + 1.0000000116860974230803549289703e-07));
    vec4 _377 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _339);
    vec3 _378 = _377.xyz;
    vec3 _380 = vec3(_377.w);
    vec3 _382 = clamp(mix(_378, vec3(0.0), _380), vec3(0.0), vec3(1.0));
    vec2 _388 = ((vec2(_368.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _389 = vec3(_388.x, _388.y, vec3(0.0).z);
    vec2 _390 = _388.xy;
    _389.z = sqrt(spvNMax(1.0 - dot(_390, _390), 0.0));
    float _396 = _368.w;
    float _405 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _406 = cos(_405);
    vec3 _421 = (((_378 * _406) + (cross(vec3(0.57735002040863037109375), _378) * sin(_405))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _378)) * (1.0 - _406))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _429 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_421, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _421, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _380), vec3(0.0), vec3(1.0));
    bool _432 = cpipeline_cb.constant_trackG_0 < 0;
    float _434 = clamp(_369, 0.0, 1.0) * 127.0;
    int _438 = int(spvNMax(trunc(_434), 0.0) + 0.5);
    int _443 = int(spvNMin(trunc(_434 + 1.0), 127.0) + 0.5);
    float _461;
    if (_432)
    {
        _461 = 0.0;
    }
    else
    {
        uint _447 = uint(cpipeline_cb.constant_trackG_0);
        int _448 = _438 / 2;
        _461 = ((_438 - 2 * (_438 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_447].value[_448] & 65535u).x : unpackHalf2x16((spline_lut._m0[_447].value[_448] >> 16u) & 65535u).x;
    }
    float _479;
    if (_432)
    {
        _479 = 0.0;
    }
    else
    {
        uint _465 = uint(cpipeline_cb.constant_trackG_0);
        int _466 = _443 / 2;
        _479 = ((_443 - 2 * (_443 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_465].value[_466] & 65535u).x : unpackHalf2x16((spline_lut._m0[_465].value[_466] >> 16u) & 65535u).x;
    }
    float _480 = fract(_434);
    bool _486 = cpipeline_cb.constant_trackG_1 < 0;
    float _504;
    if (_486)
    {
        _504 = 0.0;
    }
    else
    {
        uint _490 = uint(cpipeline_cb.constant_trackG_1);
        int _491 = _438 / 2;
        _504 = ((_438 - 2 * (_438 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_490].value[_491] & 65535u).x : unpackHalf2x16((spline_lut._m0[_490].value[_491] >> 16u) & 65535u).x;
    }
    float _522;
    if (_486)
    {
        _522 = 0.0;
    }
    else
    {
        uint _508 = uint(cpipeline_cb.constant_trackG_1);
        int _509 = _443 / 2;
        _522 = ((_443 - 2 * (_443 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_508].value[_509] & 65535u).x : unpackHalf2x16((spline_lut._m0[_508].value[_509] >> 16u) & 65535u).x;
    }
    float _531 = clamp((spvNMax(vec3(mix(_461, _479, _480), _272, _272), vec3(0.0)) + spvNMax(vec3(mix(_504, _522, _480), _272, _272), vec3(0.0))).x, 0.0, 1.0) * 127.0;
    int _536 = int(spvNMax(trunc(_531), 0.0) + 0.5);
    int _541 = int(spvNMin(trunc(_531 + 1.0), 127.0) + 0.5);
    bool _542 = cpipeline_cb.constant_trackC_0.x < 0;
    float _560;
    if (_542)
    {
        _560 = 0.0;
    }
    else
    {
        uint _546 = uint(cpipeline_cb.constant_trackC_0.x);
        int _547 = _536 / 2;
        _560 = ((_536 - 2 * (_536 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_546].value[_547] & 65535u).x : unpackHalf2x16((spline_lut._m0[_546].value[_547] >> 16u) & 65535u).x;
    }
    float _578;
    if (_542)
    {
        _578 = 0.0;
    }
    else
    {
        uint _564 = uint(cpipeline_cb.constant_trackC_0.x);
        int _565 = _541 / 2;
        _578 = ((_541 - 2 * (_541 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_564].value[_565] & 65535u).x : unpackHalf2x16((spline_lut._m0[_564].value[_565] >> 16u) & 65535u).x;
    }
    float _579 = fract(_531);
    bool _582 = cpipeline_cb.constant_trackC_0.y < 0;
    float _600;
    if (_582)
    {
        _600 = 0.0;
    }
    else
    {
        uint _586 = uint(cpipeline_cb.constant_trackC_0.y);
        int _587 = _536 / 2;
        _600 = ((_536 - 2 * (_536 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_586].value[_587] & 65535u).x : unpackHalf2x16((spline_lut._m0[_586].value[_587] >> 16u) & 65535u).x;
    }
    float _618;
    if (_582)
    {
        _618 = 0.0;
    }
    else
    {
        uint _604 = uint(cpipeline_cb.constant_trackC_0.y);
        int _605 = _541 / 2;
        _618 = ((_541 - 2 * (_541 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_604].value[_605] & 65535u).x : unpackHalf2x16((spline_lut._m0[_604].value[_605] >> 16u) & 65535u).x;
    }
    bool _621 = cpipeline_cb.constant_trackC_0.z < 0;
    float _639;
    if (_621)
    {
        _639 = 0.0;
    }
    else
    {
        uint _625 = uint(cpipeline_cb.constant_trackC_0.z);
        int _626 = _536 / 2;
        _639 = ((_536 - 2 * (_536 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_625].value[_626] & 65535u).x : unpackHalf2x16((spline_lut._m0[_625].value[_626] >> 16u) & 65535u).x;
    }
    float _657;
    if (_621)
    {
        _657 = 0.0;
    }
    else
    {
        uint _643 = uint(cpipeline_cb.constant_trackC_0.z);
        int _644 = _541 / 2;
        _657 = ((_541 - 2 * (_541 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_643].value[_644] & 65535u).x : unpackHalf2x16((spline_lut._m0[_643].value[_644] >> 16u) & 65535u).x;
    }
    bool _660 = cpipeline_cb.constant_trackC_0.w < 0;
    float _678;
    if (_660)
    {
        _678 = 0.0;
    }
    else
    {
        uint _664 = uint(cpipeline_cb.constant_trackC_0.w);
        int _665 = _536 / 2;
        _678 = ((_536 - 2 * (_536 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_664].value[_665] & 65535u).x : unpackHalf2x16((spline_lut._m0[_664].value[_665] >> 16u) & 65535u).x;
    }
    float _696;
    if (_660)
    {
        _696 = 0.0;
    }
    else
    {
        uint _682 = uint(cpipeline_cb.constant_trackC_0.w);
        int _683 = _541 / 2;
        _696 = ((_541 - 2 * (_541 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_682].value[_683] & 65535u).x : unpackHalf2x16((spline_lut._m0[_682].value[_683] >> 16u) & 65535u).x;
    }
    float _697 = mix(_678, _696, _579);
    vec3 _704 = spvNMin((vec4(mix(_560, _578, _579), mix(_600, _618, _579), mix(_639, _657, _579), _697).xyz * vec3(spvNMax(_697, 0.0))) * 5.0, vec3(100.0));
    bool _707 = cpipeline_cb.constant_trackG_2 < 0;
    float _725;
    if (_707)
    {
        _725 = 0.0;
    }
    else
    {
        uint _711 = uint(cpipeline_cb.constant_trackG_2);
        int _712 = _438 / 2;
        _725 = ((_438 - 2 * (_438 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_711].value[_712] & 65535u).x : unpackHalf2x16((spline_lut._m0[_711].value[_712] >> 16u) & 65535u).x;
    }
    float _743;
    if (_707)
    {
        _743 = 0.0;
    }
    else
    {
        uint _729 = uint(cpipeline_cb.constant_trackG_2);
        int _730 = _443 / 2;
        _743 = ((_443 - 2 * (_443 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_729].value[_730] & 65535u).x : unpackHalf2x16((spline_lut._m0[_729].value[_730] >> 16u) & 65535u).x;
    }
    float _748 = clamp(spvNMax(vec3(mix(_725, _743, _480), _272, _272), vec3(0.0)).x, 0.0, 1.0);
    vec4 _749;
    _749.w = _369;
    float _756;
    _756 = 0.0;
    float _757;
    for (uint _759 = 0u; _759 < 1u; _756 = _757, _759++)
    {
        uint _764 = cpipeline_cb.constantUInt1_80 / 4u;
        uint _765 = cpipeline_cb.constantUInt1_80 % 4u;
        uint _768 = in_var_INSTANCEID / cobject_cb.instance_count;
        vec4 _797;
        if (!(((particles_emitter_data._m0[cobject_cb.instances[_768].gpu_particle_emitter].culling_tag >> 14u) & 512u) == 0u))
        {
            vec4 _796;
            if (floatBitsToUint(cpass_cb.frame_delta_time.w) == 0u)
            {
                _796 = vec4(_272, 0.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            else
            {
                _796 = vec4(0.0, 1.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            _797 = _796;
        }
        else
        {
            _797 = cpass_cb.frame_delta_time;
        }
        float _805 = mix(particles_emitter_data._m0[cobject_cb.instances[_768].gpu_particle_emitter].prev_time, particles_emitter_data._m0[cobject_cb.instances[_768].gpu_particle_emitter].time, _797.z) / particles_emitter_data._m0[cobject_cb.instances[_768].gpu_particle_emitter].emitter_duration;
        float _806 = spvNMax(0.0, _805);
        float _812;
        if (((particles_emitter_data._m0[cobject_cb.instances[_768].gpu_particle_emitter].culling_tag >> 14u) & 2u) != 0u)
        {
            _812 = fract(_806);
        }
        else
        {
            _812 = _806;
        }
        float _819 = spvNMax(cpipeline_cb.constant1_8, 9.9999997473787516355514526367188e-05);
        float _826;
        if (abs(_819) > 0.0)
        {
            _826 = in_var_AUTO_PIPJIEKO_LDBDDLHP / _819;
        }
        else
        {
            _826 = 0.0;
        }
        float _833;
        if (_765 == 0u)
        {
            _833 = _826;
        }
        else
        {
            _833 = (_765 == 1u) ? clamp((abs(particles_emitter_data._m0[cobject_cb.instances[_768].gpu_particle_emitter].emitter_duration) > 0.0) ? _805 : 0.0, 0.0, 1.0) : 0.0;
        }
        float _841;
        if (abs(cobject_cb.instances[_768].gpu_particles_duration.x) > 0.0)
        {
            _841 = (in_var_AUTO_PIPJIEKO_CIFEPFLO * in_var_AUTO_PIPJIEKO_EIDIDJP) / cobject_cb.instances[_768].gpu_particles_duration.x;
        }
        else
        {
            _841 = 0.0;
        }
        float _858;
        if (cpipeline_cb.constantUInt1_80 == 0u)
        {
            _858 = in_var_AUTO_PIPJIEKO_CIFEPFLO;
        }
        else
        {
            float _857;
            if (cpipeline_cb.constantUInt1_80 == 1u)
            {
                _857 = _812;
            }
            else
            {
                float _856;
                if (cpipeline_cb.constantUInt1_80 == 2u)
                {
                    _856 = in_var_AUTO_PIPJIEKO_IINFNGPI;
                }
                else
                {
                    _856 = (cpipeline_cb.constantUInt1_80 == 3u) ? _841 : 0.0;
                }
                _857 = _856;
            }
            _858 = _857;
        }
        if (_764 == 0u)
        {
            _757 = _858;
        }
        else
        {
            _757 = (_764 == 1u) ? _833 : 0.0;
        }
    }
    float _865 = clamp(_756, 0.0, 1.0);
    bool _866 = _865 < 1.0;
    float _870 = _865 * _865;
    float _876 = spvNMax(dot(_251[_866 ? 0u : (_866 ? 1u : (_866 ? 2u : 3u))], vec4(_870 * _865, _870, _865, 1.0)), 0.0);
    float _883 = clamp(clamp(mix(_748 * _876, _748 - (1.0 - _876), cpipeline_cb.constant1_7), 0.0, 1.0) * 3.0, 0.0, 1.0);
    vec3 _884 = _340 * _389;
    vec3 _888 = _884 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_884)));
    vec3 _892 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _893 = reflect(_892, _888);
    vec4 _896 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _268.w);
    _896.w = 1.0;
    vec4 _898 = cpass_cb.scene_view_projection_transform * _896;
    vec4 _901 = _898 / vec4(_898.w);
    vec2 _904 = (_901.xy * 0.5) + vec2(0.5);
    float _905 = _904.y;
    float _906 = 1.0 - _905;
    float _907 = _904.x;
    vec3 _908 = vec3(_907, _906, _267);
    ivec2 _914 = ivec2(uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)));
    vec2 _924 = vec2(1.0) / vec2(float(uint(_914.x) / 1u), float(uint(_914.y) / 1u));
    bool _940;
    if (cpass_cb.sh_probe_spacing > 0)
    {
        _940 = cpass_cb.ssgi_intensity > 0.5;
    }
    else
    {
        _940 = false;
    }
    vec4 _1288;
    if (_940)
    {
        vec3 _951 = clamp((cpass_cb.scene_view_transform * vec4(_888, 0.0)).xyz, vec3(-1.0), vec3(1.0));
        float _952 = _901.z;
        ivec2 _958 = ivec2(cpass_cb.sh_probe_spacing);
        ivec2 _959 = ivec2(uvec2(vec2(_914) * cpass_cb.frame_to_dynamic_scale.xy));
        vec4 _968 = cpass_cb.scene_view_projection_transform_inv * vec4((_907 * 2.0) - 1.0, (_905 * 2.0) - 1.0, _952, 1.0);
        vec3 _972 = (_968 / vec4(_968.w)).xyz;
        ivec2 _973 = _958 / ivec2(2);
        vec2 _974 = vec2(_958);
        vec2 _975 = vec2(1.0) / _974;
        vec2 _976 = vec2(_973);
        vec2 _979 = vec2(_959);
        vec2 _981 = vec2(1.0) / _979;
        vec2 _983 = (_976 + vec2(0.5)) * _981;
        vec2 _984 = _974 * _981;
        vec2 _986 = ((vec2(-0.5) - _976) * _975) + ((_979 * _975) * vec3(_907, _906, _952).xy);
        ivec2 _988 = ivec2(floor(_986));
        vec3 _278[4];
        for (int _991 = 0; _991 < 4; _991++)
        {
            ivec2 _999 = _988 + _257[_991];
            ivec2 _1001 = _973 + (_958 * _999);
            int _1002 = _1001.x;
            bool _1008;
            if (_1002 >= 0)
            {
                _1008 = _1001.y >= 0;
            }
            else
            {
                _1008 = false;
            }
            bool _1013;
            if (_1008)
            {
                _1013 = _1002 < _959.x;
            }
            else
            {
                _1013 = false;
            }
            bool _1019;
            if (_1013)
            {
                _1019 = _1001.y < _959.y;
            }
            else
            {
                _1019 = false;
            }
            vec4 _1027;
            if (_1019)
            {
                _1027 = texelFetch(depth_sampler, ivec3(_1002, _1001.y, 0).xy, 0);
            }
            else
            {
                _1027 = vec4(1.0);
            }
            vec2 _1031 = clamp(_983 + (_984 * vec2(_999)), vec2(0.0), vec2(1.0));
            vec4 _1041 = cpass_cb.scene_view_projection_transform_inv * vec4((_1031.x * 2.0) - 1.0, ((1.0 - _1031.y) * 2.0) - 1.0, _1027.x, 1.0);
            _278[_991] = (_1041 / vec4(_1041.w)).xyz;
        }
        vec2 _1053;
        _1053 = fract(_986);
        for (int _1056 = 0; _1056 < 2; )
        {
            vec3 _1061 = vec3(_1053.y);
            vec3 _1062 = mix(_278[0], _278[2], _1061);
            vec3 _1064 = mix(_278[1], _278[3], _1061) - _1062;
            float _1069 = clamp(dot(_972 - _1062, _1064) / dot(_1064, _1064), 0.0, 1.0);
            vec3 _1070 = vec3(_1069);
            vec3 _1071 = mix(_278[0], _278[1], _1070);
            vec3 _1073 = mix(_278[2], _278[3], _1070) - _1071;
            _1053 = vec2(_1069, clamp(dot(_972 - _1071, _1073) / dot(_1073, _1073), 0.0, 1.0));
            _1056++;
            continue;
        }
        vec2 _1080 = vec2(_988) + _1053;
        uvec2 _1087 = uvec2(textureSize(ambient_light_tex, 0));
        vec2 _1095 = vec2(1.0) / vec2(float(int(_1087.x)), float(int(_1087.y)));
        uvec2 _1097 = uvec2(ivec2(uvec2(cpass_cb.sh_atlas_size) / uvec2(2u)));
        vec2 _1102 = ((vec2(uvec2(0u) * _1097) + _1080) + vec2(0.5)) * _1095;
        vec2 _1113 = ((vec2(uvec2(1u, 0u) * _1097) + _1080) + vec2(0.5)) * _1095;
        vec2 _1124 = ((vec2(uvec2(1u) * _1097) + _1080) + vec2(0.5)) * _1095;
        vec2 _1135 = ((vec2(uvec2(0u, 1u) * _1097) + _1080) + vec2(0.5)) * _1095;
        mat4 _1143 = transpose(mat4(textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1102, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1113, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1124, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1135, 0.0, 0.0).xy, 0.0)));
        vec4 _1281;
        if (cpass_cb.gi_self_lighting != 0u)
        {
            vec4 _1255 = _1143[0];
            vec4 _1261 = _1143[1];
            vec4 _1267 = _1143[2];
            vec4 _1273 = _1143[3];
            _1281 = spvNMax(vec4(0.0), vec4(_1255.x + (dot(_1255.yzw, _951) * 2.0), _1261.x + (dot(_1261.yzw, _951) * 2.0), _1267.x + (dot(_1267.yzw, _951) * 2.0), _1273.x + (dot(_1273.yzw, _951) * 2.0)));
        }
        else
        {
            vec4 _1150 = _1143[0];
            vec3 _1151 = _1150.yzw;
            float _1152 = length(_1151);
            float _1159 = _1150.x;
            float _1161 = _1152 / spvNMax(1.0000000116860974230803549289703e-07, _1159);
            float _1162 = 2.0 * _1161;
            float _1167 = (1.0 - _1161) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1161);
            vec4 _1176 = _1143[1];
            vec3 _1177 = _1176.yzw;
            float _1178 = length(_1177);
            float _1185 = _1176.x;
            float _1187 = _1178 / spvNMax(1.0000000116860974230803549289703e-07, _1185);
            float _1188 = 2.0 * _1187;
            float _1193 = (1.0 - _1187) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1187);
            vec4 _1202 = _1143[2];
            vec3 _1203 = _1202.yzw;
            float _1204 = length(_1203);
            float _1211 = _1202.x;
            float _1213 = _1204 / spvNMax(1.0000000116860974230803549289703e-07, _1211);
            float _1214 = 2.0 * _1213;
            float _1219 = (1.0 - _1213) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1213);
            vec4 _1228 = _1143[3];
            vec3 _1229 = _1228.yzw;
            float _1230 = length(_1229);
            float _1237 = _1228.x;
            float _1239 = _1230 / spvNMax(1.0000000116860974230803549289703e-07, _1237);
            float _1240 = 2.0 * _1239;
            float _1245 = (1.0 - _1239) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1239);
            _1281 = vec4(_1159 * (_1167 + (((1.0 - _1167) * (_1162 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1151 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1152)), _951)), 0.0, 1.0), 1.0 + _1162))), _1185 * (_1193 + (((1.0 - _1193) * (_1188 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1177 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1178)), _951)), 0.0, 1.0), 1.0 + _1188))), _1211 * (_1219 + (((1.0 - _1219) * (_1214 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1203 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1204)), _951)), 0.0, 1.0), 1.0 + _1214))), _1237 * (_1245 + (((1.0 - _1245) * (_1240 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1229 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1230)), _951)), 0.0, 1.0), 1.0 + _1240))));
        }
        vec3 _1283 = _1281.xyz * 1.0;
        vec4 _1284 = vec4(_1283.x, _1283.y, _1283.z, _749.w);
        _1284.w = _369 * _1281.w;
        _1288 = _1284;
    }
    else
    {
        _1288 = vec4(vec4(0.0, 0.0, 0.0, 1.0).x, vec4(0.0, 0.0, 0.0, 1.0).y, vec4(0.0, 0.0, 0.0, 1.0).z, _749.w);
    }
    vec4 _1296 = textureLod(sampler2D(screenspace_shadowmap, SamplerLinearClamp), vec4((_908.xy / (_924 / cpass_cb.frame_to_dynamic_scale.xy)) * _924, 0.0, 0.0).xy, 0.0);
    vec4 _1300 = _1288 + vec4(_1296.x * 9.9999997473787516355514526367188e-05);
    uvec4 _1313 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _1314 = _1313.x;
    uint _1315 = _1313.y;
    vec3 _1320;
    vec3 _1322;
    vec3 _1324;
    _1320 = vec3(0.0);
    _1322 = vec3(0.0);
    _1324 = vec3(0.0);
    uint _1318;
    vec3 _1321;
    vec3 _1323;
    vec3 _1325;
    for (uint _1317 = _1314, _1326 = 0u; _1326 < _1315; _1317 = _1318, _1320 = _1321, _1322 = _1323, _1324 = _1325, _1326++)
    {
        _1318 = _1317 + 1u;
        uvec4 _1332 = texelFetch(light_indices, int(_1317));
        uint _1333 = _1332.x;
        vec4 _1352;
        if (point_light_infos._m0[_1333].channel_index > (-0.5))
        {
            vec4 _1351;
            if (point_light_infos._m0[_1333].channel_index >= 2.5)
            {
                _1351 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1350;
                if (point_light_infos._m0[_1333].channel_index >= 1.5)
                {
                    _1350 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1350 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1333].channel_index >= 0.5));
                }
                _1351 = _1350;
            }
            _1352 = _1351;
        }
        else
        {
            _1352 = vec4(0.0);
        }
        vec3 _1382 = vec4(point_light_infos._m0[_1333].position, point_light_infos._m0[_1333].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1383 = length(_1382);
        vec3 _1385 = _1382 / vec3(_1383);
        vec3 _1386 = vec4(point_light_infos._m0[_1333].color, point_light_infos._m0[_1333].median_radius).xyz;
        float _1393 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1333].channel_index, 0.0, 1.0));
        float _1398 = (_1383 / (point_light_infos._m0[_1333].median_radius / _1393)) + 1.0;
        float _1399 = _1383 / (point_light_infos._m0[_1333].median_radius * sqrt(dot(abs(_1386), vec3(1.0)) * 2.0));
        float _1404 = clamp(1.0 - (((_1399 * _1399) * _1399) * _1399), 0.0, 1.0);
        vec3 _1411 = (_1386 * spvNMin(10.0, (((0.199999988079071044921875 * _1393) * _1393) * (_1404 * _1404)) / (_1398 * _1398))) * (dot(_1296, _1352) * clamp((dot(-normalize(_374), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1333].position)) - (1.0 - length(_374))) * 2.5, 0.0, 1.0));
        if (length(_1411) > 0.0)
        {
            float _1417 = clamp(dot(_1385, _888), 0.0, 1.0);
            float _1420 = clamp(1.0 - _396, 0.0, 1.0);
            float _1422 = spvNMax(_1420 * _1420, 0.00200000009499490261077880859375);
            float _1423 = _1422 * _1422;
            vec3 _1424 = -_892;
            vec3 _1426 = normalize(_1424 + _1385);
            float _1428 = clamp(dot(_888, _1426), 0.0, 1.0);
            float _1432 = clamp(dot(_1424, _1426), 0.0, 1.0);
            float _1439 = _1422 * 0.5;
            float _1440 = 1.0 - _1439;
            _1321 = _1320 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1432) - 6.9831600189208984375) * _1432)), vec3(1.0), _429) * (_1423 / pow((((_1423 - 1.0) * _1428) * _1428) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1424, _888), 0.0, 1.0) * _1440) + _1439) * ((_1417 * _1440) + _1439)))) * _1417) * vec3(0.25)) * _1411);
            _1323 = _1322 + ((_1411 * _1417) * _382.xyz);
            _1325 = _1324 + _1411;
        }
        else
        {
            _1321 = _1320;
            _1323 = _1322;
            _1325 = _1324;
        }
    }
    uvec4 _1468 = uvec4(cobject_cb.instances[in_var_INSTANCEID / cobject_cb.instance_count].dynamic_light_indices);
    uint _1469 = _1468.x;
    uint _1472 = uint(dynamic_light_infos._m0[_1469].light_type.x);
    uint _1473 = _1468.y;
    uint _1476 = uint(dynamic_light_infos._m0[_1473].light_type.x);
    uint _1477 = _1468.z;
    uint _1480 = uint(dynamic_light_infos._m0[_1477].light_type.x);
    uint _1481 = _1468.w;
    uint _1484 = uint(dynamic_light_infos._m0[_1481].light_type.x);
    vec4 _1863;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1469].shadow_enabled.x > 0.0)
    {
        vec4 _1493 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1861;
        do
        {
            vec4 _1503 = dynamic_light_infos._m0[_1469].light_matrix * _1493;
            vec3 _1560;
            if (_1472 == 2u)
            {
                vec3 _1524 = _1503.xyz;
                vec3 _1526 = normalize(_1524) + vec3(0.0, 0.0, 1.0);
                float _1530 = length(_1524);
                vec3 _1533 = vec3((_1526 / vec3(_1526.z)).xy, _1530);
                float _1534 = _1503.z;
                vec3 _1546;
                if (_1534 > 0.0)
                {
                    _1546 = _1533;
                }
                else
                {
                    _1546 = vec3(normalize(_1533.xy) * 10000000.0, -_1530);
                }
                vec3 _1554 = vec3((_1546.x * 0.5) + 0.5, 0.5 - (_1546.y * 0.5), _1546.z);
                _1554.z = _1546.z * 9.9999997473787516355514526367188e-05;
                if (_1534 < 0.0)
                {
                    _1861 = 0.0;
                    break;
                }
                _1560 = _1554;
            }
            else
            {
                vec3 _1508 = _1503.xyz;
                vec3 _1520;
                if (_1472 == 1u)
                {
                    float _1512 = _1503.z;
                    vec3 _1519 = _1508;
                    _1519.z = _1512 - (((_1512 * dynamic_light_infos._m0[_1469].shadow_scale.z) + 1.0) / _1503.w);
                    _1520 = _1519;
                }
                else
                {
                    _1520 = _1508;
                }
                _1560 = _1520 / vec3(_1503.w);
            }
            float _1669;
            if (dynamic_light_infos._m0[_1469].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1651 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1560.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1560.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1560.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1560.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1469].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1560.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1560.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1469].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1560.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1560.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1469].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1560.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1560.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1469].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1560.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1560.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1469].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1669 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1469].shadow_scale.w * spvNMax(_1651, _1560.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1560.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1469].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1669 = 1.0;
            }
            vec2 _1670 = dynamic_light_infos._m0[_1469].shadow_scale.xy * _1669;
            float _1756 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1560.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, _1560.z, 1.0).xy, _1560.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1560.xy + (vec2(1.0, 0.0) * _1670), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, _1560.z, 1.0).xy, _1560.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1560.xy + (vec2(0.5, 0.865999996662139892578125) * _1670), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, _1560.z, 1.0).xy, _1560.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1560.xy + (vec2(-0.5, 0.865999996662139892578125) * _1670), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, _1560.z, 1.0).xy, _1560.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1560.xy + (vec2(-1.0, -0.0) * _1670), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, _1560.z, 1.0).xy, _1560.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1560.xy + (vec2(-0.5, -0.865999996662139892578125) * _1670), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, _1560.z, 1.0).xy, _1560.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1560.xy + (vec2(0.5, -0.865999996662139892578125) * _1670), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1469].shadow_atlas_offset_scale.xy, _1560.z, 1.0).xy, _1560.z), 0.0);
            float _1757 = _1756 * 0.14285714924335479736328125;
            float _1860;
            if (_1472 == 0u)
            {
                float _1772 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1493.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1774 = transpose(dynamic_light_infos._m0[_1469].light_matrix)[2];
                float _1779 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1788;
                if (_1779 > 0.100000001490116119384765625)
                {
                    _1788 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1788 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1799 = _1493.xyz - ((_1774.xyz / vec3(_1774.z)) * 1000.0);
                float _1823 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1788, _1799), dot(normalize(vec3(-_1788.y, _1788.x, 0.0)), _1799)) + (vec2(_1779, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1772 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1830 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1831 = _1830 - 1.0;
                float _1832 = 1.0 - cpass_cb.clouds_midpoint;
                float _1839 = 2.0 - _1830;
                _1860 = _1757 * mix(1.0, clamp(clamp(_1832 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1823), 0.0, 1.0), _1831)) * pow(clamp(_1832, 0.0, 1.0), _1839)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1823), 0.0, 1.0), _1831) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1839))), 0.0, 1.0) + (_1772 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1860 = _1757;
            }
            _1861 = _1860;
            break;
        } while(false);
        vec4 _1862 = vec4(1.0);
        _1862.x = _1861;
        _1863 = _1862;
    }
    else
    {
        _1863 = vec4(1.0);
    }
    vec4 _2242;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1473].shadow_enabled.x > 0.0)
    {
        vec4 _1872 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2240;
        do
        {
            vec4 _1882 = dynamic_light_infos._m0[_1473].light_matrix * _1872;
            vec3 _1939;
            if (_1476 == 2u)
            {
                vec3 _1903 = _1882.xyz;
                vec3 _1905 = normalize(_1903) + vec3(0.0, 0.0, 1.0);
                float _1909 = length(_1903);
                vec3 _1912 = vec3((_1905 / vec3(_1905.z)).xy, _1909);
                float _1913 = _1882.z;
                vec3 _1925;
                if (_1913 > 0.0)
                {
                    _1925 = _1912;
                }
                else
                {
                    _1925 = vec3(normalize(_1912.xy) * 10000000.0, -_1909);
                }
                vec3 _1933 = vec3((_1925.x * 0.5) + 0.5, 0.5 - (_1925.y * 0.5), _1925.z);
                _1933.z = _1925.z * 9.9999997473787516355514526367188e-05;
                if (_1913 < 0.0)
                {
                    _2240 = 0.0;
                    break;
                }
                _1939 = _1933;
            }
            else
            {
                vec3 _1887 = _1882.xyz;
                vec3 _1899;
                if (_1476 == 1u)
                {
                    float _1891 = _1882.z;
                    vec3 _1898 = _1887;
                    _1898.z = _1891 - (((_1891 * dynamic_light_infos._m0[_1473].shadow_scale.z) + 1.0) / _1882.w);
                    _1899 = _1898;
                }
                else
                {
                    _1899 = _1887;
                }
                _1939 = _1899 / vec3(_1882.w);
            }
            float _2048;
            if (dynamic_light_infos._m0[_1473].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2030 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1939.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1939.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1939.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1939.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1473].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1939.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1939.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1473].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1939.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1939.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1473].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1939.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1939.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1473].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1939.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1939.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1473].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2048 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1473].shadow_scale.w * spvNMax(_2030, _1939.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1939.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1473].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2048 = 1.0;
            }
            vec2 _2049 = dynamic_light_infos._m0[_1473].shadow_scale.xy * _2048;
            float _2135 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1939.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, _1939.z, 1.0).xy, _1939.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1939.xy + (vec2(1.0, 0.0) * _2049), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, _1939.z, 1.0).xy, _1939.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1939.xy + (vec2(0.5, 0.865999996662139892578125) * _2049), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, _1939.z, 1.0).xy, _1939.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1939.xy + (vec2(-0.5, 0.865999996662139892578125) * _2049), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, _1939.z, 1.0).xy, _1939.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1939.xy + (vec2(-1.0, -0.0) * _2049), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, _1939.z, 1.0).xy, _1939.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1939.xy + (vec2(-0.5, -0.865999996662139892578125) * _2049), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, _1939.z, 1.0).xy, _1939.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1939.xy + (vec2(0.5, -0.865999996662139892578125) * _2049), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1473].shadow_atlas_offset_scale.xy, _1939.z, 1.0).xy, _1939.z), 0.0);
            float _2136 = _2135 * 0.14285714924335479736328125;
            float _2239;
            if (_1476 == 0u)
            {
                float _2151 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1872.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2153 = transpose(dynamic_light_infos._m0[_1473].light_matrix)[2];
                float _2158 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2167;
                if (_2158 > 0.100000001490116119384765625)
                {
                    _2167 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2167 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2178 = _1872.xyz - ((_2153.xyz / vec3(_2153.z)) * 1000.0);
                float _2202 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2167, _2178), dot(normalize(vec3(-_2167.y, _2167.x, 0.0)), _2178)) + (vec2(_2158, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2151 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2209 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2210 = _2209 - 1.0;
                float _2211 = 1.0 - cpass_cb.clouds_midpoint;
                float _2218 = 2.0 - _2209;
                _2239 = _2136 * mix(1.0, clamp(clamp(_2211 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2202), 0.0, 1.0), _2210)) * pow(clamp(_2211, 0.0, 1.0), _2218)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2202), 0.0, 1.0), _2210) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2218))), 0.0, 1.0) + (_2151 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2239 = _2136;
            }
            _2240 = _2239;
            break;
        } while(false);
        vec4 _2241 = _1863;
        _2241.y = _2240;
        _2242 = _2241;
    }
    else
    {
        _2242 = _1863;
    }
    vec4 _2621;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1477].shadow_enabled.x > 0.0)
    {
        vec4 _2251 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2619;
        do
        {
            vec4 _2261 = dynamic_light_infos._m0[_1477].light_matrix * _2251;
            vec3 _2318;
            if (_1480 == 2u)
            {
                vec3 _2282 = _2261.xyz;
                vec3 _2284 = normalize(_2282) + vec3(0.0, 0.0, 1.0);
                float _2288 = length(_2282);
                vec3 _2291 = vec3((_2284 / vec3(_2284.z)).xy, _2288);
                float _2292 = _2261.z;
                vec3 _2304;
                if (_2292 > 0.0)
                {
                    _2304 = _2291;
                }
                else
                {
                    _2304 = vec3(normalize(_2291.xy) * 10000000.0, -_2288);
                }
                vec3 _2312 = vec3((_2304.x * 0.5) + 0.5, 0.5 - (_2304.y * 0.5), _2304.z);
                _2312.z = _2304.z * 9.9999997473787516355514526367188e-05;
                if (_2292 < 0.0)
                {
                    _2619 = 0.0;
                    break;
                }
                _2318 = _2312;
            }
            else
            {
                vec3 _2266 = _2261.xyz;
                vec3 _2278;
                if (_1480 == 1u)
                {
                    float _2270 = _2261.z;
                    vec3 _2277 = _2266;
                    _2277.z = _2270 - (((_2270 * dynamic_light_infos._m0[_1477].shadow_scale.z) + 1.0) / _2261.w);
                    _2278 = _2277;
                }
                else
                {
                    _2278 = _2266;
                }
                _2318 = _2278 / vec3(_2261.w);
            }
            float _2427;
            if (dynamic_light_infos._m0[_1477].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2409 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2318.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2318.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2318.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2318.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1477].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2318.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2318.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1477].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2318.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2318.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1477].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2318.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2318.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1477].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2318.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2318.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1477].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2427 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1477].shadow_scale.w * spvNMax(_2409, _2318.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2318.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1477].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2427 = 1.0;
            }
            vec2 _2428 = dynamic_light_infos._m0[_1477].shadow_scale.xy * _2427;
            float _2514 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2318.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, _2318.z, 1.0).xy, _2318.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2318.xy + (vec2(1.0, 0.0) * _2428), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, _2318.z, 1.0).xy, _2318.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2318.xy + (vec2(0.5, 0.865999996662139892578125) * _2428), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, _2318.z, 1.0).xy, _2318.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2318.xy + (vec2(-0.5, 0.865999996662139892578125) * _2428), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, _2318.z, 1.0).xy, _2318.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2318.xy + (vec2(-1.0, -0.0) * _2428), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, _2318.z, 1.0).xy, _2318.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2318.xy + (vec2(-0.5, -0.865999996662139892578125) * _2428), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, _2318.z, 1.0).xy, _2318.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2318.xy + (vec2(0.5, -0.865999996662139892578125) * _2428), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1477].shadow_atlas_offset_scale.xy, _2318.z, 1.0).xy, _2318.z), 0.0);
            float _2515 = _2514 * 0.14285714924335479736328125;
            float _2618;
            if (_1480 == 0u)
            {
                float _2530 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2251.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2532 = transpose(dynamic_light_infos._m0[_1477].light_matrix)[2];
                float _2537 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2546;
                if (_2537 > 0.100000001490116119384765625)
                {
                    _2546 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2546 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2557 = _2251.xyz - ((_2532.xyz / vec3(_2532.z)) * 1000.0);
                float _2581 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2546, _2557), dot(normalize(vec3(-_2546.y, _2546.x, 0.0)), _2557)) + (vec2(_2537, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2530 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2588 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2589 = _2588 - 1.0;
                float _2590 = 1.0 - cpass_cb.clouds_midpoint;
                float _2597 = 2.0 - _2588;
                _2618 = _2515 * mix(1.0, clamp(clamp(_2590 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2581), 0.0, 1.0), _2589)) * pow(clamp(_2590, 0.0, 1.0), _2597)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2581), 0.0, 1.0), _2589) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2597))), 0.0, 1.0) + (_2530 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2618 = _2515;
            }
            _2619 = _2618;
            break;
        } while(false);
        vec4 _2620 = _2242;
        _2620.z = _2619;
        _2621 = _2620;
    }
    else
    {
        _2621 = _2242;
    }
    vec4 _3000;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1481].shadow_enabled.x > 0.0)
    {
        vec4 _2630 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2998;
        do
        {
            vec4 _2640 = dynamic_light_infos._m0[_1481].light_matrix * _2630;
            vec3 _2697;
            if (_1484 == 2u)
            {
                vec3 _2661 = _2640.xyz;
                vec3 _2663 = normalize(_2661) + vec3(0.0, 0.0, 1.0);
                float _2667 = length(_2661);
                vec3 _2670 = vec3((_2663 / vec3(_2663.z)).xy, _2667);
                float _2671 = _2640.z;
                vec3 _2683;
                if (_2671 > 0.0)
                {
                    _2683 = _2670;
                }
                else
                {
                    _2683 = vec3(normalize(_2670.xy) * 10000000.0, -_2667);
                }
                vec3 _2691 = vec3((_2683.x * 0.5) + 0.5, 0.5 - (_2683.y * 0.5), _2683.z);
                _2691.z = _2683.z * 9.9999997473787516355514526367188e-05;
                if (_2671 < 0.0)
                {
                    _2998 = 0.0;
                    break;
                }
                _2697 = _2691;
            }
            else
            {
                vec3 _2645 = _2640.xyz;
                vec3 _2657;
                if (_1484 == 1u)
                {
                    float _2649 = _2640.z;
                    vec3 _2656 = _2645;
                    _2656.z = _2649 - (((_2649 * dynamic_light_infos._m0[_1481].shadow_scale.z) + 1.0) / _2640.w);
                    _2657 = _2656;
                }
                else
                {
                    _2657 = _2645;
                }
                _2697 = _2657 / vec3(_2640.w);
            }
            float _2806;
            if (dynamic_light_infos._m0[_1481].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2788 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2697.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2697.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2697.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2697.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1481].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2697.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2697.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1481].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2697.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2697.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1481].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2697.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2697.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1481].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2697.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2697.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1481].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2806 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1481].shadow_scale.w * spvNMax(_2788, _2697.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2697.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1481].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2806 = 1.0;
            }
            vec2 _2807 = dynamic_light_infos._m0[_1481].shadow_scale.xy * _2806;
            float _2893 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2697.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, _2697.z, 1.0).xy, _2697.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2697.xy + (vec2(1.0, 0.0) * _2807), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, _2697.z, 1.0).xy, _2697.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2697.xy + (vec2(0.5, 0.865999996662139892578125) * _2807), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, _2697.z, 1.0).xy, _2697.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2697.xy + (vec2(-0.5, 0.865999996662139892578125) * _2807), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, _2697.z, 1.0).xy, _2697.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2697.xy + (vec2(-1.0, -0.0) * _2807), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, _2697.z, 1.0).xy, _2697.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2697.xy + (vec2(-0.5, -0.865999996662139892578125) * _2807), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, _2697.z, 1.0).xy, _2697.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2697.xy + (vec2(0.5, -0.865999996662139892578125) * _2807), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1481].shadow_atlas_offset_scale.xy, _2697.z, 1.0).xy, _2697.z), 0.0);
            float _2894 = _2893 * 0.14285714924335479736328125;
            float _2997;
            if (_1484 == 0u)
            {
                float _2909 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2630.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2911 = transpose(dynamic_light_infos._m0[_1481].light_matrix)[2];
                float _2916 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2925;
                if (_2916 > 0.100000001490116119384765625)
                {
                    _2925 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2925 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2936 = _2630.xyz - ((_2911.xyz / vec3(_2911.z)) * 1000.0);
                float _2960 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2925, _2936), dot(normalize(vec3(-_2925.y, _2925.x, 0.0)), _2936)) + (vec2(_2916, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2909 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2967 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2968 = _2967 - 1.0;
                float _2969 = 1.0 - cpass_cb.clouds_midpoint;
                float _2976 = 2.0 - _2967;
                _2997 = _2894 * mix(1.0, clamp(clamp(_2969 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2960), 0.0, 1.0), _2968)) * pow(clamp(_2969, 0.0, 1.0), _2976)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2960), 0.0, 1.0), _2968) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2976))), 0.0, 1.0) + (_2909 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2997 = _2894;
            }
            _2998 = _2997;
            break;
        } while(false);
        vec4 _2999 = _2621;
        _2999.w = _2998;
        _3000 = _2999;
    }
    else
    {
        _3000 = _2621;
    }
    vec3 _3067;
    vec3 _3068;
    switch (_1472)
    {
        case 0u:
        {
            _3067 = dynamic_light_infos._m0[_1469].light_color.xyz;
            _3068 = -dynamic_light_infos._m0[_1469].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3044 = dynamic_light_infos._m0[_1469].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3045 = length(_3044);
            vec3 _3047 = _3044 / vec3(_3045);
            _3067 = dynamic_light_infos._m0[_1469].light_color.xyz * ((1.0 - clamp(_3045 / dynamic_light_infos._m0[_1469].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1469].light_direction.xyz, _3047) - dynamic_light_infos._m0[_1469].light_direction.w) / (dynamic_light_infos._m0[_1469].light_position.w - dynamic_light_infos._m0[_1469].light_direction.w), 0.0, 1.0));
            _3068 = _3047;
            break;
        }
        case 2u:
        {
            vec3 _3012 = dynamic_light_infos._m0[_1469].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3013 = length(_3012);
            float _3025 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1469].light_position.w, 0.0, 1.0));
            float _3030 = (_3013 / (dynamic_light_infos._m0[_1469].light_color.w / _3025)) + 1.0;
            float _3031 = _3013 / (dynamic_light_infos._m0[_1469].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1469].light_color.xyz), vec3(1.0)) * 2.0));
            float _3036 = clamp(1.0 - (((_3031 * _3031) * _3031) * _3031), 0.0, 1.0);
            _3067 = dynamic_light_infos._m0[_1469].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3025) * _3025) * (_3036 * _3036)) / (_3030 * _3030));
            _3068 = _3012 / vec3(_3013);
            break;
        }
        default:
        {
            _3067 = vec3(0.0);
            _3068 = vec3(0.0);
            break;
        }
    }
    vec3 _3070 = normalize(_374);
    vec3 _3072 = -_3070;
    float _3074 = 1.0 - length(_374);
    vec3 _3080 = _3067 * (_3000.x * clamp((dot(_3072, -_3068) - _3074) * 2.5, 0.0, 1.0));
    vec3 _3132;
    vec3 _3133;
    vec3 _3134;
    if (length(_3080) > 0.0)
    {
        float _3086 = clamp(dot(_3068, _888), 0.0, 1.0);
        float _3089 = clamp(1.0 - _396, 0.0, 1.0);
        float _3091 = spvNMax(_3089 * _3089, 0.00200000009499490261077880859375);
        float _3092 = _3091 * _3091;
        vec3 _3093 = -_892;
        vec3 _3095 = normalize(_3093 + _3068);
        float _3097 = clamp(dot(_888, _3095), 0.0, 1.0);
        float _3101 = clamp(dot(_3093, _3095), 0.0, 1.0);
        float _3108 = _3091 * 0.5;
        float _3109 = 1.0 - _3108;
        _3132 = _1320 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3101) - 6.9831600189208984375) * _3101)), vec3(1.0), _429) * (_3092 / pow((((_3092 - 1.0) * _3097) * _3097) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3093, _888), 0.0, 1.0) * _3109) + _3108) * ((_3086 * _3109) + _3108)))) * _3086) * vec3(0.25)) * _3080);
        _3133 = _1322 + ((_3080 * _3086) * _382.xyz);
        _3134 = _1324 + _3080;
    }
    else
    {
        _3132 = _1320;
        _3133 = _1322;
        _3134 = _1324;
    }
    vec3 _3201;
    vec3 _3202;
    switch (_1476)
    {
        case 0u:
        {
            _3201 = dynamic_light_infos._m0[_1473].light_color.xyz;
            _3202 = -dynamic_light_infos._m0[_1473].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3178 = dynamic_light_infos._m0[_1473].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3179 = length(_3178);
            vec3 _3181 = _3178 / vec3(_3179);
            _3201 = dynamic_light_infos._m0[_1473].light_color.xyz * ((1.0 - clamp(_3179 / dynamic_light_infos._m0[_1473].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1473].light_direction.xyz, _3181) - dynamic_light_infos._m0[_1473].light_direction.w) / (dynamic_light_infos._m0[_1473].light_position.w - dynamic_light_infos._m0[_1473].light_direction.w), 0.0, 1.0));
            _3202 = _3181;
            break;
        }
        case 2u:
        {
            vec3 _3146 = dynamic_light_infos._m0[_1473].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3147 = length(_3146);
            float _3159 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1473].light_position.w, 0.0, 1.0));
            float _3164 = (_3147 / (dynamic_light_infos._m0[_1473].light_color.w / _3159)) + 1.0;
            float _3165 = _3147 / (dynamic_light_infos._m0[_1473].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1473].light_color.xyz), vec3(1.0)) * 2.0));
            float _3170 = clamp(1.0 - (((_3165 * _3165) * _3165) * _3165), 0.0, 1.0);
            _3201 = dynamic_light_infos._m0[_1473].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3159) * _3159) * (_3170 * _3170)) / (_3164 * _3164));
            _3202 = _3146 / vec3(_3147);
            break;
        }
        default:
        {
            _3201 = vec3(0.0);
            _3202 = vec3(0.0);
            break;
        }
    }
    vec3 _3210 = _3201 * (_3000.y * clamp((dot(_3072, -_3202) - _3074) * 2.5, 0.0, 1.0));
    vec3 _3262;
    vec3 _3263;
    vec3 _3264;
    if (length(_3210) > 0.0)
    {
        float _3216 = clamp(dot(_3202, _888), 0.0, 1.0);
        float _3219 = clamp(1.0 - _396, 0.0, 1.0);
        float _3221 = spvNMax(_3219 * _3219, 0.00200000009499490261077880859375);
        float _3222 = _3221 * _3221;
        vec3 _3223 = -_892;
        vec3 _3225 = normalize(_3223 + _3202);
        float _3227 = clamp(dot(_888, _3225), 0.0, 1.0);
        float _3231 = clamp(dot(_3223, _3225), 0.0, 1.0);
        float _3238 = _3221 * 0.5;
        float _3239 = 1.0 - _3238;
        _3262 = _3132 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3231) - 6.9831600189208984375) * _3231)), vec3(1.0), _429) * (_3222 / pow((((_3222 - 1.0) * _3227) * _3227) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3223, _888), 0.0, 1.0) * _3239) + _3238) * ((_3216 * _3239) + _3238)))) * _3216) * vec3(0.25)) * _3210);
        _3263 = _3133 + ((_3210 * _3216) * _382.xyz);
        _3264 = _3134 + _3210;
    }
    else
    {
        _3262 = _3132;
        _3263 = _3133;
        _3264 = _3134;
    }
    vec3 _3331;
    vec3 _3332;
    switch (_1480)
    {
        case 0u:
        {
            _3331 = dynamic_light_infos._m0[_1477].light_color.xyz;
            _3332 = -dynamic_light_infos._m0[_1477].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3308 = dynamic_light_infos._m0[_1477].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3309 = length(_3308);
            vec3 _3311 = _3308 / vec3(_3309);
            _3331 = dynamic_light_infos._m0[_1477].light_color.xyz * ((1.0 - clamp(_3309 / dynamic_light_infos._m0[_1477].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1477].light_direction.xyz, _3311) - dynamic_light_infos._m0[_1477].light_direction.w) / (dynamic_light_infos._m0[_1477].light_position.w - dynamic_light_infos._m0[_1477].light_direction.w), 0.0, 1.0));
            _3332 = _3311;
            break;
        }
        case 2u:
        {
            vec3 _3276 = dynamic_light_infos._m0[_1477].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3277 = length(_3276);
            float _3289 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1477].light_position.w, 0.0, 1.0));
            float _3294 = (_3277 / (dynamic_light_infos._m0[_1477].light_color.w / _3289)) + 1.0;
            float _3295 = _3277 / (dynamic_light_infos._m0[_1477].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1477].light_color.xyz), vec3(1.0)) * 2.0));
            float _3300 = clamp(1.0 - (((_3295 * _3295) * _3295) * _3295), 0.0, 1.0);
            _3331 = dynamic_light_infos._m0[_1477].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3289) * _3289) * (_3300 * _3300)) / (_3294 * _3294));
            _3332 = _3276 / vec3(_3277);
            break;
        }
        default:
        {
            _3331 = vec3(0.0);
            _3332 = vec3(0.0);
            break;
        }
    }
    vec3 _3340 = _3331 * (_3000.z * clamp((dot(_3072, -_3332) - _3074) * 2.5, 0.0, 1.0));
    vec3 _3392;
    vec3 _3393;
    vec3 _3394;
    if (length(_3340) > 0.0)
    {
        float _3346 = clamp(dot(_3332, _888), 0.0, 1.0);
        float _3349 = clamp(1.0 - _396, 0.0, 1.0);
        float _3351 = spvNMax(_3349 * _3349, 0.00200000009499490261077880859375);
        float _3352 = _3351 * _3351;
        vec3 _3353 = -_892;
        vec3 _3355 = normalize(_3353 + _3332);
        float _3357 = clamp(dot(_888, _3355), 0.0, 1.0);
        float _3361 = clamp(dot(_3353, _3355), 0.0, 1.0);
        float _3368 = _3351 * 0.5;
        float _3369 = 1.0 - _3368;
        _3392 = _3262 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3361) - 6.9831600189208984375) * _3361)), vec3(1.0), _429) * (_3352 / pow((((_3352 - 1.0) * _3357) * _3357) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3353, _888), 0.0, 1.0) * _3369) + _3368) * ((_3346 * _3369) + _3368)))) * _3346) * vec3(0.25)) * _3340);
        _3393 = _3263 + ((_3340 * _3346) * _382.xyz);
        _3394 = _3264 + _3340;
    }
    else
    {
        _3392 = _3262;
        _3393 = _3263;
        _3394 = _3264;
    }
    vec3 _3461;
    vec3 _3462;
    switch (_1484)
    {
        case 0u:
        {
            _3461 = dynamic_light_infos._m0[_1481].light_color.xyz;
            _3462 = -dynamic_light_infos._m0[_1481].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3438 = dynamic_light_infos._m0[_1481].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3439 = length(_3438);
            vec3 _3441 = _3438 / vec3(_3439);
            _3461 = dynamic_light_infos._m0[_1481].light_color.xyz * ((1.0 - clamp(_3439 / dynamic_light_infos._m0[_1481].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1481].light_direction.xyz, _3441) - dynamic_light_infos._m0[_1481].light_direction.w) / (dynamic_light_infos._m0[_1481].light_position.w - dynamic_light_infos._m0[_1481].light_direction.w), 0.0, 1.0));
            _3462 = _3441;
            break;
        }
        case 2u:
        {
            vec3 _3406 = dynamic_light_infos._m0[_1481].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3407 = length(_3406);
            float _3419 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1481].light_position.w, 0.0, 1.0));
            float _3424 = (_3407 / (dynamic_light_infos._m0[_1481].light_color.w / _3419)) + 1.0;
            float _3425 = _3407 / (dynamic_light_infos._m0[_1481].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1481].light_color.xyz), vec3(1.0)) * 2.0));
            float _3430 = clamp(1.0 - (((_3425 * _3425) * _3425) * _3425), 0.0, 1.0);
            _3461 = dynamic_light_infos._m0[_1481].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3419) * _3419) * (_3430 * _3430)) / (_3424 * _3424));
            _3462 = _3406 / vec3(_3407);
            break;
        }
        default:
        {
            _3461 = vec3(0.0);
            _3462 = vec3(0.0);
            break;
        }
    }
    vec3 _3470 = _3461 * (_3000.w * clamp((dot(_3072, -_3462) - _3074) * 2.5, 0.0, 1.0));
    vec3 _3522;
    vec3 _3523;
    vec3 _3524;
    if (length(_3470) > 0.0)
    {
        float _3476 = clamp(dot(_3462, _888), 0.0, 1.0);
        float _3479 = clamp(1.0 - _396, 0.0, 1.0);
        float _3481 = spvNMax(_3479 * _3479, 0.00200000009499490261077880859375);
        float _3482 = _3481 * _3481;
        vec3 _3483 = -_892;
        vec3 _3485 = normalize(_3483 + _3462);
        float _3487 = clamp(dot(_888, _3485), 0.0, 1.0);
        float _3491 = clamp(dot(_3483, _3485), 0.0, 1.0);
        float _3498 = _3481 * 0.5;
        float _3499 = 1.0 - _3498;
        _3522 = _3393 + ((_3470 * _3476) * _382.xyz);
        _3523 = _3392 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3491) - 6.9831600189208984375) * _3491)), vec3(1.0), _429) * (_3482 / pow((((_3482 - 1.0) * _3487) * _3487) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3483, _888), 0.0, 1.0) * _3499) + _3498) * ((_3476 * _3499) + _3498)))) * _3476) * vec3(0.25)) * _3470);
        _3524 = _3394 + _3470;
    }
    else
    {
        _3522 = _3393;
        _3523 = _3392;
        _3524 = _3394;
    }
    vec3 _3647;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _3537 = _1300.w;
        float _3538 = clamp(_396, 0.0, 1.0);
        float _3541 = sqrt(clamp(1.0 - _3537, 0.0, 1.0));
        float _3542 = 1.0 - _3538;
        float _3543 = _3542 * _3542;
        float _3546 = clamp(exp((-2.2999999523162841796875) * _3543), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _3547 = dot(_3070, _893);
        float _3553 = sqrt(clamp(1.0 - (_3547 * _3547), 0.0, 1.0));
        float _3555 = _3546 - (_3547 * _3541);
        float _3556 = _3553 * _3541;
        vec2 _3557 = vec2(_3555, _3556);
        float _3559 = _3541 - (_3547 * _3546);
        float _3560 = _3553 * _3546;
        vec2 _3561 = vec2(_3559, _3560);
        float _3565 = sqrt(clamp(1.0 - (_3541 * _3541), 0.0, 1.0));
        float _3582 = sqrt(clamp(1.0 - (_3546 * _3546), 0.0, 1.0));
        vec4 _3608 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_888, -_892)), _3538, 0.0, 0.0).xy, 0.0);
        float _3621 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _3543));
        vec3 _3646 = _3523 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_893, 0.0)).xyz, _3621).xyz, _3621).xyz * (vec3(_3608.x) + (_429 * _3608.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3524 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * (_3537 * ((2.0 * ((acos(clamp(_3555 / (_3565 * sqrt(dot(_3557, _3557))), -1.0, 1.0)) - (acos(clamp((_3555 * _3541) / (_3556 * _3565), -1.0, 1.0)) * _3541)) + (acos(clamp(_3559 / (_3582 * sqrt(dot(_3561, _3561))), -1.0, 1.0)) - (acos(clamp((_3559 * _3546) / (_3560 * _3582), -1.0, 1.0)) * _3546)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _3546)))));
        _3647 = _3646;
    }
    else
    {
        _3647 = _3523;
    }
    vec3 _3659 = _382.xyz;
    vec3 _3690;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _3690 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_374, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3524 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _3659) * _1300.w) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _3690 = vec3(0.0);
    }
    vec3 _3695 = (_3522 * cpass_cb.indirect_light_multiplier) + (_704 * 20.0);
    vec3 _3711 = (_3522 + _704) + (((_1300.xyz * _3659) + _3690) + spvNMax(vec3(0.0), _3647 / vec3(spvNMax(10.0, spvNMax(_3647.x, spvNMax(_3647.y, _3647.z))) * 0.100000001490116119384765625)));
    vec4 _3712 = vec4(_3711.x, _3711.y, _3711.z, vec4(0.0).w);
    _3712.w = _883;
    vec3 _3714 = in_var_TEXCOORD0.xyz - in_var_AUTO_CEOBGMGP_GEBKIEDD;
    vec4 _3717 = vec4(_3714.x, _3714.y, _3714.z, _268.w);
    _3717.w = 1.0;
    vec4 _3719 = cpass_cb.last_view_projection_transform * _3717;
    vec2 _3725 = ((_3719 / vec4(_3719.w)).xy * 0.5) + vec2(0.5);
    out_var_SV_TARGET = _3712;
    out_var_SV_TARGET2 = vec4(_3695, _883);
    out_var_SV_TARGET1 = vec4(((_908 - vec3(_3725.x, 1.0 - _3725.y, _267)) * vec3(ivec3(ivec2(uvec2((cpass_cb.frame_resolution.xy * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))), 0))).xy, 0.0, 0.0);
}

