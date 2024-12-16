import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tackleapp/widgets/balance_amount.dart';
import 'package:tackleapp/widgets/string_constants.dart';

void main() {
  testWidgets(
      'Given correct balanceamount ... '
      'when BalanceAmount is render  ... '
      'Then it should show correct text ... ', (tester) async {
    // arrange

    // act
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(440, 956), // Base design size (width x height)
        minTextAdapt: true,
        builder: (context, _) => const MaterialApp(
          home: Scaffold(
            body: BalanceAmount(balanceamount: '10000'),
          ),
        ),
      ),
    );
    //assert
    expect(find.text('10000'), findsOneWidget);
    expect(find.text(balanceAmountText), findsOneWidget);
  });
}
