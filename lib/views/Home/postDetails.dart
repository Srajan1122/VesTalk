import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socail_network_flutter/views/newPost/chewie_list_itme.dart';
import 'package:video_player/video_player.dart';

class PostDetails extends StatefulWidget {
  final String postId, userId;

  PostDetails({@required this.postId, @required this.userId});
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  static String uid, comment = '1';
  MaterialColor flag = Colors.grey;
  TextEditingController commentController = new TextEditingController();

  getUserId() async {
    if (!mounted) return;
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            uid = value.getString('id');
            print(uid);
          })
        });
  }

  Future getComments() async {
    QuerySnapshot qn = await Firestore.instance
        .collection('posts/' + widget.postId + '/comments')
        .orderBy('created', descending: true)
        .getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    getUserId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.only(top: 35), children: <Widget>[
        Container(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('posts')
                    .document(widget.postId)
                    .snapshots(),
                builder: (context, snapshot) {
                  var post = snapshot.data;
                  if (post == null) {
                    return Text('Loading');
                  }
                  return Column(children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => {Navigator.pop(context)},
                            ),
                            Card(
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 35,
                                  backgroundImage:
                                      NetworkImage(post['photoUrl'])),
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
                                        text: timeago
                                            .format(post['created'].toDate()),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 150,
                              child: RaisedButton.icon(
                                icon: FaIcon(FontAwesomeIcons.solidHeart,
                                    color: Colors.redAccent),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {},
                                color: Colors.white54,
                                label: Text('Like'),
                              ),
                            ),
                            ButtonTheme(
                              minWidth: 150,
                              child: RaisedButton.icon(
                                icon: FaIcon(
                                  FontAwesomeIcons.share,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {},
                                color: Colors.white54,
                                label: Text('Share'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    (((post['fileUrl'] != null) && (!post['isVideo']))
                        ? Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: SizedBox(
                                height: 200,
                                child: Image.network(post['fileUrl'],
                                    fit: BoxFit.fitHeight)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 10,
                            margin: EdgeInsets.all(20),
                          )
                        : Container()),
                    (((post['fileUrl'] != null) && (post['isVideo']))
                        ? Container(
                            height: 250.0,
                            width: 8100.0,
                            child: ChewieListItem(
                                videoPlayerController:
                                    VideoPlayerController.network(
                                        post['fileUrl'])),
                          )
                        : Container()),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        post['description'],
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.5,
                          height: 1.7,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Comments',
                          style: TextStyle(
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        )),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Container(
                            width: 300,
                            color: Colors.white,
                            child: Container(
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                  hintText: "Add Comment",
                                ),
                                onChanged: (value) {
                                  if (value == null) {
                                    return;
                                  }
                                  if (value.length >= 1) {
                                    setState(() {
                                      flag = Colors.blue;
                                      comment = value;
                                    });
                                  } else {
                                    setState(() {
                                      comment = value;
                                      flag = Colors.grey;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          color: flag,
                          onPressed: () {
                            if (comment.length >= 1) {
                              uploadComment(comment, uid, widget.postId);
                              Fluttertoast.showToast(msg: 'Comment Successful');
                              commentController.clear();
                              setState(() {
                                comment = '';
                                flag = Colors.grey;
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Comment is too Short!');
                            }
                          },
                        )
                      ],
                    ),
                  ]);
                })),
        CommentList(comments: getComments()),
      ]),
    );
  }
}

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
                                    backgroundColor: Colors.white,
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(comment['photoUrl']),
                                  ),
                                ),
                                elevation: 9.0,
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAlias,
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 5),
                                  width: 85,
                                  child: Center(
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
                                  ))
                            ],
                          ),
                          Container(
                              width: 250,
                              child: Text(comment['comment'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 1))),
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
