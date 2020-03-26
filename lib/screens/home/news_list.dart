import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/screens/home/news_tile.dart';
import 'package:provider/provider.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {

    final news = Provider.of<List<News>>(context);

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return NewsTile(news: news[index]);
      },

    );
  }
}