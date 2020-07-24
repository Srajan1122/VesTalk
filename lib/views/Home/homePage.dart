import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Home/widgets/widgetsHome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseMethods _databaseMethods = DatabaseMethods();
  Future<void> _refresh() async {
    if (!mounted) return;
    setState(() {
      print('hi i got refreshed');
      Constants.data = _databaseMethods.getPosts();
    });
  }

  @override
  void initState() {
    super.initState();
    if (Constants.data == null) {
      Constants.data = _databaseMethods.getPosts();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage('images/SignOut/applogo.png'),
                  ),
                  SizedBox(width: 5,),
                  Text.rich(
                    TextSpan(
                      text: 'Ves',
                      style: TextStyle(fontSize: 30, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Talk', style: TextStyle(color: Colors.lightBlue)),
                      ],
                    ),
                  ),
                ],
              ),

              GestureDetector(
                child:Row(
                  children: <Widget>[
                    Text('SIGN OUT',style: TextStyle(color: Colors.red,fontSize: 12),),
                    Container(
                      height: 30,
                      width: 30,
                      child: Image.asset('images/SignOut/logout.png',),
                    )
                  ],
                )

              ),

            ],
          )
//          Center(
//            child: Text.rich(
//              TextSpan(
//                text: 'Ves',
//                style: TextStyle(fontSize: 30, color: Colors.black),
//                children: <TextSpan>[
//                  TextSpan(
//                      text: 'Talk', style: TextStyle(color: Colors.lightBlue)),
//                ],
//              ),
//            ),
//          ),
        ),
        body: Container(
          child: buildRefreshIndicator(context),
        ));
  }

  RefreshIndicator buildRefreshIndicator(BuildContext context) {
    return RefreshIndicator(
      child: buildFutureBuilder(context),
      onRefresh: _refresh,
    );
  }

  FutureBuilder buildFutureBuilder(BuildContext context) {
    return FutureBuilder(
      future: Constants.data,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 50),
            ],
          ));
        } else if (snapshot.hasData) {
          return listbuidler(context, snapshot, _refresh);
        }
        // else if (snapshot.data.length == 0) {
        // return Center(child: Text('No Posts Available'));}
        else {
          return Center(child: Text('No Posts Available'));
        }
      },
    );
  }
}
