import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';

/*
  Общая идея:
  SharedPrefsSettingsRepository реализует хранение настроек приложения через SharedPreferences
  1. Загружает настройки из локального хранилища в формате JSON
  2. Сохраняет текущие настройки в SharedPreferences
  3. Сбрасывает настройки, удаляя ключ из SharedPreferences
  4. Обеспечивает безопасное восстановление настроек с проверкой формата и наличия данных
*/

class SharedPrefsSettingsRepository implements SettingsRepository {
  // Ключ для хранения настроек в SharedPreferences
  static const _settingsKey = 'app_settings';

  // Конструктор
  const SharedPrefsSettingsRepository();

  // Загрузка настроек из SharedPreferences
  @override
  Future<SettingsDto> load() async {
    final prefs = await SharedPreferences.getInstance();
    final rawSettings = prefs.getString(_settingsKey);

    // Если настроек нет или строка пуста, вернуть значения по умолчанию
    if (rawSettings == null || rawSettings.isEmpty) return SettingsDto.defaults;

    try {
      final decoded = jsonDecode(rawSettings);

      // Если JSON не является Map, вернуть значения по умолчанию
      if (decoded is! Map<String, dynamic>) return SettingsDto.defaults;

      // Восстановление настроек из JSON
      return SettingsDto.fromJson(decoded);
    } on FormatException {
      // При ошибке формата вернуть значения по умолчанию
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

  // Сброс настроек путем удаления ключа из SharedPreferences
  @override
  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_settingsKey);
  }
}