import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Create%20Users/CreateHOD.dart';
import 'package:asms/Create%20Users/CreateLectures.dart';
import 'package:asms/Create%20Users/CreateStudent.dart';
import 'package:asms/Create%20Users/CreateSubjects.dart';
import 'package:asms/Create%20Users/CreateTeacher.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  // final String username;
  // final String email;
  AdminHome({
    Key? key,
    // required this.username, required this.email
  }) : super(key: key);
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // ignore: non_constant_identifier_names
  int student_counter = 0;
  // ignore: non_constant_identifier_names
  int teacher_counter = 0;
  getCount() async {
    student_counter = await DatabaseMethods().noOfStudent();
    teacher_counter = await DatabaseMethods().noOfTeachers();
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCount();
  }

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
        title: text("widget.username", 20),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getCount();
                  print(MediaQuery.of(context).size.width);
                });
              },
              icon: Icon(
                Icons.refresh_outlined,
                size: 30,
                color: textColor,
              ))
        ],
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
                    Card(
                      color: btnColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 25,
                        height: 170,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: text(student_counter.toString(), 67.0),
                                subtitle: text("Total Students", 27.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 27),
                              padding: EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateStudent()));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('assets/add.png'),
                                    ),
                                  ),
                                  text("Add", 25),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: btnColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 25,
                        height: 170,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: text(teacher_counter.toString(), 67.0),
                                subtitle: text("Total Teachers", 27.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 27),
                              padding: EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateTeacher()));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('assets/add.png'),
                                    ),
                                  ),
                                  text("Add", 25),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: btnColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 25,
                        height: 170,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: text("1", 67.0),
                                subtitle: text("Total HODs", 27.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 27),
                              padding: EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateHODs()));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('assets/add.png'),
                                    ),
                                  ),
                                  text("Add", 25),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: btnColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 25,
                        height: 170,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: text("38", 67.0),
                                subtitle: text("Total Subjects", 27.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 27),
                              padding: EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateSubject()));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('assets/add.png'),
                                    ),
                                  ),
                                  text("Add", 25),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: btnColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 25,
                        height: 170,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: text("210", 67.0),
                                subtitle: text("Total Lectures", 27.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 27),
                              padding: EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateLectures()));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('assets/add.png'),
                                    ),
                                  ),
                                  text("Add", 25),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text('Ongoing Semester: ', 20),
                        text('5', 20),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              size: 50,
                              color: textColor,
                            ),
                          ),
                        ),
                        text("Manage", 16)
                      ],
                    ),
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
                            child: gridTile(
                                "Manage Student", "assets/1.png", context)),
                        GestureDetector(
                            onTap: () {},
                            child: gridTile(
                                "Manage Teacher", "assets/1.png", context)),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: gridTile(
                                "Manage Subject", "assets/1.png", context)),
                        GestureDetector(
                            onTap: () {},
                            child: gridTile(
                                "Manage Lecture", "assets/1.png", context)),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: gridTile(
                                "Student`s Complain", "assets/1.png", context)),
                        GestureDetector(
                            onTap: () {},
                            child: gridTile(
                                "Teacher`s Complain", "assets/1.png", context)),
                      ],
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
                        child: text("widget.username[0].toUpperCase()", 18),
                      )),
                  title: text("widget.username", 16),
                  subtitle: text("widget.email", 16),
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
                    HelperFunctions.saveAdminLoggedInSharedPreference(false);
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
