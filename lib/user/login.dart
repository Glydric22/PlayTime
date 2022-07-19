import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passowordController = TextEditingController();
  String _errorName = "";

  ///Sign In user
  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passowordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        setState(() => _errorName = "Inserire un'email corretta");
      }
      if (e.code == "user-not-found") {
        setState(() => _errorName = "L'utente non è stato trovato");
      }
      if (e.code == "wrong-password") {
        setState(() => _errorName = "Password Errata");
      }
      
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  registerPage() {}

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
                  const Text("Bentornato", style: TextStyle(fontSize: 20)),
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
                    onPressed: signIn,
                    child: const Text("Login"),
                  ),
                  TextButton(
                    onPressed: registerPage,
                    child: const Text("Non sei iscritto? Registrati"),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
}
