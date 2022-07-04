import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jofinance/utils/services/google_auth_service.dart';
import 'package:jofinance/modules/dashboard/screens/main_page.dart';
import 'package:jofinance/modules/register/screens/register.dart';
import 'package:sizer/sizer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _passwordvisible;
  // Form controller
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  @override
  void initState() {
    _passwordvisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/appImages/green_circle.png",
                  width: 11.h,
                  height: 11.h,
                )),
            SizedBox(
              height: 5.h,
            ),
            Image.asset(
              "assets/appImages/vault_image.png",
              width: 82.w,
            ),
            SizedBox(
              height: 6.2.h,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.w),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Inter",
                          color: const Color.fromRGBO(18, 45, 40, 1)),
                    ))),
            SizedBox(
              height: 4.h,
            ),
            Wrap(children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(80.w, 80)),
                  child: TextFormField(
                    controller: _emailcontroller,
                    decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(8, 127, 91, 1))),
                        prefixIcon: Icon(FluentIcons.mail_16_regular),
                        hintText: "Email",
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(119, 119, 119, 0.8))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(80.w, 80)),
                  child: TextFormField(
                    controller: _passwordcontroller,
                    obscureText: !_passwordvisible!,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(8, 127, 91, 1))),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordvisible = !_passwordvisible!;
                              });
                            },
                            icon: _passwordvisible ?? false
                                ? Icon(FluentIcons.eye_16_regular)
                                : Icon(FluentIcons.eye_off_16_regular)),
                        prefixIcon:
                            const Icon(FluentIcons.lock_closed_16_regular),
                        hintText: "Password",
                        hintStyle: TextStyle(
                            color: const Color.fromRGBO(119, 119, 119, 0.8))),
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 2.4.h,
            ),
            SizedBox(
              height: 45,
              width: 330,
              child: ElevatedButton(
                  onPressed: () async {
                    setState(() {});
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailcontroller.text,
                              password: _passwordcontroller.text);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (cntxt) {
                        return MainPage();
                      }));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                      } else if (e.code == 'wrong-password') {}
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontFamily: "Inter", fontSize: 15.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(8, 127, 91, 1))),
            ),
            SizedBox(
              height: 19,
            ),
            Row(children: [
              SizedBox(
                width: 90,
              ),
              const Text(
                "Don't have an account ? ",
                style: const TextStyle(
                    color: Color.fromRGBO(174, 174, 174, 1),
                    fontFamily: "Inter"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterPage();
                  }));
                },
                child: Text(
                  "Register",
                  style: TextStyle(
                      color: Color.fromRGBO(8, 127, 91, 1),
                      fontFamily: "Inter",
                      decoration: TextDecoration.underline),
                ),
              )
            ]),
            SizedBox(
              height: 18,
            ),
            Text(
              "Or Login with ",
              style: TextStyle(
                  fontSize: 8.sp,
                  color: Color.fromRGBO(174, 174, 174, 1),
                  fontFamily: "Inter"),
            ),
            SizedBox(
              height: 17,
            ),
            GestureDetector(
              onTap: () {
                final provider =
                    Provider.of<GoogleauthService>(context, listen: false);

                provider.googleSignIn();
              },
              child: Image.asset(
                "assets/appImages/google_logo.png",
                width: 50,
                height: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}