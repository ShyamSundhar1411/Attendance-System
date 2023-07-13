import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:provider/provider.dart';
import '../providers/NFCUserProvider.dart';
import '../components/circular_button.dart';
import '../models/NFCUserModel.dart';
import '../components/user_modal.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  String serialNumber = "";
  NFCUser? scannedUser;

  @override
  void initState() {
    super.initState();
    Provider.of<NFCUserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final nfcUserContainer = Provider.of<NFCUserProvider>(context);
    NFCUser findUserByNFC(String nfc) {
      final users = nfcUserContainer.getNFCUsers;
      return users.firstWhere((user) => user.nfcSerial == nfc);
    }

    void _showUserModal(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return UserModal(scannedUser!);
        },
      );
    }

    void updateScannedUser(String serialNumber) {
      setState(() {
        scannedUser = findUserByNFC(serialNumber);
      });
      if (scannedUser != null) {
        _showUserModal(context);
      }
    }


    
    Future<void> tagRead() async {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        result.value = tag.data;
        List<int> identifier = result.value['nfca']['identifier'];
        serialNumber = identifier
            .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
            .join(':')
            .toUpperCase();
        updateScannedUser(serialNumber);
        NfcManager.instance.stopSession();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan for NFC"),
      ),
      body: SafeArea(
        child: nfcUserContainer.isLoading
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<bool>(
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
                            onPressed: tagRead,
                          ),
                        ),
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
