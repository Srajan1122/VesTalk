import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/newPost/widgets/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  ImagePicker _picker = ImagePicker();
  ProgressDialog _pr;
  final postController = TextEditingController();
  bool loading = false;
  String description, id;
  File _attachment;
  bool isVideo = false;

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            id = value.getString('id');
          })
        });
  }

  void handlePress() async {
    await getUserId();
    if (description == null) {
      _showDialog();
      Fluttertoast.showToast(msg: "Please fill post content");
    } else {
      await _pr.show();
      await databaseMethods.uploadFile(id, description, _attachment, isVideo);
      await _pr.hide();

      setState(() {
        _attachment = null;
        description = null;
        isVideo = false;
      });
      postController.clear();
      Fluttertoast.showToast(msg: "Post Published");
    }
  }

  Widget _progressWidget = Image.asset(
    'images/double_ring_loading_io.gif',
  );

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Warning !",
            textAlign: TextAlign.center,
          ),
          content: new Text("Please enter description"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Color(0xFFFC2542)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                    Column(
                      children: <Widget>[
                        Center(
                            child: Text('Choose from the following!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Center(
                              // width: 320.0,
                              child: FlatButton(
                                onPressed: () {
                                  openCamera();
                                  Navigator.of(context).pop();
                                },
                                textColor: Colors.white,
                                color: Colors.transparent,
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 0, 0),
                                splashColor: Colors.lightBlue,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: const Text('Open Camera',
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ),
                            ),
                            Center(
                              // width: 320.0,
                              child: FlatButton(
                                onPressed: () {
                                  openGallery();
                                  Navigator.of(context).pop();
                                },
                                textColor: Colors.white,
                                color: Colors.transparent,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                splashColor: Colors.lightBlue,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: const Text('Open Gallery',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Montserrat')),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
    _pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    _pr.style(
      progressWidget: _progressWidget,
      message: 'Posting...',
    );
    return FocusWatcher(
      child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.search),
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.check),
                color: Colors.black,
                onPressed: handlePress,
              )
            ],
            title: Center(
              child: Text(
                'New Story',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          resizeToAvoidBottomInset: false,
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
                                                _attachment),
                                        aspectRatio: VideoPlayerController.file(
                                                _attachment)
                                            .value
                                            .aspectRatio),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 30),
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
//                 FlatButton(
//                   onPressed: handlePress,
//                   textColor: Colors.white,
//                   color: Colors.transparent,
//                   padding: const EdgeInsets.all(0.0),
//                   splashColor: Colors.lightBlue,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       color: Colors.lightBlue,
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: const EdgeInsets.all(10.0),
//                     child: const Text('Publish Post',
//                         style:
//                             TextStyle(fontSize: 16, fontFamily: 'Montserrat')),
//                   ),
// //                  color: Color(0xFF000050),
// //                  child: Text('Publish Post', style: TextStyle(color: Color(0xFFFC2542)),),
//                 ),
              ],
            ),
          ]),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22),
            backgroundColor: Colors.lightBlue,
            visible: true,
            curve: Curves.bounceIn,
            children: [
              // FAB 1
              SpeedDialChild(
                  child: Icon(Icons.image),
                  backgroundColor: Colors.lightBlue,
                  onTap: _displayOptionsDialog,
                  label: 'Add Image',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16.0),
                  labelBackgroundColor: Colors.black87),
              // FAB 2
              SpeedDialChild(
                  child: Icon(Icons.video_call),
                  backgroundColor: Colors.lightBlue,
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
                  labelBackgroundColor: Colors.black87)
            ],
          )),
    );
  }
}
