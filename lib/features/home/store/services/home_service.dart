import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomeService {
  static Future<List<Map<String, dynamic>>> getTodaytransactionList() async {
    try {
      final date = DateTime.now().copyWith(day: 1);
      final todayFormatted = DateFormat('yyyy-MM-dd').format(date);

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('testuser')
          .collection('Transactions')
          .doc(todayFormatted)
          .get();

      if (!snapshot.exists) {
        return [];
      }

      final data = snapshot.data();
      if (data == null || !data.containsKey('transactions')) {
        return [];
      }

      return List<Map<String, dynamic>>.from(data['transactions'] as List);
    } catch (e) {
      print("Error fetching today's transactions: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>> getSummary() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('testuser')
          .get();

      if (!snapshot.exists) {
        return {};
      }

      final data = snapshot.data();
      if (data == null || !data.containsKey('summary')) {
        return {};
      }

      return Map<String, dynamic>.from(data['summary'] as Map);
    } catch (e) {
      print('Error fetching summary of transactions: $e');
      return {};
    }
  }
}
