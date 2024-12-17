import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/tag_card.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/string_constants.dart';

void main() {
  group('TagCard Widget Tests', () {
    Widget createWidgetUnderTest({
      String? text,
      required TagType tagType,
      VoidCallback? onTap,
      VoidCallback? onDelete,
      ValueChanged<String>? onTextSubmit,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            theme: appTheme,
            home: Material(
              child: TagCard(
                text: text,
                tagType: tagType,
                onTap: onTap,
                onDelete: onDelete,
                onTextSubmit: onTextSubmit,
              ),
            ),
          ),
        );

    testWidgets(
        'Given a TagCard with TagType.create '
        'when the user taps on it '
        'Then it should switch to an editable TextField for input',
        (WidgetTester tester) async {
      // Arrange
      final onTextSubmitCallback = ValueNotifier<String?>(null);
      await tester.pumpWidget(
        createWidgetUnderTest(
          tagType: TagType.create,
          onTextSubmit: (text) => onTextSubmitCallback.value = text,
        ),
      );

      expect(find.text(addTagText), findsOneWidget);
      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.text(addTagText));
      await tester.pump();

      // Assert:
      expect(find.byType(TextField), findsOneWidget);

      // Act:
      await tester.enterText(find.byType(TextField), 'NewTag');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Assert:
      expect(find.byType(TextField), findsNothing);
      expect(onTextSubmitCallback.value, equals('NewTag'));
    });

    testWidgets(
        'Given a TagCard with TagType.info and text '
        'when rendered '
        'Then it should display the given text and a delete button',
        (WidgetTester tester) async {
      // Arrange
      const testText = 'SampleTag';
      var deleteTapped = false;

      await tester.pumpWidget(
        createWidgetUnderTest(
          text: testText,
          tagType: TagType.info,
          onDelete: () => deleteTapped = true,
        ),
      );

      // Assert:
      expect(find.text(testText), findsOneWidget);
      expect(find.byIcon(MinyIcons.cross), findsOneWidget);

      // Act:
      await tester.tap(find.byIcon(MinyIcons.cross));
      await tester.pump();

      // Assert:
      expect(deleteTapped, isTrue);
    });

    testWidgets(
        'Given a TagCard with no text '
        'when rendered '
        'Then it should not display any Text widget',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        createWidgetUnderTest(
          tagType: TagType.info,
        ),
      );

      // Assert
      expect(find.byType(Text), findsNothing);
    });
    testWidgets(
      'Given a TagCard with TagType.create '
      'when the user taps outside the TextField '
      'Then it should dismiss the TextField and revert to the initial state',
      (WidgetTester tester) async {
        // Arrange:
        await tester.pumpWidget(
          createWidgetUnderTest(
            tagType: TagType.create,
          ),
        );

        // Act:
        await tester.tap(find.text(addTagText));
        await tester.pump();

        // Assert:
        expect(find.byType(TextField), findsOneWidget);

        // Act:
        await tester.tapAt(const Offset(100, 100));
        await tester.pumpAndSettle();

        // Assert:
        expect(find.byType(TextField), findsOneWidget);
        expect(find.text(addTagText), findsOneWidget);
      },
    );
  });
}
