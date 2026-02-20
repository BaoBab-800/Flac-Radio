import 'package:flutter/material.dart';

import 'package:musicplayer/src/data/theme/app_theme.dart';
import 'package:musicplayer/src/services/theme/theme_settings_store.dart';

class ThemeService extends ChangeNotifier {
  final ThemeSettingsStore _store;

  ThemeMode _themeMode = ThemeSettings.defaults.mode;
  AppThemeColor _themeColor = ThemeSettings.defaults.color;

  ThemeMode get themeMode => _themeMode;
  AppThemeColor get themeColor => _themeColor;

  ThemeService(this._store) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final settings = await _store.load();
    _themeMode = settings.mode;
    _themeColor = settings.color;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();
    await _store.saveMode(mode);
  }

  Future<void> setThemeColor(AppThemeColor color) async {
    if (_themeColor == color) return;

    _themeColor = color;
    notifyListeners();
    await _store.saveColor(color);
  }
}