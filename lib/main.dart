import 'package:flutter/material.dart';
import 'package:ui_practice/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            backgroundColor: Color(0xFF070d2d),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF070d2d),
                selectedIconTheme: IconThemeData(
                  color: Color(0xFF566fe9),
                ),
                unselectedIconTheme: IconThemeData(
                  color: Color(0xFF2c3254),
                ))),
        home: MainScreen());
  }
}
