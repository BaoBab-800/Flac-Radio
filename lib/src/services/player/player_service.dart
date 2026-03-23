import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'audio_player_state.dart';
import 'package:musicplayer/src/core/error/app_error.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

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
  final AudioPlayer _audioPlayer; // Низкоуровневый аудиоплеер
  List<RadioStation> stations = [];
  int _currentIndex = 0;

  PlayerService(this._audioPlayer) {
    // Подписка на события плеера при создании сервиса
    _listenToPlayer();
  }

  AudioPlayer get audioPlayer => _audioPlayer;  // Доступ к плееру
  AudioPlayerState get state => _state; // Доступ к состоянию для UI
  AudioPlayerState _state = AudioPlayerState.empty; // Текущее состояние плеера

  int get currentIndex => _currentIndex;  // Индекс текущей станции
  set currentIndex(int index) {
    if (index >= 0 && index < stations.length) {
      _currentIndex = index;
    }
  }

  // Обновление состояния и уведомление слушателей
  void _emit(AudioPlayerState newState) {
    if (_state == newState) return; // Защита от лишних notifyListeners при неизменном состоянии
    _state = newState;
    notifyListeners();
  }

  // Подписка на стримы AudioPlayer
  // Синхронизация внутреннего состояния приложения с состоянием плеера
  void _listenToPlayer() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      // Определение состояния загрузки на основе ProcessingState
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

      // Синхронизация состояния воспроизведения и загрузки
      _emit(
        _state.copyWith(
          isPlaying: isPlaying,
          isLoading: isLoading,
          error: null,
        ),
      );
    });

    // Обработка ошибок стрима воспроизведения
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

  // Сеттер для теста
  @visibleForTesting
  void setCurrentStationForTest(RadioStation station) {
    _state = _state.copyWith(currentStation: station);
  }

  // Запуск воспроизведения выбранной радиостанции
  Future<void> play(RadioStation station, {String? localizedTitle}) async {
    // Если выбранная станция уже воспроизводится ничего не делать
    if (_state.currentStation?.id == station.id && _audioPlayer.playing) return;

    // Если станция уже выбрана, плеер не играет
    if (_state.currentStation?.id == station.id && !_audioPlayer.playing) {
      await _audioPlayer.play();
      return;
    }

    // Обновляем текущий индекс станции
    _currentIndex = stations.indexWhere((s) => s.id == station.id);
    if (_currentIndex < 0) _currentIndex = 0;

    // Обновление текущей станции до загрузки потока
    _emit(
      _state.copyWith(
        currentStation: station,
        error: null,
      ),
    );

    try {
      final playlist = stations.isEmpty ? [station] : stations;

      // Установка плейлиста для системного уведомления + запуск воспроизведения
      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: playlist.map(
                (s) => _stationSource(s, localizedTitle: localizedTitle ?? station.titleKey),
          ).toList(),
        ),
        initialIndex: _currentIndex,
      );

      await _audioPlayer.play();
    } catch (e) {
      // Обработка ошибки запуска воспроизведения
      _emit(
        _state.copyWith(
          isPlaying: false,
          isLoading: false,
          error: AppError.playbackStart,
        ),
      );
    }
  }

  AudioSource _stationSource(RadioStation station, {required String localizedTitle}) {
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

  // Пауза (вынесена в отдельную функцию для тестов)
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // Переключение между паузой и воспроизведением
  Future<void> togglePlayPause() async {
    try {
      if (_audioPlayer.playing) await _audioPlayer.pause();
      else await _audioPlayer.play();
    } catch (e, st) {
      debugPrint('PlayerService.toggle error: $e\n$st');

      _emit(
        _state.copyWith(
          error: AppError.playbackControl,
        ),
      );
    }
  }

  // Полная остановка воспроизведения и сброс состояния
  Future<void> stop() async {
    await _audioPlayer.stop();
    _emit(AudioPlayerState.empty);
  }

  // Управление громкостью
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
    _emit(_state.copyWith(volume: volume));
  }

  // Переключение станций по кругу вперёд
  Future<void> nextStation() async {
    if (stations.isEmpty) return;

    _currentIndex = (_currentIndex + 1) % stations.length;

    await play(stations[_currentIndex]);
  }

  // И назад
  Future<void> previousStation() async {
    if (stations.isEmpty) return;

    _currentIndex = (_currentIndex - 1 + stations.length) % stations.length;

    await play(stations[_currentIndex]);
  }

  // Освобождение ресурсов плеера
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}