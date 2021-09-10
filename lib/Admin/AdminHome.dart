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
import 'package:asms/Management/ManageStudent.dart';
import 'package:asms/Management/ManageTeacher.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_swiper/flutter_swiper.dart';

class AdminHome extends StatefulWidget {
  AdminHome({
    Key? key,
  }) : super(key: key);
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  // ignore: non_constant_identifier_names
  int student_counter = 0;
  // ignore: non_constant_identifier_names
  int teacher_counter = 0;

  int onGoingSem = 0;
  String department = 'NULL';
  String name = " ";
  String email = " ";
  getCount() async {
    name = (await HelperFunctions.getAdminNameSharedPreference())!;
    email = (await HelperFunctions.getAdminEmailSharedPreference())!;
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

  List<String> cardTitle = ['123', '124', '125', '126'];
  List<String> cardSubTitle = [
    'Total Students',
    'Total Teachers',
    'Total Subjects',
    'Total Lectures'
  ];
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
              height: 200,
              child: Swiper(
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: btnColor),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(cardTitle[index], 80),
                          text(cardSubTitle[index], 30)
                        ],
                      ),
                    ),
                  );
                },
                pagination: SwiperPagination(
                  
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: boxColor, borderRadius: BorderRadius.circular(18)),
                child: ListTile(
                  title: text('Ongoing Semester: ' + onGoingSem.toString(), 20),
                  subtitle: text('Depertment: ' + department.toString(), 20),
                )),
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManageStudent()));
                            },
                            child: gridTile(
                                "Manage Student", "assets/1.png", context)),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ManageTeacher()));
                            },
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
                    HelperFunctions.saveAdminLoggedInSharedPreference(false);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LevelPage()));
                  });
                },
              ),
              ListTile(
                title: text("Edit University", 16),
                leading: const Icon(
                  Icons.business,
                  color: textColor,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
