import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/designation.dart';

class Teacher extends StatefulWidget {
  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  String id, post, branch;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            id = value.getString('id');
          })
        });
  }

  bool checkValidation() {
    if (branch == null || post == null) {
      _showDialog();
      Fluttertoast.showToast(msg: "Please enter all the fields");
      return false;
    }
    return true;
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
    if (!checkValidation()) {
      print('not good');
    } else {
      print('good to go');
      await getUserId();
      databaseMethods.uploadTeacherInfo(id, post, branch);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LandingPage()));
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
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                  child: Center(
                    child: Text(
                      'Teacher Details',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DropdownButton<String>(
                    hint: Text('Select Branch          '),
                    icon: Icon(Icons.arrow_downward),
                    value: branch,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.lightBlue,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        branch = newValue;
                      });
                    },
                    items: <String>['INFT', 'ETRX', 'MCA', 'CS', 'None']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Center(
                    child: Text(
                      'Designation : ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Container(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Eg: Assistant Professor',
                      ),
                      onChanged: (value) {
                        setState(() {
                          post = value;
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
