import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chatlist.dart';

class UserListContent extends StatelessWidget {
  const UserListContent({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ChatUserList widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 1, bottom: 1),
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.photoUrl),
                maxRadius: 30,
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.displayName),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                ],
              ),
              Text(
                widget.designation,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
              )
            ],
          ),
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
