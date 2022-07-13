import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    return Scaffold(
      body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 12.h,
              ),
              Image.asset(
                "assets/appImages/register_ilust.png",
                width: 75.w,
              ),
              SizedBox(
                height: 6.2.h,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 9.w),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Inter",
                            color: const Color.fromRGBO(18, 45, 40, 1)),
                      ))),
              SizedBox(
                height: 5.h,
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
                    onPressed: () async {},
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
                  "Already have an Account ? ",
                  style: const TextStyle(
                      color: Color.fromRGBO(174, 174, 174, 1),
                      fontFamily: "Inter"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RegisterPage();
                    }));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Color.fromRGBO(8, 127, 91, 1),
                        fontFamily: "Inter",
                        decoration: TextDecoration.underline),
                  ),
                )
              ]),
            ],
          )),
    );
  }
}
