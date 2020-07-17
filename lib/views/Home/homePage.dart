import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:socail_network_flutter/Widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future getPosts() async {
    QuerySnapshot qn =
        await Firestore.instance.collection('posts').getDocuments();

    return qn.documents;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: GetAppBar(),
        body: Container(
      child: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading....'));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                    ),
                  );
                });
          }
        },
      ),
    ));
  }
}
