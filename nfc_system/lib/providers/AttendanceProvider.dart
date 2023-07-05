import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/AttendanceModel.dart';
import 'package:intl/intl.dart';

class AttendanceProvider with ChangeNotifier {
  List<Attendance> _attendanceItems = [];
  Future<void> createAttendance(Attendance attendance) async {
    final url = "https://mic-attendance-system.onrender.com/mark/attendance/";
    final headers = {'Content-Type': 'application/json'};
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedDate = dateFormat.format(attendance.date);
    final body = json.encode({
      'meeting_id': attendance.meetingId,
      'user_id': attendance.userId,
      'status': attendance.status,
      'date': formattedDate,
    });
    final response = await http.post(Uri.parse(url), 
    headers: headers,
    body: body
    );
    if (response.statusCode == 200) {
      // Attendance created successfully

      // Notify listeners that the attendance creation was successful
      notifyListeners();
    } else {
      // Failed to create attendance
      print('Failed to create attendance. Status code: ${response.statusCode}');
    }
  }
}
