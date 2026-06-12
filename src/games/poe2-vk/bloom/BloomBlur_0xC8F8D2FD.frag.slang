#include "../common.hlsl"

[[vk::binding(0, 9)]]
cbuffer type_cdepth_aware_blur_cb : register(b0, space9)
{
    int cdepth_aware_blur_cb_viewport_width : packoffset(c0);
    int cdepth_aware_blur_cb_viewport_height : packoffset(c0.y);
    int cdepth_aware_blur_cb_mips_count : packoffset(c0.z);
    float cdepth_aware_blur_cb_weight_mult : packoffset(c0.w);
    float4 cdepth_aware_blur_cb_frame_to_dynamic_scale : packoffset(c1);
};

[[vk::binding(9, 0)]]
SamplerState SamplerLinearClampNoBias : register(s9, space0);
[[vk::binding(0, 5)]]
Texture2D<float4> src_sampler : register(t0, space5);

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

    // Per-pixel stochastic rotation angle (IGN + per-frame temporal offset).
    // Breaks the fixed diagonal tap pattern into smooth per-pixel noise,
    // eliminating visible ring stairstepping and temporal jitter.
    float noise = frac(InterleavedGradientNoise(gl_FragCoord.xy) + CUSTOM_RANDOM);
    float angle = noise * 6.28318530718f;
    float ca = cos(angle);
    float sa = sin(angle);

    // Pre-rotate the two independent diagonal unit vectors (d3 and d1).
    // d0 = -d3, d2 = -d1, so we sample at ±r_a and ±r_b per mip.
    float2 r_a = 0.5f * float2(ca - sa, sa + ca);
    float2 r_b = 0.5f * float2(ca + sa, sa - ca);

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

        // 4-tap filter with stochastically rotated diagonal offsets.
        // Each bilinear tap blends a 2×2 texel region at the requested LOD;
        // the per-pixel rotation spreads sampling error into smooth noise
        // that converges cleanly under TAA.
        float2 oa = r_a * offset;
        float2 ob = r_b * offset;

        float4 s  = src_sampler.SampleLevel(SamplerLinearClampNoBias, uv + oa, fmip);
        s        += src_sampler.SampleLevel(SamplerLinearClampNoBias, uv - oa, fmip);
        s        += src_sampler.SampleLevel(SamplerLinearClampNoBias, uv + ob, fmip);
        s        += src_sampler.SampleLevel(SamplerLinearClampNoBias, uv - ob, fmip);
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
