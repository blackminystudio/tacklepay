import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tackleapp/theme/tokens/color_tokens.dart';
import 'package:tackleapp/widgets/cards/history_info_card.dart';
import 'package:tackleapp/widgets/string_constants.dart';

void main() {
  group('HistoryInfoCard Widget Tests', () {
    Widget createWidgetUnderTest({
      required String date,
      required String amount,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Material(
              child: HistoryInfoCard(
                date: date,
                amount: amount,
              ),
            ),
          ),
        );

    testWidgets(
        'Given correct date and amount '
        'when HistoryInfoCard is rendered '
        'Then it should show the correct date and formatted amount',
        (WidgetTester tester) async {
      // Arrange
      const testAmount = '1234';
      const testDate = '12 Dec 2024';
      const formattedTestAmount = '1,234';
      await tester.pumpWidget(
        createWidgetUnderTest(
          date: testDate,
          amount: testAmount,
        ),
      );

      // Assert
      expect(find.text(testDate), findsOneWidget);
      expect(find.text('$rupeeSymbol$formattedTestAmount'), findsOneWidget);
      expect(find.text(totalAmountText), findsOneWidget);
    });

    testWidgets(
        'Given date and amount '
        'when HistoryInfoCard is rendered '
        'Then it should display a separator line between date and amount',
        (WidgetTester tester) async {
      // Arrange
      const testAmount = '1234';
      const testDate = '12 Dec 2024';
      await tester.pumpWidget(
        createWidgetUnderTest(
          date: testDate,
          amount: testAmount,
        ),
      );

      // Assert
      final separatorFinder = find.byType(Container).first;
      final separatorWidget = tester.widget<Container>(separatorFinder);
      expect(separatorWidget.decoration, isA<BoxDecoration>());
    });

    testWidgets(
        'Given a theme with specific colors '
        'when HistoryInfoCard is rendered '
        'Then it should apply the correct styles from the theme',
        (WidgetTester tester) async {
      // Arrange
      const testAmount = '1234';
      const testDate = '12 Dec 2024';
      const formattedTestAmount = '1,234';
      await tester.pumpWidget(
        createWidgetUnderTest(
          date: testDate,
          amount: testAmount,
        ),
      );

      // Assert
      final dateTextFinder = find.text(testDate);
      final totalAmountTextFinder =
          find.text('$rupeeSymbol$formattedTestAmount');

      final dateTextStyle = tester.widget<Text>(dateTextFinder).style;
      final amountTextStyle = tester.widget<Text>(totalAmountTextFinder).style;

      expect(dateTextStyle?.color, ColorTokens.contrastMedium);
      expect(amountTextStyle?.color, ColorTokens.secondary);
    });

    testWidgets(
        'Given an empty amount '
        'when HistoryInfoCard is rendered '
        'Then it should display only the rupee symbol without crashing',
        (WidgetTester tester) async {
      // Arrange
      const testDate = '12 Dec 2024';
      await tester.pumpWidget(
        createWidgetUnderTest(
          date: testDate,
          amount: '',
        ),
      );

      // Assert
      expect(find.text('$rupeeSymbol$checkZero'), findsOneWidget);
    });

    testWidgets(
        'Given a large numeric amount '
        'when HistoryInfoCard is rendered '
        'Then it should display the formatted large amount in Indian format',
        (WidgetTester tester) async {
      // Arrange
      const testDate = '12 Dec 2024';
      const largeAmount = '123456789';
      const formattedLargeAmount = '12,34,56,789';
      await tester.pumpWidget(
        createWidgetUnderTest(
          date: testDate,
          amount: largeAmount,
        ),
      );

      // Assert
      expect(find.text('$rupeeSymbol$formattedLargeAmount'), findsOneWidget);
    });

    testWidgets(
        'Given a smaller screen size '
        'when HistoryInfoCard is rendered '
        'Then it should adjust the layout without overflow or truncation',
        (WidgetTester tester) async {
      // Arrange
      const testAmount = '1234';
      const testDate = '12 Dec 2024';
      const formattedTestAmount = '1,234';

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(320, 568),
          minTextAdapt: true,
          builder: (_, __) => const MaterialApp(
            home: Material(
              child: HistoryInfoCard(
                date: testDate,
                amount: testAmount,
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('$rupeeSymbol$formattedTestAmount'), findsOneWidget);
      expect(find.text(testDate), findsOneWidget);
    });
  });
}
