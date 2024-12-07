// lib/theme/theme.dart

import 'package:flutter/material.dart';
import 'extensions/miny_border_radius.dart';
import 'extensions/miny_border_width.dart';
import 'extensions/miny_colors.dart';
import 'extensions/miny_elevation.dart';
import 'extensions/miny_opacity.dart';
import 'extensions/miny_sizing.dart';
import 'extensions/miny_spacing.dart';
import 'extensions/miny_typography.dart';

final ThemeData appTheme = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    //
    ...[
      MinySizing(),
      MinySpacing(),
    ],
    //
    ...[
      const MinyColors(),
      const MinyOpacity(),
      const MinyElevation(),
      const MinyTypography(),
      const MinyBorderWidth(),
      const MinyBorderRadius(),
    ]
  ],
);

extension ThemeExtensions on ThemeData {
  // These are used with non-const as they are providing dynamic sizes accroding to the
  MinySizing get sizing => extension<MinySizing>() ?? MinySizing();
  MinySpacing get spacing => extension<MinySpacing>() ?? MinySpacing();
  //
  MinyColors get colors => extension<MinyColors>() ?? const MinyColors();
  MinyOpacity get opacity => extension<MinyOpacity>() ?? const MinyOpacity();
  MinyElevation get elevation => extension<MinyElevation>() ?? const MinyElevation();
  MinyTypography get textStyle => extension<MinyTypography>() ?? const MinyTypography();
  MinyBorderWidth get borderwidth => extension<MinyBorderWidth>() ?? const MinyBorderWidth();
  MinyBorderRadius get borderradius => extension<MinyBorderRadius>() ?? const MinyBorderRadius();
}
