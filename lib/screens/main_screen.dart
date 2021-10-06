import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui_practice/screens/download_screen.dart';
import 'package:ui_practice/screens/favorite_screen.dart';
import 'package:ui_practice/screens/home_screen.dart';
import 'package:ui_practice/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedBottomIndex = 0;

  final screenArray = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    DownloadScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Back Called");
        if (_selectedBottomIndex == 0) {
        } else {
          setState(() {
            _selectedBottomIndex = 0;
          });
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: screenArray[_selectedBottomIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedItemColor: Theme.of(context)
              .bottomNavigationBarTheme
              .selectedIconTheme!
              .color,
          unselectedItemColor: Theme.of(context)
              .bottomNavigationBarTheme
              .unselectedIconTheme!
              .color,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          currentIndex: _selectedBottomIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _selectedBottomIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/ic_home.png",
                width: 20,
                height: 20,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .unselectedIconTheme!
                    .color,
              ),
              activeIcon: Image.asset(
                "assets/icons/ic_home_fill.png",
                width: 20,
                height: 20,
                color: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedIconTheme!
                    .color,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/ic_search.png",
                  width: 20,
                  height: 20,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedIconTheme!
                      .color,
                ),
                activeIcon: Image.asset(
                  "assets/icons/ic_search.png",
                  width: 20,
                  height: 20,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedIconTheme!
                      .color,
                ),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/ic_heart.png",
                  width: 20,
                  height: 20,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedIconTheme!
                      .color,
                ),
                activeIcon: Image.asset(
                  "assets/icons/ic_heart_fill.png",
                  width: 20,
                  height: 20,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedIconTheme!
                      .color,
                ),
                label: "Favourite"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/ic_download.png",
                  width: 20,
                  height: 20,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedIconTheme!
                      .color,
                ),
                activeIcon: Image.asset(
                  "assets/icons/ic_download_fill.png",
                  width: 20,
                  height: 20,
                  color: Theme.of(context)
                      .bottomNavigationBarTheme
                      .selectedIconTheme!
                      .color,
                ),
                label: "Download")
          ],
        ),
      ),
    );
  }
}
