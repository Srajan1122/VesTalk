import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'Widgets/CouncilProfileUi.dart';

class CouncilProfile extends StatefulWidget {
  final String uid;

  CouncilProfile({@required this.uid});

  @override
  _CouncilProfilePage createState() => _CouncilProfilePage();
}

class _CouncilProfilePage extends State<CouncilProfile> {
  static DatabaseMethods databaseMethods = new DatabaseMethods();
  String name, photoUrl, email, member, description, designation;

  checkIfNull() {
    if (name == null ||
        photoUrl == null ||
        email == null ||
        member == null ||
        description == null ||
        designation == null) {
      return false;
    }
    return true;
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
          : CouncilProfileUi(
              photoUrl: photoUrl,
              name: name,
              designation: designation,
              email: email,
              member: member,
              description: description),
    );
  }
}
