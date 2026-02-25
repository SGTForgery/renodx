#include "../common.hlsl"

static const float3 _84[13] = {
    float3(0.0, 0.0, 4.0), float3(-2.0, -2.0, 1.0), float3(2.0, -2.0, 1.0),
    float3(2.0, 2.0, 1.0), float3(-2.0, 2.0, 1.0), float3(-2.0, 0.0, 2.0),
    float3(2.0, 0.0, 2.0), float3(0.0, 2.0, 2.0), float3(0.0, -2.0, 2.0),
    float3(-1.0, 1.0, 4.0), float3(1.0, 1.0, 4.0), float3(-1.0, -1.0, 4.0),
    float3(-1.0, 1.0, 4.0)
};

[[vk::binding(0, 1)]]
cbuffer ShaderVariablesGlobal : register(b0, space1)
{
    row_major float4x4 _ViewMatrix;
    row_major float4x4 _InvViewMatrix;
    row_major float4x4 _ProjMatrix;
    row_major float4x4 _InvProjMatrix;
    row_major float4x4 _DeprecatedViewProjMatrix;
    row_major float4x4 _ViewNoTransProjMatrix;
    row_major float4x4 _InvViewProjMatrix;
    row_major float4x4 _DeprecatedNonJitteredViewProjMatrix;
    row_major float4x4 _NonJitteredViewNoTransProjMatrix;
    row_major float4x4 _InvNonJitteredViewProjMatrix;
    row_major float4x4 _InvPretransformMatrix;
    float4 _WorldSpaceCameraPos_Internal;
    row_major float4x4 _DeprecatedPrevViewProjMatrix;
    row_major float4x4 _PrevViewNoTransProjMatrix;
    row_major float4x4 _DeprecatedPrevNonJitteredViewProjMatrix;
    row_major float4x4 _PrevNonJitteredViewNoTransProjMatrix;
    row_major float4x4 _PrevInvViewProjMatrix;
    row_major float4x4 _PrevNonJitteredInvViewProjMatrix;
    row_major float4x4 _ReprojectionMatrix;
    row_major float4x4 _WiderFoVViewProjMatrix;
    row_major float4x4 _WiderFoVInvViewProjMatrix;
    float4 _PrevCamPosRWS_Internal;
    float4 _ScreenSize;
    float4 _BackBufferSize;
    float4 _ZBufferParams;
    float4 _ProjectionParams;
    float4 unity_OrthoParams;
    float4 _ScreenParams;
    float4 _FrustumPlanes[6];
    float4 _ShadowFrustumPlanes[6];
    float4 _TaaFrameInfo;
    float4 _TaaJitterStrength;
    float4 _Time;
    float4 _SinTime;
    float4 _CosTime;
    float4 unity_DeltaTime;
    float4 _TimeParameters;
    float4 _LastTimeParameters;
    float _GlobalMipBias;
    float _GlobalMipBiasPow2;
    float _ProbeExposureScale;
    uint _FrameCount;
    float4 _ExposureParams;
    int4 _BinningBufferOffsets;
    float4 _EnvironmentGlobalParams0;
    float4 _GraphicsFeaturesGlobalParam0;
    float4 _GraphicsFeaturesGlobalParam1;
    float4 _WindGlobalParams0;
    float4 _WindGlobalParams2;
    float4 _CharacterPositionParams0;
    float4 _CharacterPositionParams1;
    float4 _CharacterPositionParams2;
    float4 _CharacterPositionParams3;
    float4 _CharacterHeightParams;
    float4 _WindMotorParams0[4];
    float4 _WindMotorParams1[4];
    float4 _WindMotorParams2[4];
    float4 _WindMotorParams3[4];
    float4 _WindMotorCount;
    float4 _LastWindGlobalParams0;
    float4 _LastWindMotorParams0[4];
    float4 _LastWindMotorParams1[4];
    float4 _LastWindMotorParams3[4];
    float4 _FoliageInteractiveParams0;
    float4 _PrevFoliageInteractiveParams0;
    float4 _AtmosphereFogParams0;
    float4 _AtmosphereFogParams1;
    float4 _AtmosphereFogParams2;
    float4 _AtmosphereFogParams3;
    float4 _AtmosphereFogParams4;
    float4 _AtmosphereFogParams5;
    float4 _ExponentialFogParams0;
    float4 _ExponentialFogParams1;
    float4 _ExponentialFogParams2;
    float4 _ExponentialFogParams3;
    float4 _VolumetricFogParams0;
    float4 _VolumetricFogParams1;
    float4 _VolumetricFogParams2;
    float4 _VolumetricFogParams3;
    float4 _VolumetricFogParams4;
    float4 _HeightFogFlowNoiseParams0;
    float4 _HeightFogFlowNoiseParams1;
    float4 _FogBakeLutRescaleParams;
    float4 _FogBakeLutEncodeParams;
    float4 _FogBakeLutYawParams;
    float4 _CloudShadowParams0;
    float4 _CloudShadowParams1;
    float4 _CloudShadowParams2;
    float4 _CloudShadowParams3;
    float4 _Style_MatDistCoef;
    float4 _Style_MatFarAlb0;
    float4 _Style_MatFarAlb1;
    float4 _Style_GbFarEms;
    float4 _Style_GbFarDir;
    float4 _Style_GbCoef;
    float4 _VFXParams0;
    float4 _VFXParams1;
    float4 _VFXParams2;
    float4 _CharacterParams0;
    float4 _CharacterParams1;
    float4 _CharacterParams2;
    float4 _CharacterParams3;
    float4 _CharacterParams4;
    float4 _CharacterParams5;
    float4 _CharacterParams6;
    float4 _CharacterParams7;
    float4 _CharacterParams8;
    float4 _CharacterParams9;
    float4 _CharacterParams10;
    float4 _CharacterParams11;
    float4 _CharacterParams12;
    float4 _CharacterParams13;
    float4 _CharacterParams14;
    float4 _CharacterParams15;
    float4 _InkSimulationWorldToUV;
    float4 _TerrainDeformParams0;
    float4 _TerrainDeformParams1;
    float4 _TerrainClipmapParams0[2];
    float4 _TerrainClipmapParams1[2];
    float _G_EnableFeatureErosionBlend;
    float _G_EnableFeatureB;
    float _G_EnableFeatureC;
    float _G_EnableFeatureD;
    float4 _IVParam0;
    float4 _IVParam1;
    float4 _IVParam2;
    float4 _IVDefaultSHAr;
    float4 _IVDefaultSHAg;
    float4 _IVDefaultSHAb;
    float4 _IVV2Param0;
    float4 _IVV2Param1;
    float4 _IVV2Param2;
    float4 _IVV2Param3;
    float4 _WaterInteractionParams0;
    float4 _WaterInteractionParams1;
    float4 _RainWetnessGlobalParam0;
    float4 _RainWetnessGlobalParam1;
    float4 _RainWetnessGlobalParam2;
    float4 _RainWetnessGlobalParam3;
    float4 _RainWetnessGlobalParam4;
    float4 _RainWetnessGlobalParam5;
    float4 _RainWetnessGlobalParam6;
    float4 _RainWetnessGlobalParam7;
    float4 _RainWetnessGlobalParam8;
    float4 _RainWetnessGlobalParam9;
    float4 _RainWetnessGlobalParam10;
    float4 _VerticalOcclusionMapParam0;
    float4 _WaterWetnessMaskParam0;
    float4 _GpuClothParams;
    float4 _FoliageOccluderParams0;
    float4 _FoliageOccluderCameraPosParam;
    float4 _InteractRaftParams0;
    float4 _InteractRaftParams1;
    row_major float4x4 _FakePlanarReflectionViewProjMatrix;
    float4 _FakeSphericalLightSource;
    float4 _VolumetricComposeParams;
    float4 _HackTempDataBeforeCPPPlugin[32];
};

