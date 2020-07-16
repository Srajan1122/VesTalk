import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/designation.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pages = [
    PageViewModel(
      pageColor: Colors.white,
        // iconImageAssetPath: 'images/LoginPage/Login.png',
        body: Text(
          'A place where each student is connected with each teacher irrespective of their branch',
        ),
        title: Text.rich(
          TextSpan(
            text: 'Welcome To Ves',
            style: TextStyle(fontSize: 30),
            children: <TextSpan> [
              TextSpan(
                text: 'Talk',
                style: TextStyle(color: Color(0xffFC2542))
              ),
            ],
          ),
        ),
        titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Color(0xFF000050)),
        bodyTextStyle: TextStyle(fontFamily: 'MyFont', color: Color(0xFF000050)),
        mainImage: Image.asset(
          'images/ProfileComp/connect.png',
          height: 300,
          width: 300,
          alignment: Alignment.center,
        ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          doneText: FloatingActionButton(
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
          showNextButton: true,
          showBackButton: false,
          showSkipButton: false,
//          onTapDoneButton: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => Designation(),
//              ), //MaterialPageRoute
//            );
//          },
          pageButtonTextStyles: TextStyle(
            color: Color(0xFf000050),
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ),
    );
  }
}
