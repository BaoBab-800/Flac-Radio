import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

// Контракт хранилища темы.
// ThemeService не знает, где и как хранится тема.
abstract class ThemeStorage {
  Future<AppThemeType?> loadTheme();
  Future<void> saveTheme(AppThemeType type);
}

// Реализация хранилища через SharedPreferences
class SharedPrefsThemeStorage implements ThemeStorage {
  static const _key = 'app_theme_type';

  @override
  Future<AppThemeType?> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key);

    if (index == null) return null;
    return AppThemeType.values[index];
  }

  @override
  Future<void> saveTheme(AppThemeType type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, type.index);
  }
}

// Controller состояния темы приложения.
// Хранит только тип темы и уведомляет UI об изменениях.
class ThemeService extends ChangeNotifier {
  final ThemeStorage _storage;

  AppThemeType _themeType = AppThemeType.light;

  ThemeService(this._storage);

  // Текущий тип темы
  AppThemeType get themeType => _themeType;

  // Инициализация сервиса (загрузка сохранённой темы)
  Future<void> init() async {
    final savedTheme = await _storage.loadTheme();

    if (savedTheme != null) {
      _themeType = savedTheme;
    }

    notifyListeners();
  }

  // Установка новой темы
  Future<void> setTheme(AppThemeType type) async {
    if (_themeType == type) return;

    _themeType = type;
    await _storage.saveTheme(type);
    notifyListeners();
  }
}