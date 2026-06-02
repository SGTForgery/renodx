#include "../common.hlsl"

[[vk::binding(0, 4)]]
cbuffer type_cdynamic_resolution_scale_cb : register(b0, space4)
{
    float4 cdynamic_resolution_scale_cb_dynamic_resolution_scale : packoffset(c0);
    float4 cdynamic_resolution_scale_cb_src_size : packoffset(c1);
    float4 cdynamic_resolution_scale_cb_dst_size : packoffset(c2);
    float4 cdynamic_resolution_scale_cb_gamma_vec : packoffset(c3);
    float2 cdynamic_resolution_scale_cb_src_offset : packoffset(c4);
    float cdynamic_resolution_scale_cb_src_mip_level : packoffset(c4.z);
};

[[vk::binding(1, 0)]]
SamplerState SamplerLinearClamp : register(s1, space0);
[[vk::binding(17, 2)]]
Texture2D<float4> tex_sampler : register(t17, space2);

static float4 gl_FragCoord;
static float4 out_var_SV_TARGET;

struct SPIRV_Cross_Input
{
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_TARGET : SV_Target0;
};

void frag_main()
{
    float2 _54 = floor(((cdynamic_resolution_scale_cb_src_size.xy * cdynamic_resolution_scale_cb_dynamic_resolution_scale.xy) / cdynamic_resolution_scale_cb_dst_size.xy) + 0.5f.xx);
    float2 _55 = (gl_FragCoord.xy - 0.5f.xx) * _54;
    float _56 = _54.x;
    float _59 = _54.y;
    float _64 = 1.0f / ((floor(_56 + 0.5f) * floor(_59 + 0.5f)) + 9.9999997473787516355514526367188e-06f);
    float4 _66;
    float _69;
    _66 = 0.0f.xxxx;
    _69 = 0.0f;
    float4 _67;
    for (; _69 < (_56 - 0.5f); _66 = _67, _69 += 1.0f)
    {
        _67 = _66;
        for (float _78 = 0.0f; _78 < (_59 - 0.5f); )
        {
            _67 += (tex_sampler.SampleLevel(SamplerLinearClamp, float4((((_55 + float2(_78, _69)) + 0.5f.xx) + cdynamic_resolution_scale_cb_src_offset) / cdynamic_resolution_scale_cb_src_size.xy, 0.0f, cdynamic_resolution_scale_cb_src_mip_level).xy, cdynamic_resolution_scale_cb_src_mip_level) * _64);
            _78 += 1.0f;
            continue;
        }
    }
    out_var_SV_TARGET = _66;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_TARGET = out_var_SV_TARGET;
    return stage_output;
}
