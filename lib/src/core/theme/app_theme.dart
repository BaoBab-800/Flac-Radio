import 'package:flutter/material.dart';

// типы доступных тем приложения
enum AppThemeMode { light, dark }

// модель темы приложения
// хранит основные цвета и тип темы
// цвета будут проксироваться через ThemeExtension (AppColors).
class AppTheme {
  final AppThemeMode type;  // тип темы для логики переключения
  final Color primaryColor; // основной цвет интерфейса
  final Color accentColor;  // акцентный цвет для кнопок, иконок, выделений
  final Color backgroundColor;  // цвет фона

  // конструктор требует все параметры, тема считается immutable
  AppTheme({
    required this.type,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
  });
}