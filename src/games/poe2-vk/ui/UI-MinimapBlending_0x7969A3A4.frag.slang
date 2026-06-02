#include "../common.hlsl"

static float _64 = 0.0f;

[[vk::binding(0, 4)]]
cbuffer type_cminimap_blending_pixel_cb : register(b0, space4)
{
    float4 cminimap_blending_pixel_cb_viewport_size : packoffset(c0);
    float cminimap_blending_pixel_cb_geometry_opacity : packoffset(c1);
    float cminimap_blending_pixel_cb_walkability_opacity : packoffset(c1.y);
    float cminimap_blending_pixel_cb_sdr_scale : packoffset(c1.z);
    uint cminimap_blending_pixel_cb_use_royale_data : packoffset(c1.w);
};

[[vk::binding(13, 0)]]
SamplerState SamplerLinearClampOffsetNoBias : register(s13, space0);

[[vk::binding(17, 2)]]
Texture2D<float4> walkability_sampler : register(t17, space2);

[[vk::binding(18, 2)]]
Texture2D<float4> geometry_sampler : register(t18, space2);

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
    float2 _71 = gl_FragCoord.xy / cminimap_blending_pixel_cb_viewport_size.xy;
    float4 _75 = walkability_sampler.Sample(SamplerLinearClampOffsetNoBias, _71);
    float _76 = _75.x;
    float _82 = clamp((_76 - 0.550000011920928955078125f) * 5.0f, 0.0f, 1.0f);
    float4 _84 = lerp(float4(1.0f, 1.0f, 1.0f, 0.00999999977648258209228515625f), float4(0.5f, 0.5f, 1.0f, 0.5f), clamp((_76 - 0.24999998509883880615234375f) * 5.0f, 0.0f, 1.0f).xxxx);
    float _93 = clamp(_75.y * 2.0f, 0.0f, 1.0f);
    float4 _104 = geometry_sampler.Sample(SamplerLinearClampOffsetNoBias, _71);
    float _110 = _104.w * clamp(length(_104.xyz) * 50.0f, 0.0f, 1.0f);
    float4 _111 = float4(1.0f, 1.0f, 1.0f, _93);
    float4 _116 = lerp(lerp(_84, float4(_84.xyz, 0.0f), _82.xxxx) * _111, float4(0.0f, 0.5f, 1.0f, 0.5f), pow(clamp(clamp(((_93 * (1.0f - _93)) * 4.0f) * clamp(2.0f - (2.0f * _76), 0.0f, 1.0f), 0.0f, 1.0f), 0.0f, 1.0f), 25.0f).xxxx);
    _104.w = lerp(_110, _110 * lerp(1.0f, 0.300000011920928955078125f, cminimap_blending_pixel_cb_walkability_opacity), 1.0f - _82) * cminimap_blending_pixel_cb_geometry_opacity;
    float _128 = _116.w * cminimap_blending_pixel_cb_walkability_opacity;
    float4 _129 = _104 * _111;
    float3 _130 = _116.xyz;
    float3 _132 = _129.xyz;
    float _133 = _129.w;
    float3 _134 = _132 * _133;
    float3 _140 = _133.xxx;
    float _142 = 1.0f - _133;
    float _151 = min(1.0f, 1.0f - ((1.0f - _128) * _142));
    float4 _155 = float4(lerp(lerp(((_130 * _128) + _134) / ((_128 + _133) + 0.00999999977648258209228515625f).xxx, _132, _140), lerp((_130 * _142) + _134, _132, _140), _128.xxx), _151);
    float4 _225;
    if (!(cminimap_blending_pixel_cb_use_royale_data != 0u))
    {
        float _164 = _75.z * 2.0f;
        float _167 = _151 * clamp(1.0f - _164, 0.0f, 1.0f);
        float4 _168 = _155;
        _168.w = _167;
        float _173 = (_75.w - 1.0f) + _164;
        float _181;
        if (_173 > 0.9900000095367431640625f)
        {
            _181 = 0.0f;
        }
        else
        {
            _181 = pow(clamp(_173, 0.0f, 1.0f), 2.0f) * 0.800000011920928955078125f;
        }
        float3 _199 = (_168.xyz * _167).xyz + (float4(pow(clamp(((3.0f * _181) * _181) - (((2.0f * _181) * _181) * _181), 0.0f, 1.0f).xxx, float3(1.1018698215484619140625f, 2.7502377033233642578125f, 19.5606479644775390625f)), _64).xyz * _93).xyz;
        _225 = float4(_199.x, _199.y, _199.z, _168.w);
    }
    else
    {
        float3 _202 = _155.xyz * _151;
        float _204 = _75.w;
        float4 _224;
        if (_204 > 0.0f)
        {
            _224 = lerp(float4(_202.x, _202.y, _202.z, _155.w), float4(0.0588235296308994293212890625f, 0.6235294342041015625f, 1.0f, 1.0f), ((clamp(_204, 0.0f, 1.0f) * 0.5f) * _93).xxxx);
        }
        else
        {
            float _214 = _75.z;
            float4 _223;
            if (_214 > 0.0f)
            {
                _223 = lerp(float4(_202.x, _202.y, _202.z, _155.w), float4(1.0f, 0.13725490868091583251953125f, 0.0f, 1.0f), ((clamp(_214, 0.0f, 1.0f) * 0.5f) * _93).xxxx);
            }
            else
            {
                _223 = float4(_202.x, _202.y, _202.z, _155.w);
            }
            _224 = _223;
        }
        _225 = _224;
    }
    out_var_SV_TARGET = ApplyUIProcessing(_225.xyz, _225.w);
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
