import "package:flutter/material.dart";
import "package:nfc_system/components/bottom_navigation_bar.dart";
import "package:nfc_system/providers/AttendanceProvider.dart";
import "package:nfc_system/providers/AuthProvider.dart";
import "package:nfc_system/providers/MeetingProvider.dart";
import "package:provider/provider.dart";
import "package:nfc_system/providers/NFCUserProvider.dart";
import "package:nfc_system/screens/ScanScreen.dart";

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final screens = [
    ScanScreen(),
  ];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nfcContainer = Provider.of<NFCUserProvider>(context, listen: false);
      final userContainer = Provider.of<AuthProvider>(context,listen: false);
      nfcContainer.fetchUsers();
    });
  }
  @override
  void dispose() {
  // Dispose of any resources like stream subscriptions, animation controllers, etc.
  // Make sure to call super.dispose() as well.
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // Fetch the API container on app startup

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
