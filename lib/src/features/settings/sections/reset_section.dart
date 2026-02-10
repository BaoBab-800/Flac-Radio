import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';

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

    return ListTile(
      // Заголовок
      title: const Text(
        'Reset settings',
        style: TextStyle(color: Colors.red),
      ),
      // При нажатии сбрасывает настройки (потом добавить диалог подтверждения)
      onTap: () async {
        await settings.reset();
      },
    );
  }
}