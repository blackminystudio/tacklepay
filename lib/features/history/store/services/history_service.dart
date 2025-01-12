import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryService {
  static Future<List<Map<String, dynamic>>> getTagsList() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc('testuser')
          .get();

      if (!snapshot.exists) {
        return [];
      }

      final data = snapshot.data();
      if (data == null || !data.containsKey('tags')) {
        return [];
      }

      return List<Map<String, dynamic>>.from(data['tags'] as List);
    } catch (e) {
      print('Error fetching tags: $e');
      return [];
    }
  }
}
