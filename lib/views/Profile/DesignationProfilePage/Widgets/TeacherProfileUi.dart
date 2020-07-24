import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/constant.dart';
import '../TeacherEditProfile.dart';

class TeacherProfileUi extends StatelessWidget {
  const TeacherProfileUi({
    Key key,
    @required this.photoUrl,
    @required this.name,
    @required this.designation,
    @required this.branch,
    @required this.email,
    @required this.post,
    @required this.uid,
    @required this.refreshAction
  }) : super(key: key);

  final String photoUrl;
  final String name;
  final String designation;
  final String branch;
  final String email;
  final String post;
  final String uid;
  final VoidCallback refreshAction;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Column(children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 20.0,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: CircleAvatar(
                    radius: 65.0,
                    backgroundImage: photoUrl == null
                        ? AssetImage('images/LoginPage/google.png')
                        : NetworkImage(photoUrl),
                  ),
                ),
              ),
              Container(
                margin: new EdgeInsets.fromLTRB(170.0, 55.0, 10.0, 10.0),
                height: 125.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      email,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      designation,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      branch,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      post,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(width: 5.0),
                  ],
                ),
              ),
            ],
          ),
        ),
        uid==Constants.uid ? GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TeacherEditProfile(
                  photoUrl: photoUrl,
                  name: name,
                  email: email,
                  designation: designation,
                  branch: branch,
                  post: post,
                ))).then((value){
                  refreshAction();
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            width: double.infinity,
            height: 30.0,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(4.0)),
            child: Text('Edit Profile',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
          ),
        ):Container(),
        Divider(
            height: 30.0,
            thickness: 10,
            color: Color(0xFFF5F5F5)
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Icon(
                    Icons.photo_library
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
                child: Text(
                  "Posts",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
