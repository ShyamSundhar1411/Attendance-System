import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/AttendanceModel.dart';
import '../models/MeetingModel.dart';
import '../providers/MeetingProvider.dart';
import 'package:intl/intl.dart';

class AttendanceProvider with ChangeNotifier {
  List<Attendance> _attendanceItems = [];
  List<Attendance> getAttendanceItems() {
    return _attendanceItems;
  }

  Future<void> createAttendance(Attendance attendance) async {
    final url = "https://mic-attendance-system.onrender.com/mark/attendance/";
    final headers = {'Content-Type': 'application/json'};
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedDate = dateFormat.format(attendance.date);
    final body = json.encode({
      'meeting_id': attendance.meeting.id,
      'user_id': attendance.userId,
      'status': attendance.status,
      'date': formattedDate,
    });
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      // Attendance created successfully

      // Notify listeners that the attendance creation was successful
      notifyListeners();
    } else {
      // Failed to create attendance
      print('Failed to create attendance. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetchAttendance(MeetingProvider meetingProvider) async {
    final url =
        'https://mic-attendance-system.onrender.com/get/attendances/all/';
    final List<Meeting> meetings = meetingProvider.getMeetings;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        _attendanceItems = data.map((attendanceJson) {
          final meetingId = attendanceJson['meeting_id'];
          final meeting =
              meetings.firstWhere((meeting) => meeting.id == meetingId);
          return Attendance(
            meeting,
            attendanceJson['user_id'],
            attendanceJson['status'],
            DateTime.parse(attendanceJson['date']),
          );
        }).toList();
        notifyListeners();
      } else {
        notifyListeners();
        throw Exception("Failed to fetch meetings");
      }
    } catch (e) {
      print(e);
    }
  }
}
