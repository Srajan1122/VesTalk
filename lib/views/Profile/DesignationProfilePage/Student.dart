import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/details.dart';

class StudentProfile extends StatefulWidget {
  final String uid;
  StudentProfile({@required this.uid});
  @override
  _StudentProfilePage createState() => _StudentProfilePage();
}

class _StudentProfilePage extends State<StudentProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String name, photoUrl, email, designation, phone_number, branch, year;
  // TODO : add details from db

  getUserData() async {
    List<DocumentSnapshot> documents =
        await databaseMethods.findUserById(widget.uid);
    setState(() {
      name = documents[0]['displayName'];
      email = documents[0]['email'];
      photoUrl = documents[0]['photoUrl'] ?? 'http://NoUrl';
      designation = documents[0]['designation'];
    });
    print(widget.uid);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
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
                              'INFT,',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              '  2nd YEAR',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                        Text(
                          '65626565',
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Details(designation: "Student")));
                        },
                      ))
                ],
              ),
            ),
          ])
        ]),
      ),
    );
  }
}
