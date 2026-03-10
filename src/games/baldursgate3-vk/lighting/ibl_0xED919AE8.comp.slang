

// SSAO + Screen-Space Specular IBL Composite Pass
// Applies bilateral-filtered ambient occlusion (non-metallic) or
// desaturated specular IBL reflections (metallic) to the scene.
//
// _8  (u0, space1) = RW output
// _9  (t1, space1) = Scene color input
// _10 (t2, space1) = AO/IBL buffer (.x = AO, .y = specular/metallic IBL)
// _11 (t3, space1) = Depth buffer
// _12 (s4, space1) = Sampler for bilateral blur
//
// Conditions:
//   depth == 1.0 (sky)       -> passthrough, no change
//   _10.y > 0    (metallic)  -> lerp toward desaturated/bright luminance (specular IBL)
//   _10.y <= 0   (non-metal) -> lerp toward black (AO darkening)

// Halton-like temporal jitter sequence for interleaved gradient noise
static const float _86[8] = { 0.0f, 0.5f, 0.25f, 0.75f, 0.125f, 0.625f, 0.375f, 0.875f };

[[vk::binding(0, 0)]]
cbuffer _13_4 : register(b0, space0)
{
    float _4_m0 : packoffset(c0);
    float _4_m1 : packoffset(c0.y);
    float _4_m2 : packoffset(c0.z);
    float _4_m3 : packoffset(c0.w);
    float _4_m4 : packoffset(c1);
    float _4_m5 : packoffset(c1.y);
    int _4_m6 : packoffset(c1.z);
    float _4_m7 : packoffset(c1.w);
};

[[vk::binding(2, 0)]]
cbuffer _14_5 : register(b2, space0)
{
    column_major float4x4 _5_m0 : packoffset(c0);
    column_major float4x4 _5_m1 : packoffset(c4);
    column_major float4x4 _5_m2 : packoffset(c8);
    float _5_m3 : packoffset(c12);
    float _5_m4 : packoffset(c12.y);
    float2 _5_m5 : packoffset(c12.z);
    float3 _5_m6 : packoffset(c13);
    int _5_m7 : packoffset(c13.w);
};

[[vk::binding(3, 0)]]
cbuffer _15_6 : register(b3, space0)
{
    float _6_m0 : packoffset(c0);
    float _6_m1 : packoffset(c0.y);
    float _6_m2 : packoffset(c0.z);
    float _6_m3 : packoffset(c0.w);
};

[[vk::binding(4, 0)]]
cbuffer _16_7 : register(b4, space0)
{
    float2 _7_m0 : packoffset(c0);
    float2 _7_m1 : packoffset(c0.z);
    uint2 _7_m2 : packoffset(c1);
    uint2 _7_m3 : packoffset(c1.z);
    uint2 _7_m4 : packoffset(c2);
    uint _7_m5 : packoffset(c2.z);
    uint _7_m6 : packoffset(c2.w);
    float2 _7_m7 : packoffset(c3);
    float2 _7_m8 : packoffset(c3.z);
    float2 _7_m9 : packoffset(c4);
    float2 _7_m10 : packoffset(c4.z);
    float2 _7_m11 : packoffset(c5);
    float2 _7_m12 : packoffset(c5.z);
    float2 _7_m13 : packoffset(c6);
    float2 _7_m14 : packoffset(c6.z);
    float2 _7_m15 : packoffset(c7);
    float2 _7_m16 : packoffset(c7.z);
    uint2 _7_m17 : packoffset(c8);
    uint2 _7_m18 : packoffset(c8.z);
    uint2 _7_m19 : packoffset(c9);
    uint2 _7_m20 : packoffset(c9.z);
    float2 _7_m21 : packoffset(c10);
    float2 _7_m22 : packoffset(c10.z);
};

[[vk::binding(0, 1)]]
RWTexture2D<float4> _8 : register(u0, space1);
[[vk::binding(1, 1)]]
Texture2D<float4> _9 : register(t1, space1);
[[vk::binding(2, 1)]]
Texture2D<float4> _10 : register(t2, space1);
[[vk::binding(3, 1)]]
Texture2D<float4> _11 : register(t3, space1);
[[vk::binding(4, 1)]]
SamplerState _12 : register(s4, space1);

static uint3 gl_GlobalInvocationID = (uint3)0;
struct SPIRV_Cross_Input
{
    uint3 gl_GlobalInvocationID : SV_DispatchThreadID;
};

