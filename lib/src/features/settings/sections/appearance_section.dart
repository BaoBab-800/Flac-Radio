import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/core/theme/app_theme.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

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
          title: Text(
            context.l10n.theme,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        // Тайлы выбора темы
        for (final mode in AppThemeMode.values)  // foreach для каждой темы из enum
          RadioListTile<AppThemeMode>(
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