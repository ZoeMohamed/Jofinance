import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jofinance/utils/services/google_auth_service.dart';
import 'package:jofinance/modules/transition/auth_transition.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
        child: Sizer(builder: (context, orientation, devicetype) {
          return ChangeNotifierProvider(
            create: (context) => GoogleauthService(),
            child: const MaterialApp(
                debugShowCheckedModeBanner: false, home: TransitionPage()),
          );
        }));
  }
}
