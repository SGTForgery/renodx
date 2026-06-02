#version 450
#extension GL_EXT_spirv_intrinsics : require

layout(set = 4, binding = 0, std140) uniform type_cminimap_vertex_transform_cb
{
    vec4 x_basis;
    vec4 y_basis;
    vec4 z_basis;
    vec4 tiles_count;
    float tile_world_size;
    float sdr_scale;
    vec4 render_circle;
    float subgraph_index;
    vec4 decay_map_minmax;
    vec4 decay_map_size;
    vec4 stabiliser_position;
    float decay_map_time;
    float creation_time;
    float global_stability;
    float alpha_override;
    float ignore_visibility;
    vec4 poi_position;
    vec4 royale_damage_circle;
    vec4 royale_safe_circle;
} cminimap_vertex_transform_cb;

layout(set = 0, binding = 12) uniform sampler SamplerLinearWrapOffsetNoBias;
layout(set = 0, binding = 13) uniform sampler SamplerLinearClampOffsetNoBias;
layout(set = 2, binding = 19) uniform texture2D walkability_sampler;
layout(set = 2, binding = 20) uniform texture2D visibility_sampler;
layout(set = 2, binding = 21) uniform texture2D decay_map_sampler;
layout(set = 2, binding = 22) uniform texture2D crack_sampler;

layout(location = 1) in vec4 in_var_TEXCOORD2;
layout(location = 2) in float in_var_TEXCOORD3;
layout(location = 0) out vec4 out_var_SV_TARGET;

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
    bool _79;
    if (in_var_TEXCOORD3 >= 0.0)
    {
        _79 = in_var_TEXCOORD3 != cminimap_vertex_transform_cb.subgraph_index;
    }
    else
    {
        _79 = false;
    }
    if (_79)
    {
        discard;
    }
    if (distance(gl_FragCoord.xy, cminimap_vertex_transform_cb.render_circle.xy) > cminimap_vertex_transform_cb.render_circle.z)
    {
        discard;
    }
    vec2 _99 = fract(in_var_TEXCOORD2.xy / cminimap_vertex_transform_cb.tiles_count.xy);
    vec4 _101 = texture(sampler2D(walkability_sampler, SamplerLinearClampOffsetNoBias), _99);
    vec4 _108 = texture(sampler2D(visibility_sampler, SamplerLinearClampOffsetNoBias), _99);
    bool _120;
    if (!(cminimap_vertex_transform_cb.royale_damage_circle.z > 0.0))
    {
        _120 = cminimap_vertex_transform_cb.royale_safe_circle.z > 0.0;
    }
    else
    {
        _120 = true;
    }
    float _251;
    float _252;
    if (_120)
    {
        vec2 _126 = in_var_TEXCOORD2.xy * cminimap_vertex_transform_cb.tile_world_size;
        float _137 = spvNMax(spvNMin(1.0 - clamp(abs(length(_126 - cminimap_vertex_transform_cb.royale_damage_circle.xy) - cminimap_vertex_transform_cb.royale_damage_circle.z) * 0.0199999995529651641845703125, 0.0, 1.0), 0.99999988079071044921875), 1.0000000116860974230803549289703e-07);
        float _138 = spvNMax(0.001000000047497451305389404296875, 0.5);
        float _139 = 2.0 / _138;
        float _140 = _139 - 1.0;
        float _147 = pow(0.5, 2.0 - _139);
        float _167 = spvNMax(spvNMin(1.0 - clamp(abs(length(_126 - cminimap_vertex_transform_cb.royale_safe_circle.xy) - cminimap_vertex_transform_cb.royale_safe_circle.z) * 0.0199999995529651641845703125, 0.0, 1.0), 0.99999988079071044921875), 1.0000000116860974230803549289703e-07);
        _251 = 0.5 + (_147 * ((-pow(clamp(1.0 - spvNMax(0.5, _167), 0.0, 1.0), _140)) + pow(clamp(spvNMin(0.5, _167), 0.0, 1.0), _140)));
        _252 = 0.5 + (_147 * ((-pow(clamp(1.0 - spvNMax(0.5, _137), 0.0, 1.0), _140)) + pow(clamp(spvNMin(0.5, _137), 0.0, 1.0), _140)));
    }
    else
    {
        vec2 _181 = in_var_TEXCOORD2.xy * cminimap_vertex_transform_cb.tile_world_size;
        vec3 _184 = vec3(_181, 0.0);
        vec2 _191 = cminimap_vertex_transform_cb.decay_map_minmax.zw - cminimap_vertex_transform_cb.decay_map_minmax.xy;
        vec4 _200 = textureLod(sampler2D(decay_map_sampler, SamplerLinearClampOffsetNoBias), vec4((_184.xy - cminimap_vertex_transform_cb.decay_map_minmax.xy) / (_191 + vec2(9.9999997473787516355514526367188e-06)), 0.0, 0.0).xy, 0.0);
        float _241;
        if (cminimap_vertex_transform_cb.decay_map_time > 0.0)
        {
            _241 = spvNMax((((cminimap_vertex_transform_cb.decay_map_time - _200.x) / (length(vec3(_200.yz / (_191 / cminimap_vertex_transform_cb.decay_map_size.xy), 0.0)) + 9.9999997473787516355514526367188e-05)) * 0.014285714365541934967041015625) + 1.0, 50.0 - ((1.0 - (((length(_184 - cminimap_vertex_transform_cb.stabiliser_position.xyz) - 300.0) - (pow(spvNMax(0.0, cminimap_vertex_transform_cb.creation_time), 2.0) * 1000.0)) * 0.0005000000237487256526947021484375)) * 50.0)) * 0.20000000298023223876953125;
        }
        else
        {
            _241 = 0.0;
        }
        _251 = pow(clamp(texture(sampler2D(crack_sampler, SamplerLinearWrapOffsetNoBias), _181 * 0.0005000000237487256526947021484375).z * 1.2000000476837158203125, 0.0, 1.0), 4.0);
        _252 = _241;
    }
    out_var_SV_TARGET = vec4(mix(vec4(0.0, 1.0, 0.0, 1.0), vec4(1.0, 0.0, 0.0, 1.0), vec4(_101.x)).x, _108.x, _252, _251);
}

