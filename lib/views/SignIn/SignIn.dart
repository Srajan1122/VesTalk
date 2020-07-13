import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socail_network_flutter/views/LandingPage/LandingPage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      final QuerySnapshot result = await Firestore.instance
          .collection('user')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();

      List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        Firestore.instance
            .collection('user')
            .document(firebaseUser.uid)
            .setData({
          'id': firebaseUser.uid,
          'displayName': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl
        });

        // Local Data

        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('displayName', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoUrl);
      } else {
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('id', documents[0]['displayName']);
        await prefs.setString('id', documents[0]['phototUrl']);
      }
      Fluttertoast.showToast(msg: "Sign In success");
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LandingPage()));
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
                image: AssetImage('images/LoginPage/Login.png'), fit: BoxFit.cover),
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
