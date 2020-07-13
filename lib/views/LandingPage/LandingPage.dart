import 'package:flutter/material.dart';
import 'package:socail_network_flutter/Widgets/widgets.dart';
import 'package:socail_network_flutter/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:socail_network_flutter/views/Home/homePage.dart';
import 'package:socail_network_flutter/views/Profile/profile.dart';
import 'package:socail_network_flutter/views/Chat/chat.dart';
import 'package:socail_network_flutter/views/newPost/createPost.dart';
import 'dart:async';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    CreatePost(),
    Chat(),
    ProfilePage()
  ];
  bool isLoading = false;
  Future<Null> handleSignOut() async {
    setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: getAppBar(),
          body: _children[_currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.redAccent,
            buttonBackgroundColor: Colors.black87,
            backgroundColor: Colors.white,
            height: 60,
            items: <Widget>[
              Icon(Icons.home, size: 20, color: Colors.white),
              // Icon(Icons.search, size: 20, color: Colors.white),
              Icon(Icons.add, size: 20, color: Colors.white),
              Icon(Icons.chat, size: 20, color: Colors.white),
              Icon(Icons.person, size: 20, color: Colors.white),
            ],
            animationDuration: Duration(milliseconds: 200),
            animationCurve: Curves.bounceInOut,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('Devdatta Khoche'),
                  accountEmail: Text('something@gmail.com'),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        )),
                  ),
                  decoration: BoxDecoration(color: Colors.redAccent),
                ),
                ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.person_outline),
                ),
                ListTile(
                  title: Text('Sign Out'),
                  leading: Icon(Icons.arrow_left),
                  onTap: handleSignOut,
                )
              ],
            ),
          ),
        ));
  }
}
