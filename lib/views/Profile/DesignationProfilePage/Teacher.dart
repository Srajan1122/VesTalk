import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'Widgets/TeacherProfileUi.dart';

class TeacherProfile extends StatefulWidget {
  final String uid;

  TeacherProfile({@required this.uid});

  @override
  _TeacherProfilePage createState() => _TeacherProfilePage();
}

class _TeacherProfilePage extends State<TeacherProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String post, name, photoUrl, email, designation, branch;

  checkIfNull() {
    if (name == null ||
        photoUrl == null ||
        email == null ||
        designation == null ||
        branch == null ||
        post == null) {
      return false;
    }
    return true;
  }

  getUserData() async {
    Map<String, String> teacherInfo =
        await databaseMethods.getTeacherInfo(widget.uid);
    if(!mounted) return;
    setState(() {
      name = teacherInfo['name'];
      email = teacherInfo['email'];
      photoUrl = teacherInfo['photoUrl'];
      designation = teacherInfo['designation'];
      post = teacherInfo['post'];
      branch = teacherInfo['branch'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GetAppBar(),
      body: !checkIfNull()
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TeacherProfileUi(photoUrl: photoUrl, name: name, designation: designation, branch: branch, email: email, post: post),
    );
  }
}
