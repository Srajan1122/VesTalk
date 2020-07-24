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
  int seenTime, messageTime, indexAt;
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
    print(tempSearchStore[index]["users"]);
    indexAt = user.indexOf(Constants.uid);
    print(indexAt.toString() + "erroerroerroerro");
    print(tempSearchStore[index]['userInfo']);
    try {
      seenTime = tempSearchStore[index]['userInfo'][user[indexAt]]["seenTime"];
    } catch (e) {
      seenTime = 0;
    }
    ;
    messageTime =
        tempSearchStore[index]['userInfo'][user[indexAt]]["messageTime"];
    user.remove(Constants.uid);
    print(user[0]);
    return ChatUserList(
      isUserList: true,
      seenTime: seenTime == null ? 0 : seenTime,
      messageTime: messageTime,
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
//          print('helloooooooooooo');
//          print(value.documents[i].data.toString()+"  heheheheheheeeheheh");
          queryResultSet.add(value.documents[i].data);
          tempSearchStore = queryResultSet;
          print(tempSearchStore[i]);
        });
      }
    });
  }

  Future<void> _refreshPage() async {
    queryResultSet.clear();
    tempSearchStore.clear();
    databaseMethods.getsearch(Constants.uid).then((value) {
      setState(() {
        for (int i = 0; i < value.documents.length; i++) {
          print('helloooooooooooo');
//          print(value.documents[i].data.toString()+"  heheheheheheeeheheh");
          queryResultSet.add(value.documents[i].data);

//            print(tempSearchStore[i]);
          tempSearchStore = queryResultSet;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("  " + tempSearchStore.length.toString() + " mememememeeme");
    return Scaffold(
        // appBar: getAppBar(),
        body: RefreshIndicator(
      child: ListView.builder(
        itemCount: tempSearchStore.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) return ChatUserContent();
          if (index == 1) return _searchBar();
          return _listItem(index - 2);
        },
      ),
      onRefresh: _refreshPage,
    ));
  }
}
