import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:asms/Admin/AdminHome.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';

import 'package:asms/Student/StudentHome.dart';
import 'package:asms/Teacher/TeacherHome.dart';
import 'package:asms/getStarted.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_radar/flutter_radar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  Radar.initialize("prj_test_sk_a0eaf6bc87cf3c6ea6f432766f2729d5aaee7df6");
 
  navigateToHome();
  runApp(MyApp());
}

bool teacher = false;
bool admin = false;
bool student = false;

navigateToHome() async {
 
  await HelperFunctions.getAdminLoggedInSharedPreference().then((value) async {
    print("Admin LoggedIn SharedPrefs: $value");
    if (value == true) {
      admin = true;
    } else {}
  });

  await HelperFunctions.getStudentLoggedInSharedPreference()
      .then((value) async {
   
    if (value == true) {
      admin = true;
    } else {}
  });

  await HelperFunctions.getTeacherLoggedInSharedPreference()
      .then((value) async {
   
    if (value == true) {
      teacher = true;
    } else {}
  });
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
          splash: Center(
              child: Image(
            image: AssetImage('assets/splash.png'),
          )),
          nextScreen: admin
              ? AdminHome()
              : teacher
                  ? TeacherHome()
                  : student
                      ? StudentHome()
                      : GetStarted()),
    );
  }
}
