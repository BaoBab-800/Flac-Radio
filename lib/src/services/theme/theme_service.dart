import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:musicplayer/src/data/theme/app_theme.dart';

// Сервис смены темы с сохранением настроек
class ThemeService extends ChangeNotifier {
  // Ключи
  static const _keyThemeMode = 'theme_mode';
  static const _keyThemeColor = 'theme_color';

  // Переменные текущего состояния
  ThemeMode _themeMode = ThemeMode.system;
  AppThemeColor _themeColor = AppThemeColor.red;

  // Публичные геттеры
  ThemeMode get themeMode => _themeMode;
  AppThemeColor get themeColor => _themeColor;

  // Загрузка настроек при запуске приложения
  ThemeService() {
    _loadTheme();
  }

  // Загрузка темы из локальной памяти
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[prefs.getInt(_keyThemeMode) ?? 0];  // Загружает и тему
    _themeColor = AppThemeColor.values[prefs.getInt(_keyThemeColor) ?? 0];  // И цвет темы
    notifyListeners();
  }

  // Установка мода темы в память
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_keyThemeMode, mode.index);
  }

  // Установка цвета темы в память
  Future<void> setThemeColor(AppThemeColor color) async {
    _themeColor = color;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_keyThemeColor, color.index);
  }
}