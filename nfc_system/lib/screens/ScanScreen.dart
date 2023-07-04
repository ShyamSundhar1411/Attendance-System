import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';
import '../providers/NFCUserProvider.dart';
import '../components/circular_button.dart';
import '../models/NFCUserModel.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  String serialNumber = "";
  NFCUser? scanned_user;

  @override
  void initState() {
    super.initState();
    Provider.of<NFCUserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final nfcUserContainer = Provider.of<NFCUserProvider>(context);
    NFCUser find_user_by_nfc(String nfc) {
      final users = nfcUserContainer.getNFCUsers;
      return users.firstWhere((user) => user.nfcSerial == nfc);
    }

    void _tagRead() {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        result.value = tag.data;
        List<int> identifier = result.value['nfca']['identifier'];
        serialNumber = identifier
            .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
            .join(':')
            .toUpperCase();
        setState(() {
          scanned_user = find_user_by_nfc(serialNumber);
        });

        NfcManager.instance.stopSession();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan for NFC"),
      ),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, ss) {
            if (ss.hasData && ss.data == true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularButton(
                      size: 120.0,
                      icon: Icons.add,
                      onPressed: _tagRead,
                    ),
                  ),
                  if (scanned_user != null)
                    Text(scanned_user!.userName),
                ],
              );
            } else {
              return Center(
                child: Text('NfcManager.isAvailable(): ${ss.data}'),
              );
            }
          },
        ),
      ),
    );
  }
}
