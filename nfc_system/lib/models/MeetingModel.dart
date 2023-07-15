import 'package:flutter/material.dart';
class Meeting with ChangeNotifier{
  final int id;
  final String name;
  String createdAt="";
  Meeting(this.id,this.name, this.createdAt);
}
