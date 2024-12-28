import 'package:flutter/material.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/balance_amount.dart';
import '../../../../widgets/buttons/action_button.dart';
import '../../../../widgets/cards/transaction_card.dart';
import '../../../../widgets/transaction_header.dart';
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
                const ActionButton(icon: MinyIcons.fillScan)
              ],
            ),
            SizedBox(height: theme.sizing.height.s9),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SummaryPreviewCard(
                  amount: '3200',
                  percentage: '18',
                  header: HeaderType.income,
                ),
                SummaryPreviewCard(
                  amount: '50300',
                  percentage: '18',
                  header: HeaderType.expense,
                )
              ],
            ),
            SizedBox(height: theme.sizing.height.s13),
            TransactionHeader(
              value: transactionList.length.toString(),
              onSeeAllPressed: () {},
            ),
            SizedBox(height: theme.sizing.height.s7),
            Expanded(
              child: ListView.builder(
                itemCount: transactionList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: theme.sizing.height.s5),
                  child: TransactionCard(
                    icon: transactionList[index].amount.startsWith('-')
                        ? MinyIcons.outlineSendMoney
                        : MinyIcons.outlineReceiveMoney,
                    transactionName: transactionList[index].name,
                    transactionAmount: transactionList[index].amount,
                    transactionDateTime: transactionList[index].dateTime,
                    remainingBalance: transactionList[index].balance,
                  ),
                ),
              ),
            ),
            SizedBox(height: theme.sizing.height.s5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BalanceAmount(balanceamount: '1000'),
                ActionButton(
                  title: 'New Transaction',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()

      // Start at the top-left corner
      ..moveTo(0, 0)

      // Draw the top straight line to where the circular indentation starts
      ..lineTo(size.width / 2 - 50, 0)

      // Add the circular indentation
      ..arcToPoint(
        Offset(size.width / 2 + 50, 0),
        radius: const Radius.circular(50),
      )

      // Draw the remaining top straight line
      ..lineTo(size.width, 0)

      // Draw the right vertical line
      ..lineTo(size.width, size.height)

      // Draw the bottom horizontal line
      ..lineTo(0, size.height)

      // Close the path
      ..close();
    canvas
      ..drawShadow(path, Colors.black.withAlpha(50), 6.0, false)

      // Draw the shape
      ..drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TransactionModel {
  final String name;
  final String amount;
  final String dateTime;
  final String balance;

  TransactionModel({
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.balance,
  });
}

final transactionList = [
  TransactionModel(
    name: 'Refund',
    amount: '₹3200',
    balance: '₹18,110',
    dateTime: 'Today, 08:23 PM',
  ),
  TransactionModel(
    name: 'Coffee',
    amount: '-₹300',
    balance: '₹21,310',
    dateTime: 'Yesterday, 10:20 AM',
  ),
  TransactionModel(
    name: 'Coffee',
    amount: '-₹300',
    balance: '₹21,310',
    dateTime: 'Yesterday, 10:20 AM',
  ),
  TransactionModel(
    name: 'Transfer to Client',
    amount: '-₹50,000',
    balance: '₹21,610',
    dateTime: '10th Nov, 04:35 PM',
  ),
];
