#version 450

// RDX DEBUG: 0 = off, 1 = magenta (confirm this shader is the visible specular IBL)
#define RDX_DEBUG 0

layout(set = 0, binding = 7) uniform sampler _12;
layout(set = 1, binding = 2) uniform texture2D _13;
layout(set = 1, binding = 3) uniform texture2D _14;
layout(set = 1, binding = 4) uniform texture2D _15;

layout(location = 0) in vec2 _3;
layout(location = 1) in vec3 _4;
layout(location = 2) in vec3 _5;
layout(location = 3) in vec3 _6;
layout(location = 4) in vec3 _7;
layout(location = 5) in vec3 _8;
layout(location = 6) in vec3 _9;
layout(location = 7) in vec3 _10;
layout(location = 0) out vec4 _11;

void main()
{
    vec3 _55 = normalize(normalize(-_7) * mat3(_6, _4, _5));
    vec4 _71 = texture(sampler2D(_14, _12), _3 + (vec2(_55.x, -_55.z) * fma(texture(sampler2D(_13, _12), _3).w, -0.04500000178813934326171875, -0.04500000178813934326171875)));
    vec3 _74 = (_71.wzy * 2.0) - vec3(1.0);
    vec4 _75 = vec4(_74.x, _74.y, _74.z, _71.x);
    _75.z = -_74.z;
    vec3 _81 = normalize(_75.xyz).xyz;
    vec3 _88 = normalize(mat3(_10, _8, _9) * ((-_55) + ((_81 * dot(_55, _81)) * 2.0)));
    // RDX: Dual-lobe cornea IBL (rendering.hlsl §2.1e principle)
    // Lobe 1: sharp primary cornea reflection (default mip)
    // Lobe 2: broad tear film / subsurface scattering (mip 3)
    vec2 _rdxEquirectUV = vec2(fma(atan(_88.z, _88.x), 0.1591549217700958251953125, 0.5), 1.0 - fma(asin(clamp(_88.y, -1.0, 1.0)), 0.318309962749481201171875, 0.5));
    vec3 _rdxLobe1 = texture(sampler2D(_15, _12), _rdxEquirectUV).xyz;
    vec3 _rdxLobe2 = textureLod(sampler2D(_15, _12), _rdxEquirectUV, 3.0).xyz;
#if RDX_DEBUG == 1
    _11 = vec4(1.0, 0.0, 1.0, 1.0);  // magenta = this shader is the source
#else
    _11 = vec4(mix(_rdxLobe1, _rdxLobe2, 0.30) * vec3(0.3333333432674407958984375), 1.0);
#endif
}

