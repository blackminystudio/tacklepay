import 'dart:ui';
import 'package:flutter/material.dart';
import '../tokens/opacity_tokens.dart';

class MinyOpacity extends ThemeExtension<MinyOpacity> {
  final double o4;
  final double o5;
  final double o8;
  final double o11;
  final double o12;
  final double o14;
  final double o24;
  final double o38;
  final double o40;
  final double o48;
  final double o60;
  final double o72;

  const MinyOpacity({
    this.o4 = OpacityTokens.o4,
    this.o5 = OpacityTokens.o5,
    this.o8 = OpacityTokens.o8,
    this.o11 = OpacityTokens.o11,
    this.o12 = OpacityTokens.o12,
    this.o14 = OpacityTokens.o14,
    this.o24 = OpacityTokens.o24,
    this.o38 = OpacityTokens.o38,
    this.o40 = OpacityTokens.o40,
    this.o48 = OpacityTokens.o48,
    this.o60 = OpacityTokens.o60,
    this.o72 = OpacityTokens.o72,
  });

  @override
  ThemeExtension<MinyOpacity> copyWith({
    final double? o4,
    final double? o5,
    final double? o8,
    final double? o11,
    final double? o12,
    final double? o14,
    final double? o24,
    final double? o38,
    final double? o40,
    final double? o48,
    final double? o60,
    final double? o72,
  }) =>
      MinyOpacity(
        o4: o4 ?? this.o4,
        o5: o5 ?? this.o5,
        o8: o8 ?? this.o8,
        o11: o11 ?? this.o11,
        o12: o12 ?? this.o12,
        o14: o14 ?? this.o14,
        o24: o24 ?? this.o24,
        o38: o38 ?? this.o38,
        o40: o40 ?? this.o40,
        o48: o48 ?? this.o48,
        o60: o60 ?? this.o60,
        o72: o72 ?? this.o72,
      );

  @override
  ThemeExtension<MinyOpacity> lerp(
      final ThemeExtension<MinyOpacity>? other, final double t) {
    if (other is! MinyOpacity) {
      return this;
    }
    return MinyOpacity(
      o4: lerpDouble(o4, other.o4, t) ?? o4,
      o5: lerpDouble(o5, other.o5, t) ?? o5,
      o8: lerpDouble(o8, other.o8, t) ?? o8,
      o11: lerpDouble(o11, other.o11, t) ?? o11,
      o12: lerpDouble(o12, other.o12, t) ?? o12,
      o14: lerpDouble(o14, other.o14, t) ?? o14,
      o24: lerpDouble(o24, other.o24, t) ?? o24,
      o38: lerpDouble(o38, other.o38, t) ?? o38,
      o40: lerpDouble(o40, other.o40, t) ?? o40,
      o48: lerpDouble(o48, other.o48, t) ?? o48,
      o60: lerpDouble(o60, other.o60, t) ?? o60,
      o72: lerpDouble(o72, other.o72, t) ?? o72,
    );
  }
}
