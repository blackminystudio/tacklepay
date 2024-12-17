import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/cards/upi_card.dart';

void main() {
  group('UPICard Widget Tests', () {
    Widget createWidgetUnderTest({
      required String payeeFirstName,
      required String payeeLastName,
      required String payeeUpiId,
    }) =>
        ScreenUtilInit(
          designSize: const Size(440, 956),
          builder: (context, child) => MaterialApp(
            theme: appTheme,
            home: Scaffold(
              body: UPICard(
                payeeFirstName: payeeFirstName,
                payeeLastName: payeeLastName,
                payeeUpiId: payeeUpiId,
              ),
            ),
          ),
        );

    testWidgets(
      'Given UPICard with short UPI ID '
      'Then it should display the full UPI ID without cropping',
      (WidgetTester tester) async {
        // Arrange
        const firstName = 'John';
        const lastName = 'Doe';
        const upiId = 'john.doe@bank';

        await tester.pumpWidget(
          createWidgetUnderTest(
            payeeFirstName: firstName,
            payeeLastName: lastName,
            payeeUpiId: upiId,
          ),
        );

        // Assert
        expect(find.text('$firstName $lastName'), findsOneWidget);
        expect(find.text(upiId), findsOneWidget);
      },
    );

    testWidgets(
      'Given UPICard with long UPI ID '
      'Then it should display the cropped UPI ID',
      (WidgetTester tester) async {
        // Arrange
        const firstName = 'Alice';
        const lastName = 'Smith';
        const longUpiId = 'alice.smith.verylongemail@somebank.com';

        await tester.pumpWidget(
          createWidgetUnderTest(
            payeeFirstName: firstName,
            payeeLastName: lastName,
            payeeUpiId: longUpiId,
          ),
        );

        // Correct cropped UPI ID
        const croppedUpiId = 'alic....mail@somebank.com';

        // Assert
        expect(find.text('$firstName $lastName'), findsOneWidget);
        expect(find.text(croppedUpiId), findsOneWidget);
      },
    );

    testWidgets(
      'Given UPICard with valid initials '
      'Then it should display the correct initials in the icon',
      (WidgetTester tester) async {
        // Arrange
        const firstName = 'John';
        const lastName = 'Doe';
        const upiId = 'john.doe@bank';

        await tester.pumpWidget(
          createWidgetUnderTest(
            payeeFirstName: firstName,
            payeeLastName: lastName,
            payeeUpiId: upiId,
          ),
        );

        // Assert
        expect(find.text('JD'), findsOneWidget);
      },
    );

    testWidgets(
      'Given UPICard '
      'Then it should display the correct background and border decorations',
      (WidgetTester tester) async {
        // Arrange
        const firstName = 'Jane';
        const lastName = 'Doe';
        const upiId = 'jane.doe@bank';

        await tester.pumpWidget(
          createWidgetUnderTest(
            payeeFirstName: firstName,
            payeeLastName: lastName,
            payeeUpiId: upiId,
          ),
        );

        final containerFinder = find
            .descendant(
              of: find.byType(UPICard),
              matching: find.byType(Container),
            )
            .first;

        // Assert
        final container = tester.widget<Container>(containerFinder);
        final decoration = container.decoration as BoxDecoration;

        // Check background color
        expect(
          decoration.color,
          appTheme.colors.contrastLight,
        );

        // Check border color
        final border = decoration.border as Border;
        expect(
          border.top.color,
          appTheme.colors.contrastLow,
        );
      },
    );
  });
}
