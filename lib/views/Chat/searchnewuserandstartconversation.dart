import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/Chat/chatlist.dart';


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
        title: Text('Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: UserSearch(
                      userDocumentSnapshots: _userDocumentSnapshots));
            },
          )
        ],
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
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        return ChatUserList(
                          displayName: snapshot.data[index].data['displayName'],
                          photoUrl: snapshot.data[index].data['photoUrl'],
                          designation: snapshot.data[index].data['designation'],
                          email: snapshot.data[index].data['email'],
                        );
                      });
                }
              }),
          onRefresh: _refreshPage,
        ),
      ),
    );
  }
}

class UserSearch extends SearchDelegate<String> {
  Future userDocumentSnapshots;
  List<Map> userList = [];

  UserSearch({this.userDocumentSnapshots}) {
    userDocumentSnapshots.then((value) {
      for (DocumentSnapshot i in value) {
        userList.add(i.data);
      }
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? []
        : userList.where((element) => element['displayName']
        .toString()
        .toLowerCase()
        .startsWith(query.toLowerCase())).toList();

    return ListView.builder(
        itemCount: suggestion.length,
        itemBuilder: (_, index) {
          return  ChatUserList(
            displayName: suggestion.toList()[index]['displayName'],
            photoUrl: suggestion.toList()[index]['photoUrl'],
            designation: suggestion.toList()[index]['designation'],
            email: suggestion.toList()[index]['email'],
          );
        });
  }
}

