import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';

/*
  Общая идея:
  SharedPrefsSettingsRepository хранит настройки приложения через SharedPreferences
  1. Загружает настройки из локального хранилища в формате JSON
  2. Сохраняет текущие настройки в SharedPreferences
  3. Сбрасывает настройки, удаляя ключ
  4. Обеспечивает безопасное восстановление настроек с проверкой формата и наличия данных
*/

class SharedPrefsSettingsRepository implements SettingsRepository {
  static const _settingsKey = 'app_settings';

  const SharedPrefsSettingsRepository();

  // Загрузка настроек из SharedPreferences с безопасной десериализацией
  @override
  Future<SettingsDto> load() async {
    final prefs = await SharedPreferences.getInstance();
    final rawSettings = prefs.getString(_settingsKey);

    // Если настроек нет, вернуть значения по умолчанию
    if (rawSettings == null || rawSettings.isEmpty) return SettingsDto.defaults;

    try {
      final decoded = jsonDecode(rawSettings);

      if (decoded is! Map<String, dynamic>) return SettingsDto.defaults;

      return SettingsDto.fromJson(decoded);
    } on FormatException {
      return SettingsDto.defaults;
    }
  }

  // Сохранение настроек в SharedPreferences в формате JSON
  @override
  Future<void> save(SettingsDto settings) async {
    final prefs = await SharedPreferences.getInstance();
    final serialized = jsonEncode(settings.toJson());
    await prefs.setString(_settingsKey, serialized);
  }

  // Удаление настроек из SharedPreferences
  @override
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_settingsKey);
  }
  // Кто-то реально это читает?
}