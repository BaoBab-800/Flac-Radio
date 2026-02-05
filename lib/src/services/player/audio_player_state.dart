import 'package:musicplayer/src/core/error/app_error.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

// состояние аудиоплеера используемое сервисом и UI
class AudioPlayerState {
  final RadioStation? currentStation; // текущая выбранная радиостанция
  final bool isPlaying; // признак активного воспроизведения
  final bool isLoading; // признак процесса загрузки или инициализации потока
  final AppError? error;  // сообщение об ошибке для отображения в UI

  const AudioPlayerState({
    this.currentStation,
    required this.isPlaying,
    required this.isLoading,
    this.error,
  });

  // начальное состояние плеера
  static const empty = AudioPlayerState(
    isPlaying: false,
    isLoading: false,
    currentStation: null,
    error: null,
  );

  // создание нового состояния на основе текущего
  // используется для иммутабельного обновления состояния
  AudioPlayerState copyWith({
    bool? isPlaying,
    bool? isLoading,
    RadioStation? currentStation,
    AppError? error,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      currentStation: currentStation ?? this.currentStation,
      error: error,
    );
  }
}