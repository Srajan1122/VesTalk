import 'package:flutter/material.dart';

Widget getAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Center(
      child: Text.rich(
        TextSpan(
          text: 'Ves',
          style: TextStyle(fontSize: 30, color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: 'Talk', style: TextStyle(color: Colors.lightBlue)),
          ],
        ),
      ),
    ),
  );
}
