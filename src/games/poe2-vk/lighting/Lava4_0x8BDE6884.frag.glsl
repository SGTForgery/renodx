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

const vec4 _250[4] = vec4[](vec4(0.0, 0.0, 0.0, 1.0), vec4(0.0, 0.0, 0.0, 1.0), vec4(0.0, 0.0, 0.0, 1.0), vec4(0.0, 0.0, 0.0, 1.0));
const ivec2 _256[4] = ivec2[](ivec2(0), ivec2(1, 0), ivec2(0, 1), ivec2(1));
float _266;
vec4 _267;
float _271;
vec4 _272;

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
layout(set = 2, binding = 47) uniform texture2D muddle_texture_0;
layout(set = 2, binding = 48) uniform texture2D texture_object_0;
layout(set = 2, binding = 49) uniform texture2D input_texture_0;

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
    vec4 _312 = texture(sampler2D(muddle_texture_0, SamplerLinearWrap), (in_var_TEXCOORD1 * 1.0) + (vec2(-0.0199999995529651641845703125, 0.0199999995529651641845703125) * cpass_cb.time));
    vec2 _322 = vec2(cpipeline_cb.maya_scale_pivot_0.x, 1.0 - cpipeline_cb.maya_scale_pivot_0.y);
    vec2 _338 = ((((in_var_TEXCOORD1 + ((_312.xy - vec2(0.5)) * 0.0199999995529651641845703125)) - _322) * vec2(0.5)) + _322) + (vec2((cpipeline_cb.constant_bool_0 != 0u) ? pow(spvNMax(abs(in_var_AUTO_FBMBEBGD_ANHFJCCP.w), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_2) : cpass_cb.time) * vec2(0.0, -0.100000001490116119384765625));
    mat3 _339 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _353 = ((vec2(textureLod(sampler2D(texture_object_0, SamplerDynamicWrap), vec4(_338, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _354 = vec3(_353.x, _353.y, vec3(0.0).z);
    vec2 _355 = _353.xy;
    _354.z = sqrt(spvNMax(1.0 - dot(_355, _355), 0.0));
    vec3 _361 = _339 * _354;
    vec4 _367 = texture(sampler2D(texture_object_0, SamplerDynamicWrap), _338);
    float _368 = _367.z;
    vec3 _373 = vec3(pow(spvNMax(abs(_368), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_361 / vec3(length(_361) + 1.0000000116860974230803549289703e-07));
    vec4 _376 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _338);
    vec3 _377 = _376.xyz;
    vec3 _379 = vec3(_376.w);
    vec3 _381 = clamp(mix(_377, vec3(0.0), _379), vec3(0.0), vec3(1.0));
    vec2 _387 = ((vec2(_367.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _388 = vec3(_387.x, _387.y, vec3(0.0).z);
    vec2 _389 = _387.xy;
    _388.z = sqrt(spvNMax(1.0 - dot(_389, _389), 0.0));
    float _395 = _367.w;
    float _404 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _405 = cos(_404);
    vec3 _420 = (((_377 * _405) + (cross(vec3(0.57735002040863037109375), _377) * sin(_404))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _377)) * (1.0 - _405))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _428 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_420, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _420, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _379), vec3(0.0), vec3(1.0));
    bool _431 = cpipeline_cb.constant_trackG_0 < 0;
    float _433 = clamp(_368, 0.0, 1.0) * 127.0;
    int _437 = int(spvNMax(trunc(_433), 0.0) + 0.5);
    int _442 = int(spvNMin(trunc(_433 + 1.0), 127.0) + 0.5);
    float _460;
    if (_431)
    {
        _460 = 0.0;
    }
    else
    {
        uint _446 = uint(cpipeline_cb.constant_trackG_0);
        int _447 = _437 / 2;
        _460 = ((_437 - 2 * (_437 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_446].value[_447] & 65535u).x : unpackHalf2x16((spline_lut._m0[_446].value[_447] >> 16u) & 65535u).x;
    }
    float _478;
    if (_431)
    {
        _478 = 0.0;
    }
    else
    {
        uint _464 = uint(cpipeline_cb.constant_trackG_0);
        int _465 = _442 / 2;
        _478 = ((_442 - 2 * (_442 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_464].value[_465] & 65535u).x : unpackHalf2x16((spline_lut._m0[_464].value[_465] >> 16u) & 65535u).x;
    }
    float _479 = fract(_433);
    bool _485 = cpipeline_cb.constant_trackG_1 < 0;
    float _503;
    if (_485)
    {
        _503 = 0.0;
    }
    else
    {
        uint _489 = uint(cpipeline_cb.constant_trackG_1);
        int _490 = _437 / 2;
        _503 = ((_437 - 2 * (_437 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_489].value[_490] & 65535u).x : unpackHalf2x16((spline_lut._m0[_489].value[_490] >> 16u) & 65535u).x;
    }
    float _521;
    if (_485)
    {
        _521 = 0.0;
    }
    else
    {
        uint _507 = uint(cpipeline_cb.constant_trackG_1);
        int _508 = _442 / 2;
        _521 = ((_442 - 2 * (_442 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_507].value[_508] & 65535u).x : unpackHalf2x16((spline_lut._m0[_507].value[_508] >> 16u) & 65535u).x;
    }
    float _530 = clamp((spvNMax(vec3(mix(_460, _478, _479), _271, _271), vec3(0.0)) + spvNMax(vec3(mix(_503, _521, _479), _271, _271), vec3(0.0))).x, 0.0, 1.0) * 127.0;
    int _535 = int(spvNMax(trunc(_530), 0.0) + 0.5);
    int _540 = int(spvNMin(trunc(_530 + 1.0), 127.0) + 0.5);
    bool _541 = cpipeline_cb.constant_trackC_0.x < 0;
    float _559;
    if (_541)
    {
        _559 = 0.0;
    }
    else
    {
        uint _545 = uint(cpipeline_cb.constant_trackC_0.x);
        int _546 = _535 / 2;
        _559 = ((_535 - 2 * (_535 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_545].value[_546] & 65535u).x : unpackHalf2x16((spline_lut._m0[_545].value[_546] >> 16u) & 65535u).x;
    }
    float _577;
    if (_541)
    {
        _577 = 0.0;
    }
    else
    {
        uint _563 = uint(cpipeline_cb.constant_trackC_0.x);
        int _564 = _540 / 2;
        _577 = ((_540 - 2 * (_540 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_563].value[_564] & 65535u).x : unpackHalf2x16((spline_lut._m0[_563].value[_564] >> 16u) & 65535u).x;
    }
    float _578 = fract(_530);
    bool _581 = cpipeline_cb.constant_trackC_0.y < 0;
    float _599;
    if (_581)
    {
        _599 = 0.0;
    }
    else
    {
        uint _585 = uint(cpipeline_cb.constant_trackC_0.y);
        int _586 = _535 / 2;
        _599 = ((_535 - 2 * (_535 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_585].value[_586] & 65535u).x : unpackHalf2x16((spline_lut._m0[_585].value[_586] >> 16u) & 65535u).x;
    }
    float _617;
    if (_581)
    {
        _617 = 0.0;
    }
    else
    {
        uint _603 = uint(cpipeline_cb.constant_trackC_0.y);
        int _604 = _540 / 2;
        _617 = ((_540 - 2 * (_540 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_603].value[_604] & 65535u).x : unpackHalf2x16((spline_lut._m0[_603].value[_604] >> 16u) & 65535u).x;
    }
    bool _620 = cpipeline_cb.constant_trackC_0.z < 0;
    float _638;
    if (_620)
    {
        _638 = 0.0;
    }
    else
    {
        uint _624 = uint(cpipeline_cb.constant_trackC_0.z);
        int _625 = _535 / 2;
        _638 = ((_535 - 2 * (_535 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_624].value[_625] & 65535u).x : unpackHalf2x16((spline_lut._m0[_624].value[_625] >> 16u) & 65535u).x;
    }
    float _656;
    if (_620)
    {
        _656 = 0.0;
    }
    else
    {
        uint _642 = uint(cpipeline_cb.constant_trackC_0.z);
        int _643 = _540 / 2;
        _656 = ((_540 - 2 * (_540 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_642].value[_643] & 65535u).x : unpackHalf2x16((spline_lut._m0[_642].value[_643] >> 16u) & 65535u).x;
    }
    bool _659 = cpipeline_cb.constant_trackC_0.w < 0;
    float _677;
    if (_659)
    {
        _677 = 0.0;
    }
    else
    {
        uint _663 = uint(cpipeline_cb.constant_trackC_0.w);
        int _664 = _535 / 2;
        _677 = ((_535 - 2 * (_535 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_663].value[_664] & 65535u).x : unpackHalf2x16((spline_lut._m0[_663].value[_664] >> 16u) & 65535u).x;
    }
    float _695;
    if (_659)
    {
        _695 = 0.0;
    }
    else
    {
        uint _681 = uint(cpipeline_cb.constant_trackC_0.w);
        int _682 = _540 / 2;
        _695 = ((_540 - 2 * (_540 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_681].value[_682] & 65535u).x : unpackHalf2x16((spline_lut._m0[_681].value[_682] >> 16u) & 65535u).x;
    }
    float _696 = mix(_677, _695, _578);
    vec3 _703 = spvNMin((vec4(mix(_559, _577, _578), mix(_599, _617, _578), mix(_638, _656, _578), _696).xyz * vec3(spvNMax(_696, 0.0))) * 5.0, vec3(100.0));
    bool _706 = cpipeline_cb.constant_trackG_2 < 0;
    float _724;
    if (_706)
    {
        _724 = 0.0;
    }
    else
    {
        uint _710 = uint(cpipeline_cb.constant_trackG_2);
        int _711 = _437 / 2;
        _724 = ((_437 - 2 * (_437 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_710].value[_711] & 65535u).x : unpackHalf2x16((spline_lut._m0[_710].value[_711] >> 16u) & 65535u).x;
    }
    float _742;
    if (_706)
    {
        _742 = 0.0;
    }
    else
    {
        uint _728 = uint(cpipeline_cb.constant_trackG_2);
        int _729 = _442 / 2;
        _742 = ((_442 - 2 * (_442 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_728].value[_729] & 65535u).x : unpackHalf2x16((spline_lut._m0[_728].value[_729] >> 16u) & 65535u).x;
    }
    float _747 = clamp(spvNMax(vec3(mix(_724, _742, _479), _271, _271), vec3(0.0)).x, 0.0, 1.0);
    vec4 _748;
    _748.w = _368;
    float _755;
    _755 = 0.0;
    float _756;
    for (uint _758 = 0u; _758 < 1u; _755 = _756, _758++)
    {
        uint _763 = cpipeline_cb.constantUInt1_80 / 4u;
        uint _764 = cpipeline_cb.constantUInt1_80 % 4u;
        uint _767 = in_var_INSTANCEID / cobject_cb.instance_count;
        vec4 _796;
        if (!(((particles_emitter_data._m0[cobject_cb.instances[_767].gpu_particle_emitter].culling_tag >> 14u) & 512u) == 0u))
        {
            vec4 _795;
            if (floatBitsToUint(cpass_cb.frame_delta_time.w) == 0u)
            {
                _795 = vec4(_271, 0.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            else
            {
                _795 = vec4(0.0, 1.0, 1.0, cpass_cb.frame_delta_time.w);
            }
            _796 = _795;
        }
        else
        {
            _796 = cpass_cb.frame_delta_time;
        }
        float _804 = mix(particles_emitter_data._m0[cobject_cb.instances[_767].gpu_particle_emitter].prev_time, particles_emitter_data._m0[cobject_cb.instances[_767].gpu_particle_emitter].time, _796.z) / particles_emitter_data._m0[cobject_cb.instances[_767].gpu_particle_emitter].emitter_duration;
        float _805 = spvNMax(0.0, _804);
        float _811;
        if (((particles_emitter_data._m0[cobject_cb.instances[_767].gpu_particle_emitter].culling_tag >> 14u) & 2u) != 0u)
        {
            _811 = fract(_805);
        }
        else
        {
            _811 = _805;
        }
        float _818 = spvNMax(cpipeline_cb.constant1_8, 9.9999997473787516355514526367188e-05);
        float _825;
        if (abs(_818) > 0.0)
        {
            _825 = in_var_AUTO_PIPJIEKO_LDBDDLHP / _818;
        }
        else
        {
            _825 = 0.0;
        }
        float _832;
        if (_764 == 0u)
        {
            _832 = _825;
        }
        else
        {
            _832 = (_764 == 1u) ? clamp((abs(particles_emitter_data._m0[cobject_cb.instances[_767].gpu_particle_emitter].emitter_duration) > 0.0) ? _804 : 0.0, 0.0, 1.0) : 0.0;
        }
        float _840;
        if (abs(cobject_cb.instances[_767].gpu_particles_duration.x) > 0.0)
        {
            _840 = (in_var_AUTO_PIPJIEKO_CIFEPFLO * in_var_AUTO_PIPJIEKO_EIDIDJP) / cobject_cb.instances[_767].gpu_particles_duration.x;
        }
        else
        {
            _840 = 0.0;
        }
        float _857;
        if (cpipeline_cb.constantUInt1_80 == 0u)
        {
            _857 = in_var_AUTO_PIPJIEKO_CIFEPFLO;
        }
        else
        {
            float _856;
            if (cpipeline_cb.constantUInt1_80 == 1u)
            {
                _856 = _811;
            }
            else
            {
                float _855;
                if (cpipeline_cb.constantUInt1_80 == 2u)
                {
                    _855 = in_var_AUTO_PIPJIEKO_IINFNGPI;
                }
                else
                {
                    _855 = (cpipeline_cb.constantUInt1_80 == 3u) ? _840 : 0.0;
                }
                _856 = _855;
            }
            _857 = _856;
        }
        if (_763 == 0u)
        {
            _756 = _857;
        }
        else
        {
            _756 = (_763 == 1u) ? _832 : 0.0;
        }
    }
    float _864 = clamp(_755, 0.0, 1.0);
    bool _865 = _864 < 1.0;
    float _869 = _864 * _864;
    float _875 = spvNMax(dot(_250[_865 ? 0u : (_865 ? 1u : (_865 ? 2u : 3u))], vec4(_869 * _864, _869, _864, 1.0)), 0.0);
    float _882 = clamp(clamp(mix(_747 * _875, _747 - (1.0 - _875), cpipeline_cb.constant1_7), 0.0, 1.0) * 3.0, 0.0, 1.0);
    vec3 _883 = _339 * _388;
    vec3 _887 = _883 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_883)));
    vec3 _891 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _892 = reflect(_891, _887);
    vec4 _895 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _267.w);
    _895.w = 1.0;
    vec4 _897 = cpass_cb.scene_view_projection_transform * _895;
    vec4 _900 = _897 / vec4(_897.w);
    vec2 _903 = (_900.xy * 0.5) + vec2(0.5);
    float _904 = _903.y;
    float _905 = 1.0 - _904;
    float _906 = _903.x;
    vec3 _907 = vec3(_906, _905, _266);
    ivec2 _913 = ivec2(uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)));
    vec2 _923 = vec2(1.0) / vec2(float(uint(_913.x) / 1u), float(uint(_913.y) / 1u));
    bool _939;
    if (cpass_cb.sh_probe_spacing > 0)
    {
        _939 = cpass_cb.ssgi_intensity > 0.5;
    }
    else
    {
        _939 = false;
    }
    vec4 _1287;
    if (_939)
    {
        vec3 _950 = clamp((cpass_cb.scene_view_transform * vec4(_887, 0.0)).xyz, vec3(-1.0), vec3(1.0));
        float _951 = _900.z;
        ivec2 _957 = ivec2(cpass_cb.sh_probe_spacing);
        ivec2 _958 = ivec2(uvec2(vec2(_913) * cpass_cb.frame_to_dynamic_scale.xy));
        vec4 _967 = cpass_cb.scene_view_projection_transform_inv * vec4((_906 * 2.0) - 1.0, (_904 * 2.0) - 1.0, _951, 1.0);
        vec3 _971 = (_967 / vec4(_967.w)).xyz;
        ivec2 _972 = _957 / ivec2(2);
        vec2 _973 = vec2(_957);
        vec2 _974 = vec2(1.0) / _973;
        vec2 _975 = vec2(_972);
        vec2 _978 = vec2(_958);
        vec2 _980 = vec2(1.0) / _978;
        vec2 _982 = (_975 + vec2(0.5)) * _980;
        vec2 _983 = _973 * _980;
        vec2 _985 = ((vec2(-0.5) - _975) * _974) + ((_978 * _974) * vec3(_906, _905, _951).xy);
        ivec2 _987 = ivec2(floor(_985));
        vec3 _277[4];
        for (int _990 = 0; _990 < 4; _990++)
        {
            ivec2 _998 = _987 + _256[_990];
            ivec2 _1000 = _972 + (_957 * _998);
            int _1001 = _1000.x;
            bool _1007;
            if (_1001 >= 0)
            {
                _1007 = _1000.y >= 0;
            }
            else
            {
                _1007 = false;
            }
            bool _1012;
            if (_1007)
            {
                _1012 = _1001 < _958.x;
            }
            else
            {
                _1012 = false;
            }
            bool _1018;
            if (_1012)
            {
                _1018 = _1000.y < _958.y;
            }
            else
            {
                _1018 = false;
            }
            vec4 _1026;
            if (_1018)
            {
                _1026 = texelFetch(depth_sampler, ivec3(_1001, _1000.y, 0).xy, 0);
            }
            else
            {
                _1026 = vec4(1.0);
            }
            vec2 _1030 = clamp(_982 + (_983 * vec2(_998)), vec2(0.0), vec2(1.0));
            vec4 _1040 = cpass_cb.scene_view_projection_transform_inv * vec4((_1030.x * 2.0) - 1.0, ((1.0 - _1030.y) * 2.0) - 1.0, _1026.x, 1.0);
            _277[_990] = (_1040 / vec4(_1040.w)).xyz;
        }
        vec2 _1052;
        _1052 = fract(_985);
        for (int _1055 = 0; _1055 < 2; )
        {
            vec3 _1060 = vec3(_1052.y);
            vec3 _1061 = mix(_277[0], _277[2], _1060);
            vec3 _1063 = mix(_277[1], _277[3], _1060) - _1061;
            float _1068 = clamp(dot(_971 - _1061, _1063) / dot(_1063, _1063), 0.0, 1.0);
            vec3 _1069 = vec3(_1068);
            vec3 _1070 = mix(_277[0], _277[1], _1069);
            vec3 _1072 = mix(_277[2], _277[3], _1069) - _1070;
            _1052 = vec2(_1068, clamp(dot(_971 - _1070, _1072) / dot(_1072, _1072), 0.0, 1.0));
            _1055++;
            continue;
        }
        vec2 _1079 = vec2(_987) + _1052;
        uvec2 _1086 = uvec2(textureSize(ambient_light_tex, 0));
        vec2 _1094 = vec2(1.0) / vec2(float(int(_1086.x)), float(int(_1086.y)));
        uvec2 _1096 = uvec2(ivec2(uvec2(cpass_cb.sh_atlas_size) / uvec2(2u)));
        vec2 _1101 = ((vec2(uvec2(0u) * _1096) + _1079) + vec2(0.5)) * _1094;
        vec2 _1112 = ((vec2(uvec2(1u, 0u) * _1096) + _1079) + vec2(0.5)) * _1094;
        vec2 _1123 = ((vec2(uvec2(1u) * _1096) + _1079) + vec2(0.5)) * _1094;
        vec2 _1134 = ((vec2(uvec2(0u, 1u) * _1096) + _1079) + vec2(0.5)) * _1094;
        mat4 _1142 = transpose(mat4(textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1101, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1112, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1123, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1134, 0.0, 0.0).xy, 0.0)));
        vec4 _1280;
        if (cpass_cb.gi_self_lighting != 0u)
        {
            vec4 _1254 = _1142[0];
            vec4 _1260 = _1142[1];
            vec4 _1266 = _1142[2];
            vec4 _1272 = _1142[3];
            _1280 = spvNMax(vec4(0.0), vec4(_1254.x + (dot(_1254.yzw, _950) * 2.0), _1260.x + (dot(_1260.yzw, _950) * 2.0), _1266.x + (dot(_1266.yzw, _950) * 2.0), _1272.x + (dot(_1272.yzw, _950) * 2.0)));
        }
        else
        {
            vec4 _1149 = _1142[0];
            vec3 _1150 = _1149.yzw;
            float _1151 = length(_1150);
            float _1158 = _1149.x;
            float _1160 = _1151 / spvNMax(1.0000000116860974230803549289703e-07, _1158);
            float _1161 = 2.0 * _1160;
            float _1166 = (1.0 - _1160) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1160);
            vec4 _1175 = _1142[1];
            vec3 _1176 = _1175.yzw;
            float _1177 = length(_1176);
            float _1184 = _1175.x;
            float _1186 = _1177 / spvNMax(1.0000000116860974230803549289703e-07, _1184);
            float _1187 = 2.0 * _1186;
            float _1192 = (1.0 - _1186) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1186);
            vec4 _1201 = _1142[2];
            vec3 _1202 = _1201.yzw;
            float _1203 = length(_1202);
            float _1210 = _1201.x;
            float _1212 = _1203 / spvNMax(1.0000000116860974230803549289703e-07, _1210);
            float _1213 = 2.0 * _1212;
            float _1218 = (1.0 - _1212) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1212);
            vec4 _1227 = _1142[3];
            vec3 _1228 = _1227.yzw;
            float _1229 = length(_1228);
            float _1236 = _1227.x;
            float _1238 = _1229 / spvNMax(1.0000000116860974230803549289703e-07, _1236);
            float _1239 = 2.0 * _1238;
            float _1244 = (1.0 - _1238) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1238);
            _1280 = vec4(_1158 * (_1166 + (((1.0 - _1166) * (_1161 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1150 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1151)), _950)), 0.0, 1.0), 1.0 + _1161))), _1184 * (_1192 + (((1.0 - _1192) * (_1187 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1176 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1177)), _950)), 0.0, 1.0), 1.0 + _1187))), _1210 * (_1218 + (((1.0 - _1218) * (_1213 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1202 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1203)), _950)), 0.0, 1.0), 1.0 + _1213))), _1236 * (_1244 + (((1.0 - _1244) * (_1239 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1228 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1229)), _950)), 0.0, 1.0), 1.0 + _1239))));
        }
        vec3 _1282 = _1280.xyz * 1.0;
        vec4 _1283 = vec4(_1282.x, _1282.y, _1282.z, _748.w);
        _1283.w = _368 * _1280.w;
        _1287 = _1283;
    }
    else
    {
        _1287 = vec4(vec4(0.0, 0.0, 0.0, 1.0).x, vec4(0.0, 0.0, 0.0, 1.0).y, vec4(0.0, 0.0, 0.0, 1.0).z, _748.w);
    }
    vec4 _1295 = textureLod(sampler2D(screenspace_shadowmap, SamplerLinearClamp), vec4((_907.xy / (_923 / cpass_cb.frame_to_dynamic_scale.xy)) * _923, 0.0, 0.0).xy, 0.0);
    vec4 _1299 = _1287 + vec4(_1295.x * 9.9999997473787516355514526367188e-05);
    uvec4 _1312 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _1313 = _1312.x;
    uint _1314 = _1312.y;
    vec3 _1319;
    vec3 _1321;
    vec3 _1323;
    _1319 = vec3(0.0);
    _1321 = vec3(0.0);
    _1323 = vec3(0.0);
    uint _1317;
    vec3 _1320;
    vec3 _1322;
    vec3 _1324;
    for (uint _1316 = _1313, _1325 = 0u; _1325 < _1314; _1316 = _1317, _1319 = _1320, _1321 = _1322, _1323 = _1324, _1325++)
    {
        _1317 = _1316 + 1u;
        uvec4 _1331 = texelFetch(light_indices, int(_1316));
        uint _1332 = _1331.x;
        vec4 _1351;
        if (point_light_infos._m0[_1332].channel_index > (-0.5))
        {
            vec4 _1350;
            if (point_light_infos._m0[_1332].channel_index >= 2.5)
            {
                _1350 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1349;
                if (point_light_infos._m0[_1332].channel_index >= 1.5)
                {
                    _1349 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1349 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1332].channel_index >= 0.5));
                }
                _1350 = _1349;
            }
            _1351 = _1350;
        }
        else
        {
            _1351 = vec4(0.0);
        }
        vec3 _1381 = vec4(point_light_infos._m0[_1332].position, point_light_infos._m0[_1332].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1382 = length(_1381);
        vec3 _1384 = _1381 / vec3(_1382);
        vec3 _1385 = vec4(point_light_infos._m0[_1332].color, point_light_infos._m0[_1332].median_radius).xyz;
        float _1392 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1332].channel_index, 0.0, 1.0));
        float _1397 = (_1382 / (point_light_infos._m0[_1332].median_radius / _1392)) + 1.0;
        float _1398 = _1382 / (point_light_infos._m0[_1332].median_radius * sqrt(dot(abs(_1385), vec3(1.0)) * 2.0));
        float _1403 = clamp(1.0 - (((_1398 * _1398) * _1398) * _1398), 0.0, 1.0);
        vec3 _1410 = (_1385 * spvNMin(10.0, (((0.199999988079071044921875 * _1392) * _1392) * (_1403 * _1403)) / (_1397 * _1397))) * (dot(_1295, _1351) * clamp((dot(-normalize(_373), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1332].position)) - (1.0 - length(_373))) * 2.5, 0.0, 1.0));
        if (length(_1410) > 0.0)
        {
            float _1416 = clamp(dot(_1384, _887), 0.0, 1.0);
            float _1419 = clamp(1.0 - _395, 0.0, 1.0);
            float _1421 = spvNMax(_1419 * _1419, 0.00200000009499490261077880859375);
            float _1422 = _1421 * _1421;
            vec3 _1423 = -_891;
            vec3 _1425 = normalize(_1423 + _1384);
            float _1427 = clamp(dot(_887, _1425), 0.0, 1.0);
            float _1431 = clamp(dot(_1423, _1425), 0.0, 1.0);
            float _1438 = _1421 * 0.5;
            float _1439 = 1.0 - _1438;
            _1320 = _1319 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1431) - 6.9831600189208984375) * _1431)), vec3(1.0), _428) * (_1422 / pow((((_1422 - 1.0) * _1427) * _1427) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1423, _887), 0.0, 1.0) * _1439) + _1438) * ((_1416 * _1439) + _1438)))) * _1416) * vec3(0.25)) * _1410);
            _1322 = _1321 + ((_1410 * _1416) * _381.xyz);
            _1324 = _1323 + _1410;
        }
        else
        {
            _1320 = _1319;
            _1322 = _1321;
            _1324 = _1323;
        }
    }
    uvec4 _1467 = uvec4(cobject_cb.instances[in_var_INSTANCEID / cobject_cb.instance_count].dynamic_light_indices);
    uint _1468 = _1467.x;
    uint _1471 = uint(dynamic_light_infos._m0[_1468].light_type.x);
    uint _1472 = _1467.y;
    uint _1475 = uint(dynamic_light_infos._m0[_1472].light_type.x);
    uint _1476 = _1467.z;
    uint _1479 = uint(dynamic_light_infos._m0[_1476].light_type.x);
    uint _1480 = _1467.w;
    uint _1483 = uint(dynamic_light_infos._m0[_1480].light_type.x);
    vec4 _1877;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1468].shadow_enabled.x > 0.0)
    {
        vec4 _1492 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1875;
        do
        {
            vec4 _1502 = dynamic_light_infos._m0[_1468].light_matrix * _1492;
            vec3 _1559;
            if (_1471 == 2u)
            {
                vec3 _1523 = _1502.xyz;
                vec3 _1525 = normalize(_1523) + vec3(0.0, 0.0, 1.0);
                float _1529 = length(_1523);
                vec3 _1532 = vec3((_1525 / vec3(_1525.z)).xy, _1529);
                float _1533 = _1502.z;
                vec3 _1545;
                if (_1533 > 0.0)
                {
                    _1545 = _1532;
                }
                else
                {
                    _1545 = vec3(normalize(_1532.xy) * 10000000.0, -_1529);
                }
                vec3 _1553 = vec3((_1545.x * 0.5) + 0.5, 0.5 - (_1545.y * 0.5), _1545.z);
                _1553.z = _1545.z * 9.9999997473787516355514526367188e-05;
                if (_1533 < 0.0)
                {
                    _1875 = 0.0;
                    break;
                }
                _1559 = _1553;
            }
            else
            {
                vec3 _1507 = _1502.xyz;
                vec3 _1519;
                if (_1471 == 1u)
                {
                    float _1511 = _1502.z;
                    vec3 _1518 = _1507;
                    _1518.z = _1511 - (((_1511 * dynamic_light_infos._m0[_1468].shadow_scale.z) + 1.0) / _1502.w);
                    _1519 = _1518;
                }
                else
                {
                    _1519 = _1507;
                }
                _1559 = _1519 / vec3(_1502.w);
            }
            float _1668;
            if (dynamic_light_infos._m0[_1468].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1650 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1559.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1559.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1559.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1559.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1468].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1559.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1559.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1468].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1559.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1559.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1468].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1559.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1559.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1468].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1559.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1559.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1468].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1668 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1468].shadow_scale.w * spvNMax(_1650, _1559.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1559.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1468].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1668 = 1.0;
            }
            vec3 _1669 = dFdx(_1559);
            vec3 _1670 = dFdy(_1559);
            vec3 _1684 = _1559 + ((normalize(cross(_1669, _1670)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _266) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw)).x);
            vec2 _1685 = dynamic_light_infos._m0[_1468].shadow_scale.xy * _1668;
            vec2 _1686 = _1684.xy;
            float _1691 = _1684.z;
            float _1770 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1686, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, _1691, 1.0).xy, _1691), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1686 + (vec2(1.0, 0.0) * _1685), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, _1691, 1.0).xy, _1691), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1686 + (vec2(0.5, 0.865999996662139892578125) * _1685), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, _1691, 1.0).xy, _1691), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1686 + (vec2(-0.5, 0.865999996662139892578125) * _1685), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, _1691, 1.0).xy, _1691), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1686 + (vec2(-1.0, -0.0) * _1685), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, _1691, 1.0).xy, _1691), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1686 + (vec2(-0.5, -0.865999996662139892578125) * _1685), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, _1691, 1.0).xy, _1691), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1686 + (vec2(0.5, -0.865999996662139892578125) * _1685), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1468].shadow_atlas_offset_scale.xy, _1691, 1.0).xy, _1691), 0.0);
            float _1771 = _1770 * 0.14285714924335479736328125;
            float _1874;
            if (_1471 == 0u)
            {
                float _1786 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1492.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1788 = transpose(dynamic_light_infos._m0[_1468].light_matrix)[2];
                float _1793 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1802;
                if (_1793 > 0.100000001490116119384765625)
                {
                    _1802 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1802 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1813 = _1492.xyz - ((_1788.xyz / vec3(_1788.z)) * 1000.0);
                float _1837 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1802, _1813), dot(normalize(vec3(-_1802.y, _1802.x, 0.0)), _1813)) + (vec2(_1793, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1786 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1844 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1845 = _1844 - 1.0;
                float _1846 = 1.0 - cpass_cb.clouds_midpoint;
                float _1853 = 2.0 - _1844;
                _1874 = _1771 * mix(1.0, clamp(clamp(_1846 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1837), 0.0, 1.0), _1845)) * pow(clamp(_1846, 0.0, 1.0), _1853)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1837), 0.0, 1.0), _1845) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1853))), 0.0, 1.0) + (_1786 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1874 = _1771;
            }
            _1875 = _1874;
            break;
        } while(false);
        vec4 _1876 = vec4(1.0);
        _1876.x = _1875;
        _1877 = _1876;
    }
    else
    {
        _1877 = vec4(1.0);
    }
    vec4 _2271;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1472].shadow_enabled.x > 0.0)
    {
        vec4 _1886 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2269;
        do
        {
            vec4 _1896 = dynamic_light_infos._m0[_1472].light_matrix * _1886;
            vec3 _1953;
            if (_1475 == 2u)
            {
                vec3 _1917 = _1896.xyz;
                vec3 _1919 = normalize(_1917) + vec3(0.0, 0.0, 1.0);
                float _1923 = length(_1917);
                vec3 _1926 = vec3((_1919 / vec3(_1919.z)).xy, _1923);
                float _1927 = _1896.z;
                vec3 _1939;
                if (_1927 > 0.0)
                {
                    _1939 = _1926;
                }
                else
                {
                    _1939 = vec3(normalize(_1926.xy) * 10000000.0, -_1923);
                }
                vec3 _1947 = vec3((_1939.x * 0.5) + 0.5, 0.5 - (_1939.y * 0.5), _1939.z);
                _1947.z = _1939.z * 9.9999997473787516355514526367188e-05;
                if (_1927 < 0.0)
                {
                    _2269 = 0.0;
                    break;
                }
                _1953 = _1947;
            }
            else
            {
                vec3 _1901 = _1896.xyz;
                vec3 _1913;
                if (_1475 == 1u)
                {
                    float _1905 = _1896.z;
                    vec3 _1912 = _1901;
                    _1912.z = _1905 - (((_1905 * dynamic_light_infos._m0[_1472].shadow_scale.z) + 1.0) / _1896.w);
                    _1913 = _1912;
                }
                else
                {
                    _1913 = _1901;
                }
                _1953 = _1913 / vec3(_1896.w);
            }
            float _2062;
            if (dynamic_light_infos._m0[_1472].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2044 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1953.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1953.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1953.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1953.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1472].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1953.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1953.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1472].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1953.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1953.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1472].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1953.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1953.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1472].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1953.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1953.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1472].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2062 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1472].shadow_scale.w * spvNMax(_2044, _1953.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1953.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1472].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2062 = 1.0;
            }
            vec3 _2063 = dFdx(_1953);
            vec3 _2064 = dFdy(_1953);
            vec3 _2078 = _1953 + ((normalize(cross(_2063, _2064)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _266) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw)).x);
            vec2 _2079 = dynamic_light_infos._m0[_1472].shadow_scale.xy * _2062;
            vec2 _2080 = _2078.xy;
            float _2085 = _2078.z;
            float _2164 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2080, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, _2085, 1.0).xy, _2085), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2080 + (vec2(1.0, 0.0) * _2079), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, _2085, 1.0).xy, _2085), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2080 + (vec2(0.5, 0.865999996662139892578125) * _2079), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, _2085, 1.0).xy, _2085), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2080 + (vec2(-0.5, 0.865999996662139892578125) * _2079), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, _2085, 1.0).xy, _2085), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2080 + (vec2(-1.0, -0.0) * _2079), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, _2085, 1.0).xy, _2085), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2080 + (vec2(-0.5, -0.865999996662139892578125) * _2079), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, _2085, 1.0).xy, _2085), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2080 + (vec2(0.5, -0.865999996662139892578125) * _2079), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1472].shadow_atlas_offset_scale.xy, _2085, 1.0).xy, _2085), 0.0);
            float _2165 = _2164 * 0.14285714924335479736328125;
            float _2268;
            if (_1475 == 0u)
            {
                float _2180 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1886.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2182 = transpose(dynamic_light_infos._m0[_1472].light_matrix)[2];
                float _2187 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2196;
                if (_2187 > 0.100000001490116119384765625)
                {
                    _2196 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2196 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2207 = _1886.xyz - ((_2182.xyz / vec3(_2182.z)) * 1000.0);
                float _2231 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2196, _2207), dot(normalize(vec3(-_2196.y, _2196.x, 0.0)), _2207)) + (vec2(_2187, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2180 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2238 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2239 = _2238 - 1.0;
                float _2240 = 1.0 - cpass_cb.clouds_midpoint;
                float _2247 = 2.0 - _2238;
                _2268 = _2165 * mix(1.0, clamp(clamp(_2240 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2231), 0.0, 1.0), _2239)) * pow(clamp(_2240, 0.0, 1.0), _2247)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2231), 0.0, 1.0), _2239) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2247))), 0.0, 1.0) + (_2180 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2268 = _2165;
            }
            _2269 = _2268;
            break;
        } while(false);
        vec4 _2270 = _1877;
        _2270.y = _2269;
        _2271 = _2270;
    }
    else
    {
        _2271 = _1877;
    }
    vec4 _2665;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1476].shadow_enabled.x > 0.0)
    {
        vec4 _2280 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2663;
        do
        {
            vec4 _2290 = dynamic_light_infos._m0[_1476].light_matrix * _2280;
            vec3 _2347;
            if (_1479 == 2u)
            {
                vec3 _2311 = _2290.xyz;
                vec3 _2313 = normalize(_2311) + vec3(0.0, 0.0, 1.0);
                float _2317 = length(_2311);
                vec3 _2320 = vec3((_2313 / vec3(_2313.z)).xy, _2317);
                float _2321 = _2290.z;
                vec3 _2333;
                if (_2321 > 0.0)
                {
                    _2333 = _2320;
                }
                else
                {
                    _2333 = vec3(normalize(_2320.xy) * 10000000.0, -_2317);
                }
                vec3 _2341 = vec3((_2333.x * 0.5) + 0.5, 0.5 - (_2333.y * 0.5), _2333.z);
                _2341.z = _2333.z * 9.9999997473787516355514526367188e-05;
                if (_2321 < 0.0)
                {
                    _2663 = 0.0;
                    break;
                }
                _2347 = _2341;
            }
            else
            {
                vec3 _2295 = _2290.xyz;
                vec3 _2307;
                if (_1479 == 1u)
                {
                    float _2299 = _2290.z;
                    vec3 _2306 = _2295;
                    _2306.z = _2299 - (((_2299 * dynamic_light_infos._m0[_1476].shadow_scale.z) + 1.0) / _2290.w);
                    _2307 = _2306;
                }
                else
                {
                    _2307 = _2295;
                }
                _2347 = _2307 / vec3(_2290.w);
            }
            float _2456;
            if (dynamic_light_infos._m0[_1476].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2438 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2347.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2347.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2347.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2347.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1476].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2347.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2347.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1476].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2347.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2347.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1476].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2347.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2347.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1476].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2347.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2347.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1476].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2456 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1476].shadow_scale.w * spvNMax(_2438, _2347.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2347.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1476].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2456 = 1.0;
            }
            vec3 _2457 = dFdx(_2347);
            vec3 _2458 = dFdy(_2347);
            vec3 _2472 = _2347 + ((normalize(cross(_2457, _2458)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _266) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw)).x);
            vec2 _2473 = dynamic_light_infos._m0[_1476].shadow_scale.xy * _2456;
            vec2 _2474 = _2472.xy;
            float _2479 = _2472.z;
            float _2558 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2474, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, _2479, 1.0).xy, _2479), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2474 + (vec2(1.0, 0.0) * _2473), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, _2479, 1.0).xy, _2479), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2474 + (vec2(0.5, 0.865999996662139892578125) * _2473), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, _2479, 1.0).xy, _2479), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2474 + (vec2(-0.5, 0.865999996662139892578125) * _2473), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, _2479, 1.0).xy, _2479), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2474 + (vec2(-1.0, -0.0) * _2473), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, _2479, 1.0).xy, _2479), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2474 + (vec2(-0.5, -0.865999996662139892578125) * _2473), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, _2479, 1.0).xy, _2479), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2474 + (vec2(0.5, -0.865999996662139892578125) * _2473), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1476].shadow_atlas_offset_scale.xy, _2479, 1.0).xy, _2479), 0.0);
            float _2559 = _2558 * 0.14285714924335479736328125;
            float _2662;
            if (_1479 == 0u)
            {
                float _2574 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2280.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2576 = transpose(dynamic_light_infos._m0[_1476].light_matrix)[2];
                float _2581 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2590;
                if (_2581 > 0.100000001490116119384765625)
                {
                    _2590 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2590 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2601 = _2280.xyz - ((_2576.xyz / vec3(_2576.z)) * 1000.0);
                float _2625 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2590, _2601), dot(normalize(vec3(-_2590.y, _2590.x, 0.0)), _2601)) + (vec2(_2581, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2574 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2632 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2633 = _2632 - 1.0;
                float _2634 = 1.0 - cpass_cb.clouds_midpoint;
                float _2641 = 2.0 - _2632;
                _2662 = _2559 * mix(1.0, clamp(clamp(_2634 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2625), 0.0, 1.0), _2633)) * pow(clamp(_2634, 0.0, 1.0), _2641)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2625), 0.0, 1.0), _2633) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2641))), 0.0, 1.0) + (_2574 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2662 = _2559;
            }
            _2663 = _2662;
            break;
        } while(false);
        vec4 _2664 = _2271;
        _2664.z = _2663;
        _2665 = _2664;
    }
    else
    {
        _2665 = _2271;
    }
    vec4 _3059;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1480].shadow_enabled.x > 0.0)
    {
        vec4 _2674 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _3057;
        do
        {
            vec4 _2684 = dynamic_light_infos._m0[_1480].light_matrix * _2674;
            vec3 _2741;
            if (_1483 == 2u)
            {
                vec3 _2705 = _2684.xyz;
                vec3 _2707 = normalize(_2705) + vec3(0.0, 0.0, 1.0);
                float _2711 = length(_2705);
                vec3 _2714 = vec3((_2707 / vec3(_2707.z)).xy, _2711);
                float _2715 = _2684.z;
                vec3 _2727;
                if (_2715 > 0.0)
                {
                    _2727 = _2714;
                }
                else
                {
                    _2727 = vec3(normalize(_2714.xy) * 10000000.0, -_2711);
                }
                vec3 _2735 = vec3((_2727.x * 0.5) + 0.5, 0.5 - (_2727.y * 0.5), _2727.z);
                _2735.z = _2727.z * 9.9999997473787516355514526367188e-05;
                if (_2715 < 0.0)
                {
                    _3057 = 0.0;
                    break;
                }
                _2741 = _2735;
            }
            else
            {
                vec3 _2689 = _2684.xyz;
                vec3 _2701;
                if (_1483 == 1u)
                {
                    float _2693 = _2684.z;
                    vec3 _2700 = _2689;
                    _2700.z = _2693 - (((_2693 * dynamic_light_infos._m0[_1480].shadow_scale.z) + 1.0) / _2684.w);
                    _2701 = _2700;
                }
                else
                {
                    _2701 = _2689;
                }
                _2741 = _2701 / vec3(_2684.w);
            }
            float _2850;
            if (dynamic_light_infos._m0[_1480].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2832 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2741.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2741.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2741.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2741.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1480].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2741.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2741.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1480].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2741.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2741.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1480].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2741.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2741.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1480].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2741.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2741.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1480].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2850 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1480].shadow_scale.w * spvNMax(_2832, _2741.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2741.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1480].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2850 = 1.0;
            }
            vec3 _2851 = dFdx(_2741);
            vec3 _2852 = dFdy(_2741);
            vec3 _2866 = _2741 + ((normalize(cross(_2851, _2852)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _266) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw)).x);
            vec2 _2867 = dynamic_light_infos._m0[_1480].shadow_scale.xy * _2850;
            vec2 _2868 = _2866.xy;
            float _2873 = _2866.z;
            float _2952 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2868, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, _2873, 1.0).xy, _2873), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2868 + (vec2(1.0, 0.0) * _2867), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, _2873, 1.0).xy, _2873), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2868 + (vec2(0.5, 0.865999996662139892578125) * _2867), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, _2873, 1.0).xy, _2873), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2868 + (vec2(-0.5, 0.865999996662139892578125) * _2867), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, _2873, 1.0).xy, _2873), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2868 + (vec2(-1.0, -0.0) * _2867), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, _2873, 1.0).xy, _2873), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2868 + (vec2(-0.5, -0.865999996662139892578125) * _2867), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, _2873, 1.0).xy, _2873), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2868 + (vec2(0.5, -0.865999996662139892578125) * _2867), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1480].shadow_atlas_offset_scale.xy, _2873, 1.0).xy, _2873), 0.0);
            float _2953 = _2952 * 0.14285714924335479736328125;
            float _3056;
            if (_1483 == 0u)
            {
                float _2968 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2674.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2970 = transpose(dynamic_light_infos._m0[_1480].light_matrix)[2];
                float _2975 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2984;
                if (_2975 > 0.100000001490116119384765625)
                {
                    _2984 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2984 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2995 = _2674.xyz - ((_2970.xyz / vec3(_2970.z)) * 1000.0);
                float _3019 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2984, _2995), dot(normalize(vec3(-_2984.y, _2984.x, 0.0)), _2995)) + (vec2(_2975, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2968 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _3026 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _3027 = _3026 - 1.0;
                float _3028 = 1.0 - cpass_cb.clouds_midpoint;
                float _3035 = 2.0 - _3026;
                _3056 = _2953 * mix(1.0, clamp(clamp(_3028 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _3019), 0.0, 1.0), _3027)) * pow(clamp(_3028, 0.0, 1.0), _3035)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _3019), 0.0, 1.0), _3027) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _3035))), 0.0, 1.0) + (_2968 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _3056 = _2953;
            }
            _3057 = _3056;
            break;
        } while(false);
        vec4 _3058 = _2665;
        _3058.w = _3057;
        _3059 = _3058;
    }
    else
    {
        _3059 = _2665;
    }
    vec3 _3126;
    vec3 _3127;
    switch (_1471)
    {
        case 0u:
        {
            _3126 = dynamic_light_infos._m0[_1468].light_color.xyz;
            _3127 = -dynamic_light_infos._m0[_1468].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3103 = dynamic_light_infos._m0[_1468].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3104 = length(_3103);
            vec3 _3106 = _3103 / vec3(_3104);
            _3126 = dynamic_light_infos._m0[_1468].light_color.xyz * ((1.0 - clamp(_3104 / dynamic_light_infos._m0[_1468].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1468].light_direction.xyz, _3106) - dynamic_light_infos._m0[_1468].light_direction.w) / (dynamic_light_infos._m0[_1468].light_position.w - dynamic_light_infos._m0[_1468].light_direction.w), 0.0, 1.0));
            _3127 = _3106;
            break;
        }
        case 2u:
        {
            vec3 _3071 = dynamic_light_infos._m0[_1468].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3072 = length(_3071);
            float _3084 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1468].light_position.w, 0.0, 1.0));
            float _3089 = (_3072 / (dynamic_light_infos._m0[_1468].light_color.w / _3084)) + 1.0;
            float _3090 = _3072 / (dynamic_light_infos._m0[_1468].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1468].light_color.xyz), vec3(1.0)) * 2.0));
            float _3095 = clamp(1.0 - (((_3090 * _3090) * _3090) * _3090), 0.0, 1.0);
            _3126 = dynamic_light_infos._m0[_1468].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3084) * _3084) * (_3095 * _3095)) / (_3089 * _3089));
            _3127 = _3071 / vec3(_3072);
            break;
        }
        default:
        {
            _3126 = vec3(0.0);
            _3127 = vec3(0.0);
            break;
        }
    }
    vec3 _3129 = normalize(_373);
    vec3 _3131 = -_3129;
    float _3133 = 1.0 - length(_373);
    vec3 _3139 = _3126 * (_3059.x * clamp((dot(_3131, -_3127) - _3133) * 2.5, 0.0, 1.0));
    vec3 _3191;
    vec3 _3192;
    vec3 _3193;
    if (length(_3139) > 0.0)
    {
        float _3145 = clamp(dot(_3127, _887), 0.0, 1.0);
        float _3148 = clamp(1.0 - _395, 0.0, 1.0);
        float _3150 = spvNMax(_3148 * _3148, 0.00200000009499490261077880859375);
        float _3151 = _3150 * _3150;
        vec3 _3152 = -_891;
        vec3 _3154 = normalize(_3152 + _3127);
        float _3156 = clamp(dot(_887, _3154), 0.0, 1.0);
        float _3160 = clamp(dot(_3152, _3154), 0.0, 1.0);
        float _3167 = _3150 * 0.5;
        float _3168 = 1.0 - _3167;
        _3191 = _1319 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3160) - 6.9831600189208984375) * _3160)), vec3(1.0), _428) * (_3151 / pow((((_3151 - 1.0) * _3156) * _3156) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3152, _887), 0.0, 1.0) * _3168) + _3167) * ((_3145 * _3168) + _3167)))) * _3145) * vec3(0.25)) * _3139);
        _3192 = _1321 + ((_3139 * _3145) * _381.xyz);
        _3193 = _1323 + _3139;
    }
    else
    {
        _3191 = _1319;
        _3192 = _1321;
        _3193 = _1323;
    }
    vec3 _3260;
    vec3 _3261;
    switch (_1475)
    {
        case 0u:
        {
            _3260 = dynamic_light_infos._m0[_1472].light_color.xyz;
            _3261 = -dynamic_light_infos._m0[_1472].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3237 = dynamic_light_infos._m0[_1472].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3238 = length(_3237);
            vec3 _3240 = _3237 / vec3(_3238);
            _3260 = dynamic_light_infos._m0[_1472].light_color.xyz * ((1.0 - clamp(_3238 / dynamic_light_infos._m0[_1472].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1472].light_direction.xyz, _3240) - dynamic_light_infos._m0[_1472].light_direction.w) / (dynamic_light_infos._m0[_1472].light_position.w - dynamic_light_infos._m0[_1472].light_direction.w), 0.0, 1.0));
            _3261 = _3240;
            break;
        }
        case 2u:
        {
            vec3 _3205 = dynamic_light_infos._m0[_1472].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3206 = length(_3205);
            float _3218 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1472].light_position.w, 0.0, 1.0));
            float _3223 = (_3206 / (dynamic_light_infos._m0[_1472].light_color.w / _3218)) + 1.0;
            float _3224 = _3206 / (dynamic_light_infos._m0[_1472].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1472].light_color.xyz), vec3(1.0)) * 2.0));
            float _3229 = clamp(1.0 - (((_3224 * _3224) * _3224) * _3224), 0.0, 1.0);
            _3260 = dynamic_light_infos._m0[_1472].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3218) * _3218) * (_3229 * _3229)) / (_3223 * _3223));
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
    vec3 _3269 = _3260 * (_3059.y * clamp((dot(_3131, -_3261) - _3133) * 2.5, 0.0, 1.0));
    vec3 _3321;
    vec3 _3322;
    vec3 _3323;
    if (length(_3269) > 0.0)
    {
        float _3275 = clamp(dot(_3261, _887), 0.0, 1.0);
        float _3278 = clamp(1.0 - _395, 0.0, 1.0);
        float _3280 = spvNMax(_3278 * _3278, 0.00200000009499490261077880859375);
        float _3281 = _3280 * _3280;
        vec3 _3282 = -_891;
        vec3 _3284 = normalize(_3282 + _3261);
        float _3286 = clamp(dot(_887, _3284), 0.0, 1.0);
        float _3290 = clamp(dot(_3282, _3284), 0.0, 1.0);
        float _3297 = _3280 * 0.5;
        float _3298 = 1.0 - _3297;
        _3321 = _3191 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3290) - 6.9831600189208984375) * _3290)), vec3(1.0), _428) * (_3281 / pow((((_3281 - 1.0) * _3286) * _3286) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3282, _887), 0.0, 1.0) * _3298) + _3297) * ((_3275 * _3298) + _3297)))) * _3275) * vec3(0.25)) * _3269);
        _3322 = _3192 + ((_3269 * _3275) * _381.xyz);
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
    switch (_1479)
    {
        case 0u:
        {
            _3390 = dynamic_light_infos._m0[_1476].light_color.xyz;
            _3391 = -dynamic_light_infos._m0[_1476].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3367 = dynamic_light_infos._m0[_1476].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3368 = length(_3367);
            vec3 _3370 = _3367 / vec3(_3368);
            _3390 = dynamic_light_infos._m0[_1476].light_color.xyz * ((1.0 - clamp(_3368 / dynamic_light_infos._m0[_1476].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1476].light_direction.xyz, _3370) - dynamic_light_infos._m0[_1476].light_direction.w) / (dynamic_light_infos._m0[_1476].light_position.w - dynamic_light_infos._m0[_1476].light_direction.w), 0.0, 1.0));
            _3391 = _3370;
            break;
        }
        case 2u:
        {
            vec3 _3335 = dynamic_light_infos._m0[_1476].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3336 = length(_3335);
            float _3348 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1476].light_position.w, 0.0, 1.0));
            float _3353 = (_3336 / (dynamic_light_infos._m0[_1476].light_color.w / _3348)) + 1.0;
            float _3354 = _3336 / (dynamic_light_infos._m0[_1476].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1476].light_color.xyz), vec3(1.0)) * 2.0));
            float _3359 = clamp(1.0 - (((_3354 * _3354) * _3354) * _3354), 0.0, 1.0);
            _3390 = dynamic_light_infos._m0[_1476].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3348) * _3348) * (_3359 * _3359)) / (_3353 * _3353));
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
    vec3 _3399 = _3390 * (_3059.z * clamp((dot(_3131, -_3391) - _3133) * 2.5, 0.0, 1.0));
    vec3 _3451;
    vec3 _3452;
    vec3 _3453;
    if (length(_3399) > 0.0)
    {
        float _3405 = clamp(dot(_3391, _887), 0.0, 1.0);
        float _3408 = clamp(1.0 - _395, 0.0, 1.0);
        float _3410 = spvNMax(_3408 * _3408, 0.00200000009499490261077880859375);
        float _3411 = _3410 * _3410;
        vec3 _3412 = -_891;
        vec3 _3414 = normalize(_3412 + _3391);
        float _3416 = clamp(dot(_887, _3414), 0.0, 1.0);
        float _3420 = clamp(dot(_3412, _3414), 0.0, 1.0);
        float _3427 = _3410 * 0.5;
        float _3428 = 1.0 - _3427;
        _3451 = _3321 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3420) - 6.9831600189208984375) * _3420)), vec3(1.0), _428) * (_3411 / pow((((_3411 - 1.0) * _3416) * _3416) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3412, _887), 0.0, 1.0) * _3428) + _3427) * ((_3405 * _3428) + _3427)))) * _3405) * vec3(0.25)) * _3399);
        _3452 = _3322 + ((_3399 * _3405) * _381.xyz);
        _3453 = _3323 + _3399;
    }
    else
    {
        _3451 = _3321;
        _3452 = _3322;
        _3453 = _3323;
    }
    vec3 _3520;
    vec3 _3521;
    switch (_1483)
    {
        case 0u:
        {
            _3520 = dynamic_light_infos._m0[_1480].light_color.xyz;
            _3521 = -dynamic_light_infos._m0[_1480].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3497 = dynamic_light_infos._m0[_1480].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3498 = length(_3497);
            vec3 _3500 = _3497 / vec3(_3498);
            _3520 = dynamic_light_infos._m0[_1480].light_color.xyz * ((1.0 - clamp(_3498 / dynamic_light_infos._m0[_1480].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1480].light_direction.xyz, _3500) - dynamic_light_infos._m0[_1480].light_direction.w) / (dynamic_light_infos._m0[_1480].light_position.w - dynamic_light_infos._m0[_1480].light_direction.w), 0.0, 1.0));
            _3521 = _3500;
            break;
        }
        case 2u:
        {
            vec3 _3465 = dynamic_light_infos._m0[_1480].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3466 = length(_3465);
            float _3478 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1480].light_position.w, 0.0, 1.0));
            float _3483 = (_3466 / (dynamic_light_infos._m0[_1480].light_color.w / _3478)) + 1.0;
            float _3484 = _3466 / (dynamic_light_infos._m0[_1480].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1480].light_color.xyz), vec3(1.0)) * 2.0));
            float _3489 = clamp(1.0 - (((_3484 * _3484) * _3484) * _3484), 0.0, 1.0);
            _3520 = dynamic_light_infos._m0[_1480].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3478) * _3478) * (_3489 * _3489)) / (_3483 * _3483));
            _3521 = _3465 / vec3(_3466);
            break;
        }
        default:
        {
            _3520 = vec3(0.0);
            _3521 = vec3(0.0);
            break;
        }
    }
    vec3 _3529 = _3520 * (_3059.w * clamp((dot(_3131, -_3521) - _3133) * 2.5, 0.0, 1.0));
    vec3 _3581;
    vec3 _3582;
    vec3 _3583;
    if (length(_3529) > 0.0)
    {
        float _3535 = clamp(dot(_3521, _887), 0.0, 1.0);
        float _3538 = clamp(1.0 - _395, 0.0, 1.0);
        float _3540 = spvNMax(_3538 * _3538, 0.00200000009499490261077880859375);
        float _3541 = _3540 * _3540;
        vec3 _3542 = -_891;
        vec3 _3544 = normalize(_3542 + _3521);
        float _3546 = clamp(dot(_887, _3544), 0.0, 1.0);
        float _3550 = clamp(dot(_3542, _3544), 0.0, 1.0);
        float _3557 = _3540 * 0.5;
        float _3558 = 1.0 - _3557;
        _3581 = _3452 + ((_3529 * _3535) * _381.xyz);
        _3582 = _3451 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3550) - 6.9831600189208984375) * _3550)), vec3(1.0), _428) * (_3541 / pow((((_3541 - 1.0) * _3546) * _3546) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3542, _887), 0.0, 1.0) * _3558) + _3557) * ((_3535 * _3558) + _3557)))) * _3535) * vec3(0.25)) * _3529);
        _3583 = _3453 + _3529;
    }
    else
    {
        _3581 = _3452;
        _3582 = _3451;
        _3583 = _3453;
    }
    vec3 _3706;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _3596 = _1299.w;
        float _3597 = clamp(_395, 0.0, 1.0);
        float _3600 = sqrt(clamp(1.0 - _3596, 0.0, 1.0));
        float _3601 = 1.0 - _3597;
        float _3602 = _3601 * _3601;
        float _3605 = clamp(exp((-2.2999999523162841796875) * _3602), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _3606 = dot(_3129, _892);
        float _3612 = sqrt(clamp(1.0 - (_3606 * _3606), 0.0, 1.0));
        float _3614 = _3605 - (_3606 * _3600);
        float _3615 = _3612 * _3600;
        vec2 _3616 = vec2(_3614, _3615);
        float _3618 = _3600 - (_3606 * _3605);
        float _3619 = _3612 * _3605;
        vec2 _3620 = vec2(_3618, _3619);
        float _3624 = sqrt(clamp(1.0 - (_3600 * _3600), 0.0, 1.0));
        float _3641 = sqrt(clamp(1.0 - (_3605 * _3605), 0.0, 1.0));
        vec4 _3667 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_887, -_891)), _3597, 0.0, 0.0).xy, 0.0);
        float _3680 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _3602));
        vec3 _3705 = _3582 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_892, 0.0)).xyz, _3680).xyz, _3680).xyz * (vec3(_3667.x) + (_428 * _3667.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3583 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * (_3596 * ((2.0 * ((acos(clamp(_3614 / (_3624 * sqrt(dot(_3616, _3616))), -1.0, 1.0)) - (acos(clamp((_3614 * _3600) / (_3615 * _3624), -1.0, 1.0)) * _3600)) + (acos(clamp(_3618 / (_3641 * sqrt(dot(_3620, _3620))), -1.0, 1.0)) - (acos(clamp((_3618 * _3605) / (_3619 * _3641), -1.0, 1.0)) * _3605)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _3605)))));
        _3706 = _3705;
    }
    else
    {
        _3706 = _3582;
    }
    vec3 _3718 = _381.xyz;
    vec3 _3749;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _3749 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_373, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3583 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _3718) * _1299.w) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _3749 = vec3(0.0);
    }
    vec3 _3754 = (_3581 * cpass_cb.indirect_light_multiplier) + (_703 * 20.0);
    vec3 _3770 = (_3581 + _703) + (((_1299.xyz * _3718) + _3749) + spvNMax(vec3(0.0), _3706 / vec3(spvNMax(10.0, spvNMax(_3706.x, spvNMax(_3706.y, _3706.z))) * 0.100000001490116119384765625)));
    vec4 _3771 = vec4(_3770.x, _3770.y, _3770.z, vec4(0.0).w);
    _3771.w = _882;
    vec3 _3773 = in_var_TEXCOORD0.xyz - in_var_AUTO_CEOBGMGP_GEBKIEDD;
    vec4 _3776 = vec4(_3773.x, _3773.y, _3773.z, _267.w);
    _3776.w = 1.0;
    vec4 _3778 = cpass_cb.last_view_projection_transform * _3776;
    vec2 _3784 = ((_3778 / vec4(_3778.w)).xy * 0.5) + vec2(0.5);
    out_var_SV_TARGET = _3771;
    out_var_SV_TARGET2 = vec4(_3754, _882);
    out_var_SV_TARGET1 = vec4(((_907 - vec3(_3784.x, 1.0 - _3784.y, _266)) * vec3(ivec3(ivec2(uvec2((cpass_cb.frame_resolution.xy * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))), 0))).xy, 0.0, 0.0);
}

