import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:timeago/timeago.dart' as timeago;

Row buildUserInfo(BuildContext context, post) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 3.0, top: 0),
        child: Align(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage:
                  NetworkImage(post['photoUrl']),
                ),
                elevation: 1.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
              Container(
                padding: const EdgeInsets.only(left: 1,top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Posted by:-",
                        style:
                        TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                    Text(
                      post['displayName'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Row(
                      children: <Widget>[
                        Text( post['designation'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey.shade600)),
                      ],
                    ),
                    Text(
                        timeago.format(post['created'].
                        toDate()).toString(),
                        style:
                        TextStyle(fontSize: 11, color: Colors.grey.shade600))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      if(post['id']==Constants.uid) _simplePopup(post)
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