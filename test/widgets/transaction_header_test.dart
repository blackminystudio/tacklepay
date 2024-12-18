import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/extensions/miny_colors.dart';
import 'package:tackleapp/widgets/string_constants.dart';
import 'package:tackleapp/widgets/transaction_header.dart';

void main() {
  const minyColors = MinyColors();

  group('TransactionHeader Widget Tests', () {
    Widget createWidgetUnderTest({
      required String value,
      VoidCallback? onSeeAllPressed,
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
          home: Material(
            child: TransactionHeader(
              value: value,
              onSeeAllPressed: onSeeAllPressed,
            ),
          ),
        );

    testWidgets(
      'Given TransactionHeader '
      'When rendered '
      'Then it should display the value badge with correct styles',
      (WidgetTester tester) async {
        // Arrange
        const testValue = '03';

        // Act
        await tester.pumpWidget(
          createWidgetUnderTest(value: testValue),
        );

        // Assert
        final badgeFinder = find.text(testValue);
        final badgeText = tester.widget<Text>(badgeFinder);

        expect(badgeText.style?.color, minyColors.contrastMedium);
      },
    );

    testWidgets(
      'Given onSeeAllPressed is provided '
      'When TransactionHeader is rendered '
      'Then it should display the "See All" link',
      (WidgetTester tester) async {
        // Arrange
        const testValue = '03';

        // Act
        await tester.pumpWidget(
          createWidgetUnderTest(
            value: testValue,
            onSeeAllPressed: () {},
          ),
        );

        // Assert
        expect(find.text(seeAllText), findsOneWidget);
      },
    );

    testWidgets(
      'Given onSeeAllPressed is null '
      'When TransactionHeader is rendered '
      'Then it should not display the "See All" link',
      (WidgetTester tester) async {
        // Arrange
        const testValue = '03';

        // Act
        await tester.pumpWidget(
          createWidgetUnderTest(value: testValue),
        );

        // Assert
        expect(find.text(seeAllText), findsNothing);
      },
    );

    testWidgets(
      'Given onSeeAllPressed callback '
      'When "See All" is tapped '
      'Then it should trigger the callback',
      (WidgetTester tester) async {
        // Arrange
        var wasPressed = false;

        // Act
        await tester.pumpWidget(
          createWidgetUnderTest(
            value: '03',
            onSeeAllPressed: () {
              wasPressed = true;
            },
          ),
        );

        await tester.tap(find.text(seeAllText));
        await tester.pumpAndSettle();

        // Assert
        expect(wasPressed, isTrue);
      },
    );
  });
}
