import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nfc_system/components/user_card.dart';
import 'package:nfc_system/providers/AttendanceProvider.dart';
import 'package:nfc_system/providers/MeetingProvider.dart';
import 'package:provider/provider.dart';
import 'package:card_loading/card_loading.dart';
import '../providers/NFCUserProvider.dart';
import '../components/search_bar.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key, required this.title});
  final String title;
  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final TextEditingController _searchController = TextEditingController();
  var isLoading = true;
  void startLoadingTimer() {
    const loadingDuration =
        Duration(seconds: 2); // Adjust the duration as needed

    Timer(loadingDuration, () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startLoadingTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nfcContainer = Provider.of<NFCUserProvider>(context, listen: false);
      final meetingContainer = Provider.of<MeetingProvider>(context,listen: false);
      final attendanceContainer = Provider.of<AttendanceProvider>(context,listen: false);

      nfcContainer.fetchUsers();
      meetingContainer.fetchMeetings();
      attendanceContainer.fetchAttendance(meetingContainer);
    });
  }

  @override
  Widget build(BuildContext context) {
    final nfcUserContainer = Provider.of<NFCUserProvider>(context);
    final meetingContainer = Provider.of<MeetingProvider>(context);
    final AttendanceContainer = Provider.of<AttendanceProvider>(context);

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _refreshData() async {
      setState(() {
        isLoading = true;
      });
      startLoadingTimer();
      await nfcUserContainer.fetchUsers();
      await AttendanceContainer.fetchAttendance(meetingContainer);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchBar(_searchController)),
          Expanded(child:
              Consumer<NFCUserProvider>(builder: (context, nfcUserProvider, _) {
            return RefreshIndicator(
                onRefresh: _refreshData,
                child: isLoading
                    ? (ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const CardLoading(
                            height: 100,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            margin: EdgeInsets.all(10),
                          );
                        }))
                    : ListView.builder(
                        itemCount: nfcUserProvider.getNFCUsers.length,
                        itemBuilder: (context, index) {
                          final user = nfcUserProvider.getNFCUsers[index];
                          return UserCard(user);
                        }));
          }))
        ]));
  }
}
