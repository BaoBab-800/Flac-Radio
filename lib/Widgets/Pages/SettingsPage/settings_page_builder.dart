import 'package:flutter/material.dart';
import 'package:musicplayer/Widgets/Pages/SettingsPage/settings_appbar.dart';
import 'package:musicplayer/Widgets/Pages/SettingsPage/settings_about.dart';
import 'package:musicplayer/Widgets/Pages/SettingsPage/settings_section.dart';
import 'package:musicplayer/Themes/theme_helper.dart';

class SettingsPage extends StatelessWidget {
  final AppThemeOption currentTheme;
  final ValueChanged<AppThemeOption> onThemeChange;

  const SettingsPage({
    super.key,
    required this.currentTheme,
    required this.onThemeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Кастомный и прозрачный AppBar
      appBar: CustomAppBar(),

      // Лента с карточками настроек
      body: ListView.builder(
        itemCount: sections.length + 1, // +1 для "О приложении"
        itemBuilder: (context, index) {
          if (index < sections.length) {
            final section = sections[index];
            return cardBuilder(context, section.title, section.icon, section.children);
          }
          // последний элемент — "О приложении"
          return ListTile(
            title: Text("О приложении"),
            leading: Icon(Icons.info_outline),
            onTap: () {
              // Навигация или диалог с информацией
              Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsAbout()));
            },
          );
        },
      ),
    );
  }

  // Конструктор карточек
  Widget cardBuilder(BuildContext context, String title, IconData icon, List<Widget> children) {
    return ExpansionTile(
      title: Text(title),
      leading: Icon(icon),
      children: children,
    );
  }
}