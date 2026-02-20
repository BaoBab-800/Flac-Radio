import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:musicplayer/src/data/radio/radio_stations_repository.dart';
import 'package:musicplayer/src/services/localization/localization_service.dart';
import 'package:musicplayer/src/services/other/app_lifecycle_service.dart';
import 'package:musicplayer/src/services/player/player_service.dart';
import 'package:musicplayer/src/services/settings/global_settings_service.dart';
import 'package:musicplayer/src/data/theme/shared_prefs_theme_settings_store.dart';
import 'package:musicplayer/src/services/theme/theme_service.dart';
import 'package:musicplayer/src/services/theme/theme_settings_store.dart';

// Глобальные провайдеры приложения
final List<SingleChildWidget> appProviders = [
  // Базовые зависимости
  Provider(create: (_) => RadioStationsRepository()),
  Provider<AudioPlayer>(
    create: (_) => AudioPlayer(),
    dispose: (_, player) => player.dispose(),
  ),

  // Сервисы состояния
  Provider<ThemeSettingsStore>(create: (_) => SharedPrefsThemeSettingsStore()),
  ChangeNotifierProvider(
    create: (context) => ThemeService(context.read<ThemeSettingsStore>()),
  ),
  ChangeNotifierProvider(create: (_) => LocalizationService()),
  ChangeNotifierProvider(create: (_) => GlobalSettingsService()),
  ChangeNotifierProvider(
    create: (context) => PlayerService(context.read<AudioPlayer>()),
  ),

  // Сервис жизненного цикла
  Provider<AppLifecycleService>(
    lazy: false,
    create: (context) => AppLifecycleService(
      context.read<PlayerService>(),
      context.read<GlobalSettingsService>(),
    ),
    dispose: (_, lifecycle) => lifecycle.dispose(),
  ),
];