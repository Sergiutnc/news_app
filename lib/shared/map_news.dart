import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/shared/drawer_menu.dart';
import 'package:newsapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/models/user.dart';

class MapNews extends StatefulWidget {
  final String newsUid;
  MapNews({this.newsUid});

  @override
  _MapNewsState createState() => _MapNewsState();
}

class _MapNewsState extends State<MapNews> {

  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

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
                .snapshots(),
            user: user),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('news')
                .document(widget.newsUid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Loading();
              return Text(snapshot.data['title']);
            }
        )
    );
  }
}

