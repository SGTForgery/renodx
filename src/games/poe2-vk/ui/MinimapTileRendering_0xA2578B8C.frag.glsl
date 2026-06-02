#version 450

vec4 _44;

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

layout(set = 0, binding = 13) uniform sampler SamplerLinearClampOffsetNoBias;
layout(set = 2, binding = 19) uniform texture2D tilemap_sampler;

layout(location = 0) in vec2 in_var_TEXCOORD1;
layout(location = 2) in float in_var_TEXCOORD3;
layout(location = 0) out vec4 out_var_SV_TARGET;

void main()
{
    bool _55;
    if (in_var_TEXCOORD3 >= 0.0)
    {
        _55 = in_var_TEXCOORD3 != cminimap_vertex_transform_cb.subgraph_index;
    }
    else
    {
        _55 = false;
    }
    if (_55)
    {
        discard;
    }
    if (length(gl_FragCoord.xy - cminimap_vertex_transform_cb.render_circle.xy) > cminimap_vertex_transform_cb.render_circle.z)
    {
        discard;
    }
    vec4 _72 = texture(sampler2D(tilemap_sampler, SamplerLinearClampOffsetNoBias), in_var_TEXCOORD1);
    bool _80;
    if (length(_72.xyz) < 0.001000000047497451305389404296875)
    {
        _80 = _72.w > 0.20000000298023223876953125;
    }
    else
    {
        _80 = false;
    }
    vec4 _85;
    if (_80)
    {
        vec4 _83;
        _83.w = 1.0;
        _85 = vec4(vec3(0.0).x, vec3(0.0).y, vec3(0.0).z, _83.w);
    }
    else
    {
        _85 = _72;
    }
    out_var_SV_TARGET = vec4(clamp(_85.xyz / vec3(_85.w + 9.9999997473787516355514526367188e-06), vec3(0.0), vec3(1.0)).xyz * cminimap_vertex_transform_cb.sdr_scale, _85.w);
}

