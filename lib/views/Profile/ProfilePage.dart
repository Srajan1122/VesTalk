import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DesignationProfilePage/Student.dart';
import 'DesignationProfilePage/Teacher.dart';
import 'DesignationProfilePage/Council.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  ProfilePage({@required this.uid});
  @override
  _ProfilePagestate createState() => _ProfilePagestate();
}

class _ProfilePagestate extends State<ProfilePage> {
  String designation = "Student";
  // TODO : Get user designation by uid from firestore
  // Assign the value to designation
  // Access UID by widget.uid

  handleFields(desig) {
    switch (desig) {
      case 'Student':
        {
          return StudentProfile(uid: widget.uid);
        }
      case 'Teacher':
        {
          return TeacherProfile(uid: widget.uid);
        }
      case 'Council':
        {
          return CouncilProfile(uid: widget.uid);
        }
        break;
      default:
        {
          return Text('Something went wrong');
        }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: handleFields(designation),
      ),
    );
  }
}
