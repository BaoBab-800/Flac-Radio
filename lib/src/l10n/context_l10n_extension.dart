import 'package:flutter/widgets.dart';
import 'package:musicplayer/l10n/app_localizations.dart';

extension LocalizationX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension AppLocalizationsX on AppLocalizations {
  String byKey(String key) {
    final map = <String, String>{
      'appTitle': appTitle,

      'rockRadio': rockRadio,
      'metalRadio': metalRadio,
      'jazzRadio': jazzRadio,
      'electronicRadio': electronicRadio,

      'error': error,
      'noStations': noStations,

      'copyLink': copyLink,
      'linkCopied': linkCopied,

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

      'stopAudioWhenMinimizingTheApplication': stopAudioWhenMinimizingTheApplication,

      'aboutGreetings': aboutGreetings,
      'aboutPageContent': aboutPageContent,
      'aboutEnjoy': aboutEnjoy,
      'aboutLinks': aboutLinks,
      'aboutGithub': aboutGithub,
      'aboutSupport': aboutSupport,
    };
    // Привет неизвестный читатель! Как ты дошёл до того что читаешь мой код? Да, иногда выглядит действительно не очень
    return map[key] ?? key;
  }
}
