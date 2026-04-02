import 'package:flutter/foundation.dart';
import 'package:musicplayer/src/services/player/audio_player_state.dart';

abstract class PlayerStateReader implements Listenable {
  AudioPlayerState get state;
}

abstract class PlayerControls {
  Future<void> togglePlayPause();
  Future<void> nextStation();
  Future<void> previousStation();
  Future<void> setVolume(double volume);
  Future<void> stop();
}
