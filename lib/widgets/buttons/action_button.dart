import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class ActionButton extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final IconData? icon;
  final double? padding;
  const ActionButton({
    super.key,
    this.onTap,
    this.title,
    this.icon,
    this.padding,
  });

  Widget getButtonType(ThemeData theme) {
    if (title != null && icon != null) return buildPrimary(theme);
    if (title != null && icon == null) return buildText(theme);
    return buildIcon(theme);
  }

  Widget buildIcon(ThemeData theme) => Transform.translate(
        offset: icon == MinyIcons.fillScan
            ? Offset(-theme.spacing.width.s48 / 2, 0)
            : const Offset(0, 0),
        child: Icon(
          icon,
          color: theme.colors.light,
          size: theme.spacing.width.s48,
        ),
      );

  Padding buildText(ThemeData theme) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        child: Text(
          title ?? '',
          style: theme.textStyle.headingLargeBold.copyWith(
            color: theme.colors.light,
          ),
        ),
      );

  Padding buildPrimary(ThemeData theme) => Padding(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: icon == MinyIcons.fillScan
                  ? Offset(-theme.spacing.width.s32 / 2, 0)
                  : const Offset(0, 0),
              child: Icon(
                icon,
                color: theme.colors.light,
                size: theme.spacing.width.s32,
              ),
            ),
            SizedBox(width: theme.sizing.width.s2),
            Text(
              title ?? '',
              style: theme.textStyle.headingLargeBold.copyWith(
                color: theme.colors.light,
              ),
            ),
          ],
        ),
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
              title == null && icon != null ? [theme.elevation.e1] : null,
          color: theme.colors.secondary,
          borderRadius: title == null && icon != null
              ? BorderRadius.circular(
                  theme.borderradius.full(
                    theme.sizing.width.s20,
                  ),
                )
              : BorderRadius.circular(
                  theme.borderradius.normal,
                ),
        ),
        child: getButtonType(theme),
      ),
    );
  }
}
