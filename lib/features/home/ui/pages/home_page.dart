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
        padding: EdgeInsets.symmetric(
          vertical: theme.sizing.width.s20,
          horizontal: theme.sizing.width.s10,
        ),
        child: Column(
          children: [
            GreetingCard(
              profilePictureUrl: imageUrl,
              userName: 'Satyabrata Nayak',
              greetingMessage: 'Good Morning',
            ),
            SizedBox(height: theme.sizing.height.s9),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SummaryPreviewCard(
                  amount: '71610',
                  percentage: '18',
                  header: HeaderType.income,
                ),
                SummaryPreviewCard(
                  amount: '71610',
                  percentage: '18',
                  header: HeaderType.expense,
                )
              ],
            ),
            SizedBox(height: theme.sizing.height.s13),
            TransactionHeader(
              value: '03',
              onSeeAllPressed: () {},
            ),
            SizedBox(height: theme.sizing.height.s8),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: theme.sizing.height.s5,
                  ),
                  child: const TransactionCard(
                    icon: MinyIcons.outlineSendMoney,
                    transactionName: 'Transfer ',
                    transactionDateTime: 'Today,08:23 PM',
                    transactionAmount: '3200',
                    remainingBalance: '18110',
                  ),
                ),
              ),
            ),
            SizedBox(height: theme.sizing.height.s13),
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
      floatingActionButton: const ActionButton(
        icon: MinyIcons.fillScan,
      ),
      // TODO: Correct Implementation of BottomAppBar with Top Shadow

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30), // Shadow color with opacity
              offset: const Offset(0, -5), // Offset for shadow on Y-axis
              blurRadius: 10, // Blur radius for softness
            ),
          ],
        ),
        child: CustomPaint(
          size: const Size(300, 150),
          painter: CustomShapePainter(),
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
    canvas.drawShadow(path, Colors.black.withAlpha(50), 6.0, false);

    // Draw the shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
