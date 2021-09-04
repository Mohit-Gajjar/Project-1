import 'package:asms/Authentication/Auth_service.dart';
import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/LocalDatabase/SharedPrefs.dart';
import 'package:asms/OTP/Levels/LevelsPage.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  // final String username;
  // final String email;
  const StudentHome({
    Key? key,
    //  required this.username, required this.email
  }) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
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
        title: text("Bruce Banner", 20),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    annsbox("Webinar on Game Development", "Date: 12-July-2021",
                        30.0, 20.0, context),
                    annsbox("Webinar on App Development", "Date: 12-July-2021",
                        30.0, 20.0, context),
                    annsbox("Webinar on UI/UX", "Date: 12-July-2021", 30.0,
                        20.0, context),
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
                        text('Semester: ' + '5', 20),
                        text('Department: ' + 'Computer Engg', 20),
                        text('College: ' + 'Shri KJ Polytechnic', 20)
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
              child: Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: gridTile(
                              "Mark Attendence", "assets/1.png", context)),
                      GestureDetector(
                          onTap: () {},
                          child: gridTile(
                              "Find Attendence", "assets/1.png", context)),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child:
                              gridTile("Find Marks", "assets/1.png", context)),
                      GestureDetector(
                          onTap: () {},
                          child: gridTile(
                              "Apply for Leave", "assets/1.png", context)),
                    ],
                  ),
                ],
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
                    HelperFunctions.saveStudentLoggedInSharedPreference(false);
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
