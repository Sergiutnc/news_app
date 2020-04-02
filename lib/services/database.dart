import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/models/user_details.dart';

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

  Future updateNewsData(String title, String imageUrl, String summary, String description) async {
    return await newsCollection.document().setData({
      'authorUid': userUid,
      'title': title,
      'imageUrl': imageUrl,
      'summary': summary,
      'description': description,
    });
  }

  Future editNewsData(String newsUid, String title, String imageUrl, String summary, String description) async {
    return await newsCollection.document(newsUid).setData({
      'authorUid': userUid,
      'title': title,
      'imageUrl': imageUrl,
      'summary': summary,
      'description': description,
    });
  }

  // news list from snapshot
  List<News> _newsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return News(
        newsUid: doc.documentID,
        authorUid: doc.data['authorUid'],
        title: doc.data['title'] ?? '',
        description: doc.data['description'] ?? '',
        summary: doc.data['summary'] ?? '',
        imageUrl: doc.data['imageUrl'] ?? '',
      );
    }).toList();
  }

  // userDetails from snapshots
  UserDetails _userDetailsFromSnapshot(DocumentSnapshot snapshot) {
    return UserDetails(
      uid: userUid,
      username: snapshot.data['username'],
      imageUrl: snapshot.data['imageUrl'],
      email: snapshot.data['email'],
    );
  }

  // get news stream
  Stream<List<News>> get news {
    return newsCollection.snapshots()
        .map(_newsListFromSnapshot);
  }

  // get user doc stream
  Stream<UserDetails> get userData {
    return userCollection.document(userUid).snapshots()
      .map(_userDetailsFromSnapshot);
  }

  Future addLike(String newsUid, bool isLiked) async {
    return await newsCollection.document(newsUid).collection('likes').document(userUid).setData({
      'isLiked': !isLiked
    });
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