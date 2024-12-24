import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/theme/theme.dart';
import 'package:tackleapp/widgets/cards/upi_card.dart';

void main() {
  group('UPICard Widget Tests', () {
    const firstName = 'jane';
    const lastName = '  Doe midd';
    const upiId = 'jane.doe@bank';

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
      'When the UPICard is rendered '
      'Then it displays the full UPI ID and initials as icon ',
      (WidgetTester tester) async {
        // Arrange
        const initialsIcon = 'JD';
        await tester.pumpWidget(
          createWidgetUnderTest(
            payeeFirstName: firstName,
            payeeLastName: lastName,
            payeeUpiId: upiId,
          ),
        );

        // Assert
        expect(find.text(initialsIcon), findsOneWidget);
        expect(find.text('${firstName.trim()} ${lastName.trim()}'),
            findsOneWidget);
        expect(find.text(upiId), findsOneWidget);
      },
    );

    testWidgets(
      'Given UPICard with long UPI ID '
      'When the UPICard is rendered '
      'Then it displays the cropped UPI ID ',
      (WidgetTester tester) async {
        // Arrange
        const longUpiId = 'janedoe.verylongemailid@somebank.com';
        const croppedUpiId = 'jane....ilid@somebank.com';

        await tester.pumpWidget(
          createWidgetUnderTest(
            payeeFirstName: firstName,
            payeeLastName: lastName,
            payeeUpiId: longUpiId,
          ),
        );

        // Assert
        expect(find.text('${firstName.trim()} ${lastName.trim()}'),
            findsOneWidget);
        expect(find.text(croppedUpiId), findsOneWidget);
      },
    );

    testWidgets(
      'Given UPICard '
      'When the UPICard is rendered '
      'Then it displays the correct background and border decorations',
      (WidgetTester tester) async {
        // Arrange
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

        expect(
          decoration.color,
          appTheme.colors.contrastLight,
        );
        final border = decoration.border as Border;
        expect(
          border.top.color,
          appTheme.colors.contrastLow,
        );
      },
    );
  });
}
