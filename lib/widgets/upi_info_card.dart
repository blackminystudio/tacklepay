import 'package:flutter/material.dart';
import '/theme/theme.dart';
import 'string_constants.dart';

class UpiInfoCard extends StatefulWidget {
  const UpiInfoCard({super.key});

  @override
  State<UpiInfoCard> createState() => _UpiInfoCardState();
}

class _UpiInfoCardState extends State<UpiInfoCard> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colors.contrastLow,
          width: theme.borderwidth.small,
        ),
        borderRadius: BorderRadius.circular(theme.borderradius.medium),
      ),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.width.s16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textAmount,
                  style: theme.textStyle.bodyBold.copyWith(
                    color: theme.colors.contrastMedium,
                  ),
                ),
                SizedBox(
                  width: theme.sizing.width.s32,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: hintTextAmount,
                      border: InputBorder.none,
                      hintStyle: theme.textStyle.bodyBold
                          .copyWith(color: theme.colors.contrastLow),
                    ),
                    style: theme.textStyle.titleBold
                        .copyWith(color: theme.colors.contrastDark),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            SizedBox(height: theme.spacing.width.s12),
            const Divider(),
            SizedBox(height: theme.spacing.width.s12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  textMessage,
                  style: theme.textStyle.bodyBold.copyWith(
                    color: theme.colors.contrastMedium,
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: _messageController,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: hintTextMessage,
                      border: InputBorder.none,
                      hintStyle: theme.textStyle.bodyBold
                          .copyWith(color: theme.colors.contrastLow),
                    ),
                    style: theme.textStyle.headingSmallMedium
                        .copyWith(color: theme.colors.contrastMedium),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
