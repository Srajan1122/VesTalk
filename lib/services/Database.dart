import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socail_network_flutter/services/constant.dart';

class DatabaseMethods {
  Future<void> deletePost(postId) async {
    // print(postId);
    DocumentSnapshot qn =
        await Firestore.instance.collection('posts').document(postId).get();
    String uri = qn.data['fileUrl'];
    if (uri != null) {
      StorageReference storageReference =
          await FirebaseStorage.instance.getReferenceFromUrl(uri);
      await storageReference.delete();
    }
    await Firestore.instance.collection('posts').document(postId).delete();
  }
  Future <void> updateReport(postId) async{
    DocumentReference docRef =
    await Firestore.instance.collection("posts").document(postId);
    DocumentSnapshot doc = await docRef.get();
    List reportList = doc.data['reportList'];
    int report = doc.data['report'];
    if (reportList.contains(Constants.uid) == true) {
      Fluttertoast.showToast(msg: "Already Reported");
    } else {

      docRef.updateData({
        'reportList': FieldValue.arrayUnion([Constants.uid]),
        'report': report + 1
      });
      Fluttertoast.showToast(msg: "Reported");
    }
  }

  Future getPosts() async {
    QuerySnapshot qn = await Firestore.instance
        .collection('posts')
        .orderBy('created', descending: true)
        .getDocuments();
    return qn.documents;
  }

  getPostInfo(postId) async {
    return await Firestore.instance.collection('posts').document(postId).get();
  }

  getLikedInfo(postId) {
    return Firestore.instance.collection('posts').document(postId).get();
  }

  Future getPostsById(id) async {
    print(id);
    QuerySnapshot qn = await Firestore.instance
        .collection('posts')
        .where('id', isEqualTo: id)
        .orderBy('created', descending: true)
        .getDocuments();
    return qn.documents;
  }

