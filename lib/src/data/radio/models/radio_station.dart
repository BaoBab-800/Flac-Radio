/*
  Общая идея:
  RadioStation представляет одну радиостанцию в приложении
  1. Хранит уникальный идентификатор и название станции
  2. Хранит URL потока для воспроизведения
  3. Может хранить необязательное изображение станции
  4. Используется для отображения списка станций и управления воспроизведением
*/

class RadioStation {
  final String id;
  final String titleKey;
  final Uri streamUrl;
  final String? imagePath;

  // Конструктор с обязательными и необязательными полями
  const RadioStation({
    required this.id,
    required this.titleKey,
    required this.streamUrl,
    this.imagePath,
  });
}