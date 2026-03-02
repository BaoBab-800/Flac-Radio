import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/app/app_routes.dart';

import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  Сбрасывает настройки
  Ну и всё)
*/

class ResetSection extends StatelessWidget {
  const ResetSection({super.key});

  // Диалог подтверждения
  void resetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final settings = context.read<SettingsService>(); // Подписка на изменения глобальных настроек

        return AlertDialog(
          // Заголовок
          content: Text(
            context.l10n.doYouWantToResetTheSettings,
            style: TextStyle(fontSize: 16),
          ),
          // Да/Нет
          actions: [
            TextButton(
              onPressed: () {
                settings.resetCounter();
                Navigator.of(context).pop();
              },
              child: Text(context.l10n.no),
            ),

            TextButton(
              onPressed: () {
                settings.reset();

                Navigator.of(context).pop();

                // При седьмом сбросе настроек подряд переброс на загадочную страницу
                if (settings.shouldOpenMysteriousPage) {
                  Navigator.pushNamed(context, AppRoute.mysteriousPage.path);
                  settings.resetCounter();
                }
              },
              child: Text(context.l10n.yes),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(indent: 6, endIndent: 6),

        ListTile(
          // Заголовок
          title: Text(
            context.l10n.resetSettings,
            style: TextStyle(color: Colors.red),
          ),

          // При нажатии вызывает диалог подтверждения
          onTap: ()  {
            resetConfirmationDialog(context);
          },
        ),
      ],
    );
  }
}