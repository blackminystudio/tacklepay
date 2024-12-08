import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../tokens/sizing_tokens.dart';

class MinySizing extends ThemeExtension<MinySizing> {
  final SizingDimensions width;
  final SizingDimensions height;

  MinySizing()
      : width = SizingDimensions(scale: (value) => value.w),
        height = SizingDimensions(scale: (value) => value.h);

  @override
  MinySizing copyWith({
    SizingDimensions? width,
    SizingDimensions? height,
  }) =>
      MinySizing();

  @override
  MinySizing lerp(ThemeExtension<MinySizing>? other, double t) {
    if (other is! MinySizing) {
      return this;
    }
    return MinySizing();
  }
}

class SizingDimensions {
  final double Function(double) scale;

  SizingDimensions({required this.scale});

  double get s2 => scale(SizingTokens.s2);
  double get s3 => scale(SizingTokens.s3);
  double get s4 => scale(SizingTokens.s4);
  double get s5 => scale(SizingTokens.s5);
  double get s6 => scale(SizingTokens.s6);
  double get s7 => scale(SizingTokens.s7);
  double get s8 => scale(SizingTokens.s8);
  double get s9 => scale(SizingTokens.s9);
  double get s10 => scale(SizingTokens.s10);
  double get s11 => scale(SizingTokens.s11);
  double get s12 => scale(SizingTokens.s12);
  double get s13 => scale(SizingTokens.s13);
  double get s14 => scale(SizingTokens.s14);
  double get s15 => scale(SizingTokens.s15);
  double get s16 => scale(SizingTokens.s16);
  double get s17 => scale(SizingTokens.s17);
  double get s18 => scale(SizingTokens.s18);
  double get s20 => scale(SizingTokens.s20);
  double get s22 => scale(SizingTokens.s22);
  double get s28 => scale(SizingTokens.s28);
  double get s32 => scale(SizingTokens.s32);
  double get s36 => scale(SizingTokens.s36);
  double get s40 => scale(SizingTokens.s40);
  double get s50 => scale(SizingTokens.s50);
  double get s64 => scale(SizingTokens.s64);
  double get quarter => scale(SizingTokens.quarter);
  double get half => scale(SizingTokens.half);
  double get base => scale(SizingTokens.base);
}
