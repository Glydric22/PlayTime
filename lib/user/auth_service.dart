import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  ///create a new user
  static void signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const AlertDialog(title: Text("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        const AlertDialog(
            title: Text('The account already exists for that email.'));
      }
    }
  }


  ///Sign out user
  static void signOut() async => await FirebaseAuth.instance.signOut();

  ///Reset Password
  static void resetPasswordLink(String email) =>
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
