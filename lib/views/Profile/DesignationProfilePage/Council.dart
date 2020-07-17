import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/details.dart';

class CouncilProfile extends StatefulWidget {
  final String uid;

  CouncilProfile({@required this.uid});

  @override
  _CouncilProfilePage createState() => _CouncilProfilePage();
}

class _CouncilProfilePage extends State<CouncilProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String name, photoUrl, email, member, description, designation;

  // TODO : Get data from db

  checkIfNull() {
    if (name == null ||
        photoUrl == null ||
        email == null ||
        member == null ||
        description == null ||
        designation == null) {
      return false;
    }
    return true;
  }

  getUserData() async {
    Map<String, String> councilInfo =
        await databaseMethods.getCouncilInfo(widget.uid);
    setState(() {
      name = councilInfo['displayName'];
      email = councilInfo['email'];
      photoUrl = councilInfo['photoUrl'];
      description = councilInfo['description'];
      member = councilInfo['members'];
      designation = councilInfo['designation'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GetAppBar(),
      body: !checkIfNull()
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new Container(
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
                                        ? AssetImage(
                                            'images/LoginPage/google.png')
                                        : NetworkImage(photoUrl))),
                                border: Border.all(
                                    color: Colors.black, width: 2.0)),
                          ),
                        ),
                        Container(
                          margin:
                              new EdgeInsets.fromLTRB(170.0, 55.0, 10.0, 10.0),
                          height: 150.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                designation,
                                style: TextStyle(fontSize: 14.0),
                              ),
                              Text(
                                email,
                                style: TextStyle(fontSize: 14.0),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: '$member :',
                                  style: TextStyle(fontSize: 15),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' VES ',
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: new EdgeInsets.fromLTRB(
                                350.0, 20.0, 10.0, 10.0),
                            child: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Details(designation: "Council")));
                              },
                            ))
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              new EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                          child: Text(
                            'Description:',
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100.0,
                          child: Container(
                            margin: new EdgeInsets.fromLTRB(7.0, 7.0, 7.0, 7.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  new EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                              child: Text(
                                description,
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ])
              ]),
            ),
    );
  }
}
