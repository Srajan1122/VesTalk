import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/Chat/widgets/userSearch.dart';
import 'package:socail_network_flutter/views/Chat/widgets/widgets.dart';

class ChatSearchPage extends StatefulWidget {
  @override
  _ChatSearchPageState createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();

  Future _userDocumentSnapshots;

  @override
  void initState() {
    super.initState();
    _userDocumentSnapshots = _databaseMethods.getAllUserDocumentSnapshot();
  }

  Future<void> _refreshPage() async {
    setState(() {
      _userDocumentSnapshots = _databaseMethods.getAllUserDocumentSnapshot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: UserSearch(
                      userDocumentSnapshots: _userDocumentSnapshots));
            },
          )
        ],
        title: Center(
          child: Text(
            'Search',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          child: FutureBuilder(
              future: _userDocumentSnapshots,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Loading..."),
                  );
                } else {
                  return buildListView(snapshot);
                }
              }),
          onRefresh: _refreshPage,
        ),
      ),
    );
  }
}
