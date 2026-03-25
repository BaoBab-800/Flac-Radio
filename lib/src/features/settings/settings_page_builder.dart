import 'package:flutter/material.dart';
import 'sections/settings_app_bar.dart';
import 'sections/appearance_section.dart';
import 'sections/language_section.dart';
import 'sections/player_section.dart';
import 'sections/reset_section.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  SettingsPageBuilder собирает экран настроек из независимых секций
  Отвечает только за компоновку UI без логики
*/

class SettingsPageBuilder extends StatelessWidget {
  const SettingsPageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Кастомный AppBar
      appBar: SettingsAppBar(title: context.l10n.settings, showBackButton: true),

      body: ListView(
        children: const [
          AppearanceSection(),  // Выбор темы
          LanguageSection(),    // Выбор языка
          PlayerSection(),      // Настроки плеера
          ResetSection(),       // Кнопки сброса настроек
        ],
      ),
    );
  }
}