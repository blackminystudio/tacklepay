import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/cards/transaction_card.dart';

void main() {
  const testIcon = MinyIcons.outlineReceiveMoney;
  const testTransactionName = 'Transfer to Client';
  const testTransactionDateTime = 'Today, 08:23 PM';
  const testNegativeTransactionAmount = '-₹3,200';
  const testPositiveTransactionAmount = '₹3,200';
  const testRemainingBalance = '₹18,110';

  group('TransactionCard Widget Tests', () {
    Widget createWidgetUnderTest({
      required IconData icon,
      required String transactionName,
      required String transactionDateTime,
      required String transactionAmount,
      required String remainingBalance,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            theme: appTheme,
            home: Scaffold(
              body: TransactionCard(
                icon: icon,
                transactionName: transactionName,
                transactionDateTime: transactionDateTime,
                transactionAmount: transactionAmount,
                remainingBalance: remainingBalance,
              ),
            ),
          ),
        );

    testWidgets(
      'Given TransactionCard widget '
      'When negative amount is provided '
      'Then it displays the transaction details correctly',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(
          icon: testIcon,
          transactionName: testTransactionName,
          transactionDateTime: testTransactionDateTime,
          transactionAmount: testNegativeTransactionAmount,
          remainingBalance: testRemainingBalance,
        ));

        // Assert
        expect(find.text(testTransactionName), findsOneWidget);
        expect(find.text(testTransactionDateTime), findsOneWidget);
        expect(find.text(testNegativeTransactionAmount), findsOneWidget);
        expect(find.text(testRemainingBalance), findsOneWidget);
        expect(find.byIcon(testIcon), findsOneWidget);

        final dividerFinder = find.byType(Container).last;
        final divider = tester.widget<Container>(dividerFinder);

        expect(divider.constraints?.maxHeight, 1.0);
        expect(divider.constraints?.maxWidth, double.infinity);
        expect(divider.color, appTheme.colors.contrastLow);

        final transactionAmountFinder =
            tester.widget<Text>(find.text(testNegativeTransactionAmount));
        expect(transactionAmountFinder.style?.color,
            appTheme.colors.secondaryDark);
      },
    );

    testWidgets(
      'Given TransactionCard widget '
      'When positive amount is provided '
      'Then it displays the transaction details correctly',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(
          icon: testIcon,
          transactionName: testTransactionName,
          transactionDateTime: testTransactionDateTime,
          transactionAmount: testPositiveTransactionAmount,
          remainingBalance: testRemainingBalance,
        ));

        // Assert
        expect(find.text(testTransactionName), findsOneWidget);
        expect(find.text(testTransactionDateTime), findsOneWidget);
        expect(find.text(testPositiveTransactionAmount), findsOneWidget);
        expect(find.text(testRemainingBalance), findsOneWidget);
        expect(find.byIcon(testIcon), findsOneWidget);

        final dividerFinder = find.byType(Container).last;
        final divider = tester.widget<Container>(dividerFinder);

        expect(divider.constraints?.maxHeight, 1.0);
        expect(divider.constraints?.maxWidth, double.infinity);
        expect(divider.color, appTheme.colors.contrastLow);

        final transactionAmountFinder =
            tester.widget<Text>(find.text(testPositiveTransactionAmount));
        expect(
            transactionAmountFinder.style?.color, appTheme.colors.primaryDark);
      },
    );

    testWidgets(
      'Given TransactionCard widget '
      'When null values are provided '
      'Then it displays empty placeholders',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(
          icon: testIcon,
          transactionName: '',
          transactionDateTime: '',
          transactionAmount: '',
          remainingBalance: '',
        ));

        expect(find.text(''), findsNWidgets(4));
        expect(find.byIcon(testIcon), findsOneWidget);
      },
    );
  });
}
