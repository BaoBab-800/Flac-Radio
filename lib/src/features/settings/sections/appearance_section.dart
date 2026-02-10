import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';

/*
  Общая идея:
  AppearanceSection отображает UI для выбора темы приложения
  Подписывается на SettingsService и обновляет глобальные настройки при выборе темы
*/

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();  // Подписка на изменения сервиса настроек
    final current = settings.global.themeMode;          // Текущее значение темы

    // Колонка с выбором темы
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),

        // Верх колонки
        ListTile(
          title: Text("Theme"),
        ),

        // Тайлы выбора темы
        for (final mode in ThemeMode.values)  // foreach для каждой темы из enum
          RadioListTile<ThemeMode>(
            title: Text(mode.name),
            value: mode,
            groupValue: current,

            // При выборе сменить тему
            onChanged: (value) {
              if (value == null) return;  // Если тем нет/закончились не рисовать тайлы

              // Обновление состояния темы
              settings.updateGlobal(
                settings.global.copyWith(themeMode: value),
              );
            },
          ),
      ],
    );
  }
}