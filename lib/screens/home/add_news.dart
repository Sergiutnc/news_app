import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/models/user_details.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/services/database.dart';
import 'package:newsapp/shared/constant.dart';
import 'package:newsapp/shared/drawer_menu.dart';
import 'package:newsapp/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/models/user.dart';
import 'package:date_format/date_format.dart';

class AddNews extends StatefulWidget {
  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final List<String> newsType = ['sports', 'politics', 'business', 'weather', 'others'];

  String _currentTitle = '';
  String _currentImageUrl = '';
  String _currentSummary = '';
  String _currentDescription = '';
  String _currentType;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: Text('Add news'),
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
        body: Center(
            child: ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Text(
                        'Add news',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Title'),
                          validator: (val) =>
                              val.isEmpty ? 'Please enter a title' : null,
                          onChanged: (val) =>
                              setState(() => _currentTitle = val)
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                          textInputDecoration.copyWith(hintText: 'ImageUrl'),
                          validator: (val) =>
                          val.isEmpty ? 'Please enter an imageUrl' : null,
                          onChanged: (val) =>
                              setState(() => _currentImageUrl = val)
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                          decoration:
                          textInputDecoration.copyWith(hintText: 'Summary'),
                          validator: (val) =>
                          val.isEmpty ? 'Please enter a summary' : null,
                          onChanged: (val) =>
                              setState(() => _currentSummary = val)
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'type'),
                        value: _currentType,
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
                          maxLines: 10,
                          decoration:
                          textInputDecoration.copyWith(hintText: 'Description'),
                          validator: (val) =>
                          val.isEmpty ? 'Please enter a description' : null,
                          onChanged: (val) =>
                              setState(() => _currentDescription = val)
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Add news',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          print(formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]));
                          if(_formKey.currentState.validate()) {
                            await DatabaseService(userUid: user.uid).updateNewsData(
                                _currentTitle, _currentImageUrl, _currentSummary, _currentDescription, _currentType);
                          Navigator.pop(context);
                          }
                        },

                      )
                    ])))
          ],
        )));
  }
}
