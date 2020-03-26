import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {

  Stream stream;
  DrawerMenu({ this.stream });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot){
        if(!snapshot.hasData) return Text('Loading data');
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
              ListTile(
                title: Text('edit details'),
                trailing: Icon(Icons.settings),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text('action 2'),
                trailing: Icon(Icons.arrow_downward),
                onTap: () {},
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
