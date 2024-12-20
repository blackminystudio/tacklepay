import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../flavors.dart';

import '../../../main.dart' as runner;
import '../firebase_options/firebase_options_prod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flavors.appFlavor = FlavorTypes.prod;
  await Firebase.initializeApp(
    options: ProdFirebaseOptions.currentPlatform,
  );
  await runner.main();
}
