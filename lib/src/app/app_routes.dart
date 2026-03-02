import 'package:flutter/material.dart';

import 'package:musicplayer/src/features/main/main_page_builder.dart';
import 'package:musicplayer/src/features/settings/settings_page_builder.dart';
import 'package:musicplayer/src/features/about/about.dart';
import 'package:musicplayer/src/features/other/mysterious_page.dart';
import 'package:musicplayer/src/features/other/developer_room/developer_room_builder.dart';
import 'package:musicplayer/src/features/other/test_page.dart';

// Список маршрутов
enum AppRoute {
  main,
  settings,
  about,
  mysteriousPage,
  developerRoom,
  testPage
}

// Свич для удобства
extension AppRoutePath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.main:
        return '/';
      case AppRoute.settings:
        return '/settings';
      case AppRoute.about:
        return '/about';
      case AppRoute.mysteriousPage:
        return '/mysteriousPage';
      case AppRoute.developerRoom:
        return '/developerRoom';
      case AppRoute.testPage:
        return '/testPage';
    }
  }
}

// Инициализация путей
class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    AppRoute.main.path: (_) => const MainPageBuilder(),
    AppRoute.settings.path: (_) => const SettingsPageBuilder(),
    AppRoute.about.path: (_) => const About(),
    AppRoute.mysteriousPage.path: (_) => const MysteriousPage(),
    AppRoute.developerRoom.path: (_) => const DeveloperRoomBuilder(),
    AppRoute.testPage.path: (_) => const TestPage(),
  };
}