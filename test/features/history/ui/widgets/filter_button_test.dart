import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/features/history/ui/widgets/filter_button.dart';

void main() {
  group('FilterButton Widget Tests', () {
    Widget createWidgetUnderTest({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          minTextAdapt: true,
          builder: (_, __) => MaterialApp(
            home: Scaffold(
              body: FilterButton(
                icon: icon,
                title: title,
                onTap: onTap,
              ),
            ),
          ),
        );

    testWidgets(
      'Given icon and text '
      'When FilterButton is tapped '
      'Then it triggers onTap function ',
      (WidgetTester tester) async {
        // Arrange
        var wasTapped = false;
        const testTitle = 'Filter';

        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: MinyIcons.filter,
            title: testTitle,
            onTap: () => wasTapped = true,
          ),
        );

        // Act
        await tester.tap(find.byType(FilterButton));
        await tester.pump();

        // Assert
        expect(find.byIcon(MinyIcons.filter), findsOneWidget);
        expect(find.text(testTitle), findsOneWidget);
        expect(wasTapped, isTrue);
      },
    );

    testWidgets(
      'Given FilterButton widget '
      'When an icon and empty text is provided '
      'Then it renders icon only and not text',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: MinyIcons.filter,
            title: '',
            onTap: () {},
          ),
        );

        // Assert
        expect(find.byIcon(MinyIcons.filter), findsOneWidget);
        expect(find.text(''), findsNothing);
      },
    );
  });
}
