#include "../shared.h"
#include "../common.hlsli"

// Compute twin of TonemapSampleLut (0xA00988AD), UI character permutation (_m2 == 21).
// Since a game patch the final scene -> HDR10 output runs through this dispatch:
// it reads the (linear) color-graded scene, PQ-encodes it with the game's paper
// white, samples the tonemap LUT and writes the r10g10b10a2 output image.
// The RenoDX part below is the same as in TonemapSampleLut.

[[vk::binding(4, 1)]]
cbuffer _11_10 : register(b4, space1)
{
    float _10_m0 : packoffset(c0);   // fade to black
    uint _10_m1 : packoffset(c0.y);  // offset x
    uint _10_m2 : packoffset(c0.z);  // offset y
    uint _10_m3 : packoffset(c0.w);  // size x
    uint _10_m4 : packoffset(c1);    // size y
    float _10_m5 : packoffset(c1.y); // PQ scale (10000 / paper white)
    uint _10_m6 : packoffset(c1.z);
    uint _10_m7 : packoffset(c1.w);
};

[[vk::binding(0, 1)]]
Texture2D<float4> _6 : register(t0, space1);
[[vk::binding(1, 1)]]
Texture3D<float4> _7 : register(t1, space1);
[[vk::binding(2, 1)]]
SamplerState _8 : register(s2, space1);
[[vk::binding(3, 1)]]
[vk::image_format("rgb10a2")]
RWTexture2D<float4> _9 : register(u3, space1);

static uint3 gl_GlobalInvocationID = (uint3)0;
static uint3 gl_LocalInvocationID = (uint3)0;
static uint3 gl_WorkGroupID = (uint3)0;

struct SPIRV_Cross_Input
{
    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
    uint3 gl_LocalInvocationID : SV_GroupThreadID;
    uint3 gl_WorkGroupID : SV_GroupID;
};

void comp_main()
{
    if ((gl_GlobalInvocationID.x >= _10_m3) || (gl_GlobalInvocationID.y >= _10_m4)) return;

    uint _97 = (gl_LocalInvocationID.x * 16u) + gl_LocalInvocationID.y;
    uint _117 = (((gl_WorkGroupID.x * 16u) + (((_97 >> 2u) & 7u) & 65534u)) | (_97 & 1u)) + _10_m1;
    uint _120 = (((gl_WorkGroupID.y * 16u) + ((_97 >> 1u) & 3u)) | (((_97 >> 3u) & 7u) & 65532u)) + _10_m2;
    uint2 pos = uint2(_117, _120);

    float4 _126 = _6.Load(int3(int2(pos), 0));
    float3 _84 = _126.xyz;

    // Same as Forge's UI character branch in TonemapSampleLut: bypass the LUT.
    if (RENODX_TONE_MAP_TYPE != 0.f) {
        float3 color = max(0, _84);
        color = ApplyUICharacterGrading(color);
        color = renodx::color::bt2020::from::BT709(color);
        if (RENODX_TONE_MAP_TYPE == 2.f) {
            color = renodx::tonemap::neutwo::MaxChannel(color, RENODX_PEAK_WHITE_NITS / RENODX_GRAPHICS_WHITE_NITS, 100.f);
        }
        color = renodx::color::bt709::from::BT2020(color);
        color = renodx::color::srgb::EncodeSafe(color);
        color = ApplyUICharacterReGrading(color);
        _9[pos] = lerp(float4(saturate(color), 1.0f), float4(0.0f, 0.0f, 0.0f, 1.0f), _10_m0.xxxx);
        return;
    }

    // Vanilla path (gamut compression + log2 shaper + LUT).
    float _132 = max(_126.x, max(_126.y, _126.z));
    float3 _133 = _132.xxx;
    float _135 = abs(_132);
    float3 _137 = (_133 - _126.xyz) / _135.xxx;
    float3 thr = float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f);
    float3 _139 = float3(_137.x <= thr.x ? 1.0f : 0.327301919460296630859375f, _137.y <= thr.y ? 1.0f : 0.2859380543231964111328125f, _137.z <= thr.z ? 1.0f : 0.0f);
    float3 _d = (_137 - thr) / _139;
    float3 _143 = float3(_139.x > 1e-6f ? _d.x : 0.f, _139.y > 1e-6f ? _d.y : 0.f, _139.z > 1e-6f ? _d.z : 0.f);
    float3 _pw = pow(abs(_143), 1.2000000476837158203125f.xxx);
    float3 _pp = float3(_143.x > 0.f ? _pw.x : 0.f, _143.y > 0.f ? _pw.y : 0.f, _143.z > 0.f ? _pw.z : 0.f);
    float3 _cmp = thr + ((_139 * _143) / pow(1.0f.xxx + _pp, 0.833333313465118408203125f.xxx));
    float3 _sel = float3(_137.x < thr.x ? _137.x : _cmp.x, _137.y < thr.y ? _137.y : _cmp.y, _137.z < thr.z ? _137.z : _cmp.z);
    float3 _157 = max(_133 - (_sel * _135), 0.0f.xxx);
    float3 _sh = float3(_157.x <= 3.0517578125e-05f ? (_157.x * 0.5f) + 1.52587890625e-05f : _157.x,
                        _157.y <= 3.0517578125e-05f ? (_157.y * 0.5f) + 1.52587890625e-05f : _157.y,
                        _157.z <= 3.0517578125e-05f ? (_157.z * 0.5f) + 1.52587890625e-05f : _157.z);
    float3 coord = clamp((log2(_sh) + 9.72000026702880859375f.xxx) * 0.057077623903751373291015625f.xxx, 0.0f.xxx, 1.0f.xxx);
    float3 lut_output = _7.SampleLevel(_8, coord, 0.0f).xyz;
    _9[pos] = lerp(float4(lut_output, 1.0f), float4(0.0f, 0.0f, 0.0f, 1.0f), _10_m0.xxxx);
}

[numthreads(16, 16, 1)]
void main(SPIRV_Cross_Input stage_input)
{
    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
    gl_LocalInvocationID = stage_input.gl_LocalInvocationID;
    gl_WorkGroupID = stage_input.gl_WorkGroupID;
    comp_main();
}
