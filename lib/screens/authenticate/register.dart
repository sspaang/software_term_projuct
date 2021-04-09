import 'package:flutter/material.dart';
import 'package:flutter_firbase_app/services/auth.dart';
import 'package:flutter_firbase_app/shared/constants.dart';
import 'package:flutter_firbase_app/shared/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  final String _logoPic = 'assets/coffee-break.png';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: Text('Register to Brew Crew'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(_logoPic),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      cursorColor: Colors.brown[900],
                      keyboardType: TextInputType.emailAddress,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Enter your email'),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                          return email;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) => val.length < 6
                          ? 'Enter a password more than 6 charaters'
                          : null,
                      cursorColor: Colors.brown[900],
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Enter your password',
                          prefixIcon: Icon(Icons.vpn_key)),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                          return password;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = _auth.registerWithEmailAndPassword(
                              email, password);
                          if (result == null) {
                            setState(() {
                              error = 'please supply a valid email';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              letterSpacing: 1, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.brown[50],
                          onPrimary: Colors.brown[900],
                          onSurface: Colors.brown[200]),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
