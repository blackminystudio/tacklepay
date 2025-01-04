import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await FirebaseService.initialize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, _) => const TacklePay(),
    ),
  );
}
