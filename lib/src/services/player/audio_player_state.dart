import 'package:musicplayer/src/core/error/app_error.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'package:musicplayer/src/data/radio/models/player_metadata.dart';

/*
  Общая идея:
  AudioPlayerState хранит состояние аудиоплеера
  1. Содержит текущую выбранную радиостанцию и флаги воспроизведения и загрузки
  2. Управляет уровнем громкости
  3. Передаёт информацию об ошибках через AppError
  4. Поддерживает создание изменённых копий через copyWith
  5. Используется PlayerService и UI для синхронизации состояния плеера
*/

class AudioPlayerState {
  final RadioStation? currentStation;
  final bool isPlaying;
  final bool isLoading;
  final double volume;
  final PlayerMetadata? currentSong;
  final AppError? error;

  const AudioPlayerState({
    this.currentStation,
    required this.isPlaying,
    required this.isLoading,
    required this.volume,
    this.currentSong,
    this.error,
  });

  static const empty = AudioPlayerState(
    isPlaying: false,
    isLoading: false,
    currentStation: null,
    volume: 1,
    currentSong: null,
    error: null,
  );

  // Создание копии состояния с выборочным изменением полей
  // Передача null в error сбрасывает сообщение об ошибке
  AudioPlayerState copyWith({
    bool? isPlaying,
    bool? isLoading,
    RadioStation? currentStation,
    PlayerMetadata? currentSong,
    double? volume,
    AppError? error,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      currentStation: currentStation ?? this.currentStation,
      currentSong: currentSong ?? this.currentSong,
      volume: volume ?? this.volume,
      error: error,
    );
  }
}