import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'app_localization_config.dart';

import 'package:musicplayer/src/core/theme/app_theme.dart';
import 'package:musicplayer/src/core/theme/app_theme_catalog.dart';
import 'package:musicplayer/src/core/theme/theme_data_factory.dart';
import 'package:musicplayer/src/services/theme/theme_controller.dart';

import 'package:musicplayer/src/services/settings/settings_service.dart';

/*
  Общая идея:
  Корневой виджет приложения
  1. Настраивает MaterialApp и маршрутизацию
  2. Подключает локализацию
  3. Управляет темой через ThemeController
  4. Обновляет UI при изменении настроек через Provider
*/

class FlacRadioApp extends StatelessWidget {
  const FlacRadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flac Radio',

      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      locale: Locale(context.watch<SettingsService>().global.localeCode),

      theme: ThemeDataFactory.fromAppTheme(AppThemes.byType(AppThemeMode.light)),
      darkTheme: ThemeDataFactory.fromAppTheme(AppThemes.byType(AppThemeMode.dark)),

      // Выбор текущего режима темы
      themeMode: themeController.flutterThemeMode,

      initialRoute: AppRoute.main.path,
      routes: AppRoutes.routes,
    );
  }
}