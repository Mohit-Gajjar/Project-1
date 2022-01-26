import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Create%20Pages/CreateLectures.dart';
import 'package:asms/Create%20Pages/CreateStudent.dart';
import 'package:asms/Create%20Pages/CreateSubjects.dart';
import 'package:asms/Create%20Pages/CreateTeacher.dart';
import 'package:asms/Management/ManageLectures.dart';
import 'package:asms/Management/ManageStudent.dart';
import 'package:asms/Management/ManageSubject.dart';
import 'package:asms/Management/ManageTeacher.dart';
import 'package:flutter/material.dart';

class DesktopView extends StatefulWidget {
  final Size size;
  final int studentCounter;
  final int teacherCounter;
  final int lectureCounter;
  final int subjectCounter;
  final Widget universityInfo;

  DesktopView({
    required this.size,
    required this.lectureCounter,
    required this.studentCounter,
    required this.subjectCounter,
    required this.teacherCounter,
    required this.universityInfo,
  });
  @override
  _DesktopViewState createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  bool teacherBool = false;
  bool studentBool = false;
  bool lectureBool = false;
  bool subjectBool = false;
  bool homeBool = true;
  bool creatingGeoFence = false;
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return _BottomSheetContent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SingleChildScrollView(
        child: Column(
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
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TotalCards(
                studentCounter: widget.studentCounter,
                teacherCounter: widget.teacherCounter,
                subjectCounter: widget.subjectCounter,
                lectureCounter: widget.lectureCounter,
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  managementClicker(context),
                  SizedBox(width: 20),
                  widget.universityInfo,
                  SizedBox(width: 20),
                  Container(
                    width: 300,
                  )
                ],
              ),
              SizedBox(width: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                child: lectureBool
                    ? ManageLectures()
                    : studentBool
                        ? ManageStudent()
                        : subjectBool
                            ? ManageSubject()
                            : teacherBool
                                ? ManageTeacher()
                                : Center(
                                    child: Container(),
                                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column managementClicker(BuildContext context) {
    return Column(
      children: [
        Row(
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
                height: MediaQuery.of(context).size.width / 17,
                width: MediaQuery.of(context).size.width / 12,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 12,
                      color: teacherBool ? Colors.black45 : Colors.white,
                    )
                  ],
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 70,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.group,
                          size: MediaQuery.of(context).size.width / 70,
                        )),
                    SizedBox(height: 5),
                    text("Teacher", MediaQuery.of(context).size.width / 100)
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
                height: MediaQuery.of(context).size.width / 17,
                width: MediaQuery.of(context).size.width / 12,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 12,
                      color: studentBool ? Colors.black45 : Colors.white,
                    )
                  ],
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.amber,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 70,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.amber,
                          size: MediaQuery.of(context).size.width / 70,
                        )),
                    SizedBox(height: 5),
                    text("Student", MediaQuery.of(context).size.width / 100)
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
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
                height: MediaQuery.of(context).size.width / 17,
                width: MediaQuery.of(context).size.width / 12,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 12,
                      color: subjectBool ? Colors.black45 : Colors.white,
                    )
                  ],
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 70,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.subject,
                          color: Colors.green,
                          size: MediaQuery.of(context).size.width / 70,
                        )),
                    SizedBox(height: 5),
                    text("Subject", MediaQuery.of(context).size.width / 100)
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
                  studentBool = false;
                  lectureBool = true;
                  homeBool = false;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.width / 17,
                width: MediaQuery.of(context).size.width / 12,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 12,
                      color: lectureBool ? Colors.black45 : Colors.white,
                    )
                  ],
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blueGrey,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: MediaQuery.of(context).size.width / 70,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.cast_for_education,
                          color: Colors.blueGrey,
                          size: MediaQuery.of(context).size.width / 70,
                        )),
                    SizedBox(height: 5),
                    text("Lecture", MediaQuery.of(context).size.width / 100)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CreateStudent()));
            },
            title: textBlackBold("Create Student", 16),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CreateLectures()));
            },
            title: textBlackBold("Create Lecture", 16),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CreateTeacher()));
            },
            title: textBlackBold("Create Teacher", 16),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CreateSubject()));
            },
            title: textBlackBold("Create Subject", 16),
          ),
        ],
      ),
    );
  }
}
