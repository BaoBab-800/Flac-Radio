import 'package:musicplayer/src/core/error/app_error.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

/*
  Общая идея:
  AudioPlayerState хранит состояние аудиоплеера в приложении
  1. Отслеживает текущую выбранную радиостанцию
  2. Хранит флаги воспроизведения и загрузки потока
  3. Позволяет передавать информацию об ошибках через AppError
  4. Поддерживает создание изменённых копий через copyWith
  5. Используется PlayerService и UI для синхронизации состояния плеера
*/

class AudioPlayerState {
  // Текущая выбранная радиостанция
  final RadioStation? currentStation;

  // Признак активного воспроизведения
  final bool isPlaying;

  // Признак процесса загрузки или инициализации потока
  final bool isLoading;

  // Сообщение об ошибке для отображения в UI
  final AppError? error;

  // Конструктор с обязательными флагами и необязательными полями
  const AudioPlayerState({
    this.currentStation,
    required this.isPlaying,
    required this.isLoading,
    this.error,
  });

  // Пустое состояние плеера по умолчанию
  static const empty = AudioPlayerState(
    isPlaying: false,
    isLoading: false,
    currentStation: null,
    error: null,
  );

  // Создание копии состояния с выборочным изменением полей
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
      error: error, // Если передан null, сбрасывает ошибку
    );
  }
}