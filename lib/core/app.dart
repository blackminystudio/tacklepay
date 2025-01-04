import 'package:flutter/material.dart';

import '../pages/homepage.dart';
import '../theme/theme.dart';
import '../widgets/string_constants.dart';
// import 'flavors.dart';

// Widget _flavorBanner({
//   required Widget child,
//   bool show = true,
//   required ThemeData theme,
// }) =>
//     !show
//         ? child
//         : Banner(
//             location: BannerLocation.topEnd,
//             message: Flavors.name,
//             color: Colors.amber.withAlpha(60),
//             textStyle: theme.textStyle.bodyBold,
//             textDirection: TextDirection.ltr,
//             child: child,
//           );

class TacklePay extends StatelessWidget {
  const TacklePay({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        // App Entry
        home: HomeScreen(),
      );
}
