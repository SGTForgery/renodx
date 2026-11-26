#include "../shared.h"
#include "../common.hlsli"

// Compute twin of TonemapSampleLut (0xA00988AD), log-shaper permutation (_m2 == 20).
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
    uint2 pos = uint2(gl_GlobalInvocationID.x + _10_m1, gl_GlobalInvocationID.y + _10_m2);

    float3 _84 = _6.Load(int3(int2(pos), 0)).xyz;

    // LUT coordinate exactly like vanilla (log2 shaper).
    float3 _x = max(_84, 0.0f.xxx);
    float3 _sh = float3(_x.x <= 3.0517578125e-05f ? (_x.x * 0.5f) + 1.52587890625e-05f : _x.x,
                        _x.y <= 3.0517578125e-05f ? (_x.y * 0.5f) + 1.52587890625e-05f : _x.y,
                        _x.z <= 3.0517578125e-05f ? (_x.z * 0.5f) + 1.52587890625e-05f : _x.z);
    float3 coord = clamp((log2(_sh) + 9.72000026702880859375f.xxx) * 0.057077623903751373291015625f.xxx, 0.0f.xxx, 1.0f.xxx);
    float3 lut_output = _7.SampleLevel(_8, coord, 0.0f).xyz;

    bool input_valid = !(any(isnan(_84)) || any(isinf(_84)));

    if (RENODX_TONE_MAP_TYPE != 0.f) {
        lut_output = renodx::color::pq::DecodeSafe(lut_output, 100.f);
        lut_output = renodx::color::bt709::from::BT2020(lut_output);

        if (RENODX_CUSTOM_CURVE > 0.f) {
            lut_output = SplitContrast(lut_output, 1.f + RENODX_CUSTOM_CURVE * 0.5f, 1.f, 0.18f);
            lut_output *= 0.16f / 0.18f;
        }

        lut_output = PsychoGrade(lut_output);
        lut_output = renodx::color::bt2020::from::BT709(lut_output);

        if (RENODX_HUE_CORRECTION > 0.f && input_valid) {
            float3 tonemapped_bt709 = renodx::color::bt709::from::BT2020(lut_output);
            float peak = RENODX_PEAK_WHITE_NITS / RENODX_DIFFUSE_WHITE_NITS;
            float3 hue_ref = renodx::tonemap::neutwo::PerChannel(max(0, _84), peak.xxx);
            tonemapped_bt709 = CorrectHueAndPurityMBGated(tonemapped_bt709, hue_ref, RENODX_HUE_CORRECTION, 0.05f, 0.5f, 0.f);
            lut_output = renodx::color::bt2020::from::BT709(tonemapped_bt709);
        }

        if (RENODX_GAMMA_CORRECTION == 0.f) {
            lut_output = GammaCorrectHuePreserving(lut_output, true);
        }

        if (RENODX_CUSTOM_GRAIN_STRENGTH > 0) {
            uint2 screen_size;
            _6.GetDimensions(screen_size.x, screen_size.y);
            lut_output = renodx::effects::ApplyFilmGrain(
                lut_output,
                (float2(pos) + 0.5f) / float2(screen_size),
                RENODX_CUSTOM_RANDOM,
                RENODX_CUSTOM_GRAIN_STRENGTH * 0.03f);
        }

        lut_output = renodx::color::pq::EncodeSafe(lut_output, RENODX_DIFFUSE_WHITE_NITS);

        [unroll]
        for (int j = 0; j < 3; ++j) {
            if (isnan(lut_output[j]) || isinf(lut_output[j])) lut_output[j] = 0.f;
        }
        lut_output = saturate(lut_output);
    }

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
