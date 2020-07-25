import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';
import 'package:socail_network_flutter/views/Onboarding/onBoarding.dart';
import 'package:socail_network_flutter/views/SignIn/SignIn.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  bool isLoading = false;
  bool isLoggedIn = false;
  SharedPreferences prefs;
  String id;


  check() async {
    await getUserId();
    return await databaseMethods.checkIfInitialDataIsFilled(id);
  }

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
      if (mounted)
        {
          this.setState(() {
            id = value.getString('id');
          })
        }
    });
  }

  void isSignIn() async {
    setState(() {
      isLoading = true;
    });
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = await _googleSignIn.isSignedIn();
    if (isLoggedIn && await check()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    } else if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBoarding()));
    }
    else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      )),
    );
  }
}
