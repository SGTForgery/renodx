

[[vk::binding(0, 1)]]
cbuffer _9_5 : register(b0, space1)
{
    float _5_m0 : packoffset(c0);
    float _5_m1 : packoffset(c0.y);
    int _5_m2 : packoffset(c0.z);
    int _5_m3 : packoffset(c0.w);
};

[[vk::binding(1, 1)]]
Texture2D<float4> _6 : register(t1, space1);
[[vk::binding(2, 1)]]
Texture3D<float4> _7 : register(t2, space1);
[[vk::binding(3, 1)]]
SamplerState _8 : register(s3, space1);

static float4 gl_FragCoord = (float4)0;
static float4 _4 = (float4)0;

struct SPIRV_Cross_Input
{
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 _4 : SV_Target0;
};

void frag_main()
{
    float4 _83 = _6.Load(int3(int3(int(gl_FragCoord.x), int(gl_FragCoord.y), 0).xy, 0));
    float3 _84 = _83.xyz;
    float3 _150;
    if (_5_m2 >= 20)
    {
        float3 _123;
        [branch]
        if (_5_m2 == 21)
        {
            float _98 = max(_83.x, max(_83.y, _83.z));
            float3 _99 = _98.xxx;
            float _101 = abs(_98);
            float3 _103 = (_99 - _84) / _101.xxx;
            bool3 _104 = bool3(_103.x <= float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f).x, _103.y <= float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f).y, _103.z <= float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f).z);
            float3 _105 = float3(_104.x ? 1.0f.xxx.x : float3(0.327301919460296630859375f, 0.2859380543231964111328125f, 0.0f).x, _104.y ? 1.0f.xxx.y : float3(0.327301919460296630859375f, 0.2859380543231964111328125f, 0.0f).y, _104.z ? 1.0f.xxx.z : float3(0.327301919460296630859375f, 0.2859380543231964111328125f, 0.0f).z);
            bool3 _106 = bool3(_105.x > 9.9999999747524270787835121154785e-07f.xxx.x, _105.y > 9.9999999747524270787835121154785e-07f.xxx.y, _105.z > 9.9999999747524270787835121154785e-07f.xxx.z);
            float3 _108 = (_103 - float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f)) / _105;
            float3 _109 = float3(_106.x ? _108.x : 0.0f.xxx.x, _106.y ? _108.y : 0.0f.xxx.y, _106.z ? _108.z : 0.0f.xxx.z);
            bool3 _110 = bool3(_109.x > 0.0f.xxx.x, _109.y > 0.0f.xxx.y, _109.z > 0.0f.xxx.z);
            float3 _112 = pow(abs(_109), 1.2000000476837158203125f.xxx);
            bool3 _114 = bool3(_103.x < float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f).x, _103.y < float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f).y, _103.z < float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f).z);
            float3 _119 = float3(0.814999997615814208984375f, 0.802999973297119140625f, 1.0f) + ((_105 * _109) / pow(1.0f.xxx + float3(_110.x ? _112.x : 0.0f.xxx.x, _110.y ? _112.y : 0.0f.xxx.y, _110.z ? _112.z : 0.0f.xxx.z), 0.833333313465118408203125f.xxx));
            _123 = _99 - (float3(_114.x ? _103.x : _119.x, _114.y ? _103.y : _119.y, _114.z ? _103.z : _119.z) * _101);
        }
        else
        {
            _123 = _84;
        }
        float3 _124 = max(_123, 0.0f.xxx);
        bool3 _125 = bool3(_124.x <= 3.0517578125e-05f.xxx.x, _124.y <= 3.0517578125e-05f.xxx.y, _124.z <= 3.0517578125e-05f.xxx.z);
        float3 _127 = (_124 * 0.5f) + 1.52587890625e-05f.xxx;
        _150 = clamp((log2(float3(_125.x ? _127.x : _124.x, _125.y ? _127.y : _124.y, _125.z ? _127.z : _124.z)) + 9.72000026702880859375f.xxx) * 0.057077623903751373291015625f.xxx, 0.0f.xxx, 1.0f.xxx);
    }
    else
    {
        float3 _138 = (_84 * (10000.0f / _5_m1).xxx) * 9.9999997473787516355514526367188e-05f.xxx;
        bool3 _139 = bool3(_138.x == 0.0f.xxx.x, _138.y == 0.0f.xxx.y, _138.z == 0.0f.xxx.z);
        float3 _141 = pow(abs(_138), 0.1593017578125f.xxx);
        float3 _142 = float3(_139.x ? 0.0f.xxx.x : _141.x, _139.y ? 0.0f.xxx.y : _141.y, _139.z ? 0.0f.xxx.z : _141.z);
        _150 = pow(abs((0.8359375f.xxx + (_142 * 18.8515625f)) / (1.0f.xxx + (_142 * 18.6875f))), 78.84375f.xxx);
    }
    _4 = lerp(float4(_7.SampleLevel(_8, _150, 0.0f).xyz, 1.0f), float4(0.0f, 0.0f, 0.0f, 1.0f), _5_m0.xxxx);
}

SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output._4 = _4;
    return stage_output;
}
