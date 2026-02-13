import 'package:flutter/material.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'radio_station_repository.dart';

/*
  Общая идея:
  LocalRadioStationRepository предоставляет локальный список радиостанций
  1. Хранит статический набор радиостанций в памяти
  2. Позволяет получать все станции или конкретную станцию по идентификатору
  3. Используется как источник данных до внедрения сетевого репозитория
  4. Гарантирует неизменяемость списка станций через List.unmodifiable
*/

class LocalRadioStationRepository implements RadioStationRepository {
  // Локальный список радиостанций, защищённый от изменений
  final List<RadioStation> _stations = List.unmodifiable([
    // Rock
    RadioStation(
      id: 'rock',
      title: 'Rock radio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
      imageUrl: Uri.parse('https://e7.pngegg.com/pngimages/72/807/png-clipart-guitar-hero-rock-logo-bass-guitar-guitar-text-logo-thumbnail.png'),
    ),
    // Metal
    RadioStation(
      id: 'metal',
      title: 'Metal radio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
    ),
    // Jazz
    RadioStation(
      id: 'jazz',
      title: 'Jazz radio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
    ),
    // Pop
    RadioStation(
      id: 'pop',
      title: 'Pop radio',
      streamUrl: Uri.parse('https://flacradio.duckdns.org/listen/flac_radio/radio.flac'),
    ),
  ]);

  // Получение всех радиостанций
  @override
  Future<List<RadioStation>> getAllStations() async {
    return List.unmodifiable(_stations);
  }

  // Получение радиостанции по идентификатору
  @override
  Future<RadioStation?> getById(String id) async {
    for (final station in _stations) {
      if (station.id == id) return station; // Возврат найденной станции
    }
    return null; // Если станция не найдена вернуть null
  }
}