import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import '../firebase_options/firebase_options_staging.dart';
import '../flavors.dart';
import '../main.dart' as runner;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flavors.appFlavor = FlavorTypes.staging;
  await Firebase.initializeApp(
    options: StagingFirebaseOptions.currentPlatform,
  );
  await runner.main();
}
