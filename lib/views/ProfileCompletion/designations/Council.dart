import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';

class Council extends StatefulWidget {
  @override
  _CouncilState createState() => _CouncilState();
}

class _CouncilState extends State<Council> {
  String display_name, description, members;
  bool checkValidation() {
    if (members == null || display_name == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
            child: Center(
              child: Text('Council Details'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Display name',
                ),
                onChanged: (value) {
                  setState(() {
                    display_name = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'No. of Members',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    members = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                maxLines: 9,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (checkValidation()) {
            print('good to go');
            print(display_name + ' ' + members + '\n' + description);

            // TODO : Add Council function for Firebase

            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LandingPage()));
          } else {
            print('not good');
          }
        },
        child: FaIcon(FontAwesomeIcons.arrowRight),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
