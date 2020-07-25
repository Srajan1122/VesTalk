import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chatlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListContent extends StatefulWidget {
  final ChatUserList widget;
  final int time;
  const UserListContent({
    Key key,
    @required this.widget,
    this.time
  }) : super(key: key);

  @override
  _UserListContentState createState() => _UserListContentState();
}

class _UserListContentState extends State<UserListContent> {
  String uid;
  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            uid = value.getString('id');
          })
        });
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.widget.uid == uid)
      return Container();
    else {
      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.widget.photoUrl),
        ),
        title:Text(widget.widget.displayName),
        subtitle:Text(widget.widget.email),
        trailing: (widget.widget.seenTime!=null && widget.widget.messageTime!=null)?(widget.widget.messageTime>widget.widget.seenTime)?SizedBox(
          height: 30,
          width: 60,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            alignment: Alignment.center,
            height: 10,
            width: 40,
            child: Text('New',style: TextStyle(color: Colors.blue,fontSize: 10),),
          ),
        ):SizedBox():SizedBox()
      );
    }
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
