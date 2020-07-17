import 'package:flutter/material.dart';
import 'package:socail_network_flutter/views/Profile/ProfilePage.dart';

// TODO: Give ui to this list or users
// TODO: On tap function to be written by srajan after profile page is ready
class ListUsers extends StatelessWidget {
  final String id, designation, displayName, email, photoUrl;

  ListUsers(
      {this.id, this.designation, this.displayName, this.email, this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(photoUrl),
      ),
      title: Text(displayName),
      subtitle: Text(email),
      trailing: Text(designation),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfilePage(uid: id)));
      },
    );
  }
}
