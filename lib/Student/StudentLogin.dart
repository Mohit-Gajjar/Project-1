import 'package:asms/Constants/Constants.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/Student/StudentHome.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final wrongPassword = SnackBar(content: Text('Wrong Password'));
  final invalidEmail = SnackBar(content: Text('Invalid Email'));
  final noAccount = SnackBar(content: Text('Account Not Found'));
  final pressAgain = SnackBar(content: Text('Press Again To Login'));
  QuerySnapshot? snapshot;
  bool isLoading = false;
  String key = "";

  signIn() async {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveStudentEmailSharedPreference(emailController.text);
      if (formKey.currentState!.validate()) {
        DatabaseMethods().getStudentBy(emailController.text).then((val) {
          snapshot = val;
          HelperFunctions.saveStudentNameSharedPreference(
              snapshot!.docs[0]["StudentName"]);
          key = snapshot!.docs[0]["role"];
          if (key == "Student") {
            ScaffoldMessenger.of(context).showSnackBar(pressAgain);
          }
        });
        if (key == "Student") {
          try {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text)
                .then((val) {
              HelperFunctions.saveStudentLoggedInSharedPreference(true);
              print("Student Login Shared preff");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => StudentHome()));
            });
          } on FirebaseAuthException catch (e) {
            print(e.toString());
            if (e.code == "wrong-password") {
              ScaffoldMessenger.of(context).showSnackBar(wrongPassword);
            } else if (e.code == "user-not-found") {
              ScaffoldMessenger.of(context).showSnackBar(noAccount);
            } else if (e.code == "invalid-email") {
              ScaffoldMessenger.of(context).showSnackBar(invalidEmail);
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(""),
      backgroundColor: backColor,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                imageBox('assets/1.png', 350),
                textBlackBold("Student Login", 30),
                SizedBox(
                  height: 20,
                ),
                inputFieldemail(
                    "Enter Email", Icons.person, context, emailController),
                SizedBox(
                  height: 20,
                ),
                inputFieldPass(
                  hint: 'Enter Password',
                  icon: Icons.vpn_key,
                  textEditingController: passwordController,
                ),
                SizedBox(
                  height: 20,
                ),
                btn(
                  name: 'Login',
                  size: 100,
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      signIn();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
