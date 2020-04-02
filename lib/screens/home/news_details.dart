import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/screens/home/news_container.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/shared/drawer_menu.dart';

class NewsDetails extends StatelessWidget {
  final AuthService _auth = AuthService();

  final User user;
  final String newsUid;

  NewsDetails({this.user, this.newsUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('News App'),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
      ),
      endDrawer: DrawerMenu(
          stream: Firestore.instance
              .collection('users')
              .document(user.uid)
              .snapshots(), user: user),
      body: NewsContainer(
          newsUid: newsUid, user: user),
    );
  }
}
