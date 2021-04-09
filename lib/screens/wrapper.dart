import 'package:flutter/material.dart';
import 'package:flutter_firbase_app/models/user.dart';
import 'package:flutter_firbase_app/screens/authenticate/authenticate.dart';
import 'package:flutter_firbase_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // access to user in database
    final user = Provider.of<Users>(context);
    print(user);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
