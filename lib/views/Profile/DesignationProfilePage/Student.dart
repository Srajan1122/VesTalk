import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'Widgets/StudentProfileUi.dart';

class StudentProfile extends StatefulWidget {
  final String uid;

  StudentProfile({@required this.uid});

  @override
  _StudentProfilePage createState() => _StudentProfilePage();
}

class _StudentProfilePage extends State<StudentProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String name, photoUrl, designation, branch, year, email, phoneNumber;

  checkIfNull() {
    if (name == null ||
        photoUrl == null ||
        email == null ||
        designation == null ||
        branch == null ||
        phoneNumber == null ||
        year == null) {
      return false;
    }
    return true;
  }

  getUserData() async {
    Map<String, String> studentInfo =
        await databaseMethods.getStudentInfo(widget.uid);
    if (!mounted) return;
    setState(() {
      name = studentInfo['name'];
      email = studentInfo['email'];
      photoUrl = studentInfo['photoUrl'];
      designation = studentInfo['designation'];
      branch = studentInfo['branch'];
      year = studentInfo['year'];
      email = studentInfo['email'];
      phoneNumber = studentInfo['phoneNumber'];
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
      body: !checkIfNull()
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StudentProfileUi(
              photoUrl: photoUrl,
              name: name,
              email: email,
              designation: designation,
              branch: branch,
              year: year,
              phoneNumber: phoneNumber),
    );
  }
}
