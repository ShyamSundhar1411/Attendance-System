import 'package:flutter/material.dart';
import '../models/NFCUserModel.dart';

class UserModal extends StatelessWidget{
  final NFCUser user;
  UserModal(this.user);
  @override
  Widget build(BuildContext context){
    return Container(
      // Customize the modal's content here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user.userName),
        ],
      ),
    );
  }
}