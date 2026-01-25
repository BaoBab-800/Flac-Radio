import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/Player/player_logic.dart';
import 'package:musicplayer/data/radio_stations.dart';

final currentStation = radioStations.first;

// Нижняя панель плеера
class BottomPanelOfThePlayer extends StatelessWidget {
  const BottomPanelOfThePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Левая часть с названием радио
          _LeftSection(),
          // Правая часть с кнопками управления плеером
          _RightSection(),
        ],
      ),
    );
  }
}

// Левая часть с названием радио
class _LeftSection extends StatelessWidget {
  const _LeftSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            // Иконка радиостанции
            Image.asset(
              "assets/test/album.png",
              width: 42,
              height: 42,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Название станции
                  Text(
                    currentStation.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Описание
                  Text(
                    currentStation.description,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Правая часть с кнопками управления плеером
class _RightSection extends StatelessWidget {
  const _RightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Кнопка переключить трек назад (пока не работает)
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_left, size: 32),
        ),
        // Кнопка пауза/плей
        IconButton(
          iconSize: 32,
          onPressed: () {
            if (player.playing) {
              player.pause();
            } else {
              player.play();
            }
          },
          icon: StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;

              return Icon(
                playing ? Icons.pause : Icons.play_arrow,
              );
            },
          ),
        ),
        // Кнопка переключить трек вперёд (тоже не работает)
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_right, size: 32),
        ),
      ],
    );
  }
}