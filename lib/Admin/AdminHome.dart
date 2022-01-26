import 'package:asms/Admin/desktop_view.dart';
import 'package:asms/Admin/mobile_view.dart';
import 'package:asms/Admin/tablet_view.dart';
import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Responsive.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String uid = "";
  void inputData() {
    final user = auth.currentUser;
    final uid = user!.uid;
    this.uid = uid;
  }

  @override
  void initState() {
    getCount();
    inputData();
    setState(() {});
    super.initState();
  }

  int studentCounter = 0;
  int teacherCounter = 0;
  int subjectCounter = 0;
  int lectureCounter = 0;
  String course = " ";
  String uniName = " ";
  String department = " ";
  String semester = " ";
  int onGoingSem = 0;
  String name = " ";
  String email = " ";
  getCount() async {
    name = (await HelperFunctions.getAdminNameSharedPreference())!;
    email = (await HelperFunctions.getAdminEmailSharedPreference())!;
    studentCounter = await DatabaseMethods().noOfStudent();
    teacherCounter = await DatabaseMethods().noOfTeachers();
    subjectCounter = await DatabaseMethods().noOfSubjects();
    lectureCounter = await DatabaseMethods().noOfLectures();
    course = await DatabaseMethods().getUniCourse("Computer");
    department = await DatabaseMethods().getUniDep("Computer");
    uniName = await DatabaseMethods().getUniName("Computer");
    semester = await DatabaseMethods().getUniSem("Computer");
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: textBlackBoldCenter("Admin Pannel", 16),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ],
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
                    decoration: BoxDecoration(color: Colors.blueAccent),
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
                  title: textBlackBold("Logout", 16),
                  leading: const Icon(
                    Icons.logout,
                    color: textBlack,
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
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: backColor,
        body: MakeResponsive(
          desktop: DesktopView(
            size: _size,
            lectureCounter: lectureCounter,
            studentCounter: studentCounter,
            subjectCounter: subjectCounter,
            teacherCounter: teacherCounter,
            universityInfo:
                UniversityTile(course, department, semester, uniName),
          ),
          mobile: MobileView(
            size: _size,
            lectureCounter: lectureCounter,
            studentCounter: studentCounter,
            subjectCounter: subjectCounter,
            teacherCounter: teacherCounter,
            universityInfo:
                UniversityTile(course, department, semester, uniName),
          ),
          tablet: TabletView(
            size: _size,
            lectureCounter: lectureCounter,
            studentcounter: studentCounter,
            subjectCounter: subjectCounter,
            teacherCounter: teacherCounter,
            universityInfo:
                UniversityTile(course, department, semester, uniName),
          ),
        ));
  }
}
