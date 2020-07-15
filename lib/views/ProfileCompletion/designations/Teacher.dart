import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';

class Teacher extends StatefulWidget {
  @override
  _TeacherState createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  String post;
  String branch;
  bool checkValidation() {
    if (branch == null || post == null) {
      return false;
    }

    return true;
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
          if (checkValidation()) {
            print('good to go');

            // TODO : Add Teacher function for student data

            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => LandingPage()));
          } else {
            print('not good');
          }
        },
        child: FaIcon(FontAwesomeIcons.arrowRight),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
