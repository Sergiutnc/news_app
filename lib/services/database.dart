import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/models/news.dart';

class DatabaseService {

  final String userUid;
  DatabaseService({ this.userUid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference newsCollection = Firestore.instance.collection('news');

  Future updateUserData(String username, String imageUrl) async {
    return await userCollection.document(userUid).setData({
      'username' : username,
      'imageUrl' : imageUrl,
    });

  }

  // news list from snapshot
  List<News> _newsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return News(
        title: doc.data['title'] ?? '',
        description: doc.data['description'] ?? '',
        summary: doc.data['summary'] ?? '',
        imageUrl: doc.data['imageUrl'] ?? '',
      );
    }).toList();
  }

  // get news stream
  Stream<List<News>> get news {
    return newsCollection.snapshots()
        .map(_newsListFromSnapshot);
  }

}