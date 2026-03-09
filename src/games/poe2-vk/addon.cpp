/*
 * Copyright (C) 2024 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */

#include <include/reshade_api_device.hpp>
#define ImTextureID ImU64

#define DEBUG_LEVEL_0
// #define DEBUG_LEVEL_1
// #define DEBUG_LEVEL_2

#include <filesystem>
#include <fstream>

#include <embed/shaders.h>

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "../../mods/shader.hpp"
#include "../../mods/swapchain.hpp"
#include "../../utils/data.hpp"
#include "../../utils/random.hpp"
#include "../../utils/resource.hpp"
#include "../../utils/settings.hpp"
#include "../../utils/swapchain.hpp"
#include "./shared.h"

namespace {

renodx::mods::shader::CustomShaders custom_shaders = {__ALL_CUSTOM_SHADERS};

ShaderInjectData shader_injection;

// --- IS-FAST noise texture globals ---
HMODULE g_hmodule = nullptr;
reshade::api::resource g_isfast_texture = {0};
reshade::api::resource_view g_isfast_srv = {0};
reshade::api::sampler g_isfast_sampler = {0};

float current_settings_mode = 0;

bool UsingSwapchainUpgrade() {
  return true;
}

bool UsingSwapchainUtil() {
  return UsingSwapchainUpgrade();
}

renodx::utils::settings::Settings settings = {
    new renodx::utils::settings::Setting{
        .key = "SettingsMode",
        .binding = &current_settings_mode,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 2.f,
        .can_reset = false,
        .label = "Settings Mode",
        .labels = {"Simple", "Intermediate", "Advanced"},
        .is_global = true,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapType",
        .binding = &shader_injection.tone_map_type,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .can_reset = false,
        .label = "Tone Mapper",
        .section = "Tone Mapping",
        .tooltip = "Sets the tone mapper type",
        .labels = {"Vanilla", "RenoDRT"},
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapPeakNits",
        .binding = &shader_injection.peak_white_nits,
        .default_value = 1000.f,
        .can_reset = true,
        .label = "Peak Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of peak white in nits",
        .min = 48.f,
        .max = 4000.f,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapGameNits",
        .binding = &shader_injection.diffuse_white_nits,
        .default_value = 203.f,
        .label = "Game Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the value of 100% white in nits",
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapUINits",
        .binding = &shader_injection.graphics_white_nits,
        .default_value = 203.f,
        .label = "UI Brightness",
        .section = "Tone Mapping",
        .tooltip = "Sets the brightness of UI and HUD elements in nits",
        .min = 48.f,
        .max = 500.f,
    },
    new renodx::utils::settings::Setting{
        .key = "GammaCorrection",
        .binding = &shader_injection.gamma_correction,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "Scene Gamma Correction",
        .section = "Tone Mapping",
        .labels = {"Off", "Gamma 2.2 By Luminance with Per Channel Chromiance"},
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainGammaCorrection",
        .binding = &shader_injection.swap_chain_gamma_correction,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "UI Gamma Correction",
        .section = "Tone Mapping",
        .labels = {"Off", "Gamma 2.2 By Luminance with Per Channel Chromiance"},
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueCorrection",
        .binding = &shader_injection.tone_map_hue_correction,
        .default_value = 100.f,
        .label = "Hue Correction",
        .section = "Tone Mapping",
        .tooltip = "Hue retention strength.",
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueShift",
        .binding = &shader_injection.tone_map_hue_shift,
        .default_value = 100.f,
        .label = "Hue Shift",
        .section = "Tone Mapping",
        .tooltip = "Hue-shift emulation strength.",
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
        //.is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapPerChannelBlowout",
        .binding = &shader_injection.tone_map_blowout,
        .default_value = 100.f,
        .label = "Purity Blowout",
        .section = "Tone Mapping",
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
        //.is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeExposure",
        .binding = &shader_injection.tone_map_exposure,
        .default_value = 1.f,
        .label = "Exposure",
        .section = "Color Grading",
        .max = 2.f,
        .format = "%.2f",
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeHighlights",
        .binding = &shader_injection.tone_map_highlights,
        .default_value = 50.f,
        .label = "Highlights",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeShadows",
        .binding = &shader_injection.tone_map_shadows,
        .default_value = 50.f,
        .label = "Shadows",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeContrast",
        .binding = &shader_injection.tone_map_contrast,
        .default_value = 50.f,
        .label = "Contrast",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeSaturation",
        .binding = &shader_injection.tone_map_saturation,
        .default_value = 50.f,
        .label = "Saturation",
        .section = "Color Grading",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeHighlightSaturation",
        .binding = &shader_injection.tone_map_highlight_saturation,
        .default_value = 50.f,
        .label = "Highlight Saturation",
        .section = "Color Grading",
        .tooltip = "Adds or removes highlight color.",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeBlowout",
        .binding = &shader_injection.tone_map_dechroma,
        .default_value = 0.f,
        .label = "Blowout",
        .section = "Color Grading",
        .tooltip = "Controls highlight desaturation due to overexposure.",
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeFlare",
        .binding = &shader_injection.tone_map_flare,
        .default_value = 0.f,
        .label = "Flare",
        .section = "Color Grading",
        .tooltip = "Flare/Glare Compensation",
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
        .is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeScene",
        .binding = &shader_injection.color_grade_strength,
        .default_value = 100.f,
        .label = "LUT Strength",
        .section = "Color Grading",
        .tooltip = "LUT Strength as applied by the game",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type > 0; },
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting({
            .key = "FxGrainStrength",
            .binding = &shader_injection.custom_grain_strength,
            .default_value = 0.f,
            .label = "Perceptual Grain Strength",
            .section = "Effects",
            .parse = [](float value) { return value * 0.01f; },
        }),
    new renodx::utils::settings::Setting{
        .key = "VignetteStrength",
        .binding = &shader_injection.vignette_strength,
        .default_value = 0.f,
        .label = "Vignette Strength",
        .section = "Effects",
        .min = 0.f,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "BloomStrength",
        .binding = &shader_injection.bloom_strength,
        .value_type = renodx::utils::settings::SettingValueType::FLOAT,
        .default_value = 100.f,
        .can_reset = true,
        .label = "Bloom Strength",
        .section = "Effects",
        .tooltip = "Adjusts the intensity of bloom effects.",
        .min = 0.f,
        .max = 100.f,
        .parse = [](float value) { return value * 0.02f; },
    },
    new renodx::utils::settings::Setting{
        .key = "BloomScaling",
        .binding = &shader_injection.bloom_scaling,
        .value_type = renodx::utils::settings::SettingValueType::FLOAT,
        .default_value = 70.f,
        .can_reset = true,
        .label = "Bloom Scaling",
        .section = "Effects",
        .tooltip = "Controls bloom black-floor preservation. Higher values suppress bloom more in dark areas.",
        .min = 0.f,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "AOStrength",
        .binding = &shader_injection.ao_strength,
        .value_type = renodx::utils::settings::SettingValueType::FLOAT,
        .default_value = 100.f,
        .can_reset = true,
        .label = "AO Strength",
        .section = "Effects",
        .tooltip = "Controls ambient occlusion intensity in deferred lighting. Lower values reduce black crush in dark areas.",
        .min = 0.f,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
        .is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .key = "HideUI",
        .binding = &shader_injection.hide_ui,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Hide UI",
        .section = "Effects",
        .tooltip = "Hides all UI elements for clean screenshots.",
        .labels = {"Off", "On"},
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainEncoding",
        .binding = &shader_injection.swap_chain_encoding,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 4.f,
        .label = "Encoding",
        .section = "Display Output",
        .labels = {"None", "SRGB", "2.2", "2.4", "HDR10", "scRGB"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .on_change_value = [](float previous, float current) {
          bool is_hdr10 = current == 4;
          shader_injection.swap_chain_encoding_color_space = (is_hdr10 ? 1.f : 0.f);
        },
        .is_global = true,
        .is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .key = "IntermediateDecoding",
        .binding = &shader_injection.intermediate_encoding,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Intermediate Encoding",
        .section = "Display Output",
        .labels = {"Auto", "None", "SRGB", "2.2", "2.4"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) {
            if (value == 0) return shader_injection.gamma_correction + 1.f;
            return value - 1.f; },
        .is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainDecoding",
        .binding = &shader_injection.swap_chain_decoding,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 0.f,
        .label = "Swapchain Decoding",
        .section = "Display Output",
        .labels = {"Auto", "None", "SRGB", "2.2", "2.4"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) {
            if (value == 0) return shader_injection.intermediate_encoding;
            return value - 1.f; },
        .is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainClampColorSpace",
        .binding = &shader_injection.swap_chain_clamp_color_space,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 2.f,
        .label = "Clamp Color Space",
        .section = "Display Output",
        .labels = {"None", "BT709", "BT2020", "AP1"},
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value - 1.f; },
        .is_visible = []() { return false; },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Discord",
        .section = "Links",
        .group = "button-line-1",
        .tint = 0x5865F2,
        .on_change = []() {
          renodx::utils::platform::LaunchURL("https://discord.gg/", "5WZXDpmbpP");
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "More Mods",
        .section = "Links",
        .group = "button-line-1",
        .tint = 0x2B3137,
        .on_change = []() {
          renodx::utils::platform::LaunchURL("https://github.com/", "clshortfuse/renodx/wiki/Mods");
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "- Addon maintained by Forge.",
        .section = "About",
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "- Made for Path of Exile 2 (Vulkan)",
        .section = "About",
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = std::string("- Many thanks to ShortFuse for RenoDX"),
        .section = "About",
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "- This build was compiled on " + std::string(__DATE__) + " at " + std::string(__TIME__) + ".",
        .section = "About",
    },
};

void OnPresetOff() {
renodx::utils::settings::UpdateSetting("ToneMapType", 0.f);
renodx::utils::settings::UpdateSetting("ColorGradeExposure", 1.f);
renodx::utils::settings::UpdateSetting("ColorGradeHighlights", 50.f);
renodx::utils::settings::UpdateSetting("ColorGradeShadows", 50.f);
renodx::utils::settings::UpdateSetting("ColorGradeContrast", 50.f);
renodx::utils::settings::UpdateSetting("ColorGradeSaturation", 50.f);
renodx::utils::settings::UpdateSetting("ColorGradeScene", 100.f);
renodx::utils::settings::UpdateSetting("FxGrainStrength", 0.f);
renodx::utils::settings::UpdateSetting("VignetteStrength", 100.f);
renodx::utils::settings::UpdateSetting("BloomStrength", 100.f);
renodx::utils::settings::UpdateSetting("BloomScaling", 0.f);
renodx::utils::settings::UpdateSetting("AOStrength", 100.f);
renodx::utils::settings::UpdateSetting("GammaCorrection", 0.f);
renodx::utils::settings::UpdateSetting("SwapChainGammaCorrection", 0.f);

}

// --- IS-FAST texture loading ---
void OnISFASTInitDevice(reshade::api::device* device) {
  // Locate DDS file next to addon DLL
  wchar_t module_path[MAX_PATH];
  GetModuleFileNameW(g_hmodule, module_path, MAX_PATH);
  auto dds_path = std::filesystem::path(module_path).parent_path() / L"fast_noise_ea.dds";

  std::ifstream file(dds_path, std::ios::binary | std::ios::ate);
  if (!file.is_open()) {
    reshade::log::message(reshade::log::level::warning,
        "IS-FAST: fast_noise_ea.dds not found next to addon DLL, noise texture disabled");
    return;
  }

  auto file_size = static_cast<size_t>(file.tellg());
  file.seekg(0);
  std::vector<uint8_t> dds_data(file_size);
  file.read(reinterpret_cast<char*>(dds_data.data()), file_size);
  file.close();

  // Validate DDS magic
  if (file_size < 128 || dds_data[0] != 'D' || dds_data[1] != 'D'
      || dds_data[2] != 'S' || dds_data[3] != ' ') {
    reshade::log::message(reshade::log::level::error, "IS-FAST: Invalid DDS file");
    return;
  }

  // Parse DDS header
  uint32_t height = *reinterpret_cast<uint32_t*>(&dds_data[12]);
  uint32_t width  = *reinterpret_cast<uint32_t*>(&dds_data[16]);
  uint32_t depth  = *reinterpret_cast<uint32_t*>(&dds_data[24]);
  uint32_t four_cc = *reinterpret_cast<uint32_t*>(&dds_data[84]);

  uint32_t header_size = 128;  // 4 magic + 124 DDS_HEADER
  if (four_cc == 0x30315844u) { // "DX10" extended header
    header_size = 148;         // + 20 DDS_HEADER_DX10
  }
  if (depth == 0) depth = 1;

  if (file_size < header_size) {
    reshade::log::message(reshade::log::level::error, "IS-FAST: DDS file too small");
    return;
  }

  const uint8_t* pixel_data = dds_data.data() + header_size;
  uint32_t bpp = 2;  // RG8_UNORM = 2 bytes per texel
  uint32_t row_pitch   = width * bpp;
  uint32_t slice_pitch = row_pitch * height;

  // Create Texture3D
  reshade::api::resource_desc tex_desc = {};
  tex_desc.type = reshade::api::resource_type::texture_3d;
  tex_desc.texture.width  = width;
  tex_desc.texture.height = height;
  tex_desc.texture.depth_or_layers = static_cast<uint16_t>(depth);
  tex_desc.texture.levels = 1;
  tex_desc.texture.format = reshade::api::format::r8g8_unorm;
  tex_desc.texture.samples = 1;
  tex_desc.heap  = reshade::api::memory_heap::gpu_only;
  tex_desc.usage = reshade::api::resource_usage::shader_resource;
  tex_desc.flags = reshade::api::resource_flags::none;

  reshade::api::subresource_data initial_data = {};
  initial_data.data        = const_cast<uint8_t*>(pixel_data);
  initial_data.row_pitch   = row_pitch;
  initial_data.slice_pitch = slice_pitch;

  if (!device->create_resource(tex_desc, &initial_data,
        reshade::api::resource_usage::shader_resource, &g_isfast_texture)) {
    reshade::log::message(reshade::log::level::error, "IS-FAST: Failed to create Texture3D");
    return;
  }

  // Create SRV
  reshade::api::resource_view_desc srv_desc = {};
  srv_desc.type = reshade::api::resource_view_type::texture_3d;
  srv_desc.format = reshade::api::format::r8g8_unorm;
  srv_desc.texture.first_level = 0;
  srv_desc.texture.level_count = 1;
  srv_desc.texture.first_layer = 0;
  srv_desc.texture.layer_count = 1;

  if (!device->create_resource_view(g_isfast_texture,
        reshade::api::resource_usage::shader_resource, srv_desc, &g_isfast_srv)) {
    reshade::log::message(reshade::log::level::error, "IS-FAST: Failed to create SRV");
    device->destroy_resource(g_isfast_texture);
    g_isfast_texture = {0};
    return;
  }

  // Create point-wrap sampler
  reshade::api::sampler_desc samp_desc = {};
  samp_desc.filter    = reshade::api::filter_mode::min_mag_mip_point;
  samp_desc.address_u = reshade::api::texture_address_mode::wrap;
  samp_desc.address_v = reshade::api::texture_address_mode::wrap;
  samp_desc.address_w = reshade::api::texture_address_mode::wrap;

  if (!device->create_sampler(samp_desc, &g_isfast_sampler)) {
    reshade::log::message(reshade::log::level::error, "IS-FAST: Failed to create sampler");
    device->destroy_resource_view(g_isfast_srv);
    device->destroy_resource(g_isfast_texture);
    g_isfast_srv = {0};
    g_isfast_texture = {0};
    return;
  }

  shader_injection.isfast_noise_bound = 1.0f;

  std::stringstream s;
  s << "IS-FAST: Noise texture loaded (" << width << "x" << height << "x" << depth << " RG8)";
  reshade::log::message(reshade::log::level::info, s.str().c_str());
}

void OnISFASTDestroyDevice(reshade::api::device* device) {
  shader_injection.isfast_noise_bound = 0.0f;
  if (g_isfast_sampler.handle != 0) {
    device->destroy_sampler(g_isfast_sampler);
    g_isfast_sampler = {0};
  }
  if (g_isfast_srv.handle != 0) {
    device->destroy_resource_view(g_isfast_srv);
    g_isfast_srv = {0};
  }
  if (g_isfast_texture.handle != 0) {
    device->destroy_resource(g_isfast_texture);
    g_isfast_texture = {0};
  }
}

void OnPresent(reshade::api::command_queue* queue,
                             reshade::api::swapchain* swapchain,
                             const reshade::api::rect* source_rect,
                             const reshade::api::rect* dest_rect,
                             uint32_t dirty_rect_count,
                             const reshade::api::rect* dirty_rects) {
    auto* device = queue->get_device();

}

bool initialized = false;

}  // namespace

extern "C" __declspec(dllexport) constexpr const char* NAME = "RenoDX";
extern "C" __declspec(dllexport) constexpr const char* DESCRIPTION = "RenoDX for Path of Exile 2 - (Vulkan)";

BOOL APIENTRY DllMain(HMODULE h_module, DWORD fdw_reason, LPVOID lpv_reserved) {
  g_hmodule = h_module;
  auto use_resource_view_cloning = false;
  const auto target_format = reshade::api::format::r16g16b16a16_float;
  const auto view_upgrades = renodx::utils::resource::VIEW_UPGRADES_RGBA16F;
  auto common_aspect_ratio = 16.f / 9.f;
  auto common_ignore_size = false;
  auto weird_aspect_ratio = 3840.f / 1986.f;
  const renodx::utils::resource::ResourceUpgradeInfo::Dimensions min_dimensions = {
      .width = 720,
      .height = renodx::utils::resource::ResourceUpgradeInfo::ANY,
      .depth = renodx::utils::resource::ResourceUpgradeInfo::ANY,
  };

  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH:
      if (!reshade::register_addon(h_module)) return FALSE;
      renodx::mods::shader::allow_multiple_push_constants = true;
      renodx::mods::swapchain::use_resource_cloning = false;
      renodx::mods::swapchain::target_format = target_format;
      renodx::mods::shader::expand_existing_constant_buffer = true;
      renodx::mods::shader::minimum_constant_buffer_stages = reshade::api::shader_stage::pixel;
      renodx::mods::swapchain::ignored_device_apis = {
          reshade::api::device_api::d3d11,
      };
      // disable swapchain proxy
      renodx::mods::swapchain::swap_chain_proxy_vertex_shader = __swap_chain_proxy_vertex_shader;
      renodx::mods::swapchain::swap_chain_proxy_pixel_shader = __swap_chain_proxy_pixel_shader;

      renodx::mods::swapchain::swap_chain_upgrade_targets.push_back({
          .old_format = reshade::api::format::r8g8b8a8_unorm_srgb,
          .new_format = target_format,
          .ignore_size = true,
          .use_resource_view_cloning = use_resource_view_cloning,
          .view_upgrades = view_upgrades,
          .usage_include = reshade::api::resource_usage::render_target,
      });

            if (!initialized) {

                renodx::mods::swapchain::force_borderless = false;
                renodx::mods::swapchain::prevent_full_screen = false;

                // Initialize SwapChainEncoding-related settings
                {
                    float encoding_value = 4.f;  // default
                    reshade::get_config_value(nullptr, renodx::utils::settings::global_name.c_str(), "SwapChainEncoding", encoding_value);
                    bool is_hdr10 = encoding_value == 4;
                    renodx::mods::swapchain::SetUseHDR10(is_hdr10);
                    renodx::mods::swapchain::use_resize_buffer = encoding_value < 4;
                    shader_injection.swap_chain_encoding_color_space = is_hdr10 ? 1.f : 0.f;
                }

                renodx::mods::swapchain::use_device_proxy = false;
                renodx::mods::swapchain::set_color_space = true;
                reshade::register_event<reshade::addon_event::present>(OnPresent);
                reshade::register_event<reshade::addon_event::init_device>(OnISFASTInitDevice);
                reshade::register_event<reshade::addon_event::destroy_device>(OnISFASTDestroyDevice);
                renodx::mods::swapchain::device_proxy_wait_idle_source = false;
                renodx::mods::swapchain::device_proxy_wait_idle_destination = false;

                initialized = true;
            }

      break;
        case DLL_PROCESS_DETACH:
            reshade::unregister_event<reshade::addon_event::present>(OnPresent);
            reshade::unregister_event<reshade::addon_event::init_device>(OnISFASTInitDevice);
            reshade::unregister_event<reshade::addon_event::destroy_device>(OnISFASTDestroyDevice);
            reshade::unregister_addon(h_module);
            break;
  }

    renodx::utils::settings::Use(fdw_reason, &settings, &OnPresetOff);
    renodx::mods::swapchain::Use(fdw_reason, &shader_injection);
    renodx::mods::shader::Use(fdw_reason, custom_shaders, &shader_injection);
    renodx::utils::random::binds.push_back(&shader_injection.custom_random);
    renodx::utils::random::Use(fdw_reason);

  return TRUE;
}
