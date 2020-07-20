import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentList extends StatelessWidget {
  final Future comments;
  const CommentList({Key key, @required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: comments,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          }
          return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                DocumentSnapshot comment = snapshot.data[index];
                if (comment == null) {
                  return Text('Loading');
                }

                return Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(comment['photoUrl']),
                                  ),
                                ),
                                elevation: 9.0,
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAlias,
                              ),

                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 50, 0),
                                  width: 250,
//                                  color: Colors.black,
                                  child: Text.rich(
                                    TextSpan(
                                      text: comment['displayName'] + '\n',
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1.2,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                            comment['designation'] + '\n',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 1)),
                                        TextSpan(
                                            text: timeago.format(
                                                comment['created'].toDate()),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 1)),
                                      ],
                                    ),
                                  ),
                              ),
                              Container(
                                width: 250,
                                color: Colors.black,
                                child: Text(comment['comment'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1)
                                ),
                              ),
                            ],

                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    )
                  ],
                );
              });
        });
  }
}

//@override
//Widget build(BuildContext context) {
//  return FutureBuilder(
//      future: comments,
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Text('Loading...');
//        }
//        return ListView.builder(
//            shrinkWrap: true,
//            physics: ScrollPhysics(),
//            itemCount: snapshot.data.length,
//            itemBuilder: (_, index) {
//              DocumentSnapshot comment = snapshot.data[index];
//              if (comment == null) {
//                return Text('Loading');
//              }
//
//              return Column(
//                children: <Widget>[
//                  Container(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Card(
//                              child: Align(
//                                alignment: Alignment.topLeft,
//                                child: CircleAvatar(
//                                  backgroundColor: Colors.black,
//                                  radius: 25,
//                                  backgroundImage:
//                                  NetworkImage(comment['photoUrl']),
//                                ),
//                              ),
//                              elevation: 9.0,
//                              shape: CircleBorder(),
//                              clipBehavior: Clip.antiAlias,
//                            ),
//                            Container(
//                                padding: EdgeInsets.only(top: 5),
//                                width: 85,
//                                child: Center(
//                                  child: Text.rich(
//                                    TextSpan(
//                                      text: comment['displayName'] + '\n',
//                                      style: TextStyle(
//                                          color: Colors.black,
//                                          letterSpacing: 1.2,
//                                          fontSize: 10,
//                                          fontWeight: FontWeight.bold),
//                                      children: <TextSpan>[
//                                        TextSpan(
//                                            text:
//                                            comment['designation'] + '\n',
//                                            style: TextStyle(
//                                                color: Colors.black,
//                                                fontWeight: FontWeight.w300,
//                                                letterSpacing: 1)),
//                                        TextSpan(
//                                            text: timeago.format(
//                                                comment['created'].toDate()),
//                                            style: TextStyle(
//                                                color: Colors.black,
//                                                fontWeight: FontWeight.w300,
//                                                letterSpacing: 1)),
//                                      ],
//                                    ),
//                                  ),
//                                ))
//                          ],
//                        ),
//                        Container(
//                            width: 250,
//                            color: Colors.black,
//                            child: Text(comment['comment'],
//                                style: TextStyle(
//                                    fontSize: 12,
//                                    fontWeight: FontWeight.w300,
//                                    letterSpacing: 1))),
//                      ],
//                    ),
//                  ),
//                  Divider(
//                    thickness: 1,
//                    indent: 20,
//                    endIndent: 20,
//                  )
//                ],
//              );
//            });
//      });
//}
