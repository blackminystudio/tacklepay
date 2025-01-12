import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/buttons/action_button.dart';
import '../../../../widgets/cards/transaction_card.dart';
import '../../../../widgets/string_constants.dart';
import '../../../../widgets/transaction_header.dart';
import '../../../transaction/ui/widgets/bottomSheets/bottomsheet_add_expense.dart';
import '../../../transaction/utilities/helper/formatter.dart';
import '../../store/home_store.dart';
import '../../utilities/constants/home_constant.dart';
import '../widgets/greeting_card.dart';
import '../widgets/summary_preview_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imageUrl =
      'https://media.licdn.com/dms/image/v2/D5603AQHARtfrhpGEvQ/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1728052413870?e=2147483647&v=beta&t=NmGaBmkVRlJb5RigSpDsuPxKCewHvradMs4vuoOC0jI';

  @override
  Widget build(BuildContext context) {
    final homeStore = Provider.of<HomeStore>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.light,
      body: Padding(
        padding: EdgeInsets.only(
          top: theme.sizing.width.s20,
          left: theme.sizing.width.s10,
          right: theme.sizing.width.s10,
          bottom: theme.sizing.width.s10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GreetingCard(
                  profilePictureUrl: imageUrl,
                  userName: 'Satyabrata Nayak',
                  greetingMessage: 'Good Morning',
                ),
                //TODO
                const ActionButton(icon: MinyIcons.fillScan)
              ],
            ),
            SizedBox(height: theme.sizing.height.s9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SummaryPreviewCard(
                  amount: homeStore.getThisMonthIncome,
                  percentage: homeStore.getPreviousIncomePercentage(),
                  header: HeaderType.income,
                ),
                SummaryPreviewCard(
                  amount: homeStore.getThisMonthExpense,
                  percentage: homeStore.getPreviousExpensePercentage(),
                  header: HeaderType.expense,
                ),
              ],
            ),
            SizedBox(height: theme.sizing.height.s13),
            TransactionHeader(
              value: homeStore.transactionList.length.toString(),
              // TODO:
              onSeeAllPressed: () {},
            ),
            SizedBox(height: theme.sizing.height.s7),
            Expanded(
              child: homeStore.transactionList.isEmpty
                  ? const Center(child: Text(noTransactionsText))
                  : ListView.builder(
                      itemCount: homeStore.transactionList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final transaction = homeStore.transactionList[index];
                        return Padding(
                          padding:
                              EdgeInsets.only(bottom: theme.sizing.height.s5),
                          child: TransactionCard(
                            transactionName: transaction.message ?? '',
                            transactionAmount: transaction.amount ?? '',
                            date: Format.date(transaction.dateTime) ?? '',
                            time: Format.time(transaction.dateTime) ?? '',
                            isExpense: transaction.isExpense,
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: theme.sizing.height.s5),
            ActionButton(
              padding: theme.spacing.width.s10,
              title: HomeConstants.addTransacButtonText,
              onTap: () {
                showAddExpenseBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
