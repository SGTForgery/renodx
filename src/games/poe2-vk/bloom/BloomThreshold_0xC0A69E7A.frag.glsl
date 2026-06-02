#version 450
#extension GL_EXT_spirv_intrinsics : require

layout(set = 4, binding = 0, std140) uniform type_cdepth_aware_blur_cb
{
    int viewport_width;
    int viewport_height;
    float cutoff;
    float intensity;
    vec4 frame_to_dynamic_scale;
} cdepth_aware_blur_cb;

layout(set = 0, binding = 11) uniform sampler SamplerPointClampNoBias;
layout(set = 2, binding = 17) uniform texture2D src_sampler;

layout(location = 0) out vec4 out_var_SV_TARGET;

spirv_instruction(set = "GLSL.std.450", id = 80) float spvNMax(float, float);
spirv_instruction(set = "GLSL.std.450", id = 80) vec2 spvNMax(vec2, vec2);
spirv_instruction(set = "GLSL.std.450", id = 80) vec3 spvNMax(vec3, vec3);
spirv_instruction(set = "GLSL.std.450", id = 80) vec4 spvNMax(vec4, vec4);

void main()
{
    vec4 _60 = textureLod(sampler2D(src_sampler, SamplerPointClampNoBias), vec4((gl_FragCoord.xy * (vec2(1.0) / vec2(float(cdepth_aware_blur_cb.viewport_width), float(cdepth_aware_blur_cb.viewport_height)))) * cdepth_aware_blur_cb.frame_to_dynamic_scale.xy, 0.0, 0.0).xy, 0.0);
    vec3 _61 = _60.xyz;
    out_var_SV_TARGET = vec4(_61 * (spvNMax(0.0, (dot(_61, vec3(1.0)) * 0.3333333432674407958984375) - cdepth_aware_blur_cb.cutoff) * cdepth_aware_blur_cb.intensity), _60.w);
}

