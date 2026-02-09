import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/services/theme/theme_service.dart';

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

      theme: ThemeData.light(), // Светлая тема
      darkTheme: ThemeData.dark(), // Тёмная тема
      themeMode: themeService.themeMode, // Динамический выбор темы из ThemeService
    );
  }
}