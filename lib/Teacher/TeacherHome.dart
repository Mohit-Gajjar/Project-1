import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  // ignore: non_constant_identifier_names
  int student_counter = 0;
  // ignore: non_constant_identifier_names
  int teacher_counter = 0;
  String name = " ";
  String email = " ";
  getData() async {
    name = (await HelperFunctions.getTeacherNameSharedPreference())!;
    email = (await HelperFunctions.getTeacherEmailSharedPreference())!;
    student_counter = await DatabaseMethods().noOfStudent();
    teacher_counter = await DatabaseMethods().noOfTeachers();
    setState(() {});
  }

    @override
  void initState() {
    super.initState();
    getData();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,  
      resizeToAvoidBottomInset: false,
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: text(name, 20),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu, color: textColor, size: 30),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    tbox(student_counter.toString(), "Total Students", 67.0, 27.0, context),
                    tbox(teacher_counter.toString(), "Total Teachers", 67.0, 27.0, context),
                    tbox("1", "Total HODs", 67.0, 27.0, context),
                    tbox("38", "Total Subjects", 67.0, 27.0, context),
                    tbox("210", "Total Lectures", 67.0, 27.0, context),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: boxColor, borderRadius: BorderRadius.circular(18)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text('Ongoing Semester: ' + '5', 20),
                    text('Subject: ' + 'DS', 20)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: gridTile("Mark Attendence", "assets/1.png",context)),
                        GestureDetector(
                            onTap: () {},
                            child: gridTile("View attendence", "assets/1.png",context)),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: gridTile("Manage Subject", "assets/1.png",context)),
                        GestureDetector(
                            onTap: () {},
                            child: gridTile("Manage Lecture", "assets/1.png",context)),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child:
                                gridTile("Student`s Complain", "assets/1.png",context)),
                        GestureDetector(
                            onTap: () {},
                            child:
                                gridTile("Teacher`s Complain", "assets/1.png",context),
                        )],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: backColor,
        ),
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: boxColor),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 25,
                      child: Center(
                        child: text(name[0].toUpperCase(), 18),
                      )),
                  title: text(name, 16),
                  subtitle: text(email, 16),
                ),
              ),
              ListTile(
                title: text("Logout", 16),
                leading: const Icon(
                  Icons.logout,
                  color: textColor,
                ),
                onTap: () {
                  setState(() {
                    AuthMethod().signOut();
                    HelperFunctions.saveTeacherLoggedInSharedPreference(false);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LevelPage()));
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
