import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/src/core/error/app_error.dart';

import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'audio_player_state.dart';

/*
  Общая идея:
  PlayerService управляет воспроизведением радиостанций и состоянием плеера
  1. Хранит текущее состояние плеера через AudioPlayerState
  2. Инкапсулирует AudioPlayer из just_audio
  3. Обеспечивает запуск, паузу, остановку и переключение воспроизведения
  4. Обрабатывает ошибки воспроизведения через AppError
  5. Уведомляет UI об изменениях через ChangeNotifier
*/

class PlayerService extends ChangeNotifier {
  // Внутренний аудиоплеер для воспроизведения потоков
  final AudioPlayer _audioPlayer;

  PlayerService(this._audioPlayer);

  // Текущее состояние плеера
  AudioPlayerState _state = AudioPlayerState.empty;
  AudioPlayerState get state => _state;

  // Обновление состояния плеера и уведомление слушателей
  void _emit(AudioPlayerState newState) {
    _state = newState;
    notifyListeners();
  }

  // Запуск воспроизведения выбранной радиостанции
  Future<void> play(RadioStation station) async {
    // Если та же станция уже играет не делать повторного запуска
    if (_state.currentStation?.id == station.id && _state.isPlaying) return;

    // Установка состояния загрузки перед началом воспроизведения
    _emit(
      _state.copyWith(
        isLoading: true,
        error: null, // Сброс предыдущих ошибок
      ),
    );

    try {
      await _audioPlayer.setUrl(station.streamUrl.toString()); // установка URL потока
      await _audioPlayer.play(); // запуск воспроизведения

      // Обновление состояния после успешного старта
      _emit(
        _state.copyWith(
          currentStation: station,
          isPlaying: true,
          isLoading: false,
        ),
      );
    } catch (e, st) {
      debugPrint('PlayerService.play error: $e\n$st');

      // Обновление состояния при ошибке запуска воспроизведения
      _emit(
        _state.copyWith(
          isLoading: false,
          isPlaying: false,
          error: AppError.playbackStart,
        ),
      );
    }
  }

  // Переключение между паузой и воспроизведением
  Future<void> togglePlayPause() async {
    try {
      if (_state.isPlaying) {
        await _audioPlayer.pause(); // постановка воспроизведения на паузу

        // Синхронизация состояния после успешной паузы
        _emit(_state.copyWith(isPlaying: false));
      } else {
        await _audioPlayer.play(); // возобновление или запуск воспроизведения

        // Обновление состояния после старта воспроизведения
        _emit(_state.copyWith(isPlaying: true));
      }
    } catch (e, st) {
      debugPrint('PlayerService.toggle error: $e\n$st');

      // Обновление состояния при ошибке управления воспроизведением
      _emit(
        _state.copyWith(
          error: AppError.playbackControl,
        ),
      );
    }
  }

  // Полная остановка воспроизведения и сброс состояния
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } finally {
      _emit(AudioPlayerState.empty);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Освобождение ресурсов плеера
    super.dispose();
  }
}