import 'package:hive_flutter/hive_flutter.dart';

import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';

/*
  Общая идея:
  HiveSettingsRepository хранит настройки приложения через Hive
  1. Загружает настройки из локального бокса
  2. Сохраняет текущие настройки в Hive
  3. Сбрасывает настройки, удаляя ключ
  4. Безопасно восстанавливает данные с проверкой формата
*/

class HiveSettingsRepository implements SettingsRepository {
  static const _boxName = 'settings_box';
  static const _settingsKey = 'app_settings';

  const HiveSettingsRepository();

  Future<Box<dynamic>> _openBox() => Hive.openBox<dynamic>(_boxName);

  @override
  Future<SettingsDto> load() async {
    final box = await _openBox();
    final rawSettings = box.get(_settingsKey);

    if (rawSettings is! Map) return SettingsDto.defaults;

    final decoded = _normalizeMap(rawSettings);

    return SettingsDto.fromJson(decoded);
  }

  @override
  Future<void> save(SettingsDto settings) async {
    final box = await _openBox();
    await box.put(_settingsKey, settings.toJson());
  }

  @override
  Future<void> reset() async {
    final box = await _openBox();
    await box.delete(_settingsKey);
  }

  Map<String, dynamic> _normalizeMap(Map<dynamic, dynamic> input) {
    return input.map((key, value) {
      if (value is Map) {
        return MapEntry(key.toString(), _normalizeMap(value));
      }
      return MapEntry(key.toString(), value);
    });
  }
}