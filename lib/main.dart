import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'theme/theme.dart';
import 'widgets/pay_date_dropdown.dart';
import 'widgets/string_constants.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956), // Base design size (width x height)
      minTextAdapt: true,
      builder: (context, _) => const TacklePay(),
    ),
  );
}

class TacklePay extends StatelessWidget {
  const TacklePay({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        theme: appTheme,
        home: HomeScreen(),
      );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.light,
      body: Center(child: PayDateDropdown()),
    );
  }
}
