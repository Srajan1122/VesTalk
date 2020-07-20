import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Home/postDetails.dart';
import 'package:socail_network_flutter/views/Home/widgets/userInfoHome.dart';
import 'package:socail_network_flutter/views/Home/widgets/widgetsDetail.dart';
import 'package:socail_network_flutter/views/newPost/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

Widget listbuidler(BuildContext context, snapshot) {
  {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (_, index) {
          return buildPost(context, snapshot, index);
        });
  }
}

Container buildPost(BuildContext context, snapshot, int index) {
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
                            buildUserInfo(snapshot, index),
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
              buildBottomLikeAndCommentUi()

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
            child:  ChewieListItem(
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

          margin: EdgeInsets.only(top: 10,bottom: 10),
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
Column buildBottomLikeAndCommentUi(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(top: 2,left: 8,right: 8),
        width: double.infinity,
        height: 2,
        color: Colors.grey.shade300,
        ),
      Container(
        padding: EdgeInsets.all(5),
        width: double.infinity,
        height: 50,
        child: likeAndShare(),
      )
    ],
  );
}
