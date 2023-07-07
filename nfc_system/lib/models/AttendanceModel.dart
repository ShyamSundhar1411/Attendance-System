import '../models/MeetingModel.dart';

class Attendance {
  final Meeting meeting;
  final int userId;
  final String status;
  final DateTime date;
  Attendance(this.meeting, this.userId, this.status, this.date);
}
