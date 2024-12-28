import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import '../firebase_options/firebase_options_dev.dart';
import '../flavors.dart';
import '../main.dart' as runner;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flavors.appFlavor = FlavorTypes.dev;
  await Firebase.initializeApp(
    options: DevFirebaseOptions.currentPlatform,
  );
  await runner.main();
}
