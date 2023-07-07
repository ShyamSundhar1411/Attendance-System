import 'package:flutter/material.dart';
import '../models/NFCUserModel.dart';
import '../models/AttendanceModel.dart';

class AttendanceModal extends StatelessWidget {
  final NFCUser user;
  final List<Attendance> userAttendance;
  AttendanceModal(this.user, this.userAttendance);
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 40,
                child: Text(
                  user.userName.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ),
          ),
          ...userAttendance.map(
            (element) => Card(
              margin:const  EdgeInsets.all(10),
              child:ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: Text(element.meeting.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                Text(element.status),
              ]),
            )),
          )
        ],
      ),
    );
  }
}
