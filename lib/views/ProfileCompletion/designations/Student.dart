import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  String id, phoneNumber, branch, batch, year;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            id = value.getString('id');
          })
        });
  }

  bool checkValidation() {
    if (phoneNumber == null) {
      _showDialog();
      Fluttertoast.showToast(msg: "Please enter all the fields");
    }
    if (phoneNumber.length != 10) {
      _validNumber();
      Fluttertoast.showToast(msg: "Please enter a valid number");
      return false;
    }
    if (branch == null || batch == null || year == null) {
      _showDialog();
      Fluttertoast.showToast(msg: "Please enter all the fields");
      return false;
    }

    return true;
  }

  void _validNumber() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Warning !", textAlign: TextAlign.center,),
          content: new Text("Please enter a valid number"),
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
      databaseMethods.uploadStudentInfo(id, phoneNumber, branch, batch, year);
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
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 40),
                  child: Center(
                    child: Text(
                      'Student Details :',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DropdownButton<String>(
                    hint: Text('Select Branch       '),
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
                    items: <String>['INFT', 'ETRX', 'MCA', 'CS']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DropdownButton<String>(
                    hint: Text('Select Year        '),
                    icon: Icon(Icons.arrow_downward),
                    value: year,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.lightBlue,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        year = newValue;
                      });
                    },
                    items: <String>[
                      '1st Year',
                      '2nd Year',
                      '3rd Year',
                      '4th Year'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DropdownButton<String>(
                    hint: Text('Select Divison    '),
                    icon: Icon(Icons.arrow_downward),
                    value: batch,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                      color: Colors.lightBlue,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        batch = newValue;
                      });
                    },
                    items: <String>['D10', 'D5', 'D15', 'D20']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Container(
                    width: 210,
                    height: 70,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Your Phone Number',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 5, 40, 40),
                  child: Center(
                    child: Text(
                      'Note: After you pass out, you can change your designation to Alumni',
                      style: TextStyle(fontSize: 10, color: Color(0xFFFC2542)),
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
                    Navigator.pop(context);
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => Designation(),
//                      ),
//                    );
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
