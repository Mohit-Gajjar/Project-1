import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/OTP/Levels/EmailVerification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminSiginUp extends StatefulWidget {
  const AdminSiginUp({Key? key}) : super(key: key);

  @override
  _AdminSiginUpState createState() => _AdminSiginUpState();
}

class _AdminSiginUpState extends State<AdminSiginUp> {
  final formKey = GlobalKey<FormState>();
  AuthMethod authMethod = new AuthMethod();
  bool isLoading = false;
  QuerySnapshot? userInfo;
  TextEditingController emailController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController createPasswordController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();

  signUp() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userInfoMap = {
        "username": usernameController.text,
        "email": emailController.text,
        "contactNo": contactController.text,
        "dateOfAccountCreation": DateTime.now(),
        "role": "Admin"
      };
      setState(() {
        isLoading = true;
      });
      authMethod
          .adminSignUpWithEmailAndPassword(
              emailController.text, confirmPasswordController.text)
          .then((value) {
        DatabaseMethods().uploadUserInfo(userInfoMap);
        HelperFunctions.saveAdminNameSharedPreference(usernameController.text);
        HelperFunctions.saveAdminEmailSharedPreference(emailController.text);
        HelperFunctions.saveAdminLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EmailVerification(
                      email: emailController.text,
                    )));
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                imageBox('assets/1.png', 190),
                text("Sign Up", 46),
                text("Administrator Account", 21),
                SizedBox(
                  height: 10,
                ),
                inputFieldUsername("Create Username", Icons.person, context,
                    usernameController),
                SizedBox(
                  height: 10,
                ),
                inputFieldemail(
                    "Enter Email", Icons.email, context, emailController),
                SizedBox(
                  height: 10,
                ),
                inputFieldContact("Enter Contact No", Icons.phone, context,
                    contactController),
                SizedBox(
                  height: 10,
                ),
                inputFieldPass("Create Password", Icons.vpn_key, context,
                    createPasswordController),
                SizedBox(
                  height: 10,
                ),
                inputFieldPass("Re-enter Password", Icons.gpp_good, context,
                    confirmPasswordController),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                      if (emailController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty &&
                          createPasswordController.text.isNotEmpty &&
                          contactController.text.isNotEmpty &&
                          usernameController.text.isNotEmpty) {
                        if (createPasswordController.text ==
                            confirmPasswordController.text) {
                          setState(() {
                            signUp();
                            print(emailController.text);
                          });
                        } else {
                          print("Password Does Not Match");
                        }
                      }
                    },
                    child: btn("Create", 80))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
