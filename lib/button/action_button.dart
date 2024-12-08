import 'package:flutter/material.dart';

import '../theme/theme.dart';

enum ButtonType {
  primary,
  text,
  icon,
}

class ActionButton extends StatelessWidget {
  final ButtonType buttonType;
  const ActionButton({super.key, required this.buttonType});

  Widget getButtonType(ButtonType buttonType, ThemeData theme) {
    if (buttonType == ButtonType.primary) {
      return primaryButton(theme);
    } else if (buttonType == ButtonType.text) {
      return textButton(theme);
    } else {
      return iconButton(theme);
    }
  }

  Icon iconButton(ThemeData theme) => Icon(
        Icons.qr_code_scanner_sharp,
        color: theme.colors.light,
        size: theme.spacing.width.s48,
      );

  Text textButton(ThemeData theme) => Text(
        'New Expense',
        style: theme.textStyle.headingLargeBold.copyWith(
          color: theme.colors.light,
        ),
      );

  Row primaryButton(ThemeData theme) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add,
            color: theme.colors.light,
            size: theme.spacing.width.s32,
          ),
          SizedBox(width: theme.sizing.width.s2),
          Text(
            'New Expense',
            style: theme.textStyle.headingLargeBold.copyWith(
              color: theme.colors.light,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(theme.spacing.width.s16),
        decoration: BoxDecoration(
          boxShadow:
              buttonType == ButtonType.icon ? [theme.elevation.e1] : null,
          color: theme.colors.secondary,
          borderRadius: buttonType == ButtonType.icon
              ? BorderRadius.circular(
                  theme.borderradius.full(theme.sizing.width.s20),
                )
              : BorderRadius.circular(
                  theme.borderradius.normal,
                ),
        ),
        child: getButtonType(
          buttonType,
          theme,
        ),
      ),
    );
  }
}
