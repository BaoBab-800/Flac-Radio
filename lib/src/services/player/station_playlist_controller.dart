import 'package:musicplayer/src/data/radio/models/radio_station.dart';

/*
  StationPlaylistController управляет списком радиостанций и текущим индексом.
  Основная цель:
  1. Хранить playlist (список станций)
  2. Сохранять текущую позицию (currentIndex)
  3. Обеспечивать навигацию "вперёд/назад" по списку
  4. Синхронизировать индекс с заданной станцией
*/

class StationPlaylistController {
  // Список станций
  List<RadioStation> _stations = const [];

  // Текущий индекс в списке
  int _currentIndex = 0;

  // Доступ к списку
  List<RadioStation> get stations => _stations;

  // Установка нового списка станций
  set stations(List<RadioStation> value) {
    _stations = value;

    // Если список пустой, сброс текущего индекса
    if (_stations.isEmpty) {
      _currentIndex = 0;
      return;
    }

    // Если текущий индекс выходит за границы, сброс
    if (_currentIndex >= _stations.length) _currentIndex = 0;
  }

  // Получение текущего индекса
  int get currentIndex => _currentIndex;

  // Явная установка текущего индекса
  void setCurrentIndex(int index) {
    if (index >= 0 && index < _stations.length) {
      _currentIndex = index;
    }
  }

  // Синхронизация текущего индекса по объекту RadioStation
  void syncCurrentIndexWith(RadioStation station) {
    final foundIndex = _stations.indexWhere((item) => item.id == station.id);
    _currentIndex = foundIndex < 0 ? 0 : foundIndex;
  }

  // Получение следующей станции и обновление индекса
  RadioStation? next() {
    if (_stations.isEmpty) return null;

    _currentIndex = (_currentIndex + 1) % _stations.length;
    return _stations[_currentIndex];
  }

  // Получение предыдущей станции и обновление индекса
  RadioStation? previous() {
    if (_stations.isEmpty) return null;

    _currentIndex = (_currentIndex - 1 + _stations.length) % _stations.length;
    return _stations[_currentIndex];
  }
}