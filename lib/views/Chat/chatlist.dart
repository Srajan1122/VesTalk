import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Chat/MassageMainPage.dart';
class ChatUserList extends StatefulWidget {
  String text;
  String secondaryText;
  String image;
  ChatUserList(@required this.text,this.secondaryText,this.image);
  @override
  _ChatUserListState createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return MassagePage();
        }));
        },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  maxRadius: 30,
                ),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.text),
                    SizedBox(height: 6,),
                    Text(widget.secondaryText,style: TextStyle(fontSize: 14,color: Colors.grey.shade500),)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
