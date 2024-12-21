import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/config/firebase_options/firebase_config.dart';

Future<void> main() async {
  await FirebaseService.initialize();
  runApp(const App());
}
