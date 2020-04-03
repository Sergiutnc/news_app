import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/services/database.dart';
import 'package:newsapp/shared/like_button.dart';
import 'package:newsapp/shared/loading.dart';
import 'package:newsapp/shared/map_news.dart';

class NewsContainer extends StatelessWidget {
  final AuthService _auth = AuthService();

  final User user;
  final String newsUid;
  NewsContainer({this.newsUid, this.user});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: Firestore.instance
          .collection('news')
          .document(newsUid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
        bool isLiked = false;
        return Center(
          child: ListView(children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image.asset(snapshot.data['imageUrl']),
                  Container(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('users')
                                  .document(snapshot.data['authorUid'])
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Text('Loading data');
                                return Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                        child: Image.asset(
                                            snapshot.data['imageUrl'])),
                                    Text(snapshot.data['username']),
                                  ],
                                );
                              }),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text(snapshot.data['title']),
                          alignment: Alignment.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: LikeButton(userUid: user.uid, newsUid: newsUid),
                      ),
//                      Expanded(
//                        flex: 1,
//                        child: IconButton(
//                            icon: Icon(Icons.map),
//                            onPressed: (){
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(builder: (context) => MapNews(newsUid: newsUid),)
//                              );
//                            },
//                        ),
//                      ),
                    ],
                  ),
                  Container(height: 8.0),
                  Text(snapshot.data['description']),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
