import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  late User _currentUser;

  String getAccessToken() {
    return _currentUser.accessToken;
  }

  Future<void> login(String username, String password) async {
    final clientUrl = dotenv.env['CLIENT_URL'];
    final url = "$clientUrl/api/users/login/";
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "username": username,
      "password": password,
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _currentUser = User(data['_id'], data['username'], data['access']);
        print("Logged in");
        notifyListeners();
      } else {
        print('Failed to log in. Status code: ${response.statusCode}');
        // Notify the UI about the error or handle it appropriately.
      }
    } catch (error) {
      print('Error occurred during login: $error');
      // Notify the UI about the error or handle it appropriately.
    }
  }

  void logout() {
    // Clear user session and remove access token
    _currentUser = User(0, '', '');
    notifyListeners();
  }
}
