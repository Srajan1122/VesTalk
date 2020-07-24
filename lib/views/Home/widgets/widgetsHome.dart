import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Home/postDetail.dart';
import 'package:socail_network_flutter/views/Home/postDetails.dart';
import 'package:socail_network_flutter/views/Home/widgets/userInfoHome.dart';

import 'package:socail_network_flutter/views/newPost/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

class likeAndShare extends StatefulWidget {
  final String postId, desc, name, userId;
  likeAndShare({@required this.postId, this.desc, this.name, this.userId});
  @override
  _likeAndShareState createState() => _likeAndShareState();
}

class _likeAndShareState extends State<likeAndShare> {
  int liked;
  FaIcon solidHeart =
      FaIcon(FontAwesomeIcons.solidHeart, color: Colors.redAccent);
  FaIcon heart = FaIcon(FontAwesomeIcons.heart);
  FaIcon icon;
  List userLiked;
  bool like = false;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  pressedLike() {
    databaseMethods.getLikedInfo(widget.postId).then((value) {
      setState(() {
        liked = value.data['liked'];
        userLiked = value.data['userLikedList'];
        if (userLiked.contains(Constants.uid) == true) {
          like = true;
        } else {
          like = false;
        }
      });
    });
  }

  @override
  void initState() {
    databaseMethods.getLikedInfo(widget.postId).then((val) {
      setState(() {
        liked = val.data['liked'];
        userLiked = val.data['userLikedList'];
        if (userLiked.contains(Constants.uid) == true) {
          like = true;
        } else {
          like = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 1,
          width: double.maxFinite,
          color: Colors.grey.shade500,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      iconSize: 20,
                      color: Colors.grey.shade500,
                      tooltip: like ? 'Dislike' : 'Like',
                      icon: like ? solidHeart : heart,
                      onPressed: () async {
                        DatabaseMethods _databaseMethods = DatabaseMethods();
                        await _databaseMethods.updateLike(
                            widget.postId, Constants.uid);
                        pressedLike();
                      },
                    ),
                    Text(liked.toString()),
                  ],
                ),
                Text('Like', style: TextStyle(fontSize: 15))
              ],
            ),
            Column(
              children: <Widget>[
                IconButton(
                  iconSize: 20,
                  tooltip: 'Comment',
                  icon: FaIcon(
                    FontAwesomeIcons.comment,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostDetails(
                                postId: widget.postId, userId: widget.userId)));
                  },
                  color: Colors.grey.shade900,
                ),
                Text('Comment', style: TextStyle(fontSize: 15))
              ],
            ),
            // Column(
            //   children: <Widget>[
            //     IconButton(
            //       iconSize: 28,
            //       tooltip: 'Report',
            //       icon: Icon(
            //         Icons.report,
            //         color: Colors.deepOrange,
            //       ),
            //       onPressed: () {
            //         FlutterShareMe().shareToWhatsApp(
            //             msg: widget.desc +
            //                 "\nPosted By -" +
            //                 widget.name +
            //                 "\nRead More on VESTalk");
            //       },
            //       color: Colors.grey.shade900,
            //     ),
            //     Text('Report', style: TextStyle(fontSize: 15))
            //   ],
            // ),
            Column(
              children: <Widget>[
                IconButton(
                  iconSize: 20,
                  tooltip: 'Share',
                  icon: FaIcon(
                    FontAwesomeIcons.shareAlt,
                  ),
                  onPressed: () {
                    FlutterShareMe().shareToWhatsApp(
                        msg: widget.desc +
                            "\nPosted By -" +
                            widget.name +
                            "\nRead More on VESTalk");
                  },
                  color: Colors.grey.shade900,
                ),
                Text(
                  'Share',
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Widget listbuidler(BuildContext context, snapshot, Function refresh) {
  {
    return ListView.builder(
        itemCount: snapshot.data.length,
        cacheExtent: 10000,
        itemBuilder: (_, index) {
          return buildPost(context, snapshot, index, refresh);
        });
  }
}

Container buildPost(BuildContext context, snapshot, int index, Function refresh) {
  return Container(
    width: double.maxFinite,
    child: Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostDetails(
                      postId: snapshot.data[index].documentID,
                      userId: snapshot.data[index].data['id'])));
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(7),
                child: Stack(children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            buildUserInfo(snapshot, index, context, refresh),
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ),
              buildUserDesc(snapshot, index),
              buildUserImage(snapshot, index),
              buildUserVideo(snapshot, index),
              buildBottomLikeAndCommentUi(
                  snapshot.data[index].documentID,
                  snapshot.data[index].data['description'],
                  snapshot.data[index].data['id'],
                  snapshot.data[index].data['displayName'])
            ],
          ),
        ),
      ),
    ),
  );
}

Container buildUserVideo(snapshot, int index) {
  return (((snapshot.data[index].data['fileUrl'] != null) &&
          (snapshot.data[index].data['isVideo']))
      ? Container(
          height: 450.0,
          margin: EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: ChewieListItem(
              videoPlayerController: VideoPlayerController.network(
                  snapshot.data[index].data['fileUrl']),
              aspectRatio: VideoPlayerController.network(
                      snapshot.data[index].data['fileUrl'])
                  .value
                  .aspectRatio),
        )
      : Container());
}

StatelessWidget buildUserImage(snapshot, int index) {
  return (((snapshot.data[index].data['fileUrl'] != null) &&
          (!snapshot.data[index].data['isVideo']))
      ? Container(
          child: SizedBox(
              height: 450.0,
              width: double.infinity,
              child: Image.network(snapshot.data[index].data['fileUrl'],
                  fit: BoxFit.fitHeight)),
          margin: EdgeInsets.only(top: 10, bottom: 10),
        )
      : Container());
}

FittedBox buildUserDesc(snapshot, int index) {
  return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        alignment: Alignment.topLeft,
        width: 400,
        padding: EdgeInsets.only(left: 16, right: 16),
        margin: EdgeInsets.only(bottom: 2),
        child: Text(
          snapshot.data[index].data['description'],
          overflow: TextOverflow.fade,
        ),
      ));
}

Container buildBottomLikeAndCommentUi(postId, desc, id, displayName) {
  return Container(
    padding: EdgeInsets.all(5),
    width: double.infinity,
    // height: 90,
    child:
        likeAndShare(postId: postId, desc: desc, userId: id, name: displayName),
  );
}
