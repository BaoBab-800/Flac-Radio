/*
  Общая идея:
  PlayerSettings хранит настройки плеера приложения
  1. Управляет автозапуском, уровнем громкости и поведением при потере фокуса аудио
  2. Предоставляет методы copyWith для копирования с изменениями
  3. Поддерживает сериализацию в JSON и восстановление из JSON
  4. Определяет значения по умолчанию через defaults
*/

class PlayerSettings {
  // Остановка воспроизведения при уходе приложения в background
  final bool stopOnBackground;

  // Громкость плеера от 0 до 1
  final double volume;

  const PlayerSettings({
    required this.stopOnBackground,
    required this.volume,
  });

  // Значения по умолчанию
  static const defaults = PlayerSettings(
    stopOnBackground: false,
    volume: 1.0,
  );

  // Копия с изменёнными полями
  PlayerSettings copyWith({
    bool? stopOnBackground,
    double? volume,
  }) {
    return PlayerSettings(
      stopOnBackground: stopOnBackground ?? this.stopOnBackground,
      volume: volume ?? this.volume,
    );
  }

  // Преобразование в Map для хранения или передачи
  Map<String, dynamic> toJson() {
    return {
      'stopOnBackground': stopOnBackground,
      'volume': volume,
    };
  }

  // Восстановление из Map с проверкой и нормализацией громкости
  factory PlayerSettings.fromJson(Map<String, dynamic> json) {
    final rawVolume = json['volume'];

    // Преобразование объёма к double или использование значения по умолчанию
    final normalizedVolume = switch (rawVolume) {
      num n => n.toDouble(),
      _ => defaults.volume,
    };

    return PlayerSettings(
      // Ограничение громкости от 0 до 1
      volume: normalizedVolume.clamp(0, 1),
      stopOnBackground: json['stopOnBackground'] as bool? ?? defaults.stopOnBackground,
    );
  }
}