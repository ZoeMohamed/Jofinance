import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jofinance/utils/services/google_auth_service.dart';
import 'package:jofinance/modules/login/screens/login.dart';
import 'package:jofinance/utils/services/firestore_service.dart';
import 'package:sizer/sizer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'dart:developer';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernamecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 59,
          ),
          Wrap(children: [
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(80.w, 80)),
                child: TextFormField(
                  controller: _usernamecontroller,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(8, 127, 91, 1))),
                      prefixIcon: Icon(FluentIcons.mail_16_regular),
                      hintText: "Username",
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(119, 119, 119, 0.8))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(80.w, 80)),
                child: TextFormField(
                  controller: _emailcontroller,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(8, 127, 91, 1))),
                      prefixIcon: Icon(FluentIcons.mail_16_regular),
                      hintText: "Email",
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(119, 119, 119, 0.8))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(80.w, 80)),
                child: TextFormField(
                  controller: _passwordcontroller,
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(8, 127, 91, 1))),
                      prefixIcon: Icon(FluentIcons.mail_16_regular),
                      hintText: "Password",
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(119, 119, 119, 0.8))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 5),
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(Size(80.w, 80)),
                child: TextFormField(
                  controller: _confirmpasscontroller,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(8, 127, 91, 1))),
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(FluentIcons.eye_off_16_regular)),
                      prefixIcon:
                          const Icon(FluentIcons.lock_closed_16_regular),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(
                          color: const Color.fromRGBO(119, 119, 119, 0.8))),
                ),
              ),
            ),
          ]),
          ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _emailcontroller.text,
                      password: _passwordcontroller.text);
                } catch (e) {}
              },
              child: Text("Register")),
          ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleauthService>(context, listen: false);

                provider.googleSignOut().then((value) => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    })));
              },
              child: Text("Logout")),
          ElevatedButton(onPressed: () async {}, child: Text("mantep"))
        ],
      ),
    );
  }
}