  Future getComments(postId) async {
    QuerySnapshot qn = await Firestore.instance
        .collection('posts/' + postId + '/comments')
        .orderBy('created', descending: true)
        .getDocuments();
    return qn.documents;
  }

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

  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("messagetime", descending: false)
        .snapshots();
  }
  getLatestTime(String chatRoomId) async{
    return Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection('chats')
        .orderBy('time',descending: true)
        .getDocuments();
  }

  getSeenTime(chatRoomId){
    return Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .get();
  }


  getChaRooms(String id) async {
    return Firestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: id)
        .snapshots();
  }

  getsearch(String id) async {
    return await Firestore.instance
        .collection("ChatRoom").orderBy('time',descending: true)
        .where("users", arrayContains: id)
        .getDocuments();
  }

  updateLike(postId, userId) async {
    DocumentReference docRef =
        Firestore.instance.collection("posts").document(postId);
    DocumentSnapshot doc = await docRef.get();
    List userLikedList = doc.data['userLikedList'];
    int liked = doc.data['liked'];
    if (userLikedList.contains(userId) == true) {
      docRef.updateData({
        'userLikedList': FieldValue.arrayRemove([userId]),
        'liked': liked - 1
      });
    } else {
      docRef.updateData({
        'userLikedList': FieldValue.arrayUnion([userId]),
        'liked': liked + 1
      });
    }
  }

  updatetime(roomId) async {
    DocumentReference docRef =
    Firestore.instance.collection("ChatRoom").document(roomId);
      docRef.updateData({
        'time':  DateTime.now().millisecondsSinceEpoch
      });
  }
  udateMessageTime(roomId,id) async {
    DocumentReference docRef =
    Firestore.instance.collection("ChatRoom").document(roomId);
    DocumentSnapshot doc = await docRef.get();
    print(doc.data['userInfo'][Constants.uid]);
    docRef.updateData({
      'userInfo.${Constants.uid}.messageTime':  DateTime.now().millisecondsSinceEpoch,
      'userInfo.${id}.messageTime':  DateTime.now().millisecondsSinceEpoch
    });
  }

  udateSeenTime(roomId) async {
    DocumentReference docRef =
    Firestore.instance.collection("ChatRoom").document(roomId);
    DocumentSnapshot doc = await docRef.get();
    print(doc.data['userInfo'][Constants.uid]);
    docRef.updateData({
      'userInfo.${Constants.uid}.seenTime':  DateTime.now().millisecondsSinceEpoch,
    });
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

  updateTeacherInfo(id, post, branch) async {
    await Firestore.instance
        .collection('teacher')
        .document(id)
        .updateData({'branch': branch, 'post': post});
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

  uploadStudentInfo(id, branch, batch, year) async {
    await Firestore.instance.collection('student').document(id).setData({
      'branch': branch,
      'batch': batch,
      'year': year
    });
  }

  updateStudentInfo(id, phoneNumber, branch, batch, year) async {
    await Firestore.instance.collection('student').document(id).updateData({
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

  updateCouncilInfo(id, displayName, description, members) async {
    await Firestore.instance.collection('council').document(id).updateData({
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
        'isVideo': isVideo,
        'date': dateFormat,
        'time': timeFormat,
        'weekday': weekday,
        'description': description,
        'fileUrl': fileUrl,
        'displayName': userData.documents[0].data['displayName'],
        'photoUrl': userData.documents[0].data['photoUrl'],
        'designation': userData.documents[0].data['designation'],
        'created': FieldValue.serverTimestamp(),
        'userLikedList': [],
        'liked': 0,
        'report':0,
        'reportList':[]

      });
    } catch (e) {
      print('id--> $id');
      print('description--> $description');
      print('file--> $file');
      print('isVideo--> $isVideo');
      print('something went wrong while uploading file');
    }
  }

  editFile(id, description, file, isVideo, post, postId) async {
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

      await Firestore.instance.collection('posts').document(postId).setData({
        'id': id,
        'isVideo': isVideo,
        'date': dateFormat,
        'time': timeFormat,
        'weekday': weekday,
        'description': description,
        'fileUrl': fileUrl,
        'displayName': post.data['displayName'],
        'photoUrl': post.data['photoUrl'],
        'designation': post.data['designation'],
        'created': FieldValue.serverTimestamp(),
        'userLikedList': post.data['userLikedList'],
        'liked': post.data['liked']
      });
    } catch (e) {
      print('id--> $id');
      print('description--> $description');
      print('file--> $file');
      print('isVideo--> $isVideo');
      print('something went wrong while uploading file');
    }
  }

  editPost(post, postId, description) async {
    final DateTime now = DateTime.now();
    final int hour = now.hour;
    final int minute = now.minute;

    final String date = now.day.toString();
    final String month = now.month.toString();
    final int year = now.year;
    final int weekday = now.weekday;

    final String dateFormat = ('$date-$month-$year');
    final String timeFormat = ('$hour:$minute');
    var postObject = getPostInfo(postId);
    if (postObject.data['fileUrl'] != null && post.data['fileUrl'] == null) {
      StorageReference storageReference = await FirebaseStorage.instance
          .getReferenceFromUrl(postObject.data['fileUrl']);
      await storageReference.delete();
    }

    await Firestore.instance.collection('posts').document(postId).setData({
      'id': post.data['id'],
      'isVideo': post.data['isVideo'],
      'date': dateFormat,
      'time': timeFormat,
      'weekday': weekday,
      'description': description,
      'fileUrl': post.data['fileUrl'],
      'displayName': post.data['displayName'],
      'photoUrl': post.data['photoUrl'],
      'designation': post.data['designation'],
      'created': FieldValue.serverTimestamp(),
      'userLikedList': post.data['userLikedList'],
      'liked': post.data['liked']
    });
  }

  Future getAllUserDocumentSnapshot() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("user").getDocuments();
    return querySnapshot.documents;
  }
}

uploadComment(comment, userId, postId) async {
  QuerySnapshot userData = await Firestore.instance
      .collection('user')
      .where('id', isEqualTo: userId)
      .getDocuments();
  await Firestore.instance
      .collection('posts/' + postId + '/comments')
      .document()
      .setData({
    'id': userId,
    'displayName': userData.documents[0].data['displayName'],
    'photoUrl': userData.documents[0].data['photoUrl'],
    'designation': userData.documents[0].data['designation'],
    'comment': comment,
    'created': FieldValue.serverTimestamp()
  });
}
