import 'package:flutter/material.dart';
import 'theme/theme.dart';

class UPICard extends StatelessWidget {
  final String payeeFirstName;
  final String payeeLastName;
  final String payeeUpiId;
  const UPICard({
    super.key,
    required this.payeeFirstName,
    required this.payeeLastName,
    required this.payeeUpiId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstNameInitial = payeeFirstName[0];
    final lastNameInitial = payeeLastName[0];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(theme.spacing.width.s12),
      decoration: BoxDecoration(
        color: theme.colors.contrastLight,
        borderRadius: BorderRadius.circular(
          theme.borderradius.medium,
        ),
        border: Border.all(
          color: theme.colors.contrastLow,
        ),
      ),
      child: Row(
        children: [
          // headingTitle Container
          buildIcon(theme, firstNameInitial, lastNameInitial),
          SizedBox(width: theme.spacing.width.s12),
          buildContent(theme),
        ],
      ),
    );
  }

  Column buildContent(ThemeData theme) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$payeeFirstName $payeeLastName',
            style: theme.textStyle.headingSmallRegular
                .copyWith(color: theme.colors.contrastDark),
          ),
          Text(
            payeeUpiId,
            style: theme.textStyle.bodyRegular
                .copyWith(color: theme.colors.contrastMedium),
          ),
        ],
      );

  Container buildIcon(
          ThemeData theme, String firstNameInitial, String lastNameInitial) =>
      Container(
        height: theme.sizing.width.s12,
        width: theme.sizing.width.s12,
        decoration: BoxDecoration(
          color: theme.colors.light,
          borderRadius: BorderRadius.circular(
            theme.borderradius.full(theme.sizing.width.s12),
          ),
        ),
        child: Center(
// Name Initial
          child: Text(
            '$firstNameInitial$lastNameInitial',
            style: theme.textStyle.headingSmallMedium.copyWith(
              color: theme.colors.contrastDark,
            ),
          ),
        ),
      );
}
