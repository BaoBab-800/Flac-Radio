import 'package:musicplayer/src/data/settings/settings_dto.dart';

abstract class SettingsRepository {
  // Загрузка настроек из источника данных
  Future<SettingsDto> load();

  // Сохранение настроек в источник данных
  Future<void> save(SettingsDto settings);

  // Сброс настроек к значениям по умолчанию
  Future<void> reset();
}