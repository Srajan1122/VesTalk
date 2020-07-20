import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/newPost/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

class likeAndShare extends StatefulWidget {
  final String postId;
  likeAndShare({@required this.postId});
  @override
  _likeAndShareState createState() => _likeAndShareState();
}

class _likeAndShareState extends State<likeAndShare> {
  bool like = false;
  liked(){
    setState(() {
      like=!like;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ButtonTheme(
            minWidth: 150,
            child: RaisedButton.icon(
              icon: FaIcon(FontAwesomeIcons.solidHeart, color: Colors.redAccent),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onPressed: () async {
                DatabaseMethods _databaseMethods = DatabaseMethods();
                await _databaseMethods.updateLike(widget.postId, Constants.uid);
               print(like.toString()+"  gbghbheh");
               liked();
              },
              color: like? Colors.blue : Colors.grey.shade200,
              label: Text('Like'),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onPressed: () {},
              color: Colors.grey.shade200,
              label: Text('Share'),
            ),
          ),
        ],
      ) ,
    );
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