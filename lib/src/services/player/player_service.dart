import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import 'audio_player_state.dart';
import 'player_contracts.dart';
import 'player_stream_observer.dart';
import 'player_error_mapper.dart';
import 'station_audio_source_factory.dart';
import 'station_playlist_controller.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

/*
  Общая идея:
  PlayerService управляет только сценариями воспроизведения и состоянием плеера.
  1. Делегирует синхронизацию стримов в PlayerStreamObserver
  2. Делегирует навигацию по станциям в StationPlaylistController
  3. Делегирует сборку AudioSource в StationAudioSourceFactory
  4. Делегирует маппинг ошибок в PlayerErrorMapper
*/

class PlayerService extends ChangeNotifier implements PlayerStateReader, PlayerControls {
  final AudioPlayer _audioPlayer;
  final StationPlaylistController _playlist;
  final StationAudioSourceFactory _sourceFactory;
  final PlayerErrorMapper _errorMapper;
  final bool _backgroundAudioEnabled;
  late final PlayerStreamObserver _streamObserver;

  Map<String, String> _localizedTitlesByKey = const {};

  PlayerService(
      this._audioPlayer, {
        StationPlaylistController? playlist,
        StationAudioSourceFactory? sourceFactory,
        PlayerErrorMapper? errorMapper,
        required bool backgroundAudioEnabled,
      }) : _playlist = playlist ?? StationPlaylistController(),
        _sourceFactory = sourceFactory ?? const StationAudioSourceFactory(),
        _errorMapper = errorMapper ?? const PlayerErrorMapper(),
        _backgroundAudioEnabled = backgroundAudioEnabled {
    _streamObserver = PlayerStreamObserver(
      _audioPlayer,
      readState: () => _state,
      emit: _emit,
    )..start();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  AudioPlayerState get state => _state;

  AudioPlayerState _state = AudioPlayerState.empty;

  List<RadioStation> get stations => _playlist.stations;
  set stations(List<RadioStation> value) => _playlist.stations = value;

  int get currentIndex => _playlist.currentIndex;
  set currentIndex(int index) => _playlist.setCurrentIndex(index);

  // Обновление состояния и уведомление слушателей
  void _emit(AudioPlayerState newState) {
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }

  @visibleForTesting
  void setCurrentStationForTest(RadioStation station) {
    _state = _state.copyWith(currentStation: station);
  }

  // Запуск воспроизведения станции
  Future<void> play(
      RadioStation station, {
        String? localizedTitle,
        Map<String, String>? localizedTitlesByKey,
      }) async {
    if (localizedTitlesByKey != null) _localizedTitlesByKey = localizedTitlesByKey;

    // Повторный запуск уже играющей станции
    if (_state.currentStation?.id == station.id && _audioPlayer.playing) return;

    // Продолжение воспроизведения текущей станции
    if (_state.currentStation?.id == station.id && !_audioPlayer.playing) {
      await _audioPlayer.play();
      return;
    }

    _playlist.syncCurrentIndexWith(station);

    // Установка текущей станции до загрузки потока
    _emit(
      _state.copyWith(
        currentStation: station,
        error: null,
      ),
    );

    try {
      // Установка плейлиста и запуск воспроизведения
      await _audioPlayer.setAudioSource(
        ConcatenatingAudioSource(
          children: [
            _sourceFactory.build(
              station: station,
              localizedTitle: _localizedTitlesByKey[station.titleKey] ??
                  localizedTitle ??
                  station.titleKey,
              backgroundAudioEnabled: _backgroundAudioEnabled,
            ),
          ],
        ),
        initialIndex: 0,
      );

      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Playback start error: $e');

      // Обработка ошибки запуска
      _emit(
        _state.copyWith(
          isPlaying: false,
          isLoading: false,
          error: _errorMapper.mapStartError(e),
        ),
      );
    }
  }

  // Пауза воспроизведения
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // Переключение состояния воспроизведения
  Future<void> togglePlayPause() async {
    try {
      if (_audioPlayer.playing) await _audioPlayer.pause();
      else await _audioPlayer.play();
    } catch (e, st) {
      debugPrint('PlayerService.toggle error: $e\n$st');

      _emit(
        _state.copyWith(
          error: _errorMapper.mapControlError(e),
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
    final station = _playlist.next();
    if (station == null) return;

    await play(station);
  }

  // Переключение на предыдущую станцию
  Future<void> previousStation() async {
    final station = _playlist.previous();
    if (station == null) return;

    await play(station);
  }

  // Освобождение ресурсов
  @override
  void dispose() {
    _streamObserver.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}
