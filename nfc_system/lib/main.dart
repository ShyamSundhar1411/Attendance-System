import 'package:flutter/material.dart';
import './screens/ScanScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NFC Attendance System",
      home: ScanScreen(),
    );
  }
}
