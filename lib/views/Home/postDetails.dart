import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socail_network_flutter/views/Home/widgets/commentList.dart';
import 'package:socail_network_flutter/views/Home/widgets/userInfoDetail.dart';
import 'package:socail_network_flutter/views/Home/widgets/widgetsDetail.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  DatabaseMethods _databaseMethods = DatabaseMethods();
  getUserId() async {
    if (!mounted) return;
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
    return Scaffold(
      body: buildListView(),
    );
  }

  ListView buildListView() {
    return ListView(padding: EdgeInsets.only(top: 35), children: <Widget>[
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
                return buildDetailStream(context, post);
              })),
      CommentList(comments: _databaseMethods.getComments(widget.postId)),
    ]);
  }

  Column buildDetailStream(BuildContext context, post) {
    return Column(children: <Widget>[
      Column(
        children: <Widget>[
          buildUserInfo(context, post),
          SizedBox(height: 10),
          likeAndShare(),
        ],
      ),
      buildUserImage(post),
      buildUserVideo(post),
      buildUserDesc(post),
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
                letterSpacing: 1.5, fontWeight: FontWeight.w700, fontSize: 16),
          )),
      Divider(
        color: Colors.black,
        thickness: 1,
        indent: 20,
        endIndent: 20,
      ),
      buildCommentInput(),
    ]);
  }

  Row buildCommentInput() {
    return Row(
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
                  hintStyle: TextStyle(color: Colors.grey.shade500),
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
              Fluttertoast.showToast(msg: 'Comment is too Short!');
            }
          },
        )
      ],
    );
  }
}
