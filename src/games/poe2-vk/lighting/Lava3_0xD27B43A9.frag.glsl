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

struct InstanceData
{
    mat4 world_transform;
    mat4 prev_world_transform;
    mat4 particle_emitter_transform;
    mat4 trail_emitter_transform;
    ivec4 dynamic_light_indices;
    ivec4 animation_matrices_indices;
    ivec4 prev_animation_matrices_indices;
    vec4 particle_emitter_pos;
    vec4 dynamic_AnimationData;
    vec2 gpu_particles_duration;
    uint object_random_seed;
    float gpu_particle_burst;
    ivec2 synced_random_seed;
    float gpu_particle_seed;
    uint gpu_particle_count;
    float start_time;
    uint gpu_particle_culling_priority;
    uint gpu_particle_pass_count;
    uint gpu_particle_emitter;
    float flip_tangent;
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

const ivec2 _243[4] = ivec2[](ivec2(0), ivec2(1, 0), ivec2(0, 1), ivec2(1));
float _255;
vec4 _256;
float _262;
vec4 _263;

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
    vec4 alpha_test_desc;
    ivec4 constant_trackC_0;
    uint frame_material_id;
    uint constant_bool_1;
    uint constant_bool_2;
    uint constant_bool_0;
    float mult_const_0;
    uint gpu_particle_dyn_culling;
    int constant_trackG_2;
    float constant1_12;
    float add_const_1;
    float constant1_13;
    float constant1_14;
    int constant_trackG_1;
    float constant1_4;
    int constant_trackG_0;
    float brightness_0;
    float saturation_0;
    float constant1_3;
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

layout(set = 2, binding = 37, std430) readonly buffer type_StructuredBuffer_LightInfo
{
    LightInfo _m0[];
} dynamic_light_infos;

layout(set = 2, binding = 38, std430) readonly buffer type_StructuredBuffer_PointLightInfo
{
    PointLightInfo _m0[];
} point_light_infos;

layout(set = 2, binding = 39, std430) readonly buffer type_StructuredBuffer_LUTData
{
    LUTData _m0[];
} spline_lut;

layout(set = 0, binding = 0) uniform sampler SamplerLinearWrap;
layout(set = 0, binding = 1) uniform sampler SamplerLinearClamp;
layout(set = 0, binding = 7) uniform sampler SamplerDynamicWrap;
layout(set = 0, binding = 8) uniform sampler SamplerLinearWrapNoBias;
layout(set = 0, binding = 9) uniform sampler SamplerLinearClampNoBias;
layout(set = 0, binding = 15) uniform samplerShadow SamplerDepth;
layout(set = 2, binding = 24) uniform textureCube diffuse_cube;
layout(set = 2, binding = 25) uniform textureCube specular_cube;
layout(set = 2, binding = 26) uniform texture2D environment_ggx_sampler;
layout(set = 2, binding = 27) uniform texture2D ambient_light_tex;
layout(set = 2, binding = 28) uniform texture2D screenspace_shadowmap;
layout(set = 2, binding = 29) uniform texture2D noise_sampler;
layout(set = 2, binding = 30) uniform texture2D tex_shadow_map_atlas;
layout(set = 2, binding = 31) uniform texture2D depth_sampler;
layout(set = 2, binding = 32) uniform texture2D muddle_texture_0;
layout(set = 2, binding = 33) uniform texture2D texture_object_1;
layout(set = 2, binding = 34) uniform texture2D input_texture_0;
layout(set = 2, binding = 35) uniform utexture2D light_lookup;
layout(set = 2, binding = 36) uniform usamplerBuffer light_indices;

layout(location = 0) flat in uint in_var_INSTANCEID;
layout(location = 1) in vec4 in_var_TEXCOORD0;
layout(location = 2) in vec2 in_var_TEXCOORD1;
layout(location = 3) in vec3 in_var_TEXCOORD5;
layout(location = 4) in vec3 in_var_TEXCOORD6;
layout(location = 5) in vec3 in_var_TEXCOORD7;
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
    uint _290 = in_var_INSTANCEID / cobject_cb.instance_count;
    vec4 _306 = texture(sampler2D(muddle_texture_0, SamplerLinearWrap), (in_var_TEXCOORD1 * 1.0) + (vec2(-0.02999999932944774627685546875, 0.02999999932944774627685546875) * cpass_cb.time));
    vec2 _310 = in_var_TEXCOORD1 + ((_306.xy - vec2(0.5)) * 0.0500000007450580596923828125);
    mat3 _311 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _325 = ((vec2(textureLod(sampler2D(texture_object_1, SamplerDynamicWrap), vec4(_310, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _326 = vec3(_325.x, _325.y, vec3(0.0).z);
    vec2 _327 = _325.xy;
    _326.z = sqrt(spvNMax(1.0 - dot(_327, _327), 0.0));
    vec3 _333 = _311 * _326;
    vec4 _339 = texture(sampler2D(texture_object_1, SamplerDynamicWrap), _310);
    float _340 = _339.z;
    vec3 _345 = vec3(pow(spvNMax(abs(_340), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_333 / vec3(length(_333) + 1.0000000116860974230803549289703e-07));
    vec4 _348 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _310);
    vec3 _349 = _348.xyz;
    vec3 _351 = vec3(_348.w);
    vec3 _353 = clamp(mix(_349, vec3(0.0), _351), vec3(0.0), vec3(1.0));
    vec2 _359 = ((vec2(_339.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _360 = vec3(_359.x, _359.y, vec3(0.0).z);
    vec2 _361 = _359.xy;
    _360.z = sqrt(spvNMax(1.0 - dot(_361, _361), 0.0));
    float _367 = _339.w;
    float _376 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _377 = cos(_376);
    vec3 _392 = (((_349 * _377) + (cross(vec3(0.57735002040863037109375), _349) * sin(_376))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _349)) * (1.0 - _377))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _400 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_392, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _392, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _351), vec3(0.0), vec3(1.0));
    bool _403 = cpipeline_cb.constant_trackG_0 < 0;
    float _405 = clamp(_340, 0.0, 1.0) * 127.0;
    int _409 = int(spvNMax(trunc(_405), 0.0) + 0.5);
    int _414 = int(spvNMin(trunc(_405 + 1.0), 127.0) + 0.5);
    float _432;
    if (_403)
    {
        _432 = 0.0;
    }
    else
    {
        uint _418 = uint(cpipeline_cb.constant_trackG_0);
        int _419 = _409 / 2;
        _432 = ((_409 - 2 * (_409 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_418].value[_419] & 65535u).x : unpackHalf2x16((spline_lut._m0[_418].value[_419] >> 16u) & 65535u).x;
    }
    float _450;
    if (_403)
    {
        _450 = 0.0;
    }
    else
    {
        uint _436 = uint(cpipeline_cb.constant_trackG_0);
        int _437 = _414 / 2;
        _450 = ((_414 - 2 * (_414 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_436].value[_437] & 65535u).x : unpackHalf2x16((spline_lut._m0[_436].value[_437] >> 16u) & 65535u).x;
    }
    float _451 = fract(_405);
    bool _457 = cpipeline_cb.constant_trackG_1 < 0;
    float _475;
    if (_457)
    {
        _475 = 0.0;
    }
    else
    {
        uint _461 = uint(cpipeline_cb.constant_trackG_1);
        int _462 = _409 / 2;
        _475 = ((_409 - 2 * (_409 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_461].value[_462] & 65535u).x : unpackHalf2x16((spline_lut._m0[_461].value[_462] >> 16u) & 65535u).x;
    }
    float _493;
    if (_457)
    {
        _493 = 0.0;
    }
    else
    {
        uint _479 = uint(cpipeline_cb.constant_trackG_1);
        int _480 = _414 / 2;
        _493 = ((_414 - 2 * (_414 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_479].value[_480] & 65535u).x : unpackHalf2x16((spline_lut._m0[_479].value[_480] >> 16u) & 65535u).x;
    }
    uvec3 _517 = (floatBitsToUint(vec3((cpipeline_cb.constant_bool_1 != 0u) ? clamp(uintBitsToFloat((uint(cobject_cb.instances[_290].synced_random_seed.x) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0) : clamp(uintBitsToFloat((cobject_cb.instances[_290].object_random_seed >> 9u) | 1065353216u) - 1.0, 0.0, 1.0), 0.1555101871490478515625, 0.46372699737548828125)) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _518 = _517.y;
    uint _519 = _517.z;
    uint _522 = _517.x + (_518 * _519);
    uint _524 = _518 + (_519 * _522);
    uvec3 _527 = uvec3(_522, _524, _519 + (_522 * _524));
    uvec3 _529 = _527 ^ (_527 >> uvec3(16u));
    uint _530 = _529.y;
    uint _531 = _529.z;
    float _557 = spvNMax(cpipeline_cb.constant1_12, 9.9999997473787516355514526367188e-05);
    bool _560 = cpass_cb.depth_sampler_type > 0.5;
    bool _564;
    if (_560)
    {
        _564 = cpass_cb.depth_sampler_type < 1.5;
    }
    else
    {
        _564 = false;
    }
    float _636;
    if (_564)
    {
        vec4 _568 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _256.w);
        _568.w = 1.0;
        vec4 _572 = cpass_cb.scene_view_projection_transform * _568;
        vec2 _578 = ((_572 / vec4(_572.w)).xy * 0.5) + vec2(0.5);
        float _579 = _578.y;
        vec2 _581 = _578;
        _581.y = 1.0 - _579;
        uvec2 _593 = uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)) / uvec2(uint(cpass_cb.pass_downscale));
        vec4 _621 = cpass_cb.scene_view_projection_transform_inv * vec4((_578.x * 2.0) - 1.0, (_579 * 2.0) - 1.0, textureLod(sampler2D(depth_sampler, SamplerLinearClamp), vec4(_581 * (vec2(ivec2((vec2(_593) * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))) / vec2(ivec2(_593))), 0.0, -0.5).xy, -0.5).x, 1.0);
        float _632 = length((_621 / vec4(_621.w)).xyz - cpass_cb.scene_camera_position) - length(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
        if (_632 < 0.0)
        {
            discard;
        }
        _636 = _632;
    }
    else
    {
        _636 = 0.0;
    }
    float _643;
    if (abs(_557) > 0.0)
    {
        _643 = _636 / _557;
    }
    else
    {
        _643 = 0.0;
    }
    float _650 = clamp(pow(spvNMax(abs(_643), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_13), 0.0, 1.0) * 127.0;
    int _654 = int(spvNMax(trunc(_650), 0.0) + 0.5);
    int _659 = int(spvNMin(trunc(_650 + 1.0), 127.0) + 0.5);
    bool _660 = cpipeline_cb.constant_trackG_2 < 0;
    float _678;
    if (_660)
    {
        _678 = 0.0;
    }
    else
    {
        uint _664 = uint(cpipeline_cb.constant_trackG_2);
        int _665 = _654 / 2;
        _678 = ((_654 - 2 * (_654 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_664].value[_665] & 65535u).x : unpackHalf2x16((spline_lut._m0[_664].value[_665] >> 16u) & 65535u).x;
    }
    float _696;
    if (_660)
    {
        _696 = 0.0;
    }
    else
    {
        uint _682 = uint(cpipeline_cb.constant_trackG_2);
        int _683 = _659 / 2;
        _696 = ((_659 - 2 * (_659 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_682].value[_683] & 65535u).x : unpackHalf2x16((spline_lut._m0[_682].value[_683] >> 16u) & 65535u).x;
    }
    float _699 = mix(_678, _696, fract(_650)) - clamp(-(((((0.2989999949932098388671875 * _359.x) + (0.58700001239776611328125 * _359.y)) - 0.5) * 2.0) * mix(0.439999997615814208984375, 0.439999997615814208984375, clamp(uintBitsToFloat(((_530 + (_531 * (_529.x + (_530 * _531)))) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))), 0.0, 1.0);
    float _709 = clamp(((spvNMax(vec3(mix(_432, _450, _451), _262, _262), vec3(0.0)) + spvNMax(vec3(mix(_475, _493, _451), _262, _262), vec3(0.0))) + vec3((cpipeline_cb.constant_bool_2 != 0u) ? spvNMax(_699, 0.0) : clamp(_699, 0.0, 1.0))).x, 0.0, 1.0) * 127.0;
    int _714 = int(spvNMax(trunc(_709), 0.0) + 0.5);
    int _719 = int(spvNMin(trunc(_709 + 1.0), 127.0) + 0.5);
    bool _720 = cpipeline_cb.constant_trackC_0.x < 0;
    float _738;
    if (_720)
    {
        _738 = 0.0;
    }
    else
    {
        uint _724 = uint(cpipeline_cb.constant_trackC_0.x);
        int _725 = _714 / 2;
        _738 = ((_714 - 2 * (_714 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_724].value[_725] & 65535u).x : unpackHalf2x16((spline_lut._m0[_724].value[_725] >> 16u) & 65535u).x;
    }
    float _756;
    if (_720)
    {
        _756 = 0.0;
    }
    else
    {
        uint _742 = uint(cpipeline_cb.constant_trackC_0.x);
        int _743 = _719 / 2;
        _756 = ((_719 - 2 * (_719 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_742].value[_743] & 65535u).x : unpackHalf2x16((spline_lut._m0[_742].value[_743] >> 16u) & 65535u).x;
    }
    float _757 = fract(_709);
    bool _760 = cpipeline_cb.constant_trackC_0.y < 0;
    float _778;
    if (_760)
    {
        _778 = 0.0;
    }
    else
    {
        uint _764 = uint(cpipeline_cb.constant_trackC_0.y);
        int _765 = _714 / 2;
        _778 = ((_714 - 2 * (_714 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_764].value[_765] & 65535u).x : unpackHalf2x16((spline_lut._m0[_764].value[_765] >> 16u) & 65535u).x;
    }
    float _796;
    if (_760)
    {
        _796 = 0.0;
    }
    else
    {
        uint _782 = uint(cpipeline_cb.constant_trackC_0.y);
        int _783 = _719 / 2;
        _796 = ((_719 - 2 * (_719 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_782].value[_783] & 65535u).x : unpackHalf2x16((spline_lut._m0[_782].value[_783] >> 16u) & 65535u).x;
    }
    bool _799 = cpipeline_cb.constant_trackC_0.z < 0;
    float _817;
    if (_799)
    {
        _817 = 0.0;
    }
    else
    {
        uint _803 = uint(cpipeline_cb.constant_trackC_0.z);
        int _804 = _714 / 2;
        _817 = ((_714 - 2 * (_714 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_803].value[_804] & 65535u).x : unpackHalf2x16((spline_lut._m0[_803].value[_804] >> 16u) & 65535u).x;
    }
    float _835;
    if (_799)
    {
        _835 = 0.0;
    }
    else
    {
        uint _821 = uint(cpipeline_cb.constant_trackC_0.z);
        int _822 = _719 / 2;
        _835 = ((_719 - 2 * (_719 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_821].value[_822] & 65535u).x : unpackHalf2x16((spline_lut._m0[_821].value[_822] >> 16u) & 65535u).x;
    }
    bool _838 = cpipeline_cb.constant_trackC_0.w < 0;
    float _856;
    if (_838)
    {
        _856 = 0.0;
    }
    else
    {
        uint _842 = uint(cpipeline_cb.constant_trackC_0.w);
        int _843 = _714 / 2;
        _856 = ((_714 - 2 * (_714 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_842].value[_843] & 65535u).x : unpackHalf2x16((spline_lut._m0[_842].value[_843] >> 16u) & 65535u).x;
    }
    float _874;
    if (_838)
    {
        _874 = 0.0;
    }
    else
    {
        uint _860 = uint(cpipeline_cb.constant_trackC_0.w);
        int _861 = _719 / 2;
        _874 = ((_719 - 2 * (_719 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_860].value[_861] & 65535u).x : unpackHalf2x16((spline_lut._m0[_860].value[_861] >> 16u) & 65535u).x;
    }
    float _875 = mix(_856, _874, _757);
    vec4 _883;
    _883.w = _340;
    bool _888;
    if (_560)
    {
        _888 = cpass_cb.depth_sampler_type < 1.5;
    }
    else
    {
        _888 = false;
    }
    float _960;
    if (_888)
    {
        vec4 _892 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _256.w);
        _892.w = 1.0;
        vec4 _896 = cpass_cb.scene_view_projection_transform * _892;
        vec2 _902 = ((_896 / vec4(_896.w)).xy * 0.5) + vec2(0.5);
        float _903 = _902.y;
        vec2 _905 = _902;
        _905.y = 1.0 - _903;
        uvec2 _917 = uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)) / uvec2(uint(cpass_cb.pass_downscale));
        vec4 _945 = cpass_cb.scene_view_projection_transform_inv * vec4((_902.x * 2.0) - 1.0, (_903 * 2.0) - 1.0, textureLod(sampler2D(depth_sampler, SamplerLinearClamp), vec4(_905 * (vec2(ivec2((vec2(_917) * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))) / vec2(ivec2(_917))), 0.0, -0.5).xy, -0.5).x, 1.0);
        float _956 = length((_945 / vec4(_945.w)).xyz - cpass_cb.scene_camera_position) - length(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
        if (_956 < 0.0)
        {
            discard;
        }
        _960 = _956;
    }
    else
    {
        _960 = 0.0;
    }
    float _961 = abs(20.0);
    float _967;
    if (_961 > 0.0)
    {
        _967 = _960 * 0.0500000007450580596923828125;
    }
    else
    {
        _967 = 0.0;
    }
    float _968 = spvNMax(0.001000000047497451305389404296875, 0.800000011920928955078125);
    float _971 = clamp((2.0 / _968) - 1.0, -100000.0, 100000.0);
    float _984 = 0.5 + ((pow(clamp((1.0 - spvNMax(0.5, _967)) * 2.0, 0.0, 1.0), _971) * (-0.5)) + (pow(clamp(spvNMin(0.5, _967) * 2.0, 0.0, 1.0), _971) * 0.5));
    vec3 _992 = spvNMin((vec4(mix(_738, _756, _757), mix(_778, _796, _757), mix(_817, _835, _757), _875).xyz * vec3(spvNMax(_875, 0.0))) * 5.0, vec3(100.0)) + ((vec3(1.0 - clamp(isnan(_984) ? 0.5 : _984, 0.0, 1.0)) * vec3(1.0, 0.02537130005657672882080078125, 0.0)) * 3.0);
    vec3 _993 = _311 * _360;
    if ((1.00100004673004150390625 - cpipeline_cb.alpha_test_desc.y) < 0.0)
    {
        discard;
    }
    vec3 _1003 = _993 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_993)));
    vec3 _1007 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _1008 = reflect(_1007, _1003);
    vec4 _1011 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _256.w);
    _1011.w = 1.0;
    vec4 _1013 = cpass_cb.scene_view_projection_transform * _1011;
    vec4 _1016 = _1013 / vec4(_1013.w);
    vec2 _1019 = (_1016.xy * 0.5) + vec2(0.5);
    float _1020 = _1019.y;
    float _1021 = 1.0 - _1020;
    float _1022 = _1019.x;
    ivec2 _1029 = ivec2(uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)));
    vec2 _1039 = vec2(1.0) / vec2(float(uint(_1029.x) / 1u), float(uint(_1029.y) / 1u));
    bool _1055;
    if (cpass_cb.sh_probe_spacing > 0)
    {
        _1055 = cpass_cb.ssgi_intensity > 0.5;
    }
    else
    {
        _1055 = false;
    }
    vec4 _1403;
    if (_1055)
    {
        vec3 _1066 = clamp((cpass_cb.scene_view_transform * vec4(_1003, 0.0)).xyz, vec3(-1.0), vec3(1.0));
        float _1067 = _1016.z;
        ivec2 _1073 = ivec2(cpass_cb.sh_probe_spacing);
        ivec2 _1074 = ivec2(uvec2(vec2(_1029) * cpass_cb.frame_to_dynamic_scale.xy));
        vec4 _1083 = cpass_cb.scene_view_projection_transform_inv * vec4((_1022 * 2.0) - 1.0, (_1020 * 2.0) - 1.0, _1067, 1.0);
        vec3 _1087 = (_1083 / vec4(_1083.w)).xyz;
        ivec2 _1088 = _1073 / ivec2(2);
        vec2 _1089 = vec2(_1073);
        vec2 _1090 = vec2(1.0) / _1089;
        vec2 _1091 = vec2(_1088);
        vec2 _1094 = vec2(_1074);
        vec2 _1096 = vec2(1.0) / _1094;
        vec2 _1098 = (_1091 + vec2(0.5)) * _1096;
        vec2 _1099 = _1089 * _1096;
        vec2 _1101 = ((vec2(-0.5) - _1091) * _1090) + ((_1094 * _1090) * vec3(_1022, _1021, _1067).xy);
        ivec2 _1103 = ivec2(floor(_1101));
        vec3 _267[4];
        for (int _1106 = 0; _1106 < 4; _1106++)
        {
            ivec2 _1114 = _1103 + _243[_1106];
            ivec2 _1116 = _1088 + (_1073 * _1114);
            int _1117 = _1116.x;
            bool _1123;
            if (_1117 >= 0)
            {
                _1123 = _1116.y >= 0;
            }
            else
            {
                _1123 = false;
            }
            bool _1128;
            if (_1123)
            {
                _1128 = _1117 < _1074.x;
            }
            else
            {
                _1128 = false;
            }
            bool _1134;
            if (_1128)
            {
                _1134 = _1116.y < _1074.y;
            }
            else
            {
                _1134 = false;
            }
            vec4 _1142;
            if (_1134)
            {
                _1142 = texelFetch(depth_sampler, ivec3(_1117, _1116.y, 0).xy, 0);
            }
            else
            {
                _1142 = vec4(1.0);
            }
            vec2 _1146 = clamp(_1098 + (_1099 * vec2(_1114)), vec2(0.0), vec2(1.0));
            vec4 _1156 = cpass_cb.scene_view_projection_transform_inv * vec4((_1146.x * 2.0) - 1.0, ((1.0 - _1146.y) * 2.0) - 1.0, _1142.x, 1.0);
            _267[_1106] = (_1156 / vec4(_1156.w)).xyz;
        }
        vec2 _1168;
        _1168 = fract(_1101);
        for (int _1171 = 0; _1171 < 2; )
        {
            vec3 _1176 = vec3(_1168.y);
            vec3 _1177 = mix(_267[0], _267[2], _1176);
            vec3 _1179 = mix(_267[1], _267[3], _1176) - _1177;
            float _1184 = clamp(dot(_1087 - _1177, _1179) / dot(_1179, _1179), 0.0, 1.0);
            vec3 _1185 = vec3(_1184);
            vec3 _1186 = mix(_267[0], _267[1], _1185);
            vec3 _1188 = mix(_267[2], _267[3], _1185) - _1186;
            _1168 = vec2(_1184, clamp(dot(_1087 - _1186, _1188) / dot(_1188, _1188), 0.0, 1.0));
            _1171++;
            continue;
        }
        vec2 _1195 = vec2(_1103) + _1168;
        uvec2 _1202 = uvec2(textureSize(ambient_light_tex, 0));
        vec2 _1210 = vec2(1.0) / vec2(float(int(_1202.x)), float(int(_1202.y)));
        uvec2 _1212 = uvec2(ivec2(uvec2(cpass_cb.sh_atlas_size) / uvec2(2u)));
        vec2 _1217 = ((vec2(uvec2(0u) * _1212) + _1195) + vec2(0.5)) * _1210;
        vec2 _1228 = ((vec2(uvec2(1u, 0u) * _1212) + _1195) + vec2(0.5)) * _1210;
        vec2 _1239 = ((vec2(uvec2(1u) * _1212) + _1195) + vec2(0.5)) * _1210;
        vec2 _1250 = ((vec2(uvec2(0u, 1u) * _1212) + _1195) + vec2(0.5)) * _1210;
        mat4 _1258 = transpose(mat4(textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1217, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1228, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1239, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_1250, 0.0, 0.0).xy, 0.0)));
        vec4 _1396;
        if (cpass_cb.gi_self_lighting != 0u)
        {
            vec4 _1370 = _1258[0];
            vec4 _1376 = _1258[1];
            vec4 _1382 = _1258[2];
            vec4 _1388 = _1258[3];
            _1396 = spvNMax(vec4(0.0), vec4(_1370.x + (dot(_1370.yzw, _1066) * 2.0), _1376.x + (dot(_1376.yzw, _1066) * 2.0), _1382.x + (dot(_1382.yzw, _1066) * 2.0), _1388.x + (dot(_1388.yzw, _1066) * 2.0)));
        }
        else
        {
            vec4 _1265 = _1258[0];
            vec3 _1266 = _1265.yzw;
            float _1267 = length(_1266);
            float _1274 = _1265.x;
            float _1276 = _1267 / spvNMax(1.0000000116860974230803549289703e-07, _1274);
            float _1277 = 2.0 * _1276;
            float _1282 = (1.0 - _1276) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1276);
            vec4 _1291 = _1258[1];
            vec3 _1292 = _1291.yzw;
            float _1293 = length(_1292);
            float _1300 = _1291.x;
            float _1302 = _1293 / spvNMax(1.0000000116860974230803549289703e-07, _1300);
            float _1303 = 2.0 * _1302;
            float _1308 = (1.0 - _1302) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1302);
            vec4 _1317 = _1258[2];
            vec3 _1318 = _1317.yzw;
            float _1319 = length(_1318);
            float _1326 = _1317.x;
            float _1328 = _1319 / spvNMax(1.0000000116860974230803549289703e-07, _1326);
            float _1329 = 2.0 * _1328;
            float _1334 = (1.0 - _1328) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1328);
            vec4 _1343 = _1258[3];
            vec3 _1344 = _1343.yzw;
            float _1345 = length(_1344);
            float _1352 = _1343.x;
            float _1354 = _1345 / spvNMax(1.0000000116860974230803549289703e-07, _1352);
            float _1355 = 2.0 * _1354;
            float _1360 = (1.0 - _1354) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1354);
            _1396 = vec4(_1274 * (_1282 + (((1.0 - _1282) * (_1277 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1266 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1267)), _1066)), 0.0, 1.0), 1.0 + _1277))), _1300 * (_1308 + (((1.0 - _1308) * (_1303 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1292 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1293)), _1066)), 0.0, 1.0), 1.0 + _1303))), _1326 * (_1334 + (((1.0 - _1334) * (_1329 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1318 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1319)), _1066)), 0.0, 1.0), 1.0 + _1329))), _1352 * (_1360 + (((1.0 - _1360) * (_1355 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1344 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1345)), _1066)), 0.0, 1.0), 1.0 + _1355))));
        }
        vec3 _1398 = _1396.xyz * 1.0;
        vec4 _1399 = vec4(_1398.x, _1398.y, _1398.z, _883.w);
        _1399.w = _340 * _1396.w;
        _1403 = _1399;
    }
    else
    {
        _1403 = vec4(vec3(0.0).x, vec3(0.0).y, vec3(0.0).z, _883.w);
    }
    vec4 _1411 = textureLod(sampler2D(screenspace_shadowmap, SamplerLinearClamp), vec4((vec3(_1022, _1021, _255).xy / (_1039 / cpass_cb.frame_to_dynamic_scale.xy)) * _1039, 0.0, 0.0).xy, 0.0);
    vec4 _1415 = _1403 + vec4(_1411.x * 9.9999997473787516355514526367188e-05);
    uvec4 _1428 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _1429 = _1428.x;
    uint _1430 = _1428.y;
    vec3 _1435;
    vec3 _1437;
    vec3 _1439;
    _1435 = vec3(0.0);
    _1437 = vec3(0.0);
    _1439 = vec3(0.0);
    uint _1433;
    vec3 _1436;
    vec3 _1438;
    vec3 _1440;
    for (uint _1432 = _1429, _1441 = 0u; _1441 < _1430; _1432 = _1433, _1435 = _1436, _1437 = _1438, _1439 = _1440, _1441++)
    {
        _1433 = _1432 + 1u;
        uvec4 _1447 = texelFetch(light_indices, int(_1432));
        uint _1448 = _1447.x;
        vec4 _1467;
        if (point_light_infos._m0[_1448].channel_index > (-0.5))
        {
            vec4 _1466;
            if (point_light_infos._m0[_1448].channel_index >= 2.5)
            {
                _1466 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1465;
                if (point_light_infos._m0[_1448].channel_index >= 1.5)
                {
                    _1465 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1465 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1448].channel_index >= 0.5));
                }
                _1466 = _1465;
            }
            _1467 = _1466;
        }
        else
        {
            _1467 = vec4(0.0);
        }
        vec3 _1497 = vec4(point_light_infos._m0[_1448].position, point_light_infos._m0[_1448].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1498 = length(_1497);
        vec3 _1500 = _1497 / vec3(_1498);
        vec3 _1501 = vec4(point_light_infos._m0[_1448].color, point_light_infos._m0[_1448].median_radius).xyz;
        float _1508 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1448].channel_index, 0.0, 1.0));
        float _1513 = (_1498 / (point_light_infos._m0[_1448].median_radius / _1508)) + 1.0;
        float _1514 = _1498 / (point_light_infos._m0[_1448].median_radius * sqrt(dot(abs(_1501), vec3(1.0)) * 2.0));
        float _1519 = clamp(1.0 - (((_1514 * _1514) * _1514) * _1514), 0.0, 1.0);
        vec3 _1526 = (_1501 * spvNMin(10.0, (((0.199999988079071044921875 * _1508) * _1508) * (_1519 * _1519)) / (_1513 * _1513))) * (dot(_1411, _1467) * clamp((dot(-normalize(_345), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1448].position)) - (1.0 - length(_345))) * 2.5, 0.0, 1.0));
        if (length(_1526) > 0.0)
        {
            float _1532 = clamp(dot(_1500, _1003), 0.0, 1.0);
            float _1535 = clamp(1.0 - _367, 0.0, 1.0);
            float _1537 = spvNMax(_1535 * _1535, 0.00200000009499490261077880859375);
            float _1538 = _1537 * _1537;
            vec3 _1539 = -_1007;
            vec3 _1541 = normalize(_1539 + _1500);
            float _1543 = clamp(dot(_1003, _1541), 0.0, 1.0);
            float _1547 = clamp(dot(_1539, _1541), 0.0, 1.0);
            float _1554 = _1537 * 0.5;
            float _1555 = 1.0 - _1554;
            _1436 = _1435 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1547) - 6.9831600189208984375) * _1547)), vec3(1.0), _400) * (_1538 / pow((((_1538 - 1.0) * _1543) * _1543) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1539, _1003), 0.0, 1.0) * _1555) + _1554) * ((_1532 * _1555) + _1554)))) * _1532) * vec3(0.25)) * _1526);
            _1438 = _1437 + ((_1526 * _1532) * _353.xyz);
            _1440 = _1439 + _1526;
        }
        else
        {
            _1436 = _1435;
            _1438 = _1437;
            _1440 = _1439;
        }
    }
    uvec4 _1580 = uvec4(cobject_cb.instances[_290].dynamic_light_indices);
    uint _1581 = _1580.x;
    uint _1584 = uint(dynamic_light_infos._m0[_1581].light_type.x);
    uint _1585 = _1580.y;
    uint _1588 = uint(dynamic_light_infos._m0[_1585].light_type.x);
    uint _1589 = _1580.z;
    uint _1592 = uint(dynamic_light_infos._m0[_1589].light_type.x);
    uint _1593 = _1580.w;
    uint _1596 = uint(dynamic_light_infos._m0[_1593].light_type.x);
    vec4 _1975;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1581].shadow_enabled.x > 0.0)
    {
        vec4 _1605 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1973;
        do
        {
            vec4 _1615 = dynamic_light_infos._m0[_1581].light_matrix * _1605;
            vec3 _1672;
            if (_1584 == 2u)
            {
                vec3 _1636 = _1615.xyz;
                vec3 _1638 = normalize(_1636) + vec3(0.0, 0.0, 1.0);
                float _1642 = length(_1636);
                vec3 _1645 = vec3((_1638 / vec3(_1638.z)).xy, _1642);
                float _1646 = _1615.z;
                vec3 _1658;
                if (_1646 > 0.0)
                {
                    _1658 = _1645;
                }
                else
                {
                    _1658 = vec3(normalize(_1645.xy) * 10000000.0, -_1642);
                }
                vec3 _1666 = vec3((_1658.x * 0.5) + 0.5, 0.5 - (_1658.y * 0.5), _1658.z);
                _1666.z = _1658.z * 9.9999997473787516355514526367188e-05;
                if (_1646 < 0.0)
                {
                    _1973 = 0.0;
                    break;
                }
                _1672 = _1666;
            }
            else
            {
                vec3 _1620 = _1615.xyz;
                vec3 _1632;
                if (_1584 == 1u)
                {
                    float _1624 = _1615.z;
                    vec3 _1631 = _1620;
                    _1631.z = _1624 - (((_1624 * dynamic_light_infos._m0[_1581].shadow_scale.z) + 1.0) / _1615.w);
                    _1632 = _1631;
                }
                else
                {
                    _1632 = _1620;
                }
                _1672 = _1632 / vec3(_1615.w);
            }
            float _1781;
            if (dynamic_light_infos._m0[_1581].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1763 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1672.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1672.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1672.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1672.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1581].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1672.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1672.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1581].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1672.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1672.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1581].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1672.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1672.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1581].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1672.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1672.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1581].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1781 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1581].shadow_scale.w * spvNMax(_1763, _1672.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1672.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1581].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1781 = 1.0;
            }
            vec2 _1782 = dynamic_light_infos._m0[_1581].shadow_scale.xy * _1781;
            float _1868 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1672.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, _1672.z, 1.0).xy, _1672.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1672.xy + (vec2(1.0, 0.0) * _1782), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, _1672.z, 1.0).xy, _1672.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1672.xy + (vec2(0.5, 0.865999996662139892578125) * _1782), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, _1672.z, 1.0).xy, _1672.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1672.xy + (vec2(-0.5, 0.865999996662139892578125) * _1782), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, _1672.z, 1.0).xy, _1672.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1672.xy + (vec2(-1.0, -0.0) * _1782), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, _1672.z, 1.0).xy, _1672.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1672.xy + (vec2(-0.5, -0.865999996662139892578125) * _1782), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, _1672.z, 1.0).xy, _1672.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1672.xy + (vec2(0.5, -0.865999996662139892578125) * _1782), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1581].shadow_atlas_offset_scale.xy, _1672.z, 1.0).xy, _1672.z), 0.0);
            float _1869 = _1868 * 0.14285714924335479736328125;
            float _1972;
            if (_1584 == 0u)
            {
                float _1884 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1605.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1886 = transpose(dynamic_light_infos._m0[_1581].light_matrix)[2];
                float _1891 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1900;
                if (_1891 > 0.100000001490116119384765625)
                {
                    _1900 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1900 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1911 = _1605.xyz - ((_1886.xyz / vec3(_1886.z)) * 1000.0);
                float _1935 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1900, _1911), dot(normalize(vec3(-_1900.y, _1900.x, 0.0)), _1911)) + (vec2(_1891, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1884 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1942 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1943 = _1942 - 1.0;
                float _1944 = 1.0 - cpass_cb.clouds_midpoint;
                float _1951 = 2.0 - _1942;
                _1972 = _1869 * mix(1.0, clamp(clamp(_1944 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1935), 0.0, 1.0), _1943)) * pow(clamp(_1944, 0.0, 1.0), _1951)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1935), 0.0, 1.0), _1943) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1951))), 0.0, 1.0) + (_1884 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1972 = _1869;
            }
            _1973 = _1972;
            break;
        } while(false);
        vec4 _1974 = vec4(1.0);
        _1974.x = _1973;
        _1975 = _1974;
    }
    else
    {
        _1975 = vec4(1.0);
    }
    vec4 _2354;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1585].shadow_enabled.x > 0.0)
    {
        vec4 _1984 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2352;
        do
        {
            vec4 _1994 = dynamic_light_infos._m0[_1585].light_matrix * _1984;
            vec3 _2051;
            if (_1588 == 2u)
            {
                vec3 _2015 = _1994.xyz;
                vec3 _2017 = normalize(_2015) + vec3(0.0, 0.0, 1.0);
                float _2021 = length(_2015);
                vec3 _2024 = vec3((_2017 / vec3(_2017.z)).xy, _2021);
                float _2025 = _1994.z;
                vec3 _2037;
                if (_2025 > 0.0)
                {
                    _2037 = _2024;
                }
                else
                {
                    _2037 = vec3(normalize(_2024.xy) * 10000000.0, -_2021);
                }
                vec3 _2045 = vec3((_2037.x * 0.5) + 0.5, 0.5 - (_2037.y * 0.5), _2037.z);
                _2045.z = _2037.z * 9.9999997473787516355514526367188e-05;
                if (_2025 < 0.0)
                {
                    _2352 = 0.0;
                    break;
                }
                _2051 = _2045;
            }
            else
            {
                vec3 _1999 = _1994.xyz;
                vec3 _2011;
                if (_1588 == 1u)
                {
                    float _2003 = _1994.z;
                    vec3 _2010 = _1999;
                    _2010.z = _2003 - (((_2003 * dynamic_light_infos._m0[_1585].shadow_scale.z) + 1.0) / _1994.w);
                    _2011 = _2010;
                }
                else
                {
                    _2011 = _1999;
                }
                _2051 = _2011 / vec3(_1994.w);
            }
            float _2160;
            if (dynamic_light_infos._m0[_1585].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2142 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2051.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2051.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2051.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2051.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1585].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2051.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2051.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1585].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2051.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2051.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1585].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2051.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2051.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1585].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2051.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2051.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1585].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2160 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1585].shadow_scale.w * spvNMax(_2142, _2051.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2051.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1585].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2160 = 1.0;
            }
            vec2 _2161 = dynamic_light_infos._m0[_1585].shadow_scale.xy * _2160;
            float _2247 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2051.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, _2051.z, 1.0).xy, _2051.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2051.xy + (vec2(1.0, 0.0) * _2161), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, _2051.z, 1.0).xy, _2051.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2051.xy + (vec2(0.5, 0.865999996662139892578125) * _2161), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, _2051.z, 1.0).xy, _2051.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2051.xy + (vec2(-0.5, 0.865999996662139892578125) * _2161), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, _2051.z, 1.0).xy, _2051.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2051.xy + (vec2(-1.0, -0.0) * _2161), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, _2051.z, 1.0).xy, _2051.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2051.xy + (vec2(-0.5, -0.865999996662139892578125) * _2161), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, _2051.z, 1.0).xy, _2051.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2051.xy + (vec2(0.5, -0.865999996662139892578125) * _2161), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1585].shadow_atlas_offset_scale.xy, _2051.z, 1.0).xy, _2051.z), 0.0);
            float _2248 = _2247 * 0.14285714924335479736328125;
            float _2351;
            if (_1588 == 0u)
            {
                float _2263 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1984.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2265 = transpose(dynamic_light_infos._m0[_1585].light_matrix)[2];
                float _2270 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2279;
                if (_2270 > 0.100000001490116119384765625)
                {
                    _2279 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2279 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2290 = _1984.xyz - ((_2265.xyz / vec3(_2265.z)) * 1000.0);
                float _2314 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2279, _2290), dot(normalize(vec3(-_2279.y, _2279.x, 0.0)), _2290)) + (vec2(_2270, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2263 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2321 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2322 = _2321 - 1.0;
                float _2323 = 1.0 - cpass_cb.clouds_midpoint;
                float _2330 = 2.0 - _2321;
                _2351 = _2248 * mix(1.0, clamp(clamp(_2323 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2314), 0.0, 1.0), _2322)) * pow(clamp(_2323, 0.0, 1.0), _2330)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2314), 0.0, 1.0), _2322) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2330))), 0.0, 1.0) + (_2263 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2351 = _2248;
            }
            _2352 = _2351;
            break;
        } while(false);
        vec4 _2353 = _1975;
        _2353.y = _2352;
        _2354 = _2353;
    }
    else
    {
        _2354 = _1975;
    }
    vec4 _2733;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1589].shadow_enabled.x > 0.0)
    {
        vec4 _2363 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2731;
        do
        {
            vec4 _2373 = dynamic_light_infos._m0[_1589].light_matrix * _2363;
            vec3 _2430;
            if (_1592 == 2u)
            {
                vec3 _2394 = _2373.xyz;
                vec3 _2396 = normalize(_2394) + vec3(0.0, 0.0, 1.0);
                float _2400 = length(_2394);
                vec3 _2403 = vec3((_2396 / vec3(_2396.z)).xy, _2400);
                float _2404 = _2373.z;
                vec3 _2416;
                if (_2404 > 0.0)
                {
                    _2416 = _2403;
                }
                else
                {
                    _2416 = vec3(normalize(_2403.xy) * 10000000.0, -_2400);
                }
                vec3 _2424 = vec3((_2416.x * 0.5) + 0.5, 0.5 - (_2416.y * 0.5), _2416.z);
                _2424.z = _2416.z * 9.9999997473787516355514526367188e-05;
                if (_2404 < 0.0)
                {
                    _2731 = 0.0;
                    break;
                }
                _2430 = _2424;
            }
            else
            {
                vec3 _2378 = _2373.xyz;
                vec3 _2390;
                if (_1592 == 1u)
                {
                    float _2382 = _2373.z;
                    vec3 _2389 = _2378;
                    _2389.z = _2382 - (((_2382 * dynamic_light_infos._m0[_1589].shadow_scale.z) + 1.0) / _2373.w);
                    _2390 = _2389;
                }
                else
                {
                    _2390 = _2378;
                }
                _2430 = _2390 / vec3(_2373.w);
            }
            float _2539;
            if (dynamic_light_infos._m0[_1589].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2521 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2430.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2430.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2430.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2430.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1589].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2430.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2430.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1589].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2430.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2430.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1589].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2430.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2430.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1589].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2430.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2430.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1589].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2539 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1589].shadow_scale.w * spvNMax(_2521, _2430.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2430.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1589].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2539 = 1.0;
            }
            vec2 _2540 = dynamic_light_infos._m0[_1589].shadow_scale.xy * _2539;
            float _2626 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2430.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, _2430.z, 1.0).xy, _2430.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2430.xy + (vec2(1.0, 0.0) * _2540), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, _2430.z, 1.0).xy, _2430.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2430.xy + (vec2(0.5, 0.865999996662139892578125) * _2540), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, _2430.z, 1.0).xy, _2430.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2430.xy + (vec2(-0.5, 0.865999996662139892578125) * _2540), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, _2430.z, 1.0).xy, _2430.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2430.xy + (vec2(-1.0, -0.0) * _2540), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, _2430.z, 1.0).xy, _2430.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2430.xy + (vec2(-0.5, -0.865999996662139892578125) * _2540), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, _2430.z, 1.0).xy, _2430.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2430.xy + (vec2(0.5, -0.865999996662139892578125) * _2540), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1589].shadow_atlas_offset_scale.xy, _2430.z, 1.0).xy, _2430.z), 0.0);
            float _2627 = _2626 * 0.14285714924335479736328125;
            float _2730;
            if (_1592 == 0u)
            {
                float _2642 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2363.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2644 = transpose(dynamic_light_infos._m0[_1589].light_matrix)[2];
                float _2649 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2658;
                if (_2649 > 0.100000001490116119384765625)
                {
                    _2658 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2658 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2669 = _2363.xyz - ((_2644.xyz / vec3(_2644.z)) * 1000.0);
                float _2693 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2658, _2669), dot(normalize(vec3(-_2658.y, _2658.x, 0.0)), _2669)) + (vec2(_2649, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2642 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2700 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2701 = _2700 - 1.0;
                float _2702 = 1.0 - cpass_cb.clouds_midpoint;
                float _2709 = 2.0 - _2700;
                _2730 = _2627 * mix(1.0, clamp(clamp(_2702 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2693), 0.0, 1.0), _2701)) * pow(clamp(_2702, 0.0, 1.0), _2709)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2693), 0.0, 1.0), _2701) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2709))), 0.0, 1.0) + (_2642 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2730 = _2627;
            }
            _2731 = _2730;
            break;
        } while(false);
        vec4 _2732 = _2354;
        _2732.z = _2731;
        _2733 = _2732;
    }
    else
    {
        _2733 = _2354;
    }
    vec4 _3112;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1593].shadow_enabled.x > 0.0)
    {
        vec4 _2742 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _3110;
        do
        {
            vec4 _2752 = dynamic_light_infos._m0[_1593].light_matrix * _2742;
            vec3 _2809;
            if (_1596 == 2u)
            {
                vec3 _2773 = _2752.xyz;
                vec3 _2775 = normalize(_2773) + vec3(0.0, 0.0, 1.0);
                float _2779 = length(_2773);
                vec3 _2782 = vec3((_2775 / vec3(_2775.z)).xy, _2779);
                float _2783 = _2752.z;
                vec3 _2795;
                if (_2783 > 0.0)
                {
                    _2795 = _2782;
                }
                else
                {
                    _2795 = vec3(normalize(_2782.xy) * 10000000.0, -_2779);
                }
                vec3 _2803 = vec3((_2795.x * 0.5) + 0.5, 0.5 - (_2795.y * 0.5), _2795.z);
                _2803.z = _2795.z * 9.9999997473787516355514526367188e-05;
                if (_2783 < 0.0)
                {
                    _3110 = 0.0;
                    break;
                }
                _2809 = _2803;
            }
            else
            {
                vec3 _2757 = _2752.xyz;
                vec3 _2769;
                if (_1596 == 1u)
                {
                    float _2761 = _2752.z;
                    vec3 _2768 = _2757;
                    _2768.z = _2761 - (((_2761 * dynamic_light_infos._m0[_1593].shadow_scale.z) + 1.0) / _2752.w);
                    _2769 = _2768;
                }
                else
                {
                    _2769 = _2757;
                }
                _2809 = _2769 / vec3(_2752.w);
            }
            float _2918;
            if (dynamic_light_infos._m0[_1593].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2900 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2809.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2809.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2809.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2809.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1593].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2809.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2809.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1593].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2809.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2809.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1593].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2809.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2809.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1593].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2809.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2809.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1593].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2918 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1593].shadow_scale.w * spvNMax(_2900, _2809.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2809.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1593].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2918 = 1.0;
            }
            vec2 _2919 = dynamic_light_infos._m0[_1593].shadow_scale.xy * _2918;
            float _3005 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2809.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, _2809.z, 1.0).xy, _2809.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2809.xy + (vec2(1.0, 0.0) * _2919), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, _2809.z, 1.0).xy, _2809.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2809.xy + (vec2(0.5, 0.865999996662139892578125) * _2919), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, _2809.z, 1.0).xy, _2809.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2809.xy + (vec2(-0.5, 0.865999996662139892578125) * _2919), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, _2809.z, 1.0).xy, _2809.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2809.xy + (vec2(-1.0, -0.0) * _2919), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, _2809.z, 1.0).xy, _2809.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2809.xy + (vec2(-0.5, -0.865999996662139892578125) * _2919), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, _2809.z, 1.0).xy, _2809.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2809.xy + (vec2(0.5, -0.865999996662139892578125) * _2919), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1593].shadow_atlas_offset_scale.xy, _2809.z, 1.0).xy, _2809.z), 0.0);
            float _3006 = _3005 * 0.14285714924335479736328125;
            float _3109;
            if (_1596 == 0u)
            {
                float _3021 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2742.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _3023 = transpose(dynamic_light_infos._m0[_1593].light_matrix)[2];
                float _3028 = length(cpass_cb.clouds_velocity.xy);
                vec3 _3037;
                if (_3028 > 0.100000001490116119384765625)
                {
                    _3037 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _3037 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _3048 = _2742.xyz - ((_3023.xyz / vec3(_3023.z)) * 1000.0);
                float _3072 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_3037, _3048), dot(normalize(vec3(-_3037.y, _3037.x, 0.0)), _3048)) + (vec2(_3028, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_3021 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _3079 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _3080 = _3079 - 1.0;
                float _3081 = 1.0 - cpass_cb.clouds_midpoint;
                float _3088 = 2.0 - _3079;
                _3109 = _3006 * mix(1.0, clamp(clamp(_3081 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _3072), 0.0, 1.0), _3080)) * pow(clamp(_3081, 0.0, 1.0), _3088)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _3072), 0.0, 1.0), _3080) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _3088))), 0.0, 1.0) + (_3021 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _3109 = _3006;
            }
            _3110 = _3109;
            break;
        } while(false);
        vec4 _3111 = _2733;
        _3111.w = _3110;
        _3112 = _3111;
    }
    else
    {
        _3112 = _2733;
    }
    vec3 _3179;
    vec3 _3180;
    switch (_1584)
    {
        case 0u:
        {
            _3179 = dynamic_light_infos._m0[_1581].light_color.xyz;
            _3180 = -dynamic_light_infos._m0[_1581].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3156 = dynamic_light_infos._m0[_1581].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3157 = length(_3156);
            vec3 _3159 = _3156 / vec3(_3157);
            _3179 = dynamic_light_infos._m0[_1581].light_color.xyz * ((1.0 - clamp(_3157 / dynamic_light_infos._m0[_1581].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1581].light_direction.xyz, _3159) - dynamic_light_infos._m0[_1581].light_direction.w) / (dynamic_light_infos._m0[_1581].light_position.w - dynamic_light_infos._m0[_1581].light_direction.w), 0.0, 1.0));
            _3180 = _3159;
            break;
        }
        case 2u:
        {
            vec3 _3124 = dynamic_light_infos._m0[_1581].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3125 = length(_3124);
            float _3137 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1581].light_position.w, 0.0, 1.0));
            float _3142 = (_3125 / (dynamic_light_infos._m0[_1581].light_color.w / _3137)) + 1.0;
            float _3143 = _3125 / (dynamic_light_infos._m0[_1581].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1581].light_color.xyz), vec3(1.0)) * 2.0));
            float _3148 = clamp(1.0 - (((_3143 * _3143) * _3143) * _3143), 0.0, 1.0);
            _3179 = dynamic_light_infos._m0[_1581].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3137) * _3137) * (_3148 * _3148)) / (_3142 * _3142));
            _3180 = _3124 / vec3(_3125);
            break;
        }
        default:
        {
            _3179 = vec3(0.0);
            _3180 = vec3(0.0);
            break;
        }
    }
    vec3 _3182 = normalize(_345);
    vec3 _3184 = -_3182;
    float _3186 = 1.0 - length(_345);
    vec3 _3192 = _3179 * (_3112.x * clamp((dot(_3184, -_3180) - _3186) * 2.5, 0.0, 1.0));
    vec3 _3244;
    vec3 _3245;
    vec3 _3246;
    if (length(_3192) > 0.0)
    {
        float _3198 = clamp(dot(_3180, _1003), 0.0, 1.0);
        float _3201 = clamp(1.0 - _367, 0.0, 1.0);
        float _3203 = spvNMax(_3201 * _3201, 0.00200000009499490261077880859375);
        float _3204 = _3203 * _3203;
        vec3 _3205 = -_1007;
        vec3 _3207 = normalize(_3205 + _3180);
        float _3209 = clamp(dot(_1003, _3207), 0.0, 1.0);
        float _3213 = clamp(dot(_3205, _3207), 0.0, 1.0);
        float _3220 = _3203 * 0.5;
        float _3221 = 1.0 - _3220;
        _3244 = _1435 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3213) - 6.9831600189208984375) * _3213)), vec3(1.0), _400) * (_3204 / pow((((_3204 - 1.0) * _3209) * _3209) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3205, _1003), 0.0, 1.0) * _3221) + _3220) * ((_3198 * _3221) + _3220)))) * _3198) * vec3(0.25)) * _3192);
        _3245 = _1437 + ((_3192 * _3198) * _353.xyz);
        _3246 = _1439 + _3192;
    }
    else
    {
        _3244 = _1435;
        _3245 = _1437;
        _3246 = _1439;
    }
    vec3 _3313;
    vec3 _3314;
    switch (_1588)
    {
        case 0u:
        {
            _3313 = dynamic_light_infos._m0[_1585].light_color.xyz;
            _3314 = -dynamic_light_infos._m0[_1585].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3290 = dynamic_light_infos._m0[_1585].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3291 = length(_3290);
            vec3 _3293 = _3290 / vec3(_3291);
            _3313 = dynamic_light_infos._m0[_1585].light_color.xyz * ((1.0 - clamp(_3291 / dynamic_light_infos._m0[_1585].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1585].light_direction.xyz, _3293) - dynamic_light_infos._m0[_1585].light_direction.w) / (dynamic_light_infos._m0[_1585].light_position.w - dynamic_light_infos._m0[_1585].light_direction.w), 0.0, 1.0));
            _3314 = _3293;
            break;
        }
        case 2u:
        {
            vec3 _3258 = dynamic_light_infos._m0[_1585].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3259 = length(_3258);
            float _3271 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1585].light_position.w, 0.0, 1.0));
            float _3276 = (_3259 / (dynamic_light_infos._m0[_1585].light_color.w / _3271)) + 1.0;
            float _3277 = _3259 / (dynamic_light_infos._m0[_1585].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1585].light_color.xyz), vec3(1.0)) * 2.0));
            float _3282 = clamp(1.0 - (((_3277 * _3277) * _3277) * _3277), 0.0, 1.0);
            _3313 = dynamic_light_infos._m0[_1585].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3271) * _3271) * (_3282 * _3282)) / (_3276 * _3276));
            _3314 = _3258 / vec3(_3259);
            break;
        }
        default:
        {
            _3313 = vec3(0.0);
            _3314 = vec3(0.0);
            break;
        }
    }
    vec3 _3322 = _3313 * (_3112.y * clamp((dot(_3184, -_3314) - _3186) * 2.5, 0.0, 1.0));
    vec3 _3374;
    vec3 _3375;
    vec3 _3376;
    if (length(_3322) > 0.0)
    {
        float _3328 = clamp(dot(_3314, _1003), 0.0, 1.0);
        float _3331 = clamp(1.0 - _367, 0.0, 1.0);
        float _3333 = spvNMax(_3331 * _3331, 0.00200000009499490261077880859375);
        float _3334 = _3333 * _3333;
        vec3 _3335 = -_1007;
        vec3 _3337 = normalize(_3335 + _3314);
        float _3339 = clamp(dot(_1003, _3337), 0.0, 1.0);
        float _3343 = clamp(dot(_3335, _3337), 0.0, 1.0);
        float _3350 = _3333 * 0.5;
        float _3351 = 1.0 - _3350;
        _3374 = _3244 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3343) - 6.9831600189208984375) * _3343)), vec3(1.0), _400) * (_3334 / pow((((_3334 - 1.0) * _3339) * _3339) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3335, _1003), 0.0, 1.0) * _3351) + _3350) * ((_3328 * _3351) + _3350)))) * _3328) * vec3(0.25)) * _3322);
        _3375 = _3245 + ((_3322 * _3328) * _353.xyz);
        _3376 = _3246 + _3322;
    }
    else
    {
        _3374 = _3244;
        _3375 = _3245;
        _3376 = _3246;
    }
    vec3 _3443;
    vec3 _3444;
    switch (_1592)
    {
        case 0u:
        {
            _3443 = dynamic_light_infos._m0[_1589].light_color.xyz;
            _3444 = -dynamic_light_infos._m0[_1589].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3420 = dynamic_light_infos._m0[_1589].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3421 = length(_3420);
            vec3 _3423 = _3420 / vec3(_3421);
            _3443 = dynamic_light_infos._m0[_1589].light_color.xyz * ((1.0 - clamp(_3421 / dynamic_light_infos._m0[_1589].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1589].light_direction.xyz, _3423) - dynamic_light_infos._m0[_1589].light_direction.w) / (dynamic_light_infos._m0[_1589].light_position.w - dynamic_light_infos._m0[_1589].light_direction.w), 0.0, 1.0));
            _3444 = _3423;
            break;
        }
        case 2u:
        {
            vec3 _3388 = dynamic_light_infos._m0[_1589].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3389 = length(_3388);
            float _3401 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1589].light_position.w, 0.0, 1.0));
            float _3406 = (_3389 / (dynamic_light_infos._m0[_1589].light_color.w / _3401)) + 1.0;
            float _3407 = _3389 / (dynamic_light_infos._m0[_1589].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1589].light_color.xyz), vec3(1.0)) * 2.0));
            float _3412 = clamp(1.0 - (((_3407 * _3407) * _3407) * _3407), 0.0, 1.0);
            _3443 = dynamic_light_infos._m0[_1589].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3401) * _3401) * (_3412 * _3412)) / (_3406 * _3406));
            _3444 = _3388 / vec3(_3389);
            break;
        }
        default:
        {
            _3443 = vec3(0.0);
            _3444 = vec3(0.0);
            break;
        }
    }
    vec3 _3452 = _3443 * (_3112.z * clamp((dot(_3184, -_3444) - _3186) * 2.5, 0.0, 1.0));
    vec3 _3504;
    vec3 _3505;
    vec3 _3506;
    if (length(_3452) > 0.0)
    {
        float _3458 = clamp(dot(_3444, _1003), 0.0, 1.0);
        float _3461 = clamp(1.0 - _367, 0.0, 1.0);
        float _3463 = spvNMax(_3461 * _3461, 0.00200000009499490261077880859375);
        float _3464 = _3463 * _3463;
        vec3 _3465 = -_1007;
        vec3 _3467 = normalize(_3465 + _3444);
        float _3469 = clamp(dot(_1003, _3467), 0.0, 1.0);
        float _3473 = clamp(dot(_3465, _3467), 0.0, 1.0);
        float _3480 = _3463 * 0.5;
        float _3481 = 1.0 - _3480;
        _3504 = _3374 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3473) - 6.9831600189208984375) * _3473)), vec3(1.0), _400) * (_3464 / pow((((_3464 - 1.0) * _3469) * _3469) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3465, _1003), 0.0, 1.0) * _3481) + _3480) * ((_3458 * _3481) + _3480)))) * _3458) * vec3(0.25)) * _3452);
        _3505 = _3375 + ((_3452 * _3458) * _353.xyz);
        _3506 = _3376 + _3452;
    }
    else
    {
        _3504 = _3374;
        _3505 = _3375;
        _3506 = _3376;
    }
    vec3 _3573;
    vec3 _3574;
    switch (_1596)
    {
        case 0u:
        {
            _3573 = dynamic_light_infos._m0[_1593].light_color.xyz;
            _3574 = -dynamic_light_infos._m0[_1593].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3550 = dynamic_light_infos._m0[_1593].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3551 = length(_3550);
            vec3 _3553 = _3550 / vec3(_3551);
            _3573 = dynamic_light_infos._m0[_1593].light_color.xyz * ((1.0 - clamp(_3551 / dynamic_light_infos._m0[_1593].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1593].light_direction.xyz, _3553) - dynamic_light_infos._m0[_1593].light_direction.w) / (dynamic_light_infos._m0[_1593].light_position.w - dynamic_light_infos._m0[_1593].light_direction.w), 0.0, 1.0));
            _3574 = _3553;
            break;
        }
        case 2u:
        {
            vec3 _3518 = dynamic_light_infos._m0[_1593].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3519 = length(_3518);
            float _3531 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1593].light_position.w, 0.0, 1.0));
            float _3536 = (_3519 / (dynamic_light_infos._m0[_1593].light_color.w / _3531)) + 1.0;
            float _3537 = _3519 / (dynamic_light_infos._m0[_1593].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1593].light_color.xyz), vec3(1.0)) * 2.0));
            float _3542 = clamp(1.0 - (((_3537 * _3537) * _3537) * _3537), 0.0, 1.0);
            _3573 = dynamic_light_infos._m0[_1593].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3531) * _3531) * (_3542 * _3542)) / (_3536 * _3536));
            _3574 = _3518 / vec3(_3519);
            break;
        }
        default:
        {
            _3573 = vec3(0.0);
            _3574 = vec3(0.0);
            break;
        }
    }
    vec3 _3582 = _3573 * (_3112.w * clamp((dot(_3184, -_3574) - _3186) * 2.5, 0.0, 1.0));
    vec3 _3634;
    vec3 _3635;
    vec3 _3636;
    if (length(_3582) > 0.0)
    {
        float _3588 = clamp(dot(_3574, _1003), 0.0, 1.0);
        float _3591 = clamp(1.0 - _367, 0.0, 1.0);
        float _3593 = spvNMax(_3591 * _3591, 0.00200000009499490261077880859375);
        float _3594 = _3593 * _3593;
        vec3 _3595 = -_1007;
        vec3 _3597 = normalize(_3595 + _3574);
        float _3599 = clamp(dot(_1003, _3597), 0.0, 1.0);
        float _3603 = clamp(dot(_3595, _3597), 0.0, 1.0);
        float _3610 = _3593 * 0.5;
        float _3611 = 1.0 - _3610;
        _3634 = _3505 + ((_3582 * _3588) * _353.xyz);
        _3635 = _3504 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3603) - 6.9831600189208984375) * _3603)), vec3(1.0), _400) * (_3594 / pow((((_3594 - 1.0) * _3599) * _3599) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3595, _1003), 0.0, 1.0) * _3611) + _3610) * ((_3588 * _3611) + _3610)))) * _3588) * vec3(0.25)) * _3582);
        _3636 = _3506 + _3582;
    }
    else
    {
        _3634 = _3505;
        _3635 = _3504;
        _3636 = _3506;
    }
    vec3 _3759;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _3649 = _1415.w;
        float _3650 = clamp(_367, 0.0, 1.0);
        float _3653 = sqrt(clamp(1.0 - _3649, 0.0, 1.0));
        float _3654 = 1.0 - _3650;
        float _3655 = _3654 * _3654;
        float _3658 = clamp(exp((-2.2999999523162841796875) * _3655), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _3659 = dot(_3182, _1008);
        float _3665 = sqrt(clamp(1.0 - (_3659 * _3659), 0.0, 1.0));
        float _3667 = _3658 - (_3659 * _3653);
        float _3668 = _3665 * _3653;
        vec2 _3669 = vec2(_3667, _3668);
        float _3671 = _3653 - (_3659 * _3658);
        float _3672 = _3665 * _3658;
        vec2 _3673 = vec2(_3671, _3672);
        float _3677 = sqrt(clamp(1.0 - (_3653 * _3653), 0.0, 1.0));
        float _3694 = sqrt(clamp(1.0 - (_3658 * _3658), 0.0, 1.0));
        vec4 _3720 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_1003, -_1007)), _3650, 0.0, 0.0).xy, 0.0);
        float _3733 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _3655));
        vec3 _3758 = _3635 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_1008, 0.0)).xyz, _3733).xyz, _3733).xyz * (vec3(_3720.x) + (_400 * _3720.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3636 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * (_3649 * ((2.0 * ((acos(clamp(_3667 / (_3677 * sqrt(dot(_3669, _3669))), -1.0, 1.0)) - (acos(clamp((_3667 * _3653) / (_3668 * _3677), -1.0, 1.0)) * _3653)) + (acos(clamp(_3671 / (_3694 * sqrt(dot(_3673, _3673))), -1.0, 1.0)) - (acos(clamp((_3671 * _3658) / (_3672 * _3694), -1.0, 1.0)) * _3658)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _3658)))));
        _3759 = _3758;
    }
    else
    {
        _3759 = _3635;
    }
    vec3 _3771 = _353.xyz;
    vec3 _3802;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _3802 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_345, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3636 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _3771) * _1415.w) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _3802 = vec3(0.0);
    }
    vec3 _3823 = (_3634 + _992) + (((_1415.xyz * _3771) + _3802) + spvNMax(vec3(0.0), _3759 / vec3(spvNMax(10.0, spvNMax(_3759.x, spvNMax(_3759.y, _3759.z))) * 0.100000001490116119384765625)));
    vec4 _3824 = vec4(_3823.x, _3823.y, _3823.z, vec4(0.0).w);
    _3824.w = 1.0;
    out_var_SV_TARGET = _3824;
    out_var_SV_TARGET1 = vec4((_3634 * cpass_cb.indirect_light_multiplier) + (_992 * 20.0), 1.0);
}

