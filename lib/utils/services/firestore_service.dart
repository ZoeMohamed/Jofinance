import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jofinance/modules/dashboard/screens/main_page.dart';
import 'package:jofinance/modules/login/models/user_login.dart';

class FirestoreService {
  // Initialize

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

  static Future checkUsers(user_id) async {
    List<Userauth?> list_user = await readUsers();
    List<String> user_id_db = [];

    list_user.forEach((element) {
      user_id_db.add(element!.userid);
    });

    for (var userx in user_id_db) {
      if (userx == user_id) {
        log("berhasil");
        return true;
      } else {
        return false;
      }
    }
  }

  // Read all User
  static Future readUsers() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    List<Userauth?> user_list = [];
    allData.forEach((element) {
      var data = Userauth.fromJson(element);
      user_list.add(data);
    });

    return user_list;

    // List<Userauth?> user_list =
    //     allData.map((user_data) => Userauth.fromJson(user_data)).toList();

    // log(user_list.toString());
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
