// lib/theme/theme.dart

import 'package:flutter/material.dart';
import 'extensions/miny_colors.dart';
import 'extensions/miny_sizing.dart';
import 'extensions/miny_spacing.dart';

final ThemeData appTheme = ThemeData(
  // fontFamily: 'Inter',
  extensions: const <ThemeExtension<dynamic>>[
    MinyColors(),
    MinySpacing(),
    MinySizing(),
  ],
);

extension ThemeExtensions on ThemeData {
  MinyColors get colors => extension<MinyColors>() ?? const MinyColors();
  MinySpacing get spacing => extension<MinySpacing>() ?? const MinySpacing();
  MinySizing get sizing => extension<MinySizing>() ?? const MinySizing();
}
