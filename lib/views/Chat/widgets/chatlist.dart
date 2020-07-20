import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Chat/widgets/messageMainPage.dart';
import 'package:socail_network_flutter/views/Chat/widgets/userListContent.dart';

class ChatUserList extends StatefulWidget {
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  final String designation;

  ChatUserList(
      {@required this.uid,
      this.displayName,
      this.email,
      this.photoUrl,
      this.designation});

  @override
  _ChatUserListState createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  String myName = "";

  createChatroomAndstartchat(String uid, String userName, String email,
      String designation, String photoUrl) {
    if (widget.displayName != myName) {
      List<String> users = [uid, Constants.uid];
      String chatRoomId = getChatRoomId(uid, Constants.uid);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId,
        "email": email,
        "designation": designation,
        "photoUrl": photoUrl,
        "userName": userName,
        'id': uid,
        'time': DateTime.now().millisecondsSinceEpoch
      };
      _databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MassagePage(
                  chatRoomId, widget.displayName, widget.photoUrl)));
    } else {
      print("Same user");
    }
  }

  getUserData() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            myName = (value.getString("displayName") ?? '');
          })
        });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        createChatroomAndstartchat(widget.uid, widget.displayName, widget.email,
            widget.designation, widget.photoUrl);
      },
      child: UserListContent(widget: widget),
    );
  }
}
