/*
  Общая идея:
  PlayerSettings хранит настройки плеера приложения
  1. Управляет автозапуском, уровнем громкости и поведением при потере фокуса аудио
  2. Предоставляет методы для копирования с изменениями (copyWith)
  3. Поддерживает сериализацию в JSON и восстановление из JSON
  4. Определяет значения по умолчанию через defaults
*/

class PlayerSettings {
  // Включён ли автозапуск воспроизведения
  final bool autoplay;

  // Громкость плеера от 0 до 1
  final double volume;

  // Останавливать ли воспроизведение при потере фокуса аудио
  final bool stopOnAudioFocusLoss;

  // Конструктор с обязательными параметрами
  const PlayerSettings({
    required this.autoplay,
    required this.volume,
    required this.stopOnAudioFocusLoss,
  });

  // Значения настроек плеера по умолчанию
  static const defaults = PlayerSettings(
    autoplay: true,
    volume: 1,
    stopOnAudioFocusLoss: true,
  );

  // Создание копии объекта с выборочным изменением полей
  PlayerSettings copyWith({
    bool? autoplay,
    double? volume,
    bool? stopOnAudioFocusLoss,
  }) {
    return PlayerSettings(
      autoplay: autoplay ?? this.autoplay,
      volume: volume ?? this.volume,
      stopOnAudioFocusLoss: stopOnAudioFocusLoss ?? this.stopOnAudioFocusLoss,
    );
  }

  // Сериализация настроек плеера в Map для хранения или передачи
  Map<String, dynamic> toJson() {
    return {
      'autoplay': autoplay,
      'volume': volume,
      'stopOnAudioFocusLoss': stopOnAudioFocusLoss,
    };
  }

  // Восстановление настроек плеера из Map (JSON) с проверкой и нормализацией громкости
  factory PlayerSettings.fromJson(Map<String, dynamic> json) {
    final rawVolume = json['volume'];

    // Преобразование объёма к double или использование значения по умолчанию
    final normalizedVolume = switch (rawVolume) {
      num n => n.toDouble(),
      _ => defaults.volume,
    };

    return PlayerSettings(
      autoplay: json['autoplay'] as bool? ?? defaults.autoplay,
      volume: normalizedVolume.clamp(0, 1), // Ограничение громкости от 0 до 1
      stopOnAudioFocusLoss:
      json['stopOnAudioFocusLoss'] as bool? ?? defaults.stopOnAudioFocusLoss,
    );
  }
}