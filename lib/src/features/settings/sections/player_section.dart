import 'package:flutter/material.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/services/player/player_service.dart';

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
        ListTile(
          title: Text(
            context.l10n.player,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Включение/отключение остановки при потере аудио фокуса
        SwitchListTile(
          title: Text(context.l10n.stopAudioWhenMinimizingTheApplication),
          value: player.stopOnBackground,

          onChanged: (value) async {
            // Обновление настроек плеера с новым значением stopOnBackground
            await settings.updatePlayer(
              player.copyWith(stopOnBackground: value),
            );
          },
        ),

        // Управление громкостью через слайдер
        ListTile(
          title: Text(context.l10n.volume),
          subtitle: Slider(
            value: context.watch<PlayerService>().state.volume,
            min: 0,
            max: 1,
            onChanged: (value) {
              context.read<PlayerService>().setVolume(value);
            },
          ),
        ),
      ],
    );
  }
}