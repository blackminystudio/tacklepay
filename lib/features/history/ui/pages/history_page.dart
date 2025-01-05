import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/cards/transaction_card.dart';
import '../../../../widgets/transaction_header.dart';
import '../../utilities/constants/history_constant.dart';
import '../widgets/bottomSheets/bottomsheet_show_expense.dart';
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
                  onTap: () {},
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
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: theme.sizing.height.s5),
                  child: GestureDetector(
                    onTap: () =>
                        showExpenseBottomSheet(context, transactionList[index]),
                    child: TransactionCard(
                      transactionName: transactionList[index].message ?? '',
                      transactionAmount: transactionList[index].amount ?? '',
                      transactionDateTime: transactionList[index].date ?? '',
                      remainingBalance: transactionList[index].balance ?? '',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionModel {
  final String id;
  final String? date;
  final String? amount;
  final bool isExpense;
  final String? balance;
  final String? message;
  final List<String> tags;

  TransactionModel({
    this.date,
    this.amount,
    this.message,
    this.balance,
    required this.id,
    required this.tags,
    required this.isExpense,
  });
}

final transactionList = [
  TransactionModel(
    id: '',
    message: 'Refund ..........',
    amount: '₹3200',
    balance: '₹ 18,110',
    date: 'Today, 08:23 PM',
    tags: ['pay'],
    isExpense: false,
  ),
  TransactionModel(
      id: '',
      message: 'Coffee',
      amount: '-₹300',
      balance: '₹ 21,310',
      date: 'Yesterday, 10:20 AM',
      tags: ['food'],
      isExpense: true),
  TransactionModel(
    id: '',
    message: 'Transfer to Client',
    amount: '-₹50,000',
    balance: '₹ 21,610',
    date: '10th Nov, 04:35 PM',
    tags: ['pay'],
    isExpense: true,
  ),
  TransactionModel(
      id: '',
      message: 'Transfer to Client',
      amount: '-₹50,000',
      balance: '₹ 21,610',
      date: '10th Nov, 04:35 PM',
      tags: ['pay'],
      isExpense: true),
];
