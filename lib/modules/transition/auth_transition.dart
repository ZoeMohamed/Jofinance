import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jofinance/modules/dashboard/screens/main_page.dart';
import 'package:jofinance/modules/login/screens/login.dart';
import 'package:jofinance/modules/register/screens/register.dart';
import 'package:jofinance/utils/services/google_auth_service.dart';
import 'package:provider/provider.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({Key? key}) : super(key: key);

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  @override
  Widget build(BuildContext context) {
    GoogleauthService auth =
        Provider.of<GoogleauthService>(context, listen: false);

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          // Waiting Data from stream
          log(snapshot.data.toString());
          log(FirebaseAuth.instance.currentUser?.displayName.toString() ??
              "No users");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            log("data user ada");

            return const MainPage();
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

// TODO LIST
// Memperbaiki Auth yang tidak bisa transisi ke main PAGE dari login page

