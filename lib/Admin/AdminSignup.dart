import 'package:asms/Admin/AdminHome.dart';
import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
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
        DatabaseMethods().createAdmin(userInfoMap);
        HelperFunctions.saveAdminNameSharedPreference(usernameController.text);
        HelperFunctions.saveAdminEmailSharedPreference(emailController.text);
        HelperFunctions.saveAdminLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      });
    }
  }

  String? _chosenDepartment;
  String? _chosenCourse;

  TextEditingController universityNameController = new TextEditingController();
  TextEditingController semController = new TextEditingController();
  TextEditingController courseController = new TextEditingController();
  TextEditingController departmentController = new TextEditingController();
  final snackBar = SnackBar(content: Text('University Edited Sucessfully'));
  createUniversity() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> createdUniversityMap = {
        "University_Name": universityNameController.text,
        "Department_Name": _chosenDepartment,
        "Semester": semController.text,
        "Course_Name": _chosenCourse,
        "key": "University"
      };
      DatabaseMethods().createUniversity(createdUniversityMap);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  bool selectedDepartment = false;
  bool selectedCourse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(""),
      backgroundColor: backColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  imageBox('assets/1.png', 190),
                  textBlackBoldCenter("Sign Up", 46),
                  textBlackThin("Administrator Account", 21),
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
                  inputFieldPass(
                    hint: "Create Password",
                    icon: Icons.vpn_key,
                    textEditingController: createPasswordController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  inputFieldPass(
                    hint: "Re-enter Password",
                    icon: Icons.gpp_good,
                    textEditingController: confirmPasswordController,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  inputFieldUsername("Enter University", Icons.business,
                      context, universityNameController),
                  SizedBox(height: 20),
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
                            value: _chosenDepartment,
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
                                _chosenDepartment = value;
                                selectedDepartment = true;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  inputFieldSem("Enter Semester",
                      Icons.business_center_outlined, context, semController),
                  SizedBox(height: 20),
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
                            value: _chosenCourse,
                            elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: textBlack,
                            items: <String>['Diploma', 'Degree', 'MCA', 'BCA']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: textBlackThin(value, 15));
                            }).toList(),
                            hint: textBlackThin("Course", 16),
                            onChanged: (String? value) {
                              setState(() {
                                _chosenCourse = value;
                                selectedCourse = true;
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
                  btn(
                    name: 'Create',
                    size: 100,
                    onPressed: () {
                      if (emailController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty &&
                          createPasswordController.text.isNotEmpty &&
                          contactController.text.isNotEmpty &&
                          usernameController.text.isNotEmpty &&
                          universityNameController.text.isNotEmpty &&
                          semController.text.isNotEmpty &&
                          selectedCourse &&
                          selectedDepartment) {
                        if (createPasswordController.text ==
                            confirmPasswordController.text) {
                          setState(() {
                            createUniversity();
                            signUp();
                            print(emailController.text);
                          });
                        } else {
                          print("Password Does Not Match");
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
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