void comp_main()
{
    do
    {
        uint2 _100 = gl_GlobalInvocationID.xy + _7_m3;
        if (!(all(bool2(_100.x >= _7_m3.x, _100.y >= _7_m3.y)) && all(bool2(_100.x <= _7_m4.x, _100.y <= _7_m4.y))))
        {
            break;
        }
        uint _111 = _100.x;
        int _112 = int(_111);
        uint _113 = _100.y;
        int _114 = int(_113);
        int2 _116 = int3(_112, _114, 0).xy;
        float4 _118 = _9.Load(int3(_116, 0));  // Scene color
        float4 _120 = _11.Load(int3(_116, 0));  // Depth buffer
        float _121 = _120.x;                     // Depth value

        // Sky pixels (depth == 1.0): pass through scene color unchanged
        [branch]
        if (_121 == 1.0f)
        {
            _8[_100] = _118;
            break;
        }
        // Compute UV for this pixel (pixel center + 0.5 offset)
        float2 _136 = float2((float(_111) + 0.5f) * _6_m2, (float(_113) + 0.5f) * _6_m3);

        // Interleaved gradient noise for per-pixel random rotation
        float _143 = frac(52.98291778564453125f * frac(dot(float2(0.067110560834407806396484375f, 0.005837149918079376220703125f), float2(float(_112), float(_114)))));
        // Apply temporal jitter from Halton sequence, convert to rotation angle [0, 2*PI]
        float _156 = ((_4_m3 != 0.0f) ? frac(_143 + _86[uint(_4_m2) % 8u]) : _143) * 6.283185482025146484375f;
        float2 _161 = float2(_6_m0, _6_m1);
        int _165 = int(floor(log2(max(_6_m0, _6_m1))));
        // Load AO/IBL buffer: .y = specular IBL (metallic), .x = AO (non-metallic)
        float4 _167 = _10.Load(int3(_116, 0));
        float _168 = _167.y;
        bool _169 = _168 > 0.0f;           // Metallic flag: true if specular IBL path
        float _171 = _169 ? _168 : _167.x; // Center sample value
        // Blur kernel radius, scaled by depth for perspective-correct filtering
        float2 _178 = 0.25f.xx / ((float2(_6_m0 * _6_m3, 1.0f) * _5_m4) * _121);
        // First pass: 8-sample rotated disk blur (golden-angle spacing)
        // Gathers AO/IBL samples and checks if bilateral filtering is needed
        bool _180;
        _180 = false;
        float _93[8];
        for (int _183 = 0; _183 < 8; )
        {
            float _188 = float(uint(_183));
            float _192 = mad(_188, 2.3999631404876708984375f, _156);  // Golden angle (~137.5 deg) rotation
            float2 _196 = float2(cos(_192), sin(_192)) * (sqrt(_188 + 0.5f) * 0.3535533845424652099609375f); // Sunflower spiral disk sample
            float4 _213 = _10.SampleLevel(_12, clamp(mad(_178, _196, _136), _7_m9, _7_m10), float(clamp(int(floor(log2(length((_178 * _196) * _161)))), 0, _165)));
            _93[_183] = _169 ? _213.y : _213.x;  // Pick specular or AO channel
            _180 = _180 || (abs(_93[_183] - _171) > 0.0039215688593685626983642578125f); // Edge detection: need bilateral?
            _183++;
            continue;
        }
        // Second pass: depth-aware bilateral filter (only if edge detected)
        float _274;
        [branch]
        if (_180)
        {
            float _226;
            float _229;
            _226 = 0.0f;
            _229 = 0.0f;
            for (int _231 = 0; _231 < 8; )
            {
                float _236 = float(uint(_231));
                float _240 = mad(_236, 2.3999631404876708984375f, _156);
                float2 _244 = float2(cos(_240), sin(_240)) * (sqrt(_236 + 0.5f) * 0.3535533845424652099609375f);
                // Bilateral weight: reject samples at different depths to prevent halo artifacts
                float _268 = 1.0f - clamp((abs(_11.SampleLevel(_12, clamp(mad(_178, _244, _136), _7_m9, _7_m10), float(clamp(int(floor(log2(length((_178 * _244) * _161)))), 0, _165))).x - _121) * _5_m4) * 4.0f, 0.0f, 1.0f);
                _226 = mad(_93[_231], _268, _226);
                _229 += _268;
                _231++;
                continue;
            }
            _274 = (_229 == 0.0f) ? _171 : (_226 / _229); // Weighted average (or fallback to center)
        }
        else
        {
            _274 = _171; // No edge detected: use unfiltered center sample
        }
        // Compute blend target based on metallic vs non-metallic
        float4 _287;
        if (_169)
        {
            // Metallic path: contrast boost, brighten, then convert to grayscale luminance (BT.709)
            // Creates desaturated specular reflection look (IBL approximation on metals)
            float3 _285 = dot(((((_118.xyz - 0.5f.xxx) * 1.5f) + 0.5f.xxx).xyz + 0.20000000298023223876953125f.xxx).xyz, float3(0.2125999927520751953125f, 0.715200006961822509765625f, 0.072200000286102294921875f)).xxx;
            _287 = float4(_285.x, _285.y, _285.z, _118.w);
        }
        else
        {
            // Non-metallic path: target is black -> lerp darkens scene (ambient occlusion)
            _287 = float4(0.0f, 0.0f, 0.0f, 1.0f);
        }
        // Final composite: blend scene color toward AO/IBL target by filtered intensity
        _8[_100] = lerp(_118, _287, _274.xxxx);
        break;
    } while(false);
}

[numthreads(8, 8, 1)]
void main(SPIRV_Cross_Input stage_input)
{
    gl_GlobalInvocationID = stage_input.gl_GlobalInvocationID;
    comp_main();
}
