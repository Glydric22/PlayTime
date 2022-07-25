import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  final User user;

  const UserInfoPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Text("Email"),
                Text(user.email.toString()),
                const Text("GamerTag"),
                Text(user.displayName.toString()),
                const Spacer(),
                const Text("USERINFO"),
                Text(user.toString()),
              ],
            ),
          ),
        ),
      );
}
