import 'package:flutter/material.dart';
import 'package:nfc_system/providers/AttendanceProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './providers/MeetingProvider.dart';
import './providers/NFCUserProvider.dart';
import 'package:provider/provider.dart';
import './screens/MainScreen.dart';

Future<void> main() async{

  // Get the directory where the current Dart script is executing
  

  // Load the dotenv file
  await dotenv.load(fileName: '.env');
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
        ChangeNotifierProvider(create: (ctx)=>AttendanceProvider())
      ],
      child:MaterialApp(
        title: "NFC Attendance System",
        home: MainScreen(),
    ));
  }
}
