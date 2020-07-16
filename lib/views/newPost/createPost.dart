import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socail_network_flutter/views/newPost/chewie_list_itme.dart';
import 'package:video_player/video_player.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  ImagePicker _picker = ImagePicker();
  final postController = TextEditingController();

  String description;
  File _attachment;
  bool isVideo = false;
  void handlePress() {
    if (description == null) {
      // TODO : Add alert

      Fluttertoast.showToast(msg: "Please fill post content");
    } else {
      // TODO : UI Customise alert and change buttons if needed
      // TODO  : Add firebase for post
      // get user data from shared prefs
      // Variables : - _attachment (image or video)
      //                 isVideo    (is video or not)
      //                  description (content of the post)
      setState(() {
        _attachment = null;
        description = null;
        isVideo = false;
      });
      postController.clear();
      Fluttertoast.showToast(msg: "Post Published");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _displayOptionsDialog() async {
    await _optionsDialogBox();
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text('Choose from the following!',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      // width: 320.0,
                      child: RaisedButton(
                        onPressed: openCamera,
                        child: Text(
                          "Open Camera",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    ),
                    Center(
                      // width: 320.0,
                      child: RaisedButton(
                        onPressed: openGallery,
                        child: Text(
                          "Open Gallery",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  openCamera() async {
    if (isVideo) {
      PickedFile pickedfile =
          await _picker.getVideo(source: ImageSource.camera);

      setState(() {
        _attachment = File(pickedfile.path);
      });
    } else {
      PickedFile pickedfile =
          await _picker.getImage(source: ImageSource.camera);
      setState(() {
        _attachment = File(pickedfile.path);
      });
    }
  }

  openGallery() async {
    if (isVideo) {
      PickedFile pickedfile =
          await _picker.getVideo(source: ImageSource.gallery);

      setState(() {
        _attachment = File(pickedfile.path);
      });
    } else {
      PickedFile pickedfile =
          await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _attachment = File(pickedfile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 400),
                      child: TextField(
                        controller: postController,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: ("What do you want to talk about?"),
                          hintText: ('Enjoy Posting!'),
                        ),
                        onChanged: (val) => {
                          setState(() {
                            description = val;
                          })
                        },
                      ),
                    ),
                  )),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ((_attachment != null && isVideo == true)
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: <Widget>[
                                  ChewieListItem(
                                      videoPlayerController:
                                          VideoPlayerController.file(
                                              _attachment)),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 30),
                                    child: Ink(
                                      decoration: ShapeDecoration(
                                        color: Colors.black,
                                        shape: CircleBorder(),
                                      ),
                                      child: IconButton(
                                          tooltip: 'Discard',
                                          color: Colors.white,
                                          icon: Icon(Icons.close),
                                          onPressed: () => {
                                                setState(() {
                                                  isVideo = false;
                                                  _attachment = null;
                                                })
                                              }),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container()),
                    )
                  ],
                ),
              ),
              Container(
                  child: ((_attachment != null && isVideo == false)
                      ? Column(
                          children: <Widget>[
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: SizedBox(
                                  height: 200,
                                  child: Image.file(_attachment,
                                      fit: BoxFit.fitHeight)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10,
                              margin: EdgeInsets.all(20),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                              child: Ink(
                                decoration: ShapeDecoration(
                                  color: Colors.black,
                                  shape: CircleBorder(),
                                ),
                                child: IconButton(
                                    tooltip: 'Discard',
                                    color: Colors.white,
                                    icon: Icon(Icons.close),
                                    onPressed: () => {
                                          setState(() {
                                            _attachment = null;
                                          })
                                        }),
                              ),
                            )
                          ],
                        )
                      : Container())),
              OutlineButton(
                  onPressed: handlePress,
                  child: Text('Publish Post'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))
            ],
          ),
        ]),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22),
          backgroundColor: Colors.lightBlueAccent,
          visible: true,
          curve: Curves.bounceIn,
          children: [
            // FAB 1
            SpeedDialChild(
                child: Icon(Icons.image),
                backgroundColor: Colors.lightBlueAccent,
                onTap: _displayOptionsDialog,
                label: 'Add Image',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.lightBlueAccent),
            // FAB 2
            SpeedDialChild(
                child: Icon(Icons.video_call),
                backgroundColor: Colors.lightBlueAccent,
                onTap: () => {
                      setState(() {
                        isVideo = true;
                      }),
                      _displayOptionsDialog()
                    },
                label: 'Add Video',
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16.0),
                labelBackgroundColor: Colors.lightBlueAccent)
          ],
        ));
  }
}
