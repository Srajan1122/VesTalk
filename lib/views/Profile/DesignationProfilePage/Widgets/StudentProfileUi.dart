import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/details.dart';

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
      child: ListView(children: <Widget>[
        new Column(children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 310.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'images/ProfilePage/Profile.jpg'))),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 20.0,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    height: 130.0,
                    width: 130.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (photoUrl == null
                                ? AssetImage('images/LoginPage/google.png')
                                : NetworkImage(photoUrl))),
                        border: Border.all(color: Colors.black, width: 2.0)),
                  ),
                ),
                Container(
                  margin: new EdgeInsets.fromLTRB(170.0, 55.0, 10.0, 10.0),
                  height: 150.0,
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
                Container(
                    margin: new EdgeInsets.fromLTRB(350.0, 20.0, 10.0, 10.0),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
//                            Navigator.pushReplacement(context,
//                                MaterialPageRoute(builder: (context) => Details(designation: "Student")));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                Details(designation: designation)));
                      },
                    ))
              ],
            ),
          ),
        ])
      ]),
    );
  }
}
