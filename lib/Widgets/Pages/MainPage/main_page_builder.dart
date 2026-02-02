import 'package:flutter/material.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/bottom_panel_of_the_player.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/main_page_header.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/playlist_feed.dart';
import 'package:musicplayer/Widgets/Pages/MainPage/main_page_drawer.dart';
import 'package:musicplayer/Services/player_logic.dart';
import 'package:musicplayer/data/radio_stations.dart';
import 'package:musicplayer/data/local_radio_station_repository.dart';
import 'package:musicplayer/Themes/theme_helper.dart';

// Главный экран приложения.
// Объединяет список радиостанций, управление плеером и навигацию.
class MainPage extends StatefulWidget {
  final AppThemeOption currentTheme;          // Текущая тема приложения
  final ValueChanged<AppThemeOption> onThemeChange; // Callback для смены темы

  const MainPage({
    super.key,
    required this.currentTheme,
    required this.onThemeChange,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Источник данных с локально описанными радиостанциями
  final _repository = LocalRadioStationRepository();

  // Контроллер, инкапсулирующий всю логику работы с аудиоплеером
  final _playerController = PlayerController();

  // Текущий список радиостанций, отображаемый в ленте
  List<RadioStation> _stations = [];

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  // Загрузка списка радиостанций из репозитория
  // Используется при старте экрана и при ручном обновлении списка
  void _loadStations() {
    setState(() {
      _stations = _repository.getStations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Основной цвет фона берётся из темы приложения
      backgroundColor: Theme.of(context).colorScheme.surface,

      // Боковое меню приложения
      drawerEnableOpenDragGesture: false, // Отключение жеста открытия Drawer
      drawer: MainPageDrawer(
        currentTheme: _currentTheme,
        onThemeChange: _changeTheme,
      ),

      body: Column(
        children: [
          // Верхняя панель с названием и действиями (сортировка, обновление)
          Header(onUpdate: _loadStations),

          // Лента радиостанций, занимающая всё доступное пространство
          Expanded(
            child: PlaylistFeed(
              stations: _stations,
              currentStation: _playerController.currentStation,
              onStationTap: (station) {
                setState(() {
                  _playerController.selectStation(station);
                });
              },
            ),
          ),
        ],
      ),

      // Нижняя панель управления воспроизведением
      bottomNavigationBar: BottomPanelOfThePlayer(
        currentStation: _playerController.currentStation,
        isPlaying: _playerController.isPlaying,
        onPlayPausePressed: () {
          setState(() {
            _playerController.togglePlayPause();
          });
        },
      ),
    );
  }
}