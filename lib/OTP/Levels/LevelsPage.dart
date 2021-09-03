import 'package:asms/Admin/AdminLogin.dart';
import 'package:asms/Admin/AdminSignup.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Student/StudentLogin.dart';
import 'package:asms/Teacher/TeacherLogin.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:flutter/material.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({Key? key}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {

  @override
  Widget build(BuildContext context) {
 
    

    return Scaffold(
      backgroundColor: backColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            imageBox('assets/3.png', 350),
            text("Are you a", 46),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentLogin())),
                child: btn("Student", 60)),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TeacherLogin())),
                child: btn("Teacher", 60)),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdminLogin())),
                child: btn("Admin", 60)),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  text("Admin ", 20),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminSiginUp())),
                      child: text_underline("Sign Up", 20)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
