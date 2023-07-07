import 'package:flutter/material.dart';
import 'package:nfc_system/models/NFCUserModel.dart';


class AttendanceModal extends StatelessWidget{
  final NFCUser user;
  AttendanceModal(this.user);
  @override
  Widget build(BuildContext context){
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
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(user.userName),
          ),
          ListTile(
            leading: const Icon(Icons.mail_lock_outlined),
            title: Text(user.email),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(user.regNumber),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(user.facultyRegistered),
          ),

        ],
      ),
    );
  }
}