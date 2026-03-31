import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';

// Отвечает за преобразование доменной станции в аудио-источник для движка.
class StationAudioSourceFactory {
  const StationAudioSourceFactory();

  AudioSource build({
    required RadioStation station,
    required String localizedTitle,
    required bool backgroundAudioEnabled,
  }) {
    return AudioSource.uri(
      station.streamUrl,
      tag: backgroundAudioEnabled
          ? MediaItem(
        id: station.id,
        title: localizedTitle,
      ) : null,
    );
  }
}