import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jofinance/modules/login/models/user_login.dart';

class FirestoreService {
  // Read specific user
  Future<String> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return snapshot.data().toString();
    } else {
      return "knto";
    }
  }

  // Save username registant to firestore
  Future saveUser(userid, username) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('users').doc(userid);

    Map<String, dynamic> data = <String, dynamic>{"username": username};

    await documentReferencer
        .set(data)
        .whenComplete(() => print("New User added to Firestore"))
        .catchError((e) => print(e));
  }

  readUsers(x) async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<String> tes = [];
    for (var cnt = 0; cnt < allData.length; cnt++) {}
    for (var cnt = 0; cnt < tes.length; cnt++) {
      if (tes[cnt] == x) {
        return true;
      }
    }
    return tes;
  }
}
