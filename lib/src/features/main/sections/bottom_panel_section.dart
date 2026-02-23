import 'package:flutter/material.dart';
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
            imageUrl: station.imageUrl,
            isPlaying: isPlaying,
            isLoading: isLoading,
            onToggle: player.togglePlayPause,
            onNext: player.nextStation,
            onPrev: player.previousStation,
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
    required this.imageUrl,
    required this.isPlaying,
    required this.isLoading,
    required this.onToggle,
    required this.onNext,
    required this.onPrev,
  });

  final String titleKey;
  final Uri? imageUrl;
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onToggle;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: Row(
        children: [
          // Иконка станции
          CircleAvatar(
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl.toString()) : null,
            child: imageUrl == null ? Icon(Icons.album) : null,
          ),

          const SizedBox(width: 16),

          // Название станции
          Text(
            context.l10n.byKey(titleKey),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),

          Spacer(),

          // Кнопки управления плеером
          Row(
            children: [
              // Назад
              IconButton(
                onPressed: onPrev,
                icon: Icon(Icons.arrow_left, size: 36),
              ),

              // Плей/пауза
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

              // Вперёд
              IconButton(
                onPressed: onNext,
                icon: Icon(Icons.arrow_right, size: 36),
              ),
            ],
          ),
        ],
      ),
    );
  }
}