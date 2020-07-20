import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chat_bubble.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chat_message.dart';
import 'package:socail_network_flutter/views/Chat/widgets/widgets.dart';

class MassagePage extends StatefulWidget {
  final String chatRoomId;
  final String name;
  final String photourl;
  MassagePage(this.chatRoomId, this.name, this.photourl);
  @override
  _MassagePageState createState() => _MassagePageState();
}

enum MessageType {
  sender,
  Receiver,
}

class _MassagePageState extends State<MassagePage> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessagesStream;
  ScrollController _scrollController = ScrollController();

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "messagedBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getChatAppBar(context, widget.name, widget.photourl),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: chatMessagesStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data.documents.length,
                      padding: EdgeInsets.only(top: 10, bottom: 70),
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          chatMessage: ChatMessage(
                              message: snapshot
                                  .data.documents[index].data["message"],
                              type: snapshot
                                  .data.documents[index].data["messagedBy"]),
                        );
                      })
                  : Container();
            },
          ),
          buildTextField(messageController),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.only(right: 20, bottom: 12),
                child: FloatingActionButton(
                  onPressed: () {
                    Timer(
                        Duration(milliseconds: 300),
                        () => _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent));
                    sendMessage();
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.pink,
                ),
              ))
        ],
      ),
    );
  }
}
