import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? uid;
  final String displayName;
  final String email;
  final String profileURL;
  final bool isAdmin;

  AppUser({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.profileURL,
    required this.isAdmin,
  });

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser(
      uid: data['uid'] as String? ?? '',
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      profileURL: data['profileURL'] as String? ?? '',
      isAdmin: data['isAdmin'] as bool? ?? false,
    );
  }
}
