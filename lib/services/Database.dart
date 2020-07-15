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
        'photoUrl': user.data['photoUrl'],
        'email': user.data['email']
      });
    }
    return allUsers;
  }

  uploadUserData(id, displayName, photoUrl, email) async {
    await Firestore.instance.collection('user').document(id)
      .setData({
        'id': id,
        'displayName': displayName,
        'photoUrl': photoUrl,
        'email': email
      });
  }

  findUserById(id) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('user')
        .where('id', isEqualTo: id)
        .getDocuments();
    return result.documents;
  }

  uploadUserDesignation(id, designation) async {
    await Firestore.instance.collection('user').document(id)
        .updateData({
          'designation': designation
    });
  }

  uploadTeacherInfo(id, post, branch) async {
    await Firestore.instance.collection('teacher').document(id)
        .setData({
          'branch': branch,
          'post': post
    });
  }

  uploadStudentInfo(id, phoneNumber, branch, batch, year) async {
    await Firestore.instance.collection('student').document(id)
        .setData({
          'phoneNumber': phoneNumber,
          'branch': branch,
          'batch': batch,
          'year': year
    });
  }

  uploadCouncilInfo(id, displayName, description, members) async {
    await Firestore.instance.collection('council').document(id)
        .setData({
      'displayName': displayName,
      'description': description,
      'members': members,
    });
  }

  checkIfInitialDataIsFilled(id) async {
    String _designation;
    Map<String, dynamic> _data;
    try {
      await Firestore.instance.collection('user')
          .document(id).get().then((value) {
          _designation = value.data['designation'];
        });

      if(_designation == null){
        print('i am false');
        return false;
      }

      await Firestore.instance.collection(_designation.toLowerCase())
          .document(id).get().then((value){
            _data = value.data;
          });

      if(_data == null){
        print('i am false');
        return false;
      }

    }catch (e) {
      print('some error');
      return false;
    }

    return true;
  }
}
