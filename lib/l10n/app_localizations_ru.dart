// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Flac Radio';

  @override
  String get rockRadio => 'Рок радио';

  @override
  String get metalRadio => 'Метал радио';

  @override
  String get jazzRadio => 'Джаз радио';

  @override
  String get electronicRadio => 'Электронное радио';

  @override
  String get error => 'Ошибка';

  @override
  String get noStations => 'Нет станций';

  @override
  String get copyLink => 'Скопировать ссылку';

  @override
  String get linkCopied => 'Ссылка скопирована';

  @override
  String get menu => 'Меню';

  @override
  String get settings => 'Настройки';

  @override
  String get about => 'О приложении';

  @override
  String get theme => 'Тема';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get language => 'Язык';

  @override
  String get player => 'Плеер';

  @override
  String get volume => 'Громкость';

  @override
  String get resetSettings => 'Сбросить настройки';

  @override
  String get doYouWantToResetTheSettings => 'Вы хотите сбросить настройки?';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get settingsResetWarning => 'Не сбрасывайте настройки 7 раз подряд!';

  @override
  String get stopAudioWhenMinimizingTheApplication => 'Останавливать аудио при сворачивании приложения';

  @override
  String get aboutGreetings => 'Всем привет!';

  @override
  String get aboutPageContent => 'Меня зовут Иван, я разработчик приложения Flac Radio.\nЯ создал это приложение как учебный проект, по тому что люблю слушать музыку и хочу чтоб музыку слушали все без каких-либо ограничений. Также я хочу выразить благодарность своему брату за сервер с музыкой. Не хочу много тут писать.';

  @override
  String get aboutEnjoy => 'Настаждайтесь музыкой!';

  @override
  String get aboutLinks => 'Ссылки:';

  @override
  String get aboutGithub => 'Project GitHub';

  @override
  String get aboutSupport => 'Поддержите проект на Patreon';
}
