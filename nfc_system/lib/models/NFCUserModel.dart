import 'package:flutter/material.dart';

class NFCUser with ChangeNotifier {
  final int id;
  final String email;
  final String facultyRegistered;
  final String nfcSerial;
  final String regNumber;
  final String userName;
  NFCUser(this.id, this.email, this.facultyRegistered, this.nfcSerial,
      this.regNumber, this.userName);
}
