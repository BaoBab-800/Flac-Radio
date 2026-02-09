import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

/*
  Общая идея:
  ThemeStorage определяет контракт для хранения выбранной темы
  1. Позволяет абстрагироваться от способа хранения темы
  2. Позволяет менять реализацию хранения без изменения бизнес логики
*/
abstract class ThemeStorage {
  // Загружает сохранённый тип темы из хранилища
  // Возвращает null если тема ещё не сохранялась
  Future<AppThemeType?> loadTheme();

  // Сохраняет выбранный тип темы в хранилище
  Future<void> saveTheme(AppThemeType type);
}

/*
  Общая идея:
  Реализация ThemeStorage через SharedPreferences
  1. Сохраняет индекс AppThemeType в локальном хранилище
  2. Обеспечивает восстановление темы между запусками приложения
*/
class SharedPrefsThemeStorage implements ThemeStorage {
  // Ключ для хранения темы в SharedPreferences
  static const _key = 'app_theme_type';

  @override
  Future<AppThemeType?> loadTheme() async {
    final prefs = await SharedPreferences.getInstance(); // Доступ к SharedPreferences
    final index = prefs.getInt(_key); // Чтение сохранённого индекса enum

    // Если тема не сохранена или индекс некорректен, вернуть null
    if (index == null) return null;
    if (index < 0 || index >= AppThemeType.values.length) return null;

    return AppThemeType.values[index];
  }

  @override
  Future<void> saveTheme(AppThemeType type) async {
    final prefs = await SharedPreferences.getInstance(); // Доступ к SharedPreferences
    await prefs.setInt(_key, type.index); // Сохранение индекса enum
  }
}

/*
  Общая идея:
  ThemeService управляет текущей темой приложения
  1. Хранит активный AppThemeType в памяти
  2. Загружает тему при старте приложения
  3. Сохраняет изменения темы через ThemeStorage
  4. Уведомляет UI об изменениях через ChangeNotifier
*/
class ThemeService extends ChangeNotifier {
  // Источник сохранения темы
  final ThemeStorage _storage;

  // Текущий тип темы в памяти по умолчанию
  AppThemeType _themeType = AppThemeType.light;

  ThemeService(this._storage);

  // Доступ к текущему типу темы для UI
  AppThemeType get themeType => _themeType;

  // Инициализация сервиса и загрузка сохранённой темы
  Future<void> init() async {
    final savedTheme = await _storage.loadTheme();

    // Если сохранённая тема отличается от текущей, обновляем состояние
    if (savedTheme != null && savedTheme != _themeType) {
      _themeType = savedTheme;
      notifyListeners();
    }

    // Уведомление UI даже если тема осталась дефолтной
    notifyListeners();
  }

  // Установка новой темы
  Future<void> setTheme(AppThemeType type) async {
    // Защита от повторной установки той же темы
    if (_themeType == type) return;

    await _storage.saveTheme(type); // Сохранение выбранной темы
    _themeType = type; // Обновление состояния в памяти
    notifyListeners(); // Уведомление UI об изменении темы
  }
}