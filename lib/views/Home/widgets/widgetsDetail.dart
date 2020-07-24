import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Home/postDetail.dart';
import 'package:socail_network_flutter/views/newPost/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

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
              child: Image.network(post['fileUrl'], fit: BoxFit.contain)),
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

class LikeAndShare extends StatefulWidget {
  final String postId, desc, name, userId;
  LikeAndShare({@required this.postId, this.desc, this.name, this.userId});
  @override
  _LikeAndShareState createState() => _LikeAndShareState();
}

class _LikeAndShareState extends State<LikeAndShare> {
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
      if(!mounted) return;
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
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
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
            IconButton(
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
          ],
        ),
      ],
    );
  }
}
