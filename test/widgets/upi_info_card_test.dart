import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/widgets/string_constants.dart';
import 'package:tackleapp/widgets/upi_info_card.dart';

void main() {
  Widget createWidgetUnderTest() => ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        builder: (context, child) => const MaterialApp(
          home: Material(
            child: UpiInfoCard(),
          ),
        ),
      );

  group('UpiInfoCard Widget Tests', () {
    testWidgets(
      'Given the widget is displayed '
      'When it renders '
      'Then it should show amount and message fields',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text(amountText), findsOneWidget);
        expect(find.text(messageText), findsOneWidget);
      },
    );

    testWidgets(
      'Given invalid amount or input starting with "0" '
      'When "\u20B90" or "0" is entered '
      'Then the amount should be cleared or formatted correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        final amountField = find.byType(TextField).first;

        await tester.enterText(amountField, '\u20B90');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(tester.widget<TextField>(amountField).controller?.text, isEmpty);
      },
    );

    testWidgets(
      'Given a numeric amount without a rupee symbol or valid input '
      'When the amount is submitted '
      'Then the rupee symbol added, formatted, focus shifts to message field',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        final amountField = find.byType(TextField).first;

        await tester.enterText(amountField, '30000');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(tester.widget<TextField>(amountField).controller?.text,
            '\u20B930,000');

        await tester.enterText(amountField, '\u20B91000');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        final messageField = find.byType(TextField).last;
        expect(
            tester.widget<TextField>(messageField).focusNode?.hasFocus, isTrue);
      },
    );

    testWidgets(
      'Given a message longer than 15 characters '
      'When the message is entered '
      'Then it should be truncated with ellipsis',
      (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        final messageField = find.byType(TextField).last;

        await tester.enterText(
            messageField, 'This is a very long message exceeding limit');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();

        expect(
          tester.widget<TextField>(messageField).controller?.text,
          'This is a very ...',
        );
      },
    );
  });

  group('Amount Formatter Tests', () {
    testWidgets(
      'Given 9999999.999 '
      'When  '
      'Then the amount should be cleared or formatted correctly',
      (WidgetTester tester) async {
        // ARRANGE
        await tester.pumpWidget(createWidgetUnderTest());
        final amountField = find.byType(TextField).first;

        // ACT
        await tester.enterText(amountField, '9999999.999');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        // await tester.pumpAndSettle();

        // ASSERT
        expect(find.text('₹9,99,999.99'), findsOneWidget);

        // ARRANGE
        await tester.pumpWidget(createWidgetUnderTest());

        // ACT
        await tester.enterText(amountField, '!@#\$%^&*()ABCD1234EF56');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        // await tester.pumpAndSettle();

        // ASSERT
        expect(find.text('₹1,23,456'), findsOneWidget);

        // ACT
        await tester.enterText(amountField, '1234567');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        // await tester.pumpAndSettle();

        // ASSERT
        expect(find.text('₹1,23,456'), findsOneWidget);
        // ACT
        await tester.enterText(amountField, '1234567.123');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        // await tester.pumpAndSettle();

        // ASSERT
        expect(find.text('₹1,23,456.12'), findsOneWidget);

        // ACT
        await tester.enterText(amountField, '01');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        // await tester.pumpAndSettle();

        // ASSERT
        expect(find.text('₹0.1'), findsOneWidget);

        // ACT
        await tester.enterText(amountField, '1');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        // await tester.pumpAndSettle();

        // ASSERT
        expect(find.text('₹1'), findsOneWidget);
      },
    );
  });
}
