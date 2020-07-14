import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  getAllUserData() async {
    final QuerySnapshot _data = await Firestore.instance.collection('user')
        .getDocuments();

    List<Map> allUsers = [];
    for (DocumentSnapshot user in _data.documents) {
      allUsers.add({
        'id': user.data['id'],
        'displayName': user.data['displayName'],
        'photoUrl': user.data['photoUrl']
      });
    }
    return allUsers;
  }

  uploadUserData(id, displayName, photoUrl) async {
    await Firestore.instance
        .collection('user')
        .document(id)
        .setData({
      'id': id,
      'displayName': displayName,
      'photoUrl': photoUrl
    });
  }

  findUserById(id) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('user')
        .where('id', isEqualTo: id)
        .getDocuments();
    return result.documents;
  }
}
