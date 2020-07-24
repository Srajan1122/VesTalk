import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Home/widgets/widgetsHome.dart';
import 'Widgets/CouncilProfileUi.dart';

class CouncilProfile extends StatefulWidget {
  final String uid;

  CouncilProfile({@required this.uid});

  @override
  _CouncilProfilePage createState() => _CouncilProfilePage();
}

class _CouncilProfilePage extends State<CouncilProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String name, photoUrl, email, member, description, designation, uid;

  checkIfNull() {
    if (name == null ||
        photoUrl == null ||
        email == null ||
        member == null ||
        description == null ||
        designation == null ||
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
    Map<String, String> councilInfo =
        await databaseMethods.getCouncilInfo(widget.uid);
    if (!mounted) return;
    setState(() {
      name = councilInfo['displayName'];
      email = councilInfo['email'];
      photoUrl = councilInfo['photoUrl'];
      description = councilInfo['description'];
      member = councilInfo['members'];
      designation = councilInfo['designation'];
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
                        return CouncilProfileUi(
                          photoUrl: photoUrl,
                          name: name,
                          designation: designation,
                          email: email,
                          member: member,
                          description: description,
                          uid: uid,
                            refreshAction: (){
                              _refresh();
                            }
                        );
                      return buildPost(context, snapshot, index-1, _refresh);
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