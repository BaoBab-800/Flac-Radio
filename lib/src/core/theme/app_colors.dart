import 'package:flutter/material.dart';

@immutable
// Расширение темы для хранения пользовательских цветов,
// которые не входят в стандартный ColorScheme
class AppColors extends ThemeExtension<AppColors> {
  // Основной цвет приложения
  final Color primary;
  // Акцентный цвет для выделения элементов интерфейса
  final Color accent;
  // Цвет фона приложения
  final Color background;
  // Цвет для выделения элементов на фоне
  final Color onBackground;

  // Неизменяемая модель цветов темы
  const AppColors({
    required this.primary,
    required this.accent,
    required this.background,
    required this.onBackground,
  });

  @override
  // Создание новой версии объекта с частичным изменением полей
  // Используется системой тем при обновлении ThemeData
  AppColors copyWith({Color? primary, Color? accent, Color? background, Color? onBackground}) {
    return AppColors(
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
    );
  }

  @override
  // Линейная интерполяция цветов между двумя темами
  // Используется при анимации смены темы
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    // Защита от несовместимого типа расширения
    if (other is! AppColors) return this;

    return AppColors(
      // Интерполяция каждого цвета отдельно
      primary: Color.lerp(primary, other.primary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
    );
  }
}

// Расширение BuildContext для удобного доступа к AppColors через Theme
extension AppColorsX on BuildContext {
  // Получение пользовательских цветов из ThemeData.extensions
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}