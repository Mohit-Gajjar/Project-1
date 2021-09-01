import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

class CreateStudent extends StatefulWidget {
  const CreateStudent({Key? key}) : super(key: key);

  @override
  _CreateStudentState createState() => _CreateStudentState();
}


class _CreateStudentState extends State<CreateStudent> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController enrollController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController departmentController = new TextEditingController();
  TextEditingController semController = new TextEditingController();

  String? _chosenValue;

  createStudent() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> createdStudentInfo = {
        "StudentName": usernameController.text,
        "StudentEnrollmentNo": enrollController.text,
        "StudentContactNo": contactController.text,
        "StudentEmail": emailController.text,
        "DateOfBirth": "",
        "Gender": "",
        "ParentsContactNo": "",
        "ParentsEmail": "",
        "TimeOfCreationOfStudent": DateTime.now(),
        "role": "Student",
        "Department": _chosenValue,
        "Semester": semController.text
      };
      AuthMethod()
          .createStudentWithEmailPassword(
              emailController.text, passwordController.text)
          .then((value) {
        DatabaseMethods().createStudentData(createdStudentInfo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: text("Add Student", 16),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      contactController.clear();
                      passwordController.clear();
                      emailController.clear();
                      enrollController.clear();
                      usernameController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: textColor,
                    size: 30,
                  ))
            ]),
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
                  inputFieldUsername("Enter Username", Icons.person, context,
                      usernameController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldEnroll("Enter Enrollment No", Icons.engineering,
                      context, enrollController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldContact(
                      "Enter Contact", Icons.phone, context, contactController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldSem(
                      "Enter Semester", Icons.class_, context, semController),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: textColor),
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        children: [
                          Icon(Icons.business, color: textColor),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                          dropdownColor: btnColor,
                            value: _chosenValue,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: textColor,
                            items: <String>[
                              'Chemical',
                              'Computer',
                              'Mechinical',
                              'Civil',
                              'BioMedical',
                              'Enviroment',
                              
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: text(value, 15)
                              );
                            }).toList(),
                            hint:text("Department", 16),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldemail(
                      "Enter Email", Icons.mail, context, emailController),
                  SizedBox(
                    height: 20,
                  ),
                  inputFieldPass("Enter Password", Icons.vpn_key, context,
                      passwordController),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        if (usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            enrollController.text.isNotEmpty &&
                            emailController.text.isNotEmpty) {
                          setState(() {
                            createStudent();
                            print("Student Is Added");
                            contactController.clear();
                            passwordController.clear();
                            emailController.clear();
                            enrollController.clear();
                            usernameController.clear();
                          });
                        }
                      },
                      child: btn("Create", 100)),
                ],
              ),
            ),
          ),
        ));
  }
}
