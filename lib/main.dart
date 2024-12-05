import 'package:flutter/material.dart';
import 'theme/theme.dart';

void main() {
  runApp(const TacklePay());
}

class TacklePay extends StatelessWidget {
  const TacklePay({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Tackle Pay',
        theme: appTheme,
        home: HomeScreen(),
      );
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.secondary,
      body: Container(),
    );
  }
}
