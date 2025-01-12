import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
import '../core/flavors.dart';
// import '../features/auth/store/auth_store.dart';
import '../features/scanpay/ui/pages/scan_qr_page.dart';
import '../theme/theme.dart';
// import '../widgets/bottomsheet/bottomsheet_scaffold.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final authStore = Provider.of<AuthStore>(context);
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
                // await testWriteData();
                await addData();
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}

void launchQRCodePage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const QRPage(),
    ),
  );
}

Future<void> testWriteData() async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': 'Test User',
    'createdAt': DateTime.now(),
  });
}

const day = 5;

Future<void> addData() async {
  final date = DateTime.now().copyWith(day: day);
  final _firestore = FirebaseFirestore.instance;
  await _firestore.collection('users').doc('testuser').set(profileData);
  await _firestore
      .collection('users')
      .doc('testuser')
      .collection('Transactions')
      .doc(DateFormat('yyyy-MM-dd').format(date))
      .set(todayData);
}

final profileData = {
  'uid': 'testuser',
  'displayName': 'Satyabrata Nayak',
  'email': 'satyabratanayakofficial@gmail.com',
  'profileURL': null,
  'isAdmin': false,
  'summary': {
    'thisMonthExpense': 25678,
    'thisMonthIncome': 28116,
    'previousMonthExpense': 27172,
    'previousMonthIncome': 28116,
  },
  'tags': tags
};

final tags = [
  {'tagId': 'tag1', 'tagName': 'Food'},
  {'tagId': 'tag2', 'tagName': 'Transport'},
  {'tagId': 'tag3', 'tagName': 'Income'},
  {'tagId': 'tag4', 'tagName': 'Salary'},
  {'tagId': 'tag5', 'tagName': 'Gift'},
  {'tagId': 'tag6', 'tagName': 'Shopping'},
  {'tagId': 'tag7', 'tagName': 'Entertainment'},
  {'tagId': 'tag8', 'tagName': 'Health'},
  {'tagId': 'tag9', 'tagName': 'Utilities'},
  {'tagId': 'tag10', 'tagName': 'Travel'}
];

final todayData = {
  'totalIncome': 2000,
  'totalExpense': 750,
  'transactions': [
    {
      'id': 'tx1',
      'amount': 350,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Breakfast at cafe',
      'tags': ['tag1', 'tag2'],
      'isExpense': true
    },
    {
      'id': 'tx2',
      'amount': 400,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Fuel for car',
      'tags': ['tag1', 'tag4'],
      'isExpense': true
    },
    {
      'id': 'tx3',
      'amount': 2000,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Freelance Payment',
      'tags': ['tag3'],
      'isExpense': false
    },
    {
      'id': 'tx1',
      'amount': 350,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Breakfast at cafe',
      'tags': ['tag1', 'tag2'],
      'isExpense': true
    },
    {
      'id': 'tx2',
      'amount': 400,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Fuel for car',
      'tags': ['tag1', 'tag4'],
      'isExpense': true
    },
    {
      'id': 'tx3',
      'amount': 2000,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Freelance Payment',
      'tags': ['tag3'],
      'isExpense': false
    },
    {
      'id': 'tx1',
      'amount': 350,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Breakfast at cafe',
      'tags': ['tag1', 'tag2'],
      'isExpense': true
    },
    {
      'id': 'tx2',
      'amount': 400,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Fuel for car',
      'tags': ['tag1', 'tag4'],
      'isExpense': true
    },
    {
      'id': 'tx3',
      'amount': 2000,
      'date': DateTime.now().copyWith(day: day).toIso8601String(),
      'message': 'Freelance Payment',
      'tags': ['tag3'],
      'isExpense': false
    }
  ]
};
