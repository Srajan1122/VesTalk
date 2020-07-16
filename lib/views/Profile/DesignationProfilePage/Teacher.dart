import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:socail_network_flutter/Widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/details.dart';
import 'dart:async';

class TeacherProfile extends StatefulWidget {
  final String uid;
  TeacherProfile({@required this.uid});
  @override
  _TeacherProfilePage createState() => _TeacherProfilePage();
}

class _TeacherProfilePage extends State<TeacherProfile> {
  String name = '';
  String email = '';
  String photoUrl = '';

  getUserData() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            name = value.getString("displayName");
            email = value.getString("email");
            photoUrl = value.getString("photoUrl");
          })
        });
  }

  @override
  void initState() {
    super.initState();
    print("helllllllo" + email);
    getUserData();
    print("helllllllo" + email);
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
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://www.w3schools.com/w3css/img_lights.jpg')),
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
                          'Pooja Shety',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Teacher,',
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              '  INFT',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                        Text(
                          'Pooja.shety@ves.ac.in',
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
