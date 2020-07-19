import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';
import 'package:flutter/services.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/designation.dart';

class Council extends StatefulWidget {
  @override
  _CouncilState createState() => _CouncilState();
}

class _CouncilState extends State<Council> {
  String id, displayName, description, members;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
      this.setState(() {
        id = value.getString('id');
      })
    });
  }

  bool checkValidation() {
    if (members == null || displayName == null || description == null) {
      _showDialog();
      Fluttertoast.showToast(msg: "Please enter all the fields");
      return false;
    } else {
      return true;
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Warning !", textAlign: TextAlign.center,),
          content: new Text("Please enter all the fields"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close", style: TextStyle(color: Color(0xFFFC2542)),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  onSubmit(context) async {
    if(!checkValidation()){
      print('not good');
    }
    else{
      print('good to go');
      await getUserId();
      databaseMethods.uploadCouncilInfo(id, displayName, description, members);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          LandingPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ProfileComp/OnBoarding.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            width: 450,
            height: 800,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Center(
                    child: Text('Council Details', style: TextStyle(fontSize: 30),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Display name',
                      ),
                      onChanged: (value) {
                        setState(() {
                          displayName = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'No. of Members',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          members = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      maxLines: 9,
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        floatingActionButton: Stack(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left:31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  heroTag: "btn1",
                  onPressed: () async{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Designation(),
                      ),
                    );
                  },
                  child: FaIcon(FontAwesomeIcons.arrowLeft),
                  backgroundColor: Colors.lightBlue,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  onSubmit(context);
                },
                child: FaIcon(FontAwesomeIcons.arrowRight),
                backgroundColor: Colors.lightBlue,
              ),
            ),
          ],
        )
    );
  }
}
