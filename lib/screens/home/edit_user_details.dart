import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/models/user_details.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/services/database.dart';
import 'package:newsapp/shared/constant.dart';
import 'package:newsapp/shared/drawer_menu.dart';
import 'package:newsapp/shared/loading.dart';
import 'package:provider/provider.dart';

class EditUserDetails extends StatefulWidget {
  final User user;

  EditUserDetails({this.user});

  @override
  _EditUserDetailsState createState() => _EditUserDetailsState();
}

class _EditUserDetailsState extends State<EditUserDetails> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentImageUrl;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.red[400],
        elevation: 0.0,
      ),
      endDrawer: DrawerMenu(
        stream: Firestore.instance
            .collection('users')
            .document(widget.user.uid)
            .snapshots(),
        user: widget.user,
      ),
      body: StreamBuilder<UserDetails>(
          stream: DatabaseService(userUid: user.uid).userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserDetails userDetails = snapshot.data;

              return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Update your user details',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                              initialValue: userDetails.username,
                              decoration: textInputDecoration,
                              validator: (val) =>
                                  val.isEmpty ? 'Please enter a name' : null,
                              onChanged: (val) =>
                                  setState(() => _currentName = val)),
                          SizedBox(height: 20.0),
                          TextFormField(
                              initialValue: userDetails.imageUrl,
                              decoration: textInputDecoration,
                              validator: (val) => val.isEmpty
                                  ? 'Please enter an image url'
                                  : null,
                              onChanged: (val) =>
                                  setState(() => _currentImageUrl = val)),
                          SizedBox(height: 20.0),
                          RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                await DatabaseService(userUid: user.uid).updateUserData(
                                  _currentName ?? userDetails.username,
                                  userDetails.email,
                                  _currentImageUrl ?? userDetails.imageUrl
                                );
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ));
            } else {
              return Loading();
            }
          }),
    );
  }
}
