#include "../common.hlsl"

[[vk::binding(0, 1)]]
cbuffer _BloomBuffer : register(b0, space1)
{
    float4 _BloomBuffer_Params;
    float4 _BloomBuffer_BloomBicubicParams;
    float4 _BloomBuffer_TexelSize;
};

[[vk::binding(1, 0)]]
Texture2D<float4> _InputLowTexture : register(t1, space0);
[[vk::binding(2, 0)]]
Texture2D<float4> _InputHighTexture : register(t2, space0);
[[vk::binding(3, 0)]]
SamplerState s_linear_clamp_sampler : register(s3, space0);

[[vk::binding(0, 0)]]
RWTexture2D<float3> _OutputTexture : register(u0, space0);

[numthreads(8, 8, 1)]
void main(uint3 gl_GlobalInvocationID : SV_DispatchThreadID)
{
    float2 _57 = float2(gl_GlobalInvocationID.xy);

    // Clamp high-res fetch coordinate to valid range
    float2 _67 = clamp(_57, float2(0.0, 0.0), _BloomBuffer_TexelSize.xy - float2(1.0, 1.0));

    // Max UV for clamping (1 - texel_size)
    float2 _77 = float2(1.0, 1.0) - _BloomBuffer_TexelSize.zw;

    // Compute bicubic sample position in texel space
    float2 _84 = ((_57 + float2(0.5, 0.5)) * _BloomBuffer_TexelSize.zw) * _BloomBuffer_BloomBicubicParams.xy + float2(0.5, 0.5);
    float2 _85 = floor(_84);
    float2 _86 = fract(_84);

    // Compute cubic weights (Mitchell-Netravali-style)
    float2 _92 = float2(0.16666667, 0.16666667) + (_86 * (float2(-0.5, -0.5) + (_86 * (float2(0.5, 0.5) - (_86 * 0.16666667)))));
    float2 _93 = _86 * 0.5;
    float2 _96 = (_86 * (float2(-1.0, -1.0) + _93)) * _86;
    float2 _97 = float2(0.66666669, 0.66666669) + _96;
    float2 _102 = float2(0.16666667, 0.16666667) + (_86 * (float2(0.5, 0.5) + (_86 * (float2(0.5, 0.5) - _93))));
    float2 _105 = (float2(0.33333331, 0.33333331) - _96) - _102 - _92;
    float2 _106 = _92 + _97;
    float2 _107 = _102 + _105;
    float2 _110 = float2(-1.0, -1.0) + (_97 * (float2(1.0, 1.0) / _106));
    float2 _113 = float2(1.0, 1.0) + (_105 * (float2(1.0, 1.0) / _107));

    float _123 = _106.x;
    float _133 = _107.x;

    // 4 bilinear samples with cubic weights
    float3 s0 = _InputLowTexture.SampleLevel(s_linear_clamp_sampler, min((_85 + _110 - float2(0.5, 0.5)) * _BloomBuffer_BloomBicubicParams.zw, _77), 0.0).xyz;
    float3 s1 = _InputLowTexture.SampleLevel(s_linear_clamp_sampler, min((_85 + float2(_113.x, _110.y) - float2(0.5, 0.5)) * _BloomBuffer_BloomBicubicParams.zw, _77), 0.0).xyz;
    float3 s2 = _InputLowTexture.SampleLevel(s_linear_clamp_sampler, min((_85 + float2(_110.x, _113.y) - float2(0.5, 0.5)) * _BloomBuffer_BloomBicubicParams.zw, _77), 0.0).xyz;
    float3 s3 = _InputLowTexture.SampleLevel(s_linear_clamp_sampler, min((_85 + _113 - float2(0.5, 0.5)) * _BloomBuffer_BloomBicubicParams.zw, _77), 0.0).xyz;

    // Weighted bicubic combination
    float3 bicubicResult = ((s0 * _123 + s1 * _133) * _106.y) + ((s2 * _123 + s3 * _133) * _107.y);

    // Load current mip pixel (high-res)
    float3 highRes = _InputHighTexture.Load(int3(int(_67.x), int(_67.y), 0)).xyz;

    // Lerp between high-res pixel and bicubic upsampled result
    float3 result = lerp(highRes, bicubicResult, _BloomBuffer_Params.x);

    // Bounds check and output
    _OutputTexture[int2(gl_GlobalInvocationID.xy)] = result * float(all(gl_GlobalInvocationID.xy <= uint2(_BloomBuffer_TexelSize.xy)));
}

