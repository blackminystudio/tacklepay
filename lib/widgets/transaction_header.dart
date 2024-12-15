import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'string_constants.dart';

class TransactionHeader extends StatelessWidget {
  final String value;
  final VoidCallback? onSeeAllPressed;

  const TransactionHeader({
    super.key,
    required this.value,
    this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: theme.sizing.width.s4,
        vertical: theme.sizing.height.s2,
      ),
      child: Row(
        children: [
          Text(
            (onSeeAllPressed != null) ? transactionsText : allTransactionsText,
            style: theme.textStyle.titleRegular.copyWith(
              color: theme.colors.contrastDark,
            ),
          ),
          SizedBox(width: theme.spacing.width.s10),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: theme.sizing.width.s2,
                vertical: theme.spacing.height.s4),
            decoration: BoxDecoration(
              color: theme.colors.contrastLight,
              borderRadius: BorderRadius.circular(theme.borderradius.xSmall),
            ),
            child: Text(
              value,
              style: theme.textStyle.labelRegular.copyWith(
                color: theme.colors.contrastMedium,
              ),
            ),
          ),
          const Spacer(),
          if (onSeeAllPressed != null)
            GestureDetector(
              onTap: onSeeAllPressed,
              child: Text(
                seeAllText,
                style: theme.textStyle.bodyBold.copyWith(
                  color: theme.colors.contrastMedium,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
