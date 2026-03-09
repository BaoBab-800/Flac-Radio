import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  LanguageSection отображает интерфейс для выбора языка приложения
  1. Использует SettingsService для чтения и изменения текущей локали
  2. Предоставляет DropdownButton со списком поддерживаемых языков
  3. При выборе языка обновляет глобальные настройки через сервис
  4. Подписывается на изменения настроек и автоматически обновляется
*/

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  // Поддерживаемые языки приложения
  static const supportedLocales = {
    'en': 'English',
    'uk': 'Українська',
    'ru': 'Русский',
    'de': 'Deutsch',
    'es': 'Español',
    'fr': 'Français',
  };

  @override
  Widget build(BuildContext context) {
    // Получение сервиса настроек и подписка на изменения
    final settings = context.watch<SettingsService>();

    return Column(
      children: [
        const Divider(indent: 6, endIndent: 6),

        // Секция выбора языка
        ListTile(
          title: Text(
            context.l10n.language,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          trailing: DropdownButton<String>(
            value: settings.global.localeCode, // Текущий выбранный язык
            items: supportedLocales.entries
                .map(
                  (e) => DropdownMenuItem(
                value: e.key,
                child: Text(e.value), // Отображение названия языка
              ),
            ).toList(),

            onChanged: (value) {
              if (value != null) {
                // Обновление глобальной локали через SettingsService
                settings.setLocale(value);
              }
            },
          ),
        ),
      ],
    );
  }
}