import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../string_constants.dart';

class HistoryInfoCard extends StatelessWidget {
  final String date;
  final String amount;
  const HistoryInfoCard({
    super.key,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    String _formatIndianNumber(String number) {
      if (number.isEmpty) return number;
      final length = number.length;
      if (length <= 3) return number;
      final lastThree = number.substring(length - 3);
      final remaining = number.substring(0, length - 3);
      final regExp = RegExp(r'(\d)(?=(\d{2})+(?!\d))');
      final formattedRemaining = remaining.replaceAllMapped(
        regExp,
        (Match match) => '${match[1]},',
      );
      return '$formattedRemaining,$lastThree';
    }

    final formattedAmount = _formatIndianNumber(amount);
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: theme.sizing.width.s4,
        horizontal: theme.sizing.width.s6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          theme.borderradius.normal,
        ),
        color: theme.colors.contrastLight,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildDateTime(theme),
          Container(
            width: theme.spacing.width.s2,
            height: theme.sizing.height.s7,
            decoration: BoxDecoration(
              color: theme.colors.contrastLow,
              borderRadius: BorderRadius.circular(
                theme.borderwidth.medium,
              ),
            ),
          ),
          _buildTotalAmount(formattedAmount, theme),
        ],
      ),
    );
  }

  Column _buildDateTime(ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day,
            style: theme.textStyle.caption.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
          Text(
            date,
            style: theme.textStyle.labelBold.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
        ],
      );

  Flexible _buildTotalAmount(
    String formattedAmount,
    ThemeData theme,
  ) =>
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$rupeeSymbol$formattedAmount',
              textAlign: TextAlign.right,
              style: theme.textStyle.titleBold.copyWith(
                color: theme.colors.secondary,
              ),
            ),
            Text(
              totalAmountText,
              style: theme.textStyle.bodyRegular.copyWith(
                color: theme.colors.contrastDark,
              ),
            ),
          ],
        ),
      );
}
