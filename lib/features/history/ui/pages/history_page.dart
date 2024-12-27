import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/cards/transaction_card.dart';
import '../../../../widgets/transaction_header.dart';
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
        title: const Text('History'),
        leading: IconButton(
          // TODO: needs to be changed to arrowLeft
          icon: const Icon(MinyIcons.outlineArrowDown),
          onPressed: () {
            Navigator.of(context).pop();
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
                  title: 'Tags',
                  icon: MinyIcons.filter,
                  onTap: () {
                    print('Filter button tapped');
                  },
                ),
                miny.FilterButton(
                  title: 'FILTER',
                  icon: MinyIcons.filter,
                  onTap: () {
                    print('Filter Button tapped');
                  },
                ),
              ],
            ),
            SizedBox(height: theme.sizing.height.s5),
            const HistoryInfoCard(
              date: '14/11/24',
              amount: '53500',
            ),
            SizedBox(height: theme.sizing.height.s8),
            TransactionHeader(
              value: '03',
              onSeeAllPressed: () {},
            ),
            SizedBox(height: theme.sizing.height.s7),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                        padding:
                            EdgeInsets.only(bottom: theme.sizing.height.s5),
                        child: const TransactionCard(
                            icon: MinyIcons.outlineSendMoney,
                            transactionName: 'title',
                            transactionAmount: 'amount',
                            transactionDateTime: 'dateTime',
                            remainingBalance: 'balance'),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
