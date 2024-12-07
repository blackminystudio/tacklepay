import 'package:flutter/material.dart';
import '../tokens/elevation_tokens.dart';

class MinyElevation extends ThemeExtension<MinyElevation> {
  final BoxShadow e1;
  const MinyElevation({
    this.e1 = ElevationTokens.e1,
  });

  @override
  ThemeExtension<MinyElevation> copyWith({final BoxShadow? e1}) =>
      MinyElevation(e1: e1 ?? this.e1);

  @override
  ThemeExtension<MinyElevation> lerp(
      ThemeExtension<MinyElevation>? other, final double t) {
    if (other is! MinyElevation) {
      return this;
    }
    return MinyElevation(
      e1: BoxShadow.lerp(
            e1,
            other.e1,
            t,
          ) ??
          e1,
    );
  }
}
