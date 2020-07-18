import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/designation.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ProfileComp/OnBoarding.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            width: 450,
            height: 800,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 80),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Welcome To Ves',
                        style: TextStyle(fontSize: 30),
                        children: <TextSpan> [
                          TextSpan(
                              text: 'Talk',
                              style: TextStyle(color: Colors.lightBlue)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                  child: Center(
                    child: Container(
                      width: 350,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/ProfileComp/connect.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 90, 40, 0),
                  child: Center(
                    child: Text('A place where each student is connected with each teacher irrespective of their branch.', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Designation(),
              ),
            );
          },
          child: FaIcon(FontAwesomeIcons.arrowRight),
          backgroundColor: Colors.lightBlue,
      ),
    );
  }
}


