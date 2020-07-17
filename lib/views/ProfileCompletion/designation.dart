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
    }else{
      return true;
    }
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
    print(id);
    print(dropdownValue);
    if(!checkValidation()){
      print('not good');
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
            image: AssetImage('images/ProfileComp/Profile.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Center(
                      child: Text('Please select your role :', style: TextStyle(fontSize: 20.0,),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: DropdownButton<String>(
                      hint: Text('Select Designation         '),
                      icon: Icon(Icons.arrow_downward, color: Color(0xFF000050),),
                      value: dropdownValue,
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Color(0xFFFC2542),
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
                ],
              ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            onSubmit(context);
          },
          child: FaIcon(FontAwesomeIcons.arrowRight),
          backgroundColor: Color(0xFF000050)
      ),
    );

  }
}
