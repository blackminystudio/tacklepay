import 'package:flutter/material.dart';
import '../string_constants.dart';

import '../../theme/theme.dart';

class ThemeStore {
  static Color getColor({required ThemeData theme, bool isReversed = false, required String amount}) {
    final zero = amount == checkZero;
    final minus = amount.startsWith(checkMinus);
    if (zero) {
      return theme.colors.contrastDark;
    } else if (minus) {
      return isReversed ? theme.colors.secondaryDark : theme.colors.primaryDark;
    } else {
      return isReversed ? theme.colors.primaryDark : theme.colors.secondaryDark;
    }
  }
}
