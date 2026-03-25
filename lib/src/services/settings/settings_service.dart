import 'package:flutter/foundation.dart';

import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';
import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';

/*
  Общая идея:
  SettingsService управляет состоянием всех настроек приложения
  1. Сохраняет текущие настройки в формате SettingsDto
  2. Предоставляет доступ к глобальным и плеерным настройкам
  3. Сохраняет изменения через SettingsRepository
  4. Уведомляет слушателей об изменениях через ChangeNotifier
*/

class SettingsService extends ChangeNotifier {
  final SettingsRepository _repository;

  SettingsDto _state = SettingsDto.defaults;

  SettingsService(this._repository);

  SettingsDto get state => _state;
  GlobalSettings get global => _state.global;
  PlayerSettings get player => _state.player;

  // Счётчик для открытия таинственной страницы
  int _mysteriousCounter = 0;
  bool get shouldOpenMysteriousPage => _mysteriousCounter == 7;

  // Инициализация с загрузкой настроек из репозитория
  Future<void> init() async {
    _state = await _repository.load();
    notifyListeners();
  }

  // Обновление глобальных настроек и сохранение
  Future<void> updateGlobal(GlobalSettings globalSettings) async {
    _state = _state.copyWith(global: globalSettings);
    await _repository.save(_state);
    notifyListeners();
  }

  // Обновление настроек плеера и сохранение
  Future<void> updatePlayer(PlayerSettings playerSettings) async {
    _state = _state.copyWith(player: playerSettings);
    await _repository.save(_state);
    notifyListeners();
  }

  // Установка языка
  Future<void> setLocale(String localeCode) async {
    _state = _state.copyWith(global: _state.global.copyWith(localeCode: localeCode));
    await _repository.save(_state);
    notifyListeners();
  }

  // Сброс настроек
  Future<void> reset() async {
    _mysteriousCounter++;
    _state = SettingsDto.defaults;
    await _repository.reset();
    notifyListeners();
  }

  // Сброс счётчика
  void resetCounter() {
    _mysteriousCounter = 0;
  }
}