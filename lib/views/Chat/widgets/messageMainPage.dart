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
  final String uid;
  MassagePage(this.chatRoomId, this.name, this.photourl,this.uid);
  @override
  _MassagePageState createState() => _MassagePageState();
}

enum MessageType {
  sender,
  Receiver,
}

class _MassagePageState extends State<MassagePage> {

  int seenTime;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessagesStream;
  ScrollController _scrollController = ScrollController();

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "messagedBy": Constants.myName,
        "time": DateTime.now(),
        "messagetime":  DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.updatetime(widget.chatRoomId);
      databaseMethods.udateMessageTime(widget.chatRoomId,widget.uid);
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
    databaseMethods.getSeenTime(widget.chatRoomId).then((value) {
//      print(value.data['userInfo'][widget.uid]['seenTime'].toString()+"anianaianaiananai");
      setState(() {
        seenTime=value.data['userInfo'][widget.uid]['seenTime'];
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
              databaseMethods.udateSeenTime(widget.chatRoomId);
              return snapshot.hasData
                  ? ListView.builder(
                      controller: _scrollController,
                      itemCount: snapshot.data.documents.length,
                      padding: EdgeInsets.only(top: 10, bottom: 70),
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
//                        print("zzzzzzzzz"+index.toString());
                        return ChatBubble(
                          seenTime:seenTime==null?0:seenTime,
                          chatTime:snapshot
                              .data.documents[index].data["time"],
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
                padding: EdgeInsets.only(right: 10, bottom: 2),
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
                  backgroundColor: Colors.lightBlue,
                ),
              ))
        ],
      ),
    );
  }
}
