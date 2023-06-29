import 'package:flutter/material.dart';
import 'package:nfc_system/providers/NFCUserProvider.dart';
import 'package:provider/provider.dart';
import './screens/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=>NFCUserProvider()),
      ],
      child:MaterialApp(
        title: "NFC Attendance System",
        home: MainScreen(),
    ));
  }
}
