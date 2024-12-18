import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/widgets/filter_button.dart';

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
      'When rendered '
      'Then it triggers onTap and shows both. ',
      (WidgetTester tester) async {
        var wasTapped = false;

        // Arrange
        const testIcon = Icons.filter_list;
        const testTitle = 'Filter';

        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: testIcon,
            title: testTitle,
            onTap: () => wasTapped = true,
          ),
        );

        // Act
        await tester.tap(find.byType(FilterButton));
        await tester.pump();

        // Assert
        expect(find.byIcon(testIcon), findsOneWidget);
        expect(find.text(testTitle), findsOneWidget);
        expect(wasTapped, isTrue);
      },
    );

    testWidgets(
      'Given only icon, '
      'When rendered, '
      'Then it triggers icon only and not text',
      (WidgetTester tester) async {
        // Arrange
        const testIcon = Icons.filter_list;

        await tester.pumpWidget(
          createWidgetUnderTest(
            icon: testIcon,
            title: '',
            onTap: () {},
          ),
        );

        // Assert
        expect(find.byIcon(testIcon), findsOneWidget);
        expect(find.text(''), findsNothing);
      },
    );
  });
}
