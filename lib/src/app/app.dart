import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/data/theme/app_theme.dart';
import 'package:musicplayer/src/services/theme/theme_service.dart';

class FlacRadioApp extends StatelessWidget {
  const FlacRadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<ThemeService>();

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Отключение баннера дебага
      title: 'Flac Radio', // Название приложения

      theme: AppThemes.fromSettings(ThemeMode.light, settings.themeColor),
      darkTheme: AppThemes.fromSettings(ThemeMode.dark, settings.themeColor),
      themeMode: settings.themeMode,

      home: _TestHomePage(),
    );
  }
}

class _TestHomePage extends StatelessWidget {
  const _TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 70),
            DropdownButton<ThemeMode>(
              value: themeService.themeMode,
              items: ThemeMode.values.map((mode) {
                return DropdownMenuItem(
                  value: mode,
                  child: Text(mode.toString().split('.').last),
                );
              }).toList(),
              onChanged: (mode) {
                if (mode != null) {
                  context.read<ThemeService>().setThemeMode(mode);
                }
              },
            ),
            SizedBox(height: 10),
            DropdownButton<AppThemeColor>(
              value: themeService.themeColor,
              items: AppThemes.availableColors.map((color) {
                return DropdownMenuItem(
                  value: color,
                  child: Text(color.name),
                );
              }).toList(),
              onChanged: (color) {
                if (color != null) {
                  context.read<ThemeService>().setThemeColor(color);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}