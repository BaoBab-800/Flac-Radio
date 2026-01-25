import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:file_picker/file_picker.dart';

final player = AudioPlayer(); // Создание плеера

// Запуск плеера
Future<void> playFromServer(String streamUrl) async {
  await player.setUrl(streamUrl);
  player.play();
}

// Остановка плеера
Future<void> stopPlayer() async {
  await player.stop();
}

// Функция выбора и воспроизвидения файла (пока не используется)
Future<void> pickAndPlay() async {
  // Открывает диалог выбора файла и ждёт пока пользователь выберет файл
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['flac', 'mp3', 'wav'],
  );

  if (result == null) return; // Если пользователь отменил выбор - функция ничего не вернёт

  // Путь к единственному выбранному файлу
  final path = result.files.single.path!;
  print('FILE PATH: $path');  // Для отладки (потом уберу)

  // Тоже для отладки
  final file = File(path);
  print('EXISTS: ${await file.exists()}');

  await player.setFilePath(path); // Загрузка файла в плеер
  await player.play();  // Непосредственно проигрывание
}