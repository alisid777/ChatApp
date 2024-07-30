import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:usertouserchat/pages/homepage.dart';
import 'package:usertouserchat/pages/loginpage.dart';
import 'package:usertouserchat/themes/light_mode.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isUserLoggedIn = false;
  Future<bool> isLoggedIn() async {
    final _auth = FirebaseAuth.instance;
    User? user = await _auth.currentUser;

    if (user != null) {
      setState(() {
        isUserLoggedIn = true;
      });
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isUserLoggedIn ? HomePage() : LoginPage(),
      theme: lightMode,
    );
  }
}
