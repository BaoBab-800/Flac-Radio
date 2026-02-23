// Список возможных ошибок (не забыть при надобности расширить)
enum AppError {
  playbackStart,    // Не удалось запустить поток
  playbackControl,  // Ошибка play/pause/stop
  network,          // Ошибка работы с сетью
  unknown,          // Неизвестная ошибка
}