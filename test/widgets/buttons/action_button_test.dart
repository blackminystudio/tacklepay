import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/widgets/buttons/action_button.dart';

void main() {
  const testIcon = Icons.add;
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
        'Then it should display both title and icon',
        (WidgetTester tester) async {
      // Arrange

      await tester.pumpWidget(
        createWidgetUnderTest(
          title: testTitle,
          icon: testIcon,
        ),
      );

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.byIcon(testIcon), findsOneWidget);
    });

    testWidgets(
        'Given only title '
        'when ActionButton is rendered '
        'Then it should display only the title', (WidgetTester tester) async {
      // Arrange

      await tester.pumpWidget(
        createWidgetUnderTest(
          title: testTitle,
        ),
      );

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.byType(Icon), findsNothing);
    });

    testWidgets(
        'Given only icon '
        'when ActionButton is rendered '
        'Then it should display only the icon', (WidgetTester tester) async {
      // Arrange

      await tester.pumpWidget(
        createWidgetUnderTest(
          icon: testIcon,
        ),
      );

      // Assert
      expect(find.byIcon(testIcon), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets(
        'Given ActionButton is rendered '
        'When title and icon are provided '
        'Then it should display both title and icon',
        (WidgetTester tester) async {
      // Arrange
      var isTapped = false;

      await tester.pumpWidget(
        createWidgetUnderTest(
          title: testTitle,
          onTap: () {
            isTapped = true;
          },
        ),
      );

      // Act
      await tester.tap(find.text(testTitle));
      await tester.pump();
      // Assert
      expect(isTapped, isTrue);
    });
  });
}
