import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'string_constants.dart';

class PayDateDropdown extends StatefulWidget {
  @override
  _PayDateDropDownState createState() => _PayDateDropDownState();
}

class _PayDateDropDownState extends State<PayDateDropdown> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
    return Container(
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.width.s4),
        child: GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: EdgeInsets.all(theme.spacing.width.s4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(theme.borderradius.small),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      payDate,
                      style: theme.textStyle.caption.copyWith(
                        fontSize: theme.sizing.width.s5,
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
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    selectedDate == null
                        ? noDateSelected
                        : '${selectedDate!.day.toString().padLeft(2, '0')}/'
                            '${selectedDate!.month.toString().padLeft(2, '0')}/'
                            '${selectedDate!.year}',
                    style: theme.textStyle.headingSmallMedium.copyWith(
                      color: theme.colors.contrastDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
