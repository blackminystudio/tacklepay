import 'package:flutter/material.dart';
import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../pages/add_expense_page.dart';

Future showAddExpenseBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);

  await showScaffoldBottomsheet(
    context,
    child: AddExpensePage(theme: theme),
  );
}
