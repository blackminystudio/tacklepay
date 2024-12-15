import 'package:flutter/material.dart';
import '../theme/theme.dart';

class FilterButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  FilterButton({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: theme.sizing.width.s10,
          vertical: theme.sizing.width.s4,
        ),
        decoration: BoxDecoration(
          color: theme.colors.contrastLight,
          borderRadius: BorderRadius.circular(theme.borderradius.small),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: theme.sizing.width.s6,
              color: theme.colors.contrastDark,
            ),
            SizedBox(width: theme.sizing.width.s2),
            Text(
              title,
              style: theme.textStyle.headingSmallRegular.copyWith(
                color: theme.colors.contrastDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
