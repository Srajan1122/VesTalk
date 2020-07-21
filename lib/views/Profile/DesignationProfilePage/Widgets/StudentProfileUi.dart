import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Profile/EditProfile.dart';

class StudentProfileUi extends StatelessWidget {
  const StudentProfileUi(
      {Key key,
      @required this.photoUrl,
      @required this.name,
      @required this.email,
      @required this.designation,
      @required this.branch,
      @required this.year,
      @required this.phoneNumber,
      @required this.batch,
      @required this.uid})
      : super(key: key);

  final String photoUrl;
  final String name;
  final String email;
  final String designation;
  final String branch;
  final String batch;
  final String year;
  final String phoneNumber;
  final String uid;

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
                    Row(
                      children: <Widget>[
                        Text(
                          branch,
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          year,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                    Text(
                      phoneNumber,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        uid==Constants.uid ? GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EditProfile(
                    photoUrl: photoUrl,
                    name: name,
                    email: email,
                    designation: designation,
                    branch: branch,
                    batch: batch,
                    year: year,
                    phoneNumber: phoneNumber,
                  )));
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
          height: 50.0,
        ),
      ]),
    );
  }
}
