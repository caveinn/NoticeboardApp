

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final CollectionReference brewCollection = Firestore.instance.collection('notices');

  Future updateNoticeData(String body, String docId) async {

    return await brewCollection.document(docId).setData(
      {'body': body}
    );
  }

  Future addNoticeData(String body, String userId) async {

    return await brewCollection.document().setData(
      {'body': body, 'uid': userId}
    );
  }

}
