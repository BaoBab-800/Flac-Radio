import 'package:flutter/material.dart';
import 'package:musicplayer/data/radio_stations.dart';

// Нижняя панель плеера, отображает текущую станцию и кнопку Play/Pause
class BottomPanelOfThePlayer extends StatelessWidget {
  final RadioStation? currentStation;     // Текущая станция
  final bool isPlaying;                   // Флаг состояния плеера
  final VoidCallback onPlayPausePressed;  // Callback на нажатие play/pause

  const BottomPanelOfThePlayer({
    super.key,
    required this.currentStation,
    required this.isPlaying,
    required this.onPlayPausePressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 72, // Фиксированная высота нижней панели
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Левая секция с информацией о радиостанции
            _LeftSection(currentStation: currentStation),
            // Правая секция с кнопкой управления плеером
            _RightSection(
              isPlaying: isPlaying,
              onPlayPausePressed: onPlayPausePressed,
            ),
          ],
        ),
      ),
    );
  }
}

// Левая часть панели с информацией о текущей радиостанции
class _LeftSection extends StatelessWidget {
  final RadioStation? currentStation;

  const _LeftSection({super.key, this.currentStation});

  @override
  Widget build(BuildContext context) {
    // Если станция ещё не выбрана, отображается заглушка
    if (currentStation == null) {
      return const SizedBox(
        width: 150,
        child: Text("Выберите станцию"),
      );
    }

    // Отображение иконки и информации о станции
    return Row(
      children: [
        Icon(currentStation!.icon, size: 48), // Иконка станции
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Название станции жирным текстом
            Text(
              currentStation!.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // Описание станции серым цветом
            Text(
              currentStation!.description,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

// Правая часть панели с кнопкой Play/Pause
class _RightSection extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPausePressed;

  const _RightSection({
    super.key,
    required this.isPlaying,
    required this.onPlayPausePressed,
  });

  @override
  Widget build(BuildContext context) {
    // Кнопка управления воспроизведением
    return IconButton(
      iconSize: 32,
      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
      onPressed: onPlayPausePressed,
    );
  }
}