import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/extensions/miny_border_radius.dart';
import 'package:tackleapp/theme/extensions/miny_colors.dart';
import 'package:tackleapp/theme/extensions/miny_sizing.dart';
import 'package:tackleapp/widgets/filter_button.dart';

void main() {
  const minyColors = MinyColors();
  const minyBorderRadius = MinyBorderRadius();
  final minySizing = MinySizing();

  group('FilterButton Widget Tests', () {
    Widget createWidgetUnderTest({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
      required ThemeData theme,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (_, __) => MaterialApp(
            theme: theme,
            home: Scaffold(
              body: FilterButton(
                icon: icon,
                title: title,
                onTap: onTap,
              ),
            ),
          ),
        );

    const testIcon = Icons.filter_list;
    const testTitle = 'Filter';

    testWidgets(
      'Given FilterButton is rendered, '
      'When it loads, '
      'Then it displays the icon and title correctly',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: testIcon,
            title: testTitle,
            onTap: () {},
            theme: ThemeData(
              primaryColor: minyColors.contrastDark,
            ),
          ),
        );

        // Assert
        expect(find.byIcon(testIcon), findsOneWidget);
        expect(find.text(testTitle), findsOneWidget);
      },
    );

    testWidgets(
      'Given FilterButton is rendered, '
      'When it is tapped, '
      'Then it triggers the onTap callback',
      (WidgetTester tester) async {
        // Arrange
        var wasTapped = false;

        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: testIcon,
            title: testTitle,
            onTap: () {
              wasTapped = true;
            },
            theme: ThemeData(
              primaryColor: minyColors.contrastDark,
            ),
          ),
        );

        // Act
        await tester.tap(find.byType(FilterButton));
        await tester.pump();

        // Assert
        expect(wasTapped, isTrue);
      },
    );

    testWidgets(
      'Given FilterButton is rendered, '
      'When it is interacted with, '
      'Then it applies the correct decoration and padding',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: testIcon,
            title: testTitle,
            onTap: () {},
            theme: ThemeData(
              primaryColor: minyColors.contrastDark,
            ),
          ),
        );

        // Act
        final containerFinder = find.byType(Container);
        final container = tester.widget<Container>(containerFinder);

        // Assert
        expect(
            container.padding,
            EdgeInsets.symmetric(
                horizontal: minySizing.width.s10,
                vertical: minySizing.height.s4));

        final decoration = container.decoration as BoxDecoration;
        expect(decoration, isNotNull);
        expect(decoration.borderRadius,
            BorderRadius.circular(minyBorderRadius.small));
        expect(decoration.color, minyColors.contrastLight);
      },
    );

    testWidgets(
      'Given FilterButton with custom onTap, '
      'When it is tapped, '
      'Then it performs the expected custom action',
      (WidgetTester tester) async {
        var wasCustomActionCalled = false;

        // Arrange
        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: testIcon,
            title: testTitle,
            onTap: () {
              wasCustomActionCalled = true;
            },
            theme: ThemeData(
              primaryColor: minyColors.contrastDark,
            ),
          ),
        );

        // Act
        await tester.tap(find.byType(FilterButton));
        await tester.pump();

        // Assert
        expect(wasCustomActionCalled, isTrue);
      },
    );
    testWidgets(
      'Given FilterButton has a custom icon, '
      'When it is rendered, '
      'Then it should display the custom icon correctly',
      (WidgetTester tester) async {
        const customIcon = Icons.star;

        // Arrange
        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: customIcon,
            title: testTitle,
            onTap: () {},
            theme: ThemeData(
              primaryColor: minyColors.contrastDark,
            ),
          ),
        );

        // Act
        expect(find.byIcon(customIcon), findsOneWidget);
      },
    );
    testWidgets(
      'Given FilterButton with light theme, '
      'When it is rendered, '
      'Then it should display with light theme colors',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: testIcon,
            title: testTitle,
            onTap: () {},
            theme: ThemeData.light(),
          ),
        );

        // Assert
        expect(find.byIcon(testIcon), findsOneWidget);
        expect(find.text(testTitle), findsOneWidget);
      },
    );
  });
}
