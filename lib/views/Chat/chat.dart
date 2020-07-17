import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Chat/chatlist.dart';
import 'package:socail_network_flutter/views/Chat/searchnewuserandstartconversation.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: GetAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Chats",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(30),
                        color: Colors.pink[50],
                      ),
                      height: 30,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ChatSearchPage();
                          }));
                        },
                        child:  Row(
                          children: <Widget>[
                            Icon(Icons.add,color: Colors.pink,size: 20,),
                            SizedBox(width: 20,),
                            Text("New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16,left: 16,top: 16,bottom: 0),
              child:
              TextField(
                decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: Icon(Icons.search,color: Colors.grey.shade500,size: 20,),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    border: UnderlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: Colors.grey.shade400
                        )
                    )
                ),
              ),
            ),
            ListView.builder(
              itemCount: 15,
              shrinkWrap: true ,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ChatUserList(displayName:"Aniket",email: "Aniket.gupta@ves.ac.in",photoUrl: 'https://www.w3schools.com/w3css/img_lights.jpg',designation: "Student",) ;
              },

            )
          ],
        ),
      )
    );
  }
}
