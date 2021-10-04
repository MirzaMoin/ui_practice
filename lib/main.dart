import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_practice/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
          textTheme: TextTheme(
              headline1:
                  TextStyle(fontFamily: GoogleFonts.varelaRound().fontFamily)),
          fontFamily: GoogleFonts.varelaRound().fontFamily,
          backgroundColor: Color(0xFF070d2d),
          accentColor: Color(0xff1f2542),
          buttonColor: Color(0xffff002d),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF070d2d),
            selectedIconTheme: IconThemeData(
              color: Color(0xFF566fe9),
            ),
            unselectedIconTheme: IconThemeData(
              color: Color(0xFF2c3254),
            ),
          ),
        ),
        home: MainScreen());
  }
}
