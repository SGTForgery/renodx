// Only updated the register bindings and cbuffer defs. -nilly

#include "../common.hlsl"
#include "../poe2_rendering.hlsli"

static float _193 = 0.0f;

[[vk::binding(0, 9)]]
cbuffer type_cpost_processing_desc_cb : register(b0, space9)
{
    int2 cpost_processing_desc_cb_screen_size : packoffset(c0);
    int2 cpost_processing_desc_cb_frame_size : packoffset(c0.z);
    int2 cpost_processing_desc_cb_dynamic_size : packoffset(c1);
    float2 cpost_processing_desc_cb_jitter_offset : packoffset(c1.z);
    row_major float4x4 cpost_processing_desc_cb_viewproj_matrix : packoffset(c2);
    row_major float4x4 cpost_processing_desc_cb_inv_viewproj_matrix : packoffset(c6);
    row_major float4x4 cpost_processing_desc_cb_inv_proj_matrix : packoffset(c10);
    float cpost_processing_desc_cb_time : packoffset(c14);
    float cpost_processing_desc_cb_fade_amount : packoffset(c14.y);
    float cpost_processing_desc_cb_overlay_intensity : packoffset(c14.z);
    uint cpost_processing_desc_cb_fade_enable : packoffset(c14.w);
    float4 cpost_processing_desc_cb_blur_params : packoffset(c15);
    float4 cpost_processing_desc_cb_decay_map_minmax : packoffset(c16);
    float4 cpost_processing_desc_cb_decay_map_size : packoffset(c17);
    float cpost_processing_desc_cb_decay_map_time : packoffset(c18);
    float cpost_processing_desc_cb_decay_map_type : packoffset(c18.y);
    float cpost_processing_desc_cb_creation_time : packoffset(c18.z);
    float cpost_processing_desc_cb_global_stability : packoffset(c18.w);
    float4 cpost_processing_desc_cb_stabiliser_position : packoffset(c19);
    float4 cpost_processing_desc_cb_ritual_sphere_info : packoffset(c20);
    float cpost_processing_desc_cb_ritual_sphere_ratio : packoffset(c21);
    uint cpost_processing_desc_cb_decay_enable : packoffset(c21.y);
    float cpost_processing_desc_cb_original_intensity : packoffset(c21.z);
    uint cpost_processing_desc_cb_dof_enable : packoffset(c21.w);
    float2 cpost_processing_desc_cb_dof_transition_region : packoffset(c22);
    float cpost_processing_desc_cb_dof_focus_range : packoffset(c22.z);
    float cpost_processing_desc_cb_dof_focus_distance : packoffset(c22.w);
    float cpost_processing_desc_cb_post_transform_ratio : packoffset(c23);
    float cpost_processing_desc_cb_exposure : packoffset(c23.y);
    uint cpost_processing_desc_cb_desaturation_enable : packoffset(c23.z);
    uint cpost_processing_desc_cb_vignette_enable : packoffset(c23.w);
    uint cpost_processing_desc_cb_post_transform_enable : packoffset(c24);
    float cpost_processing_desc_cb_hdr_scale : packoffset(c24.y);
    int cpost_processing_desc_cb_oetf_id : packoffset(c24.z);
    float cpost_processing_desc_cb_engine_loading_amount : packoffset(c24.w);
    float cpost_processing_desc_cb_engine_loading_time : packoffset(c25);
    float4 cpost_processing_desc_cb_azmeri_map_minmax : packoffset(c26);
    uint cpost_processing_desc_cb_azmeri_enable : packoffset(c27);
    uint cpost_processing_desc_cb_upscaled_color : packoffset(c27.y);
};

