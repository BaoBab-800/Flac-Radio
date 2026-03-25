import 'package:flutter/material.dart';

// Типы доступных тем приложения
enum AppThemeMode { light, dark }

class AppTheme {
  final AppThemeMode type;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;

  AppTheme({
    required this.type,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
  });
}