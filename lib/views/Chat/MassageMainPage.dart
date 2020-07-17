import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/Widgets/widgets.dart';
import 'package:socail_network_flutter/views/Chat/chat_bubble.dart';
import 'package:socail_network_flutter/views/Chat/chat_message.dart';

class MassagePage extends StatefulWidget {
  @override
  _MasagepageState createState() => _MasagepageState();
}
enum MessageType{
  sender,
  Receiver,
}
class _MasagepageState extends State<MassagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getChatAppBar(context),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: 6,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return ChatBubble(chatMessage:ChatMessage(message: 'Hi hello',type: MessageType.sender));
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16,bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add,color: Colors.white,size: 21,),
                    ),
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
              padding: EdgeInsets.only(right: 20,bottom: 12),
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
