import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../theme/theme.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/miny_chip.dart';
import '../../../../../widgets/string_constants.dart';
import '../../widgets/bottomSheets/bottomsheet_filters.dart';
import '../../widgets/circular_toggle.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  RangeValues range = const RangeValues(0, 5000);
  bool isExpense = true;
  bool isIncome = true;
  String? selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String? selectedYear;
  List<String> selectedMonth = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: theme.sizing.height.s3),
          Expanded(
            child: ListView(
              children: [
                _buildSelectType(theme),
                _buildSelectDate(theme),
                _buildSelectedYear(theme),
                _buildSelectedMonths(theme),
                _buildPriceRange(theme),
              ],
            ),
          ),
          Center(
            child: ActionButton(
              title: 'Apply',
              padding: theme.sizing.width.s17,
              onTap: () {
                log('Value: Expense:$isExpense');
                log('Value: Income:$isIncome');
                log('Value: Date:$selectedDate');
                log('Value: Year:$selectedYear');
                log('Value: Months:$selectedMonth');
                log('Value: Price:${range.start.toInt()}-${range.end.toInt()}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSelectedMonths(ThemeData theme) => wrapperContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Months',
                  style: theme.textStyle.bodyRegular,
                ),
                SizedBox(width: theme.spacing.width.s8),
                const Spacer(),
                CircularToggle(
                  isSelected: selectedMonth.isNotEmpty,
                  onTap: () {
                    setState(() {
                      selectedMonth = selectedMonth.length == monthList.length
                          ? [monthList.first]
                          : selectedMonth = List.from(monthList);
                    });
                  },
                ),
                SizedBox(width: theme.spacing.width.s8),
                Text(
                  selectedMonth.length.toString(),
                  style: theme.textStyle.labelRegular,
                ),
                SizedBox(width: theme.spacing.width.s8),
                Icon(
                  MinyIcons.outlineArrowRight,
                  size: theme.sizing.height.s3,
                  color: theme.colors.contrastDark,
                ),
              ],
            ),
            SizedBox(height: theme.sizing.height.s5),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    monthList.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        right: theme.sizing.width.s3,
                      ),
                      child: MinyChip(
                        label: monthList[index],
                        selected: selectedMonth.contains(monthList[index]),
                        onSelected: (value) {
                          setState(() {
                            if (value && selectedYear != null) {
                              selectedMonth.add(monthList[index]);
                            } else if (selectedMonth.length > 1) {
                              selectedMonth.remove(monthList[index]);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Container _buildSelectedYear(ThemeData theme) => wrapperContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Year',
                  style: theme.textStyle.bodyRegular,
                ),
                const Spacer(),
                Text(
                  selectedYear ?? 'N/A',
                  style: theme.textStyle.labelRegular,
                ),
                SizedBox(width: theme.spacing.width.s8),
                Icon(
                  MinyIcons.outlineArrowRight,
                  size: theme.sizing.height.s3,
                  color: theme.colors.contrastDark,
                ),
              ],
            ),
            SizedBox(height: theme.sizing.height.s5),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    yearList.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        right: theme.sizing.width.s3,
                      ),
                      child: MinyChip(
                        label: yearList[index],
                        selected: selectedYear == yearList[index],
                        onSelected: (value) {
                          setState(() {
                            selectedYear = yearList[index];
                            selectedDate = null;
                            selectedMonth = List.from(monthList);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Container _buildSelectDate(ThemeData theme) => wrapperContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Date',
              style: theme.textStyle.bodyRegular,
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      selectedDate = DateFormat('dd-MM-yyyy').format(value);
                      selectedYear = null;
                      selectedMonth = [];
                    });
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colors.contrastLow,
                  borderRadius: BorderRadius.circular(
                    theme.borderradius.xSmall,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: theme.sizing.height.s2,
                  horizontal: theme.sizing.height.s4,
                ),
                child: Row(
                  children: [
                    Text(
                      selectedDate ?? 'No Date',
                      style: theme.textStyle.bodyRegular,
                    ),
                    SizedBox(width: theme.spacing.width.s4),
                    Icon(
                      Icons.calendar_month_rounded,
                      size: theme.sizing.height.s4,
                      color: theme.colors.contrastDark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Container _buildSelectType(ThemeData theme) => wrapperContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Type',
              style: theme.textStyle.bodyRegular,
            ),
            SizedBox(height: theme.sizing.height.s4),
            Row(
              children: [
                MinyChip(
                  label: 'Expense',
                  selected: isExpense,
                  onSelected: isIncome
                      ? (value) {
                          setState(() {
                            isExpense = !isExpense;
                          });
                        }
                      : null,
                ),
                SizedBox(width: theme.sizing.width.s3),
                MinyChip(
                  label: 'Income',
                  selected: isIncome,
                  onSelected: isExpense
                      ? (value) {
                          setState(() {
                            isIncome = !isIncome;
                          });
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      );

  Container _buildPriceRange(ThemeData theme) {
    final startValue = range.start.toInt();
    final endValue = range.end.toInt();
    final rangeValue = '$rupeeSymbol$startValue - $rupeeSymbol$endValue';
    return wrapperContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price Range',
                style: theme.textStyle.bodyRegular,
              ),
              const Spacer(),
              Text(
                rangeValue,
                style: theme.textStyle.labelRegular,
              ),
              SizedBox(width: theme.spacing.width.s8),
              _buildRightArrow()
            ],
          ),
          SizedBox(height: theme.sizing.height.s6),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: RangeSlider(
              values: range,
              divisions: 100,
              activeColor: theme.colors.contrastDark,
              inactiveColor: theme.colors.contrastLow,
              max: 5000,
              onChanged: (value) {
                setState(() {
                  range = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Icon _buildRightArrow() {
    final theme = Theme.of(context);
    return Icon(
      MinyIcons.outlineArrowRight,
      size: theme.sizing.height.s3,
      color: theme.colors.contrastDark,
    );
  }

  Container wrapperContainer({required Widget child}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colors.contrastLight),
        ),
      ),
      padding: EdgeInsets.only(
        top: theme.sizing.height.s7,
        bottom: theme.sizing.height.s4,
      ),
      child: child,
    );
  }
}
