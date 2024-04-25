import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/MeetingProvider.dart';
import '../models/NFCUserModel.dart';
import '../models/MeetingModel.dart';

class UserModal extends StatefulWidget {
  final NFCUser user;
  UserModal(this.user);

  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  String? selectedMeeting;

  @override
  Widget build(BuildContext context) {
    final meetingContainer = Provider.of<MeetingProvider>(context);
    final meetings = meetingContainer.getMeetings;

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 40,
                child: Text(
                  widget.user.userName.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(widget.user.userName),
          ),
          ListTile(
            leading: const Icon(Icons.mail_lock_outlined),
            title: Text(widget.user.email),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(widget.user.regNumber),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: Text(widget.user.facultyRegistered),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: DropdownButton<String>(
              elevation: 10,
              value: selectedMeeting,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMeeting = newValue;
                });
              },
              items: meetings.map<DropdownMenuItem<String>>((Meeting meeting) {
                return DropdownMenuItem<String>(
                  value: meeting.name,
                  child: Text(meeting.name),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Access Granted"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Grant Access'),
          ),
          const SizedBox(height: 200),
        ],
      ),
    );
  }
}
