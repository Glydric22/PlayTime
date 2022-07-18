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

  ///Sign In user
  static void signIn(String email, String password) {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const AlertDialog(title: Text('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        const AlertDialog(
            title: Text('Wrong password provided for that user.'));
      }
    }
  }

  ///Sign out user
  static void signOut() async => await FirebaseAuth.instance.signOut();

  ///Reset Password
  static void resetPasswordLink(String email) =>
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
