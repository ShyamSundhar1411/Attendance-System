import 'package:flutter/material.dart';
import 'package:nfc_system/components/user_card.dart';
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
  @override
  void initState() {
    super.initState();
    Provider.of<NFCUserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final nfcUserContainer = Provider.of<NFCUserProvider>(context);
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _refreshData() async {
      await nfcUserContainer.fetchUsers();
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
            if (nfcUserProvider.getNFCUsers.isEmpty) {
              return RefreshIndicator(
                onRefresh:_refreshData,
                child:ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const CardLoading(
                      height: 100,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      margin: EdgeInsets.all(10),
                    );
                  }
                )
              );
            } else {
              return RefreshIndicator(
                onRefresh: _refreshData,
                child:ListView.builder(
                itemCount: nfcUserProvider.getNFCUsers.length,
                itemBuilder: (context, index) {
                  final user = nfcUserProvider.getNFCUsers[index];
                  return UserCard(user);
                  },
                )
              );
            }
          }))
        ]));
  }
}
