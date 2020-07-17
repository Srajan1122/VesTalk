import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  getUserByUsername(String username) async{
    return await Firestore.instance.collection("users")
        .where("name",isEqualTo: username)
        .getDocuments();
  }
  createChatRoom(String chartRoomId,chatRoomMap){
    Firestore.instance.collection("ChatRoom")
        .document(chartRoomId).setData(chatRoomMap).catchError((e){
      print(e.toString());
    });
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

  uploadFile(id, description, file, isVideo) async {
      final DateTime now = DateTime.now();
      final int hour = now.hour;
      final int minute = now.minute;
      final int millSeconds = now.millisecondsSinceEpoch;
      final String date = now.day.toString();
      final String month = now.month.toString();
      final int year = now.year;

      final String today = ('$date-$month');
      final String time = ('$date-$month-$year $hour:$minute');
      final String storageId = (millSeconds.toString() + id);

      String fileUrl;
      StorageUploadTask storageUploadTask;

      try{
        if (file != null) {
          StorageReference storageReference = FirebaseStorage.instance.ref()
              .child('posts').child(today).child(storageId);

          if(isVideo){
            storageUploadTask = storageReference.putFile(file, StorageMetadata(contentType: 'video/mp4'));
          }else{
            storageUploadTask = storageReference.putFile(file);
          }

          await storageUploadTask.onComplete;
          print('File uploaded');

          await storageReference.getDownloadURL().then((value){
            fileUrl = value;
          });
        }

        await Firestore.instance.collection('posts').document().setData({
          'id': id,
          'timestamp': time,
          'description': description,
          'fileUrl': fileUrl,
        });

      }
      catch (e){
        print('id--> $id');
        print('description--> $description');
        print('file--> $file');
        print('isVideo--> $isVideo');
        print('somthing went wrong while uploding file');
      }
  }

  Future getAllUserDocumentSnapshot() async {
      QuerySnapshot querySnapshot = await Firestore.instance.collection("user").getDocuments();
      return querySnapshot.documents;
  }
}
