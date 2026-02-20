import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Сервис управления локализацией
class LocalizationService extends ChangeNotifier {
  static const _keyLocale = 'locale';

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('uk'),
    Locale('ru'),
  ];

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  LocalizationService() {
    _loadLocale();
  }

  // Загрузка локализации из памяти
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_keyLocale);
    if (code == null) return;

    final savedLocale = Locale(code);
    if (!_isSupported(savedLocale)) return;

    _locale = savedLocale;
    notifyListeners();
  }

  // Установка локализации
  Future<void> setLocale(Locale locale) async {
    if (!_isSupported(locale) || _locale == locale) return;

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, locale.languageCode);
  }

  bool _isSupported(Locale locale) {
    return supportedLocales.any((item) => item.languageCode == locale.languageCode);
  }
}