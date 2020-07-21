import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentProfileUi extends StatelessWidget {
  const StudentProfileUi({
    Key key,
    @required this.photoUrl,
    @required this.name,
    @required this.email,
    @required this.designation,
    @required this.branch,
    @required this.year,
    @required this.phoneNumber,
  }) : super(key: key);

  final String photoUrl;
  final String name;
  final String email;
  final String designation;
  final String branch;
  final String year;
  final String phoneNumber;

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
        Divider(
          height: 50.0,
        ),
      ]),
    );
  }
}
