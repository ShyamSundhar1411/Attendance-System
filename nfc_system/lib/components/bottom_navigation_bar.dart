import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "package:flutter/material.dart";

class MyBottomNavigator extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigator(this.currentIndex, this.onTap);
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        items: const <Widget>[
          Icon(Icons.sync, size: 30),
          Icon(Icons.search, size: 30),
        ],
        onTap: onTap,
        );
  }
}
