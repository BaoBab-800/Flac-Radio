import '../models/radio_station.dart';

abstract class RadioStationRepository {
  Future<List<RadioStation>> getAllBaseStations();

  Future<List<RadioStation>> getAllLocalStations();

  Future<RadioStation?> getBaseStationById(String id);

  Future<RadioStation?> getLocalStationById(String id);
}