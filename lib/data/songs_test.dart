import 'package:flutter/material.dart';

class SongsTest {
  final String title;
  final String author;
  final Duration duration;
  final IconData icon;

  const SongsTest({
    required this.title,
    required this.author,
    required this.duration,
    required this.icon,
  });
}

const songsTest = [
  SongsTest(
    title: "Bohemian Rhapsody",
    author: "Queen",
    duration: Duration(minutes: 5, seconds: 55),
    icon: Icons.play_arrow,
  ),
  SongsTest(
    title: "I Want To Break Free",
    author: "Queen",
    duration: Duration(minutes: 4, seconds: 18),
    icon: Icons.play_arrow,
  ),
  SongsTest(
    title: "Another One Bites the Dust",
    author: "Queen",
    icon: Icons.play_arrow,
    duration: Duration(minutes: 3, seconds: 35),
  ),
  SongsTest(
    title: "The Show Must Go On",
    author: "Queen",
    icon: Icons.play_arrow,
    duration: Duration(minutes: 4, seconds: 38),
  ),
  SongsTest(
    title: "Radio Ga Ga",
    author: "Queen",
    icon: Icons.play_arrow,
    duration: Duration(minutes: 5, seconds: 49),
  ),
  SongsTest(
    title: "These Are The Days Of Our Lives",
    author: "Queen",
    icon: Icons.play_arrow,
    duration: Duration(minutes: 4, seconds: 16),
  ),

  // УБРАТЬ
  SongsTest(
    title: "Пока работаем над дизайном",
    author: "Иван",
    icon: Icons.play_arrow,
    duration: Duration(minutes: 0, seconds: 00),
  )
];