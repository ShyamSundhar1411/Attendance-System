import 'package:flutter/material.dart';
import '../models/MeetingModel.dart';


class Attendance with ChangeNotifier{
  final Meeting meeting;
  final int userId;
  final String status;
  final DateTime date;
  Attendance(this.meeting, this.userId, this.status, this.date);
}
