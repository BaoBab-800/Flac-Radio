import 'package:musicplayer/src/data/radio/models/radio_station.dart';

abstract class RadioStationRepository {
  // Получение полного списка радиостанций
  Future<List<RadioStation>> getAllStations();

  // Получение радиостанции по уникальному идентификатору
  Future<RadioStation?> getById(String id);
}