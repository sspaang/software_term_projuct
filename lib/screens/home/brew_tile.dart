import 'package:flutter/material.dart';
import 'package:flutter_firbase_app/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffee_icon_prof.png'),
          ),
          title: Text('Name: ${brew.name}'),
          subtitle: Text('Take ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
