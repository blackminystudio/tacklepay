import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'string_constants.dart';

class BalanceAmount extends StatelessWidget {
  const BalanceAmount({
    super.key,
    required this.balanceamount,
  });

  final String balanceamount;

  String _getFormattedAmount(String number) {
    if (number.isEmpty) return '$rupeeSymbol$checkZero';
    final length = number.length;
    if (length <= 3) return '$rupeeSymbol$number';
    final lastThree = number.substring(length - 3);
    final remaining = number.substring(0, length - 3);
    final regExp = RegExp(r'(\d)(?=(\d{2})+(?!\d))');
    final formattedRemaining = remaining.replaceAllMapped(
      regExp,
      (Match match) => '${match[1]},',
    );
    return '$rupeeSymbol$formattedRemaining,$lastThree';
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
              _getFormattedAmount(balanceamount),
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
