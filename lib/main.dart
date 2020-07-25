import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/SignIn//Loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Loading(),
    );
  }
}
