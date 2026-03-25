import 'package:flutter/material.dart';

/*
  Общая идея:
  AppColors расширяет стандартную тему ThemeData пользовательскими цветами
  1. Хранит основные цвета приложения
  2. Обеспечивает создание новых версий через copyWith
  3. Поддерживает интерполяцию цветов для анимации смены темы
*/

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color accent;
  final Color background;
  final Color onBackground;

  const AppColors({
    required this.primary,
    required this.accent,
    required this.background,
    required this.onBackground,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? accent,
    Color? background,
    Color? onBackground,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      accent: accent ?? this.accent,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      background: Color.lerp(background, other.background, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
    );
  }
}

// Расширение BuildContext для доступа к AppColors через ThemeData.extensions
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}