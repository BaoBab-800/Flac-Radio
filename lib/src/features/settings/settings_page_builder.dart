import 'package:flutter/material.dart';
import 'sections/settings_app_bar.dart';
import 'sections/appearance_section.dart';
import 'sections/language_section.dart';
import 'sections/player_section.dart';
import 'sections/reset_section.dart';

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
      appBar: SettingsAppBar(title: "Settings", showBackButton: true),

      body: ListView(
        children: const [
          AppearanceSection(),  // Секция с выбором темы
          LanguageSection(),    // Секция с выбором языка
          PlayerSection(),      // Секция с настроками плеера
          ResetSection(),       // Секция с кнопкой сброса настроек
        ],
      ),
    );
  }
}