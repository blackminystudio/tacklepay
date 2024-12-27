import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/cards/summary_preview_card.dart';
import 'package:tackleapp/widgets/string_constants.dart';

import '../constants/key_constants.dart';

void main() {
  group(
    'SummaryPreviewCard Widget Tests',
    () {
      final richTextFinder = find.byKey(richTextFinderKey);
      const amount = '500000';
      const formattedamount = '₹5,00,000';
      const positivePercentage = '+10';
      const negativePercentage = '-10';

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
        'When amount and positive percentage is provided '
        'Then it displays "Income" and primary background color',
        (WidgetTester tester) async {
          // Arrange
          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.income,
            amount: amount,
            percentage: positivePercentage,
          ));

          // Assert
          expect(find.text(incomeText), findsOneWidget);
          expect(find.text(formattedamount), findsOneWidget);

          final headerContainer = tester.widget<Container>(
            find.descendant(
                of: find.byType(SummaryPreviewCard),
                matching: find.byType(Container).last),
          );

          expect(
            (headerContainer.decoration as BoxDecoration).color,
            appTheme.colors.primary,
          );

          final richText = tester.widget<RichText>(richTextFinder);
          final textSpan = richText.text as TextSpan;
          final children = textSpan.children as List<InlineSpan>;
          expect(children[0].toPlainText(), '$positivePercentage%');
          expect(children[0].style?.color, appTheme.colors.primaryDark);
          expect(children[1].toPlainText(), vsLastMonthText);
          expect(children[1].style?.color, appTheme.colors.contrastDark);
        },
      );

      testWidgets(
        'Given SummaryPreviewCard with HeaderType.expense '
        'When amount and positive percentage is provided '
        'Then it displays "Expense" and secondary background color',
        (WidgetTester tester) async {
          // Arrange
          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.expense,
            amount: amount,
            percentage: positivePercentage,
          ));

          // Assert
          expect(find.text(expenseText), findsOneWidget);
          expect(find.text(formattedamount), findsOneWidget);

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

          final richText = tester.widget<RichText>(richTextFinder);
          final textSpan = richText.text as TextSpan;
          final children = textSpan.children as List<InlineSpan>;
          expect(children[0].toPlainText(), '$positivePercentage%');
          expect(children[0].style?.color, appTheme.colors.secondaryDark);
          expect(children[1].toPlainText(), vsLastMonthText);
          expect(children[1].style?.color, appTheme.colors.contrastDark);
        },
      );

      testWidgets(
        'Given SummaryPreviewCard with HeaderType.income '
        'When amount and negative percentage is provided '
        'Then it displays the correct styles',
        (WidgetTester tester) async {
          // Arrange
          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.income,
            amount: amount,
            percentage: negativePercentage,
          ));

          // Assert
          expect(find.text(incomeText), findsOneWidget);
          expect(find.text(formattedamount), findsOneWidget);

          final richText = tester.widget<RichText>(richTextFinder);
          final textSpan = richText.text as TextSpan;
          final children = textSpan.children as List<InlineSpan>;
          expect(children[0].toPlainText(), '$negativePercentage%');
          expect(children[0].style?.color, appTheme.colors.secondaryDark);
          expect(children[1].toPlainText(), vsLastMonthText);
          expect(children[1].style?.color, appTheme.colors.contrastDark);
        },
      );

      testWidgets(
        'Given SummaryPreviewCard with HeaderType.expense '
        'When amount and negative percentage is provided '
        'Then it displays the correct styles',
        (WidgetTester tester) async {
          // Arrange
          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.expense,
            amount: amount,
            percentage: negativePercentage,
          ));

          // Assert
          expect(find.text(expenseText), findsOneWidget);
          expect(find.text(formattedamount), findsOneWidget);

          final richText = tester.widget<RichText>(richTextFinder);
          final textSpan = richText.text as TextSpan;
          final children = textSpan.children as List<InlineSpan>;
          expect(children[0].toPlainText(), '$negativePercentage%');
          expect(children[0].style?.color, appTheme.colors.primaryDark);
          expect(children[1].toPlainText(), vsLastMonthText);
          expect(children[1].style?.color, appTheme.colors.contrastDark);
        },
      );

      testWidgets(
        'Given SummaryPreviewCard with HeaderType.expense '
        'When amount and 0 percentage is provided '
        'Then it displays the correct styles',
        (WidgetTester tester) async {
          // Arrange
          await tester.pumpWidget(createWidgetUnderTest(
            header: HeaderType.expense,
            amount: amount,
            percentage: checkZero,
          ));

          // Assert
          expect(find.text(expenseText), findsOneWidget);
          expect(find.text(formattedamount), findsOneWidget);

          final richText = tester.widget<RichText>(richTextFinder);
          final textSpan = richText.text as TextSpan;
          final children = textSpan.children as List<InlineSpan>;
          expect(children[0].toPlainText(), '$checkZero%');
          expect(children[0].style?.color, appTheme.colors.contrastDark);
          expect(children[1].toPlainText(), vsLastMonthText);
          expect(children[1].style?.color, appTheme.colors.contrastDark);
        },
      );
    },
  );
}
