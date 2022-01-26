import 'package:asms/Constants/Constants.dart';
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

class TabletView extends StatefulWidget {
  final Size size;
  final int studentcounter;
  final int teacherCounter;
  final int lectureCounter;
  final int subjectCounter;
  final Widget universityInfo;

  TabletView({
    required this.size,
    required this.lectureCounter,
    required this.studentcounter,
    required this.subjectCounter,
    required this.teacherCounter,
    required this.universityInfo,
  });

  @override
  _TabletViewState createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  bool teacherBool = false;
  bool studentBool = false;
  bool lectureBool = false;
  bool subjectBool = false;
  bool homeBool = true;
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
        child: Column(
          children: [
            TotalUsers(
                widget1: widget,
                widget2: widget,
                widget3: widget,
                widget4: widget),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    managementClicker(context),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: widget.universityInfo)
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            lectureBool
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
          ],
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
                height: MediaQuery.of(context).size.width / 9,
                width: MediaQuery.of(context).size.width / 6,
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
                        radius: MediaQuery.of(context).size.width / 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.group,
                          size: MediaQuery.of(context).size.width / 40,
                        )),
                    SizedBox(height: 5),
                    text("Teacher", MediaQuery.of(context).size.width / 60)
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
                height: MediaQuery.of(context).size.width / 9,
                width: MediaQuery.of(context).size.width / 6,
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
                        radius: MediaQuery.of(context).size.width / 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.amber,
                          size: MediaQuery.of(context).size.width / 40,
                        )),
                    SizedBox(height: 5),
                    text("Student", MediaQuery.of(context).size.width / 60)
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
                height: MediaQuery.of(context).size.width / 9,
                width: MediaQuery.of(context).size.width / 6,
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
                        radius: MediaQuery.of(context).size.width / 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.subject,
                          color: Colors.green,
                          size: MediaQuery.of(context).size.width / 40,
                        )),
                    SizedBox(height: 5),
                    text("Subject", MediaQuery.of(context).size.width / 60)
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
                height: MediaQuery.of(context).size.width / 9,
                width: MediaQuery.of(context).size.width / 6,
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
                        radius: MediaQuery.of(context).size.width / 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.cast_for_education,
                          color: Colors.blueGrey,
                          size: MediaQuery.of(context).size.width / 40,
                        )),
                    SizedBox(height: 5),
                    text("Lecture", MediaQuery.of(context).size.width / 60)
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

class TotalUsers extends StatelessWidget {
  const TotalUsers({
    Key? key,
    required this.widget1,
    required this.widget2,
    required this.widget3,
    required this.widget4,
  }) : super(key: key);

  final TabletView widget1;
  final TabletView widget2;
  final TabletView widget3;
  final TabletView widget4;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TotalCardTab(
            counter: widget1.studentcounter,
            title: 'Total Students',
          ),
          SizedBox(
            height: 10,
          ),
          TotalCardTab(
            counter: widget2.teacherCounter,
            title: 'Total Teachers',
          ),
          SizedBox(
            height: 10,
          ),
          TotalCardTab(
            counter: widget3.subjectCounter,
            title: 'Total Subjects',
          ),
          SizedBox(
            height: 10,
          ),
          TotalCardTab(
            counter: widget4.lectureCounter,
            title: 'Total Lectures',
          ),
        ],
      ),
    );
  }
}

class TotalCardTab extends StatelessWidget {
  final int counter;
  final String title;
  TotalCardTab({
    required this.counter,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.width / 8,
        width: MediaQuery.of(context).size.width / 4.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: btnColor),
        child: Center(
          child: ListTile(
              title: text(
                  counter.toString(), MediaQuery.of(context).size.width / 30),
              subtitle: text(title, MediaQuery.of(context).size.width / 50)),
        ));
  }
}
