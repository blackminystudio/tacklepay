import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/tag_card.dart';
import 'package:tackleapp/theme/theme.dart';

const addTagTextKey = Key('AddTagText');
const addTagTextFieldKey = Key('AddTagTextField');

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
            home: Scaffold(
              body: TagCard(
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
        'When the user taps on it and enters a text '
        'Then it switches to an editable TextField and updated string is shown',
        (WidgetTester tester) async {
      // Arrange
      final onTextSubmitCallback = ValueNotifier<String?>(null);
      await tester.pumpWidget(
        createWidgetUnderTest(
          tagType: TagType.create,
          onTextSubmit: (text) => onTextSubmitCallback.value = text,
        ),
      );

      expect(find.byKey(addTagTextKey), findsOneWidget);
      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.byKey(addTagTextKey));
      await tester.pump();

      // Assert
      expect(find.byType(TextField), findsOneWidget);

      // Act
      await tester.enterText(find.byType(TextField), 'NewTag');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Assert
      expect(find.byType(TextField), findsNothing);
      expect(onTextSubmitCallback.value, equals('NewTag'));
    });

    testWidgets(
        'Given a TagCard with TagType.info and text '
        'When it is rendered '
        'Then it displays the given text and a cross icon',
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

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.byIcon(MinyIcons.cross), findsOneWidget);

      // Act
      await tester.tap(find.byIcon(MinyIcons.cross));
      await tester.pump();

      // Assert
      expect(deleteTapped, isTrue);
    });

    testWidgets(
        'Given a TagCard with TagType.create '
        'When no text is given '
        'Then it does not display any Text widget',
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
      'When the user taps outside the TextField '
      'Then it should dismiss the TextField and revert to the initial state',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createWidgetUnderTest(
            tagType: TagType.create,
          ),
        );

        // Act
        await tester.tap(find.byKey(addTagTextKey));
        await tester.pumpAndSettle();

        // Assert
        expect(find.byKey(addTagTextKey), findsNothing);
        expect(find.byKey(addTagTextFieldKey), findsOneWidget);

        // Act
        await tester.tapAt(Offset.zero);
        await tester.pumpAndSettle();

        // Assert
        expect(find.byKey(addTagTextKey), findsOneWidget);
        expect(find.byKey(addTagTextFieldKey), findsNothing);
      },
    );

    testWidgets(
      'Given a TagCard with TagType.create '
      'When a space is entered in place of text '
      'Then it does not accept empty submissions',
      (WidgetTester tester) async {
        //Arrange
        var isSubmitted = false;

        await tester.pumpWidget(
          createWidgetUnderTest(
            tagType: TagType.create,
            onTextSubmit: (value) => isSubmitted = true,
          ),
        );
        // Act
        await tester.tap(find.byKey(addTagTextKey));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField), '  ');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

        // Assert
        expect(isSubmitted, isFalse);
        expect(find.byKey(addTagTextKey), findsOneWidget);
      },
    );
  });
}
