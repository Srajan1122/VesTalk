import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Home/widgets/widgetsHome.dart';
import 'Widgets/StudentProfileUi.dart';

class StudentProfile extends StatefulWidget {
  final String uid;

  StudentProfile({@required this.uid});

  @override
  _StudentProfilePage createState() => _StudentProfilePage();
}

class _StudentProfilePage extends State<StudentProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String name,
      photoUrl,
      designation,
      branch,
      year,
      email,
      phoneNumber,
      batch,
      uid;

  Future<void> _refresh() async {
    if (!mounted) return;
    setState(() {
      getUserData();
      Constants.userPost = databaseMethods.getPostsById(widget.uid);
    });
  }

  checkIfNull() {
    if (name == null ||
        photoUrl == null ||
        email == null ||
        designation == null ||
        branch == null ||
        phoneNumber == null ||
        year == null ||
        batch == null ||
        uid == null) {
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
      batch = studentInfo['batch'];
      uid = widget.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    if (Constants.userPost == null || uid != Constants.uid) {
      Constants.userPost = databaseMethods.getPostsById(widget.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Container(
          child: !checkIfNull()
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : FutureBuilder(
                  future: Constants.userPost,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text('Loading....'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length + 1,
                          itemBuilder: (_, index) {
                            if (index == 0)
                              return StudentProfileUi(
                                photoUrl: photoUrl,
                                name: name,
                                email: email,
                                designation: designation,
                                branch: branch,
                                year: year,
                                phoneNumber: phoneNumber,
                                batch: batch,
                                uid: uid,
                              );
                            return buildPost(context, snapshot, index-1);
                          });
                    } else {
                      return Center(child: Text('No Posts Available'));
                    }
                  },
                )),
      onRefresh: _refresh,
    );
  }
}
