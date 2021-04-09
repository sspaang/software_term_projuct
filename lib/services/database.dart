import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firbase_app/models/brew.dart';
import 'package:flutter_firbase_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance
      .collection('brews'); // this will create behind the scence

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  // Convert a QuerySnapshot we received into the List of brew
  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.data()['name'].toString() ?? '',
          sugars: doc.data()['sugars'].toString() ?? '0',
          strength: doc.data()['strength'] ?? 0);
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'].toString(),
        sugars: snapshot.data()['sugars'].toString(),
        strength: snapshot.data()['strength']);
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // ger user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
