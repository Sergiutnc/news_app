import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/news.dart';
import 'package:newsapp/services/database.dart';
import 'package:newsapp/shared/constant.dart';
import 'package:newsapp/shared/drawer_menu.dart';
import 'package:newsapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/models/user.dart';

class EditNews extends StatefulWidget {

  final String newsUid;

  EditNews({ this.newsUid });

  @override
  _EditNewsState createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {

  final _formKey = GlobalKey<FormState>();
  final List<String> newsType = ['sports', 'politics', 'business', 'weather', 'others'];

  String _currentTitle;
  String _currentImageUrl;
  String _currentSummary;
  String _currentDescription;
  String _currentType;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Edit news'),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
      ),
      endDrawer: DrawerMenu(
        stream: Firestore.instance
            .collection('users')
            .document(user.uid)
            .snapshots(),
        user: user,
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('news')
            .document(widget.newsUid)
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Center(
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Text('Edit news',
                          style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            initialValue: snapshot.data['title'],
                            decoration: textInputDecoration,
                            validator: (val) => val.isEmpty ? 'Please enter a title' : null,
                            onChanged: (val) => setState(() => _currentTitle = val),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            initialValue: snapshot.data['imageUrl'],
                            decoration: textInputDecoration,
                            validator: (val) => val.isEmpty ? 'Please enter an imageUrl' : null,
                            onChanged: (val) => setState(() => _currentImageUrl = val),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            initialValue: snapshot.data['summary'],
                            decoration: textInputDecoration,
                            validator: (val) => val.isEmpty ? 'Please enter a summary' : null,
                            onChanged: (val) => setState(() => _currentSummary = val),
                          ),
                          SizedBox(height: 20.0),
                          DropdownButtonFormField(
                            decoration: textInputDecoration.copyWith(hintText: 'type'),
                            value: _currentType ?? snapshot.data['type'],
                            items: newsType.map((type){
                              return DropdownMenuItem(
                                value: type,
                                child: Text('$type'),
                              );
                            }).toList(),
                            validator: (val) =>
                            val.isEmpty ? 'Please select a type' : null,
                            onChanged: (val) => setState(() => _currentType = val),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 10,
                            initialValue: snapshot.data['description'],
                            decoration: textInputDecoration,
                            validator: (val) => val.isEmpty ? 'Please enter a description' : null,
                            onChanged: (val) => setState(() => _currentDescription = val),
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: Colors.pink[400],
                            child: Text('Update',
                                        style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              print(_currentDescription);
                              if(_formKey.currentState.validate()) {
                                await DatabaseService(userUid: user.uid).editNewsData(
                                    widget.newsUid,
                                    _currentTitle ?? snapshot.data['title'],
                                    _currentImageUrl ?? snapshot.data['imageUrl'],
                                    _currentSummary ?? snapshot.data['summary'],
                                    _currentDescription ?? snapshot.data['description'],
                                    _currentType ?? snapshot.data['type']);
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        }

      ),
    );
  }
}
