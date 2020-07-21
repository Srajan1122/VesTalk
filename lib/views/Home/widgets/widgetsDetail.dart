import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/newPost/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class likeAndShare extends StatefulWidget {
  final String postId, desc, name;
  likeAndShare({@required this.postId, this.desc, this.name});
  @override
  _likeAndShareState createState() => _likeAndShareState();
}

class _likeAndShareState extends State<likeAndShare> {
  int liked;
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
    return Container(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 2, left: 8),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Text(liked.toString()),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.thumb_up,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2, left: 8, right: 8),
            width: double.infinity,
            height: 2,
            color: Colors.grey.shade300,
          ),
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
                  onPressed: () async {
                    DatabaseMethods _databaseMethods = DatabaseMethods();
                    await _databaseMethods.updateLike(
                        widget.postId, Constants.uid);
                    print(like.toString() + "  gbghbheh");
                    pressedLike();
                  },
                  color: like ? Colors.blue : Colors.grey.shade200,
                  label: like ? Text('Liked') : Text('Like'),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              ButtonTheme(
                minWidth: 150,
                child: RaisedButton.icon(
                  icon: FaIcon(
                    FontAwesomeIcons.share,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    FlutterShareMe().shareToWhatsApp(
                        msg: widget.desc +
                            "\nPosted By -" +
                            widget.name +
                            "\nRead More on VESTalk");
                  },
                  color: Colors.grey.shade200,
                  label: Text('Share'),
                ),
              ),
            ],
          ),
        ],
    ));
  }
}

Container buildUserVideo(post) {
  return (((post['fileUrl'] != null) && (post['isVideo']))
      ? Container(
          height: 250.0,
          width: 8100.0,
          child: ChewieListItem(
              videoPlayerController:
                  VideoPlayerController.network(post['fileUrl']),
              aspectRatio: VideoPlayerController.network(post['fileUrl'])
                  .value
                  .aspectRatio),
        )
      : Container());
}

StatelessWidget buildUserImage(post) {
  return (((post['fileUrl'] != null) && (!post['isVideo']))
      ? Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
              height: 200,
              child: Image.network(post['fileUrl'], fit: BoxFit.fitHeight)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          margin: EdgeInsets.all(20),
        )
      : Container());
}

Container buildUserDesc(post) {
  return Container(
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
  );
}
