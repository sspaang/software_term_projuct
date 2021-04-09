import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firbase_app/models/user.dart';
import 'package:flutter_firbase_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on User (firebase)
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Users> get user {
    return _auth
        .authStateChanges()
        //.map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anonymouse
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User userResult = result.user;
      //return user; // if sign in successfully
      return _userFromFirebaseUser(userResult);
    } catch (e) {
      print(e.toString());
      return null; // if sign in fail
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // make a request to Firebase
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      User userResult = result.user;
      return _userFromFirebaseUser(userResult);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with emain & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      // make a request to Firebase
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      User userResult = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: userResult.uid)
          .updateUserData('0', 'new member', 100);

      return _userFromFirebaseUser(userResult);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
