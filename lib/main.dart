import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'flavors.dart';

Future<void> main() async {
  await createDummyData(Flavors.name, Platform.isAndroid ? 'Android' : 'iOS');
  runApp(const App());
}

Future<void> createDummyData(String flavor, String platform) async {
  try {
    final firestore = FirebaseFirestore.instance;
    final data = {'message': 'Welcome to $flavor on $platform'};
    await firestore.collection('TacklePayDev').add(data);
    print('Dummy data created successfully!');
  } catch (e) {
    print('Failed to create dummy data: $e');
  }
}
