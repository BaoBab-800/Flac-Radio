import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/Services/player_logic.dart';
import 'package:musicplayer/data/radio_stations.dart';
import 'package:musicplayer/data/song_model.dart';
import 'package:musicplayer/Services/accept_JSON.dart';

final currentStation = radioStations.first;

// Нижняя панель плеера
class BottomPanelOfThePlayer extends StatefulWidget {
  const BottomPanelOfThePlayer({super.key});

  @override
  _BottomPanelOfThePlayerState createState() => _BottomPanelOfThePlayerState();
}

class _BottomPanelOfThePlayerState extends State<BottomPanelOfThePlayer> {
  late Future<Song> futureSong;

  @override
  void initState() {
    super.initState();
    futureSong = fetchCurrentSongFromFile();
  }

  // TODO: Когда отдохну сделать тут красоту
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 72,
      child: FutureBuilder<Song>(
        future: futureSong,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Ошибка: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // PlayerPanel(song: snapshot.data!),
                _CurrentRadioStation(),
                _RightSection(),
              ],
            );
          } else {
            return Text('Нет данных');
          }
        },
      ),
    );
  }
}

// Левая часть с информацией о текущей песне
class PlayerPanel extends StatefulWidget {
  final Song song;
  const PlayerPanel({super.key, required this.song});

  @override
  _PlayerPanelState createState() => _PlayerPanelState();
}

class _PlayerPanelState extends State<PlayerPanel> {
  @override
  Widget build(BuildContext context) {
    final song = widget.song;

    return Row(
      children: [
        // Если есть картика то расшифровать
        if (song.iconBytes != null) Image.memory(
          song.iconBytes!,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        )
        // Если нема то показать иконку альбома
        else Icon(Icons.album, size: 42),
        const SizedBox(width: 8),
        // Название песни и автор
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(song.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(song.artist),
          ],
        ),
      ],
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

class _CurrentRadioStation extends StatelessWidget {
  const _CurrentRadioStation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          currentStation.icon
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentStation.title),
            Text(currentStation.description),
          ],
        ),
      ],
    );
  }
}