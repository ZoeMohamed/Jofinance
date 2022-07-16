import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jofinance/modules/dashboard/screens/main_page.dart';
import 'package:jofinance/modules/login/screens/login.dart';
import 'package:jofinance/modules/register/screens/register.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({Key? key}) : super(key: key);

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          // Waiting Data from stream
          log(FirebaseAuth.instance.authStateChanges().toString());

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return MainPage();
            // Navigate to Mainpage if there is authchanges
          } else {
            // Navigate to Login
            return const LoginPage();
          }
        },
      ),
    );
  }
}
