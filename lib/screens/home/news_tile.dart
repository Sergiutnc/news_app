import 'package:flutter/material.dart';
import 'package:newsapp/models/news.dart';

class NewsTile extends StatelessWidget {
  final News news;
  NewsTile({this.news});

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
              onTap: () {},
            )));
  }
}
