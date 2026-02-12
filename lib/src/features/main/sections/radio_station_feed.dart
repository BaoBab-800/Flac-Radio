import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:musicplayer/src/data/radio/models/radio_station.dart';
import 'package:musicplayer/src/data/radio/repository/local_radio_station_repository.dart';
import 'package:musicplayer/src/services/player/player_service.dart';

/*
  Общая идея:
  RadioStationFeed отображает список всех радиостанций
  1. Загружает станции из LocalRadioStationRepository при инициализации
  2. Отображает состояние загрузки, ошибки или пустого списка
  3. При выборе станции вызывает PlayerService для воспроизведения
*/

class RadioStationFeed extends StatefulWidget {
  const RadioStationFeed({super.key});

  @override
  State<RadioStationFeed> createState() => _RadioStationFeedState();
}

class _RadioStationFeedState extends State<RadioStationFeed> {
  late final Future<List<RadioStation>> _stationsFuture; // Ленивая загрузка списка станций

  @override
  void initState() {
    super.initState();
    // Получение всех станций из локального репозитория при инициализации состояния
    _stationsFuture =
        context.read<LocalRadioStationRepository>().getAllStations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RadioStation>>(
      future: _stationsFuture,
      builder: (context, snapshot) {
        // Состояние загрузки
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildLoading();
        }

        // Состояние ошибки
        if (snapshot.hasError) {
          return _buildError(snapshot.error);
        }

        final stations = snapshot.data;

        // Пустой список станций
        if (stations == null || stations.isEmpty) {
          return _buildEmpty();
        }

        // Список станций готов к отображению
        return _buildList(stations);
      },
    );
  }

  // Индикатор загрузки
  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  // Виджет для отображения ошибки
  Widget _buildError(Object? error) {
    return Center(
      child: Text('Ошибка: $error'),
    );
  }

  // Виджет для отображения пустого списка
  Widget _buildEmpty() {
    return const Center(
      child: Text('Нет станций'),
    );
  }

  // Список станций через ListView.builder
  Widget _buildList(List<RadioStation> stations) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];

        return RadioStationTile(
          station: station,
          // Вызов плеера при нажатии на элемент списка
          onTap: () => context.read<PlayerService>().play(station),
        );
      },
    );
  }
}

// Tile для отображения отдельной радиостанции
class RadioStationTile extends StatelessWidget {
  const RadioStationTile({
    super.key,
    required this.station,
    required this.onTap,
  });

  final RadioStation station;   // Модель радиостанции
  final VoidCallback onTap;     // Обработчик нажатия на элемент списка

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Название станции
      title: Text(
        station.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // Аватар станции
      // 1. Если есть imageUrl отображается изображение из сети
      // 2. Если imageUrl отсутствует - иконка по умолчанию
      leading: station.imageUrl != null
          ? CircleAvatar(
        backgroundImage: NetworkImage(
          station.imageUrl!.toString(),
        ),
      )
          : const CircleAvatar(
        child: Icon(Icons.album),
      ),

      // Обработка нажатия
      onTap: onTap,
    );
  }
}