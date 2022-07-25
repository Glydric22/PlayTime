import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  ///Sign out user
  static void signOut() async => await FirebaseAuth.instance.signOut();

  ///Reset Password
  static void resetPasswordLink(String email) =>
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}
