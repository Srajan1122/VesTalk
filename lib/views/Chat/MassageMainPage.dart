import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/Widgets/widgets.dart';

class MassagePage extends StatefulWidget {
  @override
  _MasagepageState createState() => _MasagepageState();
}

class _MasagepageState extends State<MassagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getChatAppBar(context),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16,bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.add,color: Colors.white,size: 21,),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        hintText: "Type message...",
                        border: InputBorder.none
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 30,bottom: 50),
              child: FloatingActionButton(
                onPressed: (){},
                child: Icon(Icons.send,color: Colors.white,),
                backgroundColor: Colors.pink,
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
