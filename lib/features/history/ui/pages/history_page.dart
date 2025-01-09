import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/cards/transaction_card.dart';
import '../../../../widgets/transaction_header.dart';
import '../../../transaction/store/models/transaction_model.dart';
import '../../../transaction/utilities/helper/formatter.dart';
import '../../utilities/constants/history_constant.dart';
import '../widgets/bottomSheets/bottomsheet_show_expense.dart';
import '../widgets/bottomSheets/bottomsheet_tags.dart';
import '../widgets/filter_button.dart' as miny;
import '../widgets/history_info_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.light,
      appBar: AppBar(
        backgroundColor: theme.colors.contrastLight,
        title: const Text(HistoryConstants.pageName),
        leading: IconButton(
          icon: const Icon(MinyIcons.outlineArrowLeft),
          onPressed: () {
            // Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.sizing.width.s10,
          vertical: theme.sizing.height.s7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                miny.FilterButton(
                  title: HistoryConstants.tagButtonText,
                  icon: MinyIcons.tag,
                  onTap: () => showTagsBottomSheet(context),
                ),
                miny.FilterButton(
                  title: HistoryConstants.filterButtonText,
                  icon: MinyIcons.filter,
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: theme.sizing.height.s5),
            const HistoryInfoCard(
              date: '14/11/24',
              amount: '53500',
            ),
            SizedBox(height: theme.sizing.height.s8),
            TransactionHeader(value: transactionList.length.toString()),
            SizedBox(height: theme.sizing.height.s7),
            Expanded(
              child: ListView.builder(
                itemCount: transactionList.length,
                itemBuilder: (context, index) {
                  final transaction = transactionList[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: theme.sizing.height.s5),
                    child: GestureDetector(
                      onTap: () => showExpenseBottomSheet(context, transaction),
                      child: TransactionCard(
                        transactionName: transaction.message ?? '',
                        transactionAmount: transaction.amount ?? '',
                        date: Format.date(transaction.dateTime) ?? '',
                        time: Format.time(transaction.dateTime) ?? '',
                        isExpense: transaction.isExpense,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
