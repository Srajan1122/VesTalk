import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Chat/widgets/chatlist.dart';

InputDecoration inputDecoration() {
  return InputDecoration(
      hintText: "Search...",
      hintStyle: TextStyle(color: Colors.grey.shade500),
      prefixIcon: Icon(
        Icons.search,
        color: Colors.grey.shade500,
        size: 20,
      ),
      fillColor: Colors.grey.shade100,
      contentPadding: EdgeInsets.all(8),
      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(30)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade400)));
}

Align buildAlign(fieldController) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      padding: EdgeInsets.only(left: 16, bottom: 10),
      height: 80,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 21,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextField(
              controller: fieldController,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  hintText: "Type message...",
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    ),
  );
}

ListView buildListView(AsyncSnapshot snapshot) {
  return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (_, index) {
        return ChatUserList(
          uid: snapshot.data[index].data['id'],
          displayName: snapshot.data[index].data['displayName'],
          photoUrl: snapshot.data[index].data['photoUrl'],
          designation: snapshot.data[index].data['designation'],
          email: snapshot.data[index].data['email'],
        );
      });
}

Widget getChatAppBar(context, name, photourl) {
  return AppBar(
      elevation: 10,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(photourl),
                maxRadius: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: Colors.grey.shade700,
              ),
            ],
          ),
        ),
      ));
}
