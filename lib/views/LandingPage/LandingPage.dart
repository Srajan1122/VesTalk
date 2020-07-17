import 'package:flutter/material.dart';
import 'package:socail_network_flutter/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:socail_network_flutter/views/Home/homePage.dart';
import 'package:socail_network_flutter/views/Profile/ProfilePage.dart';
import 'package:socail_network_flutter/views/Chat/chat.dart';
import 'package:socail_network_flutter/views/newPost/createPost.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/views/Search/Search.dart';
import 'dart:async';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static String uid;
  String name = 'No name', email = 'No email', photoUrl = 'http://noPhoto';

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            uid = value.getString('id');
          })
        });
  }

  getUserData() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            name = (value.getString("displayName") ?? 'No name');
            email = (value.getString("email") ?? 'No email');
            photoUrl = (value.getString("photoUrl") ?? '');
          })
        });
  }

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    SearchPage(),
    CreatePost(),
    Chat(),
    ProfilePage(uid: uid)
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
  void initState() {
    super.initState();

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
//          appBar: getAppBar(),
          body: _children[_currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            color: Color(0xFF000050),
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            height: 60,
            items: <Widget>[
              Icon(Icons.home, size: 30, color: Color(0xFFFC2542)),
              Icon(Icons.search, size: 30, color: Color(0xFFFC2542)),
              Icon(Icons.add, size: 30, color: Color(0xFFFC2542)),
              Icon(Icons.chat, size: 30, color: Color(0xFFFC2542)),
              Icon(Icons.person, size: 30, color: Color(0xFFFC2542)),
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
                  accountName: Text(name),
                  accountEmail: Text(email),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(photoUrl),
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF000050)),
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
