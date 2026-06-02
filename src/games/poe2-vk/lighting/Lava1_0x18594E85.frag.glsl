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

layout(set = 5, binding = 0, std140) uniform type_cobject_cb
{
    uint instance_count;
    uint batch_size;
    uint padding0;
    uint padding1;
    InstanceData instances[16];
} cobject_cb;

layout(set = 2, binding = 39, std430) readonly buffer type_StructuredBuffer_LightInfo
{
    LightInfo _m0[];
} dynamic_light_infos;

layout(set = 2, binding = 40, std430) readonly buffer type_StructuredBuffer_PointLightInfo
{
    PointLightInfo _m0[];
} point_light_infos;

layout(set = 2, binding = 41, std430) readonly buffer type_StructuredBuffer_LUTData
{
    LUTData _m0[];
} spline_lut;

layout(set = 0, binding = 0) uniform sampler SamplerLinearWrap;
layout(set = 0, binding = 1) uniform sampler SamplerLinearClamp;
layout(set = 0, binding = 7) uniform sampler SamplerDynamicWrap;
layout(set = 0, binding = 8) uniform sampler SamplerLinearWrapNoBias;
layout(set = 0, binding = 9) uniform sampler SamplerLinearClampNoBias;
layout(set = 0, binding = 15) uniform samplerShadow SamplerDepth;
layout(set = 2, binding = 26) uniform textureCube diffuse_cube;
layout(set = 2, binding = 27) uniform textureCube specular_cube;
layout(set = 2, binding = 28) uniform texture2D environment_ggx_sampler;
layout(set = 2, binding = 29) uniform texture2D ambient_light_tex;
layout(set = 2, binding = 30) uniform texture2D screenspace_shadowmap;
layout(set = 2, binding = 31) uniform texture2D noise_sampler;
layout(set = 2, binding = 32) uniform texture2D tex_shadow_map_atlas;
layout(set = 2, binding = 33) uniform texture2D depth_sampler;
layout(set = 2, binding = 34) uniform texture2D muddle_texture_0;
layout(set = 2, binding = 35) uniform texture2D texture_object_0;
layout(set = 2, binding = 36) uniform texture2D input_texture_0;
layout(set = 2, binding = 37) uniform utexture2D light_lookup;
layout(set = 2, binding = 38) uniform usamplerBuffer light_indices;

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
    vec4 _1649;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1255].shadow_enabled.x > 0.0)
    {
        vec4 _1279 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _1647;
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
                    _1647 = 0.0;
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
            vec2 _1456 = dynamic_light_infos._m0[_1255].shadow_scale.xy * _1455;
            float _1542 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1346.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1346.z, 1.0).xy, _1346.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1346.xy + (vec2(1.0, 0.0) * _1456), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1346.z, 1.0).xy, _1346.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1346.xy + (vec2(0.5, 0.865999996662139892578125) * _1456), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1346.z, 1.0).xy, _1346.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1346.xy + (vec2(-0.5, 0.865999996662139892578125) * _1456), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1346.z, 1.0).xy, _1346.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1346.xy + (vec2(-1.0, -0.0) * _1456), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1346.z, 1.0).xy, _1346.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1346.xy + (vec2(-0.5, -0.865999996662139892578125) * _1456), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1346.z, 1.0).xy, _1346.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1346.xy + (vec2(0.5, -0.865999996662139892578125) * _1456), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1255].shadow_atlas_offset_scale.xy, _1346.z, 1.0).xy, _1346.z), 0.0);
            float _1543 = _1542 * 0.14285714924335479736328125;
            float _1646;
            if (_1258 == 0u)
            {
                float _1558 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1279.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1560 = transpose(dynamic_light_infos._m0[_1255].light_matrix)[2];
                float _1565 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1574;
                if (_1565 > 0.100000001490116119384765625)
                {
                    _1574 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1574 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1585 = _1279.xyz - ((_1560.xyz / vec3(_1560.z)) * 1000.0);
                float _1609 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1574, _1585), dot(normalize(vec3(-_1574.y, _1574.x, 0.0)), _1585)) + (vec2(_1565, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1558 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1616 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1617 = _1616 - 1.0;
                float _1618 = 1.0 - cpass_cb.clouds_midpoint;
                float _1625 = 2.0 - _1616;
                _1646 = _1543 * mix(1.0, clamp(clamp(_1618 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1609), 0.0, 1.0), _1617)) * pow(clamp(_1618, 0.0, 1.0), _1625)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1609), 0.0, 1.0), _1617) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _1625))), 0.0, 1.0) + (_1558 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _1646 = _1543;
            }
            _1647 = _1646;
            break;
        } while(false);
        vec4 _1648 = vec4(1.0);
        _1648.x = _1647;
        _1649 = _1648;
    }
    else
    {
        _1649 = vec4(1.0);
    }
    vec4 _2028;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1259].shadow_enabled.x > 0.0)
    {
        vec4 _1658 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2026;
        do
        {
            vec4 _1668 = dynamic_light_infos._m0[_1259].light_matrix * _1658;
            vec3 _1725;
            if (_1262 == 2u)
            {
                vec3 _1689 = _1668.xyz;
                vec3 _1691 = normalize(_1689) + vec3(0.0, 0.0, 1.0);
                float _1695 = length(_1689);
                vec3 _1698 = vec3((_1691 / vec3(_1691.z)).xy, _1695);
                float _1699 = _1668.z;
                vec3 _1711;
                if (_1699 > 0.0)
                {
                    _1711 = _1698;
                }
                else
                {
                    _1711 = vec3(normalize(_1698.xy) * 10000000.0, -_1695);
                }
                vec3 _1719 = vec3((_1711.x * 0.5) + 0.5, 0.5 - (_1711.y * 0.5), _1711.z);
                _1719.z = _1711.z * 9.9999997473787516355514526367188e-05;
                if (_1699 < 0.0)
                {
                    _2026 = 0.0;
                    break;
                }
                _1725 = _1719;
            }
            else
            {
                vec3 _1673 = _1668.xyz;
                vec3 _1685;
                if (_1262 == 1u)
                {
                    float _1677 = _1668.z;
                    vec3 _1684 = _1673;
                    _1684.z = _1677 - (((_1677 * dynamic_light_infos._m0[_1259].shadow_scale.z) + 1.0) / _1668.w);
                    _1685 = _1684;
                }
                else
                {
                    _1685 = _1673;
                }
                _1725 = _1685 / vec3(_1668.w);
            }
            float _1834;
            if (dynamic_light_infos._m0[_1259].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _1816 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _1725.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1725.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1725.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1725.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1725.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1725.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1725.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1725.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1725.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1725.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _1725.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1725.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _1834 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1259].shadow_scale.w * spvNMax(_1816, _1725.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_1725.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1259].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _1834 = 1.0;
            }
            vec2 _1835 = dynamic_light_infos._m0[_1259].shadow_scale.xy * _1834;
            float _1921 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1725.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1725.z, 1.0).xy, _1725.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1725.xy + (vec2(1.0, 0.0) * _1835), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1725.z, 1.0).xy, _1725.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1725.xy + (vec2(0.5, 0.865999996662139892578125) * _1835), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1725.z, 1.0).xy, _1725.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1725.xy + (vec2(-0.5, 0.865999996662139892578125) * _1835), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1725.z, 1.0).xy, _1725.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1725.xy + (vec2(-1.0, -0.0) * _1835), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1725.z, 1.0).xy, _1725.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1725.xy + (vec2(-0.5, -0.865999996662139892578125) * _1835), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1725.z, 1.0).xy, _1725.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_1725.xy + (vec2(0.5, -0.865999996662139892578125) * _1835), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1259].shadow_atlas_offset_scale.xy, _1725.z, 1.0).xy, _1725.z), 0.0);
            float _1922 = _1921 * 0.14285714924335479736328125;
            float _2025;
            if (_1262 == 0u)
            {
                float _1937 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _1658.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _1939 = transpose(dynamic_light_infos._m0[_1259].light_matrix)[2];
                float _1944 = length(cpass_cb.clouds_velocity.xy);
                vec3 _1953;
                if (_1944 > 0.100000001490116119384765625)
                {
                    _1953 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _1953 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _1964 = _1658.xyz - ((_1939.xyz / vec3(_1939.z)) * 1000.0);
                float _1988 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_1953, _1964), dot(normalize(vec3(-_1953.y, _1953.x, 0.0)), _1964)) + (vec2(_1944, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_1937 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _1995 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _1996 = _1995 - 1.0;
                float _1997 = 1.0 - cpass_cb.clouds_midpoint;
                float _2004 = 2.0 - _1995;
                _2025 = _1922 * mix(1.0, clamp(clamp(_1997 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _1988), 0.0, 1.0), _1996)) * pow(clamp(_1997, 0.0, 1.0), _2004)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _1988), 0.0, 1.0), _1996) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2004))), 0.0, 1.0) + (_1937 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2025 = _1922;
            }
            _2026 = _2025;
            break;
        } while(false);
        vec4 _2027 = _1649;
        _2027.y = _2026;
        _2028 = _2027;
    }
    else
    {
        _2028 = _1649;
    }
    vec4 _2407;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1263].shadow_enabled.x > 0.0)
    {
        vec4 _2037 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2405;
        do
        {
            vec4 _2047 = dynamic_light_infos._m0[_1263].light_matrix * _2037;
            vec3 _2104;
            if (_1266 == 2u)
            {
                vec3 _2068 = _2047.xyz;
                vec3 _2070 = normalize(_2068) + vec3(0.0, 0.0, 1.0);
                float _2074 = length(_2068);
                vec3 _2077 = vec3((_2070 / vec3(_2070.z)).xy, _2074);
                float _2078 = _2047.z;
                vec3 _2090;
                if (_2078 > 0.0)
                {
                    _2090 = _2077;
                }
                else
                {
                    _2090 = vec3(normalize(_2077.xy) * 10000000.0, -_2074);
                }
                vec3 _2098 = vec3((_2090.x * 0.5) + 0.5, 0.5 - (_2090.y * 0.5), _2090.z);
                _2098.z = _2090.z * 9.9999997473787516355514526367188e-05;
                if (_2078 < 0.0)
                {
                    _2405 = 0.0;
                    break;
                }
                _2104 = _2098;
            }
            else
            {
                vec3 _2052 = _2047.xyz;
                vec3 _2064;
                if (_1266 == 1u)
                {
                    float _2056 = _2047.z;
                    vec3 _2063 = _2052;
                    _2063.z = _2056 - (((_2056 * dynamic_light_infos._m0[_1263].shadow_scale.z) + 1.0) / _2047.w);
                    _2064 = _2063;
                }
                else
                {
                    _2064 = _2052;
                }
                _2104 = _2064 / vec3(_2047.w);
            }
            float _2213;
            if (dynamic_light_infos._m0[_1263].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2195 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2104.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2104.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2104.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2104.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2104.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2104.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2104.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2104.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2104.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2104.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2104.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2104.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2213 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1263].shadow_scale.w * spvNMax(_2195, _2104.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2104.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1263].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2213 = 1.0;
            }
            vec2 _2214 = dynamic_light_infos._m0[_1263].shadow_scale.xy * _2213;
            float _2300 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2104.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2104.z, 1.0).xy, _2104.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2104.xy + (vec2(1.0, 0.0) * _2214), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2104.z, 1.0).xy, _2104.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2104.xy + (vec2(0.5, 0.865999996662139892578125) * _2214), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2104.z, 1.0).xy, _2104.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2104.xy + (vec2(-0.5, 0.865999996662139892578125) * _2214), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2104.z, 1.0).xy, _2104.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2104.xy + (vec2(-1.0, -0.0) * _2214), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2104.z, 1.0).xy, _2104.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2104.xy + (vec2(-0.5, -0.865999996662139892578125) * _2214), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2104.z, 1.0).xy, _2104.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2104.xy + (vec2(0.5, -0.865999996662139892578125) * _2214), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1263].shadow_atlas_offset_scale.xy, _2104.z, 1.0).xy, _2104.z), 0.0);
            float _2301 = _2300 * 0.14285714924335479736328125;
            float _2404;
            if (_1266 == 0u)
            {
                float _2316 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2037.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2318 = transpose(dynamic_light_infos._m0[_1263].light_matrix)[2];
                float _2323 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2332;
                if (_2323 > 0.100000001490116119384765625)
                {
                    _2332 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2332 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2343 = _2037.xyz - ((_2318.xyz / vec3(_2318.z)) * 1000.0);
                float _2367 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2332, _2343), dot(normalize(vec3(-_2332.y, _2332.x, 0.0)), _2343)) + (vec2(_2323, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2316 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2374 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2375 = _2374 - 1.0;
                float _2376 = 1.0 - cpass_cb.clouds_midpoint;
                float _2383 = 2.0 - _2374;
                _2404 = _2301 * mix(1.0, clamp(clamp(_2376 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2367), 0.0, 1.0), _2375)) * pow(clamp(_2376, 0.0, 1.0), _2383)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2367), 0.0, 1.0), _2375) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2383))), 0.0, 1.0) + (_2316 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2404 = _2301;
            }
            _2405 = _2404;
            break;
        } while(false);
        vec4 _2406 = _2028;
        _2406.z = _2405;
        _2407 = _2406;
    }
    else
    {
        _2407 = _2028;
    }
    vec4 _2786;
    SPIRV_CROSS_BRANCH
    if (dynamic_light_infos._m0[_1267].shadow_enabled.x > 0.0)
    {
        vec4 _2416 = vec4(in_var_TEXCOORD0.xyz, 1.0);
        float _2784;
        do
        {
            vec4 _2426 = dynamic_light_infos._m0[_1267].light_matrix * _2416;
            vec3 _2483;
            if (_1270 == 2u)
            {
                vec3 _2447 = _2426.xyz;
                vec3 _2449 = normalize(_2447) + vec3(0.0, 0.0, 1.0);
                float _2453 = length(_2447);
                vec3 _2456 = vec3((_2449 / vec3(_2449.z)).xy, _2453);
                float _2457 = _2426.z;
                vec3 _2469;
                if (_2457 > 0.0)
                {
                    _2469 = _2456;
                }
                else
                {
                    _2469 = vec3(normalize(_2456.xy) * 10000000.0, -_2453);
                }
                vec3 _2477 = vec3((_2469.x * 0.5) + 0.5, 0.5 - (_2469.y * 0.5), _2469.z);
                _2477.z = _2469.z * 9.9999997473787516355514526367188e-05;
                if (_2457 < 0.0)
                {
                    _2784 = 0.0;
                    break;
                }
                _2483 = _2477;
            }
            else
            {
                vec3 _2431 = _2426.xyz;
                vec3 _2443;
                if (_1270 == 1u)
                {
                    float _2435 = _2426.z;
                    vec3 _2442 = _2431;
                    _2442.z = _2435 - (((_2435 * dynamic_light_infos._m0[_1267].shadow_scale.z) + 1.0) / _2426.w);
                    _2443 = _2442;
                }
                else
                {
                    _2443 = _2431;
                }
                _2483 = _2443 / vec3(_2426.w);
            }
            float _2592;
            if (dynamic_light_infos._m0[_1267].shadow_scale.w > 9.9999997473787516355514526367188e-06)
            {
                float _2574 = spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(spvNMax(-100000.0, _2483.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2483.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2483.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2483.xy + (vec2(1.0, 0.0) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2483.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2483.xy + (vec2(0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2483.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2483.xy + (vec2(-0.5, 0.865999996662139892578125) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2483.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2483.xy + (vec2(-1.0, -0.0) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x), _2483.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2483.xy + (vec2(-0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x);
                _2592 = clamp(0.20000000298023223876953125 + (dynamic_light_infos._m0[_1267].shadow_scale.w * spvNMax(_2574, _2483.z - textureLod(sampler2D(tex_shadow_map_atlas, SamplerLinearClamp), vec4((clamp(_2483.xy + (vec2(0.5, -0.865999996662139892578125) * dynamic_light_infos._m0[_1267].shadow_scale.xy), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, 0.0, 0.0).xy, 0.0).x)), 0.0, 1.0);
            }
            else
            {
                _2592 = 1.0;
            }
            vec2 _2593 = dynamic_light_infos._m0[_1267].shadow_scale.xy * _2592;
            float _2679 = (((((textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2483.xy, vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2483.z, 1.0).xy, _2483.z), 0.0) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2483.xy + (vec2(1.0, 0.0) * _2593), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2483.z, 1.0).xy, _2483.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2483.xy + (vec2(0.5, 0.865999996662139892578125) * _2593), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2483.z, 1.0).xy, _2483.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2483.xy + (vec2(-0.5, 0.865999996662139892578125) * _2593), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2483.z, 1.0).xy, _2483.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2483.xy + (vec2(-1.0, -0.0) * _2593), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2483.z, 1.0).xy, _2483.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2483.xy + (vec2(-0.5, -0.865999996662139892578125) * _2593), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2483.z, 1.0).xy, _2483.z), 0.0)) + textureLod(sampler2DShadow(tex_shadow_map_atlas, SamplerDepth), vec3(vec4((clamp(_2483.xy + (vec2(0.5, -0.865999996662139892578125) * _2593), vec2(0.0), vec2(1.0)) * dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.zw) + dynamic_light_infos._m0[_1267].shadow_atlas_offset_scale.xy, _2483.z, 1.0).xy, _2483.z), 0.0);
            float _2680 = _2679 * 0.14285714924335479736328125;
            float _2783;
            if (_1270 == 0u)
            {
                float _2695 = smoothstep(0.0, 1.0, clamp(1.0 - (length(cpass_cb.player_position.xy - _2416.xy) / cpass_cb.clouds_fade_radius), 0.0, 1.0));
                vec4 _2697 = transpose(dynamic_light_infos._m0[_1267].light_matrix)[2];
                float _2702 = length(cpass_cb.clouds_velocity.xy);
                vec3 _2711;
                if (_2702 > 0.100000001490116119384765625)
                {
                    _2711 = normalize(vec3(cpass_cb.clouds_velocity.xy, 0.0));
                }
                else
                {
                    _2711 = vec3(1.0, 0.0, 0.0);
                }
                vec3 _2722 = _2416.xyz - ((_2697.xyz / vec3(_2697.z)) * 1000.0);
                float _2746 = clamp(textureLod(sampler2D(noise_sampler, SamplerLinearWrapNoBias), vec4((vec2(dot(_2711, _2722), dot(normalize(vec3(-_2711.y, _2711.x, 0.0)), _2722)) + (vec2(_2702, 0.0) * cpass_cb.time)) * (0.001000000047497451305389404296875 * cpass_cb.clouds_scale), 0.0, 0.0).xy, 0.0).w + (_2695 * cpass_cb.clouds_pre_fade), 0.0, 1.0);
                float _2753 = 2.0 / spvNMax(0.001000000047497451305389404296875, 1.0 - cpass_cb.clouds_sharpness);
                float _2754 = _2753 - 1.0;
                float _2755 = 1.0 - cpass_cb.clouds_midpoint;
                float _2762 = 2.0 - _2753;
                _2783 = _2680 * mix(1.0, clamp(clamp(_2755 + (((-pow(clamp(1.0 - spvNMax(cpass_cb.clouds_midpoint, _2746), 0.0, 1.0), _2754)) * pow(clamp(_2755, 0.0, 1.0), _2762)) + (pow(clamp(spvNMin(cpass_cb.clouds_midpoint, _2746), 0.0, 1.0), _2754) * pow(clamp(cpass_cb.clouds_midpoint, 0.0, 1.0), _2762))), 0.0, 1.0) + (_2695 * cpass_cb.clouds_post_fade), 0.0, 1.0), cpass_cb.clouds_intensity);
            }
            else
            {
                _2783 = _2680;
            }
            _2784 = _2783;
            break;
        } while(false);
        vec4 _2785 = _2407;
        _2785.w = _2784;
        _2786 = _2785;
    }
    else
    {
        _2786 = _2407;
    }
    vec3 _2853;
    vec3 _2854;
    switch (_1258)
    {
        case 0u:
        {
            _2853 = dynamic_light_infos._m0[_1255].light_color.xyz;
            _2854 = -dynamic_light_infos._m0[_1255].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _2830 = dynamic_light_infos._m0[_1255].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2831 = length(_2830);
            vec3 _2833 = _2830 / vec3(_2831);
            _2853 = dynamic_light_infos._m0[_1255].light_color.xyz * ((1.0 - clamp(_2831 / dynamic_light_infos._m0[_1255].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1255].light_direction.xyz, _2833) - dynamic_light_infos._m0[_1255].light_direction.w) / (dynamic_light_infos._m0[_1255].light_position.w - dynamic_light_infos._m0[_1255].light_direction.w), 0.0, 1.0));
            _2854 = _2833;
            break;
        }
        case 2u:
        {
            vec3 _2798 = dynamic_light_infos._m0[_1255].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2799 = length(_2798);
            float _2811 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1255].light_position.w, 0.0, 1.0));
            float _2816 = (_2799 / (dynamic_light_infos._m0[_1255].light_color.w / _2811)) + 1.0;
            float _2817 = _2799 / (dynamic_light_infos._m0[_1255].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1255].light_color.xyz), vec3(1.0)) * 2.0));
            float _2822 = clamp(1.0 - (((_2817 * _2817) * _2817) * _2817), 0.0, 1.0);
            _2853 = dynamic_light_infos._m0[_1255].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _2811) * _2811) * (_2822 * _2822)) / (_2816 * _2816));
            _2854 = _2798 / vec3(_2799);
            break;
        }
        default:
        {
            _2853 = vec3(0.0);
            _2854 = vec3(0.0);
            break;
        }
    }
    vec3 _2856 = normalize(_337);
    vec3 _2858 = -_2856;
    float _2860 = 1.0 - length(_337);
    vec3 _2866 = _2853 * (_2786.x * clamp((dot(_2858, -_2854) - _2860) * 2.5, 0.0, 1.0));
    vec3 _2918;
    vec3 _2919;
    vec3 _2920;
    if (length(_2866) > 0.0)
    {
        float _2872 = clamp(dot(_2854, _674), 0.0, 1.0);
        float _2875 = clamp(1.0 - _359, 0.0, 1.0);
        float _2877 = spvNMax(_2875 * _2875, 0.00200000009499490261077880859375);
        float _2878 = _2877 * _2877;
        vec3 _2879 = -_678;
        vec3 _2881 = normalize(_2879 + _2854);
        float _2883 = clamp(dot(_674, _2881), 0.0, 1.0);
        float _2887 = clamp(dot(_2879, _2881), 0.0, 1.0);
        float _2894 = _2877 * 0.5;
        float _2895 = 1.0 - _2894;
        _2918 = _1106 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _2887) - 6.9831600189208984375) * _2887)), vec3(1.0), _392) * (_2878 / pow((((_2878 - 1.0) * _2883) * _2883) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_2879, _674), 0.0, 1.0) * _2895) + _2894) * ((_2872 * _2895) + _2894)))) * _2872) * vec3(0.25)) * _2866);
        _2919 = _1108 + ((_2866 * _2872) * _345.xyz);
        _2920 = _1110 + _2866;
    }
    else
    {
        _2918 = _1106;
        _2919 = _1108;
        _2920 = _1110;
    }
    vec3 _2987;
    vec3 _2988;
    switch (_1262)
    {
        case 0u:
        {
            _2987 = dynamic_light_infos._m0[_1259].light_color.xyz;
            _2988 = -dynamic_light_infos._m0[_1259].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _2964 = dynamic_light_infos._m0[_1259].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2965 = length(_2964);
            vec3 _2967 = _2964 / vec3(_2965);
            _2987 = dynamic_light_infos._m0[_1259].light_color.xyz * ((1.0 - clamp(_2965 / dynamic_light_infos._m0[_1259].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1259].light_direction.xyz, _2967) - dynamic_light_infos._m0[_1259].light_direction.w) / (dynamic_light_infos._m0[_1259].light_position.w - dynamic_light_infos._m0[_1259].light_direction.w), 0.0, 1.0));
            _2988 = _2967;
            break;
        }
        case 2u:
        {
            vec3 _2932 = dynamic_light_infos._m0[_1259].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _2933 = length(_2932);
            float _2945 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1259].light_position.w, 0.0, 1.0));
            float _2950 = (_2933 / (dynamic_light_infos._m0[_1259].light_color.w / _2945)) + 1.0;
            float _2951 = _2933 / (dynamic_light_infos._m0[_1259].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1259].light_color.xyz), vec3(1.0)) * 2.0));
            float _2956 = clamp(1.0 - (((_2951 * _2951) * _2951) * _2951), 0.0, 1.0);
            _2987 = dynamic_light_infos._m0[_1259].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _2945) * _2945) * (_2956 * _2956)) / (_2950 * _2950));
            _2988 = _2932 / vec3(_2933);
            break;
        }
        default:
        {
            _2987 = vec3(0.0);
            _2988 = vec3(0.0);
            break;
        }
    }
    vec3 _2996 = _2987 * (_2786.y * clamp((dot(_2858, -_2988) - _2860) * 2.5, 0.0, 1.0));
    vec3 _3048;
    vec3 _3049;
    vec3 _3050;
    if (length(_2996) > 0.0)
    {
        float _3002 = clamp(dot(_2988, _674), 0.0, 1.0);
        float _3005 = clamp(1.0 - _359, 0.0, 1.0);
        float _3007 = spvNMax(_3005 * _3005, 0.00200000009499490261077880859375);
        float _3008 = _3007 * _3007;
        vec3 _3009 = -_678;
        vec3 _3011 = normalize(_3009 + _2988);
        float _3013 = clamp(dot(_674, _3011), 0.0, 1.0);
        float _3017 = clamp(dot(_3009, _3011), 0.0, 1.0);
        float _3024 = _3007 * 0.5;
        float _3025 = 1.0 - _3024;
        _3048 = _2918 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3017) - 6.9831600189208984375) * _3017)), vec3(1.0), _392) * (_3008 / pow((((_3008 - 1.0) * _3013) * _3013) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3009, _674), 0.0, 1.0) * _3025) + _3024) * ((_3002 * _3025) + _3024)))) * _3002) * vec3(0.25)) * _2996);
        _3049 = _2919 + ((_2996 * _3002) * _345.xyz);
        _3050 = _2920 + _2996;
    }
    else
    {
        _3048 = _2918;
        _3049 = _2919;
        _3050 = _2920;
    }
    vec3 _3117;
    vec3 _3118;
    switch (_1266)
    {
        case 0u:
        {
            _3117 = dynamic_light_infos._m0[_1263].light_color.xyz;
            _3118 = -dynamic_light_infos._m0[_1263].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3094 = dynamic_light_infos._m0[_1263].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3095 = length(_3094);
            vec3 _3097 = _3094 / vec3(_3095);
            _3117 = dynamic_light_infos._m0[_1263].light_color.xyz * ((1.0 - clamp(_3095 / dynamic_light_infos._m0[_1263].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1263].light_direction.xyz, _3097) - dynamic_light_infos._m0[_1263].light_direction.w) / (dynamic_light_infos._m0[_1263].light_position.w - dynamic_light_infos._m0[_1263].light_direction.w), 0.0, 1.0));
            _3118 = _3097;
            break;
        }
        case 2u:
        {
            vec3 _3062 = dynamic_light_infos._m0[_1263].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3063 = length(_3062);
            float _3075 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1263].light_position.w, 0.0, 1.0));
            float _3080 = (_3063 / (dynamic_light_infos._m0[_1263].light_color.w / _3075)) + 1.0;
            float _3081 = _3063 / (dynamic_light_infos._m0[_1263].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1263].light_color.xyz), vec3(1.0)) * 2.0));
            float _3086 = clamp(1.0 - (((_3081 * _3081) * _3081) * _3081), 0.0, 1.0);
            _3117 = dynamic_light_infos._m0[_1263].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3075) * _3075) * (_3086 * _3086)) / (_3080 * _3080));
            _3118 = _3062 / vec3(_3063);
            break;
        }
        default:
        {
            _3117 = vec3(0.0);
            _3118 = vec3(0.0);
            break;
        }
    }
    vec3 _3126 = _3117 * (_2786.z * clamp((dot(_2858, -_3118) - _2860) * 2.5, 0.0, 1.0));
    vec3 _3178;
    vec3 _3179;
    vec3 _3180;
    if (length(_3126) > 0.0)
    {
        float _3132 = clamp(dot(_3118, _674), 0.0, 1.0);
        float _3135 = clamp(1.0 - _359, 0.0, 1.0);
        float _3137 = spvNMax(_3135 * _3135, 0.00200000009499490261077880859375);
        float _3138 = _3137 * _3137;
        vec3 _3139 = -_678;
        vec3 _3141 = normalize(_3139 + _3118);
        float _3143 = clamp(dot(_674, _3141), 0.0, 1.0);
        float _3147 = clamp(dot(_3139, _3141), 0.0, 1.0);
        float _3154 = _3137 * 0.5;
        float _3155 = 1.0 - _3154;
        _3178 = _3048 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3147) - 6.9831600189208984375) * _3147)), vec3(1.0), _392) * (_3138 / pow((((_3138 - 1.0) * _3143) * _3143) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3139, _674), 0.0, 1.0) * _3155) + _3154) * ((_3132 * _3155) + _3154)))) * _3132) * vec3(0.25)) * _3126);
        _3179 = _3049 + ((_3126 * _3132) * _345.xyz);
        _3180 = _3050 + _3126;
    }
    else
    {
        _3178 = _3048;
        _3179 = _3049;
        _3180 = _3050;
    }
    vec3 _3247;
    vec3 _3248;
    switch (_1270)
    {
        case 0u:
        {
            _3247 = dynamic_light_infos._m0[_1267].light_color.xyz;
            _3248 = -dynamic_light_infos._m0[_1267].light_direction.xyz;
            break;
        }
        case 1u:
        {
            vec3 _3224 = dynamic_light_infos._m0[_1267].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3225 = length(_3224);
            vec3 _3227 = _3224 / vec3(_3225);
            _3247 = dynamic_light_infos._m0[_1267].light_color.xyz * ((1.0 - clamp(_3225 / dynamic_light_infos._m0[_1267].light_color.w, 0.0, 1.0)) * clamp((dot(-dynamic_light_infos._m0[_1267].light_direction.xyz, _3227) - dynamic_light_infos._m0[_1267].light_direction.w) / (dynamic_light_infos._m0[_1267].light_position.w - dynamic_light_infos._m0[_1267].light_direction.w), 0.0, 1.0));
            _3248 = _3227;
            break;
        }
        case 2u:
        {
            vec3 _3192 = dynamic_light_infos._m0[_1267].light_position.xyz - in_var_TEXCOORD0.xyz;
            float _3193 = length(_3192);
            float _3205 = mix(7.071068286895751953125, 100.0, clamp(dynamic_light_infos._m0[_1267].light_position.w, 0.0, 1.0));
            float _3210 = (_3193 / (dynamic_light_infos._m0[_1267].light_color.w / _3205)) + 1.0;
            float _3211 = _3193 / (dynamic_light_infos._m0[_1267].light_color.w * sqrt(dot(abs(dynamic_light_infos._m0[_1267].light_color.xyz), vec3(1.0)) * 2.0));
            float _3216 = clamp(1.0 - (((_3211 * _3211) * _3211) * _3211), 0.0, 1.0);
            _3247 = dynamic_light_infos._m0[_1267].light_color.xyz * spvNMin(10.0, (((0.199999988079071044921875 * _3205) * _3205) * (_3216 * _3216)) / (_3210 * _3210));
            _3248 = _3192 / vec3(_3193);
            break;
        }
        default:
        {
            _3247 = vec3(0.0);
            _3248 = vec3(0.0);
            break;
        }
    }
    vec3 _3256 = _3247 * (_2786.w * clamp((dot(_2858, -_3248) - _2860) * 2.5, 0.0, 1.0));
    vec3 _3308;
    vec3 _3309;
    vec3 _3310;
    if (length(_3256) > 0.0)
    {
        float _3262 = clamp(dot(_3248, _674), 0.0, 1.0);
        float _3265 = clamp(1.0 - _359, 0.0, 1.0);
        float _3267 = spvNMax(_3265 * _3265, 0.00200000009499490261077880859375);
        float _3268 = _3267 * _3267;
        vec3 _3269 = -_678;
        vec3 _3271 = normalize(_3269 + _3248);
        float _3273 = clamp(dot(_674, _3271), 0.0, 1.0);
        float _3277 = clamp(dot(_3269, _3271), 0.0, 1.0);
        float _3284 = _3267 * 0.5;
        float _3285 = 1.0 - _3284;
        _3308 = _3179 + ((_3256 * _3262) * _345.xyz);
        _3309 = _3178 + (((((mix(vec3(exp2((((-5.554729938507080078125) * _3277) - 6.9831600189208984375) * _3277)), vec3(1.0), _392) * (_3268 / pow((((_3268 - 1.0) * _3273) * _3273) + 1.0, 2.0))) * (1.0 / (((clamp(dot(_3269, _674), 0.0, 1.0) * _3285) + _3284) * ((_3262 * _3285) + _3284)))) * _3262) * vec3(0.25)) * _3256);
        _3310 = _3180 + _3256;
    }
    else
    {
        _3308 = _3179;
        _3309 = _3178;
        _3310 = _3180;
    }
    vec3 _3433;
    if (cpass_cb.specular_cube_enabled != 0u)
    {
        float _3323 = _1086.w;
        float _3324 = clamp(_359, 0.0, 1.0);
        float _3327 = sqrt(clamp(1.0 - _3323, 0.0, 1.0));
        float _3328 = 1.0 - _3324;
        float _3329 = _3328 * _3328;
        float _3332 = clamp(exp((-2.2999999523162841796875) * _3329), 0.001000000047497451305389404296875, 0.999000012874603271484375);
        float _3333 = dot(_2856, _679);
        float _3339 = sqrt(clamp(1.0 - (_3333 * _3333), 0.0, 1.0));
        float _3341 = _3332 - (_3333 * _3327);
        float _3342 = _3339 * _3327;
        vec2 _3343 = vec2(_3341, _3342);
        float _3345 = _3327 - (_3333 * _3332);
        float _3346 = _3339 * _3332;
        vec2 _3347 = vec2(_3345, _3346);
        float _3351 = sqrt(clamp(1.0 - (_3327 * _3327), 0.0, 1.0));
        float _3368 = sqrt(clamp(1.0 - (_3332 * _3332), 0.0, 1.0));
        vec4 _3394 = textureLod(sampler2D(environment_ggx_sampler, SamplerLinearClamp), vec4(abs(dot(_674, -_678)), _3324, 0.0, 0.0).xy, 0.0);
        float _3407 = log2(float(int(uvec2(textureSize(specular_cube, 0)).x)) / (1.57079589366912841796875 / _3329));
        vec3 _3432 = _3309 + ((((textureLod(samplerCube(specular_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_679, 0.0)).xyz, _3407).xyz, _3407).xyz * (vec3(_3394.x) + (_392 * _3394.y))) * 1.0) * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3310 * cpass_cb.direct_light_env_ratio)) * (1.0 + cpass_cb.cube_brightness.w))) * (_3323 * ((2.0 * ((acos(clamp(_3341 / (_3351 * sqrt(dot(_3343, _3343))), -1.0, 1.0)) - (acos(clamp((_3341 * _3327) / (_3342 * _3351), -1.0, 1.0)) * _3327)) + (acos(clamp(_3345 / (_3368 * sqrt(dot(_3347, _3347))), -1.0, 1.0)) - (acos(clamp((_3345 * _3332) / (_3346 * _3368), -1.0, 1.0)) * _3332)))) / spvNMax(1.0000000116860974230803549289703e-07, 6.283184051513671875 * (1.0 - _3332)))));
        _3433 = _3432;
    }
    else
    {
        _3433 = _3309;
    }
    vec3 _3445 = _345.xyz;
    vec3 _3476;
    if (cpass_cb.diffuse_cube_enabled != 0u)
    {
        _3476 = (((textureLod(samplerCube(diffuse_cube, SamplerLinearClampNoBias), vec4((cpass_cb.env_map_rotation * vec4(_337, 0.0)).xyz, 0.0).xyz, 0.0).xyz * (((vec3(1.0) * cpass_cb.cube_brightness.x) + (_3310 * cpass_cb.direct_light_env_ratio)) + vec3(cpass_cb.cube_brightness.w))) * _3445) * _1086.w) * (1.0 - cpass_cb.gi_env_occlusion);
    }
    else
    {
        _3476 = vec3(0.0);
    }
    vec3 _3497 = (_3308 + _667) + (((_1086.xyz * _3445) + _3476) + spvNMax(vec3(0.0), _3433 / vec3(spvNMax(10.0, spvNMax(_3433.x, spvNMax(_3433.y, _3433.z))) * 0.100000001490116119384765625)));
    vec4 _3498 = vec4(_3497.x, _3497.y, _3497.z, vec4(0.0).w);
    _3498.w = 1.0;
    vec3 _3500 = in_var_TEXCOORD0.xyz - in_var_AUTO_GDFGMKIL_GEBKIEDD;
    vec4 _3503 = vec4(_3500.x, _3500.y, _3500.z, _238.w);
    _3503.w = 1.0;
    vec4 _3505 = cpass_cb.last_view_projection_transform * _3503;
    vec2 _3511 = ((_3505 / vec4(_3505.w)).xy * 0.5) + vec2(0.5);
    out_var_SV_TARGET = _3498;
    out_var_SV_TARGET2 = vec4((_3308 * cpass_cb.indirect_light_multiplier) + (_667 * 20.0), 1.0);
    out_var_SV_TARGET1 = vec4(((_694 - vec3(_3511.x, 1.0 - _3511.y, _237)) * vec3(ivec3(ivec2(uvec2((cpass_cb.frame_resolution.xy * cpass_cb.frame_to_dynamic_scale.xy) + vec2(0.5))), 0))).xy, 0.0, 0.0);
}

