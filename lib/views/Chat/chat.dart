import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/services/constant.dart';
import 'package:socail_network_flutter/views/Chat/chatlist.dart';
import 'package:socail_network_flutter/views/Chat/searchnewuserandstartconversation.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var queryResultSet=[];
  var tempSearchStore=[];
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomList;


  _searchBar(){
    return  Padding(
      padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 0),
      child: TextField(
        onChanged: (val){
          val = val.toLowerCase();
          setState(() {
            setState(() {
              tempSearchStore=queryResultSet.where((element){
                var _searchResult =element['userName'].toString().toLowerCase();
                return _searchResult.contains(val);
              }).toList();
            });
          });
        },
        decoration: InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(color: Colors.grey.shade500),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade500,
              size: 20,
            ),
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.all(8),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey.shade400))),
      ),
    );
  }

  _listItem (index){
    print(index.toString()+"insedindsxindexindex");
    print(queryResultSet[index]['userName'].toString()+"namnamnamnamnamnam");
    return  ChatUserList(
      uid: tempSearchStore[index]["id"],
      displayName:tempSearchStore[index]["userName"],
      email: tempSearchStore[index]["email"],
      photoUrl: tempSearchStore[index]["photoUrl"],
      designation: tempSearchStore[index]["designation"],
    );
  }

  @override
  void initState() {
    super.initState();

    databaseMethods.getsearch(Constants.uid).then((value) {
//        print(value.documents[0].data.toString()+"HelloHelloHelloHelloHelloHelloHelloHelloHelloHello");
      for (int i =0; i<value.documents.length; i++){
        setState(() {
          queryResultSet.add(value.documents[i].data);
          tempSearchStore=queryResultSet;
        });

//        print(value.documents[i].data.toString()+"hghghghghghghghghghghg");
      }
    });
  }


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
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Chats",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(30),
                      color: Colors.pink[50],
                    ),
                    height: 30,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatSearchPage();
                          }));
                        },
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.pink,
                                size: 20,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "New",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: tempSearchStore.length+1,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return index==0? _searchBar():_listItem(index-1);
            },
          ),
        ],
      ),
    ));
  }
}
