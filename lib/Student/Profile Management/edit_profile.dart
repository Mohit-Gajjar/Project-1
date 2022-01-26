import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileEdit extends StatefulWidget {
  String email = "";
  String id = "";
  ProfileEdit({Key? key, required this.email, required this.id})
      : super(key: key);
  @override
  ProfileEditState createState() => ProfileEditState();
}

class ProfileEditState extends State<ProfileEdit> {
  TextEditingController contactController = new TextEditingController();
  TextEditingController studentEmailController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController parentsContactController = new TextEditingController();
  TextEditingController parentsEmailController = new TextEditingController();
  final snackBar = SnackBar(content: Text('Profile Updated Sucessfully'));

  final formKey = GlobalKey<FormState>();
  editStudent() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> editStudentData = {
        "StudentContactNo": contactController.text,
        "StudentEmail": studentEmailController.text,
        "DateOfBirth": dobController.text,
        "Gender": genderController.text,
        "ParentsContactNo": parentsContactController.text,
        "ParentsEmail": parentsEmailController.text,
      };
      DatabaseMethods()
          .editStudentData(editStudentData, widget.id)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Edit Profile"),
      backgroundColor: backColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  inputFieldContact("Edit Contact Number", Icons.person,
                      context, contactController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldUsername("Edit Email Addresss",
                      Icons.email_outlined, context, studentEmailController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldContact("Enter Date Of Birth",
                      Icons.date_range_outlined, context, dobController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldUsername("Enter Gender", Icons.face_outlined,
                      context, genderController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldContact(
                      "Enter Parents Contact",
                      Icons.contact_phone_outlined,
                      context,
                      parentsContactController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldUsername("Enter Parents Email",
                      Icons.email_outlined, context, parentsEmailController),
                  SizedBox(
                    height: 20,
                  ),
                  btn(
                    onPressed: () {
                      if (contactController.text.isNotEmpty ||
                          parentsContactController.text.isNotEmpty ||
                          parentsEmailController.text.isNotEmpty ||
                          genderController.text.isNotEmpty ||
                          studentEmailController.text.isNotEmpty ||
                          dobController.text.isNotEmpty) {
                        setState(() {
                          editStudent();
                        });
                      }
                    },
                    name: 'Create',
                    size: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
