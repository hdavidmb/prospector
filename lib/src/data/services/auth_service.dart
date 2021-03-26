import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get user {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async { // TODO: Use either tu return server failures
    try {
      final UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      debugPrint(result.toString());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }
  
}