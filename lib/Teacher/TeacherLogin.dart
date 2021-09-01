import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/ForgotPassword.dart';
import 'package:asms/Teacher/TeacherHome.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:flutter/material.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);

  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            imageBox('assets/1.png', 350),
            text("Teacher Login", 30),
            SizedBox(
              height: 20,
            ),
            inputFieldUsername("Enter Username", Icons.person, context,usernameController),
            SizedBox(
              height: 20,
            ),
            inputFieldPass("Enter Password", Icons.vpn_key, context,passwordController),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPass())),
                      child: text_underline("Forgot Password?", 16)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TeacherHome())),
                child: btn("Login", 100))
          ],
        ),
      ),
    );
  }
}
