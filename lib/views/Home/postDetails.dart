import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/views/SignIn/SignIn.dart';
import 'package:socail_network_flutter/views/newPost/chewie_list_itme.dart';
import 'package:video_player/video_player.dart';

class PostDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.only(top: 35), children: <Widget>[
        Container(
            child: Column(children: <Widget>[
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
                          NetworkImage('https://picsum.photos/id/28/200/300'),
                    ),
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
                              text: 'Devdatta Khoche\n',
                              style: TextStyle(
                                  color: Colors.black,
                                  letterSpacing: 1.2,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'Teacher\n',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1)),
                          TextSpan(
                              text: 'July 18, 2020 at 2:49:21 PM ',
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
                      icon: FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.blue,
                      ),
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
          (true
              ? Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: SizedBox(
                      height: 200,
                      child: Image.network(
                          'https://picsum.photos/id/20/500/200',
                          fit: BoxFit.fitHeight)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 10,
                  margin: EdgeInsets.all(20),
                )
              : Container()),
//          (true
//              ? Container(
//                  height: 250.0,
//                  width: 8100.0,
//                  child: ChewieListItem(
//                      videoPlayerController: VideoPlayerController.network(
//                          'http://www.sample-videos.com/video123/mp4/720/video123/mp4/720/big_buck_bunny_720p_1mb.mp4')),
//                )
//              : Container()),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Flutter Video Player: A Flutter plugin used for iOS and Android for playing back video on a Widget surface. Adding Dependency Packages to the Flutter: To use Video Player in Flutter we need to add its dependency package into the pubspec.yaml file \n  Flutter Video Player: A Flutter plugin used for iOS and Android for playing back video on a Widget surface. Adding Dependency Packages to the Flutter: To use Video Player in Flutter we need to add its dependency package into the pubspec.yaml fileFlutter Video Player: A Flutter plugin used for iOS and Android for playing back video on a Widget surface. Adding Dependency Packages to the Flutter: To use Video Player in Flutter we need to add its dependency package into the pubspec.yaml file',
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  child: Align(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/id/28/200/300'),
                    ),
                  ),
                  elevation: 9.0,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                ),
                Text('Flutter Video Pladeo Player in Flutter we nee')
              ],
            ),
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  child: Align(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      backgroundImage:
                          NetworkImage('https://picsum.photos/id/28/200/300'),
                    ),
                  ),
                  elevation: 9.0,
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                ),
                Text('Flutter Video Pladeo Player in Flutter we nee')
              ],
            ),
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
//          ListView.builder(
//              itemCount: 3,
//              itemBuilder: (_, index) {
//                return Container(child: Text('Comments'));
//              })
        ])),
      ]),
    );
  }
}
