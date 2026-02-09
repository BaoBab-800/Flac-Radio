import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';

/*
  Общая идея:
  SettingsDto представляет единый формат хранения всех настроек приложения
  1. Объединяет глобальные и плеерные настройки
  2. Предоставляет методы для копирования с изменениями (copyWith)
  3. Поддерживает сериализацию в JSON и восстановление из JSON
  4. Определяет значения по умолчанию через defaults
*/

class SettingsDto {
  // Глобальные настройки приложения
  final GlobalSettings global;

  // Настройки плеера
  final PlayerSettings player;

  // Конструктор с обязательными параметрами
  const SettingsDto({
    required this.global,
    required this.player,
  });

  // Значения настроек по умолчанию
  static const defaults = SettingsDto(
    global: GlobalSettings.defaults,
    player: PlayerSettings.defaults,
  );

  // Создание копии объекта с выборочным изменением полей
  SettingsDto copyWith({
    GlobalSettings? global,
    PlayerSettings? player,
  }) {
    return SettingsDto(
      global: global ?? this.global,
      player: player ?? this.player,
    );
  }

  // Сериализация настроек в Map для хранения или передачи
  Map<String, dynamic> toJson() {
    return {
      'global': global.toJson(),
      'player': player.toJson(),
    };
  }

  // Настройки из Map (JSON)
  factory SettingsDto.fromJson(Map<String, dynamic> json) {
    final globalJson = json['global'];
    final playerJson = json['player'];

    return SettingsDto(
      global: globalJson is Map<String, dynamic>
          ? GlobalSettings.fromJson(globalJson)
          : GlobalSettings.defaults,
      player: playerJson is Map<String, dynamic>
          ? PlayerSettings.fromJson(playerJson)
          : PlayerSettings.defaults,
    );
  }
}