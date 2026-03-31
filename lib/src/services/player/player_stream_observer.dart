import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_player_state.dart';
import 'package:musicplayer/src/core/error/app_error.dart';

typedef OnStateChanged = void Function(AudioPlayerState state);

/*
  Общая идея:
  PlayerStreamObserver синхронизирует состояние AudioPlayer с состоянием приложения
  1. Подписывается на стримы AudioPlayer
  2. Преобразует события плеера в AudioPlayerState
  3. Передаёт обновлённое состояние через emit
  4. Управляет жизненным циклом подписок
*/

class PlayerStreamObserver {
  final AudioPlayer _audioPlayer;

  // Получение текущего состояния перед обновлением
  final AudioPlayerState Function() _readState;

  // Передача нового состояния наружу
  final OnStateChanged _emit;

  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<PlaybackEvent>? _playbackEventSub;

  PlayerStreamObserver(
      this._audioPlayer, {
        required AudioPlayerState Function() readState,
        required OnStateChanged emit,
      })  : _readState = readState, _emit = emit;

  // Запуск подписок на стримы плеера
  void start() {
    _playerStateSub = _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      // Определение состояния загрузки
      final isLoading = processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering;

      // Обработка завершения воспроизведения
      if (processingState == ProcessingState.completed) {
        _emit(
          _readState().copyWith(
            isPlaying: false,
            isLoading: false,
          ),
        );
        return;
      }

      // Синхронизация состояния воспроизведения
      _emit(
        _readState().copyWith(
          isPlaying: isPlaying,
          isLoading: isLoading,
          error: null,
        ),
      );
    });

    // Обработка ошибок стрима воспроизведения
    _playbackEventSub = _audioPlayer.playbackEventStream.listen(
          (_) {},
      onError: (e, st) {
        debugPrint('Playback stream error: $e\n$st');

        _emit(
          _readState().copyWith(
            isPlaying: false,
            isLoading: false,
            error: AppError.playbackStart,
          ),
        );
      },
    );
  }

  // Отмена подписок на стримы
  void dispose() {
    unawaited(_playerStateSub?.cancel());
    unawaited(_playbackEventSub?.cancel());
  }
}