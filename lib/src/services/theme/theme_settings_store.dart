import 'package:flutter/material.dart';

import 'package:musicplayer/src/data/theme/app_theme.dart';

class ThemeSettings {
  final ThemeMode mode;
  final AppThemeColor color;

  const ThemeSettings({
    required this.mode,
    required this.color,
  });

  static const defaults = ThemeSettings(
    mode: ThemeMode.system,
    color: AppThemeColor.red,
  );
}

abstract interface class ThemeSettingsStore {
  Future<ThemeSettings> load();
  Future<void> saveMode(ThemeMode mode);
  Future<void> saveColor(AppThemeColor color);
}