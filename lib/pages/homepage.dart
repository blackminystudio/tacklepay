import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/flavors.dart';
import '../features/auth/store/auth_store.dart';
import '../theme/theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authStore = Provider.of<AuthStore>(context);
    return Scaffold(
      backgroundColor: theme.colors.light,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello ${Flavors.title}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authStore.googleLogout();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> testWriteData() async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': 'Test User',
    'createdAt': DateTime.now(),
  });
}
