import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jofinance/modules/dashboard/screens/main_page.dart';
import 'package:jofinance/modules/login/models/user_login.dart';
import 'package:jofinance/utils/services/firestore_service.dart';

class GoogleauthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleSignIn() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
    final Userauth? user = await FirestoreService.readUser();
    // Prevent user from login without register
    final checkFetch = await FirebaseAuth.instance
        .fetchSignInMethodsForEmail(
            FirebaseAuth.instance.currentUser!.email.toString())
        .then((value) {
      return value;
    });
    if (!checkFetch.contains("password") && user?.password != null) {
      FirebaseAuth.instance.currentUser!
          .linkWithCredential(EmailAuthProvider.credential(
              email: FirebaseAuth.instance.currentUser!.email.toString(),
              password: user!.password))
          .whenComplete(() => const MainPage());
      notifyListeners();
    } else if (checkFetch.contains("google.com")) {}
  }

  Future googleSignOut() async {
    try {
      final checkFetch = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(
              FirebaseAuth.instance.currentUser!.email.toString())
          .then((value) {
        log(value.toString());
        return value;
      });
      if (checkFetch.contains("password") &&
          !checkFetch.contains('google.com')) {
        // FirebaseAuth.instance.currentUser!.unlink("password");

        FirebaseAuth.instance.signOut();
        notifyListeners();
      } else if (checkFetch.contains("password") &&
          checkFetch.contains("google.com")) {
        FirebaseAuth.instance.currentUser!.unlink("google.com");
        await _googleSignIn.disconnect();

        FirebaseAuth.instance.signOut();
        notifyListeners();
      } else if (!checkFetch.contains("password") &&
          checkFetch.contains("google.com")) {
        // FirebaseAuth.instance.currentUser!.unlink("google.com");
        await _googleSignIn.disconnect();

        FirebaseAuth.instance.signOut();
        notifyListeners();
      } else if (checkFetch.contains("password")) {
        // FirebaseAuth.instance.currentUser!.unlink("password");

        FirebaseAuth.instance.signOut();
        notifyListeners();
      } else if (checkFetch.contains("google.com")) {
        // FirebaseAuth.instance.currentUser!.unlink("google.com");
        await _googleSignIn.disconnect();

        FirebaseAuth.instance.signOut();

        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
