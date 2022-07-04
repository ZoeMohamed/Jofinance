import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jofinance/modules/login/models/user_login.dart';

class FirestoreService {
  // Read specific user
  Future<Userauth?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return Userauth.fromJson(snapshot.data()!);
    }
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
