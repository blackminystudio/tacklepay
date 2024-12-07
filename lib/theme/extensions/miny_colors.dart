import 'package:flutter/material.dart';
import '../tokens/color_tokens.dart';

class MinyColors extends ThemeExtension<MinyColors> {
  final Color primary;
  final Color primaryDark;
  final Color secondary;
  final Color secondaryDark;
  final Color contrastDark;
  final Color contrastMedium;
  final Color contrastLow;
  final Color contrastLight;
  final Color light;
  final Color dark;

  const MinyColors({
    this.primary = ColorTokens.primary,
    this.primaryDark = ColorTokens.primaryDark,
    this.secondary = ColorTokens.secondary,
    this.secondaryDark = ColorTokens.secondaryDark,
    this.contrastDark = ColorTokens.contrastDark,
    this.contrastMedium = ColorTokens.contrastMedium,
    this.contrastLow = ColorTokens.contrastLow,
    this.contrastLight = ColorTokens.contrastLight,
    this.light = ColorTokens.light,
    this.dark = ColorTokens.dark,
  });

  @override
  MinyColors copyWith({
    Color? primary,
    Color? primaryDark,
    Color? secondary,
    Color? secondaryDark,
    Color? contrastDark,
    Color? contrastMedium,
    Color? contrastLow,
    Color? contrastLight,
    Color? light,
    Color? dark,
  }) =>
      MinyColors(
        primary: primary ?? this.primary,
        primaryDark: primaryDark ?? this.primaryDark,
        secondary: secondary ?? this.secondary,
        secondaryDark: secondaryDark ?? this.secondaryDark,
        contrastDark: contrastDark ?? this.contrastDark,
        contrastMedium: contrastMedium ?? this.contrastMedium,
        contrastLow: contrastLow ?? this.contrastLow,
        contrastLight: contrastLight ?? this.contrastLight,
        light: light ?? this.light,
        dark: dark ?? this.dark,
      );

  @override
  ThemeExtension<MinyColors> lerp(ThemeExtension<MinyColors>? other, double t) {
    if (other is! MinyColors) return this;

    return MinyColors(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryDark: Color.lerp(secondaryDark, other.secondaryDark, t)!,
      contrastDark: Color.lerp(contrastDark, other.contrastDark, t)!,
      contrastMedium: Color.lerp(contrastMedium, other.contrastMedium, t)!,
      contrastLow: Color.lerp(contrastLow, other.contrastLow, t)!,
      contrastLight: Color.lerp(contrastLight, other.contrastLight, t)!,
      light: Color.lerp(light, other.light, t)!,
      dark: Color.lerp(dark, other.dark, t)!,
    );
  }
}
