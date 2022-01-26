import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Responsive.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:asms/Student/attendence.dart';
import 'package:asms/Student/desktop_view.dart';
import 'package:asms/Student/mobile_view.dart';
import 'package:asms/Student/Profile%20Management/student_profile.dart';
import 'package:asms/Student/tablet_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_radar/flutter_radar.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({
    Key? key,
  }) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = " ";
  String email = " ";
  String course = " ";
  String uniName = " ";
  String department = " ";
  String semester = " ";
  String enrollmentNo = " ";
  getData() async {
    name = (await HelperFunctions.getStudentNameSharedPreference())!;
    email = (await HelperFunctions.getStudentEmailSharedPreference())!;
    enrollmentNo = await DatabaseMethods().getStudentEnrollment(email);
    course = await DatabaseMethods().getUniCourse("Computer");
    department = await DatabaseMethods().getUniDep("Computer");
    uniName = await DatabaseMethods().getUniName("Computer");
    semester = await DatabaseMethods().getUniSem("Computer");
    setState(() {});
  }

  Stream? anouncementStream;
  Widget getAnouncements() {
    return StreamBuilder(
        stream: anouncementStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return AnouncementCard(
                      title: snapshot.data.docs[index]["Message"],
                      subtitle: snapshot.data.docs[index]["Subject"],
                    );
                  })
              : Center(
                  child: SingleChildScrollView(),
                );
        });
  }

  getAnouncementsMethord() async {
    DatabaseMethods().getAnouncements("anouncements").then((value) {
      setState(() {
        anouncementStream = value;
      });
    });
  }

  String uid = " ";
  final FirebaseAuth auth = FirebaseAuth.instance;
  void inputData() {
    final user = auth.currentUser;
    final uid = user!.uid;
    this.uid = uid;
    print("Student: " + uid);
  }

  @override
  void initState() {
    super.initState();
    getData();
    getAnouncementsMethord();
    inputData();
    initRadar();
    _getPermissionsStatus();
  }

  Future<void> initRadar() async {
    Map<String, dynamic> studentMetadata = {
      "StudentName": name,
      "StudentEmail": email,
      "timeOfJoining": DateTime.now().toString(),
    };
    Radar.setUserId(uid);
    Radar.setDescription(enrollmentNo);
    Radar.setMetadata(studentMetadata);
  }

  String _status = 'NOT_DETERMINED';
  Future _getPermissionsStatus() async {
    String status = await Radar.getPermissionsStatus();
    // String status1 = await Radar.requestPermissions(false);
    setState(() {
      _status = status;
      print("Permisson status: " + _status);
    });
    if (_status == "DENIED") {
      String status = await Radar.requestPermissions(false);
      print("Permissons are requested: " + status);
      Radar.startTracking('continuous');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: textBlackBold(name, 20),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
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
          universityInfo: UniversityTile(course, department, semester, uniName),
          anouncement: getAnouncements(),
          uid: uid,
        ),
        tablet: TabletView(
          anouncement: getAnouncements(),
          uid: uid,
          universityTile: UniversityTile(course, department, semester, uniName),
        ),
        desktop: DesktopView(
          anouncement: getAnouncements(),
          uid: uid,
          universityTile: UniversityTile(course, department, semester, uniName),
        ),
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
                title: textBlackBold("Logout", 16),
                leading: const Icon(
                  Icons.logout,
                  color: textBlack,
                ),
                onTap: () {
                  print("Logout Pressed");
                  AuthMethod().signOut();
                  HelperFunctions.saveStudentLoggedInSharedPreference(false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LevelPage()));
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
                          builder: (context) => StudentProfile(
                                loginEmail: email,
                              )));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
