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
  final Uri streamUrl;
  final String? description;
  final String? imageUrl;

  // Конструктор с обязательными и необязательными полями
  const RadioStation({
    required this.id,
    required this.title,
    required this.streamUrl,
    this.description,
    this.imageUrl,
  });
}