import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jofinance/utils/services/google_auth_service.dart';
import 'package:jofinance/modules/login/models/user_login.dart';
import 'package:jofinance/modules/login/screens/login.dart';
import 'package:jofinance/modules/register/screens/register.dart';
import 'package:jofinance/utils/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isemailverif = false;
  final firebase = FirestoreService();

  @override
  void initState() {
    readUser();
    super.initState();
  }

  Future<Userauth?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return Userauth.fromJson(snapshot.data()!);
    }
  }

  sendverif() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              return Column(
                children: [
                  SizedBox(
                    height: 92,
                  ),
                  Container(
                    color: Colors.black,
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        readUser();
                      },
                      child: Text("mantep")),
                  ElevatedButton(
                      onPressed: () {
                        final provider = Provider.of<GoogleauthService>(context,
                            listen: false);
                        provider
                            .googleSignOut()
                            .whenComplete(() => LoginPage());
                      },
                      child: Text("Logout"))
                ],
              );
            }));
  }
}
