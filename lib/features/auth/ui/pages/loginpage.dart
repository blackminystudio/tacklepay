import 'package:flutter/material.dart';

import '../../../../core/utilities/file_constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/buttons/action_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Padding(
        padding: EdgeInsets.all(theme.spacing.width.s40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath),
            Text(
              tagLine,
              style: theme.textStyle.headingSmallMedium.copyWith(
                color: theme.colors.light,
              ),
            ),
            SizedBox(height: theme.sizing.height.s64),
            const ActionButton(
              title: loginWGoogleText,
            )
          ],
        ),
      ),
    );
  }
}
