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
    var checking;
    final status = FirebaseAuth.instance
        .fetchSignInMethodsForEmail(
            FirebaseAuth.instance.currentUser!.email!.toString())
        .then((value) {
      checking = value;
    });
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
            FirebaseAuth.instance.currentUser!.providerData[0].displayName
                .toString(),
            style: TextStyle(
              fontSize: 45,
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              // final email_credential = GoogleAuthProvider.credential(
              //     idToken:
              //         "eyJhbGciOiJSUzI1NiIsImtpZCI6IjUwYTdhYTlkNzg5MmI1MmE4YzgxMzkwMzIzYzVjMjJlMTkwMzI1ZDgiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vam9maW5hbmNlLTQ2YWVjIiwiYXVkIjoiam9maW5hbmNlLTQ2YWVjIiwiYXV0aF90aW1lIjoxNjU3MTI3MDI0LCJ1c2VyX2lkIjoiRkhYVEZaaDVINmE4RFNOUnhDdHZNN2lsQWROMiIsInN1YiI6IkZIWFRGWmg1SDZhOERTTlJ4Q3R2TTdpbEFkTjIiLCJpYXQiOjE2NTcxMjcwMjQsImV4cCI6MTY1NzEzMDYyNCwiZW1haWwiOiJ6b2Vtb2hhbWVkMzFAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbInpvZW1vaGFtZWQzMUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.CU7c8bBPLVsYI2f32hgajZ2gLQBBaOhypXdHvJlm__dXklHsRAbhpr1Uf-ZpaaPKQ3dYPa1GsfiITEFpDvcR5nYMHSU-joRTU_xHXPuudbKHNUZGjM9wJ5-ZOBgYSigXLs8FCy3ztTEHX1JlbQgUX6MhIco4QZcGJ3HdDvA25hRaJ68DBSK4Op2IEBSN7-hcCr-jRoghwEH5Lu8ztUu3HVKVKTDwYy-t3G63WrFK6BLrRZbcQmgnh2yWf25lGUfMgqSlY9ynUS9lKwXjzHaQ3QF89NZnylqBweyzo2Fm7SDK8JlB8YMIC8ANQLl2CzzNzaY7Lqd8dhkGzfl3lbk7MA");
              log(FirebaseAuth.instance.currentUser!.email.toString());
              try {
                final userCredential = await FirebaseAuth.instance.currentUser
                    ?.linkWithCredential(GoogleAuthProvider.credential(
                        idToken:
                            "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFiZDY4NWY1ZThmYzYyZDc1ODcwNWMxZWIwZThhNzUyNGM0NzU5NzUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI0MjUxMzk2OTc4MjQtZWhqaWRscTd0MXZ2ZjNha3MyZmJrZWZ0cmhvdTg5bmsuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI0MjUxMzk2OTc4MjQtbzFlaHYzYnZpNmZzc3JmY25uczFhcGxkMmpqcmFpN3EuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTIyMjQyNTkxMjcwNjY0MzE2MjMiLCJlbWFpbCI6InpvZW1vaGFtZWQzMUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6IlpvZSBNb2hhbWVkIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BRmRadWNwX0RRREVLNXhNSGhaUGFVT3BhUFZuR1hMMlFFMmo5dUw2WG44cDJRPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IlpvZSIsImZhbWlseV9uYW1lIjoiTW9oYW1lZCIsImxvY2FsZSI6ImVuIiwiaWF0IjoxNjU3NTYyMDAyLCJleHAiOjE2NTc1NjU2MDJ9.CNRxAihXqetZbiKzH3azUU7e4FnXDvHGGPc6CDQDOR0fRxf3S3YpZbWVHB1IIpTB6e4iwIFAX_DdpBVeID5p2YtskOd8iNjQI5FfDY1TR_0uAUN5WOeKknhP-5RNlrJzO6E0vgfZLadkgt3CyvqtbTirN24AUxynslhU4opaIlV6S0gzk9o9Ai5h0c8Vhzt7yXpAbA7qG0MwWYNPA91UhLuwY91F0sj7qMz3bOadcxpPXa6kc16GBV2k5DmAEvc7G3ulLKdf_jHROR_Aw4Tc-MD5aVvh2JZz_Hc2ZY8wE4PM49vd1JuYgxekBYf1yk6nlArYcgxJiL5Fz6zZDXlAug"));
              } catch (e) {
                log(e.toString());
              }
            },
            child: Text("mantep")),
        ElevatedButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleauthService>(context, listen: false);
              provider.googleSignOut().whenComplete(() => LoginPage());
            },
            child: Text("Logout"))
      ],
    ));
  }
}
