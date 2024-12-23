import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/tokens/color_tokens.dart';
import 'package:tackleapp/widgets/string_constants.dart';
import 'package:tackleapp/widgets/transaction_header.dart';

void main() {
  group('TransactionHeader Widget Tests', () {
    const testValue = '03';

    Widget createWidgetUnderTest({
      required String value,
      VoidCallback? onSeeAllPressed,
    }) =>
        MaterialApp(
          builder: (context, child) {
            ScreenUtil.init(
              context,
              designSize: const Size(440, 956),
              minTextAdapt: true,
              splitScreenMode: true,
            );
            return child!;
          },
          home: Material(
            child: TransactionHeader(
              value: value,
              onSeeAllPressed: onSeeAllPressed,
            ),
          ),
        );

    testWidgets(
      'Given onSeeAllPressed is not provided '
      'When TransactionHeader is rendered '
      'Then it does not displays the "See All" link',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createWidgetUnderTest(value: testValue),
        );

        // Assert
        final badgeFinder = find.text(testValue);
        final badgeText = tester.widget<Text>(badgeFinder);

        expect(badgeText.style?.color, ColorTokens.contrastMedium);
        expect(find.text(seeAllText), findsNothing);
        expect(find.text(allTransactionsText), findsOneWidget);
        expect(find.text(transactionsText), findsNothing);
      },
    );

    testWidgets(
      'Given onSeeAllPressed is provided '
      'When TransactionHeader is rendered '
      'Then it displays the "See All" link and triggers callback ',
      (WidgetTester tester) async {
        // Arrange
        var wasPressed = false;

        await tester.pumpWidget(
          createWidgetUnderTest(
            value: testValue,
            onSeeAllPressed: () => wasPressed = true,
          ),
        );

        // Act
        await tester.tap(find.text(seeAllText));
        await tester.pumpAndSettle();

        // Assert
        expect(find.text(seeAllText), findsOneWidget);
        expect(wasPressed, isTrue);
        expect(find.text(testValue), findsOneWidget);
        expect(find.text(transactionsText), findsOneWidget);
        expect(find.text(allTransactionsText), findsNothing);
      },
    );
  });
}
