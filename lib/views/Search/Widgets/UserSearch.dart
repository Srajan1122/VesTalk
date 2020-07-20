import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ListUsers.dart';

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
          return ListUsers(
            id: suggestion.toList()[index]['id'],
            displayName: suggestion.toList()[index]['displayName'],
            photoUrl: suggestion.toList()[index]['photoUrl'],
            designation: suggestion.toList()[index]['designation'],
            email: suggestion.toList()[index]['email'],
          );
        });
  }
}
