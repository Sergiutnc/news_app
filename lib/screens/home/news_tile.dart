import 'package:flutter/material.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/screens/home/add_news.dart';
import 'package:newsapp/screens/home/edit_news.dart';
import 'package:newsapp/screens/home/news_details.dart';

class NewsTile extends StatelessWidget {

  final User user;
  final News news;
  NewsTile({ this.user, this.news });

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: Image.asset(news.imageUrl),
              title: Text(news.title),
              subtitle:
              Text(news.summary),
              // trailing: Icon(Icons.more_vert),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewsDetails(user: user, newsUid: news.newsUid),)
                );
              },
              onLongPress: () {
                if (user.uid == news.authorUid) {
                  print(news.newsUid);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditNews(newsUid: news.newsUid),)
                  );
                }
              },
            )));
  }
}
