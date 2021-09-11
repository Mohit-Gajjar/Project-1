import 'package:asms/Admin/AdminHome.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Student/StudentHome.dart';
import 'package:asms/Teacher/TeacherHome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() {
  firebaseInitiallize();
  runApp(MyApp());
}

Future<void> firebaseInitiallize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getLoggedIn();
  }

  getLoggedIn() async {
    await HelperFunctions.getAdminLoggedInSharedPreference()
        .then((value) async {
      print("Admin LoggedIn SharedPrefs== $value");
      if (value == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
      } else {}
    });

    await HelperFunctions.getStudentLoggedInSharedPreference()
        .then((value) async {
      print("Student LoggedIn SharedPrefs== $value");
      if (value == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentHome()),
        );
      } else {}
    });

    await HelperFunctions.getTeacherLoggedInSharedPreference()
        .then((value) async {
      print("Teacher LoggedIn SharedPrefs== $value");
      if (value == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeacherHome()),
        );
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Image(height: 150, image: AssetImage('assets/0.png')),
            imageBox('assets/4.png', 480),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LevelPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text("Get Started", 29),
                    Image(height: 60, image: AssetImage('assets/5.png'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
