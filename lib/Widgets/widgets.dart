

import 'package:flutter/material.dart';

Widget getAppBar() {
  return AppBar(
    backgroundColor: Color(0xFF000050),
    title: Text('Appbar'),
  );
}

Widget getChatAppBar(context){
  return AppBar(
    elevation: 10,
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    flexibleSpace: SafeArea(
      child: Container(
        padding: EdgeInsets.only(right: 16),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,),
            ),
            SizedBox(width: 2,),
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
