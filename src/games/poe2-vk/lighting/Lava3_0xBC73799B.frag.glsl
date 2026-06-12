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
    vec4 performance_overlay_data;
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

float _227;
vec4 _228;
float _234;

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

layout(set = 0, binding = 0) uniform sampler SamplerLinearWrap;
layout(set = 0, binding = 1) uniform sampler SamplerLinearClamp;
layout(set = 0, binding = 7) uniform sampler SamplerDynamicWrap;
layout(set = 0, binding = 8) uniform sampler SamplerLinearWrapNoBias;
layout(set = 0, binding = 9) uniform sampler SamplerLinearClampNoBias;
layout(set = 0, binding = 15) uniform samplerShadow SamplerDepth;
layout(set = 1, binding = 7) uniform texture2D depth_sampler;
layout(set = 1, binding = 8) uniform textureCube diffuse_cube;
layout(set = 1, binding = 11) uniform texture2D environment_ggx_sampler;
layout(set = 1, binding = 18) uniform usamplerBuffer light_indices;
layout(set = 1, binding = 19) uniform utexture2D light_lookup;
layout(set = 1, binding = 21) uniform texture2D noise_sampler;
layout(set = 1, binding = 31) uniform textureCube specular_cube;
layout(set = 1, binding = 34) uniform texture2D tex_shadow_map_atlas;
layout(set = 2, binding = 43) uniform texture2D muddle_texture_0;
layout(set = 2, binding = 44) uniform texture2D texture_object_1;
layout(set = 2, binding = 45) uniform texture2D input_texture_0;

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
    uint _259 = in_var_INSTANCEID / cobject_cb.instance_count;
    vec4 _275 = texture(sampler2D(muddle_texture_0, SamplerLinearWrap), (in_var_TEXCOORD1 * 1.0) + (vec2(-0.02999999932944774627685546875, 0.02999999932944774627685546875) * cpass_cb.time));
    vec2 _279 = in_var_TEXCOORD1 + ((_275.xy - vec2(0.5)) * 0.0500000007450580596923828125);
    mat3 _280 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _294 = ((vec2(textureLod(sampler2D(texture_object_1, SamplerDynamicWrap), vec4(_279, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _295 = vec3(_294.x, _294.y, vec3(0.0).z);
    vec2 _296 = _294.xy;
    _295.z = sqrt(spvNMax(1.0 - dot(_296, _296), 0.0));
    vec3 _302 = _280 * _295;
    vec4 _308 = texture(sampler2D(texture_object_1, SamplerDynamicWrap), _279);
    float _309 = _308.z;
    vec3 _314 = vec3(pow(spvNMax(abs(_309), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_302 / vec3(length(_302) + 1.0000000116860974230803549289703e-07));
    vec4 _317 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _279);
    vec3 _318 = _317.xyz;
    vec3 _320 = vec3(_317.w);
    vec3 _322 = clamp(mix(_318, vec3(0.0), _320), vec3(0.0), vec3(1.0));
    vec2 _328 = ((vec2(_308.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _329 = vec3(_328.x, _328.y, vec3(0.0).z);
    vec2 _330 = _328.xy;
    _329.z = sqrt(spvNMax(1.0 - dot(_330, _330), 0.0));
    float _336 = _308.w;
    float _345 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _346 = cos(_345);
    vec3 _361 = (((_318 * _346) + (cross(vec3(0.57735002040863037109375), _318) * sin(_345))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _318)) * (1.0 - _346))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _369 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_361, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _361, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _320), vec3(0.0), vec3(1.0));
    bool _372 = cpipeline_cb.constant_trackG_0 < 0;
    float _374 = clamp(_309, 0.0, 1.0) * 127.0;
    int _378 = int(spvNMax(trunc(_374), 0.0) + 0.5);
    int _383 = int(spvNMin(trunc(_374 + 1.0), 127.0) + 0.5);
    float _401;
    if (_372)
    {
        _401 = 0.0;
    }
    else
    {
        uint _387 = uint(cpipeline_cb.constant_trackG_0);
        int _388 = _378 / 2;
        _401 = ((_378 - 2 * (_378 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_387].value[_388] & 65535u).x : unpackHalf2x16((spline_lut._m0[_387].value[_388] >> 16u) & 65535u).x;
    }
    float _419;
    if (_372)
    {
        _419 = 0.0;
    }
    else
    {
        uint _405 = uint(cpipeline_cb.constant_trackG_0);
        int _406 = _383 / 2;
        _419 = ((_383 - 2 * (_383 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_405].value[_406] & 65535u).x : unpackHalf2x16((spline_lut._m0[_405].value[_406] >> 16u) & 65535u).x;
    }
    float _420 = fract(_374);
    bool _426 = cpipeline_cb.constant_trackG_1 < 0;
    float _444;
    if (_426)
    {
        _444 = 0.0;
    }
    else
    {
        uint _430 = uint(cpipeline_cb.constant_trackG_1);
        int _431 = _378 / 2;
        _444 = ((_378 - 2 * (_378 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_430].value[_431] & 65535u).x : unpackHalf2x16((spline_lut._m0[_430].value[_431] >> 16u) & 65535u).x;
    }
    float _462;
    if (_426)
    {
        _462 = 0.0;
    }
    else
    {
        uint _448 = uint(cpipeline_cb.constant_trackG_1);
        int _449 = _383 / 2;
        _462 = ((_383 - 2 * (_383 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_448].value[_449] & 65535u).x : unpackHalf2x16((spline_lut._m0[_448].value[_449] >> 16u) & 65535u).x;
    }
    uvec3 _486 = (floatBitsToUint(vec3((cpipeline_cb.constant_bool_1 != 0u) ? clamp(uintBitsToFloat((uint(cobject_cb.instances[_259].synced_random_seed.x) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0) : clamp(uintBitsToFloat((cobject_cb.instances[_259].object_random_seed >> 9u) | 1065353216u) - 1.0, 0.0, 1.0), 0.59305775165557861328125, 0.22627294063568115234375)) * uvec3(1664525u)) + uvec3(1013904223u);
    uint _487 = _486.y;
    uint _488 = _486.z;
    uint _491 = _486.x + (_487 * _488);
    uint _493 = _487 + (_488 * _491);
    uvec3 _496 = uvec3(_491, _493, _488 + (_491 * _493));
    uvec3 _498 = _496 ^ (_496 >> uvec3(16u));
    uint _499 = _498.y;
    uint _500 = _498.z;
    float _526 = spvNMax(cpipeline_cb.constant1_12, 9.9999997473787516355514526367188e-05);
    bool _529 = cpass_cb.depth_sampler_type > 0.5;
    bool _533;
    if (_529)
    {
        _533 = cpass_cb.depth_sampler_type < 1.5;
    }
    else
    {
        _533 = false;
    }
    float _605;
    if (_533)
    {
        vec4 _537 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _228.w);
        _537.w = 1.0;
        vec4 _541 = cpass_cb.scene_view_projection_transform * _537;
        vec2 _547 = ((_541 / vec4(_541.w)).xy * 0.5) + vec2(0.5);
        float _548 = _547.y;
        vec2 _550 = _547;
        _550.y = 1.0 - _548;
        uvec2 _562 = uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)) / uvec2(uint(cpass_cb.pass_downscale));
        vec4 _590 = cpass_cb.scene_view_projection_transform_inv * vec4((_547.x * 2.0) - 1.0, (_548 * 2.0) - 1.0, textureLod(sampler2D(depth_sampler, SamplerLinearClamp), vec4(_550 * (vec2(ivec2((vec2(_562) * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))) / vec2(ivec2(_562))), 0.0, -0.5).xy, -0.5).x, 1.0);
        float _601 = length((_590 / vec4(_590.w)).xyz - cpass_cb.scene_camera_position) - length(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
        if (_601 < 0.0)
        {
            discard;
        }
        _605 = _601;
    }
    else
    {
        _605 = 0.0;
    }
    float _612;
    if (abs(_526) > 0.0)
    {
        _612 = _605 / _526;
    }
    else
    {
        _612 = 0.0;
    }
    float _619 = clamp(pow(spvNMax(abs(_612), 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_13), 0.0, 1.0) * 127.0;
    int _623 = int(spvNMax(trunc(_619), 0.0) + 0.5);
    int _628 = int(spvNMin(trunc(_619 + 1.0), 127.0) + 0.5);
    bool _629 = cpipeline_cb.constant_trackG_2 < 0;
    float _647;
    if (_629)
    {
        _647 = 0.0;
    }
    else
    {
        uint _633 = uint(cpipeline_cb.constant_trackG_2);
        int _634 = _623 / 2;
        _647 = ((_623 - 2 * (_623 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_633].value[_634] & 65535u).x : unpackHalf2x16((spline_lut._m0[_633].value[_634] >> 16u) & 65535u).x;
    }
    float _665;
    if (_629)
    {
        _665 = 0.0;
    }
    else
    {
        uint _651 = uint(cpipeline_cb.constant_trackG_2);
        int _652 = _628 / 2;
        _665 = ((_628 - 2 * (_628 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_651].value[_652] & 65535u).x : unpackHalf2x16((spline_lut._m0[_651].value[_652] >> 16u) & 65535u).x;
    }
    float _668 = mix(_647, _665, fract(_619)) - clamp(-(((((0.2989999949932098388671875 * _328.x) + (0.58700001239776611328125 * _328.y)) - 0.5) * 2.0) * mix(0.439999997615814208984375, 0.439999997615814208984375, clamp(uintBitsToFloat(((_499 + (_500 * (_498.x + (_499 * _500)))) >> 9u) | 1065353216u) - 1.0, 0.0, 1.0))), 0.0, 1.0);
    float _678 = clamp(((spvNMax(vec3(mix(_401, _419, _420), _234, _234), vec3(0.0)) + spvNMax(vec3(mix(_444, _462, _420), _234, _234), vec3(0.0))) + vec3((cpipeline_cb.constant_bool_2 != 0u) ? spvNMax(_668, 0.0) : clamp(_668, 0.0, 1.0))).x, 0.0, 1.0) * 127.0;
    int _683 = int(spvNMax(trunc(_678), 0.0) + 0.5);
    int _688 = int(spvNMin(trunc(_678 + 1.0), 127.0) + 0.5);
    bool _689 = cpipeline_cb.constant_trackC_0.x < 0;
    float _707;
    if (_689)
    {
        _707 = 0.0;
    }
    else
    {
        uint _693 = uint(cpipeline_cb.constant_trackC_0.x);
        int _694 = _683 / 2;
        _707 = ((_683 - 2 * (_683 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_693].value[_694] & 65535u).x : unpackHalf2x16((spline_lut._m0[_693].value[_694] >> 16u) & 65535u).x;
    }
    float _725;
    if (_689)
    {
        _725 = 0.0;
    }
    else
    {
        uint _711 = uint(cpipeline_cb.constant_trackC_0.x);
        int _712 = _688 / 2;
        _725 = ((_688 - 2 * (_688 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_711].value[_712] & 65535u).x : unpackHalf2x16((spline_lut._m0[_711].value[_712] >> 16u) & 65535u).x;
    }
    float _726 = fract(_678);
    bool _729 = cpipeline_cb.constant_trackC_0.y < 0;
    float _747;
    if (_729)
    {
        _747 = 0.0;
    }
    else
    {
        uint _733 = uint(cpipeline_cb.constant_trackC_0.y);
        int _734 = _683 / 2;
        _747 = ((_683 - 2 * (_683 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_733].value[_734] & 65535u).x : unpackHalf2x16((spline_lut._m0[_733].value[_734] >> 16u) & 65535u).x;
    }
    float _765;
    if (_729)
    {
        _765 = 0.0;
    }
    else
    {
        uint _751 = uint(cpipeline_cb.constant_trackC_0.y);
        int _752 = _688 / 2;
        _765 = ((_688 - 2 * (_688 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_751].value[_752] & 65535u).x : unpackHalf2x16((spline_lut._m0[_751].value[_752] >> 16u) & 65535u).x;
    }
    bool _768 = cpipeline_cb.constant_trackC_0.z < 0;
    float _786;
    if (_768)
    {
        _786 = 0.0;
    }
    else
    {
        uint _772 = uint(cpipeline_cb.constant_trackC_0.z);
        int _773 = _683 / 2;
        _786 = ((_683 - 2 * (_683 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_772].value[_773] & 65535u).x : unpackHalf2x16((spline_lut._m0[_772].value[_773] >> 16u) & 65535u).x;
    }
    float _804;
    if (_768)
    {
        _804 = 0.0;
    }
    else
    {
        uint _790 = uint(cpipeline_cb.constant_trackC_0.z);
        int _791 = _688 / 2;
        _804 = ((_688 - 2 * (_688 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_790].value[_791] & 65535u).x : unpackHalf2x16((spline_lut._m0[_790].value[_791] >> 16u) & 65535u).x;
    }
    bool _807 = cpipeline_cb.constant_trackC_0.w < 0;
    float _825;
    if (_807)
    {
        _825 = 0.0;
    }
    else
    {
        uint _811 = uint(cpipeline_cb.constant_trackC_0.w);
        int _812 = _683 / 2;
        _825 = ((_683 - 2 * (_683 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_811].value[_812] & 65535u).x : unpackHalf2x16((spline_lut._m0[_811].value[_812] >> 16u) & 65535u).x;
    }
    float _843;
    if (_807)
    {
        _843 = 0.0;
    }
    else
    {
        uint _829 = uint(cpipeline_cb.constant_trackC_0.w);
        int _830 = _688 / 2;
        _843 = ((_688 - 2 * (_688 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_829].value[_830] & 65535u).x : unpackHalf2x16((spline_lut._m0[_829].value[_830] >> 16u) & 65535u).x;
    }
    float _844 = mix(_825, _843, _726);
    bool _855;
    if (_529)
    {
        _855 = cpass_cb.depth_sampler_type < 1.5;
    }
    else
    {
        _855 = false;
    }
    float _927;
    if (_855)
    {
        vec4 _859 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _228.w);
        _859.w = 1.0;
        vec4 _863 = cpass_cb.scene_view_projection_transform * _859;
        vec2 _869 = ((_863 / vec4(_863.w)).xy * 0.5) + vec2(0.5);
        float _870 = _869.y;
        vec2 _872 = _869;
        _872.y = 1.0 - _870;
        uvec2 _884 = uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)) / uvec2(uint(cpass_cb.pass_downscale));
        vec4 _912 = cpass_cb.scene_view_projection_transform_inv * vec4((_869.x * 2.0) - 1.0, (_870 * 2.0) - 1.0, textureLod(sampler2D(depth_sampler, SamplerLinearClamp), vec4(_872 * (vec2(ivec2((vec2(_884) * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))) / vec2(ivec2(_884))), 0.0, -0.5).xy, -0.5).x, 1.0);
        float _923 = length((_912 / vec4(_912.w)).xyz - cpass_cb.scene_camera_position) - length(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
        if (_923 < 0.0)
        {
            discard;
        }
        _927 = _923;
    }
    else
    {
        _927 = 0.0;
    }
    float _928 = abs(20.0);
    float _934;
    if (_928 > 0.0)
    {
        _934 = _927 * 0.0500000007450580596923828125;
    }
    else
    {
        _934 = 0.0;
    }
    float _935 = spvNMax(0.001000000047497451305389404296875, 0.800000011920928955078125);
    float _938 = clamp((2.0 / _935) - 1.0, -100000.0, 100000.0);
    float _951 = 0.5 + ((pow(clamp((1.0 - spvNMax(0.5, _934)) * 2.0, 0.0, 1.0), _938) * (-0.5)) + (pow(clamp(spvNMin(0.5, _934) * 2.0, 0.0, 1.0), _938) * 0.5));
    vec3 _959 = spvNMin((vec4(mix(_707, _725, _726), mix(_747, _765, _726), mix(_786, _804, _726), _844).xyz * vec3(spvNMax(_844, 0.0))) * 5.0, vec3(100.0)) + ((vec3(1.0 - clamp(isnan(_951) ? 0.5 : _951, 0.0, 1.0)) * vec3(1.0, 0.02537130005657672882080078125, 0.0)) * 3.0);
    vec3 _960 = _280 * _329;
    if ((1.00100004673004150390625 - cpipeline_cb.alpha_test_desc.y) < 0.0)
    {
        discard;
    }
    vec3 _970 = _960 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_960)));
    vec3 _974 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _975 = reflect(_974, _970);
    uvec4 _988 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _989 = _988.x;
    uint _990 = _988.y;
    vec3 _995;
    vec3 _997;
    vec3 _999;
    _995 = vec3(0.0);
    _997 = vec3(0.0);
    _999 = vec3(0.0);
    uint _993;
    vec3 _996;
    vec3 _998;
    vec3 _1000;
    for (uint _992 = _989, _1001 = 0u; _1001 < _990; _992 = _993, _995 = _996, _997 = _998, _999 = _1000, _1001++)
    {
        _993 = _992 + 1u;
        uvec4 _1007 = texelFetch(light_indices, int(_992));
        uint _1008 = _1007.x;
        vec4 _1027;
        if (point_light_infos._m0[_1008].channel_index > (-0.5))
        {
            vec4 _1026;
            if (point_light_infos._m0[_1008].channel_index >= 2.5)
            {
                _1026 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1025;
                if (point_light_infos._m0[_1008].channel_index >= 1.5)
                {
                    _1025 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1025 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1008].channel_index >= 0.5));
                }
                _1026 = _1025;
            }
            _1027 = _1026;
        }
        else
        {
            _1027 = vec4(0.0);
        }
        vec3 _1057 = vec4(point_light_infos._m0[_1008].position, point_light_infos._m0[_1008].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1058 = length(_1057);
        vec3 _1060 = _1057 / vec3(_1058);
        vec3 _1061 = vec4(point_light_infos._m0[_1008].color, point_light_infos._m0[_1008].median_radius).xyz;
        float _1068 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1008].channel_index, 0.0, 1.0));
        float _1073 = (_1058 / (point_light_infos._m0[_1008].median_radius / _1068)) + 1.0;
        float _1074 = _1058 / (point_light_infos._m0[_1008].median_radius * sqrt(dot(abs(_1061), vec3(1.0)) * 2.0));
        float _1079 = clamp(1.0 - (((_1074 * _1074) * _1074) * _1074), 0.0, 1.0);
        vec3 _1086 = (_1061 * spvNMin(10.0, (((0.199999988079071044921875 * _1068) * _1068) * (_1079 * _1079)) / (_1073 * _1073))) * (dot(vec4(1.0), _1027) * clamp((dot(-normalize(_314), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1008].position)) - (1.0 - length(_314))) * 2.5, 0.0, 1.0));
        if (length(_1086) > 0.0)
        {
            float _1092 = clamp(dot(_1060, _970), 0.0, 1.0);
            float _1095 = clamp(1.0 - _336, 0.0, 1.0);
            float _1097 = spvNMax(_1095 * _1095, 0.00200000009499490261077880859375);
            float _1098 = _1097 * _1097;
            vec3 _1099 = -_974;
            vec3 _1101 = normalize(_1099 + _1060);
            float _1103 = clamp(dot(_970, _1101), 0.0, 1.0);
            float _1107 = clamp(dot(_1099, _1101), 0.0, 1.0);
            float _1114 = _1097 * 0.5;
            float _1115 = 1.0 - _1114;
            _996 = _995 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1107) - 6.9831600189208984375) * _1107)), vec3(1.0), _369) * (_1098 / pow((((_1098 - 1.0) * _1103) * _1103) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1099, _970), 0.0, 1.0) * _1115) + _1114) * ((_1092 * _1115) + _1114)))) * _1092) * vec3(0.25)) * _1086);
            _998 = _997 + ((_1086 * _1092) * _322.xyz);
            _1000 = _999 + _1086;
        }
        else
        {
            _996 = _995;
            _998 = _997;
            _1000 = _999;
        }
    }
    uvec4 _1140 = uvec4(cobject_cb.instances[_259].dynamic_light_indices);
    uint _1141 = _1140.x;
    uint _1144 = uint(dynamic_light_infos._m0[_1141].light_type.x);
    uint _1145 = _1140.y;
    uint _1148 = uint(dynamic_light_infos._m0[_1145].light_type.x);
    uint _1149 = _1140.z;
    uint _1152 = uint(dynamic_light_infos._m0[_1149].light_type.x);
    uint _1153 = _1140.w;
    uint _1156 = uint(dynamic_light_infos._m0[_1153].light_type.x);
    vec4 _1551;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1141].shadow_enabled.x > 0.0)
    {
        vec4 _1165 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1549;
        do
        {
            vec4 _1175 = dynamic_light_infos._m0[_1141].light_matrix * _1165;
            vec3 _1232;
            if (_1144 == 2u)
            {
                vec3 _1196 = _1175.xyz;
                vec3 _1198 = normalize(_1196) + vec3(0.0, 0.0, 1.0);
                float _1202 = length(_1196);
                vec3 _1205 = vec3((_1198 / vec3(_1198.z)).xy, _1202);
                float _1206 = _1175.z;
                vec3 _1218;
                if (_1206 > 0.0)
                {
                    _1218 = _1205;
                }
                else
                {
                    _1218 = vec3(normalize(_1205.xy) * 10000000.0, -_1202);
                }
                vec3 _1226 = vec3((_1218.x * 0.5) + 0.5, 0.5 - (_1218.y * 0.5), _1218.z);
                _1226.z = _1218.z * 9.9999997473787516355514526367188e-05;
                if (_1206 < 0.0)
                {
                    _1549 = 0.0;
                    break;
                }
                _1232 = _1226;
            }
            else
            {
                vec3 _1180 = _1175.xyz;
                vec3 _1192;
                if (_1144 == 1u)
                {
                    float _1184 = _1175.z;
                    vec3 _1191 = _1180;
                    _1191.z = _1184 - (((_1184 * dynamic_light_infos._m0[_1141].shadow_scale.z) + 1.0) / _1175.w);
                    _1192 = _1191;
                }
                else
                {
                    _1192 = _1180;
                }
                _1232 = _1192 / vec3(_1175.w);
            }
            float _1342;
            if (dynamic_light_infos._m0[_1141].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1324 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1232.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1232.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1232.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1232.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1141].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1232.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1232.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1141].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1232.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1232.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1141].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1232.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1232.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1141].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1232.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1232.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1141].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1342 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1141].shadow_scale.w * spvNMax(_1324, _1232.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1232.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1141].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1342 = 1.0;
            }
            vec3 _1343 = dFdx(_1232);
            vec3 _1344 = dFdy(_1232);
            vec3 _1358 = _1232 + ((normalize(cross(_1343, _1344)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _227) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw)).x);
            vec2 _1359 = dynamic_light_infos._m0[_1141].shadow_scale.xy * _1342;
            vec2 _1360 = _1358.xy;
            float _1365 = _1358.z;
            float _1444 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1360, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, _1365, 1.0).xy, _1365), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1360 + (vec2(1.0, 0.0) * _1359), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, _1365, 1.0).xy, _1365), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1360 + (vec2(0.5, 0.865999996662139892578125) * _1359), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, _1365, 1.0).xy, _1365), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1360 + (vec2(-0.5, 0.865999996662139892578125) * _1359), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, _1365, 1.0).xy, _1365), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1360 + (vec2(-1.0, -0.0) * _1359), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, _1365, 1.0).xy, _1365), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1360 + (vec2(-0.5, -0.865999996662139892578125) * _1359), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, _1365, 1.0).xy, _1365), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1360 + (vec2(0.5, -0.865999996662139892578125) * _1359), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1141].shadow_atlas_offset_scale.xy, _1365, 1.0).xy, _1365), 0.0);
            float _1445 = _1444 * 0.14285714924335479736328125;
            float _1548;
            if (_1144 == 0u)
            {
                float _1460 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1165.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1462 = transpose(dynamic_light_infos._m0[_1141].light_matrix)[2];
                float _1467 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1476;
                if (_1467 > 0.100000001490116119384765625)
                {
                    _1476 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1476 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1487 = _1165.xyz - ((_1462.xyz / vec3(_1462.z)) * 1000.0);
                float _1511 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1476, _1487), dot(normalize(vec3(-_1476.y, _1476.x, 0.0)), _1487)) + (vec2(_1467, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1460 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1518 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1519 = _1518 - 1.0;
                float _1520 = 1.0 - cpass_cb.clouds_midpoint;
                float _1527 = 2.0 - _1518;
                _1548 = _1445 * mix(1.0, clamp(clamp(_1520 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1511), 0.0, 1.0), _1519)) * pow(clamp(_1520, 0.0, 1.0), _1527)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1511), 0.0, 1.0), _1519) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1527))), 0.0, 1.0) + (_1460 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1548 = _1445;
            }
            _1549 = _1548;
            break;
        } while(false);
        vec4 _1550 = vec4(1.0);
        _1550.x = _1549;
        _1551 = _1550;
    }
    else
    {
        _1551 = vec4(1.0);
    }
    vec4 _1946;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1145].shadow_enabled.x > 0.0)
    {
        vec4 _1560 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1944;
        do
        {
            vec4 _1570 = dynamic_light_infos._m0[_1145].light_matrix * _1560;
            vec3 _1627;
            if (_1148 == 2u)
            {
                vec3 _1591 = _1570.xyz;
                vec3 _1593 = normalize(_1591) + vec3(0.0, 0.0, 1.0);
                float _1597 = length(_1591);
                vec3 _1600 = vec3((_1593 / vec3(_1593.z)).xy, _1597);
                float _1601 = _1570.z;
                vec3 _1613;
                if (_1601 > 0.0)
                {
                    _1613 = _1600;
                }
                else
                {
                    _1613 = vec3(normalize(_1600.xy) * 10000000.0, -_1597);
                }
                vec3 _1621 = vec3((_1613.x * 0.5) + 0.5, 0.5 - (_1613.y * 0.5), _1613.z);
                _1621.z = _1613.z * 9.9999997473787516355514526367188e-05;
                if (_1601 < 0.0)
                {
                    _1944 = 0.0;
                    break;
                }
                _1627 = _1621;
            }
            else
            {
                vec3 _1575 = _1570.xyz;
                vec3 _1587;
                if (_1148 == 1u)
                {
                    float _1579 = _1570.z;
                    vec3 _1586 = _1575;
                    _1586.z = _1579 - (((_1579 * dynamic_light_infos._m0[_1145].shadow_scale.z) + 1.0) / _1570.w);
                    _1587 = _1586;
                }
                else
                {
                    _1587 = _1575;
                }
                _1627 = _1587 / vec3(_1570.w);
            }
            float _1737;
            if (dynamic_light_infos._m0[_1145].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1719 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1627.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1627.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1627.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1627.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1145].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1627.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1627.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1145].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1627.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1627.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1145].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1627.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1627.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1145].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1627.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1627.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1145].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1737 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1145].shadow_scale.w * spvNMax(_1719, _1627.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1627.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1145].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1737 = 1.0;
            }
            vec3 _1738 = dFdx(_1627);
            vec3 _1739 = dFdy(_1627);
            vec3 _1753 = _1627 + ((normalize(cross(_1738, _1739)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _227) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw)).x);
            vec2 _1754 = dynamic_light_infos._m0[_1145].shadow_scale.xy * _1737;
            vec2 _1755 = _1753.xy;
            float _1760 = _1753.z;
            float _1839 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1755, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, _1760, 1.0).xy, _1760), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1755 + (vec2(1.0, 0.0) * _1754), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, _1760, 1.0).xy, _1760), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1755 + (vec2(0.5, 0.865999996662139892578125) * _1754), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, _1760, 1.0).xy, _1760), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1755 + (vec2(-0.5, 0.865999996662139892578125) * _1754), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, _1760, 1.0).xy, _1760), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1755 + (vec2(-1.0, -0.0) * _1754), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, _1760, 1.0).xy, _1760), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1755 + (vec2(-0.5, -0.865999996662139892578125) * _1754), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, _1760, 1.0).xy, _1760), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1755 + (vec2(0.5, -0.865999996662139892578125) * _1754), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1145].shadow_atlas_offset_scale.xy, _1760, 1.0).xy, _1760), 0.0);
            float _1840 = _1839 * 0.14285714924335479736328125;
            float _1943;
            if (_1148 == 0u)
            {
                float _1855 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1560.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1857 = transpose(dynamic_light_infos._m0[_1145].light_matrix)[2];
                float _1862 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1871;
                if (_1862 > 0.100000001490116119384765625)
                {
                    _1871 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1871 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1882 = _1560.xyz - ((_1857.xyz / vec3(_1857.z)) * 1000.0);
                float _1906 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1871, _1882), dot(normalize(vec3(-_1871.y, _1871.x, 0.0)), _1882)) + (vec2(_1862, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1855 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1913 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1914 = _1913 - 1.0;
                float _1915 = 1.0 - cpass_cb.clouds_midpoint;
                float _1922 = 2.0 - _1913;
                _1943 = _1840 * mix(1.0, clamp(clamp(_1915 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1906), 0.0, 1.0), _1914)) * pow(clamp(_1915, 0.0, 1.0), _1922)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1906), 0.0, 1.0), _1914) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1922))), 0.0, 1.0) + (_1855 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1943 = _1840;
            }
            _1944 = _1943;
            break;
        } while(false);
        vec4 _1945 = _1551;
        _1945.y = _1944;
        _1946 = _1945;
    }
    else
    {
        _1946 = _1551;
    }
    vec4 _2341;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1149].shadow_enabled.x > 0.0)
    {
        vec4 _1955 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2339;
        do
        {
            vec4 _1965 = dynamic_light_infos._m0[_1149].light_matrix * _1955;
            vec3 _2022;
            if (_1152 == 2u)
            {
                vec3 _1986 = _1965.xyz;
                vec3 _1988 = normalize(_1986) + vec3(0.0, 0.0, 1.0);
                float _1992 = length(_1986);
                vec3 _1995 = vec3((_1988 / vec3(_1988.z)).xy, _1992);
                float _1996 = _1965.z;
                vec3 _2008;
                if (_1996 > 0.0)
                {
                    _2008 = _1995;
                }
                else
                {
                    _2008 = vec3(normalize(_1995.xy) * 10000000.0, -_1992);
                }
                vec3 _2016 = vec3((_2008.x * 0.5) + 0.5, 0.5 - (_2008.y * 0.5), _2008.z);
                _2016.z = _2008.z * 9.9999997473787516355514526367188e-05;
                if (_1996 < 0.0)
                {
                    _2339 = 0.0;
                    break;
                }
                _2022 = _2016;
            }
            else
            {
                vec3 _1970 = _1965.xyz;
                vec3 _1982;
                if (_1152 == 1u)
                {
                    float _1974 = _1965.z;
                    vec3 _1981 = _1970;
                    _1981.z = _1974 - (((_1974 * dynamic_light_infos._m0[_1149].shadow_scale.z) + 1.0) / _1965.w);
                    _1982 = _1981;
                }
                else
                {
                    _1982 = _1970;
                }
                _2022 = _1982 / vec3(_1965.w);
            }
            float _2132;
            if (dynamic_light_infos._m0[_1149].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2114 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2022.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2022.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2022.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2022.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1149].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2022.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2022.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1149].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2022.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2022.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1149].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2022.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2022.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1149].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2022.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2022.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1149].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2132 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1149].shadow_scale.w * spvNMax(_2114, _2022.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2022.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1149].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2132 = 1.0;
            }
            vec3 _2133 = dFdx(_2022);
            vec3 _2134 = dFdy(_2022);
            vec3 _2148 = _2022 + ((normalize(cross(_2133, _2134)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _227) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw)).x);
            vec2 _2149 = dynamic_light_infos._m0[_1149].shadow_scale.xy * _2132;
            vec2 _2150 = _2148.xy;
            float _2155 = _2148.z;
            float _2234 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2150, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, _2155, 1.0).xy, _2155), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2150 + (vec2(1.0, 0.0) * _2149), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, _2155, 1.0).xy, _2155), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2150 + (vec2(0.5, 0.865999996662139892578125) * _2149), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, _2155, 1.0).xy, _2155), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2150 + (vec2(-0.5, 0.865999996662139892578125) * _2149), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, _2155, 1.0).xy, _2155), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2150 + (vec2(-1.0, -0.0) * _2149), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, _2155, 1.0).xy, _2155), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2150 + (vec2(-0.5, -0.865999996662139892578125) * _2149), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, _2155, 1.0).xy, _2155), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2150 + (vec2(0.5, -0.865999996662139892578125) * _2149), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1149].shadow_atlas_offset_scale.xy, _2155, 1.0).xy, _2155), 0.0);
            float _2235 = _2234 * 0.14285714924335479736328125;
            float _2338;
            if (_1152 == 0u)
            {
                float _2250 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1955.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2252 = transpose(dynamic_light_infos._m0[_1149].light_matrix)[2];
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
                vec3 _2277 = _1955.xyz - ((_2252.xyz / vec3(_2252.z)) * 1000.0);
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
        vec4 _2340 = _1946;
        _2340.z = _2339;
        _2341 = _2340;
    }
    else
    {
        _2341 = _1946;
    }
    vec4 _2736;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1153].shadow_enabled.x > 0.0)
    {
        vec4 _2350 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2734;
        do
        {
            vec4 _2360 = dynamic_light_infos._m0[_1153].light_matrix * _2350;
            vec3 _2417;
            if (_1156 == 2u)
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
                    _2734 = 0.0;
                    break;
                }
                _2417 = _2411;
            }
            else
            {
                vec3 _2365 = _2360.xyz;
                vec3 _2377;
                if (_1156 == 1u)
                {
                    float _2369 = _2360.z;
                    vec3 _2376 = _2365;
                    _2376.z = _2369 - (((_2369 * dynamic_light_infos._m0[_1153].shadow_scale.z) + 1.0) / _2360.w);
                    _2377 = _2376;
                }
                else
                {
                    _2377 = _2365;
                }
                _2417 = _2377 / vec3(_2360.w);
            }
            float _2527;
            if (dynamic_light_infos._m0[_1153].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2509 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1153].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1153].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1153].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1153].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1153].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2527 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1153].shadow_scale.w * spvNMax(_2509, _2417.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2417.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1153].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2527 = 1.0;
            }
            vec3 _2528 = dFdx(_2417);
            vec3 _2529 = dFdy(_2417);
            vec3 _2543 = _2417 + ((normalize(cross(_2528, _2529)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _227) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw)).x);
            vec2 _2544 = dynamic_light_infos._m0[_1153].shadow_scale.xy * _2527;
            vec2 _2545 = _2543.xy;
            float _2550 = _2543.z;
            float _2629 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2545, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, _2550, 1.0).xy, _2550), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2545 + (vec2(1.0, 0.0) * _2544), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, _2550, 1.0).xy, _2550), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2545 + (vec2(0.5, 0.865999996662139892578125) * _2544), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, _2550, 1.0).xy, _2550), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2545 + (vec2(-0.5, 0.865999996662139892578125) * _2544), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, _2550, 1.0).xy, _2550), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2545 + (vec2(-1.0, -0.0) * _2544), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, _2550, 1.0).xy, _2550), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2545 + (vec2(-0.5, -0.865999996662139892578125) * _2544), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, _2550, 1.0).xy, _2550), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2545 + (vec2(0.5, -0.865999996662139892578125) * _2544), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1153].shadow_atlas_offset_scale.xy, _2550, 1.0).xy, _2550), 0.0);
            float _2630 = _2629 * 0.14285714924335479736328125;
            float _2733;
            if (_1156 == 0u)
            {
                float _2645 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2350.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2647 = transpose(dynamic_light_infos._m0[_1153].light_matrix)[2];
                float _2652 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2661;
                if (_2652 > 0.100000001490116119384765625)
                {
                    _2661 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2661 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2672 = _2350.xyz - ((_2647.xyz / vec3(_2647.z)) * 1000.0);
                float _2696 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2661, _2672), dot(normalize(vec3(-_2661.y, _2661.x, 0.0)), _2672)) + (vec2(_2652, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2645 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2703 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2704 = _2703 - 1.0;
                float _2705 = 1.0 - cpass_cb.clouds_midpoint;
                float _2712 = 2.0 - _2703;
                _2733 = _2630 * mix(1.0, clamp(clamp(_2705 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2696), 0.0, 1.0), _2704)) * pow(clamp(_2705, 0.0, 1.0), _2712)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2696), 0.0, 1.0), _2704) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2712))), 0.0, 1.0) + (_2645 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2733 = _2630;
            }
            _2734 = _2733;
            break;
        } while(false);
        vec4 _2735 = _2341;
        _2735.w = _2734;
        _2736 = _2735;
    }
    else
    {
        _2736 = _2341;
    }
    vec3 _2803;
    vec3 _2804;
    switch (_1144)
    {
        case 0u:
        {
            _2803 = dynamic_light_infos._m0[_1141].light_color.xyz;
            _2804 = -dynamic_light_infos._m0[_1141].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _2780 = dynamic_light_infos._m0[_1141].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2781 = length(_2780);
            vec3 _2783 = _2780 / vec3(_2781);
            _2803 = dynamic_light_infos._m0[_1141].light_color.xyz * ((1.0 - clamp(_2781 / dynamic_light_infos._m0[_1141].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1141].light_direction.xyz, _2783) - dynamic_light_infos._m0[_1141].light_direction.w) / (dynamic_light_infos._m0[_1141].light_position.w - dynamic_light_infos._m0[_1141].light_direction.w), 0.0, 1.0));
            _2804 = _2783;
            break;
        }
        case 2u:
        {
            vec3 _2748 = dynamic_light_infos._m0[_1141].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2749 = length(_2748);
            float _2761 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1141].light_position.w, 0.0, 1.0));
            float _2766 = (_2749 / (dynamic_light_infos._m0[_1141].light_color.w / _2761)) + 1.0;
            float _2767 = _2749 / (dynamic_light_infos._m0[_1141].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1141].light_color.xyz), vec3(1.0)) * 2.0));
            float _2772 = clamp(1.0 - (((_2767 * _2767) * _2767) * _2767), 0.0, 1.0);
            _2803 = dynamic_light_infos._m0[_1141].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _2761) * _2761) * (_2772 * _2772)) / (_2766 * _2766));
            _2804 = _2748 / vec3(_2749);
            break;
        }
        default:
        {
            _2803 = vec3(0.0);
            _2804 = vec3(0.0);
            break;
        }
    }
    vec3 _2806 = normalize(_314);
    vec3 _2808 = -_2806;
    float _2810 = 1.0 - length(_314);
    vec3 _2816 = _2803 * (_2736.x * clamp((dot(_2808, -_2804) - _2810) * 2.5, 0.0, 1.0));
    vec3 _2868;
    vec3 _2869;
    vec3 _2870;
    if (length(_2816) > 0.0)
    {
        float _2822 = clamp(dot(_2804, _970), 0.0, 1.0);
        float _2825 = clamp(1.0 - _336, 0.0, 1.0);
        float _2827 = spvNMax(_2825 * _2825, 0.00200000009499490261077880859375);
        float _2828 = _2827 * _2827;
        vec3 _2829 = -_974;
        vec3 _2831 = normalize(_2829 + _2804);
        float _2833 = clamp(dot(_970, _2831), 0.0, 1.0);
        float _2837 = clamp(dot(_2829, _2831), 0.0, 1.0);
        float _2844 = _2827 * 0.5;
        float _2845 = 1.0 - _2844;
        _2868 = _995 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _2837) - 6.9831600189208984375) * _2837)), vec3(1.0), _369) * (_2828 / pow((((_2828 - 1.0) * _2833) * _2833) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_2829, _970), 0.0, 1.0) * _2845) + _2844) * ((_2822 * _2845) + _2844)))) * _2822) * vec3(0.25)) * _2816);
        _2869 = _997 + ((_2816 * _2822) * _322.xyz);
        _2870 = _999 + _2816;
    }
    else
    {
        _2868 = _995;
        _2869 = _997;
        _2870 = _999;
    }
    vec3 _2937;
    vec3 _2938;
    switch (_1148)
    {
        case 0u:
        {
            _2937 = dynamic_light_infos._m0[_1145].light_color.xyz;
            _2938 = -dynamic_light_infos._m0[_1145].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _2914 = dynamic_light_infos._m0[_1145].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2915 = length(_2914);
            vec3 _2917 = _2914 / vec3(_2915);
            _2937 = dynamic_light_infos._m0[_1145].light_color.xyz * ((1.0 - clamp(_2915 / dynamic_light_infos._m0[_1145].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1145].light_direction.xyz, _2917) - dynamic_light_infos._m0[_1145].light_direction.w) / (dynamic_light_infos._m0[_1145].light_position.w - dynamic_light_infos._m0[_1145].light_direction.w), 0.0, 1.0));
            _2938 = _2917;
            break;
        }
        case 2u:
        {
            vec3 _2882 = dynamic_light_infos._m0[_1145].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2883 = length(_2882);
            float _2895 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1145].light_position.w, 0.0, 1.0));
            float _2900 = (_2883 / (dynamic_light_infos._m0[_1145].light_color.w / _2895)) + 1.0;
            float _2901 = _2883 / (dynamic_light_infos._m0[_1145].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1145].light_color.xyz), vec3(1.0)) * 2.0));
            float _2906 = clamp(1.0 - (((_2901 * _2901) * _2901) * _2901), 0.0, 1.0);
            _2937 = dynamic_light_infos._m0[_1145].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _2895) * _2895) * (_2906 * _2906)) / (_2900 * _2900));
            _2938 = _2882 / vec3(_2883);
            break;
        }
        default:
        {
            _2937 = vec3(0.0);
            _2938 = vec3(0.0);
            break;
        }
    }
    vec3 _2946 = _2937 * (_2736.y * clamp((dot(_2808, -_2938) - _2810) * 2.5, 0.0, 1.0));
    vec3 _2998;
    vec3 _2999;
    vec3 _3000;
    if (length(_2946) > 0.0)
    {
        float _2952 = clamp(dot(_2938, _970), 0.0, 1.0);
        float _2955 = clamp(1.0 - _336, 0.0, 1.0);
        float _2957 = spvNMax(_2955 * _2955, 0.00200000009499490261077880859375);
        float _2958 = _2957 * _2957;
        vec3 _2959 = -_974;
        vec3 _2961 = normalize(_2959 + _2938);
        float _2963 = clamp(dot(_970, _2961), 0.0, 1.0);
        float _2967 = clamp(dot(_2959, _2961), 0.0, 1.0);
        float _2974 = _2957 * 0.5;
        float _2975 = 1.0 - _2974;
        _2998 = _2868 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _2967) - 6.9831600189208984375) * _2967)), vec3(1.0), _369) * (_2958 / pow((((_2958 - 1.0) * _2963) * _2963) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_2959, _970), 0.0, 1.0) * _2975) + _2974) * ((_2952 * _2975) + _2974)))) * _2952) * vec3(0.25)) * _2946);
        _2999 = _2869 + ((_2946 * _2952) * _322.xyz);
        _3000 = _2870 + _2946;
    }
    else
    {
        _2998 = _2868;
        _2999 = _2869;
        _3000 = _2870;
    }
    vec3 _3067;
    vec3 _3068;
    switch (_1152)
    {
        case 0u:
        {
            _3067 = dynamic_light_infos._m0[_1149].light_color.xyz;
            _3068 = -dynamic_light_infos._m0[_1149].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3044 = dynamic_light_infos._m0[_1149].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3045 = length(_3044);
            vec3 _3047 = _3044 / vec3(_3045);
            _3067 = dynamic_light_infos._m0[_1149].light_color.xyz * ((1.0 - clamp(_3045 / dynamic_light_infos._m0[_1149].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1149].light_direction.xyz, _3047) - dynamic_light_infos._m0[_1149].light_direction.w) / (dynamic_light_infos._m0[_1149].light_position.w - dynamic_light_infos._m0[_1149].light_direction.w), 0.0, 1.0));
            _3068 = _3047;
            break;
        }
        case 2u:
        {
            vec3 _3012 = dynamic_light_infos._m0[_1149].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3013 = length(_3012);
            float _3025 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1149].light_position.w, 0.0, 1.0));
            float _3030 = (_3013 / (dynamic_light_infos._m0[_1149].light_color.w / _3025)) + 1.0;
            float _3031 = _3013 / (dynamic_light_infos._m0[_1149].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1149].light_color.xyz), vec3(1.0)) * 2.0));
            float _3036 = clamp(1.0 - (((_3031 * _3031) * _3031) * _3031), 0.0, 1.0);
            _3067 = dynamic_light_infos._m0[_1149].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3025) * _3025) * (_3036 * _3036)) / (_3030 * _3030));
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
    vec3 _3076 = _3067 * (_2736.z * clamp((dot(_2808, -_3068) - _2810) * 2.5, 0.0, 1.0));
    vec3 _3128;
    vec3 _3129;
    vec3 _3130;
    if (length(_3076) > 0.0)
    {
        float _3082 = clamp(dot(_3068, _970), 0.0, 1.0);
        float _3085 = clamp(1.0 - _336, 0.0, 1.0);
        float _3087 = spvNMax(_3085 * _3085, 0.00200000009499490261077880859375);
        float _3088 = _3087 * _3087;
        vec3 _3089 = -_974;
        vec3 _3091 = normalize(_3089 + _3068);
        float _3093 = clamp(dot(_970, _3091), 0.0, 1.0);
        float _3097 = clamp(dot(_3089, _3091), 0.0, 1.0);
        float _3104 = _3087 * 0.5;
        float _3105 = 1.0 - _3104;
        _3128 = _2998 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3097) - 6.9831600189208984375) * _3097)), vec3(1.0), _369) * (_3088 / pow((((_3088 - 1.0) * _3093) * _3093) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3089, _970), 0.0, 1.0) * _3105) + _3104) * ((_3082 * _3105) + _3104)))) * _3082) * vec3(0.25)) * _3076);
        _3129 = _2999 + ((_3076 * _3082) * _322.xyz);
        _3130 = _3000 + _3076;
    }
    else
    {
        _3128 = _2998;
        _3129 = _2999;
        _3130 = _3000;
    }
    vec3 _3197;
    vec3 _3198;
    switch (_1156)
    {
        case 0u:
        {
            _3197 = dynamic_light_infos._m0[_1153].light_color.xyz;
            _3198 = -dynamic_light_infos._m0[_1153].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3174 = dynamic_light_infos._m0[_1153].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3175 = length(_3174);
            vec3 _3177 = _3174 / vec3(_3175);
            _3197 = dynamic_light_infos._m0[_1153].light_color.xyz * ((1.0 - clamp(_3175 / dynamic_light_infos._m0[_1153].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1153].light_direction.xyz, _3177) - dynamic_light_infos._m0[_1153].light_direction.w) / (dynamic_light_infos._m0[_1153].light_position.w - dynamic_light_infos._m0[_1153].light_direction.w), 0.0, 1.0));
            _3198 = _3177;
            break;
        }
        case 2u:
        {
            vec3 _3142 = dynamic_light_infos._m0[_1153].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3143 = length(_3142);
            float _3155 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1153].light_position.w, 0.0, 1.0));
            float _3160 = (_3143 / (dynamic_light_infos._m0[_1153].light_color.w / _3155)) + 1.0;
            float _3161 = _3143 / (dynamic_light_infos._m0[_1153].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1153].light_color.xyz), vec3(1.0)) * 2.0));
            float _3166 = clamp(1.0 - (((_3161 * _3161) * _3161) * _3161), 0.0, 1.0);
            _3197 = dynamic_light_infos._m0[_1153].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3155) * _3155) * (_3166 * _3166)) / (_3160 * _3160));
            _3198 = _3142 / vec3(_3143);
            break;
        }
        default:
        {
            _3197 = vec3(0.0);
            _3198 = vec3(0.0);
            break;
        }
    }
    vec3 _3206 = _3197 * (_2736.w * clamp((dot(_2808, -_3198) - _2810) * 2.5, 0.0, 1.0));
    vec3 _3258;
    vec3 _3259;
    vec3 _3260;
    if (length(_3206) > 0.0)
    {
        float _3212 = clamp(dot(_3198, _970), 0.0, 1.0);
        float _3215 = clamp(1.0 - _336, 0.0, 1.0);
        float _3217 = spvNMax(_3215 * _3215, 0.00200000009499490261077880859375);
        float _3218 = _3217 * _3217;
        vec3 _3219 = -_974;
        vec3 _3221 = normalize(_3219 + _3198);
        float _3223 = clamp(dot(_970, _3221), 0.0, 1.0);
        float _3227 = clamp(dot(_3219, _3221), 0.0, 1.0);
        float _3234 = _3217 * 0.5;
        float _3235 = 1.0 - _3234;
        _3258 = _3129 + ((_3206 * _3212) * _322.xyz);
        _3259 = _3128 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3227) - 6.9831600189208984375) * _3227)), vec3(1.0), _369) * (_3218 / pow((((_3218 - 1.0) * _3223) * _3223) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3219, _970), 0.0, 1.0) * _3235) + _3234) * ((_3212 * _3235) + _3234)))) * _3212) * vec3(0.25)) * _3206);
        _3260 = _3130 + _3206;
    }
    else
    {
        _3258 = _3129;
        _3259 = _3128;
        _3260 = _3130;
    }
    vec3 _3364;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _3273 = clamp(_336, 0.0, 1.0);
        float _3274 = 1.0 - _3273;
        float _3275 = _3274 * _3274;
        float _3278 = clamp(exp((-2.2999999523162841796875) * _3275), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _3279 = dot(_2806, _975);
        vec2 _3286 = vec2(_3278, 0.0);
        float _3288 = -(_3279 * _3278);
        float _3289 = sqrt(clamp(1.0 - (_3279 * _3279), 0.0, 1.0)) * _3278;
        vec2 _3290 = vec2(_3288, _3289);
        float _3299 = sqrt(clamp(1.0 - (_3278 * _3278), 0.0, 1.0));
        vec4 _3325 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_970, -_974)), _3273, 0.0, 0.0).xy, 0.0);
        float _3338 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _3275));
        vec3 _3363 = _3259 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_975, 0.0)).xyz, _3338).xyz, _3338).xyz * (vec3(_3325.x) + (_369 * _3325.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3260 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * ((2.0 * (acos(clamp(_3278 / sqrt(dot(_3286, _3286)), -1.0, 1.0)) + (acos(clamp(_3288 / (_3299 * sqrt(dot(_3290, _3290))), -1.0, 1.0)) - (acos(clamp((_3288 * _3278) / (_3289 * _3299), -1.0, 1.0)) * _3278)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _3278))));
        _3364 = _3363;
    }
    else
    {
        _3364 = _3259;
    }
    vec3 _3406;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _3406 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_314, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3260 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _322.xyz) * 1.0) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _3406 = vec3(0.0);
    }
    vec3 _3424 = (_3258 + _959) + (_3406 + spvNMax(vec3(0.0), _3364 / vec3(spvNMax(10.0, spvNMax(_3364.x, spvNMax(_3364.y, _3364.z))) * 0.100000001490116119384765625)));
    vec4 _3425 = vec4(_3424.x, _3424.y, _3424.z, vec4(0.0).w);
    _3425.w = 1.0;
    out_var_SV_TARGET = _3425;
    out_var_SV_TARGET1 = vec4((_3258 * cpass_cb.indirect_light_multiplier) + (_959 * 20.0), 1.0);
}

