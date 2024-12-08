import 'package:flutter/material.dart';
import 'theme/theme.dart';

class TransactionCard extends StatelessWidget {
  final IconData icon;
  final String transactionName;
  final String transactionTime;
  final String transactionAmount;
  final String remainingBalance;
  final Color backgroundColor;

  const TransactionCard({
    super.key,
    required this.icon,
    required this.transactionName,
    required this.transactionTime,
    required this.transactionAmount,
    required this.remainingBalance,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            iconWidget(theme),
            SizedBox(width: theme.sizing.width.s3),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleWidget(theme),
                  priceWidget(theme),
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

  Container iconWidget(ThemeData theme) => Container(
        height: theme.sizing.height.s14,
        width: theme.sizing.width.s14,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
              theme.borderradius.full(theme.sizing.width.s15)),
        ),
        child: Icon(
          icon,
          color: theme.colors.light,
          size: theme.sizing.width.s6,
        ),
      );

  Column priceWidget(ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            transactionAmount,
            style: theme.textStyle.headingSmallMeduim.copyWith(
              color: theme.colors.secondary,
            ),
          ),
          SizedBox(height: theme.spacing.height.s1),
          Text(
            remainingBalance,
            style: theme.textStyle.bodyRegular.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
        ],
      );

  Column titleWidget(ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transactionName,
            style: theme.textStyle.headingLargeBold.copyWith(
              color: theme.colors.contrastDark,
            ),
          ),
          SizedBox(height: theme.spacing.height.s1),
          Text(
            transactionTime,
            style: theme.textStyle.bodyRegular.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
        ],
      );
}
