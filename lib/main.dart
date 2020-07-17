import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/SignIn/SignIn.dart';
import 'package:socail_network_flutter/views/Onboarding/onBoarding.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      home: OnBoarding(),
    );
  }
}
