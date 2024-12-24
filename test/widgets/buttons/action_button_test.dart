import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/buttons/action_button.dart';

void main() {
  const testIcon = MinyIcons.plus;
  const testTitle = 'Test Button';
  group('ActionButton Widget Tests', () {
    Widget createWidgetUnderTest({
      Function()? onTap,
      String? title,
      IconData? icon,
      double? padding,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Scaffold(
              body: ActionButton(
                onTap: onTap,
                title: title,
                icon: icon,
                padding: padding,
              ),
            ),
          ),
        );

    testWidgets(
        'Given title and icon '
        'when ActionButton is rendered '
        'Then it displays both title and icon', (WidgetTester tester) async {
      // Arrange
      var isTapped = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          title: testTitle,
          icon: testIcon,
          onTap: () => isTapped = true,
        ),
      );

      // Act
      await tester.tap(find.text(testTitle));
      await tester.pump();

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.byIcon(testIcon), findsOneWidget);
      expect(isTapped, isTrue);
    });

    testWidgets(
        'Given only title '
        'when ActionButton is rendered '
        'Then it displays only the title ', (WidgetTester tester) async {
      // Arrange
      var isTapped = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          title: testTitle,
          onTap: () => isTapped = true,
        ),
      );

      // Act
      await tester.tap(find.text(testTitle));
      await tester.pump();

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.byIcon(testIcon), findsNothing);
      expect(isTapped, isTrue);
    });

    testWidgets(
        'Given only icon '
        'when ActionButton is rendered '
        'Then it displays only the icon', (WidgetTester tester) async {
      // Arrange
      var isTapped = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: testIcon,
          onTap: () => isTapped = true,
        ),
      );

      // Act
      await tester.tap(find.byIcon(testIcon));
      await tester.pump();

      // Assert
      expect(find.byIcon(testIcon), findsOneWidget);
      expect(find.text(testTitle), findsNothing);
      expect(isTapped, isTrue);
    });

    testWidgets(
        'Given no icon and no title '
        'when ActionButton is rendered '
        'Then it displays blank and is clickable ',
        (WidgetTester tester) async {
      // Arrange
      var isTapped = false;
      await tester.pumpWidget(
        createWidgetUnderTest(
          onTap: () => isTapped = true,
        ),
      );

      // Act
      final buttonFinder = find.byType(ActionButton);
      await tester.tap(buttonFinder);
      await tester.pump();

      // Assert
      expect(find.text(testTitle), findsNothing);
      expect(find.byIcon(testIcon), findsNothing);
      expect(buttonFinder, findsOneWidget);
      expect(isTapped, isTrue);
    });

    testWidgets(
        'Given fillScan icon '
        'when ActionButton is rendered '
        'Then it applies the correct offset', (WidgetTester tester) async {
      // Arrange
      const fillScanIcon = MinyIcons.fillScan;
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: fillScanIcon,
        ),
      );

      // Assert
      expect(find.byIcon(fillScanIcon), findsOneWidget);

      // Verify the offset is applied via Transform widget
      final transformFinder = find.ancestor(
        of: find.byIcon(fillScanIcon),
        matching: find.byType(Transform),
      );

      // Ensure the Transform widget exists
      expect(transformFinder, findsOneWidget);

      // Extract the Transform widget and check its offset
      final transform = tester.widget<Transform>(transformFinder);
      final translation = transform.transform.getTranslation();
      expect(translation.x, isNot(0));
      expect(translation.x, lessThan(0));
      expect(translation.y, equals(0));
    });

    testWidgets(
        'Given fillScan icon and title '
        'when ActionButton is rendered '
        'Then it applies the correct offset', (WidgetTester tester) async {
      // Arrange
      const fillScanIcon = MinyIcons.fillScan;
      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: fillScanIcon,
          title: testTitle,
        ),
      );

      // Assert
      expect(find.byIcon(fillScanIcon), findsOneWidget);

      // Verify the offset is applied via Transform widget
      final transformFinder = find.ancestor(
        of: find.byIcon(fillScanIcon),
        matching: find.byType(Transform),
      );

      // Ensure the Transform widget exists
      expect(transformFinder, findsOneWidget);

      // Extract the Transform widget and check its offset
      final transform = tester.widget<Transform>(transformFinder);
      final translation = transform.transform.getTranslation();
      expect(translation.x, isNot(0));
      expect(translation.x, lessThan(0));
      expect(translation.y, equals(0));
    });
  });
}
