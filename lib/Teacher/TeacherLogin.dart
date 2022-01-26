import 'package:asms/Constants/Constants.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/Teacher/TeacherHome.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);

  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final wrongPassword = SnackBar(content: Text('Wrong Password'));
  final invalidEmail = SnackBar(content: Text('Invalid Email'));
  final pressAgain = SnackBar(content: Text('Press Again To Login'));
  final noAccount = SnackBar(content: Text('Account Not Found'));
  final formKey = GlobalKey<FormState>();
  QuerySnapshot? snapshot;
  String key = "";
  signIn() async {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveTeacherEmailSharedPreference(emailController.text);
      DatabaseMethods().getTeacherBy(emailController.text).then((val) {
        snapshot = val;
        HelperFunctions.saveTeacherNameSharedPreference(
            snapshot!.docs[0]["name"]);
        key = snapshot!.docs[0]["role"];
        if (key == "Teacher"){
           ScaffoldMessenger.of(context).showSnackBar(pressAgain);
        }
      });
      if (key == "Teacher") {
       

        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((val) {
            HelperFunctions.saveTeacherLoggedInSharedPreference(true);
            print("AdminLogin Shared preff");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => TeacherHome()));
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
                text("Teacher Login", 30),
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
                GestureDetector(
                  onTap: () {},
                  child: btn(
                    name: 'Login',
                    size: 100,
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        signIn();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
