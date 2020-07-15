import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';

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
      return false;
    }
    return true;
  }

  onSubmit(context) async {
    if(!checkValidation()){
      print('not good');
    }
    else{
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
            child: Center(
              child: Text('Teacher Details'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Please specify your post!!',
                ),
                onChanged: (value) {
                  setState(() {
                    post = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: DropdownButton<String>(
              hint: Text('Select Branch'),
              icon: Icon(Icons.arrow_downward),
              value: branch,
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            onSubmit(context);
        },
        child: FaIcon(FontAwesomeIcons.arrowRight),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
