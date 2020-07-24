import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:socail_network_flutter/services/constant.dart';

Row buildUserInfo(BuildContext context, post) {
  return Row(
    children: <Widget>[
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)},
      ),
      Card(
        child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            backgroundImage: NetworkImage(post['photoUrl'])),
        elevation: 9.0,
        shape: CircleBorder(),
        clipBehavior: Clip.antiAlias,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
        child: Text.rich(
          TextSpan(
            text: 'Posted By - \n',
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                height: 1.5,
                letterSpacing: 1),
            children: <TextSpan>[
              TextSpan(
                  text: post['displayName'] + '\n',
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1.2,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: post['designation'] + '\n',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1)),
              TextSpan(
                  text: timeago.format(post['created'].toDate()),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1)),
            ],
          ),
        ),
      ),
      if (post['id'] == Constants.uid) _simplePopup(post)
    ],
  );
}

Widget _simplePopup(postId) => PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("Edit"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Delete"),
        ),
      ],
    );
