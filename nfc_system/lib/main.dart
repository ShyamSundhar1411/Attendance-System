import 'package:flutter/material.dart';
import './providers/MeetingProvider.dart';
import './providers/NFCUserProvider.dart';
import 'package:provider/provider.dart';
import './screens/MainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=>NFCUserProvider()),
        ChangeNotifierProvider(create: (ctx)=>MeetingProvider()),
      ],
      child:MaterialApp(
        title: "NFC Attendance System",
        home: MainScreen(),
    ));
  }
}
