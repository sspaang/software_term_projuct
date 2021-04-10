import 'package:flutter/material.dart';
import 'package:flutter_firbase_app/screens/home/brew_list.dart';
import 'package:flutter_firbase_app/screens/home/settings_form.dart';
import 'package:flutter_firbase_app/services/auth.dart';
import 'package:flutter_firbase_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firbase_app/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.brown[900]),
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.brown[900]),
              onPressed: () {
                return _showSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
