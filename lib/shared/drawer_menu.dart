import 'package:flutter/material.dart';
import 'package:newsapp/models/user.dart';
import 'package:newsapp/services/auth.dart';
import 'package:newsapp/screens/home/edit_user_details.dart';

class DrawerMenu extends StatelessWidget {
  final AuthService _auth = AuthService();

  final User user;
  Stream stream;
  DrawerMenu({this.stream, this.user});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading data');
        return Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red[400],
                ),
                accountName: Text(snapshot.data['username']),
                accountEmail: Text(snapshot.data['email']),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(snapshot.data['imageUrl']),
                ),
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Edit details'),
                onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditUserDetails(user: user),)
                );
                },
              ),
              Divider(),
              ListTile(
                title: Text('action 2'),
                trailing: Icon(Icons.arrow_downward),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('Log Out'),
                trailing: Icon(Icons.person),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
              Divider(),
              ListTile(
                title: Text('Close'),
                trailing: Icon(Icons.close),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
