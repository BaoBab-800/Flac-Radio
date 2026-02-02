import 'package:flutter/material.dart';

class RadioStation {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Uri streamUrl;

  RadioStation({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.streamUrl,
  });
}