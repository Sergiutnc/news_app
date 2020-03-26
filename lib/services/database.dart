import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/models/userDetails.dart';

class DatabaseService {

  final String userUid;
  DatabaseService({ this.userUid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
  final CollectionReference newsCollection = Firestore.instance.collection('news');

  Future updateUserData(String username, String email, String imageUrl) async {
    return await userCollection.document(userUid).setData({
      'username' : username,
      'email' : email,
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

//  Future<UserDetails> getUserDetails (String uid) async {
//    var result = await userCollection.document(uid).get();
//    print(result.data['username']);
//    print(result.data['email']);
//    return UserDetails(
//        username: result.data['username'],
//        email: result.data['email'],
//        imageUrl: result.data['imageUrl'],
//    );
//}

}