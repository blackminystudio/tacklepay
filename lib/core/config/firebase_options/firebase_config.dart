// lib/core/config/firebase_options/firebase_config.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static const bool useEmulator = bool.fromEnvironment(
    'USE_FIREBASE_EMULATOR',
  );

  static Future<void> initialize() async {
    await Firebase.initializeApp();

    if (useEmulator) {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }
  }
}
