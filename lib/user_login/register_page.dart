import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_info_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _gamerTagController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passowordController = TextEditingController();
  // final FirebaseFirestore db;
  String _errorName = "";

  @override
  Widget build(BuildContext context) => Scaffold(
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
                    controller: _gamerTagController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text("GamerTag"),
                    ),
                  ),
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
      User user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passowordController.text)
          .then((credential) => credential.user!);
      await user.updateDisplayName(_gamerTagController.text);

      toPage(UserInfoPage(user: user));

      _errorName = "";
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        setState(() => _errorName = "Scegliere una password più sicura");
      } else if (e.code == "email-already-in-use") {
        setState(() => _errorName = "L'account è già esistente");
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  toPage(Widget page) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );

  backToLoginPage() => Navigator.pop(context);
}
