import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/MeetingProvider.dart';
import '../models/NFCUserModel.dart';

class UserModal extends StatefulWidget {
  final NFCUser user;
  UserModal(this.user);

  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  @override
  Widget build(BuildContext context) {
    final meetingContainer = Provider.of<MeetingProvider>(context);
    final meetings = meetingContainer.getMeetings;
    final selectedMeeting = meetings[0];
    return Column(
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
        )),
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
          padding: const EdgeInsets.all(10),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            isDense: true,
            isExpanded: true,

            hint: const Text("Select Data",
                style: TextStyle(color: Colors.black)),
            items: meetings.map((meeting) {
              return DropdownMenuItem(
                child: Text(meeting.name),
                value: meeting.id.toString(),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                print(value);
              });
            },
          )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle absent button press
              },
              child: const Text('Present'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                // Handle present button press
              },
              child: const Text('Absent'),
            ),
          ],
        ),
      ],
    );
  }
}
