import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  String phoneNumber, branch, batch, year;

  bool checkValidation() {
    if (phoneNumber.length != 10) {
      // TODO : show alert
      return false;
    }
    if (branch == null || batch == null || year == null) {
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
              child: Text('Student Details'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Phone number',
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
              hint: Text('Select Year'),
              icon: Icon(Icons.arrow_downward),
              value: year,
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  year = newValue;
                });
              },
              items: <String>['1st Year', '2nd Year', '3rd Year', '4th Year']
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
              hint: Text('Select Divison'),
              icon: Icon(Icons.arrow_downward),
              value: batch,
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (checkValidation()) {
            print('good to go');

            // TODO : Add firebase function for student data

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
