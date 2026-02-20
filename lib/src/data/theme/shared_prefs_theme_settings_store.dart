import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:musicplayer/src/data/theme/app_theme.dart';
import 'package:musicplayer/src/services/theme/theme_settings_store.dart';

class SharedPrefsThemeSettingsStore implements ThemeSettingsStore {
  static const _keyThemeMode = 'theme_mode';
  static const _keyThemeColor = 'theme_color';

  @override
  Future<ThemeSettings> load() async {
    final prefs = await SharedPreferences.getInstance();

    final modeIndex = prefs.getInt(_keyThemeMode);
    final colorIndex = prefs.getInt(_keyThemeColor);

    final mode = _modeByIndex(modeIndex) ?? ThemeSettings.defaults.mode;
    final color = _colorByIndex(colorIndex) ?? ThemeSettings.defaults.color;

    return ThemeSettings(mode: mode, color: color);
  }

  @override
  Future<void> saveMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeMode, mode.index);
  }

  @override
  Future<void> saveColor(AppThemeColor color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeColor, color.index);
  }

  ThemeMode? _modeByIndex(int? index) {
    if (index == null) return null;
    if (index < 0 || index >= ThemeMode.values.length) return null;
    return ThemeMode.values[index];
  }

  AppThemeColor? _colorByIndex(int? index) {
    if (index == null) return null;
    if (index < 0 || index >= AppThemeColor.values.length) return null;
    return AppThemeColor.values[index];
  }
}