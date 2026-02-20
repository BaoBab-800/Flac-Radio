import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'settings/global_settings_service.dart';
import 'player/player_service.dart';
import 'theme/theme_service.dart';
import 'localization/localization_service.dart';

/// Получить SettingsService через watch (для UI)
GlobalSettingsService watchGlobalSettings(BuildContext context) => context.watch<GlobalSettingsService>();
GlobalSettingsService readGlobalSettings(BuildContext context) => context.read<GlobalSettingsService>();

/// Получить PlayerService
PlayerService watchPlayer(BuildContext context) => context.watch<PlayerService>();
PlayerService readPlayer(BuildContext context) => context.read<PlayerService>();

/// Получить ThemeService
ThemeService watchTheme(BuildContext context) => context.watch<ThemeService>();
ThemeService readTheme(BuildContext context) => context.read<ThemeService>();

LocalizationService watchLocalization(BuildContext context) => context.watch<LocalizationService>();
LocalizationService readLocalization(BuildContext context) => context.read<LocalizationService>();