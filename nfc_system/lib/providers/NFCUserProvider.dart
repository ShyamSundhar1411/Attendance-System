import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/NFCUserModel.dart';

class NFCUserProvider with ChangeNotifier {
  List<NFCUser> _nfcuseritems = [];

  List<NFCUser> get getNFCUsers {
    return _nfcuseritems;
  }

  Future<void> fetchUsers() async {
    final url = 'https://mic-attendance-system.onrender.com//get/users/all/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _nfcuseritems = data
          .map((userJson) => NFCUser(
              userJson['id'],
              userJson['email'],
              userJson['faculty_registered'],
              userJson['nfc_serial'],
              userJson['roll_no'],
              userJson['username']))
          .toList();
      notifyListeners();
    } else {
      throw Exception("Failed to fetch users");
    }
  }
}
