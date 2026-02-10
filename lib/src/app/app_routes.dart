import 'package:flutter/material.dart';
import 'package:musicplayer/src/features/settings/settings_page_builder.dart';

class AppRoutes {
  static const initial = '/';
  static const settings = '/settings';

  static final routes = <String, WidgetBuilder>{
    settings: (_) => const SettingsPageBuilder(),
  };
}