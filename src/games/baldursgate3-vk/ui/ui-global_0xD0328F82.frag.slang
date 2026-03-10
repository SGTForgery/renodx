

[[vk::binding(0, 1)]]
cbuffer _9_8 : register(b0, space1)
{
    float _8_m0 : packoffset(c0);
    float _8_m1 : packoffset(c0.y);
    float _8_m2 : packoffset(c0.z);
    float _8_m3 : packoffset(c0.w);
};

[[vk::binding(1, 1)]]
Texture2D<float4> _5 : register(t1, space1);
[[vk::binding(2, 1)]]
Texture2D<float4> _6 : register(t2, space1);
[[vk::binding(3, 1)]]
SamplerState _7 : register(s3, space1);

static float2 _3 = (float2)0;
static float4 _4 = (float4)0;

struct SPIRV_Cross_Input
{
    float2 _3 : TEXCOORD0;
};

struct SPIRV_Cross_Output
{
    float4 _4 : SV_Target0;
};

void frag_main()
{
    float4 _79 = _6.SampleLevel(_7, _3, 0.0f);
    float _80 = _79.w;
    float4 _175;
    [branch]
    if (_80 < 0.001000000047497451305389404296875f)
    {
        _175 = float4(_5.SampleLevel(_7, _3, 0.0f).xyz, 1.0f);
    }
    else
    {
        float4 _174;
        if (_80 == 1.0f)
        {
            float3 _96 = _79.xyz;
            float3 _97 = _96 * 0.077399380505084991455078125f.xxx;
            float3 _101 = pow(abs(_96 + 0.054999999701976776123046875f.xxx) * 0.947867333889007568359375f.xxx, 2.400000095367431640625f.xxx);
            bool3 _102 = bool3(_96.x <= 0.040449999272823333740234375f.xxx.x, _96.y <= 0.040449999272823333740234375f.xxx.y, _96.z <= 0.040449999272823333740234375f.xxx.z);
            float3 _108 = (mul(float3x3(float3(0.627399981021881103515625f, 0.329299986362457275390625f, 0.0432999990880489349365234375f), float3(0.069099999964237213134765625f, 0.91949999332427978515625f, 0.011400000192224979400634765625f), float3(0.01640000008046627044677734375f, 0.087999999523162841796875f, 0.895600020885467529296875f)), float3(_102.x ? _97.x : _101.x, _102.y ? _97.y : _101.y, _102.z ? _97.z : _101.z)) * _8_m0) * 9.9999997473787516355514526367188e-05f.xxx;
            bool3 _109 = bool3(_108.x == 0.0f.xxx.x, _108.y == 0.0f.xxx.y, _108.z == 0.0f.xxx.z);
            float3 _111 = pow(abs(_108), 0.1593017578125f.xxx);
            float3 _112 = float3(_109.x ? 0.0f.xxx.x : _111.x, _109.y ? 0.0f.xxx.y : _111.y, _109.z ? 0.0f.xxx.z : _111.z);
            _174 = float4(pow(abs((0.8359375f.xxx + (_112 * 18.8515625f)) / (1.0f.xxx + (_112 * 18.6875f))), 78.84375f.xxx), 1.0f);
        }
        else
        {
            float3 _127 = _5.SampleLevel(_7, _3, 0.0f).xyz;
            bool3 _128 = bool3(_127.x == 0.0f.xxx.x, _127.y == 0.0f.xxx.y, _127.z == 0.0f.xxx.z);
            float3 _130 = pow(abs(_127), 0.0126833133399486541748046875f.xxx);
            float3 _131 = float3(_128.x ? 0.0f.xxx.x : _130.x, _128.y ? 0.0f.xxx.y : _130.y, _128.z ? 0.0f.xxx.z : _130.z);
            float3 _136 = max(_131 - 0.8359375f.xxx, 0.0f.xxx) / (18.8515625f.xxx - (_131 * 18.6875f));
            bool3 _137 = bool3(_136.x == 0.0f.xxx.x, _136.y == 0.0f.xxx.y, _136.z == 0.0f.xxx.z);
            float3 _140 = pow(abs(_136), 6.277394771575927734375f.xxx) * 10000.0f;
            float3 _142 = _80.xxx;
            float3 _144 = _79.xyz;
            float3 _145 = _144 * 0.077399380505084991455078125f.xxx;
            float3 _149 = pow(abs(_144 + 0.054999999701976776123046875f.xxx) * 0.947867333889007568359375f.xxx, 2.400000095367431640625f.xxx);
            bool3 _150 = bool3(_144.x <= 0.040449999272823333740234375f.xxx.x, _144.y <= 0.040449999272823333740234375f.xxx.y, _144.z <= 0.040449999272823333740234375f.xxx.z);
            float3 _158 = ((mul(float3x3(float3(0.627399981021881103515625f, 0.329299986362457275390625f, 0.0432999990880489349365234375f), float3(0.069099999964237213134765625f, 0.91949999332427978515625f, 0.011400000192224979400634765625f), float3(0.01640000008046627044677734375f, 0.087999999523162841796875f, 0.895600020885467529296875f)), float3(_150.x ? _145.x : _149.x, _150.y ? _145.y : _149.y, _150.z ? _145.z : _149.z)) * _8_m0) + lerp(lerp(float3(_137.x ? 0.0f.xxx.x : _140.x, _137.y ? 0.0f.xxx.y : _140.y, _137.z ? 0.0f.xxx.z : _140.z), 0.0f.xxx, _142), 0.0f.xxx, _142)) * 9.9999997473787516355514526367188e-05f.xxx;
            bool3 _159 = bool3(_158.x == 0.0f.xxx.x, _158.y == 0.0f.xxx.y, _158.z == 0.0f.xxx.z);
            float3 _161 = pow(abs(_158), 0.1593017578125f.xxx);
            float3 _162 = float3(_159.x ? 0.0f.xxx.x : _161.x, _159.y ? 0.0f.xxx.y : _161.y, _159.z ? 0.0f.xxx.z : _161.z);
            _174 = float4(pow(abs((0.8359375f.xxx + (_162 * 18.8515625f)) / (1.0f.xxx + (_162 * 18.6875f))), 78.84375f.xxx), 1.0f);
        }
        _175 = _174;
    }
    _4 = _175;
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    _3 = stage_input._3;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._4 = _4;
    return stage_output;
}
