import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/cards/transaction_card.dart';

void main() {
  const testIconRecieve = MinyIcons.outlineReceiveMoney;
  const testIconSend = MinyIcons.outlineSendMoney;
  const testTransactionName = 'Transfer to Client';
  final testTransactionDateTime = DateTime.now();
  const testNegativeTransactionAmount = '-₹3,200';
  const testPositiveTransactionAmount = '₹3,200';
  const testRemainingBalance = '₹18,110';

  group('TransactionCard Widget Tests', () {
    Widget createWidgetUnderTest({
      required String transactionName,
      required DateTime transactionDateTime,
      required String transactionAmount,
      required String remainingBalance,
      required bool isExpense,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            theme: appTheme,
            home: Scaffold(
              body: TransactionCard(
                transactionName: transactionName,
                transactionDateTime: transactionDateTime,
                transactionAmount: transactionAmount,
                isExpense: isExpense,
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
          transactionName: testTransactionName,
          transactionDateTime: testTransactionDateTime,
          transactionAmount: testNegativeTransactionAmount,
          remainingBalance: testRemainingBalance,
          isExpense: true,
        ));

        // Assert
        expect(find.text(testTransactionName), findsOneWidget);
        expect(find.text(testTransactionDateTime.toString()), findsOneWidget);
        expect(find.text(testNegativeTransactionAmount), findsOneWidget);
        expect(find.text(testRemainingBalance), findsOneWidget);
        expect(find.byIcon(testIconSend), findsOneWidget);

        final dividerFinder = find.byType(Container).last;
        final divider = tester.widget<Container>(dividerFinder);

        expect(divider.constraints?.maxHeight, 1.0);
        expect(divider.constraints?.maxWidth, double.infinity);
        expect(divider.color, appTheme.colors.contrastLow);

        final transactionAmountFinder = tester.widget<Text>(
          find.text(testNegativeTransactionAmount),
        );
        expect(
          transactionAmountFinder.style?.color,
          appTheme.colors.secondaryDark,
        );
      },
    );

    testWidgets(
      'Given TransactionCard widget '
      'When positive amount is provided '
      'Then it displays the transaction details correctly',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(
          transactionName: testTransactionName,
          transactionDateTime: testTransactionDateTime,
          transactionAmount: testPositiveTransactionAmount,
          remainingBalance: testRemainingBalance,
          isExpense: false,
        ));

        // Assert
        expect(find.text(testTransactionName), findsOneWidget);
        expect(find.text(testTransactionDateTime.toString()), findsOneWidget);
        expect(find.text(testPositiveTransactionAmount), findsOneWidget);
        expect(find.text(testRemainingBalance), findsOneWidget);
        expect(find.byIcon(testIconRecieve), findsOneWidget);

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
          transactionName: '',
          transactionDateTime: testTransactionDateTime,
          transactionAmount: '',
          remainingBalance: '',
          isExpense: true,
        ));

        expect(find.text(''), findsNWidgets(4));
        expect(find.byIcon(testIconRecieve), findsOneWidget);
      },
    );
  });
}
