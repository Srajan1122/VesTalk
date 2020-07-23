import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Chat/widgets/messageMainPage.dart';
import 'package:socail_network_flutter/views/Chat/widgets/userListContent.dart';

class ChatUserList extends StatefulWidget {
  final int lasttime;
  final String uid;
  final String displayName;
  final String email;
  final String photoUrl;
  ChatUserList(
      {@required this.uid,
      this.displayName,
      this.email,
      this.photoUrl,
        this.lasttime
     });

  @override
  _ChatUserListState createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  String myName = "";
  var time;

  createChatroomAndstartchat(String uid, String userName, String email, String photoUrl) {
    if (widget.displayName != myName) {
      Map<String,dynamic> userInfo ={
        uid:{"email": email,
        "photoUrl": photoUrl,
        "userName": userName,
        'id': uid,}
        ,Constants.uid:{
          "email": Constants.email,
          "photoUrl": Constants.photoUrl,
          "userName": Constants.myName,
          'id': Constants.uid,
        }};
      List<String> users = [uid, Constants.uid];
      String chatRoomId = getChatRoomId(uid, Constants.uid);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId,
        "email": email,
        "photoUrl": photoUrl,
        "userName": userName,
        'id': uid,
        'userInfo':userInfo,
        'seentime': time,
        'time':DateTime.now().millisecondsSinceEpoch
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

    _databaseMethods.getLatestTime(getChatRoomId(widget.uid, Constants.uid)).then((value) {
      print(value.documents[0]['time'].toString()+"  aniketaniketaniket"+value.documents[0]['message'].toString());
      setState(() {
        time=value.documents[0]['time'];
      });
    }).catchError((e){
     time=0;
    });
    print(time.toString()+"timtitmtitmtitm");
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    print(time.toString()+"  hel  "+widget.lasttime.toString());
    return GestureDetector(
      onTap: () {
        createChatroomAndstartchat(widget.uid, widget.displayName, widget.email,
             widget.photoUrl);
      },
      child: UserListContent(widget: widget,time: time,),
    );
  }
}
