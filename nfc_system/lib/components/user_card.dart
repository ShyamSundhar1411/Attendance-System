import 'package:flutter/material.dart';
import 'package:nfc_system/models/NFCUserModel.dart';

class UserCard extends StatelessWidget {
  final NFCUser user;
  UserCard(this.user);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child:ListTile(
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
            ),
        )
    );
  }
}
