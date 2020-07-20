import 'package:flutter/material.dart';

Row buildUserInfo(snapshot, int index) {
  return Row(
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
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        snapshot.data[index].data['displayName'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
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
                        DateTime.fromMicrosecondsSinceEpoch(snapshot.data[index]
                                .data['created'].microsecondsSinceEpoch)
                            .toString(),
                        style:
                            TextStyle(fontSize: 9, color: Colors.grey.shade600))
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ],
  );
}
