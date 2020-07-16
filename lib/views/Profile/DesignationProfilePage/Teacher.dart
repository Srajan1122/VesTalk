import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/details.dart';

class TeacherProfile extends StatefulWidget {
  final String uid;
  TeacherProfile({@required this.uid});
  @override
  _TeacherProfilePage createState() => _TeacherProfilePage();
}

class _TeacherProfilePage extends State<TeacherProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String name, photoUrl, email, designation, branch, post;
  // TODO : add details from db

  getUserData() async {
    List<DocumentSnapshot> documents =
        await databaseMethods.findUserById(widget.uid);
    setState(() {
      name = documents[0]['displayName'];
      email = documents[0]['email'];
      photoUrl = documents[0]['photoUrl'];
      designation = documents[0]['designation'];
    });
  }

  getData() async {
    await getUserData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GetAppBar(),
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
                              fit: BoxFit.cover, image: NetworkImage(photoUrl)),
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
                        Row(
                          children: <Widget>[
                            Text(
                              designation,
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              '  INFT',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                        Text(
                          email,
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          '65626565',
                          style: TextStyle(fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: new EdgeInsets.fromLTRB(350.0, 20.0, 10.0, 10.0),
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
//                                Navigator.pushReplacement(context,
//                                MaterialPageRoute(builder: (context) => Details(designation: "Teacher")));

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Details(designation: "Teacher")));
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
