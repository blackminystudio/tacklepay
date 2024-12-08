import 'package:flutter/material.dart';

import 'theme/theme.dart';

class Balanceamount extends StatelessWidget {
  const Balanceamount({
    super.key,
    required this.balanceamount,
  });

  final String balanceamount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                balanceamount,
                style: theme.textStyle.bodyBold.copyWith(
                  color: theme.colors.contrastDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: theme.sizing.width.s2),
              Text(
                'Balance Amount',
                style: theme.textStyle.bodyRegular.copyWith(
                  color: theme.colors.contrastMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
