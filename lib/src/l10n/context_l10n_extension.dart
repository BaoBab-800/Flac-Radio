import 'package:flutter/widgets.dart';
import 'package:musicplayer/l10n/app_localizations.dart';

extension LocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

// Преобразователь для удобства
extension AppLocalizationsX on AppLocalizations {
  String byKey(String key) {
    final map = <String, String>{
      'appTitle': appTitle,

      'rockRadio': rockRadio,
      'metalRadio': metalRadio,
      'jazzRadio': jazzRadio,
      'popRadio': popRadio,

      'sorting': sorting,
      'secureStation': secureStation,

      'menu': menu,
      'settings': settings,
      'about': about,

      'theme': theme,
      'themeLight': themeLight,
      'themeDark': themeDark,

      'language': language,

      'player': player,
      'volume': volume,

      'resetSettings': resetSettings,
      'doYouWantToResetTheSettings': doYouWantToResetTheSettings,
      'yes': yes,
      'no': no,
      'settingsResetWarning': settingsResetWarning,

      'stopAudioWhenMinimizingTheApplication':
      stopAudioWhenMinimizingTheApplication,

      'aboutGreetings': aboutGreetings,
      'aboutPageContent': aboutPageContent,
      'aboutEnjoy': aboutEnjoy,
      'aboutLinks': aboutLinks,
      'aboutGithub': aboutGithub,
      'aboutSupport': aboutSupport,
    };
    return map[key] ?? key;
  }
}