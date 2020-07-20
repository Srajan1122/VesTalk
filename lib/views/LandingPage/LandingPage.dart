import 'package:flutter/material.dart';
import 'package:socail_network_flutter/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:socail_network_flutter/services/constant.dart';
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

  getUserId() async {
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            uid = value.getString('id');
          })
        });
  }

  getUserData() async {
    await getUserId();
    print("User id : $uid");
    await SharedPreferences.getInstance().then((value) => {
          this.setState(() {
            Constants.myName = (value.getString("displayName") ?? 'No name');
            Constants.email = (value.getString("email") ?? 'No email');
            Constants.photoUrl = (value.getString("photoUrl") ?? '');
            Constants.uid = (value.getString('id') ?? '');
          })
        });
  }

  listOfPage(index, id) {
    if (index == 0) {
      return HomePage();
    } else if (index == 1) {
      return SearchPage();
    } else if (index == 2) {
      return CreatePost();
    } else if (index == 3) {
      return Chat();
    } else if (index == 4) {
      return ProfilePage(uid: id);
    }
  }

  int _currentIndex = 0;
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Center(
            child: const Text.rich(
              TextSpan(
                text: 'Ves',
                style: TextStyle(fontSize: 30, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Talk',
                      style: TextStyle(color: Colors.lightBlue)),
                ],
              ),
            ),

          ),
        ),
          body: listOfPage(_currentIndex, uid),
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.lightBlue,
            buttonBackgroundColor: Colors.black87,
            backgroundColor: Colors.white,
            height: 50,
            items: <Widget>[
              Icon(Icons.home, size: 20, color: Colors.white),
              Icon(Icons.search, size: 20, color: Colors.white),
              Icon(Icons.add, size: 20, color: Colors.white),
              Icon(Icons.chat, size: 20, color: Colors.white),
              Icon(Icons.person, size: 20, color: Colors.white),
            ],
            animationDuration: Duration(milliseconds: 200),
            animationCurve: Curves.bounceInOut,
            onTap: (index) async {
              if (uid == null) {
                await getUserId();
              }
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(Constants.myName),
                  accountEmail: Text(Constants.email),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(Constants.photoUrl),
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.lightBlue),
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
