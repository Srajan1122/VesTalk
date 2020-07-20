import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Designation extends StatefulWidget {
  @override
  _DesignationState createState() => _DesignationState();
}

class _DesignationState extends State<Designation> {
  String dropdownValue, id;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
      this.setState(() {
        id = value.getString('id');
      })
    });
  }

  bool checkValidation() {
    if (dropdownValue == null) {
      _showDialog();
      Fluttertoast.showToast(msg: "Please enter the fields" );
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
          content: new Text("Please enter your role."),
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
    await getUserId();
    databaseMethods.uploadUserDesignation(id, dropdownValue);
    if(!checkValidation()){
      print('not good');
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Details(designation: dropdownValue)));
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
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Please select a ',
                          style: TextStyle(fontSize: 30),
                          children: <TextSpan> [
                            TextSpan(
                                text: 'Role',
                                style: TextStyle(color: Colors.lightBlue)
                            ),
                            TextSpan(
                              text: " :",
                                style: TextStyle(color: Colors.black)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: Center(
                      child: Container(
                        width: 250,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/ProfileComp/role.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 90, 40, 0),
                    child: DropdownButton<String>(
                      hint: Text('Select Designation         '),
                      icon: Icon(Icons.arrow_downward, color: Colors.black87),
                      value: dropdownValue,
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.lightBlue,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Student', 'Teacher', 'Council', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 40),
                    child: Center(
                      child: Text(
                        'Note: You cannot change your role later',
                        style: TextStyle(fontSize: 11, color: Color(0xFFFC2542)),
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
//                        builder: (context) => OnBoarding(),
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
