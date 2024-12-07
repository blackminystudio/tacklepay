import 'dart:ui';
import 'package:flutter/material.dart';
import '../tokens/border_width_tokens.dart';

class MinyBorderWidth extends ThemeExtension<MinyBorderWidth> {
  final double none;
  final double small;
  final double medium;
  final double large;

  const MinyBorderWidth({
    this.none = BorderWidthTokens.none,
    this.small = BorderWidthTokens.small,
    this.medium = BorderWidthTokens.medium,
    this.large = BorderWidthTokens.large,
  });
  @override
  ThemeExtension<MinyBorderWidth> copyWith({
    final double? none,
    final double? small,
    final double? medium,
    final double? large,
  }) =>
      MinyBorderWidth(
        none: none ?? this.none,
        small: small ?? this.small,
        medium: medium ?? this.medium,
        large: large ?? this.large,
      );

  @override
  ThemeExtension<MinyBorderWidth> lerp(
    final ThemeExtension<MinyBorderWidth>? other,
    final double t,
  ) {
    if (other is! MinyBorderWidth) {
      return this;
    }
    return MinyBorderWidth(
      none: lerpDouble(none, other.none, t) ?? none,
      small: lerpDouble(small, other.small, t) ?? small,
      medium: lerpDouble(medium, other.medium, t) ?? medium,
      large: lerpDouble(large, other.large, t) ?? large,
    );
  }
}
