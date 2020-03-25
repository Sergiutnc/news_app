import 'package:flutter/material.dart';
import 'package:newsapp/screens/authenticate/authenticate.dart';
import 'package:newsapp/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return either Home or Authenticate widget
    if (user != null) {
      return Home();
    } else {
      return Authenticate();
    }
  }
}