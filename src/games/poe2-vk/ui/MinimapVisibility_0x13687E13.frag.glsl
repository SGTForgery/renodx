#version 450
#extension GL_EXT_spirv_intrinsics : require

layout(set = 4, binding = 0, std140) uniform type_cminimap_visibility_pixel_cb
{
    vec4 explored_tile;
    vec4 tile_map_size;
    vec4 visibility_map_size;
    vec4 revealed_bound;
    float visibility_radius;
    float visibility_fully_revealed;
    float visibility_walkable_revealed;
    float visibility_reset;
    uint use_revealed_bound;
} cminimap_visibility_pixel_cb;

layout(set = 0, binding = 1) uniform sampler SamplerLinearClamp;
layout(set = 2, binding = 17) uniform texture2D curr_visibility_sampler;
layout(set = 2, binding = 18) uniform texture2D walkability_sampler;

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
    vec2 _53 = gl_FragCoord.xy / cminimap_visibility_pixel_cb.visibility_map_size.xy;
    vec2 _57 = _53 * cminimap_visibility_pixel_cb.tile_map_size.xy;
    float _62 = length(_57 - cminimap_visibility_pixel_cb.explored_tile.xy);
    float _87;
    if (cminimap_visibility_pixel_cb.use_revealed_bound != 0u)
    {
        float _71 = _57.x;
        float _78 = _57.y;
        _87 = spvNMin(_62, length(vec2(spvNMax(spvNMax(cminimap_visibility_pixel_cb.revealed_bound.x - _71, _71 - cminimap_visibility_pixel_cb.revealed_bound.z), 0.0), spvNMax(spvNMax(cminimap_visibility_pixel_cb.revealed_bound.y - _78, _78 - cminimap_visibility_pixel_cb.revealed_bound.w), 0.0))));
    }
    else
    {
        _87 = _62;
    }
    float _93 = clamp((1.0 - (_87 / cminimap_visibility_pixel_cb.visibility_radius)) * 2.0, 0.0, 1.0);
    vec4 _97 = texture(sampler2D(curr_visibility_sampler, SamplerLinearClamp), _53);
    float _98 = _97.x;
    vec4 _143;
    if (cminimap_visibility_pixel_cb.visibility_walkable_revealed > 0.5)
    {
        vec4 _118 = texture(sampler2D(walkability_sampler, SamplerLinearClamp), _53);
        float _121 = 1.0 - clamp(_118.x, 0.0, 1.0);
        float _140;
        if ((abs(cminimap_visibility_pixel_cb.revealed_bound.x - cminimap_visibility_pixel_cb.revealed_bound.z) + abs(cminimap_visibility_pixel_cb.revealed_bound.y - cminimap_visibility_pixel_cb.revealed_bound.w)) > 0.00999999977648258209228515625)
        {
            _140 = spvNMax(_98, spvNMin(_121, _93));
        }
        else
        {
            _140 = _121;
        }
        _143 = vec4(spvNMax(_98, _140), 0.0, 0.0, 1.0);
    }
    else
    {
        _143 = mix(mix(vec4(spvNMax(_93, _98), 0.0, 0.0, 1.0), vec4(0.0, 0.0, 0.0, 1.0), bvec4(cminimap_visibility_pixel_cb.visibility_reset > 0.5)), vec4(1.0, 0.0, 0.0, 1.0), bvec4(cminimap_visibility_pixel_cb.visibility_fully_revealed > 0.5));
    }
    out_var_SV_TARGET = _143;
}

