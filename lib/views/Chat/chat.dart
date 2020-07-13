import 'package:flutter/material.dart';
// import 'package:socail_network_flutter/Widgets/widgets.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GetAppBar(),
      body: Center(
        child: Text("Chat Page"),
      ),
    );
  }
}
