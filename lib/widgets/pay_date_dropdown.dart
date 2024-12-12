import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'string_constants.dart';

class PayDateDropdown extends StatefulWidget {
  @override
  State<PayDateDropdown> createState() => _PayDateDropDownState();
}

class _PayDateDropDownState extends State<PayDateDropdown> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.width.s4),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
          padding: EdgeInsets.all(theme.spacing.width.s4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.borderradius.small),
          ),
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
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.width.s4),
              Text(
                selectedDate == null
                    ? '${DateTime.now().day.toString().padLeft(2, '0')}/'
                        '${DateTime.now().month.toString().padLeft(2, '0')}/'
                        '${DateTime.now().year}'
                    : '${selectedDate!.day.toString().padLeft(2, '0')}/'
                        '${selectedDate!.month.toString().padLeft(2, '0')}/'
                        '${selectedDate!.year}',
                style: theme.textStyle.headingSmallMedium.copyWith(
                  color: theme.colors.contrastDark,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
