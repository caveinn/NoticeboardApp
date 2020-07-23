import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noticeboard_app/models/notice.dart';
import 'package:noticeboard_app/models/user.dart';

class DatabaseService {

  final CollectionReference noticeCollection = Firestore.instance.collection('notices');
  final CollectionReference userCollection = Firestore.instance.collection('users');

  // Future updateNoticeData(String name, String docId) async {

  //   return await brewCollection.document(docId).setData(
  //     {'body': body}
  //   );
  // }

  // Future getNotices(){
  //   await brewCollection.document().
  // }

  Future<User> getUser(String userId)  async {
    User user = User(id: userId);
    await userCollection.where(
    "id",
    isEqualTo: userId
  ).getDocuments().then((event) {
    if (event.documents.isNotEmpty) {
      Map<String, dynamic> documentData = event.documents.single.data;//if it is a single document
      user = User(
        name: documentData['name'],
        id: documentData['id'],
        department: documentData['department']
        );
    }
  }).catchError((e)=> print("error fetching data: $e"));
    // userCollection.where('id', isEqualTo: "gUVTaiDeZ7dUaQ32iwPi0LYD1Dq1")
  print('********************');
  print(user);
  print('********************');

  return user;
  }

  Future addNoticeData(String url, String userId, String title) async {

    return await noticeCollection.document().setData(
      {'url': url, 'userId': userId, 'title': title, "time":DateTime.now()}
    );
  }

  Future<List<Notice>> get notices {
    noticeCollection.snapshots().listen((event) {

    });
  }

}
