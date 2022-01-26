import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';

class CreateTeacher extends StatefulWidget {
  const CreateTeacher({Key? key}) : super(key: key);

  @override
  _CreateTeacherState createState() => _CreateTeacherState();
}

class _CreateTeacherState extends State<CreateTeacher> {
  @override
  void initState() {
    super.initState();
  }

  generateId() async {
    id = await nanoid(10);
    print(id);
  }

  String postfix = "@asmsgroup.edu.in";
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController subjectController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  String? _chosenValue;
  String id = "";
  final snackBar = SnackBar(content: Text('Teacher Created Sucessfully'));
  createTeacher() {
    if (formKey.currentState!.validate()) {
      generateId();
      Map<String, dynamic> createdTeacherInfo = {
        "name": usernameController.text,
        "email": emailController.text,
        "LoginEmail":
            usernameController.text.replaceAll(" ", "").toLowerCase() + postfix,
        "contact": contactController.text,
        "assigned_subject": subjectController.text,
        "assigned_semester": "HardCoded Value = sem5",
        "assigned_department": _chosenValue,
        "role": "Teacher",
        "documentID": id
      };
      AuthMethod()
          .createTeacherWithEmailPassword(
              usernameController.text.replaceAll(" ", "").toLowerCase() +
                  postfix,
              passwordController.text)
          .then((value) {
        DatabaseMethods().createTeacherData(createdTeacherInfo, id);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(value.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: textBlackBold("Add Teacher", 16),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      contactController.clear();
                      passwordController.clear();
                      emailController.clear();
                      subjectController.clear();
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
        body: Center(
          child: SingleChildScrollView(
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
                    inputFieldUsername("Assign Subject", Icons.subject_outlined,
                        context, subjectController),
                    SizedBox(
                      height: 20,
                    ),
                    inputFieldContact("Enter Contact", Icons.phone, context,
                        contactController),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: textBlack),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Icon(Icons.business, color: textBlack),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButton<String>(
                              dropdownColor: Colors.blue,
                              value: _chosenValue,
                              //elevation: 5,
                              style: TextStyle(color: Colors.black),
                              iconEnabledColor: textBlack,
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
                                    child: textBlackThin(value, 15));
                              }).toList(),
                              hint: textBlackThin("Department", 16),
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
                    inputFieldPass(
                      hint: 'Enter Password',
                      icon: Icons.vpn_key,
                      textEditingController: passwordController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textBlackBold(
                        "Login Email: " +
                            usernameController.text
                                .replaceAll(" ", "")
                                .toLowerCase() +
                            postfix,
                        16),
                    SizedBox(
                      height: 20,
                    ),
                    btn(
                      name: 'Create',
                      size: 100,
                      onPressed: () {
                        if (usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            contactController.text.isNotEmpty &&
                            subjectController.text.isNotEmpty &&
                            emailController.text.isNotEmpty) {
                          createTeacher();
                          print("Teacher Is Added");
                          contactController.clear();
                          passwordController.clear();
                          emailController.clear();
                          subjectController.clear();
                          usernameController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
