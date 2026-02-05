import 'package:flutter/material.dart';

// типы доступных тем приложения
enum AppThemeType { light, dark, custom }

// модель темы приложения
// хранит основные цвета и тип темы
class AppTheme {
  final AppThemeType type;  // тип темы для логики переключения
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