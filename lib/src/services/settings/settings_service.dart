import 'package:flutter/foundation.dart';

import 'package:musicplayer/src/core/settings/global_settings.dart';
import 'package:musicplayer/src/core/settings/player_settings.dart';
import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/data/settings/settings_dto.dart';

/*
  Общая идея:
  SettingsService управляет состоянием всех настроек приложения
  1. Хранит текущие настройки в формате SettingsDto
  2. Даёт доступ к глобальным и плеерным настройкам через геттеры
  3. Сохраняет изменения через SettingsRepository
  4. Уведомляет слушателей об изменениях с помощью ChangeNotifier
*/

class SettingsService extends ChangeNotifier {
  // Репозиторий для загрузки и сохранения настроек
  final SettingsRepository _repository;

  // Текущее состояние настроек в формате DTO
  SettingsDto _state = SettingsDto.defaults;

  // Конструктор с передачей репозитория
  SettingsService(this._repository);

  // Доступ к текущему состоянию настроек
  SettingsDto get state => _state;

  // Доступ к глобальным настройкам
  GlobalSettings get global => _state.global;

  // Доступ к настройкам плеера
  PlayerSettings get player => _state.player;

  // Инициализация сервиса с загрузкой настроек из репозитория
  Future<void> init() async {
    _state = await _repository.load();
    notifyListeners();
  }

  // Обновление глобальных настроек и сохранение в репозиторий
  Future<void> updateGlobal(GlobalSettings globalSettings) async {
    _state = _state.copyWith(global: globalSettings);
    await _repository.save(_state);
    notifyListeners();
  }

  // Обновление настроек плеера и сохранение в репозиторий
  Future<void> updatePlayer(PlayerSettings playerSettings) async {
    _state = _state.copyWith(player: playerSettings);
    await _repository.save(_state);
    notifyListeners();
  }

  // Сброс настроек к значениям по умолчанию и очистка репозитория
  Future<void> reset() async {
    _state = SettingsDto.defaults;
    await _repository.reset();
    notifyListeners();
  }
}