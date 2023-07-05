import 'package:nfc_system/models/MeetingModel.dart';
import 'package:nfc_system/models/NFCUserModel.dart';

class Attendance {
  final int meetingId;
  final int userId;
  final String status;
  final DateTime date;
  Attendance(this.meetingId, this.userId, this.status, this.date);
}
