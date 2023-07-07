import 'package:flutter/material.dart';
import '../components/attendance_modal.dart';
import '../models/NFCUserModel.dart';

class UserCard extends StatelessWidget {
  final NFCUser user;
  UserCard(this.user);
  void _showUserModal(BuildContext context, NFCUser user) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AttendanceModal(user);
        },
      );
    }
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: InkWell(
              splashColor: Colors.blue,
              onTap: () => {
                _showUserModal(context,user)
              },
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
