import 'package:flutter/material.dart';
import '/theme/theme.dart';
import '../store/theme_store.dart';

class TransactionCard extends StatelessWidget {
  final IconData icon;
  final String transactionName;
  final String transactionDateTime;
  final String transactionAmount;
  final String remainingBalance;

  const TransactionCard({
    super.key,
    required this.icon,
    required this.transactionName,
    required this.transactionDateTime,
    required this.transactionAmount,
    required this.remainingBalance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            buildIcon(theme),
            SizedBox(width: theme.sizing.width.s3),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTitle(theme),
                  buildPrice(theme),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: theme.spacing.height.s20,
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: theme.colors.contrastLow,
        )
      ],
    );
  }

  Container buildIcon(ThemeData theme) => Container(
        height: theme.sizing.width.s14,
        width: theme.sizing.width.s14,
        decoration: BoxDecoration(
          color: theme.colors.light,
          borderRadius: BorderRadius.circular(
              theme.borderradius.full(theme.sizing.width.s14)),
        ),
        child: Icon(
          icon,
          color: theme.colors.dark,
          size: theme.sizing.width.s6,
        ),
      );

  Column buildPrice(ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            transactionAmount,
            style: theme.textStyle.headingSmallMedium.copyWith(
              color: ThemeStore.getColor(
                theme: theme,
                amount: transactionAmount,
              ),
            ),
          ),
          SizedBox(height: theme.spacing.height.s8),
          Text(
            remainingBalance,
            style: theme.textStyle.bodyRegular.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
        ],
      );

  Column buildTitle(ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transactionName,
            style: theme.textStyle.headingLargeBold.copyWith(
              color: theme.colors.contrastDark,
            ),
          ),
          SizedBox(height: theme.spacing.height.s4),
          Text(
            transactionDateTime,
            style: theme.textStyle.bodyRegular.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
        ],
      );
}
