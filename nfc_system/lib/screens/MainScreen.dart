import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "package:flutter/material.dart";
import "package:nfc_system/components/bottom_navigation_bar.dart";
import "package:nfc_system/screens/ScanScreen.dart";
import "package:nfc_system/screens/SearchUserScreen.dart";

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final screens = [
    ScanScreen(),
    const SearchUserScreen(title: "Search for Users",),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        bottomNavigationBar: MyBottomNavigator(
          index,
          (index) {
            setState(() {
              this.index = index;
            });
          },
        ));
  }
}
