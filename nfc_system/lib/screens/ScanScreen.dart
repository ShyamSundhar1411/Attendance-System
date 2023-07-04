import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_system/components/bottom_navigation_bar.dart';

import '../components/circular_button.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      List<int> identifier = result.value['nfca']['identifier'];
      String serialNumber = identifier
          .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join(':').toUpperCase();
      print(serialNumber);
      NfcManager.instance.stopSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scan for NFC"),
        ),
        body: SafeArea(
            child: FutureBuilder<bool>(
                future: NfcManager.instance.isAvailable(),
                builder: (context, ss) => ss.data != true
                    ? Center(
                        child: Text('NfcManager.isAvailable(): ${ss.data}'))
                    : Center(
                        child: CircularButton(
                            size: 120.0, icon: Icons.add, onPressed: _tagRead),
                      ))));
  }
}
