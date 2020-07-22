import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:socail_network_flutter/views/editPost/editPost.dart';

Row buildUserInfo(snapshot, int index, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 1.0, top: 0),
        child: Align(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  backgroundImage:
                      NetworkImage(snapshot.data[index].data['photoUrl']),
                ),
                elevation: 1.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
              Container(
                padding: const EdgeInsets.only(left: 1, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      snapshot.data[index].data['displayName'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Row(
                      children: <Widget>[
                        Text(snapshot.data[index].data['designation'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.grey.shade600)),
                        Text(':-',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.grey.shade600)),
                        SizedBox(
                          width: 3,
                        ),
                      ],
                    ),
                    Text(
                        timeago
                            .format(
                                snapshot.data[index].data['created'].toDate())
                            .toString(),
                        style:
                            TextStyle(fontSize: 9, color: Colors.grey.shade600))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      if (snapshot.data[index].data['id'] == Constants.uid)
        _simplePopup(snapshot.data[index].documentID, context)
    ],
  );
}

Widget _simplePopup(postId, context) {
  DatabaseMethods _database = DatabaseMethods();
  return PopupMenuButton<int>(
    onSelected: (value) => {
      if (value == 0)
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditPost(postId: postId)))
        }
      else if (value == 1)
        {_database.deletePost(postId)}
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 0,
        child: Text("Edit"),
      ),
      PopupMenuItem(
        value: 1,
        child: Text("Delete"),
      ),
    ],
  );
}
