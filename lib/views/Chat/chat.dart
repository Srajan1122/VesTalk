import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chatlist.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chatUserContent.dart';
import 'package:socail_network_flutter/views/Chat/widgets/widgets.dart';
import 'package:socail_network_flutter/Widgets/widgets.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var queryResultSet = [];
  var tempSearchStore = [];
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomList;

  _searchBar() {
    return Padding(
      padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 0),
      child: TextField(
        onChanged: (val) {
          val = val.toLowerCase();
          setState(() {
            setState(() {
              tempSearchStore = queryResultSet.where((element) {
                var _searchResult =
                    element['userName'].toString().toLowerCase();
                return _searchResult.contains(val);
              }).toList();
            });
          });
        },
        decoration: inputDecoration(),
      ),
    );
  }

  _listItem(index) {
    return ChatUserList(
      uid: tempSearchStore[index]["id"],
      displayName: tempSearchStore[index]["userName"],
      email: tempSearchStore[index]["email"],
      photoUrl: tempSearchStore[index]["photoUrl"],
      designation: tempSearchStore[index]["designation"],
    );
  }

  @override
  void initState() {
    super.initState();

    databaseMethods.getsearch(Constants.uid).then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        setState(() {
          queryResultSet.add(value.documents[i].data);
          tempSearchStore = queryResultSet;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: getAppBar(),
        body: SingleChildScrollView(
           physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ChatUserContent(),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: tempSearchStore.length + 1,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return index == 0 ? _searchBar() : _listItem(index - 1);
                },
              ),
            ],
          ),
    ));
  }
}
