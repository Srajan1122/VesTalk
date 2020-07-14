import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';
import 'package:socail_network_flutter/views/ProfileCompletion/designation.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  bool isLoading = false;
  bool isLoggedIn = false;
  SharedPreferences prefs;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    isSignIn();
  }

  void isSignIn() async {
    setState(() {
      isLoading = true;
    });
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = await _googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<FirebaseUser> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      List<DocumentSnapshot> documents = await databaseMethods.findUserById(firebaseUser.uid);
      if (documents.length == 0) {
        await databaseMethods.uploadUserData( firebaseUser.uid, firebaseUser.displayName, firebaseUser.photoUrl, firebaseUser.email);

        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('displayName', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
        await prefs.setString('email', currentUser.email);
      } else {
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('displayName', documents[0]['displayName']);
        await prefs.setString('photoUrl', documents[0]['phototUrl']);
        await prefs.setString('email', documents[0]['email']);
      }
      Fluttertoast.showToast(msg: "Sign In success");
      setState(() {
        isLoading = false;
      });
      // TODO : Check Condition if user has filled the profile before : checkProfile()

      // if(!checkProfile){
      //   Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LandingPage()));
      // }
      // else{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Designation()));
      // }

    } else {
      Fluttertoast.showToast(msg: "Sign In Failed");
      setState(() {
        isLoading = false;
      });
    }
    return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/LoginPage/Login.png'),
                fit: BoxFit.cover),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Welcome!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Nice to see you!',
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: RaisedButton.icon(
                    onPressed: handleSignIn,
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text('Sign in with Google'),
                    color: Colors.redAccent,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text.rich(
                          TextSpan(
                            text: 'Login with',
                            style: TextStyle(fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' VES ',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: "ID's only", style: TextStyle()),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
