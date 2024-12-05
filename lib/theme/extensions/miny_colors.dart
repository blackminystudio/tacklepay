// lib/theme/extensions/miny_colors.dart

import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';

class MinyColors extends ThemeExtension<MinyColors> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color error;

  const MinyColors({
    this.primary = ColorTokens.primary,
    this.secondary = ColorTokens.secondary,
    this.background = ColorTokens.background,
    this.error = ColorTokens.error,
  });

  @override
  MinyColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? error,
  }) =>
      MinyColors(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        background: background ?? this.background,
        error: error ?? this.error,
      );

  @override
  ThemeExtension<MinyColors> lerp(ThemeExtension<MinyColors>? other, double t) {
    if (other is! MinyColors) return this;

    return MinyColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
