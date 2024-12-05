// lib/theme/theme.dart

import 'package:flutter/material.dart';
import 'extensions/miny_colors.dart';

final ThemeData appTheme = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    const MinyColors(),
  ],
);

extension ThemeExtensions on ThemeData {
  MinyColors get colors => extension<MinyColors>() ?? const MinyColors();
}
