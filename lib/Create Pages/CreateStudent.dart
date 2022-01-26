import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/async.dart';

class CreateStudent extends StatefulWidget {
  const CreateStudent({Key? key}) : super(key: key);

  @override
  _CreateStudentState createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  final formKey = GlobalKey<FormState>();
  String adminName = '';
  String adminEmail = '';
  String id = "";
  String postfix = "@asmsgroup.edu.in";
  TextEditingController usernameController = new TextEditingController();
  TextEditingController enrollController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController departmentController = new TextEditingController();
  TextEditingController semController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    getAdmin();
   
  }

  generateId() async {
    id = await nanoid(10);
    print(id);
  }

  getAdmin() async {
    adminName = (await HelperFunctions.getAdminNameSharedPreference())!;
    adminEmail = (await HelperFunctions.getAdminEmailSharedPreference())!;
  }

  final snackBar = SnackBar(content: Text('Student Created Sucessfully'));
  String? _chosenValue;
  createStudent() {
    if (formKey.currentState!.validate()) {
       generateId();
      Map<String, dynamic> createdStudentInfo = {
        "StudentName": usernameController.text,
        "StudentEnrollmentNo": enrollController.text,
        "StudentContactNo": contactController.text,
        "StudentEmail": emailController.text,
        "LoginEmail": enrollController.text + postfix,
        "DateOfBirth": "",
        "Gender": "",
        "ParentsContactNo": "",
        "ParentsEmail": "",
        "TimeOfCreationOfStudent": DateTime.now(),
        "role": "Student",
        "Department": _chosenValue,
        "Semester": semController.text,
        "documentID": id,
      };
      AuthMethod()
          .createStudentWithEmailPassword(
              enrollController.text + postfix, passwordController.text)
          .then((value) {
        DatabaseMethods().createStudentData(createdStudentInfo, id);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: textBlackBold("Add Student", 16),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
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
                    inputFieldContact("Enter Contact", Icons.phone, context,
                        contactController),
                    SizedBox(
                      height: 20,
                    ),
                    inputFieldSem(
                        "Enter Semester", Icons.class_, context, semController),
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
                              elevation: 5,
                              style: TextStyle(color: Colors.white),
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
                    textBlackBold("Login Email: " + enrollController.text + postfix, 16),
                    btn(
                      onPressed: () {
                        if (usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            enrollController.text.isNotEmpty &&
                            emailController.text.isNotEmpty) {
                          createStudent();
                          print("Student Is Added");
                          contactController.clear();
                          passwordController.clear();
                          emailController.clear();
                          enrollController.clear();
                          usernameController.clear();
                        }
                      },
                      name: 'Create',
                      size: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
