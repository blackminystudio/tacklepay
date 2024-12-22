import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app.dart';
import 'firebase_options/firebase_config.dart';

FutureOr<void> main() async {
  await FirebaseService.initialize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, _) => const TacklePay(),
    ),
  );
}
