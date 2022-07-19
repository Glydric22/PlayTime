import 'package:flutter/material.dart';
import 'example_page.dart';
import 'user/login_page.dart';

class Switcher extends StatefulWidget {
  const Switcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SwitcherState();
}

class SwitcherState extends State<Switcher> {
  int _index = 2; //0;

  final _screen = const [ExamplePage(), ExamplePage(), LoginPage()];
  void _updateIndex(int value) {
    setState(() => _index = value);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: _screen[_index],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 1,
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          items: const [
            BottomNavigationBarItem(
              label: "test",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "test",
              icon: Icon(Icons.bolt),
            ),
            BottomNavigationBarItem(
              label: "test",
              icon: Icon(Icons.account_circle),
            ),
          ],
          onTap: _updateIndex,
        ),
      );
}
