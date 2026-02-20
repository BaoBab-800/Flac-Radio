import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Сервис управления локализацией
class LocalizationService extends ChangeNotifier {
  static const _keyLocale = 'locale';

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  LocalizationService() {
    _loadLocale();
  }

  // Загрузка локализации из памяти
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_keyLocale);
    if (code != null) {
      _locale = Locale(code);
      notifyListeners();
    }
  }

  // Установка локализации
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, locale.languageCode);
  }
}