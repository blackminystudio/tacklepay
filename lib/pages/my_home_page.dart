import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../flavors.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(Flavors.title)),
        body: Center(
          child: Column(
            children: [
              Text('Hello ${Flavors.title}'),
              ElevatedButton(
                onPressed: () async {
                  await testWriteData();
                },
                child: const Text('add Data'),
              )
            ],
          ),
        ),
      );
}

Future<void> testWriteData() async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': 'Test User',
    'createdAt': DateTime.now(),
  });
}
