import 'package:flutter/material.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/models/user_details.dart';
import 'package:newsapp/screens/home/news_list.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/services/database.dart';
import 'package:newsapp/shared/drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  final User user;
  Home({ this.user });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<News>>.value(
      value: DatabaseService().news,
      child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: Text('News App'),
          backgroundColor: Colors.red[400],
          elevation: 0.0,
        ),
        endDrawer: DrawerMenu(stream: Firestore.instance.collection('users').document(user.uid).snapshots(), user: user),
        body: NewsList(user: user),
      ),
    );
  }
}
