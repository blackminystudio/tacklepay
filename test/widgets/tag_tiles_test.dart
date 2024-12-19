import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/tokens/color_tokens.dart';
import 'package:tackleapp/widgets/tag_tiles.dart';

void main() {
  group('TagTile Widget Tests', () {
    late String savedTag;
    var isSelected = false;

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
        'When rendered '
        'Then tagName is visible with correct styles ',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        createTestableWidget(
          TagTile(
            tagName: 'TestTag',
            onSelection: (value) => isSelected = value,
            onSaveTag: (value) => savedTag = value,
          ),
        ),
      );

      expect(find.text('TestTag'), findsOneWidget);
      expect(
        tester.widget<Text>(find.text('TestTag')).style?.color,
        ColorTokens.contrastMedium,
      );
    });

    testWidgets(
        'Given a tagName '
        'When the tagName is edited with long name '
        'Then the new tagName should be visible with max 15 characters',
        (WidgetTester tester) async {
      savedTag = 'OldTag';
      isSelected = true;
      await tester.pumpWidget(
        createTestableWidget(
          TagTile(
            tagName: savedTag,
            onSelection: (value) => isSelected = value,
            onSaveTag: (value) => savedTag = value,
            isSelected: isSelected,
          ),
        ),
      );

      expect(
        tester.widget<Text>(find.text('OldTag')).style?.color,
        ColorTokens.contrastDark,
      );

      await tester.tap(find.text('OldTag'));
      await tester.pumpAndSettle();

      final textFieldFinder = find.byType(TextField);
      final textFieldWidgetBefore = tester.widget<TextField>(textFieldFinder);
      expect(textFieldWidgetBefore.style?.color, ColorTokens.contrastDark);

      await tester.enterText(find.byType(TextField), 'ThisTagIsTooLong1234');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      expect(savedTag, 'ThisTagIsTooLon');
      expect(find.text(savedTag), findsOneWidget);
    });

    testWidgets(
      'Given a tag tile '
      'When the check box is clicked '
      'Then it is checked and the text color is updated',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestableWidget(
            TagTile(
              tagName: 'TestTag',
              onSelection: (value) => isSelected = value,
              onSaveTag: (value) => savedTag = value,
            ),
          ),
        );

        final textFinder = find.text('TestTag');
        final checkBoxFinder = find.byType(Checkbox);

        expect(isSelected, false);
        expect(
          tester.widget<Text>(textFinder).style?.color,
          ColorTokens.contrastMedium,
        );

        await tester.tap(checkBoxFinder);
        await tester.pumpAndSettle();

        expect(isSelected, true);
        expect(
          tester.widget<Text>(textFinder).style?.color,
          ColorTokens.contrastDark,
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
      await tester.pumpWidget(
        createTestableWidget(
          TagTile(
            tagName: 'OriginalTag',
            onSelection: (value) => isSelected = value,
            onSaveTag: (value) => savedTag = value,
          ),
        ),
      );

      await tester.tap(find.text('OriginalTag'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'TempTag');
      await tester.pumpAndSettle();

      // Ensure the character count is visible when editing
      expect(find.text('7 / 15'), findsOneWidget);

      await tester.tapAt(Offset.zero); // Tapping outside
      await tester.pumpAndSettle();

      // Ensure the tag name resets and character count is hidden
      expect(find.text('OriginalTag'), findsOneWidget);
      expect(find.text('7 / 15'), findsNothing);
    });

    testWidgets(
      'Given a tagName '
      'When the tagName is cleared and submitted '
      'Then the tagName should reset to its original value',
      (WidgetTester tester) async {
        savedTag = 'InitialTag';

        await tester.pumpWidget(
          createTestableWidget(
            TagTile(
              tagName: savedTag,
              onSelection: (value) => isSelected = value,
              onSaveTag: (value) => savedTag = value,
            ),
          ),
        );

        await tester.tap(find.text('InitialTag'));
        await tester.pumpAndSettle();

        final textFieldFinder = find.byType(TextField);
        await tester.enterText(textFieldFinder, '');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(savedTag, 'InitialTag');
        expect(find.text('InitialTag'), findsOneWidget);
      },
    );
  });
}
