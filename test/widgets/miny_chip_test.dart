import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/miny_chip.dart';

void main() {
  group('MinyChip Widget Tests', () {
    const label = 'Toggle Chip';
    Widget createWidgetUnderTest({
      required String label,
      required bool selected,
      void Function(bool)? onSelected,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            theme: appTheme,
            home: Material(
              child: MinyChip(
                label: label,
                selected: selected,
                onSelected: onSelected,
              ),
            ),
          ),
        );

    testWidgets(
      'Given MinyChip is selected '
      'When the widget is rendered '
      'Then it has contrastDark color bg, light color text and a check icon ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(
          label: label,
          selected: true,
          onSelected: (_) {},
        ));

        // Assert
        final container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration as BoxDecoration).color,
          appTheme.colors.contrastDark,
        );

        final textWidget = tester.widget<Text>(find.text(label));
        expect(textWidget.style!.color, appTheme.colors.light);

        expect(find.byIcon(MinyIcons.check), findsOneWidget);
      },
    );

    testWidgets(
      'Given MinyChip is not selected '
      'When the widget is rendered '
      'Then it has contrastLow color bg, contrastDark color text and no icon ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(createWidgetUnderTest(
          label: label,
          selected: false,
          onSelected: (_) {},
        ));

        // Assert
        final container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration as BoxDecoration).color,
          appTheme.colors.contrastLow,
        );

        final textWidget = tester.widget<Text>(find.text(label));
        expect(textWidget.style!.color, appTheme.colors.contrastDark);
        expect(find.byIcon(MinyIcons.check), findsNothing);
      },
    );

    /// No longer required as now the updated minychip is
    /// dependent on the parent widget
    ///
    ///
    ///
    // testWidgets(
    //   'Given MinyChip is rendered '
    //   'When it is tapped '
    //   'Then it switches from non-selected to selected state ',
    //   (WidgetTester tester) async {
    //     // Arrange
    //     var isSelected = false;

    //     await tester.pumpWidget(createWidgetUnderTest(
    //       label: label,
    //       selected: isSelected,
    //       onSelected: (value) => isSelected = value,
    //     ));

    //     // Act
    //     await tester.tap(find.text(label));
    //     await tester.pumpAndSettle();

    //     // Assert
    //     var container = tester.widget<Container>(find.byType(Container));
    //     expect(
    //       (container.decoration as BoxDecoration).color,
    //       appTheme.colors.contrastDark,
    //     );
    //     expect(find.byIcon(MinyIcons.check), findsOneWidget);

    //     // Act
    //     await tester.tap(find.text(label));
    //     await tester.pumpAndSettle();

    //     // Assert
    //     container = tester.widget<Container>(find.byType(Container));
    //     expect(
    //       (container.decoration as BoxDecoration).color,
    //       appTheme.colors.contrastLow,
    //     );
    //     expect(find.byIcon(MinyIcons.check), findsNothing);
    //   },
    // );
  });
}
