import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/miny_chip.dart';
import 'package:tackleapp/theme/theme.dart';

void main() {
  group('MinyChip Color and Decoration Tests', () {
    Widget createWidgetUnderTest({
      required String label,
      required bool selected,
      void Function(bool)? onSelected,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956), // Base design size (width x height)
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
      'Then it should have primary color as background, light color for text',
      (WidgetTester tester) async {
        // Arrange
        const label = 'Selected Chip';

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
      },
    );

    testWidgets(
      'Given MinyChip is not selected '
      'When the widget is rendered '
      'Then its secondary color as background, contrastDark color for text',
      (WidgetTester tester) async {
        // Arrange
        const label = 'Unselected Chip';

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
      },
    );

    testWidgets(
      'Given MinyChip with onSelected callback '
      'When it is tapped '
      'Then it should toggle the background color between primary & secondary',
      (WidgetTester tester) async {
        // Arrange
        const label = 'Toggle Chip';
        var isSelected = false;

        await tester.pumpWidget(createWidgetUnderTest(
          label: label,
          selected: isSelected,
          onSelected: (value) => isSelected = value,
        ));

        // Act
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();

        // Assert:
        var container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration as BoxDecoration).color,
          appTheme.colors.contrastDark,
        );

        // Act:
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();

        // Assert:
        container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration as BoxDecoration).color,
          appTheme.colors.contrastLow,
        );
      },
    );
  });
}
