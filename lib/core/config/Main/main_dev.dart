import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../flavors.dart';
import '../../main.dart' as runner;
import '../firebase_options/firebase_options_dev.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Dev Firebase environment
  Flavors.appFlavor = FlavorTypes.dev;
  await Firebase.initializeApp(
    options: DevFirebaseOptions.currentPlatform,
  );
  await runner.main();
}
