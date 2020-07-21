import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Profile/DesignationProfilePage/Widgets/TeacherEditProfileTopImage.dart';

class TeacherEditProfile extends StatefulWidget {
  const TeacherEditProfile({
    Key key,
    @required this.photoUrl,
    @required this.name,
    @required this.email,
    @required this.designation,
    @required this.branch,
    @required this.post,
  }) : super(key: key);

  final String photoUrl;
  final String name;
  final String email;
  final String designation;
  final String branch;
  final String post;

  @override
  _TeacherEditProfileState createState() => _TeacherEditProfileState();
}

class _TeacherEditProfileState extends State<TeacherEditProfile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController postController = new TextEditingController();
  String newBranch, newPost;
  List<String> listOfBranch = ['INFT', 'ETRX', 'MCA', 'CS'];

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
                  if (title == 'Branch') newBranch = newValue;
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
                maxLengthEnforced: true,
                controller: postController,
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
      ],
    );
  }

  check() {
    if (postController.text.length == 0) return false;
    return true;
  }

  onSubmit() async {
    if (!check()) {
      Fluttertoast.showToast(msg: "Please enter all the fields correctly");
    } else {
      await databaseMethods.updateTeacherInfo(
          Constants.uid, postController.text, newBranch);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    newBranch = widget.branch;
    postController..text = widget.post;
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
                  TeacherEditProfileTopImage(widget: widget),
                  customDropDown(
                      'Branch', 'Select Branch', newBranch, listOfBranch),
                  customInputField('Post'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
