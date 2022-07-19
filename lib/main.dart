import 'package:flutter/material.dart';
import 'package:playtime/switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(256, 36),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.grey
          ),
        ),
      ),
      home: const Switcher(),
    );
  }
}
