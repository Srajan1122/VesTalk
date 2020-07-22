import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';

import 'Widgets/CouncilEditProfileTopImage.dart';

class CouncilEditProfile extends StatefulWidget {
  const CouncilEditProfile({
    Key key,
    @required this.photoUrl,
    @required this.name,
    @required this.email,
    @required this.designation,
    @required this.member,
    @required this.description,
  }) : super(key: key);

  final String photoUrl;
  final String name;
  final String email;
  final String designation;
  final String member;
  final String description;

  @override
  _CouncilEditProfileState createState() => _CouncilEditProfileState();
}

class _CouncilEditProfileState extends State<CouncilEditProfile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController descController = new TextEditingController();
  TextEditingController memberController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

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
              child: title == 'Member'
                  ? TextField(
                      maxLengthEnforced: true,
                      controller: memberController,
                      keyboardType: TextInputType.number,
                    )
                  : title == 'Description'
                      ? TextField(
                          maxLengthEnforced: true,
                          controller: descController,
                          keyboardType: TextInputType.multiline,
                        )
                      : title == 'Name'
                          ? TextField(
                              maxLengthEnforced: true,
                              controller: nameController,
                              keyboardType: TextInputType.text,
                            )
                          : Container(),
            ),
          ],
        ),
      ],
    );
  }

  check() {
    if (descController.text.length == 0) return false;
    return true;
  }

  onSubmit() async {
    if (!check()) {
      Fluttertoast.showToast(msg: "Please enter all the fields correctly");
    } else {
      await databaseMethods.uploadCouncilInfo(Constants.uid,
          nameController.text, descController.text, memberController.text);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    descController..text = widget.description;
    memberController..text = widget.member;
    nameController..text = widget.name;
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
                  CouncilEditProfileTopImage(widget: widget),
                  customInputField('Name'),
                  customInputField('Member'),
                  customInputField('Description'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
