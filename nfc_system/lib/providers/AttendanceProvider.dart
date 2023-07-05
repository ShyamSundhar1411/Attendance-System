import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/AttendanceModel.dart';

class AttendanceProvider with ChangeNotifier {
  List<Attendance> _attendanceItems = [];
  Future<void> createAttendance(Attendance attendance) async {
    final url = "https://mic-attendance-system.onrender.com/mark/attendance/";
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'meeting_id': attendance.meetingId,
      'user_id': attendance.userId,
      'status': attendance.status,
      'date': attendance.date.toIso8601String(),
    });
    final response = await http.post(Uri.parse(url), 
    headers: headers,
    body: body
    );
    if (response.statusCode == 200) {
      // Attendance created successfully
      print('Attendance created');

      // Notify listeners that the attendance creation was successful
      notifyListeners();
    } else {
      // Failed to create attendance
      print('Failed to create attendance. Status code: ${response.statusCode}');
    }
  }
}
