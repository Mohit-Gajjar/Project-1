import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Create%20Pages/CreateLectures.dart';
import 'package:asms/Create%20Pages/CreateStudent.dart';
import 'package:asms/Create%20Pages/CreateSubjects.dart';
import 'package:asms/Create%20Pages/CreateTeacher.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Management/ManageLectures.dart';
import 'package:asms/Management/ManageStudent.dart';
import 'package:asms/Management/ManageSubject.dart';
import 'package:asms/Management/ManageTeacher.dart';
import 'package:flutter/material.dart';

class MobileView extends StatefulWidget {
  final Size size;
  final int studentCounter;
  final int teacherCounter;
  final int lectureCounter;
  final int subjectCounter;
  final Widget universityInfo;

  MobileView({
    required this.size,
    required this.lectureCounter,
    required this.studentCounter,
    required this.subjectCounter,
    required this.teacherCounter,
    required this.universityInfo,
  });

  @override
  _MobileViewState createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return _BottomSheetContent();
      },
    );
  }

  DatabaseMethods databaseMethods = DatabaseMethods();
  bool teacherBool = false;
  bool studentBool = false;
  bool lectureBool = false;
  bool subjectBool = false;
  bool homeBool = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              managementClicker(context),
              SizedBox(
                height: 15,
              ),
              homeBool
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: widget.universityInfo),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                TotalCardMobile(
                                  counter: widget.subjectCounter,
                                  title: 'Total Subjects',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TotalCardMobile(
                                  counter: widget.lectureCounter,
                                  title: 'Total Lectures',
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                TotalCardMobile(
                                  counter: widget.studentCounter,
                                  title: 'Total Students',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TotalCardMobile(
                                  counter: widget.teacherCounter,
                                  title: 'Total Teachers',
                                ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    )
                  : LayoutBuilder(builder: (context, constraints) {
                      print(constraints.maxHeight);
                      return lectureBool
                          ? ManageLectures()
                          : studentBool
                              ? ManageStudent()
                              : subjectBool
                                  ? ManageSubject()
                                  : teacherBool
                                      ? ManageTeacher()
                                      : Center(
                                          child: CircularProgressIndicator(),
                                        );
                    }),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  teacherBool = false;
                  studentBool = false;
                  lectureBool = false;
                  subjectBool = false;
                  homeBool = true;
                });
              },
              child: CircleAvatar(
                radius: 30,
                child: Icon(Icons.home),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                _showModalBottomSheet(context);
              },
              child: Icon(Icons.add),
            ),
          ],
        ));
  }

  Column managementClicker(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  subjectBool = false;
                  teacherBool = true;
                  homeBool = false;
                  studentBool = false;
                  lectureBool = false;
                });
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 12,
                      color: teacherBool ? Colors.black45 : Colors.white,
                    )
                  ],
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 8),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.group)),
                    SizedBox(width: 10),
                    text("Teacher", 14)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  subjectBool = false;
                  teacherBool = false;
                  studentBool = true;
                  homeBool = false;
                  lectureBool = false;
                });
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 2.5,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 12,
                      color: studentBool ? Colors.black45 : Colors.white,
                    )
                  ],
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 8),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.amber,
                        )),
                    SizedBox(width: 10),
                    text("Student", 14)
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  subjectBool = true;
                  teacherBool = false;
                  homeBool = false;
                  studentBool = false;
                  lectureBool = false;
                });
              },
              child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 12,
                        color: subjectBool ? Colors.black45 : Colors.white,
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 8),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.subject,
                            color: Colors.green,
                          )),
                      SizedBox(width: 10),
                      text("Subject", 14)
                    ],
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  subjectBool = false;
                  teacherBool = false;
                  studentBool = false;
                  lectureBool = true;
                  homeBool = false;
                });
              },
              child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 12,
                        color: lectureBool ? Colors.black45 : Colors.white,
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.lightBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 8),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.cast_for_education,
                            color: Colors.lightBlue,
                          )),
                      SizedBox(width: 10),
                      text("Lecture", 14)
                    ],
                  )),
            ),
          ],
        ),
      ],
    );
  }
}

class TotalCardMobile extends StatelessWidget {
  final int counter;
  final String title;
  TotalCardMobile({
    required this.counter,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 2.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: btnColor),
        child: Center(
          child: ListTile(
              title: text(
                  counter.toString(), MediaQuery.of(context).size.width / 15),
              subtitle: text(title, MediaQuery.of(context).size.width / 30)),
        ));
  }
}

class _BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CreateStudent()));
            },
            child: textBlackBold("Create Student", 16),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CreateLectures()));
            },
            child: textBlackBold("Create Lecture", 16),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CreateTeacher()));
            },
            child: textBlackBold("Create Teacher", 16),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CreateSubject()));
            },
            child: textBlackBold("Create Subject", 16),
          ),
        ],
      ),
    );
  }
}
