#include "../common.hlsl"

[[vk::binding(0, 4)]]
cbuffer type_cdepth_aware_blur_cb : register(b0, space4)
{
    int cdepth_aware_blur_cb_viewport_width : packoffset(c0);
    int cdepth_aware_blur_cb_viewport_height : packoffset(c0.y);
    int cdepth_aware_blur_cb_mips_count : packoffset(c0.z);
    float cdepth_aware_blur_cb_weight_mult : packoffset(c0.w);
    float4 cdepth_aware_blur_cb_frame_to_dynamic_scale : packoffset(c1);
};

[[vk::binding(9, 0)]]
SamplerState SamplerLinearClampNoBias : register(s9, space0);
[[vk::binding(17, 2)]]
Texture2D<float4> src_sampler : register(t17, space2);

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
    float2 texel_size = 1.0f.xx / float2(float(cdepth_aware_blur_cb_viewport_width), float(cdepth_aware_blur_cb_viewport_height));
    float2 uv = gl_FragCoord.xy * texel_size;

    float total_weight = 0.0f;
    float4 total_color = 0.0f.xxxx;

    // Sample at half-mip increments (0.5, 1.0, 1.5, ... 5.0) = 10 steps.
    // Fractional LOD values trigger hardware trilinear filtering, which
    // smoothly blends between adjacent integer mip levels.  This eliminates
    // the visible "rings" / stairstepping from hard integer-mip jumps and
    // the flickering during motion that comes with them.
    static const float MIP_START = 0.5f;
    static const float MIP_END   = 5.0f;
    static const float MIP_STEP  = 0.5f;

    for (float fmip = MIP_START; fmip <= MIP_END; fmip += MIP_STEP)
    {
        float mip_weight = pow(cdepth_aware_blur_cb_weight_mult, fmip);

        
        float2 offset = texel_size * exp2(fmip);

        // 4-tap bilinear filter at diagonal half-texel offsets.
        // Each bilinear tap blends a 2x2 texel region at the requested LOD;
        // four overlapping taps produce a smooth 3x3 tent kernel per level.
        float4 s  = src_sampler.SampleLevel(SamplerLinearClampNoBias, uv + float2(-0.5f, -0.5f) * offset, fmip);
        s        += src_sampler.SampleLevel(SamplerLinearClampNoBias, uv + float2( 0.5f, -0.5f) * offset, fmip);
        s        += src_sampler.SampleLevel(SamplerLinearClampNoBias, uv + float2(-0.5f,  0.5f) * offset, fmip);
        s        += src_sampler.SampleLevel(SamplerLinearClampNoBias, uv + float2( 0.5f,  0.5f) * offset, fmip);
        s        *= 0.25f;

        total_weight += mip_weight;
        total_color  += s * mip_weight;
    }

    out_var_SV_TARGET = total_color / (total_weight + 1.0000000116860974230803549289703e-07f).xxxx;
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
