import 'package:musicplayer/src/data/radio/radio_station_model.dart';

class AudioPlayerState {
  final RadioStationModel? currentStation;
  final bool isPlaying;
  final bool isLoading;
  final double volume;
  final bool stopOnBackground;

  const AudioPlayerState({
    this.currentStation,
    required this.isPlaying,
    required this.isLoading,
    required this.volume,
    required this.stopOnBackground,
  });

  // Чистое/стартовое состояние плеера
  static const empty = AudioPlayerState(
    isPlaying: false,
    isLoading: false,
    currentStation: null,
    volume: 1,
    stopOnBackground: false,
  );

  AudioPlayerState copyWith({
    RadioStationModel? currentStation,
    bool? isPlaying,
    bool? isLoading,
    double? volume,
  }) {
    return AudioPlayerState(
      currentStation: currentStation ?? this.currentStation,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      volume: volume ?? this.volume,
      stopOnBackground: stopOnBackground ?? this.stopOnBackground,
    );
  }

  // Переопределение оператора для корректной работы _emit
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AudioPlayerState &&
              currentStation == other.currentStation &&
              isPlaying == other.isPlaying &&
              isLoading == other.isLoading &&
              volume == other.volume;

  @override
  int get hashCode =>
      currentStation.hashCode ^ isPlaying.hashCode ^ isLoading.hashCode ^ volume.hashCode;
}