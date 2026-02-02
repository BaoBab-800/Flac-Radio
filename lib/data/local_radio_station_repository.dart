import 'package:flutter/material.dart';
import 'package:musicplayer/data/radio_station_repository.dart';
import 'package:musicplayer/data/radio_stations.dart';

class LocalRadioStationRepository implements RadioStationRepository {
  @override
  List<RadioStation> getStations() {
    return [
      RadioStation(
        id: "rock",
        title: "Рок музыка",
        description: "Пока без описания",
        icon: Icons.album,
        streamUrl: Uri.parse("http://146.0.82.234:8000/live.flac"), // http://146.0.82.234:8000/rock_music/live.flac
      ),
      RadioStation(
        id: "metal",
        title: "Метал",
        description: "Тоже без описания",
        icon: Icons.album,
        streamUrl: Uri.parse("http://146.0.82.234:8000/live.flac"), // http://146.0.82.234:8000/metal_music/live.flac
      ),
      RadioStation(
        id: "jazz",
        title: "Джаз",
        description: "Без описания",
        icon: Icons.album,
        streamUrl: Uri.parse("http://146.0.82.234:8000/live.flac"),  // http://146.0.82.234:8000/jazz_music/live.flac
      ),
    ];
  }
}