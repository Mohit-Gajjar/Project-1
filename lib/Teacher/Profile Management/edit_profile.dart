import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

class EditTeacherProfile extends StatefulWidget {
  final String email;
  final String id;
  EditTeacherProfile({Key? key, required this.email, required this.id})
      : super(key: key);

  @override
  _EditTeacherProfileState createState() => _EditTeacherProfileState();
}

class _EditTeacherProfileState extends State<EditTeacherProfile> {
  TextEditingController contactController = new TextEditingController();
  TextEditingController techerEmailController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController parentsContactController = new TextEditingController();
  TextEditingController parentsEmailController = new TextEditingController();
  final snackBar = SnackBar(content: Text('Profile Updated Sucessfully'));

  final formKey = GlobalKey<FormState>();
  editStudent() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> editTeacherData = {
        "contact": contactController.text,
        "email": techerEmailController.text,
      };
      DatabaseMethods()
          .editTeacherData(editTeacherData, widget.id)
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
                        Icons.email_outlined, context, techerEmailController),
                    SizedBox(
                      height: 20,
                    ),
                    btn(
                      onPressed: () {
                        if (contactController.text.isNotEmpty ||
                            techerEmailController.text.isNotEmpty) {
                          setState(() {
                            editStudent();
                          });
                        }
                      },
                      name: 'Submit',
                      size: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
