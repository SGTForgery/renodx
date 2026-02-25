#include "../common.hlsl"

[[vk::binding(0, 1)]]
cbuffer _BloomBuffer : register(b0, space1)
{
    float4 _BloomBuffer_TexelSize;
};

[[vk::binding(1, 0)]]
Texture2D<float4> _InputTexture : register(t1, space0);
[[vk::binding(2, 0)]]
SamplerState s_linear_clamp_sampler : register(s2, space0);

[[vk::binding(0, 0)]]
RWTexture2D<float3> _OutputTexture : register(u0, space0);

groupshared uint gs_cacheR[128];
groupshared uint gs_cacheG[128];
groupshared uint gs_cacheB[128];

// Helper functions to replace GLSL packHalf2x16/unpackHalf2x16
uint PackHalf2x16(float2 v) {
    uint lo = f32tof16(v.x);
    uint hi = f32tof16(v.y);
    return lo | (hi << 16u);
}

float2 UnpackHalf2x16(uint v) {
    float x = f16tof32(v & 0xFFFFu);
    float y = f16tof32(v >> 16u);
    return float2(x, y);
}

[numthreads(8, 8, 1)]
void main(uint3 gl_GlobalInvocationID : SV_DispatchThreadID, uint3 gl_LocalInvocationID : SV_GroupThreadID, uint3 gl_WorkGroupID : SV_GroupID)
{
    // Phase 1: Load 4 samples per thread into shared memory (packed as half)
    float2 _82 = float2(int2(((gl_LocalInvocationID.xy << uint2(1u, 1u)) + (gl_WorkGroupID.xy << uint2(3u, 3u))) - uint2(4u, 4u)));
    float4 _91 = _InputTexture.SampleLevel(s_linear_clamp_sampler, (_82 + float2(0.5, 0.5)) * _BloomBuffer_TexelSize.zw, 0.0);
    float4 _97 = _InputTexture.SampleLevel(s_linear_clamp_sampler, (_82 + float2(1.5, 0.5)) * _BloomBuffer_TexelSize.zw, 0.0);
    float4 _103 = _InputTexture.SampleLevel(s_linear_clamp_sampler, (_82 + float2(0.5, 1.5)) * _BloomBuffer_TexelSize.zw, 0.0);
    float4 _109 = _InputTexture.SampleLevel(s_linear_clamp_sampler, (_82 + float2(1.5, 1.5)) * _BloomBuffer_TexelSize.zw, 0.0);

    uint _112 = gl_LocalInvocationID.y << 4u;
    uint _113 = gl_LocalInvocationID.x + _112;

    // Pack two half values per uint: low 16 = sample A, high 16 = sample B
    gs_cacheR[_113] = f32tof16(_91.x) | (f32tof16(_97.x) << 16u);
    gs_cacheG[_113] = f32tof16(_91.y) | (f32tof16(_97.y) << 16u);
    gs_cacheB[_113] = f32tof16(_91.z) | (f32tof16(_97.z) << 16u);

    uint _141 = _113 + 8u;
    gs_cacheR[_141] = f32tof16(_103.x) | (f32tof16(_109.x) << 16u);
    gs_cacheG[_141] = f32tof16(_103.y) | (f32tof16(_109.y) << 16u);
    gs_cacheB[_141] = f32tof16(_103.z) | (f32tof16(_109.z) << 16u);

    GroupMemoryBarrierWithGroupSync();

    // Phase 2: Horizontal 9-tap Gaussian from shared memory
    uint _170 = _112 + (gl_LocalInvocationID.x << 1u);
    uint _173 = (_112 + gl_LocalInvocationID.x) + (gl_LocalInvocationID.x & 4u);

    uint _175 = gs_cacheR[_173];
    uint _177 = gs_cacheG[_173];
    uint _179 = gs_cacheB[_173];

    // Unpack: low half = even pixel, high half = odd pixel
    float3 s0 = float3(f16tof32(_175), f16tof32(_177), f16tof32(_179));
    float3 s1 = float3(f16tof32(_175 >> 16u), f16tof32(_177 >> 16u), f16tof32(_179 >> 16u));

    uint _197 = _173 + 1u;
    uint _199 = gs_cacheR[_197];
    uint _201 = gs_cacheG[_197];
    uint _203 = gs_cacheB[_197];
    float3 s2 = float3(f16tof32(_199), f16tof32(_201), f16tof32(_203));
    float3 s3 = float3(f16tof32(_199 >> 16u), f16tof32(_201 >> 16u), f16tof32(_203 >> 16u));

    uint _221 = _173 + 2u;
    uint _223 = gs_cacheR[_221];
    uint _225 = gs_cacheG[_221];
    uint _227 = gs_cacheB[_221];
    float3 s4 = float3(f16tof32(_223), f16tof32(_225), f16tof32(_227));
    float3 s5 = float3(f16tof32(_223 >> 16u), f16tof32(_225 >> 16u), f16tof32(_227 >> 16u));

    uint _245 = _173 + 3u;
    uint _247 = gs_cacheR[_245];
    uint _249 = gs_cacheG[_245];
    uint _251 = gs_cacheB[_245];
    float3 s6 = float3(f16tof32(_247), f16tof32(_249), f16tof32(_251));
    float3 s7 = float3(f16tof32(_247 >> 16u), f16tof32(_249 >> 16u), f16tof32(_251 >> 16u));

    uint _269 = _173 + 4u;
    uint _271 = gs_cacheR[_269];
    uint _273 = gs_cacheG[_269];
    uint _275 = gs_cacheB[_269];
    float3 s8 = float3(f16tof32(_271), f16tof32(_273), f16tof32(_275));

    // 9-tap Gaussian weights: 1/256, 8/256, 28/256, 56/256, 70/256, 56/256, 28/256, 8/256, 1/256
    float3 _305 = ((((s4 * 0.2734375) + ((s3 + s5) * 0.21875)) + ((s2 + s6) * 0.109375)) + ((s1 + s7) * 0.03125)) + ((s0 + s8) * 0.00390625);

    // Store horizontal result as full floats
    gs_cacheR[_170] = asuint(_305.x);
    gs_cacheG[_170] = asuint(_305.y);
    gs_cacheB[_170] = asuint(_305.z);

    uint _315 = _170 + 1u;
    float3 s8_hi = float3(f16tof32(_271 >> 16u), f16tof32(_273 >> 16u), f16tof32(_275 >> 16u));
    float3 _328 = ((((s5 * 0.2734375) + ((s4 + s6) * 0.21875)) + ((s3 + s7) * 0.109375)) + ((s2 + s8) * 0.03125)) + ((s1 + s8_hi) * 0.00390625);

    gs_cacheR[_315] = asuint(_328.x);
    gs_cacheG[_315] = asuint(_328.y);
    gs_cacheB[_315] = asuint(_328.z);

    GroupMemoryBarrierWithGroupSync();

    // Phase 3: Vertical 9-tap Gaussian from shared memory
    uint _340 = (gl_LocalInvocationID.y << 3u) + gl_LocalInvocationID.x;
    uint _349 = _340 + 8u;
    uint _358 = _340 + 16u;
    uint _367 = _340 + 24u;
    uint _376 = _340 + 32u;
    uint _385 = _340 + 40u;
    uint _394 = _340 + 48u;
    uint _403 = _340 + 56u;
    uint _412 = _340 + 64u;

    float3 v0 = asfloat(uint3(gs_cacheR[_340], gs_cacheG[_340], gs_cacheB[_340]));
    float3 v1 = asfloat(uint3(gs_cacheR[_349], gs_cacheG[_349], gs_cacheB[_349]));
    float3 v2 = asfloat(uint3(gs_cacheR[_358], gs_cacheG[_358], gs_cacheB[_358]));
    float3 v3 = asfloat(uint3(gs_cacheR[_367], gs_cacheG[_367], gs_cacheB[_367]));
    float3 v4 = asfloat(uint3(gs_cacheR[_376], gs_cacheG[_376], gs_cacheB[_376]));
    float3 v5 = asfloat(uint3(gs_cacheR[_385], gs_cacheG[_385], gs_cacheB[_385]));
    float3 v6 = asfloat(uint3(gs_cacheR[_394], gs_cacheG[_394], gs_cacheB[_394]));
    float3 v7 = asfloat(uint3(gs_cacheR[_403], gs_cacheG[_403], gs_cacheB[_403]));
    float3 v8 = asfloat(uint3(gs_cacheR[_412], gs_cacheG[_412], gs_cacheB[_412]));

    float3 _433 = ((((v4 * 0.2734375) + ((v3 + v5) * 0.21875)) + ((v2 + v6) * 0.109375)) + ((v1 + v7) * 0.03125)) + ((v0 + v8) * 0.00390625);

    uint2 _dims = uint2(_BloomBuffer_TexelSize.xy);
    _OutputTexture[int2(gl_GlobalInvocationID.xy)] = _433 * float(all(gl_GlobalInvocationID.xy < _dims));
}
