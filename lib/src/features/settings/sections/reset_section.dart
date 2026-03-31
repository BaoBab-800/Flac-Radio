import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/app/app_routes.dart';

import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/services/settings/mysterious_page_service.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  ResetSection предоставляет возможность сброса настроек
  1. Показывает диалог подтверждения
  2. Выполняет сброс через SettingsService
  3. Содержит скрытую логику перехода на таинственную страницу
*/

class ResetSection extends StatelessWidget {
  const ResetSection({super.key});

  // Диалог подтверждения сброса настроек
  void resetConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final settings = dialogContext.read<SettingsService>();
        final mysteriousPageService = dialogContext.read<MysteriousPageService>();

        return AlertDialog(
          content: Text(
            dialogContext.l10n.doYouWantToResetTheSettings,
            style: const TextStyle(fontSize: 16),
          ),

          actions: [
            // Нет
            TextButton(
              onPressed: () {
                mysteriousPageService.resetCounter();
                Navigator.of(dialogContext).pop();
              },
              child: Text(dialogContext.l10n.no),
            ),

            // Да
            TextButton(
              onPressed: () {
                settings.reset();

                Navigator.of(dialogContext).pop();

                // Седьмой сброс открывает таинственную страницу
                mysteriousPageService.registerResetAttempt();

                if (mysteriousPageService.shouldOpenMysteriousPage) {
                  Navigator.pushNamed(
                    dialogContext,
                    AppRoute.mysteriousPage.path,
                  );

                  mysteriousPageService.resetCounter();
                }
              },
              child: Text(dialogContext.l10n.yes),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(indent: 6, endIndent: 6),

        ListTile(
          title: Text(
            context.l10n.resetSettings,
            style: const TextStyle(color: Colors.red),
          ),

          // Открытие диалога подтверждения
          onTap: () {
            resetConfirmationDialog(context);
          },
        ),
      ],
    );
  }
}