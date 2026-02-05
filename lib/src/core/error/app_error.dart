// список возможных ошибок (не забудь при надобности расширить)
enum AppError {
  playbackStart,    // не удалось запустить поток
  playbackControl,  // ошибка play/pause/stop
  network,          // ошибка работы с сетью
  unknown,          // неизвестная ошибка
}