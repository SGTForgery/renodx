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
    vec4 performance_overlay_data;
    ivec4 dynamic_light_indices;
    ivec4 animation_matrices_indices;
    ivec4 prev_animation_matrices_indices;
    float start_time;
    float roof_fade;
    uint object_scene_index;
    float flip_tangent;
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

const ivec2 _227[4] = ivec2[](ivec2(0), ivec2(1, 0), ivec2(0, 1), ivec2(1));
float _237;
vec4 _238;
float _242;
vec4 _243;

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
    vec2 maya_scale_pivot_0;
    uint constant_bool_0;
    int constant_trackG_1;
    uint frame_material_id;
    int constant_trackG_0;
    float brightness_0;
    float saturation_0;
    float constant1_0;
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
layout(set = 2, binding = 41) uniform texture2D muddle_texture_0;
layout(set = 2, binding = 42) uniform texture2D texture_object_0;
layout(set = 2, binding = 43) uniform texture2D input_texture_0;

layout(location = 0) in vec3 in_var_AUTO_GDFGMKIL_GEBKIEDD;
layout(location = 1) flat in uint in_var_INSTANCEID;
layout(location = 2) in vec4 in_var_TEXCOORD0;
layout(location = 3) in vec2 in_var_TEXCOORD1;
layout(location = 4) in vec3 in_var_TEXCOORD5;
layout(location = 5) in vec3 in_var_TEXCOORD6;
layout(location = 6) in vec3 in_var_TEXCOORD7;
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
    vec4 _277 = texture(sampler2D(muddle_texture_0, SamplerLinearWrap), (in_var_TEXCOORD1 * 1.0) + (vec2(-0.02999999932944774627685546875, 0.02999999932944774627685546875) * cpass_cb.time));
    vec2 _287 = vec2(cpipeline_cb.maya_scale_pivot_0.x, 1.0 - cpipeline_cb.maya_scale_pivot_0.y);
    float _296 = abs(1.0);
    vec2 _302 = ((((in_var_TEXCOORD1 + ((_277.xy - vec2(0.5)) * 0.0500000007450580596923828125)) - _287) * vec2(0.5)) + _287) + (vec2((cpipeline_cb.constant_bool_0 != 0u) ? pow(spvNMax(_296, 1.0000000116860974230803549289703e-07), cpipeline_cb.constant1_0) : cpass_cb.time) * vec2(0.0, 0.100000001490116119384765625));
    mat3 _303 = mat3(in_var_TEXCOORD6 / vec3(length(in_var_TEXCOORD6) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD7 / vec3(length(in_var_TEXCOORD7) + 1.0000000116860974230803549289703e-07), in_var_TEXCOORD5 / vec3(length(in_var_TEXCOORD5) + 1.0000000116860974230803549289703e-07));
    vec2 _317 = ((vec2(textureLod(sampler2D(texture_object_0, SamplerDynamicWrap), vec4(_302, 0.0, 1.0).xy, 1.0).xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _318 = vec3(_317.x, _317.y, vec3(0.0).z);
    vec2 _319 = _317.xy;
    _318.z = sqrt(spvNMax(1.0 - dot(_319, _319), 0.0));
    vec3 _325 = _303 * _318;
    vec4 _331 = texture(sampler2D(texture_object_0, SamplerDynamicWrap), _302);
    float _332 = _331.z;
    vec3 _337 = vec3(pow(spvNMax(abs(_332), 1.0000000116860974230803549289703e-07), 0.449999988079071044921875)) * (_325 / vec3(length(_325) + 1.0000000116860974230803549289703e-07));
    vec4 _340 = texture(sampler2D(input_texture_0, SamplerDynamicWrap), _302);
    vec3 _341 = _340.xyz;
    vec3 _343 = vec3(_340.w);
    vec3 _345 = clamp(mix(_341, vec3(0.0), _343), vec3(0.0), vec3(1.0));
    vec2 _351 = ((vec2(_331.xy) * 2.0) - vec2(1.0)) * 1.0;
    vec3 _352 = vec3(_351.x, _351.y, vec3(0.0).z);
    vec2 _353 = _351.xy;
    _352.z = sqrt(spvNMax(1.0 - dot(_353, _353), 0.0));
    float _359 = _331.w;
    float _368 = cpipeline_cb.hue_0 * 0.01745833270251750946044921875;
    float _369 = cos(_368);
    vec3 _384 = (((_341 * _369) + (cross(vec3(0.57735002040863037109375), _341) * sin(_368))) + ((vec3(0.57735002040863037109375) * dot(vec3(0.57735002040863037109375), _341)) * (1.0 - _369))) + vec3((cpipeline_cb.brightness_0 * 2.0) - 1.0);
    vec3 _392 = clamp(mix(vec3(0.039999999105930328369140625), mix(vec3(dot(_384, vec3(0.2989999949932098388671875, 0.58700001239776611328125, 0.114000000059604644775390625))), _384, vec3(cpipeline_cb.saturation_0 * 2.0)) * vec3(cpipeline_cb.constant_pixel_3), _343), vec3(0.0), vec3(1.0));
    bool _395 = cpipeline_cb.constant_trackG_0 < 0;
    float _397 = clamp(_332, 0.0, 1.0) * 127.0;
    int _401 = int(spvNMax(trunc(_397), 0.0) + 0.5);
    int _406 = int(spvNMin(trunc(_397 + 1.0), 127.0) + 0.5);
    float _424;
    if (_395)
    {
        _424 = 0.0;
    }
    else
    {
        uint _410 = uint(cpipeline_cb.constant_trackG_0);
        int _411 = _401 / 2;
        _424 = ((_401 - 2 * (_401 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_410].value[_411] & 65535u).x : unpackHalf2x16((spline_lut._m0[_410].value[_411] >> 16u) & 65535u).x;
    }
    float _442;
    if (_395)
    {
        _442 = 0.0;
    }
    else
    {
        uint _428 = uint(cpipeline_cb.constant_trackG_0);
        int _429 = _406 / 2;
        _442 = ((_406 - 2 * (_406 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_428].value[_429] & 65535u).x : unpackHalf2x16((spline_lut._m0[_428].value[_429] >> 16u) & 65535u).x;
    }
    float _443 = fract(_397);
    bool _449 = cpipeline_cb.constant_trackG_1 < 0;
    float _467;
    if (_449)
    {
        _467 = 0.0;
    }
    else
    {
        uint _453 = uint(cpipeline_cb.constant_trackG_1);
        int _454 = _401 / 2;
        _467 = ((_401 - 2 * (_401 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_453].value[_454] & 65535u).x : unpackHalf2x16((spline_lut._m0[_453].value[_454] >> 16u) & 65535u).x;
    }
    float _485;
    if (_449)
    {
        _485 = 0.0;
    }
    else
    {
        uint _471 = uint(cpipeline_cb.constant_trackG_1);
        int _472 = _406 / 2;
        _485 = ((_406 - 2 * (_406 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_471].value[_472] & 65535u).x : unpackHalf2x16((spline_lut._m0[_471].value[_472] >> 16u) & 65535u).x;
    }
    float _494 = clamp((spvNMax(vec3(mix(_424, _442, _443), _242, _242), vec3(0.0)) + spvNMax(vec3(mix(_467, _485, _443), _242, _242), vec3(0.0))).x, 0.0, 1.0) * 127.0;
    int _499 = int(spvNMax(trunc(_494), 0.0) + 0.5);
    int _504 = int(spvNMin(trunc(_494 + 1.0), 127.0) + 0.5);
    bool _505 = cpipeline_cb.constant_trackC_0.x < 0;
    float _523;
    if (_505)
    {
        _523 = 0.0;
    }
    else
    {
        uint _509 = uint(cpipeline_cb.constant_trackC_0.x);
        int _510 = _499 / 2;
        _523 = ((_499 - 2 * (_499 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_509].value[_510] & 65535u).x : unpackHalf2x16((spline_lut._m0[_509].value[_510] >> 16u) & 65535u).x;
    }
    float _541;
    if (_505)
    {
        _541 = 0.0;
    }
    else
    {
        uint _527 = uint(cpipeline_cb.constant_trackC_0.x);
        int _528 = _504 / 2;
        _541 = ((_504 - 2 * (_504 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_527].value[_528] & 65535u).x : unpackHalf2x16((spline_lut._m0[_527].value[_528] >> 16u) & 65535u).x;
    }
    float _542 = fract(_494);
    bool _545 = cpipeline_cb.constant_trackC_0.y < 0;
    float _563;
    if (_545)
    {
        _563 = 0.0;
    }
    else
    {
        uint _549 = uint(cpipeline_cb.constant_trackC_0.y);
        int _550 = _499 / 2;
        _563 = ((_499 - 2 * (_499 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_549].value[_550] & 65535u).x : unpackHalf2x16((spline_lut._m0[_549].value[_550] >> 16u) & 65535u).x;
    }
    float _581;
    if (_545)
    {
        _581 = 0.0;
    }
    else
    {
        uint _567 = uint(cpipeline_cb.constant_trackC_0.y);
        int _568 = _504 / 2;
        _581 = ((_504 - 2 * (_504 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_567].value[_568] & 65535u).x : unpackHalf2x16((spline_lut._m0[_567].value[_568] >> 16u) & 65535u).x;
    }
    bool _584 = cpipeline_cb.constant_trackC_0.z < 0;
    float _602;
    if (_584)
    {
        _602 = 0.0;
    }
    else
    {
        uint _588 = uint(cpipeline_cb.constant_trackC_0.z);
        int _589 = _499 / 2;
        _602 = ((_499 - 2 * (_499 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_588].value[_589] & 65535u).x : unpackHalf2x16((spline_lut._m0[_588].value[_589] >> 16u) & 65535u).x;
    }
    float _620;
    if (_584)
    {
        _620 = 0.0;
    }
    else
    {
        uint _606 = uint(cpipeline_cb.constant_trackC_0.z);
        int _607 = _504 / 2;
        _620 = ((_504 - 2 * (_504 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_606].value[_607] & 65535u).x : unpackHalf2x16((spline_lut._m0[_606].value[_607] >> 16u) & 65535u).x;
    }
    bool _623 = cpipeline_cb.constant_trackC_0.w < 0;
    float _641;
    if (_623)
    {
        _641 = 0.0;
    }
    else
    {
        uint _627 = uint(cpipeline_cb.constant_trackC_0.w);
        int _628 = _499 / 2;
        _641 = ((_499 - 2 * (_499 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_627].value[_628] & 65535u).x : unpackHalf2x16((spline_lut._m0[_627].value[_628] >> 16u) & 65535u).x;
    }
    float _659;
    if (_623)
    {
        _659 = 0.0;
    }
    else
    {
        uint _645 = uint(cpipeline_cb.constant_trackC_0.w);
        int _646 = _504 / 2;
        _659 = ((_504 - 2 * (_504 / 2)) == 0) ? unpackHalf2x16(spline_lut._m0[_645].value[_646] & 65535u).x : unpackHalf2x16((spline_lut._m0[_645].value[_646] >> 16u) & 65535u).x;
    }
    float _660 = mix(_641, _659, _542);
    vec3 _667 = spvNMin((vec4(mix(_523, _541, _542), mix(_563, _581, _542), mix(_602, _620, _542), _660).xyz * vec3(spvNMax(_660, 0.0))) * 5.0, vec3(100.0));
    vec4 _668;
    _668.w = _332;
    vec3 _670 = _303 * _352;
    vec3 _674 = _670 / vec3(spvNMax(1.0000000116860974230803549289703e-07, length(_670)));
    vec3 _678 = normalize(in_var_TEXCOORD0.xyz - cpass_cb.scene_camera_position);
    vec3 _679 = reflect(_678, _674);
    vec4 _682 = vec4(in_var_TEXCOORD0.x, in_var_TEXCOORD0.y, in_var_TEXCOORD0.z, _238.w);
    _682.w = 1.0;
    vec4 _684 = cpass_cb.scene_view_projection_transform * _682;
    vec4 _687 = _684 / vec4(_684.w);
    vec2 _690 = (_687.xy * 0.5) + vec2(0.5);
    float _691 = _690.y;
    float _692 = 1.0 - _691;
    float _693 = _690.x;
    vec3 _694 = vec3(_693, _692, _237);
    ivec2 _700 = ivec2(uvec2(cpass_cb.frame_resolution.xy + vec2(0.5)));
    vec2 _710 = vec2(1.0) / vec2(float(uint(_700.x) / 1u), float(uint(_700.y) / 1u));
    bool _726;
    if (cpass_cb.sh_probe_spacing > 0)
    {
        _726 = cpass_cb.ssgi_intensity > 0.5;
    }
    else
    {
        _726 = false;
    }
    vec4 _1074;
    if (_726)
    {
        vec3 _737 = clamp((cpass_cb.scene_view_transform * vec4(_674, 0.0)).xyz, vec3(-1.0), vec3(1.0));
        float _738 = _687.z;
        ivec2 _744 = ivec2(cpass_cb.sh_probe_spacing);
        ivec2 _745 = ivec2(uvec2(vec2(_700) * cpass_cb.frame_to_dynamic_scale.xy));
        vec4 _754 = cpass_cb.scene_view_projection_transform_inv * vec4((_693 * 2.0) - 1.0, (_691 * 2.0) - 1.0, _738, 1.0);
        vec3 _758 = (_754 / vec4(_754.w)).xyz;
        ivec2 _759 = _744 / ivec2(2);
        vec2 _760 = vec2(_744);
        vec2 _761 = vec2(1.0) / _760;
        vec2 _762 = vec2(_759);
        vec2 _765 = vec2(_745);
        vec2 _767 = vec2(1.0) / _765;
        vec2 _769 = (_762 + vec2(0.5)) * _767;
        vec2 _770 = _760 * _767;
        vec2 _772 = ((vec2(-0.5) - _762) * _761) + ((_765 * _761) * vec3(_693, _692, _738).xy);
        ivec2 _774 = ivec2(floor(_772));
        vec3 _247[4];
        for (int _777 = 0; _777 < 4; _777++)
        {
            ivec2 _785 = _774 + _227[_777];
            ivec2 _787 = _759 + (_744 * _785);
            int _788 = _787.x;
            bool _794;
            if (_788 >= 0)
            {
                _794 = _787.y >= 0;
            }
            else
            {
                _794 = false;
            }
            bool _799;
            if (_794)
            {
                _799 = _788 < _745.x;
            }
            else
            {
                _799 = false;
            }
            bool _805;
            if (_799)
            {
                _805 = _787.y < _745.y;
            }
            else
            {
                _805 = false;
            }
            vec4 _813;
            if (_805)
            {
                _813 = texelFetch(depth_sampler, ivec3(_788, _787.y, 0).xy, 0);
            }
            else
            {
                _813 = vec4(1.0);
            }
            vec2 _817 = clamp(_769 + (_770 * vec2(_785)), vec2(0.0), vec2(1.0));
            vec4 _827 = cpass_cb.scene_view_projection_transform_inv * vec4((_817.x * 2.0) - 1.0, ((1.0 - _817.y) * 2.0) - 1.0, _813.x, 1.0);
            _247[_777] = (_827 / vec4(_827.w)).xyz;
        }
        vec2 _839;
        _839 = fract(_772);
        for (int _842 = 0; _842 < 2; )
        {
            vec3 _847 = vec3(_839.y);
            vec3 _848 = mix(_247[0], _247[2], _847);
            vec3 _850 = mix(_247[1], _247[3], _847) - _848;
            float _855 = clamp(dot(_758 - _848, _850) / dot(_850, _850), 0.0, 1.0);
            vec3 _856 = vec3(_855);
            vec3 _857 = mix(_247[0], _247[1], _856);
            vec3 _859 = mix(_247[2], _247[3], _856) - _857;
            _839 = vec2(_855, clamp(dot(_758 - _857, _859) / dot(_859, _859), 0.0, 1.0));
            _842++;
            continue;
        }
        vec2 _866 = vec2(_774) + _839;
        uvec2 _873 = uvec2(textureSize(ambient_light_tex, 0));
        vec2 _881 = vec2(1.0) / vec2(float(int(_873.x)), float(int(_873.y)));
        uvec2 _883 = uvec2(ivec2(uvec2(cpass_cb.sh_atlas_size) / uvec2(2u)));
        vec2 _888 = ((vec2(uvec2(0u) * _883) + _866) + vec2(0.5)) * _881;
        vec2 _899 = ((vec2(uvec2(1u, 0u) * _883) + _866) + vec2(0.5)) * _881;
        vec2 _910 = ((vec2(uvec2(1u) * _883) + _866) + vec2(0.5)) * _881;
        vec2 _921 = ((vec2(uvec2(0u, 1u) * _883) + _866) + vec2(0.5)) * _881;
        mat4 _929 = transpose(mat4(textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_888, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_899, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_910, 0.0, 0.0).xy, 0.0), textureLod(sampler2D(ambient_light_tex, SamplerLinearClampNoBias), vec4(_921, 0.0, 0.0).xy, 0.0)));
        vec4 _1067;
        if (cpass_cb.gi_self_lighting != 0u)
        {
            vec4 _1041 = _929[0];
            vec4 _1047 = _929[1];
            vec4 _1053 = _929[2];
            vec4 _1059 = _929[3];
            _1067 = spvNMax(vec4(0.0), vec4(_1041.x + (dot(_1041.yzw, _737) * 2.0), _1047.x + (dot(_1047.yzw, _737) * 2.0), _1053.x + (dot(_1053.yzw, _737) * 2.0), _1059.x + (dot(_1059.yzw, _737) * 2.0)));
        }
        else
        {
            vec4 _936 = _929[0];
            vec3 _937 = _936.yzw;
            float _938 = length(_937);
            float _945 = _936.x;
            float _947 = _938 / spvNMax(1.0000000116860974230803549289703e-07, _945);
            float _948 = 2.0 * _947;
            float _953 = (1.0 - _947) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _947);
            vec4 _962 = _929[1];
            vec3 _963 = _962.yzw;
            float _964 = length(_963);
            float _971 = _962.x;
            float _973 = _964 / spvNMax(1.0000000116860974230803549289703e-07, _971);
            float _974 = 2.0 * _973;
            float _979 = (1.0 - _973) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _973);
            vec4 _988 = _929[2];
            vec3 _989 = _988.yzw;
            float _990 = length(_989);
            float _997 = _988.x;
            float _999 = _990 / spvNMax(1.0000000116860974230803549289703e-07, _997);
            float _1000 = 2.0 * _999;
            float _1005 = (1.0 - _999) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _999);
            vec4 _1014 = _929[3];
            vec3 _1015 = _1014.yzw;
            float _1016 = length(_1015);
            float _1023 = _1014.x;
            float _1025 = _1016 / spvNMax(1.0000000116860974230803549289703e-07, _1023);
            float _1026 = 2.0 * _1025;
            float _1031 = (1.0 - _1025) / spvNMax(1.0000000116860974230803549289703e-07, 1.0 + _1025);
            _1067 = vec4(_945 * (_953 + (((1.0 - _953) * (_948 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_937 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _938)), _737)), 0.0, 1.0), 1.0 + _948))), _971 * (_979 + (((1.0 - _979) * (_974 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_963 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _964)), _737)), 0.0, 1.0), 1.0 + _974))), _997 * (_1005 + (((1.0 - _1005) * (_1000 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_989 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _990)), _737)), 0.0, 1.0), 1.0 + _1000))), _1023 * (_1031 + (((1.0 - _1031) * (_1026 + 2.0)) * pow(clamp(0.5 * (1.0 + dot(_1015 / vec3(spvNMax(1.0000000116860974230803549289703e-07, _1016)), _737)), 0.0, 1.0), 1.0 + _1026))));
        }
        vec3 _1069 = _1067.xyz * 1.0;
        vec4 _1070 = vec4(_1069.x, _1069.y, _1069.z, _668.w);
        _1070.w = _332 * _1067.w;
        _1074 = _1070;
    }
    else
    {
        _1074 = vec4(vec4(0.0, 0.0, 0.0, 1.0).x, vec4(0.0, 0.0, 0.0, 1.0).y, vec4(0.0, 0.0, 0.0, 1.0).z, _668.w);
    }
    vec4 _1082 = textureLod(sampler2D(screenspace_shadowmap, SamplerLinearClamp), vec4((_694.xy / (_710 / cpass_cb.frame_to_dynamic_scale.xy)) * _710, 0.0, 0.0).xy, 0.0);
    vec4 _1086 = _1074 + vec4(_1082.x * 9.9999997473787516355514526367188e-05);
    uvec4 _1099 = texelFetch(light_lookup, ivec3((ivec2(gl_FragCoord.xy) * ivec2(cpass_cb.pass_downscale)) >> ivec2(6), 0).xy, 0);
    uint _1100 = _1099.x;
    uint _1101 = _1099.y;
    vec3 _1106;
    vec3 _1108;
    vec3 _1110;
    _1106 = vec3(0.0);
    _1108 = vec3(0.0);
    _1110 = vec3(0.0);
    uint _1104;
    vec3 _1107;
    vec3 _1109;
    vec3 _1111;
    for (uint _1103 = _1100, _1112 = 0u; _1112 < _1101; _1103 = _1104, _1106 = _1107, _1108 = _1109, _1110 = _1111, _1112++)
    {
        _1104 = _1103 + 1u;
        uvec4 _1118 = texelFetch(light_indices, int(_1103));
        uint _1119 = _1118.x;
        vec4 _1138;
        if (point_light_infos._m0[_1119].channel_index > (-0.5))
        {
            vec4 _1137;
            if (point_light_infos._m0[_1119].channel_index >= 2.5)
            {
                _1137 = vec4(0.0, 0.0, 0.0, 1.0);
            }
            else
            {
                vec4 _1136;
                if (point_light_infos._m0[_1119].channel_index >= 1.5)
                {
                    _1136 = vec4(0.0, 0.0, 1.0, 0.0);
                }
                else
                {
                    _1136 = mix(vec4(1.0, 0.0, 0.0, 0.0), vec4(0.0, 1.0, 0.0, 0.0), bvec4(point_light_infos._m0[_1119].channel_index >= 0.5));
                }
                _1137 = _1136;
            }
            _1138 = _1137;
        }
        else
        {
            _1138 = vec4(0.0);
        }
        vec3 _1168 = vec4(point_light_infos._m0[_1119].position, point_light_infos._m0[_1119].channel_index).xyz - in_var_TEXCOORD0.xyz;
        float _1169 = length(_1168);
        vec3 _1171 = _1168 / vec3(_1169);
        vec3 _1172 = vec4(point_light_infos._m0[_1119].color, point_light_infos._m0[_1119].median_radius).xyz;
        float _1179 = mix(7.071068286895751953125, 100.0, clamp(point_light_infos._m0[_1119].channel_index, 0.0, 1.0));
        float _1184 = (_1169 / (point_light_infos._m0[_1119].median_radius / _1179)) + 1.0;
        float _1185 = _1169 / (point_light_infos._m0[_1119].median_radius * sqrt(dot(abs(_1172), vec3(1.0)) * 2.0));
        float _1190 = clamp(1.0 - (((_1185 * _1185) * _1185) * _1185), 0.0, 1.0);
        vec3 _1197 = (_1172 * spvNMin(10.0, (((0.199999988079071044921875 * _1179) * _1179) * (_1190 * _1190)) / (_1184 * _1184))) * (dot(_1082, _1138) * clamp((dot(-normalize(_337), normalize(in_var_TEXCOORD0.xyz - point_light_infos._m0[_1119].position)) - (1.0 - length(_337))) * 2.5, 0.0, 1.0));
        if (length(_1197) > 0.0)
        {
            float _1203 = clamp(dot(_1171, _674), 0.0, 1.0);
            float _1206 = clamp(1.0 - _359, 0.0, 1.0);
            float _1208 = spvNMax(_1206 * _1206, 0.00200000009499490261077880859375);
            float _1209 = _1208 * _1208;
            vec3 _1210 = -_678;
            vec3 _1212 = normalize(_1210 + _1171);
            float _1214 = clamp(dot(_674, _1212), 0.0, 1.0);
            float _1218 = clamp(dot(_1210, _1212), 0.0, 1.0);
            float _1225 = _1208 * 0.5;
            float _1226 = 1.0 - _1225;
            _1107 = _1106 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _1218) - 6.9831600189208984375) * _1218)), vec3(1.0), _392) * (_1209 / pow((((_1209 - 1.0) * _1214) * _1214) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_1210, _674), 0.0, 1.0) * _1226) + _1225) * ((_1203 * _1226) + _1225)))) * _1203) * vec3(0.25)) * _1197);
            _1109 = _1108 + ((_1197 * _1203) * _345.xyz);
            _1111 = _1110 + _1197;
        }
        else
        {
            _1107 = _1106;
            _1109 = _1108;
            _1111 = _1110;
        }
    }
    uvec4 _1254 = uvec4(cobject_cb.instances[in_var_INSTANCEID / cobject_cb.instance_count].dynamic_light_indices);
    uint _1255 = _1254.x;
    uint _1258 = uint(dynamic_light_infos._m0[_1255].light_type.x);
    uint _1259 = _1254.y;
    uint _1262 = uint(dynamic_light_infos._m0[_1259].light_type.x);
    uint _1263 = _1254.z;
    uint _1266 = uint(dynamic_light_infos._m0[_1263].light_type.x);
    uint _1267 = _1254.w;
    uint _1270 = uint(dynamic_light_infos._m0[_1267].light_type.x);
    vec4 _1664;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1255].shadow_enabled.x > 0.0)
    {
        vec4 _1279 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1662;
        do
        {
            vec4 _1289 = dynamic_light_infos._m0[_1255].light_matrix * _1279;
            vec3 _1346;
            if (_1258 == 2u)
            {
                vec3 _1310 = _1289.xyz;
                vec3 _1312 = normalize(_1310) + vec3(0.0, 0.0, 1.0);
                float _1316 = length(_1310);
                vec3 _1319 = vec3((_1312 / vec3(_1312.z)).xy, _1316);
                float _1320 = _1289.z;
                vec3 _1332;
                if (_1320 > 0.0)
                {
                    _1332 = _1319;
                }
                else
                {
                    _1332 = vec3(normalize(_1319.xy) * 10000000.0, -_1316);
                }
                vec3 _1340 = vec3((_1332.x * 0.5) + 0.5, 0.5 - (_1332.y * 0.5), _1332.z);
                _1340.z = _1332.z * 9.9999997473787516355514526367188e-05;
                if (_1320 < 0.0)
                {
                    _1662 = 0.0;
                    break;
                }
                _1346 = _1340;
            }
            else
            {
                vec3 _1294 = _1289.xyz;
                vec3 _1306;
                if (_1258 == 1u)
                {
                    float _1298 = _1289.z;
                    vec3 _1305 = _1294;
                    _1305.z = _1298 - (((_1298 * dynamic_light_infos._m0[_1255].shadow_scale.z) + 1.0) / _1289.w);
                    _1306 = _1305;
                }
                else
                {
                    _1306 = _1294;
                }
                _1346 = _1306 / vec3(_1289.w);
            }
            float _1455;
            if (dynamic_light_infos._m0[_1255].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1437 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1346.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1346.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1346.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1346.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1255].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1346.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1346.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1255].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1346.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1346.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1255].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1346.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1346.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1255].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1346.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1346.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1255].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1455 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1255].shadow_scale.w * spvNMax(_1437, _1346.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1346.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1255].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1455 = 1.0;
            }
            vec3 _1456 = dFdx(_1346);
            vec3 _1457 = dFdy(_1346);
            vec3 _1471 = _1346 + ((normalize(cross(_1456, _1457)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _237) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw)).x);
            vec2 _1472 = dynamic_light_infos._m0[_1255].shadow_scale.xy * _1455;
            vec2 _1473 = _1471.xy;
            float _1478 = _1471.z;
            float _1557 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1473, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1478, 1.0).xy, _1478), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1473 + (vec2(1.0, 0.0) * _1472), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1478, 1.0).xy, _1478), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1473 + (vec2(0.5, 0.865999996662139892578125) * _1472), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1478, 1.0).xy, _1478), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1473 + (vec2(-0.5, 0.865999996662139892578125) * _1472), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1478, 1.0).xy, _1478), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1473 + (vec2(-1.0, -0.0) * _1472), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1478, 1.0).xy, _1478), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1473 + (vec2(-0.5, -0.865999996662139892578125) * _1472), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1478, 1.0).xy, _1478), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1473 + (vec2(0.5, -0.865999996662139892578125) * _1472), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1478, 1.0).xy, _1478), 0.0);
            float _1558 = _1557 * 0.14285714924335479736328125;
            float _1661;
            if (_1258 == 0u)
            {
                float _1573 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1279.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1575 = transpose(dynamic_light_infos._m0[_1255].light_matrix)[2];
                float _1580 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1589;
                if (_1580 > 0.100000001490116119384765625)
                {
                    _1589 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1589 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1600 = _1279.xyz - ((_1575.xyz / vec3(_1575.z)) * 1000.0);
                float _1624 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1589, _1600), dot(normalize(vec3(-_1589.y, _1589.x, 0.0)), _1600)) + (vec2(_1580, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1573 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1631 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1632 = _1631 - 1.0;
                float _1633 = 1.0 - cpass_cb.clouds_midpoint;
                float _1640 = 2.0 - _1631;
                _1661 = _1558 * mix(1.0, clamp(clamp(_1633 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1624), 0.0, 1.0), _1632)) * pow(clamp(_1633, 0.0, 1.0), _1640)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1624), 0.0, 1.0), _1632) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1640))), 0.0, 1.0) + (_1573 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1661 = _1558;
            }
            _1662 = _1661;
            break;
        } while(false);
        vec4 _1663 = vec4(1.0);
        _1663.x = _1662;
        _1664 = _1663;
    }
    else
    {
        _1664 = vec4(1.0);
    }
    vec4 _2058;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1259].shadow_enabled.x > 0.0)
    {
        vec4 _1673 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2056;
        do
        {
            vec4 _1683 = dynamic_light_infos._m0[_1259].light_matrix * _1673;
            vec3 _1740;
            if (_1262 == 2u)
            {
                vec3 _1704 = _1683.xyz;
                vec3 _1706 = normalize(_1704) + vec3(0.0, 0.0, 1.0);
                float _1710 = length(_1704);
                vec3 _1713 = vec3((_1706 / vec3(_1706.z)).xy, _1710);
                float _1714 = _1683.z;
                vec3 _1726;
                if (_1714 > 0.0)
                {
                    _1726 = _1713;
                }
                else
                {
                    _1726 = vec3(normalize(_1713.xy) * 10000000.0, -_1710);
                }
                vec3 _1734 = vec3((_1726.x * 0.5) + 0.5, 0.5 - (_1726.y * 0.5), _1726.z);
                _1734.z = _1726.z * 9.9999997473787516355514526367188e-05;
                if (_1714 < 0.0)
                {
                    _2056 = 0.0;
                    break;
                }
                _1740 = _1734;
            }
            else
            {
                vec3 _1688 = _1683.xyz;
                vec3 _1700;
                if (_1262 == 1u)
                {
                    float _1692 = _1683.z;
                    vec3 _1699 = _1688;
                    _1699.z = _1692 - (((_1692 * dynamic_light_infos._m0[_1259].shadow_scale.z) + 1.0) / _1683.w);
                    _1700 = _1699;
                }
                else
                {
                    _1700 = _1688;
                }
                _1740 = _1700 / vec3(_1683.w);
            }
            float _1849;
            if (dynamic_light_infos._m0[_1259].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1831 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1740.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1740.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1740.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1740.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1740.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1740.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1740.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1740.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1740.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1740.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1740.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1740.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1849 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1259].shadow_scale.w * spvNMax(_1831, _1740.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1740.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1849 = 1.0;
            }
            vec3 _1850 = dFdx(_1740);
            vec3 _1851 = dFdy(_1740);
            vec3 _1865 = _1740 + ((normalize(cross(_1850, _1851)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _237) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw)).x);
            vec2 _1866 = dynamic_light_infos._m0[_1259].shadow_scale.xy * _1849;
            vec2 _1867 = _1865.xy;
            float _1872 = _1865.z;
            float _1951 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1867, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1872, 1.0).xy, _1872), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1867 + (vec2(1.0, 0.0) * _1866), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1872, 1.0).xy, _1872), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1867 + (vec2(0.5, 0.865999996662139892578125) * _1866), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1872, 1.0).xy, _1872), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1867 + (vec2(-0.5, 0.865999996662139892578125) * _1866), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1872, 1.0).xy, _1872), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1867 + (vec2(-1.0, -0.0) * _1866), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1872, 1.0).xy, _1872), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1867 + (vec2(-0.5, -0.865999996662139892578125) * _1866), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1872, 1.0).xy, _1872), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1867 + (vec2(0.5, -0.865999996662139892578125) * _1866), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1872, 1.0).xy, _1872), 0.0);
            float _1952 = _1951 * 0.14285714924335479736328125;
            float _2055;
            if (_1262 == 0u)
            {
                float _1967 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1673.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1969 = transpose(dynamic_light_infos._m0[_1259].light_matrix)[2];
                float _1974 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1983;
                if (_1974 > 0.100000001490116119384765625)
                {
                    _1983 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1983 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1994 = _1673.xyz - ((_1969.xyz / vec3(_1969.z)) * 1000.0);
                float _2018 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1983, _1994), dot(normalize(vec3(-_1983.y, _1983.x, 0.0)), _1994)) + (vec2(_1974, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1967 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2025 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2026 = _2025 - 1.0;
                float _2027 = 1.0 - cpass_cb.clouds_midpoint;
                float _2034 = 2.0 - _2025;
                _2055 = _1952 * mix(1.0, clamp(clamp(_2027 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2018), 0.0, 1.0), _2026)) * pow(clamp(_2027, 0.0, 1.0), _2034)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2018), 0.0, 1.0), _2026) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2034))), 0.0, 1.0) + (_1967 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2055 = _1952;
            }
            _2056 = _2055;
            break;
        } while(false);
        vec4 _2057 = _1664;
        _2057.y = _2056;
        _2058 = _2057;
    }
    else
    {
        _2058 = _1664;
    }
    vec4 _2452;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1263].shadow_enabled.x > 0.0)
    {
        vec4 _2067 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2450;
        do
        {
            vec4 _2077 = dynamic_light_infos._m0[_1263].light_matrix * _2067;
            vec3 _2134;
            if (_1266 == 2u)
            {
                vec3 _2098 = _2077.xyz;
                vec3 _2100 = normalize(_2098) + vec3(0.0, 0.0, 1.0);
                float _2104 = length(_2098);
                vec3 _2107 = vec3((_2100 / vec3(_2100.z)).xy, _2104);
                float _2108 = _2077.z;
                vec3 _2120;
                if (_2108 > 0.0)
                {
                    _2120 = _2107;
                }
                else
                {
                    _2120 = vec3(normalize(_2107.xy) * 10000000.0, -_2104);
                }
                vec3 _2128 = vec3((_2120.x * 0.5) + 0.5, 0.5 - (_2120.y * 0.5), _2120.z);
                _2128.z = _2120.z * 9.9999997473787516355514526367188e-05;
                if (_2108 < 0.0)
                {
                    _2450 = 0.0;
                    break;
                }
                _2134 = _2128;
            }
            else
            {
                vec3 _2082 = _2077.xyz;
                vec3 _2094;
                if (_1266 == 1u)
                {
                    float _2086 = _2077.z;
                    vec3 _2093 = _2082;
                    _2093.z = _2086 - (((_2086 * dynamic_light_infos._m0[_1263].shadow_scale.z) + 1.0) / _2077.w);
                    _2094 = _2093;
                }
                else
                {
                    _2094 = _2082;
                }
                _2134 = _2094 / vec3(_2077.w);
            }
            float _2243;
            if (dynamic_light_infos._m0[_1263].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2225 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2134.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2134.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2134.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2134.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2134.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2134.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2134.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2134.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2134.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2134.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2134.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2134.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2243 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1263].shadow_scale.w * spvNMax(_2225, _2134.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2134.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2243 = 1.0;
            }
            vec3 _2244 = dFdx(_2134);
            vec3 _2245 = dFdy(_2134);
            vec3 _2259 = _2134 + ((normalize(cross(_2244, _2245)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _237) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw)).x);
            vec2 _2260 = dynamic_light_infos._m0[_1263].shadow_scale.xy * _2243;
            vec2 _2261 = _2259.xy;
            float _2266 = _2259.z;
            float _2345 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2261, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2266, 1.0).xy, _2266), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2261 + (vec2(1.0, 0.0) * _2260), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2266, 1.0).xy, _2266), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2261 + (vec2(0.5, 0.865999996662139892578125) * _2260), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2266, 1.0).xy, _2266), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2261 + (vec2(-0.5, 0.865999996662139892578125) * _2260), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2266, 1.0).xy, _2266), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2261 + (vec2(-1.0, -0.0) * _2260), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2266, 1.0).xy, _2266), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2261 + (vec2(-0.5, -0.865999996662139892578125) * _2260), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2266, 1.0).xy, _2266), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2261 + (vec2(0.5, -0.865999996662139892578125) * _2260), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2266, 1.0).xy, _2266), 0.0);
            float _2346 = _2345 * 0.14285714924335479736328125;
            float _2449;
            if (_1266 == 0u)
            {
                float _2361 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2067.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2363 = transpose(dynamic_light_infos._m0[_1263].light_matrix)[2];
                float _2368 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2377;
                if (_2368 > 0.100000001490116119384765625)
                {
                    _2377 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2377 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2388 = _2067.xyz - ((_2363.xyz / vec3(_2363.z)) * 1000.0);
                float _2412 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2377, _2388), dot(normalize(vec3(-_2377.y, _2377.x, 0.0)), _2388)) + (vec2(_2368, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2361 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2419 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2420 = _2419 - 1.0;
                float _2421 = 1.0 - cpass_cb.clouds_midpoint;
                float _2428 = 2.0 - _2419;
                _2449 = _2346 * mix(1.0, clamp(clamp(_2421 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2412), 0.0, 1.0), _2420)) * pow(clamp(_2421, 0.0, 1.0), _2428)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2412), 0.0, 1.0), _2420) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2428))), 0.0, 1.0) + (_2361 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2449 = _2346;
            }
            _2450 = _2449;
            break;
        } while(false);
        vec4 _2451 = _2058;
        _2451.z = _2450;
        _2452 = _2451;
    }
    else
    {
        _2452 = _2058;
    }
    vec4 _2846;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1267].shadow_enabled.x > 0.0)
    {
        vec4 _2461 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2844;
        do
        {
            vec4 _2471 = dynamic_light_infos._m0[_1267].light_matrix * _2461;
            vec3 _2528;
            if (_1270 == 2u)
            {
                vec3 _2492 = _2471.xyz;
                vec3 _2494 = normalize(_2492) + vec3(0.0, 0.0, 1.0);
                float _2498 = length(_2492);
                vec3 _2501 = vec3((_2494 / vec3(_2494.z)).xy, _2498);
                float _2502 = _2471.z;
                vec3 _2514;
                if (_2502 > 0.0)
                {
                    _2514 = _2501;
                }
                else
                {
                    _2514 = vec3(normalize(_2501.xy) * 10000000.0, -_2498);
                }
                vec3 _2522 = vec3((_2514.x * 0.5) + 0.5, 0.5 - (_2514.y * 0.5), _2514.z);
                _2522.z = _2514.z * 9.9999997473787516355514526367188e-05;
                if (_2502 < 0.0)
                {
                    _2844 = 0.0;
                    break;
                }
                _2528 = _2522;
            }
            else
            {
                vec3 _2476 = _2471.xyz;
                vec3 _2488;
                if (_1270 == 1u)
                {
                    float _2480 = _2471.z;
                    vec3 _2487 = _2476;
                    _2487.z = _2480 - (((_2480 * dynamic_light_infos._m0[_1267].shadow_scale.z) + 1.0) / _2471.w);
                    _2488 = _2487;
                }
                else
                {
                    _2488 = _2476;
                }
                _2528 = _2488 / vec3(_2471.w);
            }
            float _2637;
            if (dynamic_light_infos._m0[_1267].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2619 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2528.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2528.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2528.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2528.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2528.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2528.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2528.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2528.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2528.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2528.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2528.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2528.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2637 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1267].shadow_scale.w * spvNMax(_2619, _2528.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2528.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2637 = 1.0;
            }
            vec3 _2638 = dFdx(_2528);
            vec3 _2639 = dFdy(_2528);
            vec3 _2653 = _2528 + ((normalize(cross(_2638, _2639)) * (-1.0)) * (vec2(1.0) / (vec2(float(int(uvec2(textureSize(tex_shadow_map_atlas, 0)).x)), _237) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw)).x);
            vec2 _2654 = dynamic_light_infos._m0[_1267].shadow_scale.xy * _2637;
            vec2 _2655 = _2653.xy;
            float _2660 = _2653.z;
            float _2739 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2655, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2660, 1.0).xy, _2660), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2655 + (vec2(1.0, 0.0) * _2654), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2660, 1.0).xy, _2660), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2655 + (vec2(0.5, 0.865999996662139892578125) * _2654), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2660, 1.0).xy, _2660), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2655 + (vec2(-0.5, 0.865999996662139892578125) * _2654), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2660, 1.0).xy, _2660), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2655 + (vec2(-1.0, -0.0) * _2654), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2660, 1.0).xy, _2660), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2655 + (vec2(-0.5, -0.865999996662139892578125) * _2654), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2660, 1.0).xy, _2660), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2655 + (vec2(0.5, -0.865999996662139892578125) * _2654), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2660, 1.0).xy, _2660), 0.0);
            float _2740 = _2739 * 0.14285714924335479736328125;
            float _2843;
            if (_1270 == 0u)
            {
                float _2755 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2461.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2757 = transpose(dynamic_light_infos._m0[_1267].light_matrix)[2];
                float _2762 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2771;
                if (_2762 > 0.100000001490116119384765625)
                {
                    _2771 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2771 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2782 = _2461.xyz - ((_2757.xyz / vec3(_2757.z)) * 1000.0);
                float _2806 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2771, _2782), dot(normalize(vec3(-_2771.y, _2771.x, 0.0)), _2782)) + (vec2(_2762, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2755 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2813 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2814 = _2813 - 1.0;
                float _2815 = 1.0 - cpass_cb.clouds_midpoint;
                float _2822 = 2.0 - _2813;
                _2843 = _2740 * mix(1.0, clamp(clamp(_2815 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2806), 0.0, 1.0), _2814)) * pow(clamp(_2815, 0.0, 1.0), _2822)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2806), 0.0, 1.0), _2814) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2822))), 0.0, 1.0) + (_2755 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2843 = _2740;
            }
            _2844 = _2843;
            break;
        } while(false);
        vec4 _2845 = _2452;
        _2845.w = _2844;
        _2846 = _2845;
    }
    else
    {
        _2846 = _2452;
    }
    vec3 _2913;
    vec3 _2914;
    switch (_1258)
    {
        case 0u:
        {
            _2913 = dynamic_light_infos._m0[_1255].light_color.xyz;
            _2914 = -dynamic_light_infos._m0[_1255].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _2890 = dynamic_light_infos._m0[_1255].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2891 = length(_2890);
            vec3 _2893 = _2890 / vec3(_2891);
            _2913 = dynamic_light_infos._m0[_1255].light_color.xyz * ((1.0 - clamp(_2891 / dynamic_light_infos._m0[_1255].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1255].light_direction.xyz, _2893) - dynamic_light_infos._m0[_1255].light_direction.w) / (dynamic_light_infos._m0[_1255].light_position.w - dynamic_light_infos._m0[_1255].light_direction.w), 0.0, 1.0));
            _2914 = _2893;
            break;
        }
        case 2u:
        {
            vec3 _2858 = dynamic_light_infos._m0[_1255].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2859 = length(_2858);
            float _2871 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1255].light_position.w, 0.0, 1.0));
            float _2876 = (_2859 / (dynamic_light_infos._m0[_1255].light_color.w / _2871)) + 1.0;
            float _2877 = _2859 / (dynamic_light_infos._m0[_1255].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1255].light_color.xyz), vec3(1.0)) * 2.0));
            float _2882 = clamp(1.0 - (((_2877 * _2877) * _2877) * _2877), 0.0, 1.0);
            _2913 = dynamic_light_infos._m0[_1255].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _2871) * _2871) * (_2882 * _2882)) / (_2876 * _2876));
            _2914 = _2858 / vec3(_2859);
            break;
        }
        default:
        {
            _2913 = vec3(0.0);
            _2914 = vec3(0.0);
            break;
        }
    }
    vec3 _2916 = normalize(_337);
    vec3 _2918 = -_2916;
    float _2920 = 1.0 - length(_337);
    vec3 _2926 = _2913 * (_2846.x * clamp((dot(_2918, -_2914) - _2920) * 2.5, 0.0, 1.0));
    vec3 _2978;
    vec3 _2979;
    vec3 _2980;
    if (length(_2926) > 0.0)
    {
        float _2932 = clamp(dot(_2914, _674), 0.0, 1.0);
        float _2935 = clamp(1.0 - _359, 0.0, 1.0);
        float _2937 = spvNMax(_2935 * _2935, 0.00200000009499490261077880859375);
        float _2938 = _2937 * _2937;
        vec3 _2939 = -_678;
        vec3 _2941 = normalize(_2939 + _2914);
        float _2943 = clamp(dot(_674, _2941), 0.0, 1.0);
        float _2947 = clamp(dot(_2939, _2941), 0.0, 1.0);
        float _2954 = _2937 * 0.5;
        float _2955 = 1.0 - _2954;
        _2978 = _1106 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _2947) - 6.9831600189208984375) * _2947)), vec3(1.0), _392) * (_2938 / pow((((_2938 - 1.0) * _2943) * _2943) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_2939, _674), 0.0, 1.0) * _2955) + _2954) * ((_2932 * _2955) + _2954)))) * _2932) * vec3(0.25)) * _2926);
        _2979 = _1108 + ((_2926 * _2932) * _345.xyz);
        _2980 = _1110 + _2926;
    }
    else
    {
        _2978 = _1106;
        _2979 = _1108;
        _2980 = _1110;
    }
    vec3 _3047;
    vec3 _3048;
    switch (_1262)
    {
        case 0u:
        {
            _3047 = dynamic_light_infos._m0[_1259].light_color.xyz;
            _3048 = -dynamic_light_infos._m0[_1259].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3024 = dynamic_light_infos._m0[_1259].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3025 = length(_3024);
            vec3 _3027 = _3024 / vec3(_3025);
            _3047 = dynamic_light_infos._m0[_1259].light_color.xyz * ((1.0 - clamp(_3025 / dynamic_light_infos._m0[_1259].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1259].light_direction.xyz, _3027) - dynamic_light_infos._m0[_1259].light_direction.w) / (dynamic_light_infos._m0[_1259].light_position.w - dynamic_light_infos._m0[_1259].light_direction.w), 0.0, 1.0));
            _3048 = _3027;
            break;
        }
        case 2u:
        {
            vec3 _2992 = dynamic_light_infos._m0[_1259].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2993 = length(_2992);
            float _3005 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1259].light_position.w, 0.0, 1.0));
            float _3010 = (_2993 / (dynamic_light_infos._m0[_1259].light_color.w / _3005)) + 1.0;
            float _3011 = _2993 / (dynamic_light_infos._m0[_1259].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1259].light_color.xyz), vec3(1.0)) * 2.0));
            float _3016 = clamp(1.0 - (((_3011 * _3011) * _3011) * _3011), 0.0, 1.0);
            _3047 = dynamic_light_infos._m0[_1259].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3005) * _3005) * (_3016 * _3016)) / (_3010 * _3010));
            _3048 = _2992 / vec3(_2993);
            break;
        }
        default:
        {
            _3047 = vec3(0.0);
            _3048 = vec3(0.0);
            break;
        }
    }
    vec3 _3056 = _3047 * (_2846.y * clamp((dot(_2918, -_3048) - _2920) * 2.5, 0.0, 1.0));
    vec3 _3108;
    vec3 _3109;
    vec3 _3110;
    if (length(_3056) > 0.0)
    {
        float _3062 = clamp(dot(_3048, _674), 0.0, 1.0);
        float _3065 = clamp(1.0 - _359, 0.0, 1.0);
        float _3067 = spvNMax(_3065 * _3065, 0.00200000009499490261077880859375);
        float _3068 = _3067 * _3067;
        vec3 _3069 = -_678;
        vec3 _3071 = normalize(_3069 + _3048);
        float _3073 = clamp(dot(_674, _3071), 0.0, 1.0);
        float _3077 = clamp(dot(_3069, _3071), 0.0, 1.0);
        float _3084 = _3067 * 0.5;
        float _3085 = 1.0 - _3084;
        _3108 = _2978 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3077) - 6.9831600189208984375) * _3077)), vec3(1.0), _392) * (_3068 / pow((((_3068 - 1.0) * _3073) * _3073) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3069, _674), 0.0, 1.0) * _3085) + _3084) * ((_3062 * _3085) + _3084)))) * _3062) * vec3(0.25)) * _3056);
        _3109 = _2979 + ((_3056 * _3062) * _345.xyz);
        _3110 = _2980 + _3056;
    }
    else
    {
        _3108 = _2978;
        _3109 = _2979;
        _3110 = _2980;
    }
    vec3 _3177;
    vec3 _3178;
    switch (_1266)
    {
        case 0u:
        {
            _3177 = dynamic_light_infos._m0[_1263].light_color.xyz;
            _3178 = -dynamic_light_infos._m0[_1263].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3154 = dynamic_light_infos._m0[_1263].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3155 = length(_3154);
            vec3 _3157 = _3154 / vec3(_3155);
            _3177 = dynamic_light_infos._m0[_1263].light_color.xyz * ((1.0 - clamp(_3155 / dynamic_light_infos._m0[_1263].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1263].light_direction.xyz, _3157) - dynamic_light_infos._m0[_1263].light_direction.w) / (dynamic_light_infos._m0[_1263].light_position.w - dynamic_light_infos._m0[_1263].light_direction.w), 0.0, 1.0));
            _3178 = _3157;
            break;
        }
        case 2u:
        {
            vec3 _3122 = dynamic_light_infos._m0[_1263].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3123 = length(_3122);
            float _3135 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1263].light_position.w, 0.0, 1.0));
            float _3140 = (_3123 / (dynamic_light_infos._m0[_1263].light_color.w / _3135)) + 1.0;
            float _3141 = _3123 / (dynamic_light_infos._m0[_1263].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1263].light_color.xyz), vec3(1.0)) * 2.0));
            float _3146 = clamp(1.0 - (((_3141 * _3141) * _3141) * _3141), 0.0, 1.0);
            _3177 = dynamic_light_infos._m0[_1263].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3135) * _3135) * (_3146 * _3146)) / (_3140 * _3140));
            _3178 = _3122 / vec3(_3123);
            break;
        }
        default:
        {
            _3177 = vec3(0.0);
            _3178 = vec3(0.0);
            break;
        }
    }
    vec3 _3186 = _3177 * (_2846.z * clamp((dot(_2918, -_3178) - _2920) * 2.5, 0.0, 1.0));
    vec3 _3238;
    vec3 _3239;
    vec3 _3240;
    if (length(_3186) > 0.0)
    {
        float _3192 = clamp(dot(_3178, _674), 0.0, 1.0);
        float _3195 = clamp(1.0 - _359, 0.0, 1.0);
        float _3197 = spvNMax(_3195 * _3195, 0.00200000009499490261077880859375);
        float _3198 = _3197 * _3197;
        vec3 _3199 = -_678;
        vec3 _3201 = normalize(_3199 + _3178);
        float _3203 = clamp(dot(_674, _3201), 0.0, 1.0);
        float _3207 = clamp(dot(_3199, _3201), 0.0, 1.0);
        float _3214 = _3197 * 0.5;
        float _3215 = 1.0 - _3214;
        _3238 = _3108 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3207) - 6.9831600189208984375) * _3207)), vec3(1.0), _392) * (_3198 / pow((((_3198 - 1.0) * _3203) * _3203) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3199, _674), 0.0, 1.0) * _3215) + _3214) * ((_3192 * _3215) + _3214)))) * _3192) * vec3(0.25)) * _3186);
        _3239 = _3109 + ((_3186 * _3192) * _345.xyz);
        _3240 = _3110 + _3186;
    }
    else
    {
        _3238 = _3108;
        _3239 = _3109;
        _3240 = _3110;
    }
    vec3 _3307;
    vec3 _3308;
    switch (_1270)
    {
        case 0u:
        {
            _3307 = dynamic_light_infos._m0[_1267].light_color.xyz;
            _3308 = -dynamic_light_infos._m0[_1267].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3284 = dynamic_light_infos._m0[_1267].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3285 = length(_3284);
            vec3 _3287 = _3284 / vec3(_3285);
            _3307 = dynamic_light_infos._m0[_1267].light_color.xyz * ((1.0 - clamp(_3285 / dynamic_light_infos._m0[_1267].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1267].light_direction.xyz, _3287) - dynamic_light_infos._m0[_1267].light_direction.w) / (dynamic_light_infos._m0[_1267].light_position.w - dynamic_light_infos._m0[_1267].light_direction.w), 0.0, 1.0));
            _3308 = _3287;
            break;
        }
        case 2u:
        {
            vec3 _3252 = dynamic_light_infos._m0[_1267].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3253 = length(_3252);
            float _3265 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1267].light_position.w, 0.0, 1.0));
            float _3270 = (_3253 / (dynamic_light_infos._m0[_1267].light_color.w / _3265)) + 1.0;
            float _3271 = _3253 / (dynamic_light_infos._m0[_1267].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1267].light_color.xyz), vec3(1.0)) * 2.0));
            float _3276 = clamp(1.0 - (((_3271 * _3271) * _3271) * _3271), 0.0, 1.0);
            _3307 = dynamic_light_infos._m0[_1267].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3265) * _3265) * (_3276 * _3276)) / (_3270 * _3270));
            _3308 = _3252 / vec3(_3253);
            break;
        }
        default:
        {
            _3307 = vec3(0.0);
            _3308 = vec3(0.0);
            break;
        }
    }
    vec3 _3316 = _3307 * (_2846.w * clamp((dot(_2918, -_3308) - _2920) * 2.5, 0.0, 1.0));
    vec3 _3368;
    vec3 _3369;
    vec3 _3370;
    if (length(_3316) > 0.0)
    {
        float _3322 = clamp(dot(_3308, _674), 0.0, 1.0);
        float _3325 = clamp(1.0 - _359, 0.0, 1.0);
        float _3327 = spvNMax(_3325 * _3325, 0.00200000009499490261077880859375);
        float _3328 = _3327 * _3327;
        vec3 _3329 = -_678;
        vec3 _3331 = normalize(_3329 + _3308);
        float _3333 = clamp(dot(_674, _3331), 0.0, 1.0);
        float _3337 = clamp(dot(_3329, _3331), 0.0, 1.0);
        float _3344 = _3327 * 0.5;
        float _3345 = 1.0 - _3344;
        _3368 = _3239 + ((_3316 * _3322) * _345.xyz);
        _3369 = _3238 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3337) - 6.9831600189208984375) * _3337)), vec3(1.0), _392) * (_3328 / pow((((_3328 - 1.0) * _3333) * _3333) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3329, _674), 0.0, 1.0) * _3345) + _3344) * ((_3322 * _3345) + _3344)))) * _3322) * vec3(0.25)) * _3316);
        _3370 = _3240 + _3316;
    }
    else
    {
        _3368 = _3239;
        _3369 = _3238;
        _3370 = _3240;
    }
    vec3 _3493;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _3383 = _1086.w;
        float _3384 = clamp(_359, 0.0, 1.0);
        float _3387 = sqrt(clamp(1.0 - _3383, 0.0, 1.0));
        float _3388 = 1.0 - _3384;
        float _3389 = _3388 * _3388;
        float _3392 = clamp(exp((-2.2999999523162841796875) * _3389), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _3393 = dot(_2916, _679);
        float _3399 = sqrt(clamp(1.0 - (_3393 * _3393), 0.0, 1.0));
        float _3401 = _3392 - (_3393 * _3387);
        float _3402 = _3399 * _3387;
        vec2 _3403 = vec2(_3401, _3402);
        float _3405 = _3387 - (_3393 * _3392);
        float _3406 = _3399 * _3392;
        vec2 _3407 = vec2(_3405, _3406);
        float _3411 = sqrt(clamp(1.0 - (_3387 * _3387), 0.0, 1.0));
        float _3428 = sqrt(clamp(1.0 - (_3392 * _3392), 0.0, 1.0));
        vec4 _3454 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_674, -_678)), _3384, 0.0, 0.0).xy, 0.0);
        float _3467 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _3389));
        vec3 _3492 = _3369 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_679, 0.0)).xyz, _3467).xyz, _3467).xyz * (vec3(_3454.x) + (_392 * _3454.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3370 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * (_3383 * ((2.0 * ((acos(clamp(_3401 / (_3411 * sqrt(dot(_3403, _3403))), -1.0, 1.0)) - (acos(clamp((_3401 * _3387) / (_3402 * _3411), -1.0, 1.0)) * _3387)) + (acos(clamp(_3405 / (_3428 * sqrt(dot(_3407, _3407))), -1.0, 1.0)) - (acos(clamp((_3405 * _3392) / (_3406 * _3428), -1.0, 1.0)) * _3392)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _3392)))));
        _3493 = _3492;
    }
    else
    {
        _3493 = _3369;
    }
    vec3 _3505 = _345.xyz;
    vec3 _3536;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _3536 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_337, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3370 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _3505) * _1086.w) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _3536 = vec3(0.0);
    }
    vec3 _3557 = (_3368 + _667) + (((_1086.xyz * _3505) + _3536) + spvNMax(vec3(0.0), _3493 / vec3(spvNMax(10.0, spvNMax(_3493.x, spvNMax(_3493.y, _3493.z))) * 0.100000001490116119384765625)));
    vec4 _3558 = vec4(_3557.x, _3557.y, _3557.z, vec4(0.0).w);
    _3558.w = 1.0;
    vec3 _3560 = in_var_TEXCOORD0.xyz - in_var_AUTO_GDFGMKIL_GEBKIEDD;
    vec4 _3563 = vec4(_3560.x, _3560.y, _3560.z, _238.w);
    _3563.w = 1.0;
    vec4 _3565 = cpass_cb.last_view_projection_transform * _3563;
    vec2 _3571 = ((_3565 / vec4(_3565.w)).xy * 0.5) + vec2(0.5);
    out_var_SV_TARGET = _3558;
    out_var_SV_TARGET2 = vec4((_3368 * cpass_cb.indirect_light_multiplier) + (_667 * 20.0), 1.0);
    out_var_SV_TARGET1 = vec4(((_694 - vec3(_3571.x, 1.0 - _3571.y, _237)) * vec3(ivec3(ivec2(uvec2((cpass_cb.frame_resolution.xy * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))), 0))).xy, 0.0, 0.0);
}

