import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DesignationProfilePage/Student.dart';
import 'DesignationProfilePage/Teacher.dart';
import 'DesignationProfilePage/Council.dart';
class ProfilePage extends StatefulWidget {
  final String designation;
  ProfilePage({@required this.designation});
  @override
  _ProfilePagestate createState() => _ProfilePagestate();
}

class _ProfilePagestate extends State<ProfilePage> {
  handleFields(desig) {
    switch (desig) {
      case 'Student':
        {
          return StudentProfile();
        }
      case 'Teacher':
        {
          return TeacherProfile();
        }
      case 'Council':
        {
          return CouncilProfile();
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
        body: handleFields(widget.designation),
      ),
    );
  }
}
