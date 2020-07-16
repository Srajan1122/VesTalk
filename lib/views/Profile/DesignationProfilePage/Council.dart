import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:socail_network_flutter/Widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/details.dart';

class CouncilProfile extends StatefulWidget {
  final String uid;
  CouncilProfile({@required this.uid});
  @override
  _CouncilProfilePage createState() => _CouncilProfilePage();
}

class _CouncilProfilePage extends State<CouncilProfile> {
  String name, email, photoUrl, members, desc;
  // setState for there variables

  getUserData() async {
    //TODO : Get user data from uid  and setState for there values , not necessary to use shared prefs
    // Access uid as uid
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
    getUserData();
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
                        Text(
                          'Council',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          email,
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Number of Members : ',
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
                      margin: new EdgeInsets.fromLTRB(350.0, 20.0, 10.0, 10.0),
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
                    padding: new EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
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
                        padding: new EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                        child: Text(
                          'Hello everyone I am intrested in AI and ML please contact me for startup',
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
