#include "../common.hlsl"

[[vk::binding(0, 9)]]
cbuffer type_cpost_processing_desc_cb : register(b0, space9)
{
    int cpost_processing_desc_cb_viewport_width : packoffset(c0);
    int cpost_processing_desc_cb_viewport_height : packoffset(c0.y);
    int cpost_processing_desc_cb_oetf_id : packoffset(c0.z);
    float4 cpost_processing_desc_cb_src_frame_to_dynamic_scale : packoffset(c1);
};

[[vk::binding(1, 0)]]
SamplerState SamplerLinearClamp : register(s1, space0);
[[vk::binding(0, 5)]]
Texture2D<float4> source_sampler : register(t0, space5);

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
    float4 _87 = source_sampler.SampleLevel(SamplerLinearClamp, float4(min((gl_FragCoord.xy / float2(float(cpost_processing_desc_cb_viewport_width), float(cpost_processing_desc_cb_viewport_height))) * cpost_processing_desc_cb_src_frame_to_dynamic_scale.xy, cpost_processing_desc_cb_src_frame_to_dynamic_scale.zw), 0.0f, 0.0f).xy, 0.0f);
    float4 _191;
    if (cpost_processing_desc_cb_oetf_id == 0)
    {
        float3 _95 = clamp(_87.xyz, 0.0f.xxx, 1.0f.xxx);
        float _96 = _95.x;
        float _105;
        if (_96 > 0.003130800090730190277099609375f)
        {
            _105 = (1.05499994754791259765625f * pow(_96, 0.4166666567325592041015625f)) - 0.054999999701976776123046875f;
        }
        else
        {
            _105 = 12.9200000762939453125f * _96;
        }
        float _106 = _95.y;
        float _115;
        if (_106 > 0.003130800090730190277099609375f)
        {
            _115 = (1.05499994754791259765625f * pow(_106, 0.4166666567325592041015625f)) - 0.054999999701976776123046875f;
        }
        else
        {
            _115 = 12.9200000762939453125f * _106;
        }
        float _116 = _95.z;
        float _125;
        if (_116 > 0.003130800090730190277099609375f)
        {
            _125 = (1.05499994754791259765625f * pow(_116, 0.4166666567325592041015625f)) - 0.054999999701976776123046875f;
        }
        else
        {
            _125 = 12.9200000762939453125f * _116;
        }
        float3 _126 = float3(_105, _115, _125);
        _191 = float4(_126.x, _126.y, _126.z, _87.w);
    }
    else
    {
        float4 _190;
        if (cpost_processing_desc_cb_oetf_id == 1)
        {
            float3 _136 = pow(clamp(mul(float3x3(float3(0.6274039745330810546875f, 0.329281985759735107421875f, 0.043313600122928619384765625f), float3(0.06909699738025665283203125f, 0.919539988040924072265625f, 0.0113612003624439239501953125f), float3(0.01639159955084323883056640625f, 0.0880132019519805908203125f, 0.895595014095306396484375f)), _87.xyz) * 0.008000000379979610443115234375f, 0.0f.xxx, 1.0f.xxx), 0.1593017578125f.xxx);
            float3 _142 = pow((0.8359375f.xxx + (_136 * 18.8515625f)) / (1.0f.xxx + (_136 * 18.6875f)), 78.84375f.xxx);
            _190 = float4(_142.x, _142.y, _142.z, _87.w);
        }
        else
        {
            float4 _189;
            if (cpost_processing_desc_cb_oetf_id == 2)
            {
                _189 = float4(_87.x, _87.y, _87.z, _87.w);
            }
            else
            {
                float4 _188;
                if (cpost_processing_desc_cb_oetf_id == 3)
                {
                    _188 = float4(_87.x, _87.y, _87.z, _87.w);
                }
                else
                {
                    float3 _155 = clamp(_87.xyz, 0.0f.xxx, 1.0f.xxx);
                    float _156 = _155.x;
                    float _165;
                    if (_156 > 0.003130800090730190277099609375f)
                    {
                        _165 = (1.05499994754791259765625f * pow(_156, 0.4166666567325592041015625f)) - 0.054999999701976776123046875f;
                    }
                    else
                    {
                        _165 = 12.9200000762939453125f * _156;
                    }
                    float _166 = _155.y;
                    float _175;
                    if (_166 > 0.003130800090730190277099609375f)
                    {
                        _175 = (1.05499994754791259765625f * pow(_166, 0.4166666567325592041015625f)) - 0.054999999701976776123046875f;
                    }
                    else
                    {
                        _175 = 12.9200000762939453125f * _166;
                    }
                    float _176 = _155.z;
                    float _185;
                    if (_176 > 0.003130800090730190277099609375f)
                    {
                        _185 = (1.05499994754791259765625f * pow(_176, 0.4166666567325592041015625f)) - 0.054999999701976776123046875f;
                    }
                    else
                    {
                        _185 = 12.9200000762939453125f * _176;
                    }
                    float3 _186 = float3(_165, _175, _185);
                    _188 = float4(_186.x, _186.y, _186.z, _87.w);
                }
                _189 = _188;
            }
            _190 = _189;
        }
        _191 = _190;
    }
    out_var_SV_TARGET = _191;
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
