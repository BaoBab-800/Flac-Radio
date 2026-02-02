import 'package:flutter/material.dart';

// Возможные темы приложения
enum AppTheme {
  system,
  light,
  dark,
}

// Виджет настроек интерфейса приложения
class SettingsInterface extends StatefulWidget {
  const SettingsInterface({super.key});

  @override
  State<SettingsInterface> createState() => _SettingsInterfaceState();
}

class _SettingsInterfaceState extends State<SettingsInterface> {

  // Текущая выбранная тема, по умолчанию системная
  AppTheme _currentTheme = AppTheme.system;

  // Преобразует enum AppTheme в человекочитаемый текст
  // Используется в UI (subtitle, RadioListTile)
  String _themeTitle(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return "Светлая";
      case AppTheme.dark:
        return "Тёмная";
      case AppTheme.system:
        return "Системная";
    }
  }

  // Показывает диалог выбора темы
  // Используется при нажатии на пункт "Тема приложения"
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Выбор темы"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: AppTheme.values.map((theme) {
              return RadioListTile<AppTheme>(
                title: Text(_themeTitle(theme)),
                value: theme,
                groupValue: _currentTheme,  // Выбранное в данный момент значение
                // Срабатывает при выборе радиокнопки
                onChanged: (value) {
                  onThemeChange(value!);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Пункт выбора темы приложения
        ListTile(
          title: const Text("Тема приложения"),
          subtitle: Text(_themeTitle(_currentTheme)),
          onTap: () => _showThemeDialog(context), // По нажатию открыть диалог выбора темы
        ),

        // Заглушка под настройку размера текста
        ListTile(
          title: const Text("Размер текста"),
          onTap: () {},
        ),

        // Переключатель отображения нижней панели
        ListTile(
          title: const Text("Скрывать нижнюю панель, если ничего не играет"),
          trailing: Switch(
            value: true,          // TODO: заменить на состояние
            onChanged: (val) {},  // TODO: сохранить настройку
          ),
        ),

        // Переключатель отображения описания станции
        ListTile(
          title: const Text("Показывать описание станции в списке"),
          trailing: Switch(
            value: true,          // TODO: заменить на состояние
            onChanged: (val) {},  // TODO: сохранить настройку
          ),
        ),
      ],
    );
  }
}