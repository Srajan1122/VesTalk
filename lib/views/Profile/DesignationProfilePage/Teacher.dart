import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Home/widgets/widgetsHome.dart';
import 'Widgets/TeacherProfileUi.dart';

class TeacherProfile extends StatefulWidget {
  final String uid;

  TeacherProfile({@required this.uid});

  @override
  _TeacherProfilePage createState() => _TeacherProfilePage();
}

class _TeacherProfilePage extends State<TeacherProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String post, name, photoUrl, email, designation, branch, uid;

  checkIfNull() {
    if (name == null ||
        photoUrl == null ||
        email == null ||
        designation == null ||
        branch == null ||
        post == null ||
        uid == null) {
      return false;
    }
    return true;
  }

  Future<void> _refresh() async {
    if (!mounted) return;
    setState(() {
      getUserData();
      Constants.userPost = databaseMethods.getPostsById(widget.uid);
    });
  }

  getUserData() async {
    Map<String, String> teacherInfo =
        await databaseMethods.getTeacherInfo(widget.uid);
    if (!mounted) return;
    setState(() {
      name = teacherInfo['name'];
      email = teacherInfo['email'];
      photoUrl = teacherInfo['photoUrl'];
      designation = teacherInfo['designation'];
      post = teacherInfo['post'];
      branch = teacherInfo['branch'];
      uid = widget.uid;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    if (Constants.userPost == null || widget.uid != Constants.uid) {
      print('It is refreshing');
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
                        return TeacherProfileUi(
                          photoUrl: photoUrl,
                          name: name,
                          designation: designation,
                          branch: branch,
                          email: email,
                          post: post,
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