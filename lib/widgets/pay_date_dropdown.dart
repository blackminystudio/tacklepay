import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/theme.dart';
import 'string_constants.dart';

class PayDateDropdown extends StatefulWidget {
  @override
  State<PayDateDropdown> createState() => _PayDateDropDownState();
}

class _PayDateDropDownState extends State<PayDateDropdown> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.all(theme.spacing.width.s4),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  payDateText,
                  style: theme.textStyle.caption.copyWith(
                    color: theme.colors.contrastMedium,
                  ),
                ),
                SizedBox(width: theme.sizing.width.s3),
                Icon(
                  MinyIcons.outlineArrowUp,
                  color: theme.colors.contrastMedium,
                  size: theme.sizing.width.s3,
                ),
              ],
            ),
            SizedBox(height: theme.spacing.width.s4),
            Text(
              DateFormat('dd/MM/yyyy').format(selectedDate),
              style: theme.textStyle.headingSmallMedium.copyWith(
                color: theme.colors.contrastDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
