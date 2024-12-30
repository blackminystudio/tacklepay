import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../../store/transaction_store.dart';
import '../../pages/add_expense_page.dart';

Future showAddExpenseBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  final store = Provider.of<TransactionStore>(context, listen: false);

  await showScaffoldBottomsheet(
    context,
    child: AddExpensePage(theme: theme, store: store),
  );
}
