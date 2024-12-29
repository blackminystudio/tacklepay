import 'package:flutter/material.dart';

import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';

Future showProfileBottomsheet(BuildContext context) async {
  final theme = Theme.of(context);
  await showScaffoldBottomsheet(
    context,
    title: 'Profile',
    children: [
      SizedBox(height: theme.sizing.height.s22),
      Center(
        child: Container(
          height: theme.sizing.width.s32,
          width: theme.sizing.width.s32,
          decoration: BoxDecoration(
            color: theme.colors.contrastDark,
            borderRadius: BorderRadius.circular(theme.borderradius.xLarge),
          ),
        ),
      )
    ],
  );
}
