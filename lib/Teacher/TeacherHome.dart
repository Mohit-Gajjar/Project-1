import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Responsive.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:asms/Teacher/Profile%20Management/teacher_profile.dart';
import 'package:asms/Teacher/available_lectures.dart';
import 'package:asms/Teacher/create_anouncemnts.dart';
import 'package:asms/Teacher/desktop_view_teacher.dart';
import 'package:asms/Teacher/mobile_view_teacher.dart';
import 'package:asms/Teacher/tablet_view_teacher.dart';
import 'package:asms/Teacher/view_attendence.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  TeacherHome({Key? key}) : super(key: key);

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
  String subject = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  String uniName = " ";
  String department = " ";
  String course = " ";
  String semester = " ";
  getData() async {
    name = (await HelperFunctions.getTeacherNameSharedPreference())!;
    email = (await HelperFunctions.getTeacherEmailSharedPreference())!;
    student_counter = await DatabaseMethods().noOfStudent();
    teacher_counter = await DatabaseMethods().noOfTeachers();
    subject = await DatabaseMethods().getTeacherSubject(email);
    course = await DatabaseMethods().getUniCourse("Computer");
    department = await DatabaseMethods().getUniDep("Computer");
    uniName = await DatabaseMethods().getUniName("Computer");
    semester = await DatabaseMethods().getUniSem("Computer");
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: textBlackBold(name, 20),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu, color: textBlack, size: 30),
        ),
      ),
      body: MakeResponsive(
        mobile: MobileView(
          studentCounter: student_counter,
          teacherCounter: teacher_counter,
          universityTile: UniversityTile(course, department, semester, uniName),
        ),
        tablet: TabletView(
          studentcounter: student_counter,
          university: UniversityTile(course, department, semester, uniName),
        ),
        desktop: DesktopView(
            studentcounter: student_counter,
            university: UniversityTile(course, department, semester, uniName)),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: backColor,
        ),
        child: Drawer(
          semanticLabel: name,
          child: ListView(
            children: [
              Container(
                height: 120,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 23,
                        child: Center(
                          child: text(name[0].toUpperCase(), 18),
                        )),
                    title: textBlackBold(name, 16),
                    subtitle: textBlackThin(email, 11),
                  ),
                ),
              ),
              ListTile(
                title: textBlackBold("Make Anouncement", 16),
                leading: const Icon(
                  Icons.campaign_outlined,
                  color: textBlack,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateAnouncemnt(
                                name: name,
                                subject: subject,
                              )));
                },
              ),
              ListTile(
                title: textBlackBold("Profile", 16),
                leading: const Icon(
                  Icons.account_circle_outlined,
                  color: textBlack,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TeacherProfile(
                                loginEmail: email,
                              )));
                },
              ),
              ListTile(
                title: textBlackBold("Logout", 16),
                leading: const Icon(
                  Icons.logout,
                  color: textBlack,
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

class GridTs extends StatelessWidget {
  const GridTs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contexxt) => TakeOrLeave()));
                    },
                    child: gridTile("Manage Lecture", "assets/1.png", context)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAttendence()));
                    },
                    child:
                        gridTile("View attendence", "assets/1.png", context)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
