import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'audio_player_state.dart';
import 'package:musicplayer/src/core/error/app_error.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'package:musicplayer/src/services/url/now_playing_service.dart';

/*
  Общая идея:
  PlayerService управляет воспроизведением аудио и синхронизирует состояние AudioPlayer с состоянием приложения
  1. Инкапсулирует работу с just_audio
  2. Подписывается на стримы плеера и обновляет AudioPlayerState
  3. Предоставляет методы управления воспроизведением и переключением станций
  4. Уведомляет UI об изменениях через ChangeNotifier
*/

class PlayerService extends ChangeNotifier {
  static bool backgroundAudioEnabled = true;

  final AudioPlayer _audioPlayer;
  final NowPlayingService _nowPlayingService = NowPlayingService();
  List<RadioStation> stations = [];
  Map<String, String> _localizedTitlesByKey = const {};
  int _currentIndex = 0;
  Timer? _timer;

  PlayerService(this._audioPlayer) {
    // Подписка на стримы плеера
    _listenToPlayer();
    _startPollingCurrentSong();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  AudioPlayerState get state => _state;

  AudioPlayerState _state = AudioPlayerState.empty;

  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    if (index >= 0 && index < stations.length) {
      _currentIndex = index;
    }
  }

  // Обновление состояния и уведомление слушателей
  void _emit(AudioPlayerState newState) {
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }

  // Синхронизация состояния плеера с состоянием приложения
  void _listenToPlayer() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      // Определение состояния загрузки
      final isLoading = processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering;

      // Обработка завершения воспроизведения
      if (processingState == ProcessingState.completed) {
        _emit(
          _state.copyWith(
            isPlaying: false,
            isLoading: false,
          ),
        );
        return;
      }

      // Обновление состояния воспроизведения
      _emit(
        _state.copyWith(
          isPlaying: isPlaying,
          isLoading: isLoading,
          error: null,
        ),
      );
    });

    // Обработка ошибок воспроизведения
    _audioPlayer.playbackEventStream.listen(
          (event) {},
      onError: (e, st) {
        debugPrint('Playback stream error: $e\n$st');

        _emit(
          _state.copyWith(
            isPlaying: false,
            isLoading: false,
            error: AppError.playbackStart,
          ),
        );
      },
    );

    // Синхронизация текущей станции по индексу плеера
    _audioPlayer.currentIndexStream.listen((index) {
      if (index == null || index < 0 || index >= stations.length) return;

      _currentIndex = index;

      _emit(
        _state.copyWith(
          currentStation: stations[index],
        ),
      );
    });
  }

  @visibleForTesting
  void setCurrentStationForTest(RadioStation station) {
    _state = _state.copyWith(currentStation: station);
  }

  void _startPollingCurrentSong() {
    _fetchCurrentSong();
    _timer = Timer.periodic(Duration(seconds: 10), (_) => _fetchCurrentSong());
  }

  Future<void> _fetchCurrentSong() async {
    final song = await _nowPlayingService.fetchCurrentSong();
    if (song != null) {
      _state = _state.copyWith(currentSong: song);
      notifyListeners();
    }
  }

  // Запуск воспроизведения станции
  Future<void> play(
      RadioStation station, {
        String? localizedTitle,
        Map<String, String>? localizedTitlesByKey,
      }) async {
    if (localizedTitlesByKey != null) {
      _localizedTitlesByKey = localizedTitlesByKey;
    }
    // Повторный запуск уже играющей станции
    if (_state.currentStation?.id == station.id && _audioPlayer.playing) return;

    // Продолжение воспроизведения текущей станции
    if (_state.currentStation?.id == station.id && !_audioPlayer.playing) {
      await _audioPlayer.play();
      return;
    }

    // Обновление текущего индекса станции
    _currentIndex = stations.indexWhere((s) => s.id == station.id);
    if (_currentIndex < 0) _currentIndex = 0;

    // Установка текущей станции до загрузки потока
    _emit(
      _state.copyWith(
        currentStation: station,
        error: null,
      ),
    );

    try {
      final playlist = stations.isEmpty ? [station] : stations;

      // Установка плейлиста и запуск воспроизведения
      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: playlist.map(
                (s) => _stationSource(
              s,
              localizedTitle:
              _localizedTitlesByKey[s.titleKey] ??
                  localizedTitle ??
                  s.titleKey,
            ),
          ).toList(),
        ),
        initialIndex: _currentIndex,
      );

      await _audioPlayer.play();
    } catch (e) {
      // Обработка ошибки запуска
      _emit(
        _state.copyWith(
          isPlaying: false,
          isLoading: false,
          error: AppError.playbackStart,
        ),
      );
    }
  }

  AudioSource _stationSource(
      RadioStation station, {
        required String localizedTitle,
      }) {
    return AudioSource.uri(
      station.streamUrl,
      tag: backgroundAudioEnabled
          ? MediaItem(
        id: station.id,
        title: localizedTitle,
      ) : null,
      headers: {
        "User-Agent": "Mozilla/5.0 (Android)",
        "Accept": "*/*",
        "Connection": "keep-alive",
      },
    );
  }

  // Пауза воспроизведения
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // Переключение состояния воспроизведения
  Future<void> togglePlayPause() async {
    try {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } catch (e, st) {
      debugPrint('PlayerService.toggle error: $e\n$st');

      _emit(
        _state.copyWith(
          error: AppError.playbackControl,
        ),
      );
    }
  }

  // Полная остановка и сброс состояния
  Future<void> stop() async {
    await _audioPlayer.stop();
    _emit(AudioPlayerState.empty);
  }

  // Изменение громкости
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
    _emit(_state.copyWith(volume: volume));
  }

  // Переключение на следующую станцию
  Future<void> nextStation() async {
    if (stations.isEmpty) return;

    _currentIndex = (_currentIndex + 1) % stations.length;

    await play(stations[_currentIndex]);
  }

  // Переключение на предыдущую станцию
  Future<void> previousStation() async {
    if (stations.isEmpty) return;

    _currentIndex = (_currentIndex - 1 + stations.length) % stations.length;

    await play(stations[_currentIndex]);
  }

  // Освобождение ресурсов
  @override
  void dispose() {
    _audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }
}