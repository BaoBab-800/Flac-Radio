import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';

/*
  Общая идея:
  PlayerSection отображает UI для управления настройками плеера
  Подписывается на SettingsService и обновляет PlayerSettings при изменениях
*/

class PlayerSection extends StatelessWidget {
  const PlayerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsService>();  // Подписка на изменения глобальных настроек
    final player = settings.player;                     // Текущие настройки плеера

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),

        // Заголовок секции
        const ListTile(
          title: Text(
            'Player',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Включение/отключение автозапуска
        SwitchListTile(
          title: const Text('Autoplay'),
          value: player.autoplay,
          onChanged: (value) {
            // Обновление глобальных настроек с новым значением autoplay
            settings.updatePlayer(
              player.copyWith(autoplay: value),
            );
          },
        ),

        // Включение/отключение остановки при потере аудио фокуса
        SwitchListTile(
          title: const Text('Stop on audio focus loss'),
          value: player.stopOnAudioFocusLoss,
          onChanged: (value) {
            // Обновление глобальных настроек с новым значением stopOnAudioFocusLoss
            settings.updatePlayer(
              player.copyWith(stopOnAudioFocusLoss: value),
            );
          },
        ),

        // Управление громкостью через слайдер
        ListTile(
          title: const Text('Volume'),
          subtitle: Slider(
            value: player.volume,
            min: 0,
            max: 1,
            onChanged: (value) {
              // Обновление глобальных настроек с новым значением громкости
              settings.updatePlayer(
                player.copyWith(volume: value),
              );
            },
          ),
        ),
      ],
    );
  }
}