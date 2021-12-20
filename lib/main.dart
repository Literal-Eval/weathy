import 'package:flutter/material.dart';
// import 'package:weathy/screens/home_screen.dart';
import 'package:weathy/screens/main_screen.dart';

void main() {
  runApp(const MaterialApp(home: Weathy()));
}

class Weathy extends StatelessWidget {
  const Weathy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}
