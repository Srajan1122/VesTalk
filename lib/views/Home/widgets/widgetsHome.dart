import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Home/postDetails.dart';
import 'package:socail_network_flutter/views/Home/widgets/userInfoHome.dart';
import 'package:socail_network_flutter/views/newPost/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

Widget listbuidler(BuildContext context, snapshot) {
  {
    return ListView.builder(
        itemCount: snapshot.data.length,
        cacheExtent: 10000,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Container(
                  height: 50,
                  child: Text(
                    snapshot.data[index].data['description'],
                    overflow: TextOverflow.fade,
                  ),
                ),
              )
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
          height: 250.0,
          width: 8100.0,
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
      ? Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
              height: 200,
              child: Image.network(snapshot.data[index].data['fileUrl'],
                  fit: BoxFit.fitHeight)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 10,
          margin: EdgeInsets.all(20),
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
        child: Text(
          snapshot.data[index].data['description'],
          overflow: TextOverflow.fade,
        ),
      ));
}
