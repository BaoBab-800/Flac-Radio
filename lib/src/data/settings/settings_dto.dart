import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';

/*
  Общая идея:
  SettingsDto объединяет все настройки приложения в единый формат
  1. Содержит глобальные и плеерные настройки
  2. Предоставляет copyWith для создания копий с изменениями
  3. Поддерживает сериализацию в JSON и восстановление из JSON
  4. Определяет значения по умолчанию через defaults
*/

class SettingsDto {
  final GlobalSettings global;
  final PlayerSettings player;

  const SettingsDto({
    required this.global,
    required this.player,
  });

  static const defaults = SettingsDto(
    global: GlobalSettings.defaults,
    player: PlayerSettings.defaults,
  );

  // Создание копии с выборочным изменением полей
  SettingsDto copyWith({
    GlobalSettings? global,
    PlayerSettings? player,
  }) {
    return SettingsDto(
      global: global ?? this.global,
      player: player ?? this.player,
    );
  }

  // Преобразование в Map для хранения или передачи
  Map<String, dynamic> toJson() {
    return {
      'global': global.toJson(),
      'player': player.toJson(),
    };
  }

  // Восстановление из Map (JSON) с проверкой типов
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