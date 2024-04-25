import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  User _currentUser = User(0, '', ''); // Initialize _currentUser

  User get currentUser => _currentUser; // Provide access to currentUser

  String getAccessToken() {
    return _currentUser.accessToken;
  }

  Future<void> login(String username, String password) async {
    final clientUrl = dotenv.env['CLIENT_URL'];
    final url = "$clientUrl/api/login";
    print(url);
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "email": username,
      "password": password,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _currentUser = User(data['id'], data['username'], data['access']);
        print(_currentUser);
        notifyListeners();
      } else {
        print('Failed to log in. Status code: ${response.statusCode}');
        throw Exception('Failed to log in');
      }
    } catch (error) {
      print('Error occurred during login: $error');
      throw Exception(
          'Error occurred during login'); // Throw exception for error handling
    }
  }

  void logout() {
    _currentUser = User(0, '', '');
    notifyListeners();
  }
}
