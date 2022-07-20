import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'user_info_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passowordController = TextEditingController();
  String _errorName = "";

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Spacer(),
                  const Text(
                    "Playtime",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const Spacer(),
                  const Text("Registrati", style: TextStyle(fontSize: 20)),
                  const Spacer(),
                  const Spacer(),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      label: Text("Email"),
                    ),
                  ),

                  TextFormField(
                    controller: _passowordController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(label: Text("Password")),
                  ), // PasswordField

                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _errorName,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
                  const Spacer(),

                  const Spacer(),
                  ElevatedButton(
                    onPressed: signUp,
                    child: const Text("Register"),
                  ),
                  TextButton(
                    onPressed: backToLoginPage,
                    child: const Text("Già iscritto? Accedi"),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );

  ///create a new user
  void signUp() async {
    try {
      toPage(
        UserInfoPage(
          credential: await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passowordController.text),
        ),
      );
      _errorName = "";
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        setState(() => _errorName = "The password provided is too weak.");
      } else if (e.code == "email-already-in-use") {
        setState(
            () => _errorName = "The account already exists for that email.");
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  toPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  void backToLoginPage() => Navigator.pop(context);
}
