import 'package:flutter/cupertino.dart';

/*
  Общая идея:
  RadioStation представляет одну радиостанцию в приложении
  1. Хранит уникальный идентификатор и название станции
  2. Хранит URL потока для воспроизведения
  3. Может хранить необязательное описание и изображение станции
  4. Используется для отображения списка станций и управления воспроизведением
*/

class RadioStation {
  final String id;
  final String title;
  final String? description;
  final Uri streamUrl;
  final Uri? imageUrl;

  // Конструктор с обязательными и необязательными полями
  const RadioStation({
    required this.id,
    required this.title,
    required this.streamUrl,
    this.description,
    this.imageUrl,
  });
}