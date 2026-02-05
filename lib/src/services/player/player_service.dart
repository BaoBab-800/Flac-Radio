import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/src/core/error/app_error.dart';

import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'audio_player_state.dart';

/*
  Общая идея:
  PlayerService управляет аудиоплеером just_audio и состоянием воспроизведения

  Ответственность:
  хранение и обновление AudioPlayerState
  управление воспроизведением радиостанций
  уведомление UI о изменениях через ChangeNotifier
*/

class PlayerService extends ChangeNotifier {
  final AudioPlayer _audioPlayer;

  PlayerService(this._audioPlayer);

  AudioPlayerState _state = AudioPlayerState.empty;
  AudioPlayerState get state => _state;

  // обновление состояния плеера и уведомление слушателей
  void _emit(AudioPlayerState newState) {
    _state = newState;
    notifyListeners();
  }

  // запуск воспроизведения выбранной радиостанции
  Future<void> play(RadioStation station) async {
    // защита от повторного запуска уже воспроизводимой станции
    if (_state.currentStation?.id == station.id && _state.isPlaying) return;

    _emit(
      _state.copyWith(
        isLoading: true,
        error: null,
      ),
    );

    try {
      // установка URL потока в плеер
      await _audioPlayer.setUrl(station.streamUrl.toString());

      // запуск воспроизведения после успешной инициализации источника
      await _audioPlayer.play();

      // обновление состояния после успешного старта воспроизведения
      _emit(
        _state.copyWith(
          currentStation: station,
          isPlaying: true,
          isLoading: false,
        ),
      );
    } catch (e, st) {
      debugPrint('PlayerService.play error: $e\n$st');

      // обработка любой ошибки и возврат плеера в безопасное состояние
      _emit(
        _state.copyWith(
          isLoading: false,
          isPlaying: false,
          error: AppError.playbackStart,
        ),
      );
    }
  }

  // переключение между паузой и воспроизведением
  Future<void> togglePlayPause() async {
    try {
      // если играт - остановить, иначе воспроизвести
      // проверка текущего состояния воспроизведения, логика управления строится на локальном состоянии а не на состоянии плеера
      if (_state.isPlaying) {
        await _audioPlayer.pause(); // постановка воспроизведения на паузу

        // синхронизация состояния после успешной паузы
        _emit(_state.copyWith(isPlaying: false));
      } else {
        // возобновление или запуск воспроизведения
        await _audioPlayer.play();

        // обновление состояния после старта воспроизведения
        _emit(_state.copyWith(isPlaying: true));
      }
    } catch (e, st) {
      debugPrint('PlayerService.toggle error: $e\n$st');

      // обработка ошибок управления плеером без изменения текущей станции
      _emit(
        _state.copyWith(
          error: AppError.playbackControl,
        ),
      );
    }
  }

  // полная остановка воспроизведения и сброс состояния
  // гарантированно сбрасывает состояние плеера
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } finally {
      _emit(AudioPlayerState.empty);
    }
  }

  // освобождает все ресурсы just_audio
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}