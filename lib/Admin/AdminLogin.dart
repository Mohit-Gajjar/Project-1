import 'package:asms/Admin/AdminHome.dart';
import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final wrongPassword = SnackBar(content: Text('Wrong Password'));
  final invalidEmail = SnackBar(content: Text('Invalid Email'));
  final noAccount = SnackBar(content: Text('Account Not Found'));
  final pressAgain = SnackBar(content: Text('Press Again To Login'));

  final formKey = GlobalKey<FormState>();
  QuerySnapshot? snapshot;
  final resetpass =
      SnackBar(content: Text('Password reset link is sent on this email'));
  String key = "";
  signIn() async {

    if (formKey.currentState!.validate()) {
      DatabaseMethods().getAdminBy(emailController.text).then((val) {
        snapshot = val;
        HelperFunctions.saveAdminNameSharedPreference(
            snapshot!.docs[0]["username"]);
        key = snapshot!.docs[0]["role"];
         if (key == "Admin"){
           ScaffoldMessenger.of(context).showSnackBar(pressAgain);
        }
      });
      HelperFunctions.saveAdminEmailSharedPreference(emailController.text);
      if (key == "Admin") {

        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((val) {
            HelperFunctions.saveAdminLoggedInSharedPreference(true);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AdminHome()));
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

  sendResetPassword() {
    AuthMethod().resetPass(emailController.text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(resetpass);
    });
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
                  height: 20,
                ),
                imageBox('assets/1.png', 300),
                textBlackBoldCenter("Admin Login", 30),
                SizedBox(
                  height: 20,
                ),
                inputFieldemail(
                    "Enter Email", Icons.person, context, emailController),
                SizedBox(
                  height: 20,
                ),
                inputFieldPass(
                    hint: "Enter Password",
                    icon: Icons.vpn_key,
                    textEditingController: passwordController),
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
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () => sendResetPassword(),
                          child: text_underline("Forgot Password?", 16)),
                    ],
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
