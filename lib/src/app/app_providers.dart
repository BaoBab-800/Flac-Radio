import 'package:provider/provider.dart';

import 'package:musicplayer/src/core/theme/theme_service.dart';

/*
  Общая идея:
  Глобальные провайдеры, связанные с темами приложения
  ThemeService создаётся один раз и инициализируется при старте приложения
*/

final appProviders = [
  ChangeNotifierProvider<ThemeService>(
    create: (_) {
      // создание сервиса управления темой с реализацией хранения через SharedPreferences
      final service = ThemeService(
        SharedPrefsThemeStorage(),
      );

      // загрузка сохранённой темы при инициализации сервиса
      service.init();

      return service;
    },
  ),
];