import 'package:flutter/material.dart';
class User with ChangeNotifier{
  int id;
  String userName;
  String accessToken;
  User(this.id, this.userName, this.accessToken);
}
