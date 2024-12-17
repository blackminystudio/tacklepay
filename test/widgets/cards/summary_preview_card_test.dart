import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/cards/summary_preview_card.dart';

void main() {
  group(
    'SummaryPreviewCard Widget Tests',
    () {
      Widget createWidgetUnderTest({
        required HeaderType header,
        required String amount,
        required String percentage,
      }) =>
          ScreenUtilInit(
            designSize: const Size(440, 956),
            minTextAdapt: true,
            builder: (context, child) => MaterialApp(
              theme: appTheme,
              home: Scaffold(
                body: SummaryPreviewCard(
                  header: header,
                  amount: amount,
                  percentage: percentage,
                ),
              ),
            ),
          );

      testWidgets(
        'Given SummaryPreviewCard with HeaderType.income '
        'Then it should display "Income" and primary background color',
        (WidgetTester tester) async {
          // Arrange
          const amount = '5000';
          const percentage = '10';

          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.income,
            amount: amount,
            percentage: percentage,
          ));

          expect(find.text('Income'), findsOneWidget);

          final headerContainer = tester.widget<Container>(
            find.descendant(
                of: find.byType(SummaryPreviewCard),
                matching: find.byType(Container).last),
          );

          expect(
            (headerContainer.decoration as BoxDecoration).color,
            appTheme.colors.primary,
          );
        },
      );

      testWidgets(
        'Given SummaryPreviewCard with HeaderType.expense '
        'Then it should display "Expense" and secondary background color',
        (WidgetTester tester) async {
          // Arrange
          const amount = '2000';
          const percentage = '5';

          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.expense,
            amount: amount,
            percentage: percentage,
          ));

          // Assert
          expect(find.text('Expense'), findsOneWidget);
          final container = tester.widget<Container>(find
              .descendant(
                  of: find.byType(SummaryPreviewCard),
                  matching: find.byType(
                    Container,
                  ))
              .last);

          expect(
            (container.decoration as BoxDecoration).color,
            appTheme.colors.secondary,
          );
        },
      );

      testWidgets(
        'Given SummaryPreviewCard '
        'Then it should display the correct amount with ₹ symbol',
        (WidgetTester tester) async {
          // Arrange
          const amount = '5000';
          const percentage = '10';

          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.income,
            amount: amount,
            percentage: percentage,
          ));

          // Assert
          expect(find.text('₹5000'), findsOneWidget);
        },
      );

      testWidgets(
        'Given SummaryPreviewCard '
        'Then it should display the correct percentage &"vs last month" text',
        (WidgetTester tester) async {
          // Arrange
          const amount = '5000';
          const percentage = '10';

          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.income,
            amount: amount,
            percentage: percentage,
          ));

          final textWidgets =
              tester.widgetList<Text>(find.byType(Text)).toList();

          expect(textWidgets[1].data, contains('₹$amount'));
        },
      );
    },
  );
}
