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
            image: AssetImage('images/ProfileComp/Profile.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            width: 350,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 30),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'Welcome To Ves',
                        style: TextStyle(fontSize: 25),
                        children: <TextSpan> [
                          TextSpan(
                              text: 'Talk',
                              style: TextStyle(color: Color(0xffFC2542))
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
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
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
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
          backgroundColor: Color(0xFF000050)
      ),
    );
  }
}


