import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'models/model_app_user.dart';

class AuthStore extends ChangeNotifier {
  AppUser? _appUser;
  AppUser? get appUser => _appUser;

  // Google Signone
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthStore() {
    _loadUserDataOnce();
  }

  // Method to load user data only once
  Future<void> _loadUserDataOnce() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final userDoc = await _firestore.collection('Users').doc(uid).get();
    if (uid != null) {
      try {
        if (userDoc.exists) {
          _appUser = AppUser.fromFirestore(userDoc);
          notifyListeners();
        } else {
          log('User data does not exist');
        }
      } catch (e) {
        log('Error loading user data: $e');
      }
    }
  }

  Future googleLogIn() async {
    // Sign in with Google
    final googleUser = await _googleSignIn.signIn();

    // Set to local user
    if (googleUser == null) return null;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('Users').doc(uid).set({
      'uid': uid,
      'displayName': _user?.displayName,
      'email': _user?.email,
      'profileURL': _user?.photoUrl,
      'isAdmin': false,
    });
    await _loadUserDataOnce();
    notifyListeners();
  }

  Future googleLogout() async {
    await _googleSignIn.disconnect();
    await _auth.signOut();
    _appUser = null;
    notifyListeners();
  }
}
