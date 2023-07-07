import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/MeetingModel.dart';

class MeetingProvider with ChangeNotifier {
  List<Meeting> _meetingItems = [];
  List<Meeting> get getMeetings {
    return _meetingItems;
  }

  Future<void> fetchMeetings() async {
    final url = 'https://mic-attendance-system.onrender.com/get/meetings/all/';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _meetingItems = data
            .map((meetingJson) => Meeting(meetingJson['id'],
                meetingJson['name'], meetingJson['created_at']))
            .toList();
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
