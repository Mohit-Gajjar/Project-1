import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController emailEditingController = TextEditingController();
  final resetpass =
      SnackBar(content: Text('password reset link is sent on this email'));
  sendResetPassword() {
    AuthMethod().resetPass(emailEditingController.text).then((value) {
       ScaffoldMessenger.of(context).showSnackBar(resetpass);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("Forgot Password"),
        body: Center(
          child: Column(
            children: [
              inputFieldemail(
                  "Enter Email", Icons.email, context, emailEditingController),
              btn(
                  name: "Send",
                  size: 100,
                  onPressed: () {
                    if (emailEditingController.text.isNotEmpty) {
                      sendResetPassword();
                      // Navigator.pop(context);
                    }
                  })
            ],
          ),
        ));
  }
}
