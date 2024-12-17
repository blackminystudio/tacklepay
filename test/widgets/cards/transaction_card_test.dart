import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/extensions/miny_colors.dart';
import 'package:tackleapp/widgets/cards/transaction_card.dart';

void main() {
  const minyColors = MinyColors();

  const testIcon = Icons.transfer_within_a_station;
  const testTransactionName = 'Transfer to Client';
  const testTransactionDateTime = 'Today, 08:23 PM';
  const testTransactionAmount = '-₹3200';
  const testRemainingBalance = '₹18,110';

  group('TransactionCard Widget Tests', () {
    Widget createWidgetUnderTest({
      required IconData icon,
      required String transactionName,
      required String transactionDateTime,
      required String transactionAmount,
      required String remainingBalance,
      required Color backgroundColor,
    }) =>
        MaterialApp(
          builder: (context, child) {
            ScreenUtil.init(
              context,
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
            );
            return child!;
          },
          theme: ThemeData(
            primaryColor: minyColors.contrastLow,
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: minyColors.secondary),
          ),
          home: Material(
            child: TransactionCard(
              icon: icon,
              transactionName: transactionName,
              transactionDateTime: transactionDateTime,
              transactionAmount: transactionAmount,
              remainingBalance: remainingBalance,
            ),
          ),
        );

    testWidgets(
      'Given TransactionCard widget, '
      'When the widget is rendered, '
      'Then it should display the transaction details correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(
          icon: testIcon,
          transactionName: testTransactionName,
          transactionDateTime: testTransactionDateTime,
          transactionAmount: testTransactionAmount,
          remainingBalance: testRemainingBalance,
          backgroundColor: minyColors.light,
        ));

        expect(find.text(testTransactionName), findsOneWidget);
        expect(find.text(testTransactionDateTime), findsOneWidget);
        expect(find.text(testTransactionAmount), findsOneWidget);
        expect(find.text(testRemainingBalance), findsOneWidget);
      },
    );

    testWidgets(
      'Given TransactionCard widget with null values, '
      'When rendered, '
      'Then it should display empty placeholders',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(
          icon: testIcon,
          transactionName: '',
          transactionDateTime: '',
          transactionAmount: '',
          remainingBalance: '',
          backgroundColor: minyColors.light,
        ));

        expect(find.text(''), findsNWidgets(4));
      },
    );

    testWidgets(
      'Given TransactionCard widget, '
      'When rendered, '
      'Then the divider should have correct properties',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(
          icon: testIcon,
          transactionName: testTransactionName,
          transactionDateTime: testTransactionDateTime,
          transactionAmount: testTransactionAmount,
          remainingBalance: testRemainingBalance,
          backgroundColor: minyColors.light,
        ));

        final dividerFinder = find.byType(Container).last;
        final divider = tester.widget<Container>(dividerFinder);

        expect(divider.constraints?.maxHeight, 1.0);
        expect(divider.constraints?.maxWidth, double.infinity);
        expect(divider.color, minyColors.contrastLow);
      },
    );
    testWidgets(
      'Given TransactionCard widget, '
      'When rendered, '
      'Then it should have proper semantics for accessibility',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(
          icon: testIcon,
          transactionName: testTransactionName,
          transactionDateTime: testTransactionDateTime,
          transactionAmount: testTransactionAmount,
          remainingBalance: testRemainingBalance,
          backgroundColor: minyColors.light,
        ));

        final semanticsFinder = find.bySemanticsLabel('Transfer to Client');
        expect(semanticsFinder, findsOneWidget);
      },
    );
  });
}
