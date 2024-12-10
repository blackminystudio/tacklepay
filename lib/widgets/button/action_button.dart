import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum ButtonType {
  primary,
  text,
  icon,
}

class ActionButton extends StatelessWidget {
  final ButtonType buttonType;
  final Function()? onTap;
  final String title;
  final IconData icon;
  const ActionButton({
    super.key,
    required this.buttonType,
    this.onTap,
    required this.title,
    required this.icon,
  });

  Widget getButtonType(ButtonType buttonType, ThemeData theme) {
    if (buttonType == ButtonType.primary) {
      return buildPrimary(theme);
    } else if (buttonType == ButtonType.text) {
      return buildText(theme);
    } else {
      return buildIcon(theme);
    }
  }

  Icon buildIcon(ThemeData theme) => Icon(
        Icons.qr_code_scanner_sharp,
        color: theme.colors.light,
        size: theme.spacing.width.s48,
      );

  Text buildText(ThemeData theme) => Text(
        title,
        style: theme.textStyle.headingLargeBold.copyWith(
          color: theme.colors.light,
        ),
      );

  Row buildPrimary(ThemeData theme) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: theme.colors.light,
            size: theme.spacing.width.s32,
          ),
          SizedBox(width: theme.sizing.width.s2),
          Text(
            title,
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
      onTap: onTap,
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
        child: getButtonType(buttonType, theme),
      ),
    );
  }
}
