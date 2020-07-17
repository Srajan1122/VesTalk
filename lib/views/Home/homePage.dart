import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socail_network_flutter/views/newPost/chewie_list_itme.dart';
import 'package:video_player/video_player.dart';
// import 'package:socail_network_flutter/Widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future getPosts() async {
    QuerySnapshot qn =
        await Firestore.instance.collection('posts').getDocuments();
    return qn.documents;
  }

  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: Colors.black,
        // appBar: GetAppBar(),
        body: Container(
      child: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading....'));
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Container(
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      child: Container(
//                            decoration: BoxDecoration(
//                              border: Border(
//                                bottom: BorderSide(
//                                    width: 2.0, color: Colors.redAccent),
//                              ),
//                            ),
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
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Card(
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(snapshot
                                                                      .data[index]
                                                                      .data[
                                                                  'photoUrl']),
                                                        ),
                                                        elevation: 15.0,
                                                        shape: CircleBorder(),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                      ),
                                                      Column(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    40,
                                                                    0,
                                                                    0,
                                                                    10),
                                                            child: Text(
                                                              snapshot
                                                                      .data[index]
                                                                      .data[
                                                                  'displayName'],
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          Text(
                                                            snapshot.data[index]
                                                                    .data[
                                                                'designation'],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ]),
                            ),
                            (((snapshot.data[index].data['fileUrl'] != null) &&
                                    (!snapshot.data[index].data['isVideo']))
                                ? Container(
                                    height: 250.0,
                                    width: 8100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data[index].data['fileUrl']),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )
                                : Container()),
                            (((snapshot.data[index].data['fileUrl'] != null) &&
                                    (snapshot.data[index].data['isVideo']))
                                ? Container(
                                    height: 250.0,
                                    width: 8100.0,
                                    child: ChewieListItem(
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                                snapshot.data[index]
                                                    .data['fileUrl'])),
                                  )
                                : Container()),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
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
                  );
                });
          } else {
            return Center(child: Text('No Posts Available'));
          }
        },
      ),
    ));
  }
}
