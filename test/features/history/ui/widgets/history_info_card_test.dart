import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/features/history/ui/widgets/history_info_card.dart';
import 'package:tackleapp/theme/theme.dart';

import 'package:tackleapp/widgets/string_constants.dart';

void main() {
  group('HistoryInfoCard Widget Tests', () {
    const testAmount = '12323234';
    const testDate = '12 Dec 2024';
    const formattedTestAmount = '1,23,23,234';
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
        'Then it shows the correct date and formatted amount',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        createWidgetUnderTest(
          date: testDate,
          amount: testAmount,
        ),
      );

      // Assert
      expect(find.text(todayText), findsOneWidget);
      expect(find.text(testDate), findsOneWidget);

      final separatorFinder = find.byType(Container).first;
      final separatorWidget = tester.widget<Container>(separatorFinder);
      expect(separatorWidget.decoration, isA<BoxDecoration>());

      expect(find.text('$rupeeSymbol$formattedTestAmount'), findsOneWidget);
      expect(find.text(totalAmountText), findsOneWidget);
    });

    testWidgets(
        'Given a theme with specific colors '
        'when HistoryInfoCard is rendered '
        'Then it applies the correct styles from the theme',
        (WidgetTester tester) async {
      // Arrange
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

      expect(dateTextStyle?.color, appTheme.colors.contrastMedium);
      expect(amountTextStyle?.color, appTheme.colors.secondary);
    });

    testWidgets(
        'Given an empty amount '
        'when HistoryInfoCard is rendered '
        'Then it displays the rupee symbol with zero ',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        createWidgetUnderTest(
          date: testDate,
          amount: '',
        ),
      );

      // Assert
      expect(find.text('$rupeeSymbol$checkZero'), findsOneWidget);
    });
  });
}
