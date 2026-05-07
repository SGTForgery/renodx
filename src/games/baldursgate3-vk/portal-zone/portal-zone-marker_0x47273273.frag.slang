[[vk::binding(0, 1)]]
cbuffer _4_3 : register(b0, space1) {
  column_major float4x4 _3_m0 : packoffset(c0);
  float _3_m1 : packoffset(c4);
  float _3_m2 : packoffset(c4.y);
  float2 _3_m3 : packoffset(c4.z);
};

struct SPIRV_Cross_Output {
  [[vk::location(0)]] float4 _2 : SV_Target0;
};

[shader("fragment")]
SPIRV_Cross_Output main() {
  discard;
  SPIRV_Cross_Output stage_output = (SPIRV_Cross_Output)0;
  return stage_output;
}
