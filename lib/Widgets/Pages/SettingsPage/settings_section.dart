import 'package:flutter/material.dart';
import 'package:musicplayer/Widgets/Pages/SettingsPage/settings_interface.dart';
import 'package:musicplayer/Widgets/Pages/SettingsPage/settings_playback.dart';

class SettingsSection {
  final String title;
  final IconData icon;
  final List<Widget> children;

  SettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });
}

final sections = <SettingsSection>[
  // Интерфейс
  SettingsSection(
    title: "Интерфейс",
    icon: Icons.palette,
    children: [
      SettingsInterface(),
    ],
  ),
  // Плеер
  SettingsSection(
    title: "Плеер",
    icon: Icons.radio,
    children: [
      SettingsPlayback(),
    ],
  ),
];