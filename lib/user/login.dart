import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  signIn() {
    AuthService.signIn(email!, password!);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextField(
              onSubmitted: (value) => email = value,
            ),
            TextField(
              onSubmitted: (value) => password = value,
              obscureText: true,
            ), // PasswordField
            MaterialButton(
              onPressed: signIn,
            )
          ],
        ),
      );
}
