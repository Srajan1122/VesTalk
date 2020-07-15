import 'package:flutter/material.dart';
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

  onSubmit(context) async {
    await getUserId();
    databaseMethods.uploadUserDesignation(id, dropdownValue);
    print(id);
    print(dropdownValue);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Details(designation: dropdownValue)));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: DropdownButton<String>(
            hint: Text('Select Designation'),
            icon: Icon(Icons.arrow_downward),
            value: dropdownValue,
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.blueAccent,
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
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
             onSubmit(context);
          },
          child: FaIcon(FontAwesomeIcons.arrowRight),
          backgroundColor: Colors.redAccent),
    );
  }
}
