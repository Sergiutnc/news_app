import 'package:flutter/material.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/models/userDetails.dart';
import 'package:newsapp/screens/home/news_list.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/services/database.dart';
import 'package:newsapp/shared/drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  User user;
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
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'logout',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        drawer: DrawerMenu(stream: Firestore.instance.collection('users').document(user.uid).snapshots()),
        body: NewsList(),
      ),
    );
  }
}
