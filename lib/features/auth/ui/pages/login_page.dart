import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utilities/file_constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/buttons/action_button.dart';
import '../../store/auth_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authStore = Provider.of<AuthStore>(context);
    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Padding(
        padding: EdgeInsets.all(theme.spacing.width.s40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(iconPath),
            Text(
              tagLine,
              style: theme.textStyle.headingSmallMedium.copyWith(
                color: theme.colors.light,
              ),
            ),
            const Spacer(),
            if (isLoading) CircularProgressIndicator(color: theme.colors.light),
            const Spacer(),
            ActionButton(
              title: loginWGoogleText,
              padding: theme.sizing.width.s5,
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await authStore.googleLogIn();
                setState(() {
                  isLoading = false;
                });
              },
            ),
            SizedBox(height: theme.sizing.height.s40)
          ],
        ),
      ),
    );
  }
}
