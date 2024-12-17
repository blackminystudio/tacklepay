import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/theme.dart';
import 'string_constants.dart';

class BalanceAmount extends StatelessWidget {
  const BalanceAmount({
    super.key,
    required this.balanceamount,
  });

  final String balanceamount;

  String getFormattedAmount(String amount) {
    try {
      if (amount.isEmpty) {
        return '$rupeeSymbol$checkZero';
      }
      final number = double.parse(amount);
      final formatter = NumberFormat.decimalPattern('hi_IN');
      return '₹${formatter.format(number)}';
    } catch (e) {
      return amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: theme.sizing.width.s36,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              getFormattedAmount(balanceamount),
              style: theme.textStyle.titleBold.copyWith(
                color: theme.colors.contrastDark,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: theme.sizing.width.s2),
          Flexible(
            child: Text(
              balanceAmountText,
              style: theme.textStyle.bodyRegular.copyWith(
                color: theme.colors.contrastMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
