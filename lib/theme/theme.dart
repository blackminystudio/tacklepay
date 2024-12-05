// lib/theme/theme.dart

import 'package:flutter/material.dart';
import 'extensions/miny_colors.dart';
import 'extensions/miny_spacing.dart';

final ThemeData appTheme = ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    MinyColors(),
    MinySpacing(),
  ],
);

extension ThemeExtensions on ThemeData {
  MinyColors get colors => extension<MinyColors>() ?? const MinyColors();
  MinySpacing get spacing => extension<MinySpacing>() ?? const MinySpacing();
}
