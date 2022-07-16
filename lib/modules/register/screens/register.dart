import 'package:flutter/material.dart';
import 'package:jofinance/modules/login/screens/login.dart';
import 'package:jofinance/utils/services/email_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool? _passwordvisible;
  bool? _passconfirmvisible;
  // Form controller
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _usernamecontroller = TextEditingController();
  final _passconfirmcontroller = TextEditingController();

  @override
  void initState() {
    _passwordvisible = false;
    _passconfirmvisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _usernamecontroller.dispose();
    _passconfirmcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 11.2.h,
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
                  height: 4.2.h,
                ),
                Wrap(children: [
                  Padding(
                    padding: EdgeInsets.only(right: 1.5.w),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(80.w, 80)),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _usernamecontroller,
                        decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(8, 127, 91, 1))),
                            prefixIcon:
                                Icon(FluentIcons.book_contacts_20_regular),
                            hintText: "Username",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(119, 119, 119, 0.8))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 1.5.w),
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
                    padding: EdgeInsets.only(right: 1.5.w),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(80.w, 80)),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _passwordcontroller,
                        obscureText: !_passwordvisible!,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(8, 127, 91, 1))),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordvisible = !_passwordvisible!;
                                  });
                                },
                                icon: _passwordvisible ?? false
                                    ? const Icon(FluentIcons.eye_16_regular)
                                    : const Icon(
                                        FluentIcons.eye_off_16_regular)),
                            prefixIcon:
                                const Icon(FluentIcons.lock_closed_16_regular),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(119, 119, 119, 0.8))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 1.5.w),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(80.w, 80)),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _passconfirmcontroller,
                        obscureText: !_passconfirmvisible!,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(8, 127, 91, 1))),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passconfirmvisible = !_passconfirmvisible!;
                                  });
                                },
                                icon: _passconfirmvisible ?? false
                                    ? const Icon(FluentIcons.eye_16_regular)
                                    : const Icon(
                                        FluentIcons.eye_off_16_regular)),
                            prefixIcon: const Icon(
                                FluentIcons.shield_keyhole_16_regular),
                            hintText: "Confirm Password",
                            hintStyle: const TextStyle(
                                color: Color.fromRGBO(119, 119, 119, 0.8))),
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 1.8.h,
                ),
                SizedBox(
                  height: 5.2.h,
                  width: 80.w,
                  child: ElevatedButton(
                      onPressed: () async {
                        final provider = Provider.of<EmailAuthService>(context,
                            listen: false);

                        provider.registerUsingEmailPassword(
                            password: _passwordcontroller.text,
                            email: _emailcontroller.text,
                            username: _usernamecontroller.text);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontFamily: "Inter", fontSize: 15.sp),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(8, 127, 91, 1))),
                ),
                SizedBox(
                  height: 2.7.h,
                ),
                Row(children: [
                  SizedBox(
                    width: 19.5.w,
                  ),
                  const Text(
                    "Already have an Account ? ",
                    style: TextStyle(
                        color: Color.fromRGBO(174, 174, 174, 1),
                        fontFamily: "Inter"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const Text(
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
      ),
    );
  }
}
