import 'package:flutter/material.dart';
import '../../../../../theme/theme.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';
import '../../../../../widgets/buttons/action_button.dart';
import '../../../../../widgets/miny_chip.dart';
import '../../../../../widgets/string_constants.dart';

Future showFiltersButtomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  await showScaffoldBottomsheet(
    title: 'All Filters',
    context,
    actionButton: _buildTextActionButton(context),
    children: [
      const FilterView(),
      Center(
        child: ActionButton(
          title: 'Apply',
          padding: theme.sizing.width.s17,
        ),
      ),
    ],
  );
}

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  RangeValues range = const RangeValues(0, 5000);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rangeValue =
        '$rupeeSymbol${range.start.toInt()} - $rupeeSymbol${range.end.toInt()}';
    return Expanded(
      child: ListView(
        children: [
          // _buildSelectType(theme, isIncome, isExpense, setState),
          _buildSelectDate(theme),
          _buildSelectYear(theme),
          _buildSelectMonths(theme),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: theme.colors.contrastLight),
              ),
            ),
            padding: EdgeInsets.only(
              top: theme.sizing.height.s7,
              bottom: theme.sizing.height.s6,
            ),
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
                    Icon(
                      MinyIcons.outlineArrowDown,
                      size: theme.sizing.height.s3,
                      color: theme.colors.contrastDark,
                    )
                  ],
                ),
                SizedBox(height: theme.sizing.height.s6),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    // trackHeight: 4.0, // Set the desired height for the track
                    overlayShape: SliderComponentShape.noThumb,
                    // thumbShape: const RoundSliderThumbShape(
                    //   enabledThumbRadius: 8.0,
                    // ), // Adjust thumb size
                    // rangeThumbShape: const RoundRangeSliderThumbShape(
                    //   enabledThumbRadius: 8.0,
                    // ), // For RangeSlider
                    // activeTrackColor:
                    //     Colors.blue, // Customize active track color
                    // inactiveTrackColor:
                    //     Colors.grey, // Customize inactive track color
                  ),
                  child: RangeSlider(
                    values: range,
                    divisions: 50,
                    activeColor: theme.colors.contrastDark,
                    inactiveColor: theme.colors.contrastLow,
                    max: 5000,
                    onChanged: (value) {
                      setState(() {
                        range = value;
                      });
                    },
                  ),
                )
                // RangeSlider(
                //   max: 5000,
                //   // activeColor: theme.colors.contrastDark,
                //   // inactiveColor: theme.colors.contrastLow,
                //   values: rangeValues,
                //   onChangeStart: (value) {
                //     setState(() {
                //       rangeValues = value;
                //     });
                //   },
                //   onChangeEnd: (value) {
                //     setState(() {
                //       rangeValues = value;
                //     });
                //   },
                //   onChanged: (values) {
                //     setState(() {
                //       rangeValues = values;
                //     });
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

GestureDetector _buildTextActionButton(
  BuildContext context,
) {
  final theme = Theme.of(context);
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Container(
      color: theme.colors.transparent,
      padding: EdgeInsets.only(
        top: theme.spacing.width.s4,
        left: theme.spacing.width.s4,
        bottom: theme.spacing.width.s4,
      ),
      child: Text(
        'Reset',
        style: theme.textStyle.bodyRegular,
      ),
    ),
  );
}

// Widget _buildFilterView(BuildContext context) {
//   final theme = Theme.of(context);
//   const isExpense = true;
//   const isIncome = false;
//   log('T:isExpense: $isExpense , isIncome: $isIncome');

//   return StatefulBuilder(
//       builder: (context, setState) => );
// }

// Widget _buildSelectPriceRange(ThemeData theme) =>
//     StatefulBuilder(builder: (context, setState) {
//       var range = 0.00;
//       return
//     });

Container _buildSelectMonths(ThemeData theme) => Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colors.contrastLight),
        ),
      ),
      padding: EdgeInsets.only(
        top: theme.sizing.height.s7,
        bottom: theme.sizing.height.s4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Month(s)',
                style: theme.textStyle.bodyRegular,
              ),
              const Spacer(),
              Text(
                '05',
                style: theme.textStyle.labelRegular,
              ),
              SizedBox(width: theme.spacing.width.s8),
              Icon(
                // change Icon from MinyIcons
                MinyIcons.outlineArrowDown,
                size: theme.sizing.height.s3,
                color: theme.colors.contrastDark,
              ),
            ],
          ),
          // ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: chipYearList.length,
          //   itemBuilder: (context, index) => MinyChip(
          //     label: chipYearList[index].label,
          //     selected: chipYearList[index].selected,
          //   ),
          // )
        ],
      ),
    );

Container _buildSelectYear(ThemeData theme) => Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colors.contrastLight),
        ),
      ),
      padding: EdgeInsets.only(
        top: theme.sizing.height.s7,
        bottom: theme.sizing.height.s7,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Select Year',
            style: theme.textStyle.bodyRegular,
          ),
          Container(
            decoration: BoxDecoration(
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
                  '2024',
                  style: theme.textStyle.labelRegular,
                ),
                SizedBox(width: theme.spacing.width.s8),
                Icon(
                  // change Icon from MinyIcons
                  MinyIcons.outlineArrowRight,
                  size: theme.sizing.height.s3,
                  color: theme.colors.contrastDark,
                )
              ],
            ),
          )
        ],
      ),
    );

Container _buildSelectDate(ThemeData theme) => Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colors.contrastLight),
        ),
      ),
      padding: EdgeInsets.only(
        top: theme.sizing.height.s7,
        bottom: theme.sizing.height.s7,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Select Date',
            style: theme.textStyle.bodyRegular,
          ),
          Container(
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
                  'No Date',
                  style: theme.textStyle.bodyRegular,
                ),
                SizedBox(width: theme.spacing.width.s4),
                Icon(
                  // change Icon from MinyIcons
                  Icons.calendar_view_week_rounded,
                  size: theme.sizing.height.s3,
                  color: theme.colors.contrastDark,
                )
              ],
            ),
          )
        ],
      ),
    );
Container _buildSelectType(
  ThemeData theme,
  bool isIncome,
  bool isExpense,
  Function(void Function()) setState,
) =>
    Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.colors.contrastLight),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: theme.sizing.height.s4,
        top: theme.sizing.height.s10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'select Type',
            style: theme.textStyle.bodyRegular,
          ),
          SizedBox(height: theme.sizing.height.s4),
          Row(
            children: [
              MinyChip(
                label: 'Expense',
                selected: isExpense,
                onSelected: (value) {
                  setState(() {
                    isExpense = value;
                  });
                },
              ),
              SizedBox(
                width: theme.sizing.width.s3,
              ),
              MinyChip(
                label: 'Income',
                selected: isIncome,
              ),
            ],
          ),
        ],
      ),
    );

class MinyChipModel {
  final String label;
  bool selected;

  MinyChipModel({
    required this.label,
    this.selected = false,
  });
}

final chipYearList = [
  MinyChipModel(label: 'January', selected: true),
  MinyChipModel(label: 'February', selected: true),
  MinyChipModel(label: 'March'),
  MinyChipModel(label: 'April'),
];
