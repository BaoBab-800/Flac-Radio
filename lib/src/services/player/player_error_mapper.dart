import 'package:musicplayer/src/core/error/app_error.dart';

// Преобразует исключения инфраструктуры плеера в ошибки домена приложения.
class PlayerErrorMapper {
  const PlayerErrorMapper();

  AppError mapStartError(Object error) {
    return AppError.playbackStart;
  }

  AppError mapControlError(Object error) {
    return AppError.playbackControl;
  }
}
