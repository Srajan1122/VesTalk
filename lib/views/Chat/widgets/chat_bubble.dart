import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chat_message.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatefulWidget {
  final ChatMessage chatMessage;
  final Timestamp chatTime;
  final int seenTime;
  ChatBubble({@required this.chatMessage,this.chatTime,this.seenTime});
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
              borderRadius: BorderRadius.circular(10),
              color: (widget.chatMessage.type != Constants.myName
                  ? Colors.white
                  : Colors.grey.shade200),
            ),
            padding:  EdgeInsets.only(bottom: 4,right: 2,left: 2),
            child:Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 4,top: 8,bottom: 2,right: 20),
                  child: Text(widget.chatMessage.message),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(new DateFormat.jm().format(widget.chatTime.toDate()).toString(),style: TextStyle(fontSize: 8),),
                    (widget.chatMessage.type == Constants.myName)?
                    (widget.chatTime.millisecondsSinceEpoch>widget.seenTime)?Icon(Icons.check,size: 10,color: Colors.blue,):
                        Row(
                          children: <Widget>[
                            Icon(Icons.check,size: 10,color: Colors.blue,),
                            Icon(Icons.check,size: 10,color: Colors.blue,)
                          ],
                        )
                   :SizedBox()
                  ],
                )

              ],
            ),
        ),
      ),
    );
  }
}