[[vk::binding(1, 0)]]
SamplerState SamplerLinearClamp : register(s1, space0);
[[vk::binding(9, 0)]]
SamplerState SamplerLinearClampNoBias : register(s9, space0);
[[vk::binding(0, 5)]]
Texture2D<float4> source_sampler : register(t0, space5);
[[vk::binding(1, 5)]]
Texture2D<float4> depth_sampler : register(t1, space5);
[[vk::binding(2, 5)]]
Texture2D<float4> bloom_sampler : register(t2, space5);
[[vk::binding(3, 5)]]
Texture2D<float4> dof_foreground_sampler : register(t3, space5);
[[vk::binding(4, 5)]]
Texture2D<float4> dof_background_sampler : register(t4, space5);
[[vk::binding(5, 5)]]
Texture2D<float4> desaturation_sampler : register(t5, space5);
[[vk::binding(6, 5)]]
Texture2D<float4> gear_loading_tex : register(t6, space5);
[[vk::binding(7, 5)]]
Texture3D<float4> desaturation_transform_sampler : register(t7, space5);
[[vk::binding(8, 5)]]
Texture3D<float4> post_transform_sampler0 : register(t8, space5);
[[vk::binding(9, 5)]]
Texture3D<float4> post_transform_sampler1 : register(t9, space5);

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
    float2 _199 = float2(cpost_processing_desc_cb_screen_size);
    float2 _200 = gl_FragCoord.xy / _199;
    float2 _211;
    if (cpost_processing_desc_cb_upscaled_color == 0u)
    {
        _211 = _199 / float2(cpost_processing_desc_cb_frame_size);
    }
    else
    {
        _211 = 1.0f.xx;
    }
    float2 _217 = float2(cpost_processing_desc_cb_frame_size);
    float2 _221 = _200 * _211;
    float4 _227 = source_sampler.SampleLevel(SamplerLinearClamp, float4(_221, 0.0f, 0.0f).xy, 0.0f);
    float2 _230 = cpost_processing_desc_cb_jitter_offset / _217;
    float2 _233 = (_200 * (float2(cpost_processing_desc_cb_dynamic_size) / _217)) + _230;
    bool _253;
    if (!(!(cpost_processing_desc_cb_decay_enable != 0u)))
    {
        _253 = !(cpost_processing_desc_cb_decay_map_time > 0.0f);
    }
    else
    {
        _253 = true;
    }
    float4 _312;
    [branch]
    if (_253)
    {
        float4 _310;
        if (length(cpost_processing_desc_cb_blur_params.xy) > 0.001000000047497451305389404296875f)
        {
            float2 _265 = _200 - 0.5f.xx;
            float2 _266 = normalize(_265);
            float2 _275 = (_266 * cpost_processing_desc_cb_blur_params.x) + (float2(-_266.y, _266.x) * cpost_processing_desc_cb_blur_params.y);
            float _277 = pow(length(_265), cpost_processing_desc_cb_blur_params.z);
            float _281 = frac(sin(dot(_200, float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f);
            float4 _283;
            float4 _286;
            _283 = 0.0f.xxxx;
            _286 = 0.0f.xxxx;
            for (int _288 = 0; _288 < 2; )
            {
                float _294 = (float(_288) + _281) * 0.5f;
                float4 _296 = lerp(float4(1.0f, 1.0f, 0.0f, 1.0f), float4(0.0f, 1.0f, 1.0f, 1.0f), _294.xxxx);
                _283 += _296;
                _286 += (source_sampler.SampleLevel(SamplerLinearClamp, float4((_200 - (((_275 * _277) * _294) * 0.100000001490116119384765625f)) * _211, 0.0f, 0.0f).xy, 0.0f) * _296);
                _288++;
                continue;
            }
            _310 = _286 / _283;
        }
        else
        {
            _310 = _227;
        }
        float4 _311 = _310;
        _311.w = 1.0f;
        _312 = _311;
    }
    else
    {
        _312 = _227;
    }
    float4 _377;
    [branch]
    if (cpost_processing_desc_cb_dof_enable != 0u)
    {
        float4 _329 = mul(float4((_200.x * 2.0f) - 1.0f, ((1.0f - _200.y) * 2.0f) - 1.0f, depth_sampler.SampleLevel(SamplerLinearClamp, float4(_233, 0.0f, 0.0f).xy, 0.0f).x, 1.0f), cpost_processing_desc_cb_inv_proj_matrix);
        float _334 = abs((_329 / _329.w.xxxx).z);
        float2 _339 = float4(_221 + _230, 0.0f, 0.0f).xy;
        float3 _362 = _312.xyz * 9.9999997473787516355514526367188e-05f;
        _377 = float4(lerp(lerp(_362 + dof_background_sampler.SampleLevel(SamplerLinearClamp, _339, 0.0f).xyz, _312.xyz, smoothstep(0.0f, 1.0f, 1.0f - clamp((_334 - (cpost_processing_desc_cb_dof_focus_distance + cpost_processing_desc_cb_dof_focus_range)) / cpost_processing_desc_cb_dof_transition_region.y, 0.0f, 1.0f)).xxx), _362 + dof_foreground_sampler.SampleLevel(SamplerLinearClamp, _339, 0.0f).xyz, smoothstep(0.0f, 1.0f, clamp((cpost_processing_desc_cb_dof_focus_distance - _334) / cpost_processing_desc_cb_dof_transition_region.x, 0.0f, 1.0f)).xxx), 1.0f);
    }
    else
    {
        _377 = _312;
    }
    float _380 = _200.x;
    float3 _sceneColor = _377.xyz * cpost_processing_desc_cb_original_intensity;

    float3 _bloomColor = bloom_sampler.SampleLevel(SamplerLinearClampNoBias, float4(_380, _200.y, 0.0f, 0.0f).xy, 0.0f).xyz;

    // Musa's bloom scaling
    _bloomColor = renodx::rendering::BloomScaling(_bloomColor, _sceneColor, BLOOM_SCALING);

    _bloomColor *= BLOOM_STRENGTH;

    float3 _396 = (_sceneColor + _bloomColor) * max(1.0f, cpost_processing_desc_cb_exposure);

    // RenoDX: Shadows applied pre LUT on clean linear scene data.
    if (RENODX_TONE_MAP_TYPE > 0.f) {
        UserGradingConfig _shadow_cg = CreateColorGradeConfig();
        if (_shadow_cg.shadows != 1.f) {
            float _shadow_y = renodx::color::y::from::BT709(_396);
            _396 = renodx::color::correct::Luminance(
                _396, _shadow_y,
                Shadows(_shadow_y, _shadow_cg.shadows, 0.18f));
        }
    }

    float4 _397 = float4(_396.x, _396.y, _396.z, _377.w);
    float4 _424;
    do
    {
        if (cpost_processing_desc_cb_desaturation_enable != 0u)
        {
            float4 _418 = desaturation_transform_sampler.SampleLevel(SamplerLinearClamp, float4(pow(clamp(_396.xyz, 0.0f.xxx, 1.0f.xxx), 0.4545454680919647216796875f.xxx), 0.0f).xyz, 0.0f);
            _424 = lerp(_397, float4(_418.x, _418.y, _418.z, _377.w), clamp(desaturation_sampler.Sample(SamplerLinearClamp, _233).x, 0.0f, 1.0f).xxxx);
            break;
        }
        _424 = _397;
        break;
    } while(false);
    // RenoDX: ColorGradeScene controls desaturation LUT strength
    _424 = lerp(_397, _424, saturate(RENODX_COLOR_GRADE_STRENGTH));
    float4 _460;
    if (cpost_processing_desc_cb_post_transform_enable != 0u)
    {
        float _435 = max(max(_424.x, _424.y), max(_424.z, 1.0f));
        float3 _446 = float4(pow(clamp(_424.xyz / _435.xxx, 0.0f.xxx, 1.0f.xxx), 0.4545454680919647216796875f.xxx), 0.0f).xyz;
        float3 _458 = lerp(post_transform_sampler0.SampleLevel(SamplerLinearClamp, _446, 0.0f).xyz, post_transform_sampler1.SampleLevel(SamplerLinearClamp, _446, 0.0f).xyz, cpost_processing_desc_cb_post_transform_ratio.xxx) * _435;
        _460 = float4(_458.x, _458.y, _458.z, _424.w);
    }
    else
    {
        _460 = _424;
    }
    // RenoDX: ColorGradeScene controls post transform LUT strength
    _460 = float4(lerp(_424.xyz, _460.xyz, saturate(RENODX_COLOR_GRADE_STRENGTH)), _460.w);

    if (RENODX_TONE_MAP_TYPE > 0.f) {

        float in_max = max(1.0f, max(_460.x, max(_460.y, _460.z)));
        float3 normalized = _460.xyz / in_max;
        float3 linear_color = renodx::color::srgb::DecodeSafe(normalized) * in_max;

        // Exposure, contrast, highlights in linear space (shadows applied pre LUT).
        UserGradingConfig _pre_cg = CreateColorGradeConfig();
        _pre_cg.shadows = 1.f;
        float _pre_y = renodx::color::y::from::BT709(linear_color);
        linear_color = ApplyExposureContrastFlareHighlightsShadowsByLuminance(
            linear_color, _pre_y, _pre_cg);

        LUTSampleResult lut_result;
        lut_result.graded = linear_color;
        lut_result.y = renodx::color::y::from::BT709(linear_color);
        lut_result.graded_ap1 = renodx::color::ap1::from::BT709(linear_color);
        lut_result.pre_lut_linear = _396;

        float3 hdr_color = PSYCHOGRADE(lut_result);

        float out_max = max(1.0f, max(hdr_color.r, max(hdr_color.g, hdr_color.b)));
        hdr_color = renodx::color::srgb::EncodeSafe(hdr_color / out_max) * out_max;

        if (RENODX_GAMMA_CORRECTION == 1.f) {
            hdr_color = ApplyGammaCorrectionByLuminance(hdr_color);
        }
        _460 = float4(hdr_color, _460.w);
    }

    if (CUSTOM_GRAIN_STRENGTH > 0.f) {
        _460.xyz = renodx::effects::ApplyFilmGrain(
            _460.xyz,
            _200,
            CUSTOM_RANDOM,
            CUSTOM_GRAIN_STRENGTH * 0.03f);
    }

    bool _481;
    do
    {
        if (cpost_processing_desc_cb_oetf_id == 0)
        {
            _481 = false;
            break;
        }
        else
        {
            if (cpost_processing_desc_cb_oetf_id == 1)
            {
                _481 = true;
                break;
            }
            else
            {
                if (cpost_processing_desc_cb_oetf_id == 2)
                {
                    _481 = true;
                    break;
                }
                else
                {
                    if (cpost_processing_desc_cb_oetf_id == 3)
                    {
                        _481 = false;
                        break;
                    }
                    else
                    {
                        _481 = false;
                        break;
                    }
                    break; // unreachable workaround
                }
                break; // unreachable workaround
            }
            break; // unreachable workaround
        }
        break; // unreachable workaround
    } while(false);
    float4 _492;
    if (!_481 && !(RENODX_TONE_MAP_TYPE > 0.f))
    {
        _492 = _460 + (frac(sin(dot(gl_FragCoord.xy, float2(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f) * 0.001000000047497451305389404296875f).xxxx;
    }
    else
    {
        _492 = _460;
    }
    // Vignette:
    // RenoDX: Smoothstep to reduce visible circular banding vs the original hard pow.
    float _vignette_dist = length(_200 - 0.5f.xx) * 1.41421353816986083984375f; // 0..1 from center to corner
    float _vignette_falloff = 1.0f - smoothstep(0.0f, 1.0f, _vignette_dist * _vignette_dist);
    float _vignette_factor = lerp(1.0f, lerp(_vignette_falloff, 1.0f, 0.1500000059604644775390625f), saturate(VIGNETTE_STRENGTH));
    float4 _506 = float4(_492.xyz * _vignette_factor, _492.w);
    float4 _515;
    if (cpost_processing_desc_cb_fade_enable != 0u)
    {
        _515 = _506 * cpost_processing_desc_cb_fade_amount;
    }
    else
    {
        _515 = _506;
    }
    float4 _2785;
    do
    {
        [branch]
        if (cpost_processing_desc_cb_engine_loading_amount < 9.9999997473787516355514526367188e-06f)
        {
            _2785 = _515;
            break;
        }
        float2 _525 = ((_200 * 2.0f) - 1.0f.xx) * 1.7999999523162841796875f;
        float2 _532 = (_525 * 1.0f) + ((float2(0.699999988079071044921875f, -1.0f) * (cpost_processing_desc_cb_time * 1.2999999523162841796875f)) * 1.0f);
        float2 _534;
        float _541;
        _534 = 0.0f.xx;
        _541 = 0.0f;
        float _537 = 1.0f;
        float _539 = 1.0f;
        uint _543 = 0u;
        for (; _543 < 2u; )
        {
            uint3 _550 = (asuint(float3(_539, _537, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _551 = _550.y;
            uint _552 = _550.z;
            uint _555 = _550.x + (_551 * _552);
            uint _557 = _551 + (_552 * _555);
            uint3 _560 = uint3(_555, _557, _552 + (_555 * _557));
            uint3 _562 = _560 ^ (_560 >> uint3(16u, 16u, 16u));
            uint _563 = _562.y;
            uint _564 = _562.z;
            uint _567 = _562.x + (_563 * _564);
            uint _569 = _563 + (_564 * _567);
            float2 _535 = _534 + (float3(_193, clamp(asfloat((_569 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_564 + (_567 * _569)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz * 10.0f);
            float2 _590 = ((_532 * _537) + ((float2(0.699999988079071044921875f, -1.0f) * (cpost_processing_desc_cb_time * 0.20000000298023223876953125f)) * 1.0f)) + _535;
            float2 _592 = smoothstep(0.0f.xx, 1.0f.xx, frac(_590));
            float2 _593 = floor(_590);
            uint3 _602 = (asuint(float3(_593, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _603 = _602.y;
            uint _604 = _602.z;
            uint _607 = _602.x + (_603 * _604);
            uint _609 = _603 + (_604 * _607);
            uint3 _612 = uint3(_607, _609, _604 + (_607 * _609));
            uint3 _614 = _612 ^ (_612 >> uint3(16u, 16u, 16u));
            uint3 _630 = (asuint(float3(_593 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _631 = _630.y;
            uint _632 = _630.z;
            uint _635 = _630.x + (_631 * _632);
            uint _637 = _631 + (_632 * _635);
            uint3 _640 = uint3(_635, _637, _632 + (_635 * _637));
            uint3 _642 = _640 ^ (_640 >> uint3(16u, 16u, 16u));
            uint3 _658 = (asuint(float3(_593 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _659 = _658.y;
            uint _660 = _658.z;
            uint _663 = _658.x + (_659 * _660);
            uint _665 = _659 + (_660 * _663);
            uint3 _668 = uint3(_663, _665, _660 + (_663 * _665));
            uint3 _670 = _668 ^ (_668 >> uint3(16u, 16u, 16u));
            uint3 _686 = (asuint(float3(_593 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _687 = _686.y;
            uint _688 = _686.z;
            uint _691 = _686.x + (_687 * _688);
            uint _693 = _687 + (_688 * _691);
            uint3 _696 = uint3(_691, _693, _688 + (_691 * _693));
            uint3 _698 = _696 ^ (_696 >> uint3(16u, 16u, 16u));
            float _709 = _592.y;
            float _714 = lerp(lerp(clamp(asfloat(((_614.x + (_614.y * _614.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_642.x + (_642.y * _642.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), _709), lerp(clamp(asfloat(((_670.x + (_670.y * _670.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_698.x + (_698.y * _698.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), _709), _592.x) * _539;
            _534 = _535;
            _537 *= 1.7000000476837158203125f;
            _539 *= 0.699999988079071044921875f;
            _541 += _714;
            _543++;
            continue;
        }
        float _718 = _525.y;
        float _725 = cpost_processing_desc_cb_engine_loading_time - 4.0f;
        float _730 = ((_541 * 0.300000011920928955078125f) / max(1.0000000116860974230803549289703e-07f, 0.5099999904632568359375f)) * (pow(max(0.0f, 0.75f - smoothstep(-0.5f, 2.0f, _718)), 2.5f) * smoothstep(6.0f, 20.0f, _725 * (2.0f - _718)));
        float2 _738 = (_525 * 4.0f) + ((float2(0.699999988079071044921875f, -1.0f) * (cpost_processing_desc_cb_time * 0.5f)) * 1.0f);
        float2 _740;
        float _747;
        _740 = 0.0f.xx;
        _747 = 0.0f;
        float _743 = 1.0f;
        float _745 = 1.0f;
        uint _749 = 0u;
        for (; _749 < 3u; )
        {
            uint3 _756 = (asuint(float3(_745, _743, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _757 = _756.y;
            uint _758 = _756.z;
            uint _761 = _756.x + (_757 * _758);
            uint _763 = _757 + (_758 * _761);
            uint3 _766 = uint3(_761, _763, _758 + (_761 * _763));
            uint3 _768 = _766 ^ (_766 >> uint3(16u, 16u, 16u));
            uint _769 = _768.y;
            uint _770 = _768.z;
            uint _773 = _768.x + (_769 * _770);
            uint _775 = _769 + (_770 * _773);
            float2 _741 = _740 + (float3(_193, clamp(asfloat((_775 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_770 + (_773 * _775)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz * 10.0f);
            float2 _796 = ((_738 * _743) + ((float2(0.699999988079071044921875f, -1.0f) * (cpost_processing_desc_cb_time * 0.20000000298023223876953125f)) * 1.0f)) + _741;
            float2 _798 = smoothstep(0.0f.xx, 1.0f.xx, frac(_796));
            float2 _799 = floor(_796);
            uint3 _808 = (asuint(float3(_799, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _809 = _808.y;
            uint _810 = _808.z;
            uint _813 = _808.x + (_809 * _810);
            uint _815 = _809 + (_810 * _813);
            uint3 _818 = uint3(_813, _815, _810 + (_813 * _815));
            uint3 _820 = _818 ^ (_818 >> uint3(16u, 16u, 16u));
            uint3 _836 = (asuint(float3(_799 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _837 = _836.y;
            uint _838 = _836.z;
            uint _841 = _836.x + (_837 * _838);
            uint _843 = _837 + (_838 * _841);
            uint3 _846 = uint3(_841, _843, _838 + (_841 * _843));
            uint3 _848 = _846 ^ (_846 >> uint3(16u, 16u, 16u));
            uint3 _864 = (asuint(float3(_799 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _865 = _864.y;
            uint _866 = _864.z;
            uint _869 = _864.x + (_865 * _866);
            uint _871 = _865 + (_866 * _869);
            uint3 _874 = uint3(_869, _871, _866 + (_869 * _871));
            uint3 _876 = _874 ^ (_874 >> uint3(16u, 16u, 16u));
            uint3 _892 = (asuint(float3(_799 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _893 = _892.y;
            uint _894 = _892.z;
            uint _897 = _892.x + (_893 * _894);
            uint _899 = _893 + (_894 * _897);
            uint3 _902 = uint3(_897, _899, _894 + (_897 * _899));
            uint3 _904 = _902 ^ (_902 >> uint3(16u, 16u, 16u));
            float _915 = _798.y;
            float _920 = lerp(lerp(clamp(asfloat(((_820.x + (_820.y * _820.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_848.x + (_848.y * _848.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), _915), lerp(clamp(asfloat(((_876.x + (_876.y * _876.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_904.x + (_904.y * _904.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), _915), _798.x) * _745;
            _740 = _741;
            _743 *= 1.7999999523162841796875f;
            _745 *= 0.5f;
            _747 += _920;
            _749++;
            continue;
        }
        float4 _931 = float4((((float3(1.0f, 0.20000000298023223876953125f, 0.100000001490116119384765625f) * _730) * 0.1500000059604644775390625f) * 0.300000011920928955078125f) * (pow((_747 * 0.5f) / max(1.0000000116860974230803549289703e-07f, 0.875f), 2.0f) * 1.5f), _730) * cpost_processing_desc_cb_engine_loading_amount;
        float _934 = clamp(1.0f + _931.w, 0.0f, 1.0f);
        float2 _939 = _525 * 0.800000011920928955078125f;
        float2 _941 = smoothstep(0.0f.xx, 1.0f.xx, frac(_939));
        float2 _942 = floor(_939);
        uint3 _951 = (asuint(float3(_942, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
        uint _952 = _951.y;
        uint _953 = _951.z;
        uint _956 = _951.x + (_952 * _953);
        uint _958 = _952 + (_953 * _956);
        uint3 _961 = uint3(_956, _958, _953 + (_956 * _958));
        uint3 _963 = _961 ^ (_961 >> uint3(16u, 16u, 16u));
        uint3 _979 = (asuint(float3(_942 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
        uint _980 = _979.y;
        uint _981 = _979.z;
        uint _984 = _979.x + (_980 * _981);
        uint _986 = _980 + (_981 * _984);
        uint3 _989 = uint3(_984, _986, _981 + (_984 * _986));
        uint3 _991 = _989 ^ (_989 >> uint3(16u, 16u, 16u));
        uint3 _1007 = (asuint(float3(_942 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
        uint _1008 = _1007.y;
        uint _1009 = _1007.z;
        uint _1012 = _1007.x + (_1008 * _1009);
        uint _1014 = _1008 + (_1009 * _1012);
        uint3 _1017 = uint3(_1012, _1014, _1009 + (_1012 * _1014));
        uint3 _1019 = _1017 ^ (_1017 >> uint3(16u, 16u, 16u));
        uint3 _1035 = (asuint(float3(_942 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
        uint _1036 = _1035.y;
        uint _1037 = _1035.z;
        uint _1040 = _1035.x + (_1036 * _1037);
        uint _1042 = _1036 + (_1037 * _1040);
        uint3 _1045 = uint3(_1040, _1042, _1037 + (_1040 * _1042));
        uint3 _1047 = _1045 ^ (_1045 >> uint3(16u, 16u, 16u));
        float _1058 = _941.y;
        float _1063 = lerp(-5.5f, -4.5f, lerp(lerp(clamp(asfloat(((_963.x + (_963.y * _963.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_991.x + (_991.y * _991.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), _1058), lerp(clamp(asfloat(((_1019.x + (_1019.y * _1019.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1047.x + (_1047.y * _1047.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), _1058), _941.x));
        float2 _1068;
        float4 _1072;
        _1068 = float2(0.5226194858551025390625f, 8.81068325042724609375f);
        _1072 = 0.0f.xxxx;
        float _1065 = 0.730000019073486328125f;
        float _1070 = 1.15999996662139892578125f;
        uint _1074 = 0u;
        for (; _1074 < 4u; )
        {
            float2 _1078 = _525 * _1070;
            float2 _1080 = (_1078 * 2.0f) + 0.5f.xx;
            float2 _1082 = smoothstep(0.0f.xx, 1.0f.xx, frac(_1080));
            float2 _1083 = floor(_1080);
            uint3 _1092 = (asuint(float3(_1083, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1093 = _1092.y;
            uint _1094 = _1092.z;
            uint _1097 = _1092.x + (_1093 * _1094);
            uint _1099 = _1093 + (_1094 * _1097);
            uint3 _1102 = uint3(_1097, _1099, _1094 + (_1097 * _1099));
            uint3 _1104 = _1102 ^ (_1102 >> uint3(16u, 16u, 16u));
            uint _1105 = _1104.y;
            uint _1106 = _1104.z;
            uint _1109 = _1104.x + (_1105 * _1106);
            uint _1111 = _1105 + (_1106 * _1109);
            uint3 _1131 = (asuint(float3(_1083 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1132 = _1131.y;
            uint _1133 = _1131.z;
            uint _1136 = _1131.x + (_1132 * _1133);
            uint _1138 = _1132 + (_1133 * _1136);
            uint3 _1141 = uint3(_1136, _1138, _1133 + (_1136 * _1138));
            uint3 _1143 = _1141 ^ (_1141 >> uint3(16u, 16u, 16u));
            uint _1144 = _1143.y;
            uint _1145 = _1143.z;
            uint _1148 = _1143.x + (_1144 * _1145);
            uint _1150 = _1144 + (_1145 * _1148);
            uint3 _1170 = (asuint(float3(_1083 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1171 = _1170.y;
            uint _1172 = _1170.z;
            uint _1175 = _1170.x + (_1171 * _1172);
            uint _1177 = _1171 + (_1172 * _1175);
            uint3 _1180 = uint3(_1175, _1177, _1172 + (_1175 * _1177));
            uint3 _1182 = _1180 ^ (_1180 >> uint3(16u, 16u, 16u));
            uint _1183 = _1182.y;
            uint _1184 = _1182.z;
            uint _1187 = _1182.x + (_1183 * _1184);
            uint _1189 = _1183 + (_1184 * _1187);
            uint3 _1209 = (asuint(float3(_1083 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1210 = _1209.y;
            uint _1211 = _1209.z;
            uint _1214 = _1209.x + (_1210 * _1211);
            uint _1216 = _1210 + (_1211 * _1214);
            uint3 _1219 = uint3(_1214, _1216, _1211 + (_1214 * _1216));
            uint3 _1221 = _1219 ^ (_1219 >> uint3(16u, 16u, 16u));
            uint _1222 = _1221.y;
            uint _1223 = _1221.z;
            uint _1226 = _1221.x + (_1222 * _1223);
            uint _1228 = _1222 + (_1223 * _1226);
            float2 _1244 = _1082.y.xx;
            float2 _1250 = lerp(lerp(float3(_193, clamp(asfloat((_1111 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1106 + (_1109 * _1111)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_1150 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1145 + (_1148 * _1150)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _1244), lerp(float3(_193, clamp(asfloat((_1189 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1184 + (_1187 * _1189)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_1228 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1223 + (_1226 * _1228)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _1244), _1082.x.xx) - 0.5f.xx;
            float2 _1254 = _1078 + ((float2(0.699999988079071044921875f, -1.0f) * _725) * 1.0f);
            float2 _1256 = (_1254 + _1068) + (_1250 * 0.1500000059604644775390625f);
            float2 _1257 = floor(_1256);
            uint3 _1264 = (asuint(float3(_1257, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1265 = _1264.y;
            uint _1266 = _1264.z;
            uint _1269 = _1264.x + (_1265 * _1266);
            uint _1271 = _1265 + (_1266 * _1269);
            uint3 _1274 = uint3(_1269, _1271, _1266 + (_1269 * _1271));
            uint3 _1276 = _1274 ^ (_1274 >> uint3(16u, 16u, 16u));
            uint _1277 = _1276.y;
            uint _1278 = _1276.z;
            uint _1281 = _1276.x + (_1277 * _1278);
            uint _1283 = _1277 + (_1278 * _1281);
            float _1290 = clamp(asfloat((_1281 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f);
            float _1302 = _1290 - 0.5f;
            float _1304 = ((cpost_processing_desc_cb_time * 1.5f) * _1302) * 2.0f;
            float2 _1306 = float3(_1290, clamp(asfloat((_1283 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1278 + (_1281 * _1283)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz - 0.5f.xx;
            float _1307 = sin(_1304);
            float _1308 = cos(_1304);
            float2 _1318 = _1256 * 2.0f;
            float2 _1320 = smoothstep(0.0f.xx, 1.0f.xx, frac(_1318));
            float2 _1321 = floor(_1318);
            uint3 _1330 = (asuint(float3(_1321, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1331 = _1330.y;
            uint _1332 = _1330.z;
            uint _1335 = _1330.x + (_1331 * _1332);
            uint _1337 = _1331 + (_1332 * _1335);
            uint3 _1340 = uint3(_1335, _1337, _1332 + (_1335 * _1337));
            uint3 _1342 = _1340 ^ (_1340 >> uint3(16u, 16u, 16u));
            uint _1343 = _1342.y;
            uint _1344 = _1342.z;
            uint _1347 = _1342.x + (_1343 * _1344);
            uint _1349 = _1343 + (_1344 * _1347);
            uint3 _1369 = (asuint(float3(_1321 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1370 = _1369.y;
            uint _1371 = _1369.z;
            uint _1374 = _1369.x + (_1370 * _1371);
            uint _1376 = _1370 + (_1371 * _1374);
            uint3 _1379 = uint3(_1374, _1376, _1371 + (_1374 * _1376));
            uint3 _1381 = _1379 ^ (_1379 >> uint3(16u, 16u, 16u));
            uint _1382 = _1381.y;
            uint _1383 = _1381.z;
            uint _1386 = _1381.x + (_1382 * _1383);
            uint _1388 = _1382 + (_1383 * _1386);
            uint3 _1408 = (asuint(float3(_1321 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1409 = _1408.y;
            uint _1410 = _1408.z;
            uint _1413 = _1408.x + (_1409 * _1410);
            uint _1415 = _1409 + (_1410 * _1413);
            uint3 _1418 = uint3(_1413, _1415, _1410 + (_1413 * _1415));
            uint3 _1420 = _1418 ^ (_1418 >> uint3(16u, 16u, 16u));
            uint _1421 = _1420.y;
            uint _1422 = _1420.z;
            uint _1425 = _1420.x + (_1421 * _1422);
            uint _1427 = _1421 + (_1422 * _1425);
            uint3 _1447 = (asuint(float3(_1321 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1448 = _1447.y;
            uint _1449 = _1447.z;
            uint _1452 = _1447.x + (_1448 * _1449);
            uint _1454 = _1448 + (_1449 * _1452);
            uint3 _1457 = uint3(_1452, _1454, _1449 + (_1452 * _1454));
            uint3 _1459 = _1457 ^ (_1457 >> uint3(16u, 16u, 16u));
            uint _1460 = _1459.y;
            uint _1461 = _1459.z;
            uint _1464 = _1459.x + (_1460 * _1461);
            uint _1466 = _1460 + (_1461 * _1464);
            float2 _1482 = _1320.y.xx;
            float2 _1488 = lerp(lerp(float3(_193, clamp(asfloat((_1349 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1344 + (_1347 * _1349)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_1388 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1383 + (_1386 * _1388)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _1482), lerp(float3(_193, clamp(asfloat((_1427 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1422 + (_1425 * _1427)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_1466 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1461 + (_1464 * _1466)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _1482), _1320.x.xx) - 0.5f.xx;
            float2 _1493 = (_1256 * 3.0f) + cpost_processing_desc_cb_time.xx;
            float2 _1495 = smoothstep(0.0f.xx, 1.0f.xx, frac(_1493));
            float2 _1496 = floor(_1493);
            uint3 _1505 = (asuint(float3(_1496, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1506 = _1505.y;
            uint _1507 = _1505.z;
            uint _1510 = _1505.x + (_1506 * _1507);
            uint _1512 = _1506 + (_1507 * _1510);
            uint3 _1515 = uint3(_1510, _1512, _1507 + (_1510 * _1512));
            uint3 _1517 = _1515 ^ (_1515 >> uint3(16u, 16u, 16u));
            uint _1518 = _1517.y;
            uint _1519 = _1517.z;
            uint _1522 = _1517.x + (_1518 * _1519);
            uint _1524 = _1518 + (_1519 * _1522);
            uint3 _1544 = (asuint(float3(_1496 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1545 = _1544.y;
            uint _1546 = _1544.z;
            uint _1549 = _1544.x + (_1545 * _1546);
            uint _1551 = _1545 + (_1546 * _1549);
            uint3 _1554 = uint3(_1549, _1551, _1546 + (_1549 * _1551));
            uint3 _1556 = _1554 ^ (_1554 >> uint3(16u, 16u, 16u));
            uint _1557 = _1556.y;
            uint _1558 = _1556.z;
            uint _1561 = _1556.x + (_1557 * _1558);
            uint _1563 = _1557 + (_1558 * _1561);
            uint3 _1583 = (asuint(float3(_1496 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1584 = _1583.y;
            uint _1585 = _1583.z;
            uint _1588 = _1583.x + (_1584 * _1585);
            uint _1590 = _1584 + (_1585 * _1588);
            uint3 _1593 = uint3(_1588, _1590, _1585 + (_1588 * _1590));
            uint3 _1595 = _1593 ^ (_1593 >> uint3(16u, 16u, 16u));
            uint _1596 = _1595.y;
            uint _1597 = _1595.z;
            uint _1600 = _1595.x + (_1596 * _1597);
            uint _1602 = _1596 + (_1597 * _1600);
            uint3 _1622 = (asuint(float3(_1496 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1623 = _1622.y;
            uint _1624 = _1622.z;
            uint _1627 = _1622.x + (_1623 * _1624);
            uint _1629 = _1623 + (_1624 * _1627);
            uint3 _1632 = uint3(_1627, _1629, _1624 + (_1627 * _1629));
            uint3 _1634 = _1632 ^ (_1632 >> uint3(16u, 16u, 16u));
            uint _1635 = _1634.y;
            uint _1636 = _1634.z;
            uint _1639 = _1634.x + (_1635 * _1636);
            uint _1641 = _1635 + (_1636 * _1639);
            float2 _1657 = _1495.y.xx;
            float2 _1663 = lerp(lerp(float3(_193, clamp(asfloat((_1524 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1519 + (_1522 * _1524)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_1563 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1558 + (_1561 * _1563)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _1657), lerp(float3(_193, clamp(asfloat((_1602 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1597 + (_1600 * _1602)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_1641 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1636 + (_1639 * _1641)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _1657), _1495.x.xx) - 0.5f.xx;
            float2 _1667 = mul(float2x2(float2(0.644217669963836669921875f, 0.764842212200164794921875f), float2(-0.764842212200164794921875f, 0.644217669963836669921875f)), ((_1256 + (_1488 * 0.100000001490116119384765625f)) - (_1663 * 0.070000000298023223876953125f)) - (((mul(float2x2(float2(_1307, _1308), float2(-_1308, _1307)), _1306) * 2.0f) * 0.3333333432674407958984375f.xx) + (_1257 + 0.5f.xx)));
            float2 _1668 = _1306 * float2(0.4000000059604644775390625f, 0.20000000298023223876953125f);
            float _1676 = 1.0f - smoothstep(0.000600000028498470783233642578125f, 0.0030000000260770320892333984375f, length(_1667 * (float2(2.099999904632568359375f, 1.0499999523162841796875f) + _1668)));
            float _1686 = max(0.0f, exp(length(_1667 * (float2(0.800000011920928955078125f, 0.5f) + _1668)) * (-499.999969482421875f)) - 6.1442124206223525106906890869141e-06f);
            float3 _1688 = (float3(22.75f, 2.76249980926513671875f, 0.324999988079071044921875f) * _1686) * _1686;
            float4 _1694 = float4(float3(10.0f, 2.0f, 1.25f) * _1676, clamp(_1676, 0.0f, 1.0f)) + float4(_1688, clamp(_1686, 0.0f, 1.0f));
            float _1695 = _1302 * 2.5f;
            uint3 _1705 = (asuint(float3(_1257 + 0.21400000154972076416015625f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1706 = _1705.y;
            uint _1707 = _1705.z;
            uint _1710 = _1705.x + (_1706 * _1707);
            uint _1712 = _1706 + (_1707 * _1710);
            uint3 _1715 = uint3(_1710, _1712, _1707 + (_1710 * _1712));
            uint3 _1717 = _1715 ^ (_1715 >> uint3(16u, 16u, 16u));
            float _1729 = (clamp(asfloat(((_1717.x + (_1717.y * _1717.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f) - 1.7999999523162841796875f) * 1.2999999523162841796875f;
            float _1732 = (1.0f - smoothstep(_1695, _1695 + 0.5f, _718)) * smoothstep(_1729, _1729 + 0.5f, _718);
            float _1751 = _1065 * (1.0f - ((smoothstep(0.0f, 1.0f, _730) * float(_1074)) * 0.25f));
            float4 _1752 = (float4(_1694.xyz * _1732, _1694.w * _1732) * (1.0f - smoothstep(_1063 - 1.5f, _1063, _1254.y))) * _1751;
            float _1754 = _1752.w;
            float3 _1766 = float3(_1065, _1065, 0.0f);
            uint3 _1769 = (asuint(_1766) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _1770 = _1769.y;
            uint _1771 = _1769.z;
            uint _1774 = _1769.x + (_1770 * _1771);
            uint _1776 = _1770 + (_1771 * _1774);
            uint3 _1779 = uint3(_1774, _1776, _1771 + (_1774 * _1776));
            uint3 _1781 = _1779 ^ (_1779 >> uint3(16u, 16u, 16u));
            uint _1782 = _1781.y;
            uint _1783 = _1781.z;
            uint _1786 = _1781.x + (_1782 * _1783);
            uint _1788 = _1782 + (_1783 * _1786);
            _1065 *= 0.728999912738800048828125f;
            _1068 += (float3(_193, clamp(asfloat((_1788 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_1783 + (_1786 * _1788)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz * 10.0f);
            _1070 *= 1.15762484073638916015625f;
            _1072 = float4((_1072.xyz * (1.0f - clamp(_1754, 0.0f, 1.0f))) + _1752.xyz, clamp(_1072.w + _1754, 0.0f, 1.0f));
            _1074++;
            continue;
        }
        float4 _1804 = _1072 * cpost_processing_desc_cb_engine_loading_amount;
        float _1806 = _1804.w;
        float _1813 = clamp(_934 + _1806, 0.0f, 1.0f);
        float2 _1827 = float2(1.0f, float(cpost_processing_desc_cb_frame_size.y) / float(cpost_processing_desc_cb_frame_size.x));
        float3 _1829 = float3(_380, _200.y, 0.0f);
        float _1832 = frac(cpost_processing_desc_cb_time * 0.25f) * 6.283185482025146484375f;
        float _1833 = sin(_1832);
        float _1834 = cos(_1832);
        float2 _1839 = mul(float2x2(float2(_1833, _1834), float2(-_1834, _1833)), ((_200 - float2(0.520699977874755859375f, 0.5f)) * 20.0f) * _1827);
        float _1845 = max(abs(_1839.x), abs(_1839.y)) - 0.5f;
        float4 _1857 = gear_loading_tex.Sample(SamplerLinearClamp, _1839 + 0.5f.xx);
        float _1858 = _1857.w;
        float3 _1861 = _1829;
        _1861.z = smoothstep(0.0f, 1.0f, _1858) * 0.20000000298023223876953125f;
        float2 _1865 = ddx(_200);
        float2 _1866 = ddy(_200);
        float _1867 = _1865.x;
        float _1868 = _1866.y;
        float _1870 = _1865.y;
        float _1871 = _1866.x;
        float _1873 = (_1867 * _1868) - (_1870 * _1871);
        float2 _1881 = ((abs(_1873) > 0.0f) ? _1873 : 1.0000000116860974230803549289703e-07f).xx;
        float2x3 _1885 = mul(float2x2(float2(_1868, -_1870) / _1881, float2(-_1871, _1867) / _1881), float2x3(ddx(_1861), ddy(_1861)));
        float3 _1888 = cross(_1885[0], _1885[1]);
        float3 _1892 = _1888 / max(1.0000000116860974230803549289703e-07f, length(_1888)).xxx;
        float3 _1894 = normalize(float3(0.20000000298023223876953125f, 0.800000011920928955078125f, 4.0f) - _1861);
        float3 _1896 = normalize(float3(0.5f, 0.5f, 1.0f) - _1829);
        float3 _1899 = _1857.xyz;
        float _1908 = smoothstep(0.0f, 0.5f, cpost_processing_desc_cb_engine_loading_time - 1.0f);
        float _1924 = ((-0.064000003039836883544921875f) + frac(cpost_processing_desc_cb_time * (-0.25f))) * 6.283185482025146484375f;
        float _1925 = sin(_1924);
        float _1926 = cos(_1924);
        float2 _1931 = mul(float2x2(float2(_1925, _1926), float2(-_1926, _1925)), ((_200 - float2(0.4792999923229217529296875f, 0.5f)) * 20.0f) * _1827);
        float _1937 = max(abs(_1931.x), abs(_1931.y)) - 0.5f;
        float4 _1948 = gear_loading_tex.Sample(SamplerLinearClamp, _1931 + 0.5f.xx);
        float _1949 = _1948.w;
        float3 _1952 = _1829;
        _1952.z = smoothstep(0.0f, 1.0f, _1949) * 0.20000000298023223876953125f;
        float2 _1956 = ddx(_200);
        float2 _1957 = ddy(_200);
        float _1958 = _1956.x;
        float _1959 = _1957.y;
        float _1961 = _1956.y;
        float _1962 = _1957.x;
        float _1964 = (_1958 * _1959) - (_1961 * _1962);
        float2 _1972 = ((abs(_1964) > 0.0f) ? _1964 : 1.0000000116860974230803549289703e-07f).xx;
        float2x3 _1976 = mul(float2x2(float2(_1959, -_1961) / _1972, float2(-_1962, _1958) / _1972), float2x3(ddx(_1952), ddy(_1952)));
        float3 _1979 = cross(_1976[0], _1976[1]);
        float3 _1983 = _1979 / max(1.0000000116860974230803549289703e-07f, length(_1979)).xxx;
        float3 _1985 = normalize(float3(0.20000000298023223876953125f, 0.800000011920928955078125f, 4.0f) - _1952);
        float3 _1988 = _1948.xyz;
        float4 _2006 = (((float4(0.800000011920928955078125f.xxx * ((_1899 * clamp(dot(_1892, _1894), 0.0f, 1.0f)) + (_1899 * pow(clamp(dot(_1892, normalize(_1894 + _1896)), 0.0f, 1.0f), 1.0f))), 1.0f) * _1858) * (1.0f - clamp(_1845 / max(1.0000000116860974230803549289703e-07f, length(float2(ddx(_1845), ddy(_1845)))), 0.0f, 1.0f))) * _1908) + ((((float4(0.800000011920928955078125f.xxx * ((_1988 * clamp(dot(_1983, _1985), 0.0f, 1.0f)) + (_1988 * pow(clamp(dot(_1983, normalize(_1985 + _1896)), 0.0f, 1.0f), 1.0f))), 1.0f) * _1949) * (1.0f - clamp(_1937 / max(1.0000000116860974230803549289703e-07f, length(float2(ddx(_1937), ddy(_1937)))), 0.0f, 1.0f))) * _1908) * float4(0.699999988079071044921875f, 0.699999988079071044921875f, 0.699999988079071044921875f, 1.0f));
        float _2015 = clamp(_1813 + _2006.w, 0.0f, 1.0f);
        float2 _2024;
        float4 _2028;
        _2024 = float2(9.1670284271240234375f, 8.5698833465576171875f);
        _2028 = 0.0f.xxxx;
        float _2021 = 1.0f;
        float _2026 = 1.0f;
        uint _2030 = 0u;
        for (; _2030 < 1u; )
        {
            float2 _2034 = _525 * _2026;
            float2 _2036 = (_2034 * 2.0f) + 0.5f.xx;
            float2 _2038 = smoothstep(0.0f.xx, 1.0f.xx, frac(_2036));
            float2 _2039 = floor(_2036);
            uint3 _2048 = (asuint(float3(_2039, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2049 = _2048.y;
            uint _2050 = _2048.z;
            uint _2053 = _2048.x + (_2049 * _2050);
            uint _2055 = _2049 + (_2050 * _2053);
            uint3 _2058 = uint3(_2053, _2055, _2050 + (_2053 * _2055));
            uint3 _2060 = _2058 ^ (_2058 >> uint3(16u, 16u, 16u));
            uint _2061 = _2060.y;
            uint _2062 = _2060.z;
            uint _2065 = _2060.x + (_2061 * _2062);
            uint _2067 = _2061 + (_2062 * _2065);
            uint3 _2087 = (asuint(float3(_2039 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2088 = _2087.y;
            uint _2089 = _2087.z;
            uint _2092 = _2087.x + (_2088 * _2089);
            uint _2094 = _2088 + (_2089 * _2092);
            uint3 _2097 = uint3(_2092, _2094, _2089 + (_2092 * _2094));
            uint3 _2099 = _2097 ^ (_2097 >> uint3(16u, 16u, 16u));
            uint _2100 = _2099.y;
            uint _2101 = _2099.z;
            uint _2104 = _2099.x + (_2100 * _2101);
            uint _2106 = _2100 + (_2101 * _2104);
            uint3 _2126 = (asuint(float3(_2039 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2127 = _2126.y;
            uint _2128 = _2126.z;
            uint _2131 = _2126.x + (_2127 * _2128);
            uint _2133 = _2127 + (_2128 * _2131);
            uint3 _2136 = uint3(_2131, _2133, _2128 + (_2131 * _2133));
            uint3 _2138 = _2136 ^ (_2136 >> uint3(16u, 16u, 16u));
            uint _2139 = _2138.y;
            uint _2140 = _2138.z;
            uint _2143 = _2138.x + (_2139 * _2140);
            uint _2145 = _2139 + (_2140 * _2143);
            uint3 _2165 = (asuint(float3(_2039 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2166 = _2165.y;
            uint _2167 = _2165.z;
            uint _2170 = _2165.x + (_2166 * _2167);
            uint _2172 = _2166 + (_2167 * _2170);
            uint3 _2175 = uint3(_2170, _2172, _2167 + (_2170 * _2172));
            uint3 _2177 = _2175 ^ (_2175 >> uint3(16u, 16u, 16u));
            uint _2178 = _2177.y;
            uint _2179 = _2177.z;
            uint _2182 = _2177.x + (_2178 * _2179);
            uint _2184 = _2178 + (_2179 * _2182);
            float2 _2200 = _2038.y.xx;
            float2 _2206 = lerp(lerp(float3(_193, clamp(asfloat((_2067 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2062 + (_2065 * _2067)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_2106 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2101 + (_2104 * _2106)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _2200), lerp(float3(_193, clamp(asfloat((_2145 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2140 + (_2143 * _2145)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_2184 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2179 + (_2182 * _2184)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _2200), _2038.x.xx) - 0.5f.xx;
            float2 _2210 = _2034 + ((float2(0.699999988079071044921875f, -1.0f) * _725) * 1.0f);
            float2 _2212 = (_2210 + _2024) + (_2206 * 0.1500000059604644775390625f);
            float2 _2213 = floor(_2212);
            uint3 _2220 = (asuint(float3(_2213, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2221 = _2220.y;
            uint _2222 = _2220.z;
            uint _2225 = _2220.x + (_2221 * _2222);
            uint _2227 = _2221 + (_2222 * _2225);
            uint3 _2230 = uint3(_2225, _2227, _2222 + (_2225 * _2227));
            uint3 _2232 = _2230 ^ (_2230 >> uint3(16u, 16u, 16u));
            uint _2233 = _2232.y;
            uint _2234 = _2232.z;
            uint _2237 = _2232.x + (_2233 * _2234);
            uint _2239 = _2233 + (_2234 * _2237);
            float _2246 = clamp(asfloat((_2237 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f);
            float _2258 = _2246 - 0.5f;
            float _2260 = ((cpost_processing_desc_cb_time * 1.5f) * _2258) * 2.0f;
            float2 _2262 = float3(_2246, clamp(asfloat((_2239 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2234 + (_2237 * _2239)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz - 0.5f.xx;
            float _2263 = sin(_2260);
            float _2264 = cos(_2260);
            float2 _2274 = _2212 * 2.0f;
            float2 _2276 = smoothstep(0.0f.xx, 1.0f.xx, frac(_2274));
            float2 _2277 = floor(_2274);
            uint3 _2286 = (asuint(float3(_2277, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2287 = _2286.y;
            uint _2288 = _2286.z;
            uint _2291 = _2286.x + (_2287 * _2288);
            uint _2293 = _2287 + (_2288 * _2291);
            uint3 _2296 = uint3(_2291, _2293, _2288 + (_2291 * _2293));
            uint3 _2298 = _2296 ^ (_2296 >> uint3(16u, 16u, 16u));
            uint _2299 = _2298.y;
            uint _2300 = _2298.z;
            uint _2303 = _2298.x + (_2299 * _2300);
            uint _2305 = _2299 + (_2300 * _2303);
            uint3 _2325 = (asuint(float3(_2277 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2326 = _2325.y;
            uint _2327 = _2325.z;
            uint _2330 = _2325.x + (_2326 * _2327);
            uint _2332 = _2326 + (_2327 * _2330);
            uint3 _2335 = uint3(_2330, _2332, _2327 + (_2330 * _2332));
            uint3 _2337 = _2335 ^ (_2335 >> uint3(16u, 16u, 16u));
            uint _2338 = _2337.y;
            uint _2339 = _2337.z;
            uint _2342 = _2337.x + (_2338 * _2339);
            uint _2344 = _2338 + (_2339 * _2342);
            uint3 _2364 = (asuint(float3(_2277 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2365 = _2364.y;
            uint _2366 = _2364.z;
            uint _2369 = _2364.x + (_2365 * _2366);
            uint _2371 = _2365 + (_2366 * _2369);
            uint3 _2374 = uint3(_2369, _2371, _2366 + (_2369 * _2371));
            uint3 _2376 = _2374 ^ (_2374 >> uint3(16u, 16u, 16u));
            uint _2377 = _2376.y;
            uint _2378 = _2376.z;
            uint _2381 = _2376.x + (_2377 * _2378);
            uint _2383 = _2377 + (_2378 * _2381);
            uint3 _2403 = (asuint(float3(_2277 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2404 = _2403.y;
            uint _2405 = _2403.z;
            uint _2408 = _2403.x + (_2404 * _2405);
            uint _2410 = _2404 + (_2405 * _2408);
            uint3 _2413 = uint3(_2408, _2410, _2405 + (_2408 * _2410));
            uint3 _2415 = _2413 ^ (_2413 >> uint3(16u, 16u, 16u));
            uint _2416 = _2415.y;
            uint _2417 = _2415.z;
            uint _2420 = _2415.x + (_2416 * _2417);
            uint _2422 = _2416 + (_2417 * _2420);
            float2 _2438 = _2276.y.xx;
            float2 _2444 = lerp(lerp(float3(_193, clamp(asfloat((_2305 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2300 + (_2303 * _2305)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_2344 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2339 + (_2342 * _2344)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _2438), lerp(float3(_193, clamp(asfloat((_2383 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2378 + (_2381 * _2383)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_2422 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2417 + (_2420 * _2422)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _2438), _2276.x.xx) - 0.5f.xx;
            float2 _2449 = (_2212 * 3.0f) + cpost_processing_desc_cb_time.xx;
            float2 _2451 = smoothstep(0.0f.xx, 1.0f.xx, frac(_2449));
            float2 _2452 = floor(_2449);
            uint3 _2461 = (asuint(float3(_2452, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2462 = _2461.y;
            uint _2463 = _2461.z;
            uint _2466 = _2461.x + (_2462 * _2463);
            uint _2468 = _2462 + (_2463 * _2466);
            uint3 _2471 = uint3(_2466, _2468, _2463 + (_2466 * _2468));
            uint3 _2473 = _2471 ^ (_2471 >> uint3(16u, 16u, 16u));
            uint _2474 = _2473.y;
            uint _2475 = _2473.z;
            uint _2478 = _2473.x + (_2474 * _2475);
            uint _2480 = _2474 + (_2475 * _2478);
            uint3 _2500 = (asuint(float3(_2452 + float2(0.0f, 1.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2501 = _2500.y;
            uint _2502 = _2500.z;
            uint _2505 = _2500.x + (_2501 * _2502);
            uint _2507 = _2501 + (_2502 * _2505);
            uint3 _2510 = uint3(_2505, _2507, _2502 + (_2505 * _2507));
            uint3 _2512 = _2510 ^ (_2510 >> uint3(16u, 16u, 16u));
            uint _2513 = _2512.y;
            uint _2514 = _2512.z;
            uint _2517 = _2512.x + (_2513 * _2514);
            uint _2519 = _2513 + (_2514 * _2517);
            uint3 _2539 = (asuint(float3(_2452 + float2(1.0f, 0.0f), 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2540 = _2539.y;
            uint _2541 = _2539.z;
            uint _2544 = _2539.x + (_2540 * _2541);
            uint _2546 = _2540 + (_2541 * _2544);
            uint3 _2549 = uint3(_2544, _2546, _2541 + (_2544 * _2546));
            uint3 _2551 = _2549 ^ (_2549 >> uint3(16u, 16u, 16u));
            uint _2552 = _2551.y;
            uint _2553 = _2551.z;
            uint _2556 = _2551.x + (_2552 * _2553);
            uint _2558 = _2552 + (_2553 * _2556);
            uint3 _2578 = (asuint(float3(_2452 + 1.0f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2579 = _2578.y;
            uint _2580 = _2578.z;
            uint _2583 = _2578.x + (_2579 * _2580);
            uint _2585 = _2579 + (_2580 * _2583);
            uint3 _2588 = uint3(_2583, _2585, _2580 + (_2583 * _2585));
            uint3 _2590 = _2588 ^ (_2588 >> uint3(16u, 16u, 16u));
            uint _2591 = _2590.y;
            uint _2592 = _2590.z;
            uint _2595 = _2590.x + (_2591 * _2592);
            uint _2597 = _2591 + (_2592 * _2595);
            float2 _2613 = _2451.y.xx;
            float2 _2619 = lerp(lerp(float3(_193, clamp(asfloat((_2480 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2475 + (_2478 * _2480)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_2519 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2514 + (_2517 * _2519)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _2613), lerp(float3(_193, clamp(asfloat((_2558 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2553 + (_2556 * _2558)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, float3(_193, clamp(asfloat((_2597 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2592 + (_2595 * _2597)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz, _2613), _2451.x.xx) - 0.5f.xx;
            float2 _2623 = mul(float2x2(float2(0.644217669963836669921875f, 0.764842212200164794921875f), float2(-0.764842212200164794921875f, 0.644217669963836669921875f)), ((_2212 + (_2444 * 0.100000001490116119384765625f)) - (_2619 * 0.070000000298023223876953125f)) - (((mul(float2x2(float2(_2263, _2264), float2(-_2264, _2263)), _2262) * 2.0f) * 0.3333333432674407958984375f.xx) + (_2213 + 0.5f.xx)));
            float2 _2624 = _2262 * float2(0.4000000059604644775390625f, 0.20000000298023223876953125f);
            float _2632 = 1.0f - smoothstep(0.000600000028498470783233642578125f, 0.0030000000260770320892333984375f, length(_2623 * (float2(2.099999904632568359375f, 1.0499999523162841796875f) + _2624)));
            float _2642 = max(0.0f, exp(length(_2623 * (float2(0.800000011920928955078125f, 0.5f) + _2624)) * (-499.999969482421875f)) - 6.1442124206223525106906890869141e-06f);
            float3 _2644 = (float3(22.75f, 2.76249980926513671875f, 0.324999988079071044921875f) * _2642) * _2642;
            float4 _2650 = float4(float3(10.0f, 2.0f, 1.25f) * _2632, clamp(_2632, 0.0f, 1.0f)) + float4(_2644, clamp(_2642, 0.0f, 1.0f));
            float _2651 = _2258 * 2.5f;
            uint3 _2661 = (asuint(float3(_2213 + 0.21400000154972076416015625f.xx, 0.0f)) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2662 = _2661.y;
            uint _2663 = _2661.z;
            uint _2666 = _2661.x + (_2662 * _2663);
            uint _2668 = _2662 + (_2663 * _2666);
            uint3 _2671 = uint3(_2666, _2668, _2663 + (_2666 * _2668));
            uint3 _2673 = _2671 ^ (_2671 >> uint3(16u, 16u, 16u));
            float _2685 = (clamp(asfloat(((_2673.x + (_2673.y * _2673.z)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f) - 1.7999999523162841796875f) * 1.2999999523162841796875f;
            float _2688 = (1.0f - smoothstep(_2651, _2651 + 0.5f, _718)) * smoothstep(_2685, _2685 + 0.5f, _718);
            float _2706 = _2021 * (1.0f - (smoothstep(0.0f, 1.0f, _730) * float(_2030)));
            float4 _2707 = (float4(_2650.xyz * _2688, _2650.w * _2688) * (1.0f - smoothstep(_1063 - 1.5f, _1063, _2210.y))) * _2706;
            float _2709 = _2707.w;
            float3 _2721 = float3(_2021, _2021, 0.0f);
            uint3 _2724 = (asuint(_2721) * uint3(1664525u, 1664525u, 1664525u)) + uint3(1013904223u, 1013904223u, 1013904223u);
            uint _2725 = _2724.y;
            uint _2726 = _2724.z;
            uint _2729 = _2724.x + (_2725 * _2726);
            uint _2731 = _2725 + (_2726 * _2729);
            uint3 _2734 = uint3(_2729, _2731, _2726 + (_2729 * _2731));
            uint3 _2736 = _2734 ^ (_2734 >> uint3(16u, 16u, 16u));
            uint _2737 = _2736.y;
            uint _2738 = _2736.z;
            uint _2741 = _2736.x + (_2737 * _2738);
            uint _2743 = _2737 + (_2738 * _2741);
            _2021 *= 0.809999942779541015625f;
            _2024 += (float3(_193, clamp(asfloat((_2743 >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f), clamp(asfloat(((_2738 + (_2741 * _2743)) >> 9u) | 1065353216u) - 1.0f, 0.0f, 1.0f)).yz * 10.0f);
            _2026 *= 1.10249984264373779296875f;
            _2028 = float4((_2028.xyz * (1.0f - clamp(_2709, 0.0f, 1.0f))) + _2707.xyz, clamp(_2028.w + _2709, 0.0f, 1.0f));
            _2030++;
            continue;
        }
        float4 _2759 = _2028 * cpost_processing_desc_cb_engine_loading_amount;
        float _2761 = _2759.w;
        float4 _2773 = float4((float4((float4((float4(_931.xyz, _934).xyz * (1.0f - clamp(_1806, 0.0f, 1.0f))) + _1804.xyz, _1813).xyz * (1.0f - clamp(_2006.w, 0.0f, 1.0f))) + _2006.xyz, _2015).xyz * (1.0f - clamp(_2761, 0.0f, 1.0f))) + _2759.xyz, clamp(_2015 + _2761, 0.0f, 1.0f)) * cpost_processing_desc_cb_engine_loading_amount;
        _2785 = float4((_515.xyz * (1.0f - clamp(_2773.w, 0.0f, 1.0f))) + _2773.xyz, _193);
        break;
    } while(false);

    // RenoDX: Disable vanilla in game brightness slider (hdr_scale)
    float4 _2788 = _2785 * 2.5f * (RENODX_DIFFUSE_WHITE_NITS / 203.f);
    _2788.w = _227.w;
    out_var_SV_TARGET = _2788;
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
