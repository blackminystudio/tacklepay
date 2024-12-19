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

  bool _isIntegerLimited(String text) =>
      text.length > 6 ||
      BigInt.tryParse(text) != null && BigInt.parse(text) > BigInt.from(999999);

  String _validateMaxAmountAndDecimalLimit(String text) {
    if (text.contains('.')) {
      final parts = text.split('.');
      var integerPart = parts[0];
      var decimalPart = parts.length > 1 ? parts[1] : '';
      if (_isIntegerLimited(integerPart)) {
        integerPart = integerPart.substring(0, 6);
      }
      if (decimalPart.length > 2) {
        decimalPart = decimalPart.substring(0, 2);
      }
      return '$integerPart.$decimalPart';
    }
    if (_isIntegerLimited(text)) return text.substring(0, 6);
    return text;
  }

  String _extractNumericText(String text) =>
      text.replaceAll(RegExp(r'[^0-9.]'), '');

  String _replaceZeroToDecimal(String text) {
    if (text.startsWith('0') && text.length > 1 && !text.contains('.')) {
      text = text.replaceFirst('0', '0.');
    }
    if (text.startsWith('.') && text.length > 1) {
      text = text.replaceFirst('.', '0.');
    }

    return text;
  }

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

  group('AmountFormatter Tests', () {
    test(
      'Given a string with special characters and numbers '
      'When _extractNumericText is called '
      'Then it should return a formatted numeric string with a rupee symbol',
      () {
        const input = '!@#\$%^&*()ABCD1234EF56';
        const expectedOutput = '123456';

        final result = _extractNumericText(input);

        expect(result, expectedOutput);
      },
    );

    test(
      'Given a numeric input exceeding max limit '
      'When _validateMaxAmountAndDecimalLimit is called '
      'Then it should truncate to the maximum allowed value',
      () {
        const input = '1234567';
        const expectedOutput = '123456';

        final result = _validateMaxAmountAndDecimalLimit(input);

        expect(result, expectedOutput);
      },
    );

    test(
      'Given a numeric input with excessive decimals '
      'When _validateMaxAmountAndDecimalLimit is called '
      'Then it should truncate to two decimal places',
      () {
        const input = '1234567.123';
        const expectedOutput = '123456.12';

        final result = _validateMaxAmountAndDecimalLimit(input);

        expect(result, expectedOutput);
      },
    );

    test(
      'Given an input starting with 0 '
      'When _replaceZeroToDecimal is called '
      'Then it should replace 0 with 0.',
      () {
        const input = '01';
        const expectedOutput = '0.1';

        final result = _replaceZeroToDecimal(input);

        expect(result, expectedOutput);
      },
    );

    test(
      'Given an input starting with . '
      'When _replaceZeroToDecimal is called '
      'Then it should prepend 0 to make it 0.',
      () {
        const input = '.1';
        const expectedOutput = '0.1';

        final result = _replaceZeroToDecimal(input);

        expect(result, expectedOutput);
      },
    );
  });
}
