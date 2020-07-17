import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';
import 'package:socail_network_flutter/views/Onboarding/onBoarding.dart';

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
  String id;

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            id = value.getString('id');
          })
        });
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
    GoogleSignInAccount googleUser;
    GoogleSignInAuthentication googleAuth;
    AuthCredential credential;
    FirebaseUser firebaseUser;

    try {
      googleUser = await _googleSignIn.signIn();
      googleAuth = await googleUser.authentication;
      credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;
    } catch (e) {
      print('This is error in google');
    }

    if (firebaseUser != null) {
      try {
        List<DocumentSnapshot> documents =
            await databaseMethods.findUserById(firebaseUser.uid);
        if (documents.length == 0) {
          await databaseMethods.uploadUserData(
              firebaseUser.uid,
              firebaseUser.displayName,
              firebaseUser.photoUrl,
              firebaseUser.email);

          currentUser = firebaseUser;
          await prefs.setString('id', currentUser.uid);
          await prefs.setString('displayName', currentUser.displayName);
          await prefs.setString('email', currentUser.email);
          await prefs.setString('photoUrl', currentUser.photoUrl);
        } else {
          await prefs.setString('id', documents[0]['id']);
          await prefs.setString('displayName', documents[0]['displayName']);
          await prefs.setString('email', documents[0]['email']);
          await prefs.setString('photoUrl', documents[0]['photoUrl']);
        }
      } on PlatformException catch (e) {
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        user.delete();
        firebaseAuth.signOut();
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();

        Fluttertoast.showToast(msg: "Sign in only with VES ID");
        return firebaseUser;
      } catch (e) {
        Fluttertoast.showToast(msg: "Something went wrong try again later");
      }
      Fluttertoast.showToast(msg: "Sign In success");
      setState(() {
        isLoading = false;
      });

      check() async {
        await getUserId();
        return await databaseMethods.checkIfInitialDataIsFilled(id);
      }

      if (await check()) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OnBoarding()));
      }
    } else {
      Fluttertoast.showToast(msg: "Sign In Failed");
      setState(() {
        isLoading = false;
      });
    }
    return firebaseUser;
  }

  @override
  void initState() {
    super.initState();
    isSignIn();
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
                    onPressed: () {
                      try {
                        handleSignIn();
                      } catch (e) {
                        print('handle sign in error');
                      }
                    },
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
