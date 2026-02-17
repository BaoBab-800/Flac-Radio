import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/services/player/player_service.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  1. Реализация панели управления плеером
  2. Отображение текущей станции
  3. Кнопка пауза/плей
  TODO: Сделать переключение станций
*/

// Логика виджета
class BottomPanelSection extends StatelessWidget {
  const BottomPanelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Consumer<PlayerService>(
        builder: (context, player, child) {
          // Параметры панели
          final station = player.state.currentStation;
          final isPlaying = player.state.isPlaying;
          final isLoading = player.state.isLoading;

          // Если станция не запущена пустая панель
          if (station == null) {
            return const SizedBox.shrink();
          }

          // Непосредственно панель
          return _PanelContents(
            titleKey: station.titleKey,
            isPlaying: isPlaying,
            isLoading: isLoading,
            onToggle: player.togglePlayPause,
          );
        },
      ),
    );
  }
}

// Виджет
class _PanelContents extends StatelessWidget {
  const _PanelContents({
    required this.titleKey,
    required this.isPlaying,
    required this.isLoading,
    required this.onToggle,
  });

  final String titleKey;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Название станции
          Expanded(
            child: Text(
              context.l10n.byKey(titleKey),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          isLoading
              ? const SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : IconButton(
            iconSize: 32,
            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: onToggle,
          ),
        ],
      ),
    );
  }
}