import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'string_constants.dart';

enum HeaderType {
  income,
  expense,
}

class SummaryPreviewCard extends StatelessWidget {
  final HeaderType header;
  final String amount;
  final String percentage;

  const SummaryPreviewCard({
    super.key,
    required this.header,
    required this.amount,
    required this.percentage,
  });

  Color getColor(ThemeData theme, bool isIncome) {
    final zero = percentage == checkZero;
    final minus = percentage.startsWith(checkMinus);
    if (zero) {
      return theme.colors.contrastDark;
    } else if (minus) {
      return isIncome ? theme.colors.secondaryDark : theme.colors.primaryDark;
    } else {
      return isIncome ? theme.colors.primaryDark : theme.colors.secondaryDark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = header == HeaderType.income;
    final theme = Theme.of(context);
    final title = header == HeaderType.income ? incomeText : expenseText;
    final headerColor = header == HeaderType.income
        ? theme.colors.primary
        : theme.colors.secondary;
    return Container(
      width: theme.sizing.width.s40,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.contrastLow),
        borderRadius: BorderRadius.circular(theme.borderradius.large),
        color: theme.colors.light,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header part
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(theme.borderradius.large),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: theme.spacing.height.s12,
                horizontal: theme.spacing.width.s20,
              ),
              child: Text(
                title,
                style: theme.textStyle.labelBold.copyWith(
                  color: theme.colors.light,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(
              left: theme.spacing.width.s16,
              top: theme.spacing.height.s12,
              right: theme.spacing.width.s16,
              bottom: theme.spacing.height.s16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₹ $amount',
                  style: theme.textStyle.titleBold.copyWith(
                    color: theme.colors.contrastDark,
                  ),
                ),
                SizedBox(height: theme.spacing.height.s4),
                Text.rich(
                  TextSpan(
                    text: '$percentage%',
                    style: theme.textStyle.bodyBold.copyWith(
                      color: getColor(theme, isIncome),
                    ),
                    children: [
                      TextSpan(
                        text: '  vs. last month',
                        style: theme.textStyle.quote.copyWith(
                          color: theme.colors.contrastDark,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
