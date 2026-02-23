import 'package:flutter/material.dart';

import 'package:musicplayer/src/features/main/main_page_builder.dart';
import 'package:musicplayer/src/features/settings/settings_page_builder.dart';
import 'package:musicplayer/src/features/about/about.dart';
import 'package:musicplayer/src/features/mysterious_page.dart';

enum AppRoute {
  main,
  settings,
  about,
  mysteriousPage
}

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
    }
  }
}

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    AppRoute.main.path: (_) => const MainPageBuilder(),
    AppRoute.settings.path: (_) => const SettingsPageBuilder(),
    AppRoute.about.path: (_) => const About(),
    AppRoute.mysteriousPage.path: (_) => const MysteriousPage(),
  };
}