import 'package:flutter/material.dart';
import 'package:flutter_firbase_app/models/user.dart';
import 'package:flutter_firbase_app/services/database.dart';
import 'package:flutter_firbase_app/shared/constants.dart';
import 'package:flutter_firbase_app/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Update your brew settings',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration.copyWith(
                          prefixIcon: Icon(Icons.person), hintText: 'Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // dropdown
                    DropdownButtonFormField(
                      decoration: textInputDecoration.copyWith(
                          prefixIcon: Icon(Icons.add_outlined)),
                      value: _currentSugars ?? userData.sugars,
                      onChanged: (val) => setState(() => _currentSugars = val),
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugar(s)'),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // slider
                    Slider(
                        value:
                            (_currentStrength ?? userData.strength).toDouble(),
                        activeColor:
                            Colors.brown[_currentStrength ?? userData.strength],
                        inactiveColor:
                            Colors.brown[_currentStrength ?? userData.strength],
                        min: 100,
                        max: 900,
                        divisions: 8,
                        onChanged: (val) {
                          setState(() => _currentStrength = val.round());
                        }),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.brown[100],
                          primary: Colors.brown[800]),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? userData.sugars,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Update',
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
