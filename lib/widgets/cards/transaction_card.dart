import 'package:flutter/material.dart';
import '/theme/theme.dart';
import '../store/theme_store.dart';

class TransactionCard extends StatelessWidget {
  final String transactionName;
  final String time;
  final String date;
  final String transactionAmount;
  final bool isExpense;

  const TransactionCard({
    super.key,
    required this.transactionName,
    required this.time,
    required this.date,
    required this.transactionAmount,
    required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildIcon(theme),
            SizedBox(width: theme.sizing.width.s3),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: buildTitle(theme)),
                  buildPrice(theme),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.height.s20),
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
          color: theme.colors.contrastLight,
          borderRadius: BorderRadius.circular(
            theme.borderradius.full(theme.sizing.width.s14),
          ),
        ),
        child: Icon(
          isExpense
              ? MinyIcons.outlineSendMoney
              : MinyIcons.outlineReceiveMoney,
          color:
              isExpense ? theme.colors.secondaryDark : theme.colors.primaryDark,
          size: theme.sizing.width.s6,
        ),
      );

  Column buildPrice(ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            transactionAmount,
            style: theme.textStyle.headingSmallMedium.copyWith(
              color: ThemeStore.getColor(
                theme: theme,
                amount: isExpense ? '-$transactionAmount' : transactionAmount,
                isReversed: true,
              ),
            ),
          ),
        ],
      );

  Column buildTitle(ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            transactionName,
            style: theme.textStyle.headingLargeBold.copyWith(
              color: theme.colors.contrastDark,
            ),
          ),
          SizedBox(height: theme.spacing.height.s4),
          Text(
            '$date, $time',
            style: theme.textStyle.bodyRegular.copyWith(
              color: theme.colors.contrastMedium,
            ),
          ),
        ],
      );
}
