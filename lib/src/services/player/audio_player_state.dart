import 'package:musicplayer/src/data/radio/radio_station_model.dart';

class AudioPlayerState {
  static const _sentinel = Object();

  final RadioStationModel? currentStation;
  final bool isPlaying;
  final bool isLoading;
  final double volume;
  final String? errorMessage;

  const AudioPlayerState({
    this.currentStation,
    required this.isPlaying,
    required this.isLoading,
    required this.volume,
    this.errorMessage,
  });

  // Чистое/стартовое состояние плеера
  static const empty = AudioPlayerState(
    isPlaying: false,
    isLoading: false,
    currentStation: null,
    volume: 1,
    errorMessage: null,
  );

  AudioPlayerState copyWith({
    Object? currentStation = _sentinel,
    bool? isPlaying,
    bool? isLoading,
    double? volume,
    Object? errorMessage = _sentinel,
  }) {
    return AudioPlayerState(
      currentStation: currentStation == _sentinel
          ? this.currentStation
          : currentStation as RadioStationModel?,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      volume: volume ?? this.volume,
      errorMessage: errorMessage == _sentinel
          ? this.errorMessage
          : errorMessage as String?,
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
              volume == other.volume &&
              errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      Object.hash(
        currentStation,
        isPlaying,
        isLoading,
        volume,
        errorMessage,
      );
}