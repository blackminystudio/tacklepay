import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/tag_tiles.dart';

void main() {
  group('TagTile Widget Tests', () {
    late String savedTag;
    var isSelected = false;
    const testTag = 'TestTag';

    setUp(() {
      savedTag = '';
      isSelected = false;
    });

    Widget createTestableWidget(Widget child) => ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            home: Scaffold(body: child!),
          ),
          child: child,
        );

    testWidgets(
        'Given a valid tagName '
        'When Tag Tile is rendered '
        'Then tagName is visible with correct styles ',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        createTestableWidget(
          TagTile(
            tagName: testTag,
            onSelection: (value) => isSelected = value,
            onSaveTag: (value) => savedTag = value,
          ),
        ),
      );

      // Assert
      expect(find.text(testTag), findsOneWidget);
      expect(
        tester.widget<Text>(find.text(testTag)).style?.color,
        appTheme.colors.contrastMedium,
      );
    });

    testWidgets(
        'Given a tagName '
        'When the tagName is edited with long name '
        'Then the new tagName is truncated to max 15 characters',
        (WidgetTester tester) async {
      // Arrange
      isSelected = true;
      const longTag = 'ThisTagIsTooLong1234';
      const truncatedTag = 'ThisTagIsTooLon';
      await tester.pumpWidget(
        createTestableWidget(
          TagTile(
            tagName: testTag,
            onSelection: (value) => isSelected = value,
            onSaveTag: (value) => savedTag = value,
            isSelected: isSelected,
          ),
        ),
      );

      expect(
        tester.widget<Text>(find.text(testTag)).style?.color,
        appTheme.colors.contrastDark,
      );

      // Act
      await tester.tap(find.text(testTag));
      await tester.pumpAndSettle();

      // Assert
      final textFieldFinder = find.byType(TextField);
      final textFieldWidgetBefore = tester.widget<TextField>(textFieldFinder);
      expect(textFieldWidgetBefore.style?.color, appTheme.colors.contrastDark);

      // Act
      await tester.enterText(find.byType(TextField), longTag);
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Assert
      expect(savedTag, truncatedTag);
      expect(find.text(truncatedTag), findsOneWidget);
    });

    testWidgets(
      'Given a tag tile '
      'When the check box is clicked '
      'Then it is checked and the text color is updated',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createTestableWidget(
            TagTile(
              tagName: testTag,
              onSelection: (value) => isSelected = value,
              onSaveTag: (value) => savedTag = value,
            ),
          ),
        );

        final textFinder = find.text(testTag);
        final checkBoxFinder = find.byType(Checkbox);

        expect(isSelected, false);
        expect(
          tester.widget<Text>(textFinder).style?.color,
          appTheme.colors.contrastMedium,
        );

        // Act
        await tester.tap(checkBoxFinder);
        await tester.pumpAndSettle();

        // Assert
        expect(isSelected, true);
        expect(
          tester.widget<Text>(textFinder).style?.color,
          appTheme.colors.contrastDark,
        );
        expect(
          tester.widget<Checkbox>(checkBoxFinder).value,
          true,
        );
      },
    );

    testWidgets(
        'Given a tagName '
        'When tagName is edited but not submitted '
        'Then the tagName does not change', (WidgetTester tester) async {
      // Arrange
      const tempTag = 'TempTag';
      const tagLength = '7 / 15';
      await tester.pumpWidget(
        createTestableWidget(
          TagTile(
            tagName: testTag,
            onSelection: (value) => isSelected = value,
            onSaveTag: (value) => savedTag = value,
          ),
        ),
      );

      // Act
      await tester.tap(find.text(testTag));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), tempTag);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(tagLength), findsOneWidget);

      // Act
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(testTag), findsOneWidget);
      expect(find.text(tagLength), findsNothing);
    });

    testWidgets(
      'Given a tagName '
      'When the tagName is cleared and submitted '
      'Then the tagName resets to its original value',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestableWidget(
            TagTile(
              tagName: testTag,
              onSelection: (value) => isSelected = value,
              onSaveTag: (value) => savedTag = value,
            ),
          ),
        );

        await tester.tap(find.text(testTag));
        await tester.pumpAndSettle();

        final textFieldFinder = find.byType(TextField);
        await tester.enterText(textFieldFinder, '');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(find.text(testTag), findsOneWidget);
      },
    );
  });
}
