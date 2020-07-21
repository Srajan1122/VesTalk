import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Profile/DesignationProfilePage/TeacherEditProfile.dart';

class TeacherEditProfileTopImage extends StatelessWidget {
  const TeacherEditProfileTopImage({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final TeacherEditProfile widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(widget.photoUrl),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Text(
                  widget.name,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
