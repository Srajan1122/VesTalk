import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseMethods {
  getAllUserData() async {
    final QuerySnapshot _data =
        await Firestore.instance.collection('user').getDocuments();

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
  getUserByUsername(String username) async{
    return await Firestore.instance.collection("users")
        .where("name",isEqualTo: username)
        .getDocuments();
  }
  createChatRoom(String chatRoomId,chatRoomMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId,messageMap){
    Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){print(e.toString());});
  }
  getConversationMessages(String chatRoomId) async {
    return await Firestore.instance.collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time",descending: false )
        .snapshots();
  }
  getChaRooms(String userName) async{
    return await Firestore.instance.collection("ChatRoom")
        .where("users",arrayContains: userName)
        .snapshots();
  }

  uploadUserData(id, displayName, photoUrl, email) async {
    await Firestore.instance.collection('user').document(id).setData({
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
    await Firestore.instance
        .collection('user')
        .document(id)
        .updateData({'designation': designation});
  }

  uploadTeacherInfo(id, post, branch) async {
    await Firestore.instance
        .collection('teacher')
        .document(id)
        .setData({'branch': branch, 'post': post});
  }

  getTeacherInfo(id) async {
    print("Id for getting teacher info is $id");
    Map<String, String> teacherInfo = {};
    try {
      final QuerySnapshot userQuery = await Firestore.instance
          .collection('user')
          .where('id', isEqualTo: id)
          .getDocuments();

      final DocumentSnapshot teacherQuery =
          await Firestore.instance.collection('teacher').document(id).get();

      teacherInfo = {
        'name': userQuery.documents[0]['displayName'],
        'photoUrl': userQuery.documents[0]['photoUrl'],
        'designation': userQuery.documents[0]['designation'],
        'email': userQuery.documents[0]['email'],
        'branch': teacherQuery.data['branch'],
        'post': teacherQuery.data['post']
      };
      print(teacherInfo);
    } catch (e) {
      print('Error in getting teacherInfo for id : $id');
    }

    return teacherInfo;
  }

  uploadStudentInfo(id, phoneNumber, branch, batch, year) async {
    await Firestore.instance.collection('student').document(id).setData({
      'phoneNumber': phoneNumber,
      'branch': branch,
      'batch': batch,
      'year': year
    });
  }

  getStudentInfo(id) async {
    print("Id for getting student info is $id");
    Map<String, String> studentInfo = {};
    try {
      final QuerySnapshot userQuery = await Firestore.instance
          .collection('user')
          .where('id', isEqualTo: id)
          .getDocuments();

      final DocumentSnapshot studentQuery =
          await Firestore.instance.collection('student').document(id).get();
      studentInfo = {
        'name': userQuery.documents[0]['displayName'],
        'photoUrl': userQuery.documents[0]['photoUrl'],
        'designation': userQuery.documents[0]['designation'],
        'email': userQuery.documents[0]['email'],
        'branch': studentQuery.data['branch'],
        'phoneNumber': studentQuery.data['phoneNumber'],
        'batch': studentQuery.data['batch'],
        'year': studentQuery.data['year']
      };
      print(studentInfo);
    } catch (e) {
      print('Error in getting studentInfo for id : $id');
    }

    return studentInfo;
  }

  uploadCouncilInfo(id, displayName, description, members) async {
    await Firestore.instance.collection('council').document(id).setData({
      'displayName': displayName,
      'description': description,
      'members': members,
    });
  }

  getCouncilInfo(id) async {
    print("Id for getting council info is $id");
    Map<String, String> councilInfo = {};
    try {
      final QuerySnapshot userQuery = await Firestore.instance
          .collection('user')
          .where('id', isEqualTo: id)
          .getDocuments();

      final DocumentSnapshot councilQuery =
          await Firestore.instance.collection('council').document(id).get();

      councilInfo = {
        'name': userQuery.documents[0]['displayName'],
        'photoUrl': userQuery.documents[0]['photoUrl'],
        'designation': userQuery.documents[0]['designation'],
        'email': userQuery.documents[0]['email'],
        'displayName': councilQuery.data['displayName'],
        'description': councilQuery.data['description'],
        'members': councilQuery.data['members'],
      };
      print(councilInfo);
    } catch (e) {
      print('Error in getting CouncilInfo for id : $id');
    }

    return councilInfo;
  }

  checkIfInitialDataIsFilled(id) async {
    String _designation;
    Map<String, dynamic> _data;
    try {
      await Firestore.instance
          .collection('user')
          .document(id)
          .get()
          .then((value) {
        _designation = value.data['designation'];
      });

      if (_designation == null) {
        print('i am false');
        return false;
      }

      await Firestore.instance
          .collection(_designation.toLowerCase())
          .document(id)
          .get()
          .then((value) {
        _data = value.data;
      });

      if (_data == null) {
        print('i am false');
        return false;
      }
    } catch (e) {
      print('some error');
      return false;
    }

    return true;
  }

  uploadFile(id, description, file, isVideo) async {
    final DateTime now = DateTime.now();
    final int hour = now.hour;
    final int minute = now.minute;
    final int millSeconds = now.millisecondsSinceEpoch;
    final String date = now.day.toString();
    final String month = now.month.toString();
    final int year = now.year;
    final int weekday = now.weekday;

    final String today = ('$date-$month');
    final String dateFormat = ('$date-$month-$year');
    final String timeFormat = ('$hour:$minute');
    final String storageId = (millSeconds.toString() + id);

    String fileUrl;
    StorageUploadTask storageUploadTask;

    try {
      if (file != null) {
        StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child('posts')
            .child(today)
            .child(storageId);

        if (isVideo) {
          storageUploadTask = storageReference.putFile(
              file, StorageMetadata(contentType: 'video/mp4'));
        } else {
          storageUploadTask = storageReference.putFile(file);
        }

        await storageUploadTask.onComplete;
        print('File uploaded');

        await storageReference.getDownloadURL().then((value) {
          fileUrl = value;
        });
      }

      QuerySnapshot userData = await Firestore.instance
          .collection('user')
          .where('id', isEqualTo: id)
          .getDocuments();

      await Firestore.instance.collection('posts').document().setData({
        'id': id,
        'date': dateFormat,
        'time': timeFormat,
        'weekday': weekday,
        'description': description,
        'fileUrl': fileUrl,
        'displayName': userData.documents[0].data['displayName'],
        'photoUrl': userData.documents[0].data['displayName'],
        'designation': userData.documents[0].data['displayName'],
      });
    } catch (e) {
      print('id--> $id');
      print('description--> $description');
      print('file--> $file');
      print('isVideo--> $isVideo');
      print('something went wrong while uploading file');
    }
  }

  Future getAllUserDocumentSnapshot() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("user").getDocuments();
    return querySnapshot.documents;
  }
}
