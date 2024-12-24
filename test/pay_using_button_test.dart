import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/pay_using_button.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/string_constants.dart';

void main() {
  group('PayUsingButton Widget Tests', () {
    final listOfPayUsing = [
      PayUsingModel(
        'https://example.com/image1.png',
        'Provider 1',
        'prefix1',
      ),
      PayUsingModel(
        'https://example.com/image2.png',
        'Provider 2',
        'prefix2',
      ),
      PayUsingModel(
        'https://example.com/image3.png',
        'Provider 3',
        'prefix3',
      ),
    ];

    Widget buildTestableWidget(Widget child) => ScreenUtilInit(
          designSize: const Size(440, 956),
          builder: (context, widget) => MaterialApp(
            home: Scaffold(
              body: SizedBox(
                child: child,
              ),
            ),
          ),
        );

    testWidgets(
        'Given the payUsingButton widget '
        'When rendered correctly '
        'Then it displays the first payment method',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          PayUsingButton(
            listOfPayUsing: listOfPayUsing,
          ),
        ),
      );

      expect(find.byType(GestureDetector), findsNWidgets(1));
      expect(find.text('Provider 1'), findsOneWidget);
      expect(find.text('Provider 2'), findsNothing);
      expect(find.text(payUsingText), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) =>
              widget is Image &&
              widget.image
                  .toString()
                  .contains('https://example.com/image1.png')),
          findsOneWidget);

      expect(find.byIcon(MinyIcons.outlineArrowUp), findsOneWidget);
    });

    testWidgets(
        'Given the payUsingButton widget '
        'When it is tapped on '
        'Then it expands to show other payment methods',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          PayUsingButton(
            listOfPayUsing: listOfPayUsing,
          ),
        ),
      );

      await tester.tap(find.text('Provider 1'));
      await tester.pumpAndSettle();

      expect(find.text('Provider 1'), findsOneWidget);
      expect(find.text('Provider 2'), findsOneWidget);
      expect(find.text('Provider 3'), findsOneWidget);
      expect(find.byIcon(MinyIcons.outlineArrowDown), findsOneWidget);
    });

    testWidgets(
        'Given the payUsingButton is tapped '
        'When another method is selected '
        'Then popup is minimised and selected one appears',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          PayUsingButton(
            listOfPayUsing: listOfPayUsing,
          ),
        ),
      );

      await tester.tap(find.text('Provider 1'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Provider 2'));
      await tester.pumpAndSettle();

      expect(find.text('Provider 2'), findsOneWidget);
      expect(find.text('Provider 1'), findsNothing);
    });

    testWidgets(
        'Given the payUsingButton is tappped '
        'When tapped on the same payment method '
        'Then popup is minimised without changing anything',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          PayUsingButton(
            listOfPayUsing: listOfPayUsing,
          ),
        ),
      );

      await tester.tap(find.text('Provider 1'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Provider 1'));
      await tester.pumpAndSettle();

      expect(find.text('Provider 1'), findsOneWidget);
      expect(find.text('Provider 2'), findsNothing);
      expect(find.text('Provider 3'), findsNothing);
    });
  });
}
