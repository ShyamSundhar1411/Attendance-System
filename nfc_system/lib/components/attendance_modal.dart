import 'package:flutter/material.dart';
import 'package:nfc_system/providers/MeetingProvider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../models/NFCUserModel.dart';
import '../models/AttendanceModel.dart';
import '../models/MeetingModel.dart';

class AttendanceModal extends StatelessWidget {
  final NFCUser user;
  final List<Attendance> userAttendance;
  final List<Meeting> allMeetings;

  AttendanceModal(this.user, this.userAttendance, this.allMeetings);
  
  @override
  Widget build(BuildContext context) {
    int presentCount = userAttendance
        .where((attendance) => attendance.status == 'Present')
        .length;
    int totalCount = allMeetings.length;
    double attendancePercentage = (presentCount / totalCount);
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 10,
                      percent: attendancePercentage,
                      center: Text(
                        "${(attendancePercentage * 100).toInt()}%",
                        style: const TextStyle(fontSize: 20),
                      ),
                      progressColor: Colors.blue,
              ),
            ),
          ),
          ...allMeetings.map(
            (meeting) => Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.account_circle_outlined),
                title: Text(meeting.name),
                subtitle: Row(
                  children: [
                    Icon(
                      userAttendance.any((attendance) =>
                              attendance.meeting.id == meeting.id &&
                              attendance.status == 'Present')
                          ? Icons.check_rounded
                          : Icons.close_rounded,
                      color: userAttendance.any((attendance) =>
                              attendance.meeting.id == meeting.id &&
                              attendance.status == 'Present')
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        userAttendance.any((attendance) =>
                                attendance.meeting.id == meeting.id &&
                                attendance.status == 'Present')
                            ? 'Present'
                            : 'Absent',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
