import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Chat/MassageMainPage.dart';
class ChatUserList extends StatefulWidget {
  String displayName;
  String email;
  String photoUrl;
  String designation;
  ChatUserList({@required this.displayName,this.email,this.photoUrl,this.designation});
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
        color: Colors.grey.shade50,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 1,bottom: 1),
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.photoUrl),
                  maxRadius: 30,
                ),
                SizedBox(width: 16,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.displayName),
                    SizedBox(height: 6,),
                    Text(widget.email,style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),

                  ],
                ),
                Text(widget.designation,style: TextStyle(fontSize: 14,color: Colors.grey.shade500),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
