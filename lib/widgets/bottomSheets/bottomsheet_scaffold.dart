import 'package:flutter/material.dart';

import '../../theme/theme.dart';
// import '../buttons/toggle_button.dart';

Future<dynamic> showScaffoldBottomsheet(
  BuildContext context, {
  Widget? actionButton,
  String? title,
  List<Widget>? children,
}) {
  final theme = Theme.of(context);

  return showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 0.8,
    context: context,
    builder: (context) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(theme.borderradius.xLarge),
          topRight: Radius.circular(theme.borderradius.xLarge),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.sizing.width.s10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    color: theme.colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(MinyIcons.outlineArrowLeft),
                        SizedBox(width: theme.sizing.width.s4),
                        Text(
                          title ?? 'Expense',
                          style: theme.textStyle.headingLargeBold,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                actionButton ?? const SizedBox.shrink(),
              ],
            ),
            ...?children,
          ],
        ),
      ),
    ),
  );
}

// MinyToggleButton _buildMinyToggleButton() => MinyToggleButton(
//       value: true,
//       onChanged: (value) {},
//     );

// GestureDetector _buildTextActionButton(
//   BuildContext context,
// ) {
//   final theme = Theme.of(context);
//   return GestureDetector(
//     onTap: () => Navigator.pop(context),
//     child: Container(
//       color: theme.colors.transparent,
//       padding: EdgeInsets.only(
//         top: theme.spacing.width.s4,
//         left: theme.spacing.width.s4,
//         bottom: theme.spacing.width.s4,
//       ),
//       child: Text(
//         'Merge',
//         style: theme.textStyle.bodyRegular,
//       ),
//     ),
//   );
// }
