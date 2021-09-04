import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/ForgotPassword.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/Student/StudentHome.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController enrollController = new TextEditingController();
  String email = "";
  QuerySnapshot? snapshot;
  signIn() async {
    HelperFunctions.saveStudentEmailSharedPreference(emailController.text);
    if (formKey.currentState!.validate()) {
      DatabaseMethods().getStudentBy(emailController.text).then((val) {
        snapshot = val;
        HelperFunctions.saveStudentNameSharedPreference(
            snapshot!.docs[0]["StudentName"]);
      });
      AuthMethod()
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveAdminLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentHome(
                      // email: emailController.text,
                      // username: "Name",
                      )));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                imageBox('assets/1.png', 350),
                text("Student Login", 30),
                SizedBox(
                  height: 20,
                ),
                inputFieldemail(
                    "Enter Email", Icons.person, context, emailController),
                SizedBox(
                  height: 20,
                ),
                inputFieldPass("Enter Password", Icons.vpn_key, context,
                    passwordController),
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
                    onTap: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        signIn();
                        print("Student Sigin working");
                      }
                    },
                    child: btn("Login", 100))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
