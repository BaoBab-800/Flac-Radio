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
  1. Подключает MaterialApp с конфигурацией темы и названия приложения
  2. Использует ThemeController (ThemeService) для динамического управления ThemeMode
  3. Подключение Provider позволяет автоматически обновлять UI при смене темы
*/

class FlacRadioApp extends StatelessWidget {
  const FlacRadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Получение текущего сервиса темы из контекста
    final themeService = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Отключение баннера дебага
      title: 'Flac Radio', // Название приложения

      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      locale: Locale(context.watch<SettingsService>().global.localeCode),

      // Светлая и тёмная темы
      theme: ThemeDataFactory.fromAppTheme(AppThemes.byType(AppThemeMode.light)),
      darkTheme: ThemeDataFactory.fromAppTheme(AppThemes.byType(AppThemeMode.dark)),
      themeMode: themeService.flutterThemeMode, // Динамический выбор темы из ThemeController

      initialRoute: AppRoute.main.path,
      routes: AppRoutes.routes,
    );
  }
}