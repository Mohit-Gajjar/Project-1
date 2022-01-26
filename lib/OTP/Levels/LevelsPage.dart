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
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              imageBox('assets/3.png', 350),
              textBlackBoldCenter("Are you a", 46),
              SizedBox(
                height: 20,
              ),
              btn(
                name: 'Student',
                size: 300,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StudentLogin()));
                },
              ),
              SizedBox(
                height: 15,
              ),
              btn(
                name: 'Teacher',
                size: 300,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeacherLogin()));
                },
              ),
              SizedBox(
                height: 15,
              ),
              btn(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminLogin()));
                },
                name: 'Admin',
                size: 300,
              ),
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
      ),
    );
  }
}
