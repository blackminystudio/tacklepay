import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../tokens/spacing_tokens.dart';

class MinySpacing extends ThemeExtension<MinySpacing> {
  final SpacingDimensions width;
  final SpacingDimensions height;

  MinySpacing()
      : width = SpacingDimensions(scale: (value) => value.w),
        height = SpacingDimensions(scale: (value) => value.h);

  @override
  MinySpacing copyWith({
    SpacingDimensions? width,
    SpacingDimensions? height,
  }) =>
      MinySpacing();

  @override
  MinySpacing lerp(ThemeExtension<MinySpacing>? other, double t) {
    if (other is! MinySpacing) {
      return this;
    }
    return MinySpacing();
  }
}

class SpacingDimensions {
  final double Function(double) scale;

  SpacingDimensions({required this.scale});

  double get s0 => scale(SpacingTokens.s0);
  double get s1 => scale(SpacingTokens.s1);
  double get s2 => scale(SpacingTokens.s2);
  double get s4 => scale(SpacingTokens.s4);
  double get s8 => scale(SpacingTokens.s8);
  double get s10 => scale(SpacingTokens.s10);
  double get s12 => scale(SpacingTokens.s12);
  double get s16 => scale(SpacingTokens.s16);
  double get s20 => scale(SpacingTokens.s20);
  double get s24 => scale(SpacingTokens.s24);
  double get s32 => scale(SpacingTokens.s32);
  double get s40 => scale(SpacingTokens.s40);
  double get s48 => scale(SpacingTokens.s48);
  double get s56 => scale(SpacingTokens.s56);
  double get s64 => scale(SpacingTokens.s64);
  double get s72 => scale(SpacingTokens.s72);
  double get s80 => scale(SpacingTokens.s80);
}
