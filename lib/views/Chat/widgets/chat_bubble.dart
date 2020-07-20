import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chat_message.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessage chatMessage;
  ChatBubble({@required this.chatMessage});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type != Constants.myName
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: (widget.chatMessage.type != Constants.myName
                  ? Colors.white
                  : Colors.grey.shade200),
            ),
            padding: EdgeInsets.all(16),
            child: Text(widget.chatMessage.message)),
      ),
    );
  }
}
