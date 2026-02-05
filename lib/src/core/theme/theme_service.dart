import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

const _defaultThemeKey = 'theme';
const _defaultThemeType = 'dark';

// сервис для управления темой приложения
// уведомляет UI через ChangeNotifier при изменении темы
class ThemeService extends ChangeNotifier {
  // текущая тема приложения, сразу инициализирована дефолтной
  AppTheme _currentTheme = _getThemeByTypeStatic(_defaultThemeType);

  ThemeService() {
    _loadTheme(); // асинхронная загрузка сохранённой темы
  }

  AppTheme get currentTheme => _currentTheme;

  // установка новой темы
  // сохраняет выбор пользователя и уведомляет UI
  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    await _saveTheme(theme); // ждём сохранения
    notifyListeners();
  }

  // Загрузка темы из SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final type = prefs.getString(_defaultThemeKey) ?? _defaultThemeType;
    _currentTheme = _getThemeByType(type);
    notifyListeners();
  }

  // сохранение текущей темы
  Future<void> _saveTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_defaultThemeKey, theme.type.name);
  }

  // преобразование типа темы в AppTheme (для асинхронной загрузки)
  AppTheme _getThemeByType(String type) {
    return _themes[type] ?? _themes[_defaultThemeType]!;
  }

  // список всех доступных тем
  static final Map<String, AppTheme> _themes = {
    'dark': AppTheme(
      type: AppThemeType.dark,
      primaryColor: Colors.blue,
      accentColor: Colors.orange,
      backgroundColor: Colors.black,
    ),
    'light': AppTheme(
      type: AppThemeType.light,
      primaryColor: Colors.grey[900]!,
      accentColor: Colors.redAccent,
      backgroundColor: Colors.white,
    ),
    'custom': AppTheme(
      type: AppThemeType.custom,
      primaryColor: Colors.teal,
      accentColor: Colors.amber,
      backgroundColor: Colors.grey[900]!,
    ),
  };

  // статическая версия для инициализации поля по умолчанию
  static AppTheme _getThemeByTypeStatic(String type) {
    return _themes[type] ?? _themes[_defaultThemeType]!;
  }
}