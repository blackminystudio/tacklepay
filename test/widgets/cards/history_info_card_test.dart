import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tackleapp/theme/tokens/color_tokens.dart';
import 'package:tackleapp/widgets/cards/history_info_card.dart';
import 'package:tackleapp/widgets/string_constants.dart';

void main() {
  group('HistoryInfoCard Widget Tests', () {
    const testDate = '12 Dec 2024';
    const testAmount = '1234567';
    const formattedTestAmount = '12,34,567';

    Widget createWidgetUnderTest() => ScreenUtilInit(
          designSize: const Size(440, 956), // Base design size (width x height)
          minTextAdapt: true,
          builder: (context, child) => const MaterialApp(
            home: Material(
              child: HistoryInfoCard(
                date: testDate,
                amount: testAmount,
              ),
            ),
          ),
        );

    testWidgets('renders the correct date and formatted amount',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      expect(find.text(testDate), findsOneWidget);
      expect(find.text('$rupeeSymbol$formattedTestAmount'), findsOneWidget);
      expect(find.text(totalAmountText), findsOneWidget);
    });

    testWidgets('renders separator line between date and amount',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      final separatorFinder = find.byType(Container).first;
      final separatorWidget = tester.widget<Container>(separatorFinder);
      expect(separatorWidget.decoration, isA<BoxDecoration>());
    });

    testWidgets('applies correct styles from the theme',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(createWidgetUnderTest());

      // Assert
      final dateTextFinder = find.text(testDate);
      final totalAmountTextFinder =
          find.text('$rupeeSymbol$formattedTestAmount');

      final dateTextStyle = tester.widget<Text>(dateTextFinder).style;
      final amountTextStyle = tester.widget<Text>(totalAmountTextFinder).style;

      expect(dateTextStyle?.color, ColorTokens.contrastMedium);
      expect(amountTextStyle?.color, ColorTokens.secondary);
    });

    testWidgets('renders correctly with empty amount',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (_, __) => const MaterialApp(
            home: Material(
              child: HistoryInfoCard(
                date: testDate,
                amount: '',
              ),
            ),
          ),
        ),
      );

      // Assert
      // expect(find.text('${rupeeSymbol}0'), findsOneWidget);
      expect(find.text(rupeeSymbol), findsOneWidget);
    });
  });
}
