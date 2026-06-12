/*
 * Copyright (C) 2024 Carlos Lopez
 * SPDX-License-Identifier: MIT
 */

#define ImTextureID ImU64

#define DEBUG_LEVEL_0
// #define DEBUG_LEVEL_1
// #define DEBUG_LEVEL_2

#include <embed/shaders.h>

#include <deps/imgui/imgui.h>
#include <include/reshade.hpp>

#include "../../mods/shader.hpp"
#include "../../utils/random.hpp"
#include "../../utils/resource_upgrade.hpp"
#include "../../utils/settings.hpp"
#include "./shared.h"

namespace {

renodx::mods::shader::CustomShaders custom_shaders = {__ALL_CUSTOM_SHADERS};

ShaderInjectData shader_injection;

float current_settings_mode = 0;

// Hotkey state tracking
bool ui_toggle_key_was_pressed = false;
int ui_toggle_hotkey = 0;
bool hotkey_input_active = false;

std::string GetKeyName(int keycode) {
  if (keycode == 0 || keycode >= 256) return "";

  static const char* keyboard_keys[256] = {
      "", "Left Mouse", "Right Mouse", "Cancel", "Middle Mouse", "X1 Mouse", "X2 Mouse", "", "Backspace", "Tab", "", "", "Clear", "Enter", "", "",
      "Shift", "Control", "Alt", "Pause", "Caps Lock", "", "", "", "", "", "", "Escape", "", "", "", "",
      "Space", "Page Up", "Page Down", "End", "Home", "Left Arrow", "Up Arrow", "Right Arrow", "Down Arrow", "Select", "", "", "Print Screen", "Insert", "Delete", "Help",
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "", "", "", "", "", "",
      "", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
      "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "Left Windows", "Right Windows", "Apps", "", "Sleep",
      "Numpad 0", "Numpad 1", "Numpad 2", "Numpad 3", "Numpad 4", "Numpad 5", "Numpad 6", "Numpad 7", "Numpad 8", "Numpad 9", "Numpad *", "Numpad +", "", "Numpad -", "Numpad Decimal", "Numpad /",
      "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "F13", "F14", "F15", "F16",
      "F17", "F18", "F19", "F20", "F21", "F22", "F23", "F24", "", "", "", "", "", "", "", "",
      "Num Lock", "Scroll Lock", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "Left Shift", "Right Shift", "Left Control", "Right Control", "Left Menu", "Right Menu", "Browser Back", "Browser Forward", "Browser Refresh", "Browser Stop", "Browser Search", "Browser Favorites", "Browser Home", "Volume Mute", "Volume Down", "Volume Up",
      "Next Track", "Previous Track", "Media Stop", "Media Play/Pause", "Mail", "Media Select", "Launch App 1", "Launch App 2", "", "", "OEM ;", "OEM +", "OEM ,", "OEM -", "OEM .", "OEM /",
      "OEM ~", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "", "", "", "", "", "OEM [", "OEM \\", "OEM ]", "OEM '", "OEM 8",
      "", "", "OEM <", "", "", "", "", "", "", "", "", "", "", "", "", "",
      "", "", "", "", "", "", "Attn", "CrSel", "ExSel", "Erase EOF", "Play", "Zoom", "", "PA1", "OEM Clear", ""};

  return keyboard_keys[keycode];
}

int GetLastKeyPressedImGui() {
  struct KeyMapping {
    ImGuiKey imgui_key;
    int vk_code;

    constexpr KeyMapping(ImGuiKey key, int code) : imgui_key(key), vk_code(code) {}
  };

  static constexpr auto KEY_MAPPINGS = std::to_array<KeyMapping>({
      // Function keys
      {ImGuiKey_F1, VK_F1}, {ImGuiKey_F2, VK_F2}, {ImGuiKey_F3, VK_F3}, {ImGuiKey_F4, VK_F4},
      {ImGuiKey_F5, VK_F5}, {ImGuiKey_F6, VK_F6}, {ImGuiKey_F7, VK_F7}, {ImGuiKey_F8, VK_F8},
      {ImGuiKey_F9, VK_F9}, {ImGuiKey_F10, VK_F10}, {ImGuiKey_F11, VK_F11}, {ImGuiKey_F12, VK_F12},
      // Navigation keys
      {ImGuiKey_Insert, VK_INSERT}, {ImGuiKey_Delete, VK_DELETE}, {ImGuiKey_Home, VK_HOME}, {ImGuiKey_End, VK_END},
      {ImGuiKey_PageUp, VK_PRIOR}, {ImGuiKey_PageDown, VK_NEXT},
      // Arrow keys
      {ImGuiKey_LeftArrow, VK_LEFT}, {ImGuiKey_RightArrow, VK_RIGHT}, {ImGuiKey_UpArrow, VK_UP}, {ImGuiKey_DownArrow, VK_DOWN},
      // Special keys
      {ImGuiKey_Backspace, VK_BACK}, {ImGuiKey_Space, VK_SPACE}, {ImGuiKey_Enter, VK_RETURN},
      {ImGuiKey_Escape, VK_ESCAPE}, {ImGuiKey_Tab, VK_TAB},
      {ImGuiKey_Pause, VK_PAUSE}, {ImGuiKey_ScrollLock, VK_SCROLL}, {ImGuiKey_PrintScreen, VK_SNAPSHOT},
      // Numpad
      {ImGuiKey_Keypad0, VK_NUMPAD0}, {ImGuiKey_Keypad1, VK_NUMPAD1}, {ImGuiKey_Keypad2, VK_NUMPAD2},
      {ImGuiKey_Keypad3, VK_NUMPAD3}, {ImGuiKey_Keypad4, VK_NUMPAD4}, {ImGuiKey_Keypad5, VK_NUMPAD5},
      {ImGuiKey_Keypad6, VK_NUMPAD6}, {ImGuiKey_Keypad7, VK_NUMPAD7}, {ImGuiKey_Keypad8, VK_NUMPAD8},
      {ImGuiKey_Keypad9, VK_NUMPAD9}, {ImGuiKey_KeypadDecimal, VK_DECIMAL},
      {ImGuiKey_KeypadDivide, VK_DIVIDE}, {ImGuiKey_KeypadMultiply, VK_MULTIPLY},
      {ImGuiKey_KeypadSubtract, VK_SUBTRACT}, {ImGuiKey_KeypadAdd, VK_ADD}, {ImGuiKey_KeypadEnter, VK_RETURN},
      // Letters
      {ImGuiKey_A, 'A'}, {ImGuiKey_B, 'B'}, {ImGuiKey_C, 'C'}, {ImGuiKey_D, 'D'}, {ImGuiKey_E, 'E'},
      {ImGuiKey_F, 'F'}, {ImGuiKey_G, 'G'}, {ImGuiKey_H, 'H'}, {ImGuiKey_I, 'I'}, {ImGuiKey_J, 'J'},
      {ImGuiKey_K, 'K'}, {ImGuiKey_L, 'L'}, {ImGuiKey_M, 'M'}, {ImGuiKey_N, 'N'}, {ImGuiKey_O, 'O'},
      {ImGuiKey_P, 'P'}, {ImGuiKey_Q, 'Q'}, {ImGuiKey_R, 'R'}, {ImGuiKey_S, 'S'}, {ImGuiKey_T, 'T'},
      {ImGuiKey_U, 'U'}, {ImGuiKey_V, 'V'}, {ImGuiKey_W, 'W'}, {ImGuiKey_X, 'X'}, {ImGuiKey_Y, 'Y'}, {ImGuiKey_Z, 'Z'},
      // Numbers
      {ImGuiKey_0, '0'}, {ImGuiKey_1, '1'}, {ImGuiKey_2, '2'}, {ImGuiKey_3, '3'}, {ImGuiKey_4, '4'},
      {ImGuiKey_5, '5'}, {ImGuiKey_6, '6'}, {ImGuiKey_7, '7'}, {ImGuiKey_8, '8'}, {ImGuiKey_9, '9'},
      // Punctuation
      {ImGuiKey_GraveAccent, VK_OEM_3}, {ImGuiKey_Minus, VK_OEM_MINUS}, {ImGuiKey_Equal, VK_OEM_PLUS},
      {ImGuiKey_LeftBracket, VK_OEM_4}, {ImGuiKey_RightBracket, VK_OEM_6}, {ImGuiKey_Backslash, VK_OEM_5},
      {ImGuiKey_Semicolon, VK_OEM_1}, {ImGuiKey_Apostrophe, VK_OEM_7},
      {ImGuiKey_Comma, VK_OEM_COMMA}, {ImGuiKey_Period, VK_OEM_PERIOD}, {ImGuiKey_Slash, VK_OEM_2},
  });

  for (const auto& mapping : KEY_MAPPINGS) {
    if (ImGui::IsKeyPressed(mapping.imgui_key, false)) {
      return mapping.vk_code;
    }
  }
  return 0;
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
        .is_visible = []() { return false; },
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
        .labels = {"Vanilla", "Psycho V17"},
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
        .labels = {"Off", "2.2 Per Channel"},
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "SwapChainGammaCorrection",
        .binding = &shader_injection.swap_chain_gamma_correction,
        .value_type = renodx::utils::settings::SettingValueType::INTEGER,
        .default_value = 1.f,
        .label = "UI Gamma Correction",
        .section = "Tone Mapping",
        .labels = {"Off", "2.2 Per Channel"},
        .is_visible = []() { return current_settings_mode >= 1; },
    },
    new renodx::utils::settings::Setting{
        .key = "ToneMapHueShift",
        .binding = &shader_injection.tone_map_hue_shift,
        .default_value = 0.f,
        .label = "Hue Shift",
        .section = "Tone Mapping",
        .tooltip = "Hue shift emulation strength.",
        .min = 0.f,
        .max = 200.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "HueCorrection",
        .binding = &shader_injection.hue_correction,
        .default_value = 25.f,
        .label = "Hue Correction",
        .section = "Tone Mapping",
        .tooltip = "Post tonemap hue correction toward per channel reference. Fixes pink fire/lava.",
        .min = 0.f,
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
    },
    new renodx::utils::settings::Setting{
        .key = "ColorGradeBlowout",
        .binding = &shader_injection.tone_map_dechroma,
        .default_value = 0.f,
        .label = "Max Channel Blowout",
        .section = "Tone Mapping",
        .tooltip = "Controls highlight desaturation.",
        .max = 100.f,
        .is_enabled = []() { return shader_injection.tone_map_type >= 1; },
        .parse = [](float value) { return value * 0.01f; },
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
        .parse = [](float value) { return (value + 2.f) * 0.02f; },
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
        //.is_visible = []() { return false; },
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
        .default_value = 50.f,
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
        .default_value = 25.f,
        .can_reset = true,
        .label = "Bloom Scaling",
        .section = "Effects",
        .tooltip = "Controls bloom black floor preservation. Higher values suppress bloom more in dark areas.",
        .min = 0.f,
        .max = 100.f,
        .parse = [](float value) { return value * 0.01f; },
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
        .key = "UIToggleHotkey",
        .value_type = renodx::utils::settings::SettingValueType::CUSTOM,
        .default_value = 0.f,
        .label = "Hide UI Hotkey",
        .section = "Effects",
        .tooltip = "Click in the field and press any key to set the hotkey, or press Backspace/Delete to clear",
        .on_draw = []() {
          static bool key_was_pressed = false;
          bool changed = false;

          // Get current key name for display
          std::string key_name = ui_toggle_hotkey != 0 ? GetKeyName(ui_toggle_hotkey) : "";
          char buf[64] = {0};
          if (!key_name.empty()) {
            size_t copy_len = (key_name.size() < sizeof(buf) - 1) ? key_name.size() : sizeof(buf) - 1;
            memcpy(buf, key_name.c_str(), copy_len);
          }

          // Create the input text widget
          ImGui::InputTextWithHint(
              "Hide UI Hotkey",
              "Click to set keyboard shortcut",
              buf,
              sizeof(buf),
              ImGuiInputTextFlags_ReadOnly | ImGuiInputTextFlags_NoUndoRedo | ImGuiInputTextFlags_NoHorizontalScroll);

          // Check if widget is active and capture key presses
          if (ImGui::IsItemActive()) {
            hotkey_input_active = true;
            int key_pressed = GetLastKeyPressedImGui();

            if (key_pressed != 0 && !key_was_pressed) {
              if (key_pressed == VK_BACK || key_pressed == VK_DELETE) {
                ui_toggle_hotkey = 0;
                changed = true;
              } else if (key_pressed != VK_ESCAPE) {
                ui_toggle_hotkey = key_pressed;
                changed = true;
              }

              if (changed) {
                reshade::set_config_value(nullptr, renodx::utils::settings::global_name.c_str(), "UIToggleHotkey", ui_toggle_hotkey);
              }

              key_was_pressed = true;
            } else if (key_pressed == 0) {
              key_was_pressed = false;
            }
          } else {
            hotkey_input_active = false;
            key_was_pressed = false;
          }

          if (ImGui::IsItemHovered(ImGuiHoveredFlags_ForTooltip)) {
            ImGui::SetTooltip("Click and press any key to set hotkey.\nPress Backspace or Delete to clear.");
          }

          return changed;
        },
        .is_global = true,
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Reset All",
        .section = "Options",
        .group = "button-line-1",
        .on_change = []() { renodx::utils::settings::ResetSettings(); },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "Discord",
        .section = "Links",
        .group = "button-line-2",
        .tint = 0x5865F2,
        .on_change = []() {
          renodx::utils::platform::LaunchURL("https://discord.gg/", "5WZXDpmbpP");
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::BUTTON,
        .label = "More Mods",
        .section = "Links",
        .group = "button-line-2",
        .tint = 0x2B3137,
        .on_change = []() {
          renodx::utils::platform::LaunchURL("https://github.com/", "clshortfuse/renodx/wiki/Mods");
        },
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "- Addon maintained by Forge + Nilly (0.5).",
        .section = "About",
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = "- Made for Path of Exile 2 (Vulkan)",
        .section = "About",
    },
    new renodx::utils::settings::Setting{
        .value_type = renodx::utils::settings::SettingValueType::TEXT,
        .label = std::string("- Many thanks to ShortFuse for RenoDX & Ritsu for RenoVK"),
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
  renodx::utils::settings::UpdateSetting("GammaCorrection", 0.f);
  renodx::utils::settings::UpdateSetting("SwapChainGammaCorrection", 0.f);
  renodx::utils::settings::UpdateSetting(  "HideUI", 0.f);
}

void OnInitDevice(reshade::api::device* device) {
  const auto target_format = reshade::api::format::r16g16b16a16_float;
  const auto view_upgrades = renodx::utils::resource::VIEW_UPGRADES_RGBA16F;

  std::vector<renodx::utils::resource::ResourceUpgradeInfo> upgrade_infos = {
      {
          .old_format = reshade::api::format::r8g8b8a8_typeless,
          .new_format = target_format,
          .ignore_size = true,
          .view_upgrades = view_upgrades,
          .usage_include = reshade::api::resource_usage::render_target,
      },
      {
          .old_format = reshade::api::format::r8g8b8a8_unorm_srgb,
          .new_format = target_format,
          .ignore_size = true,
          .view_upgrades = view_upgrades,
          .usage_include = reshade::api::resource_usage::render_target,
      },
  };

  renodx::utils::resource::upgrade::SetUpgradeInfos(device, upgrade_infos);
}

void OnPresent(reshade::api::command_queue* /*unused*/,
               reshade::api::swapchain* /*unused*/,
               const reshade::api::rect* /*unused*/,
               const reshade::api::rect* /*unused*/,
               uint32_t /*unused*/,
               const reshade::api::rect* /*unused*/) {
  // Check UI toggle hotkey (skip if user is currently setting a new hotkey)
  if (ui_toggle_hotkey != 0 && !hotkey_input_active) {
    bool key_down = (GetAsyncKeyState(ui_toggle_hotkey) & 0x8000) != 0;

    if (key_down && !ui_toggle_key_was_pressed) {
      // Toggle Hide UI
      shader_injection.hide_ui = (shader_injection.hide_ui == 0.f) ? 1.f : 0.f;

      // Update the setting value to keep UI in sync
      renodx::utils::settings::UpdateSetting("HideUI", shader_injection.hide_ui);
    }

    ui_toggle_key_was_pressed = key_down;
  }
}

}  // namespace

extern "C" __declspec(dllexport) constexpr const char* NAME = "RenoDX";
extern "C" __declspec(dllexport) constexpr const char* DESCRIPTION = "RenoDX for Path of Exile 2 - (Vulkan)";

BOOL APIENTRY DllMain(HMODULE h_module, DWORD fdw_reason, LPVOID lpv_reserved) {
  switch (fdw_reason) {
    case DLL_PROCESS_ATTACH:
      if (!reshade::register_addon(h_module)) return FALSE;

      renodx::mods::shader::allow_multiple_push_constants = true;
      renodx::mods::shader::minimum_constant_buffer_stages = reshade::api::shader_stage::pixel;

      renodx::utils::resource::upgrade::Use(fdw_reason);
      reshade::register_event<reshade::addon_event::init_device>(OnInitDevice);
      reshade::register_event<reshade::addon_event::present>(OnPresent);

      // Load UI toggle hotkey from saved config
      {
        int saved_hotkey = 0;
        if (reshade::get_config_value(nullptr, renodx::utils::settings::global_name.c_str(), "UIToggleHotkey", saved_hotkey)) {
          ui_toggle_hotkey = saved_hotkey;
        }
      }

      break;
    case DLL_PROCESS_DETACH:
      renodx::utils::resource::upgrade::Use(fdw_reason);
      reshade::unregister_event<reshade::addon_event::init_device>(OnInitDevice);
      reshade::unregister_event<reshade::addon_event::present>(OnPresent);
      reshade::unregister_addon(h_module);
      break;
  }

  renodx::utils::settings::Use(fdw_reason, &settings, &OnPresetOff);
  renodx::mods::shader::Use(fdw_reason, custom_shaders, &shader_injection);
  renodx::utils::random::binds.push_back(&shader_injection.custom_random);
  renodx::utils::random::Use(fdw_reason);

  return TRUE;
}
