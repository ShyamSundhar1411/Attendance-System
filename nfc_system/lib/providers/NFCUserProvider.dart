import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/NFCUserModel.dart';

class NFCUserProvider with ChangeNotifier {
  List<NFCUser> _nfcuseritems = [];

  List<NFCUser> get getNFCUsers {
    return _nfcuseritems;
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  Future<void> fetchUsers() async {
    final url = 'https://mic-attendance-system.onrender.com/get/users/all/';
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
      _isLoading = false;
      notifyListeners();
    } else {
      _isLoading = false;
      notifyListeners();
      throw Exception("Failed to fetch users");
    }
  }

  Future<NFCUser> fetchUserNFC(String serial) async {
    final url =
        'https://mic-attendance-system.onrender.com/get/user/${serial}/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final user = NFCUser(
          jsonData['id'],
          jsonData['email'],
          jsonData['faculty_registered'],
          jsonData['nfc_serial'],
          jsonData['roll_no'],
          jsonData['username']);
      return user;
    } else {
      throw Exception('Failed to fetch user');
    }
  }
}
