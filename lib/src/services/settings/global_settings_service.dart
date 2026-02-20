import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalSettingsService extends ChangeNotifier {
  static const _keyStopOnBackground = 'stopOnBackground';

  // Остановка плеера, когда приложение уходит в фон
  bool _stopOnBackground = true;
  bool get stopOnBackground => _stopOnBackground;

  GlobalSettingsService() {
    _loadSettings();
  }

  // Загрузка настроек из SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _stopOnBackground = prefs.getBool(_keyStopOnBackground) ?? true;
    notifyListeners();
  }

  // Установка остановки плеера в фоне
  Future<void> setStopOnBackground(bool value) async {
    if (_stopOnBackground == value) return; // защита от лишних notifyListeners
    _stopOnBackground = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyStopOnBackground, value);
  }

  // Сброс всех настроек к дефолту
  Future<void> reset() async {
    _stopOnBackground = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyStopOnBackground);
  }
}