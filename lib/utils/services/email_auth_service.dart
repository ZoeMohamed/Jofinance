import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jofinance/utils/services/firestore_service.dart';

class EmailAuthService extends ChangeNotifier {
  Future registerUsingEmailPassword(
      {required String password,
      required String email,
      required String username}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      FirestoreService()
          .saveUser(FirebaseAuth.instance.currentUser!.uid, username);
    } catch (e) {
      log(e.toString());
    }
  }
}
