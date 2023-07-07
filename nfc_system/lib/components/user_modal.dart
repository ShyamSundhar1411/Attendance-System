import 'package:flutter/material.dart';
import 'package:nfc_system/models/AttendanceModel.dart';
import 'package:nfc_system/providers/AttendanceProvider.dart';
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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final meetingContainer = Provider.of<MeetingProvider>(context);
    final meetings = meetingContainer.getMeetings;
    final attendanceContainer = Provider.of<AttendanceProvider>(context);

    void _createAttendance(String status) {
      setState(() {
        _isLoading = true;
      });

      final meetingId = meetings
          .firstWhere((element) => element.name == selectedMeeting);
      final createdAttendance = Attendance(
        meetingId,
        widget.user.id,
        status,
        DateTime.now(),
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Marking Attendance...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

      Future.delayed(Duration(seconds: 3), () {
        attendanceContainer.createAttendance(createdAttendance);

        setState(() {
          _isLoading = false;
        });

        // Close the modal after a delay of 3 seconds
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      });
    }

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
            margin:const  EdgeInsets.only(left:10),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (selectedMeeting != null) {
                          _createAttendance("Present");
                        }
                      },
                child: const Text('Present'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (selectedMeeting != null) {
                          _createAttendance("Absent");
                        }
                      },
                child: const Text('Absent'),
              ),
            ],
          ),
        const SizedBox(width: 200)
        ],
      ),
    );
  }
}
