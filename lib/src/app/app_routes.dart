import 'package:flutter/material.dart';

import 'package:musicplayer/src/features/main/main_page_builder.dart';
import 'package:musicplayer/src/features/settings/settings_page_builder.dart';
import 'package:musicplayer/src/features/about/about.dart';

enum AppRoute {
  main,
  settings,
  about,
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
    }
  }
}

class AppRoutes {
  static final routes = <String, WidgetBuilder>{
    AppRoute.main.path: (_) => const MainPageBuilder(),
    AppRoute.settings.path: (_) => const SettingsPageBuilder(),
    AppRoute.about.path: (_) => const About(),
  };
}