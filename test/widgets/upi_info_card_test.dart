import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/widgets/string_constants.dart';
import 'package:tackleapp/widgets/upi_info_card.dart';

import 'constants/key_constants.dart';

void main() {
  Widget _upiInfoCard() => ScreenUtilInit(
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
      'Given UpiInfoCard '
      'When it renders '
      'Then it shows "amount", "message" and divider ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        final upiInfoDividerFinder = find.byKey(upiInfoDividerFinderKey);

        // Assert
        expect(find.text(amountText), findsOneWidget);
        expect(find.text(messageText), findsOneWidget);
        expect(upiInfoDividerFinder, findsOneWidget);
      },
    );

    testWidgets(
      'Given the amount field '
      'When any combination of "0", "." or "₹" is entered '
      'Then the amount field is cleared ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        final amountField = find.byType(TextField).first;
        const doubleZeros = '00';
        const rupeeWithZero = '₹0';
        const rupeeWithDecimal = '₹.';
        const rupeeWithZeroAndDecimal = '₹0.';
        const rupeeWithTwoDecimalZeros = '₹0.00';
        const rupeeWithSingleDecimalZero = '₹0.0';

        // Act
        await tester.enterText(amountField, rupeeSymbol);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        var output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isEmpty);

        // Act
        await tester.enterText(amountField, rupeeWithDecimal);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isEmpty);

        // Act
        await tester.enterText(amountField, rupeeWithZero);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;
        await tester.enterText(amountField, doubleZeros);
        // Assert

        expect(output, isEmpty);
        // Act

        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isEmpty);

        // Act
        await tester.enterText(amountField, rupeeWithZeroAndDecimal);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isEmpty);

        // Act
        await tester.enterText(amountField, rupeeWithSingleDecimalZero);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isEmpty);

        // Act
        await tester.enterText(amountField, rupeeWithTwoDecimalZeros);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isEmpty);
      },
    );
    testWidgets(
      'Given the amount field '
      'When any combination except "0", "." or "₹" is entered '
      'Then the amount field is not cleared ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        final amountField = find.byType(TextField).first;
        const rupeeOne = '₹1';
        const rupeeTen = '₹10';
        const rupeeOneWithDecimal = '₹1.';
        const rupeeTenWithTwoDecimals = '₹10.00';
        const rupeeTenWithSingleDecimal = '₹10.0';

        // Act
        await tester.enterText(amountField, rupeeOne);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        var output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isNotEmpty);

        // Act
        await tester.enterText(amountField, rupeeOneWithDecimal);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isNotEmpty);

        // Act
        await tester.enterText(amountField, rupeeTen);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isNotEmpty);

        // Act
        await tester.enterText(amountField, rupeeTenWithSingleDecimal);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isNotEmpty);

        // Act
        await tester.enterText(amountField, rupeeTenWithTwoDecimals);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(amountField).controller?.text;

        // Assert
        expect(output, isNotEmpty);
      },
    );
  });

  group('Message Field Tests', () {
    testWidgets(
      'Given the amount field '
      'When any value is submitted '
      'Then it shifts focus to the message field ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        final amountField = find.byType(TextField).first;

        // Act
        await tester.enterText(amountField, '');
        await tester.testTextInput.receiveAction(TextInputAction.done);

        final textField = find.byType(TextField).last;
        final messageField = tester.widget<TextField>(textField).focusNode;

        // Assert
        expect(messageField?.hasFocus, isTrue);
      },
    );

    testWidgets(
      'Given the message field '
      'When a long message is entered and tapped again '
      'Then it is truncated and full message is restored again',
      (WidgetTester tester) async {
        // Arrange
        const longText = 'This is a very long message exceeding limit';
        const expectedText = 'This is a very ...';
        await tester.pumpWidget(_upiInfoCard());
        final messageField = find.byType(TextField).last;
        var output = tester.widget<TextField>(messageField).controller?.text;

        // Act
        await tester.enterText(messageField, longText);
        await tester.testTextInput.receiveAction(TextInputAction.done);
        output = tester.widget<TextField>(messageField).controller?.text;

        // Assert: Ensure the message is truncated
        expect(output, expectedText);

        // Act: Tap the message field
        await tester.tap(messageField);
        await tester.pumpAndSettle();
        output = tester.widget<TextField>(messageField).controller?.text;

        // Assert: Full message is restored
        expect(output, longText);
      },
    );
  });

  group('Amount Formatter Tests', () {
    final amountField = find.byType(TextField).first;
    testWidgets(
      'Given the amount exceeds maximum value '
      'When "9999999.999" is entered '
      'Then it is formatted as "₹9,99,999.99" ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        const largeAmount = '9999999.999';
        const formattedAmount = '₹9,99,999.99';

        // Act
        await tester.enterText(amountField, largeAmount);
        await tester.testTextInput.receiveAction(TextInputAction.done);

        // Assert
        expect(find.text(formattedAmount), findsOneWidget);
      },
    );

    testWidgets(
      'Given an amount with invalid characters '
      'When "!@#\$%^&*()ABCD1234EF56" is entered '
      'Then it is formatted as "₹1,23,456" ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        const invalidAmount = '!@#\$%^&*()ABCD1234EF56';
        const formattedAmount = '₹1,23,456';

        // Act
        await tester.enterText(amountField, invalidAmount);
        await tester.testTextInput.receiveAction(TextInputAction.done);

        // Assert
        expect(find.text(formattedAmount), findsOneWidget);
      },
    );

    testWidgets(
      'Given an amount starting with "0" '
      'When "01" is entered '
      'Then it is formatted as "₹0.1"',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        const amount = '01';
        const formattedAmount = '₹0.1';

        // Act
        await tester.enterText(amountField, amount);
        await tester.testTextInput.receiveAction(TextInputAction.done);

        // Assert
        expect(find.text(formattedAmount), findsOneWidget);
      },
    );

    testWidgets(
      'Given the amount field contains extra whitespace '
      'When "  1000  " is entered '
      'Then it is formatted as "₹1,000"',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        const amount = '  1000  ';
        const formattedAmount = '₹1,000';

        // Act: Enter amount with extra whitespace
        await tester.enterText(amountField, amount);
        await tester.testTextInput.receiveAction(TextInputAction.done);

        // Assert: Expect formatted and trimmed amount
        expect(find.text(formattedAmount), findsOneWidget);
      },
    );

    testWidgets(
      'Given a negative amount '
      'When "-100" is entered '
      'Then it is formatted as "₹100" ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        const negativeAmount = '-100';
        const formattedAmount = '₹100';

        // Act
        await tester.enterText(amountField, negativeAmount);
        await tester.testTextInput.receiveAction(TextInputAction.done);

        // Assert
        expect(find.text(formattedAmount), findsOneWidget);
      },
    );

    testWidgets(
      'Given an amount starting with "." '
      'When ".1" is entered '
      'Then it is formatted as "₹0.1"',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(_upiInfoCard());
        const decimalAmount = '.1';
        const formattedAmount = '₹0.1';

        // Act
        await tester.enterText(amountField, decimalAmount);
        await tester.testTextInput.receiveAction(TextInputAction.done);

        // Assert
        expect(find.text(formattedAmount), findsOneWidget);
      },
    );
  });
}
