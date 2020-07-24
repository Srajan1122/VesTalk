import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chatlist.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chatUserContent.dart';
import 'package:socail_network_flutter/views/Chat/widgets/widgets.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var queryResultSet = [];
  var tempSearchStore = [];
  DocumentSnapshot Documents;
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
    List user = tempSearchStore[index]["users"];
    user.remove(Constants.uid);
    print(user[0]);
    return ChatUserList(
      lasttime: tempSearchStore[index]['seentime'],
      uid: tempSearchStore[index]['userInfo'][user[0]]["id"],
      displayName: tempSearchStore[index]['userInfo'][user[0]]["userName"],
      email: tempSearchStore[index]['userInfo'][user[0]]["email"],
      photoUrl: tempSearchStore[index]['userInfo'][user[0]]["photoUrl"],
    );
  }

  @override
  void initState() {
    super.initState();

    databaseMethods.getsearch(Constants.uid).then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        setState(() {
//          print(value.documents[i].data.toString()+"  heheheheheheeeheheh");
          queryResultSet.add(value.documents[i].data);
          tempSearchStore = queryResultSet;
//          print(tempSearchStore[i]);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("  " + tempSearchStore.length.toString() + " mememememeeme");
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
