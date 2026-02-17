import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  Сбрасывает настройки
  Ну и всё
*/

class ResetSection extends StatelessWidget {
  const ResetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsService>(); // Подписка на изменения глобальных настроек

    return Column(
      children: [
        Divider(),

        ListTile(
          // Заголовок
          title: Text(
            context.l10n.resetSettings,
            style: TextStyle(color: Colors.red),
          ),

          // При нажатии сбрасывает настройки (потом добавить диалог подтверждения)
          onTap: () async {
            await settings.reset();
          },
        ),
      ],
    );
  }
}