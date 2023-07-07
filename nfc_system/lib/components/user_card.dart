import 'package:flutter/material.dart';
import 'package:nfc_system/models/AttendanceModel.dart';
import 'package:nfc_system/providers/AttendanceProvider.dart';
import 'package:nfc_system/providers/MeetingProvider.dart';
import 'package:provider/provider.dart';
import '../components/attendance_modal.dart';
import '../models/NFCUserModel.dart';
import '../models/MeetingModel.dart';

class UserCard extends StatelessWidget {
  final NFCUser user;
  UserCard(this.user);
  void _showUserModal(BuildContext context, NFCUser user,
      List<Attendance> userAttendance, List<Meeting> allMeetings) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AttendanceModal(user, userAttendance, allMeetings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final attendanceContainer = Provider.of<AttendanceProvider>(context);
    final meetingContainer = Provider.of<MeetingProvider>(context);
    final List<Attendance> userAttendance = attendanceContainer
        .getAttendanceItems()
        .where((element) => element.userId == user.id)
        .toList();
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: InkWell(
              splashColor: Colors.blue,
              onTap: () => {_showUserModal(context, user, userAttendance,meetingContainer.getMeetings)},
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(user.userName.substring(0, 1)),
                ),
                title: Text(user.userName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.email),
                    Text(user.facultyRegistered),
                    Text(user.nfcSerial),
                    Text(user.regNumber),
                  ],
                ),
              )),
        ));
  }
}
