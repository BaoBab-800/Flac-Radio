import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/app/app_localization_config.dart';
import 'package:musicplayer/src/data/theme/app_theme.dart';
import 'package:musicplayer/src/services/localization/context_l10n_extension.dart';
import 'package:musicplayer/src/services/localization/localization_service.dart';
import 'package:musicplayer/src/services/theme/theme_service.dart';

class FlacRadioApp extends StatelessWidget {
  const FlacRadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSettings = context.watch<ThemeService>();
    final localizationSettings = context.watch<LocalizationService>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flac Radio',

      localizationsDelegates: AppLocalizationConfig.localizationsDelegates,
      supportedLocales: AppLocalizationConfig.supportedLocales,
      locale: localizationSettings.locale,

      theme: AppThemes.fromSettings(ThemeMode.light, themeSettings.themeColor),
      darkTheme: AppThemes.fromSettings(ThemeMode.dark, themeSettings.themeColor),
      themeMode: themeSettings.themeMode,

      home: const _TestHomePage(),
    );
  }
}

class _TestHomePage extends StatelessWidget {
  const _TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = context.watch<ThemeService>();
    final localizationService = context.watch<LocalizationService>();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            const SizedBox(height: 70),
            Text(context.l10n.appTitle),
            const SizedBox(height: 10),
            DropdownButton<Locale>(
              value: localizationService.locale,
              items: LocalizationService.supportedLocales.map((locale) {
                return DropdownMenuItem(
                  value: locale,
                  child: Text(locale.languageCode.toUpperCase()),
                );
              }).toList(),
              onChanged: (locale) {
                if (locale != null) {
                  context.read<LocalizationService>().setLocale(locale);
                }
              },
            ),
            const SizedBox(height: 10),
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