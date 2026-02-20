import 'package:flutter/widgets.dart';
import 'package:musicplayer/l10n/app_localizations.dart';

extension LocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension AppLocalizationsX on AppLocalizations {
  String byKey(String key) {
    final map = <String, String>{
      'rockRadio': rockRadio,
      'metalRadio': metalRadio,
      'jazzRadio': jazzRadio,
      'popRadio': popRadio,
      'theme': theme,
      'language': language,
      'sorting': sorting,
      'secureStation': secureStation,
      'menu': menu,
      'settings': settings,
      'about': about,
      'player': player,
      'volume': volume,
      'resetSettings': resetSettings,
      'stopAudioWhenMinimizingTheApplication': stopAudioWhenMinimizingTheApplication,
      'aboutPageContent': aboutPageContent,
    };
    return map[key] ?? key;
  }
}