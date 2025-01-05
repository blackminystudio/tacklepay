import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../pages/home_screen.dart';
import '../theme/theme.dart';
import '../widgets/string_constants.dart';
import 'flavors.dart';

Widget _flavorBanner({
  required Widget child,
  bool show = true,
  required ThemeData theme,
}) =>
    !show
        ? child
        : Banner(
            location: BannerLocation.topEnd,
            message: Flavors.name,
            color: Colors.amber.withAlpha(60),
            textStyle: theme.textStyle.bodyBold,
            textDirection: TextDirection.ltr,
            child: child,
          );

class TacklePay extends StatelessWidget {
  const TacklePay({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: _flavorBanner(
            theme: Theme.of(context),
            // App Entry
            child: AuthWrapper()),
      );
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      );
}
