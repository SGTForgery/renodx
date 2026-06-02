#include "../common.hlsl"

static float _99 = 0.0f;

[[vk::binding(0, 4)]]
cbuffer type_cconstants_cb : register(b0, space4)
{
    float4 cconstants_cb_point_light_positions[64] : packoffset(c0);
    float4 cconstants_cb_point_light_colors[64] : packoffset(c64);
    float4 cconstants_cb_screen_size : packoffset(c128);
    uint cconstants_cb_point_lights_count : packoffset(c129);
    float cconstants_cb_time : packoffset(c129.y);
    float cconstants_cb_sdr_scale : packoffset(c129.z);
};

[[vk::binding(1, 0)]]
SamplerState SamplerLinearClamp : register(s1, space0);

[[vk::binding(9, 0)]]
SamplerState SamplerLinearClampNoBias : register(s9, space0);

[[vk::binding(12, 0)]]
SamplerState SamplerLinearWrapOffsetNoBias : register(s12, space0);

[[vk::binding(19, 2)]]
TextureCube<float4> specular_cube : register(t19, space2);

[[vk::binding(20, 2)]]
TextureCube<float4> diffuse_cube : register(t20, space2);

[[vk::binding(21, 2)]]
Texture2D<float4> environment_ggx_tex : register(t21, space2);

[[vk::binding(22, 2)]]
Texture2D<float4> albedo_tex : register(t22, space2);

[[vk::binding(23, 2)]]
Texture2D<float4> normal_tex : register(t23, space2);

[[vk::binding(24, 2)]]
Texture2D<float4> roughness_tex : register(t24, space2);

[[vk::binding(25, 2)]]
Texture2D<float4> bent_normal_tex : register(t25, space2);

[[vk::binding(26, 2)]]
Texture2D<float4> ao_tex : register(t26, space2);

[[vk::binding(27, 2)]]
Texture2D<float4> depth_tex : register(t27, space2);

[[vk::binding(28, 2)]]
Texture2D<float4> metal_tex : register(t28, space2);

static float4 gl_FragCoord;
static float2 in_var_TEXCOORD0;
static float4 in_var_COLOR0;
static float4 out_var_SV_TARGET;

struct SPIRV_Cross_Input
{
    float2 in_var_TEXCOORD0 : TEXCOORD0;
    float4 in_var_COLOR0 : TEXCOORD1;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_TARGET : SV_Target0;
};

uint2 spvTextureSize(TextureCube<float4> Tex, uint Level, out uint Param)
{
    uint2 ret;
    Tex.GetDimensions(Level, ret.x, ret.y, Param);
    return ret;
}

