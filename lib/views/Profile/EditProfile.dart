import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Profile/ProfilePage.dart';

import 'DesignationProfilePage/Widgets/EditProfileTopImage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key key,
    @required this.photoUrl,
    @required this.name,
    @required this.email,
    @required this.designation,
    @required this.branch,
    @required this.year,
    @required this.phoneNumber,
    @required this.batch,
  }) : super(key: key);

  final String photoUrl;
  final String name;
  final String email;
  final String designation;
  final String branch;
  final String batch;
  final String year;
  final String phoneNumber;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController phoneController = new TextEditingController();
  String newBranch, newYear, newBatch, newPhone;
  List<String> listOfBranch = ['INFT', 'ETRX', 'MCA', 'CS'];
  List<String> listOfYear = ['1st Year', '2nd Year', '3rd Year', '4th Year'];
  List<String> listOfBatch = ['D10', 'D5', 'D15', 'D20'];

  Widget customDropDown(title, hint, variable, list) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title.padRight(15),
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: 20.0,
            ),
            DropdownButton<String>(
              hint: Text(hint.padRight(25)),
              icon: Icon(Icons.arrow_downward),
              value: variable,
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 1,
                color: Colors.lightBlue,
              ),
              onChanged: (String newValue) {
                setState(() {
                  if (title == 'Branch')
                    newBranch = newValue;
                  else if (title == 'Year')
                    newYear = newValue;
                  else if (title == 'Batch') newBatch = newValue;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget customInputField(title) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 40.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title.padRight(15),
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w300),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: TextField(
                maxLength: 10,
                maxLengthEnforced: true,
                controller: phoneController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  check() {
    if (phoneController.text.length != 10) return false;
    return true;
  }

  onSubmit() async {
    if (!check()) {
      Fluttertoast.showToast(msg: "Please enter all the fields correctly");
    } else {
      await databaseMethods.updateStudentInfo(
          Constants.uid, phoneController.text, newBranch, newBatch, newYear);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    newBranch = widget.branch;
    newYear = widget.year;
    newBatch = widget.batch;
    newPhone = widget.phoneNumber;
    phoneController..text = newPhone;
  }

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Edit Profile',
            style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.black,
              ),
              onPressed: onSubmit,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  EditProfileTopImage(widget: widget),
                  customDropDown('Year', 'Select Year', newYear, listOfYear),
                  customDropDown(
                      'Branch', 'Select Branch', newBranch, listOfBranch),
                  customDropDown(
                      'Batch', 'Select Batch', newBatch, listOfBatch),
                  customInputField('Phone Number'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
