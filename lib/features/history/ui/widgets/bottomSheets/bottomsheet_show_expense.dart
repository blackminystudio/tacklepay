import 'package:flutter/material.dart';
import '../../../../../widgets/bottomsheet/bottomsheet_scaffold.dart';
import '../../pages/history_page.dart';
import '../../pages/show_expense_page.dart';

Future showExpenseBottomSheet(BuildContext context) async {
  final theme = Theme.of(context);
  await showScaffoldBottomsheet(
    context,
    child: ShowExpensePage(
      theme: theme,
      transactionModel: transactionModel,
    ),
  );
}

final transactionModel = TransactionModel(
  amount: '300',
  name: 'Coffee',
  balance: '18000',
  dateTime: '11-12-24',
);
