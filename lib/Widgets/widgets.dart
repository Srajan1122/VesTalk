

import 'package:flutter/material.dart';

Widget getAppBar() {
  return AppBar(
    backgroundColor: Colors.redAccent,
    title: Text('Appbar'),
  );
}

Widget getChatAppBar(context){
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.redAccent,

    flexibleSpace: SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
        child: Row(
          children: <Widget>[

            SizedBox(width: 50,),
            CircleAvatar(
              backgroundImage: NetworkImage('https://www.w3schools.com/w3css/img_lights.jpg'),
              maxRadius: 20,
            ),
            SizedBox(width: 6,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10,),
                  Text("Hello anik",style: TextStyle(fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            Icon(Icons.more_vert,color: Colors.grey.shade700,),

          ],
        ),
      ),
    )
  );
}
