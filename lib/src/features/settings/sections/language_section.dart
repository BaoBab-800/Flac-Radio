import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';

/*
  Общая идея:
  LanguageSection отображает UI для выбора языка приложения
  Подписывается на SettingsService и обновляет глобальные настройки при выборе нового языка
*/

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  // Список поддерживаемых локалей
  static const supportedLocales = {
    'en': 'English',
    'ru': 'Русский',
  };

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();  // Подписка на изменения глобальных настроек
    final locale = settings.global.localeCode;          // Текущий выбранный язык

    // Отображение строки выбора языка
    return Column(
      children: [
        Divider(),

        ListTile(
          title: const Text('Language'),

          // Dropdown с выбором локали
          trailing: DropdownButton<String>(
            value: locale,  // Текущий выбранный язык
            items: supportedLocales.entries
                .map(
                  (e) => DropdownMenuItem(
                value: e.key,     // Код локали
                child: Text(e.value), // Название локали
              ),
            ).toList(),

            // Обработка выбора нового языка
            onChanged: (value) {
              if (value == null) return;  // Защита от null

              // Обновление глобальных настроек с новым языком
              settings.updateGlobal(
                settings.global.copyWith(localeCode: value),
              );
            },
          ),
        ),
      ],
    );
  }
}