[[vk::binding(1, 1)]]
cbuffer _BloomBuffer : register(b1, space1)
{
    float4 _BloomBuffer_TexelSize;
    float4 _BloomBuffer_BloomThreshold;
    float4 _BloomBuffer_BloomCharacterThreshold;
    float4 _BloomBuffer_BloomCharacterParams;
};

[[vk::binding(1, 0)]]
Texture2D<float4> _InputTexture : register(t1, space0);
[[vk::binding(2, 0)]]
SamplerState s_linear_clamp_sampler : register(s2, space0);

[[vk::binding(0, 0)]]
RWTexture2D<float3> _OutputTexture : register(u0, space0);

[numthreads(8, 8, 1)]
void main(uint3 gl_GlobalInvocationID : SV_DispatchThreadID)
{
    float2 _90 = float2(gl_GlobalInvocationID.xy);
    float2 _95 = (_90 + float2(0.5, 0.5)) * _BloomBuffer_TexelSize.zw;
    float _98 = 0.0;
    float3 _101 = float3(0.0, 0.0, 0.0);
    float _87[13];
    [loop]
    for (int _103 = 0; _103 < 13; )
    {
        float4 _119 = _InputTexture.SampleLevel(s_linear_clamp_sampler, _95 + (_84[_103].xy * _ScreenSize.zw), 0.0);
        float _125 = _119.x;
        float _126 = _119.y;
        float _127 = _119.z;
        float _128 = max(_125, _126);
        float _129 = max(_128, _127);
        float _133 = clamp(_129 - _BloomBuffer_BloomThreshold.y, 0.0, _BloomBuffer_BloomThreshold.z);
        float _136 = (_BloomBuffer_BloomThreshold.w * _133) * _133;
        float _137 = _129 - _BloomBuffer_BloomThreshold.x;
        float3 _144 = (_119.xyz * (max(_136, _137) / max(_129, 9.9999997473787516355514526367188e-05))) * _ExposureParams.x;

        _144 *= (BLOOM_STRENGTH / 50.0f);

        _87[_103] = 1.0 / (dot(_144, float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625)) + 1.0);
        _98 += (_84[_103].z * _87[_103]);
        _101 += ((_144 * _84[_103].z) * _87[_103]);
        _103++;
        continue;
    }
    uint2 _dims = uint2(_BloomBuffer_TexelSize.xy);
    _OutputTexture[int2(uint2(_90))] = (_101 / float3(_98)) * float(all(gl_GlobalInvocationID.xy <= _dims));
}

