import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jofinance/modules/login/models/user_login.dart';

class FirestoreService {
  // Read specific user
  static Future<Userauth?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return Userauth.fromJson(snapshot.data()!);
    }
  }

  // Save username registant to firestore
  Future saveUser({userid, username, email, password}) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection('users').doc(userid);

    // Mappers format
    Map<String, dynamic> data = <String, dynamic>{
      "user_id": userid,
      "username": username,
      "email": email,
      "password": password
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("New User added to Firestore"))
        .catchError((e) => print(e));
  }

  // static Future<Userauth?> readUsers(x) async {
  //   final docUser = FirebaseFirestore.instance.collection('users');

  //   final snapshot = await docUser.get();

  //   if (snapshot.exists) {
  //     return Userauth.fromJson(snapshot.data()!);
  //   }
  // }
}
