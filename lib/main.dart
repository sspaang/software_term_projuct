import 'package:flutter/material.dart';
import 'package:flutter_firbase_app/models/user.dart';
import 'package:flutter_firbase_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firbase_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      initialData: null, // required
      value: AuthService().user, // expected
      child: MaterialApp(
        title: "Brew Crew",
        home: Wrapper(),
      ),
    );
  }
}
