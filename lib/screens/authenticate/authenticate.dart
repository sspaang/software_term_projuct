import 'package:flutter/material.dart';
import 'package:flutter_firbase_app/screens/authenticate/register.dart';
import 'package:flutter_firbase_app/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [SignIn(), Register()],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.brown[900]),
              ),
            ),
            Tab(
              child: Text(
                'Register',
                style: TextStyle(color: Colors.brown[900]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
