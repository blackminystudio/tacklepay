import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/theme/tokens/color_tokens.dart';
import 'package:tackleapp/widgets/pay_date_dropdown.dart';
import 'package:tackleapp/widgets/string_constants.dart';

void main() {
  Widget buildTestableWidget(Widget child) => ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        builder: (context, _) => MaterialApp(
          home: Scaffold(
            body: child,
          ),
        ),
      );

  group('PayDateDropdown Widget Test', () {
    testWidgets(
        'Given the payDateDropdown widget '
        'When it is rendered '
        'Then today\'s date is visible ', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(PayDateDropdown()));

      final initialDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      // Verify that today's date is displayed
      expect(find.text(initialDate), findsOneWidget);
      expect(
        tester.widget<Text>(find.text(initialDate)).style?.color,
        ColorTokens.contrastDark,
      );

      // Also check payDateText and icon are displayed
      expect(find.text(payDateText), findsOneWidget);
      expect(find.byIcon(MinyIcons.outlineArrowUp), findsOneWidget);
    });

    testWidgets(
        'Given the payDateDropdown widget '
        'When it is tapped on '
        'Then a datepicker pops up ', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(PayDateDropdown()));

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      expect(find.byType(CalendarDatePicker), findsOneWidget);
    });

    testWidgets(
      'Given the payDateDropdown widget '
      'When it is tapped on and datepicker opens '
      'Then we can select any date ',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestableWidget(PayDateDropdown()));

        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        expect(find.byType(CalendarDatePicker), findsOneWidget);

        await tester.tap(find.text('1'));
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        final formattedDate =
            DateFormat('dd/MM/yyyy').format(DateTime.now().copyWith(day: 1));

        expect(find.text(formattedDate), findsOneWidget);
      },
    );

    testWidgets(
      'Given the payDateDropdown widget '
      'When it is tapped on and datepicker opens '
      'Then we can not select date later than today ',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestableWidget(PayDateDropdown()));

        await tester.tap(find.byType(GestureDetector));
        await tester.pumpAndSettle();

        expect(find.byType(CalendarDatePicker), findsOneWidget);

        await tester.tap(find.text('21'));
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        final formattedDate =
            DateFormat('dd/MM/yyyy').format(DateTime.now().copyWith(day: 21));
        expect(find.text(formattedDate), findsNothing);
      },
    );
  });
}
