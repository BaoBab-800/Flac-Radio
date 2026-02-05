import 'package:musicplayer/src/data/radio/models/radio_station.dart';

abstract class RadioStationRepository {
  Future<List<RadioStation>> getAllStations();

  Future<RadioStation?> getById(String id);
}
