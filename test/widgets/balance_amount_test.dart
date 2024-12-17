import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/widgets/balance_amount.dart';
import 'package:tackleapp/widgets/string_constants.dart';

void main() {
  group('BalanceAmount Widget Tests', () {
    Widget createWidgetUnderTest(String balanceAmount) => ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, _) => MaterialApp(
            home: Scaffold(
              body: BalanceAmount(balanceamount: balanceAmount),
            ),
          ),
        );

    testWidgets(
        'Given a valid balance amount '
        'when BalanceAmount is rendered '
        'Then it should display the correct balance amount and label text',
        (WidgetTester tester) async {
      // Arrange
      const testBalance = '123000000';

      // Act
      await tester.pumpWidget(createWidgetUnderTest(testBalance));

      // Assert
      expect(find.text('12,30,00,000'), findsOneWidget);
      expect(find.text(balanceAmountText), findsOneWidget);
    });

    testWidgets(
        'Given a very large balance amount '
        'when BalanceAmount is rendered '
        'Then it should truncate and display the amount with ellipsis',
        (WidgetTester tester) async {
      // Arrange
      const largeBalance = '12345678901234567890';

      // Act
      await tester.pumpWidget(createWidgetUnderTest(largeBalance));

      // Assert
      final textFinder = find.text(largeBalance);
      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets(
        'Given an empty balance amount '
        'when BalanceAmount is rendered '
        'Then it should display zero with rupee symbol and label text',
        (WidgetTester tester) async {
      // Arrange
      const emptyBalance = '';

      // Act
      await tester.pumpWidget(createWidgetUnderTest(emptyBalance));

      // Assert
      expect(find.text('₹0'), findsOneWidget);
      expect(find.text(balanceAmountText), findsOneWidget);
    });
  });
}
