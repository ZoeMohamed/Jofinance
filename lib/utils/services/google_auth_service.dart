import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleauthService extends ChangeNotifier {
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

    // Check if there is no linking with google

    await FirebaseAuth.instance.signInWithCredential(credential);

    FirebaseAuth.instance.currentUser!.linkWithCredential(
        EmailAuthProvider.credential(
            email: "zoemohamed31@gmail.com", password: "123456"));

    // Notify Provider listener if there is change in widget tree
    notifyListeners();
  }

  Future googleSignOut() async {
    try {
      (FirebaseAuth.instance.fetchSignInMethodsForEmail(
              FirebaseAuth.instance.currentUser!.email.toString()))
          .then((value) => log(value.toString()));
      final check_fetch = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(
              FirebaseAuth.instance.currentUser!.email.toString())
          .then((value) => value);
      if ((check_fetch.length) > 0) {
        FirebaseAuth.instance.currentUser!.unlink("password");

        await _googleSignIn.disconnect();

        FirebaseAuth.instance.signOut();
      } else {
        await _googleSignIn.disconnect();

        FirebaseAuth.instance.signOut();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
