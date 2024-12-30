import 'package:flutter/material.dart';
import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../pages/show_expense_page.dart';

Future showExpenseBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  await showScaffoldBottomsheet(
    context,
    child: ShowExpensePage(theme: theme),
  );
}
