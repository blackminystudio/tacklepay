import 'package:flutter/material.dart';
import '../../../../../widgets/bottomSheets/bottomsheet_scaffold.dart';
import '../../pages/filters/filter_page.dart';

// Data From Database
List<String> yearList = [
  '2023',
  '2024',
];
List<String> monthList = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

Future showFiltersButtomSheet(BuildContext context) async {
  await showScaffoldBottomsheet(
    title: 'All Filters',
    context,
    // actionButton: _buildTextActionButton(context),
    children: [
      const FilterView(),
    ],
  );
}

// GestureDetector _buildTextActionButton(
//   BuildContext context,
// ) {
//   final theme = Theme.of(context);
//   return GestureDetector(
//     onTap: () => Navigator.pop(context),
//     child: Container(
//       color: theme.colors.transparent,
//       padding: EdgeInsets.only(
//         top: theme.spacing.width.s4,
//         left: theme.spacing.width.s4,
//         bottom: theme.spacing.width.s4,
//       ),
//       child: Text(
//         'Reset',
//         style: theme.textStyle.bodyRegular,
//       ),
//     ),
//   );
// }