void frag_main()
{
    float4 _107 = albedo_tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0);
    float4 _110 = normal_tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0);
    float4 _113 = roughness_tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0);
    float4 _119 = ao_tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0);
    float4 _122 = depth_tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0);
    float4 _125 = metal_tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0);
    float3 _135 = float3(gl_FragCoord.xy / cconstants_cb_screen_size.xy, lerp(0.300000011920928955078125f, 0.699999988079071044921875f, _122.x));
    float _136 = _119.x;
    float3 _140 = normalize((_110.xyz * 2.0f) - 1.0f.xxx);
    float3 _143 = _140;
    _143.y = _140.y * (-1.0f);
    float3 _148 = normalize((bent_normal_tex.Sample(SamplerLinearWrapOffsetNoBias, in_var_TEXCOORD0).xyz * 2.0f) - 1.0f.xxx) * _136;
    _148.y = _148.y * (-1.0f);
    float _152 = _113.x;
    float _153 = 1.0f - _152;
    float3 _155 = _107.xyz;
    float3 _156 = _125.x.xxx;
    float3 _157 = lerp(_155, 0.0f.xxx, _156);
    float3 _159 = lerp(0.039999999105930328369140625f.xxx, clamp(_155, 0.0f.xxx, 1.0f.xxx), _156);
    float3x3 _161 = mul(mul(float3x3(float3(1.0f, 0.0f, 0.0f), float3(0.0f, 0.70866978168487548828125f, 0.70554029941558837890625f), float3(0.0f, -0.70554029941558837890625f, 0.70866978168487548828125f)), float3x3(float3(-0.9364566802978515625f, 0.0f, -0.35078322887420654296875f), float3(0.0f, 1.0f, 0.0f), float3(0.35078322887420654296875f, 0.0f, -0.9364566802978515625f))), float3x3(float3(1.0f, 0.0f, 0.0f), float3(0.0f, -1.0f, 0.0f), float3(0.0f, 0.0f, 1.0f)));
    float4 _166 = diffuse_cube.Sample(SamplerLinearClamp, mul(_148, _161));
    float _177 = _140.z;
    float4 _183 = environment_ggx_tex.SampleLevel(SamplerLinearClamp, float4(abs(_177), _153, 0.0f, 0.0f).xy, 0.0f);
    uint _189_dummy_parameter;
    float _196 = log2(float(int(spvTextureSize(specular_cube, uint(0), _189_dummy_parameter).x)) / (1.57079589366912841796875f / (_152 * _152)));
    float3 _217 = normalize(_148);
    float _218 = length(_148);
    float3 _220;
    _220 = 0.0f.xxx;
    for (uint _223 = 0u; _223 < cconstants_cb_point_lights_count; )
    {
        float _241 = clamp((1.0f - cconstants_cb_point_light_positions[_223].y) * 5.0f, 0.0f, 1.0f);
        float3 _244 = cconstants_cb_point_light_positions[_223].xyz - _135;
        _244.z = _244.z * 0.5f;
        float3 _248 = normalize(_244);
        float3 _262 = ((cconstants_cb_point_light_colors[_223].xyz / (dot(_244, _244) + 1.0000000116860974230803549289703e-07f).xxx) * (((clamp(cconstants_cb_point_light_positions[_223].x * 5.0f, 0.0f, 1.0f) * clamp(cconstants_cb_point_light_positions[_223].y * 5.0f, 0.0f, 1.0f)) * _241) * _241)) * clamp((dot(_217, _248) - (1.0f - _218)) * 10.0f, 0.0f, 1.0f);
        float _267 = clamp(_152, 0.0f, 1.0f);
        float _269 = max(_267 * _267, 0.00200000009499490261077880859375f);
        float _270 = _269 * _269;
        float3 _272 = normalize(float3(-0.0f, -0.0f, 1.0f) + _248);
        float _274 = clamp(dot(_143, _272), 0.0f, 1.0f);
        float _276 = clamp(dot(_248, _143), 0.0f, 1.0f);
        float _279 = clamp(_272.z, 0.0f, 1.0f);
        float _286 = _269 * 0.5f;
        float _287 = 1.0f - _286;
        _220 += (((_262 * max(0.0f, dot(_143, _248))) * _157) + (((((lerp(exp2((((-5.554729938507080078125f) * _279) - 6.9831600189208984375f) * _279).xxx, 1.0f.xxx, _159) * (_270 / pow((((_270 - 1.0f) * _274) * _274) + 1.0f, 2.0f))) * (1.0f / (((clamp(_177, 0.0f, 1.0f) * _287) + _286) * ((_276 * _287) + _286)))) * _276) * 0.25f.xxx) * _262));
        _223++;
        continue;
    }
    float _308 = _107.w;
    float4 _314 = float4((((((_166.xyz * 3.3299999237060546875f) * _157) * _136) + (((float4((_183.x.xxx + (_159 * _183.y)) * specular_cube.SampleLevel(SamplerLinearClampNoBias, float4(mul(float3(0.0f, 0.0f, -1.0f) - ((_143 * 2.0f) * dot(float3(0.0f, 0.0f, -1.0f), _143)), _161), _196).xyz, _196).xyz, _99) * 3.3299999237060546875f) * 1.0f).xyz * lerp(_136, 1.0f, _153))) + (_220 * 0.0199999995529651641845703125f)) * _308, _308) * in_var_COLOR0;

    float3 _tonemapped = _314.xyz;

    // RenoDX:
    if (RENODX_TONE_MAP_TYPE > 0.f) {
      _tonemapped = renodx::color::bt2020::from::BT709(_tonemapped);
      _tonemapped = renodx::tonemap::neutwo::MaxChannel(
          _tonemapped, shader_injection.peak_white_nits / shader_injection.graphics_white_nits, 65.f);
      _tonemapped = renodx::color::bt709::from::BT2020(_tonemapped);
    }
    out_var_SV_TARGET = ApplyUIProcessing(_tonemapped, _314.w);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_COLOR0 = stage_input.in_var_COLOR0;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_TARGET = out_var_SV_TARGET;
    return stage_output;
}
