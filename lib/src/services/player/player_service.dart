import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'package:musicplayer/src/data/radio/radio_station_model.dart';

import 'audio_player_state.dart';

class PlayerService extends ChangeNotifier {
  final AudioPlayer _audioPlayer;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  PlayerService(this._audioPlayer) {
    _listenToPlayer();
  }

  AudioPlayerState _state = AudioPlayerState.empty;
  AudioPlayerState get state => _state;

  void _emit(AudioPlayerState newState) {
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }

  // Подписка и обработка стриа аудио
  void _listenToPlayer() {
    _playerStateSubscription = _audioPlayer.playerStateStream.listen(
            (playerState) {
          final isPlaying = playerState.playing;
          final processingState = playerState.processingState;
          final isLoading = processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering;

          if (processingState == ProcessingState.completed) {
            _emit(
              _state.copyWith(
                isPlaying: false,
                isLoading: false,
                errorMessage: null,
              ),
            );
            return;
          }

          _emit(
            _state.copyWith(
              isPlaying: isPlaying,
              isLoading: isLoading,
              errorMessage: null,
            ),
          );
        },
        onError: (Object error, StackTrace stackTrace) {
          _emit(
            _state.copyWith(
              isPlaying: false,
              isLoading: false,
              errorMessage: error.toString(),
            ),
          );
        }
    );
  }

  Future<void> play(RadioStationModel station) async {
    try {
      if (_state.currentStation?.id == station.id) {
        if (!_audioPlayer.playing) await _audioPlayer.play();
        return;
      }

      _emit(
        _state.copyWith(
          currentStation: station,
          isLoading: true,
          errorMessage: null,
        ),
      );

      await _audioPlayer.setAudioSource(
        AudioSource.uri(
          station.streamUrl,
          headers: {
            'User-Agent': 'Mozilla/5.0 (Android)',
            'Accept': '*/*',
            'Connection': 'keep-alive',
          },
        ),
      );

      await _audioPlayer.play();
    } catch (error, _) {
      _emit(
        _state.copyWith(
          isPlaying: false,
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  // Переключение пауза/плей
  Future<void> togglePlayPause() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (error, _) {
      _emit(
        _state.copyWith(
          isPlaying: false,
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  // Остановка плеера
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _emit(
        _state.copyWith(
          currentStation: null,
          isPlaying: false,
          isLoading: false,
          errorMessage: null,
        ),
      );
    } catch (error, _) {
      _emit(
        _state.copyWith(
          isPlaying: false,
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  // Установка громкости
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
      _emit(
        _state.copyWith(
          volume: volume,
          errorMessage: null,
        ),
      );
    } catch (error, _) {
      _emit(
        _state.copyWith(errorMessage: error.toString()),
      );
    }
  }

// Очистка ресурсов плеера
  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    super.dispose();
  }
}