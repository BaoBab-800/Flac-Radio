import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/src/services/theme/theme_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:musicplayer/src/data/radio/repository/local_radio_station_repository.dart';
import 'package:musicplayer/src/data/radio/repository/radio_station_repository.dart';
import 'package:musicplayer/src/features/main/sections/feed/radio_station_feed_vm.dart';
import 'package:musicplayer/src/core/settings/settings_repository.dart';
import 'package:musicplayer/src/core/settings/shared_prefs_settings_repository.dart';
import 'package:musicplayer/src/services/player/player_service.dart';
import 'package:musicplayer/src/services/player/player_contracts.dart';
import 'package:musicplayer/src/services/settings/settings_service.dart';
import 'package:musicplayer/src/services/url/url_launcher_service.dart';
import 'package:musicplayer/src/services/settings/app_lifecycle_service.dart';
import 'package:musicplayer/src/services/settings/mysterious_page_service.dart';
import 'package:musicplayer/src/services/settings/background_playback_policy.dart';

/*
  Общая идея:
  Список провайдеров приложения
  1. Создаёт и связывает сервисы и репозитории
  2. Управляет жизненным циклом зависимостей
  3. Обеспечивает доступ к зависимостям через Provider
*/

List<SingleChildWidget> buildAppProviders({
  required bool backgroundAudioEnabled,
}) => [
  Provider<AudioPlayer>(
    create: (_) => AudioPlayer(),
    dispose: (_, player) => player.dispose(),
  ),

  ChangeNotifierProvider<PlayerService>(
    create: (context) => PlayerService(
      context.read<AudioPlayer>(),
      backgroundAudioEnabled: backgroundAudioEnabled,
    ),
  ),

  ListenableProvider<PlayerStateReader>(
    create: (context) => context.read<PlayerService>(),
  ),

  Provider<PlayerControls>(
    create: (context) => context.read<PlayerService>(),
  ),

  Provider<RadioStationRepository>(
    create: (_) => LocalRadioStationRepository(),
  ),

  Provider<SettingsRepository>(
    create: (_) => const SharedPrefsSettingsRepository(),
  ),

  // Инициализация настроек при создании
  ChangeNotifierProvider<SettingsService>(
    create: (context) => SettingsService(
      context.read<SettingsRepository>(),
    )..init(),
  ),

  ChangeNotifierProvider<ThemeController>(
    create: (context) => ThemeController(
      context.read<SettingsService>(),
    ),
  ),

  ChangeNotifierProvider<RadioStationFeedViewModel>(
    create: (context) => RadioStationFeedViewModel(
      repository: context.read<RadioStationRepository>(),
      playerService: context.read<PlayerService>(),
    ),
  ),

  Provider<UrlLauncherService>(
    create: (_) => UrlLauncherService(),
  ),

  Provider<MysteriousPageService>(
    create: (_) => MysteriousPageService(),
  ),

  Provider<MysteriousPageService>(
    create: (_) => MysteriousPageService(),
  ),

  Provider<BackgroundPlaybackPolicy>(
    create: (context) => SettingsBackgroundPlaybackPolicy(
      context.read<SettingsService>(),
    ),
  ),

  // Создание при старте приложения
  Provider(
    create: (context) => AppLifecycleService(
      context.read<PlayerControls>(),
      context.read<BackgroundPlaybackPolicy>(),
    ),
    dispose: (_, service) => service.dispose(),
    lazy: false,
  ),
];
