import 'package:flutter/material.dart';
import 'package:musicplayer/src/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:musicplayer/src/services/player/player_service.dart';
import 'package:musicplayer/src/l10n/context_l10n_extension.dart';

/*
  Общая идея:
  1. Реализация панели управления плеером
  2. Отображение текущей станции
  3. Кнопка пауза/плей
*/

// Логика виджета
class BottomPanelSection extends StatelessWidget {
  const BottomPanelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: context.colors.onBackground,

      child: Consumer<PlayerService>(
        builder: (context, player, child) {
          // Параметры панели
          final station = player.state.currentStation;
          final isPlaying = player.state.isPlaying;
          final isLoading = player.state.isLoading;

          // Если станция не запущена пустая панель
          if (station == null) return const SizedBox.shrink();

          // Непосредственно панель
          return _PanelContents(
            titleKey: station.titleKey,
            imagePath: station.imagePath,
            isPlaying: isPlaying,
            isLoading: isLoading,
            onToggle: player.togglePlayPause,
            onNext: player.nextStation,
            onPrev: player.previousStation,
            songTitle: player.state.currentSong?.title,
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
    required this.imagePath,
    required this.isPlaying,
    required this.isLoading,
    required this.onToggle,
    required this.onNext,
    required this.onPrev,
    this.songTitle,
  });

  final String titleKey;
  final String? imagePath;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onToggle;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final String? songTitle;

  @override
  Widget build(BuildContext context) {
    final displayTitle = songTitle?.isNotEmpty == true
        ? songTitle!
        : context.l10n.byKey(titleKey);

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(14),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),

        child: Row(
          children: [
            // Иконка станции
            CircleAvatar(
              radius: 22,
              backgroundImage: imagePath != null ? AssetImage(imagePath!) : null,
              child: imagePath == null ? const Icon(Icons.album) : null,
            ),

            const SizedBox(width: 12),

            // Название станции
            Expanded(
              child: Text(
                displayTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Кнопки управления плеером
            _buildControls(context),
          ],
        ),
      ),
    );
  }

  // Кнопки управления плеером
  Widget _buildControls(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Назад
        IconButton(
          onPressed: onPrev,
          icon: const Icon(Icons.skip_previous),
          iconSize: 30,
        ),

        // Пауза/плей
        isLoading
            ? const SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : IconButton(
          iconSize: 34,
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: onToggle,
        ),

        // Вперёд
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.skip_next),
          iconSize: 30,
        ),
      ],
    );
  }
}