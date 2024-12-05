// lib/theme/theme.dart

import 'package:flutter/material.dart';
import 'extensions/miny_colors.dart';
import 'extensions/miny_sizing.dart';
import 'extensions/miny_spacing.dart';
import 'extensions/miny_typography.dart';

final ThemeData appTheme = ThemeData(
  // fontFamily: 'Inter',
  extensions: const <ThemeExtension<dynamic>>[
    MinyColors(),
    MinySpacing(),
    MinySizing(),
    MinyTypography(),
  ],
);

extension ThemeExtensions on ThemeData {
  MinyColors get colors => extension<MinyColors>() ?? const MinyColors();
  MinySpacing get spacing => extension<MinySpacing>() ?? const MinySpacing();
  MinySizing get sizing => extension<MinySizing>() ?? const MinySizing();
  MinyTypography get textStyle =>
      extension<MinyTypography>() ?? const MinyTypography();
}
