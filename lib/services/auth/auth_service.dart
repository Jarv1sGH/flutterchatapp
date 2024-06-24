import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; // auth instance
  final FirebaseFirestore _fireStore =
      FirebaseFirestore.instance; // firestore instance

  // Registering a new user
  Future<UserCredential> register(
      String email, String password, String username, String mobileNum) async {
    try {
      UserCredential userCreds = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // saving the new user in the firestore database along  with username and mobile number
      await _fireStore.collection('users').doc(userCreds.user!.uid).set({
        'uid': userCreds.user!.uid,
        'username': username,
        'mobileNum': mobileNum,
        'email': email,
      });

      return userCreds;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // for logging in
  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential userCreds = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCreds;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // for logging out

  Future<void> logOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
