import 'package:musicplayer/src/data/radio/models/radio_station.dart';

/*
  Общая идея:
  RadioStationRepository определяет контракт для источника данных радиостанций
  1. Абстрагирует доступ к списку радиостанций от конкретной реализации
  2. Позволяет получать все станции или конкретную станцию по идентификатору
  3. Реализации могут хранить станции локально, в сети или в базе данных
*/

abstract class RadioStationRepository {
  // Получение полного списка радиостанций
  Future<List<RadioStation>> getAllStations();

  // Получение радиостанции по уникальному идентификатору
  Future<RadioStation?> getById(String id);
}