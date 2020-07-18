import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/Chat/MassageMainPage.dart';
class ChatUserList extends StatefulWidget {
  final String displayName;
  final String email;
  final String photoUrl;
  final String designation;
  ChatUserList({@required this.displayName,this.email,this.photoUrl,this.designation});
  @override
  _ChatUserListState createState() => _ChatUserListState();

}

class _ChatUserListState extends State<ChatUserList> {


  DatabaseMethods _databaseMethods = new DatabaseMethods();
  String myName="";

  createChatroomAndstartchat(String userName){
    if(userName != myName){
      List<String> users = [userName, myName];
      String chatRoomId = getChatRoomId(userName, myName);
      Map<String,dynamic> chatRoomMap ={
        "users" :users,
        "chatroomId":chatRoomId
      };
      _databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => MassagePage(chatRoomId,widget.displayName,widget.photoUrl)
      ));
    }
    else{
      print("Same user");
    }

  }
  getUserData() async {
    await SharedPreferences.getInstance().then((value) => {
      this.setState(() {
        myName = (value.getString("displayName") ?? '');
      })
    });
  }


  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        createChatroomAndstartchat(widget.displayName);
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
getChatRoomId(String a,String b){
  if(a.substring(0,1).codeUnitAt(0)> b.substring(0,1).codeUnitAt(0)){
    return"$b\_$a";
  }
  else{
    return "$a\_$b";
  }
}
