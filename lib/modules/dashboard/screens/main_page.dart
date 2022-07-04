import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jofinance/modules/login/repository/google_sign_in.dart';
import 'package:jofinance/modules/login/models/user_login.dart';
import 'package:jofinance/modules/login/screens/login.dart';
import 'package:jofinance/modules/register/screens/register.dart';
import 'package:jofinance/utils/services/firebase_service.dart';
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
    super.initState();
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
        body: Column(
      children: [
        SizedBox(
          height: 92,
        ),
        Container(
          color: Colors.black,
          child: Text(
            "tai",
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              firebase.readUser();

              final x = await firebase.readUser();
            },
            child: Text("mantep")),
        ElevatedButton(
            onPressed: () {
              final logout =
                  Provider.of<GoogleSignInProvider>(context, listen: false);

              logout.googleLogout().then((value) =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  })));
            },
            child: Text("Logout"))
      ],
    ));
  }
}
