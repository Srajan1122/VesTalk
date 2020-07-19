import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/newPost/chewie_list_itme.dart';
import 'package:video_player/video_player.dart';
import 'package:socail_network_flutter/views/Home/postDetails.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future _data;

  Future getPosts() async {
    print('i got called');
    QuerySnapshot qn = await Firestore.instance
        .collection('posts')
        .orderBy('created', descending: true)
        .getDocuments();
    return qn.documents;
  }

  Future<void> _refresh() async {
    if(!mounted) return;
    setState(() {
      Constants.data = getPosts();
    });
  }

  @override
  void initState() {
    super.initState();
    if (Constants.data == null) {
      print('heelo');
      Constants.data = getPosts();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: Colors.black,
//        appBar: getAppBar(),
        body: Container(
      child: RefreshIndicator(
        child: FutureBuilder(
          future: Constants.data,
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PostDetails(
                                        postId: snapshot.data[index].documentID,
                                        userId:
                                            snapshot.data[index].data['id'])));
                          },
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1.0,top: 0),
                                                    child: Align(
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Card(
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              radius: 25,
                                                              backgroundImage:
                                                                  NetworkImage(snapshot
                                                                          .data[
                                                                              index]
                                                                          .data[
                                                                      'photoUrl']),
                                                            ),
                                                            elevation: 1.0,
                                                            shape:
                                                                CircleBorder(),
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                          ),
                                                          Container(
                                                                padding: const EdgeInsets.fromLTRB(40, 0, 0, 10),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment:MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding:
                                                                      const EdgeInsets.only(left: 2),
                                                                      child: Text(
                                                                        snapshot.data[index].data['displayName'],
                                                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      children: <Widget>[
                                                                        Text(
                                                                            snapshot.data[index]
                                                                                .data[
                                                                            'designation'],
                                                                            style:TextStyle(fontWeight: FontWeight.bold,fontSize: 10 ,
                                                                                color: Colors.grey.shade600
                                                                            )
                                                                        ),
                                                                        Text(':-',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 10 ,
                                                                            color: Colors.grey.shade600
                                                                        )),
                                                                        SizedBox(width: 3,),
                                                                      ],
                                                                    ),
                                                                    Text( DateTime.fromMicrosecondsSinceEpoch(snapshot.data[index].data['created'].microsecondsSinceEpoch).toString(),
                                                                        style:TextStyle(fontSize: 9 ,
                                                                            color: Colors.grey.shade600
                                                                        ))
                                                                  ],
                                                                ),
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
                                FittedBox(fit: BoxFit.fill,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      width: 400,
                                      padding: EdgeInsets.only(left: 16,right: 16),
                                      child:
                                      Text(
                                        snapshot.data[index].data['description'],
                                        overflow: TextOverflow.fade,
                                      ),
                                    )
                                ),
                                (((snapshot.data[index].data['fileUrl'] !=
                                            null) &&
                                        (!snapshot.data[index].data['isVideo']))
                                    ? Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: SizedBox(
                                            height: 200,
                                            child: Image.network(
                                                snapshot.data[index]
                                                    .data['fileUrl'],
                                                fit: BoxFit.fitHeight)),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        elevation: 10,
                                        margin: EdgeInsets.all(20),
                                      )
                                    : Container()),
                                (((snapshot.data[index].data['fileUrl'] !=
                                            null) &&
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 0),
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
                  });
            } else {
              return Center(child: Text('No Posts Available'));
            }
          },
        ),
        onRefresh: _refresh,
      ),
    ));
  }
}
