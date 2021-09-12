// ignore_for_file: must_be_immutable

import 'package:asms/Admin/AdminHome.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  String email = "";
  EmailVerification({Key? key, required this.email}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  User? user;
  final _auth = FirebaseAuth.instance;
  Future<void> checkEmailVerified() async {
    user = _auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminHome()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  final snackBar = SnackBar(content: Text('Email Not Verified'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageBox('assets/2.png', 300),
          text("Vetification email is sent on", 16),
          text(widget.email, 14),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
              onTap: () {
                //   bool check;
                //   check = checkEmailVerified() as bool;
                //   if (check == false) {
                //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //   }
                checkEmailVerified();
              },
              child: btn("Verified", 150))
        ],
      ),
    );
  }
}
