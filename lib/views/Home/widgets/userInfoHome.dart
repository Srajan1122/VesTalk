import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:timeago/timeago.dart' as timeago;

Row buildUserInfo(snapshot, int index) {
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
                padding: const EdgeInsets.only(left: 1,top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        snapshot.data[index].data['displayName'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
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
                        timeago.format(snapshot.data[index]
                                .data['created'].toDate())
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
      if(snapshot.data[index].data['id']==Constants.uid) _simplePopup(snapshot.data[index].documentID)



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