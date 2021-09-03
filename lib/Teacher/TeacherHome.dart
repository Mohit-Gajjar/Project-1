import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final drawerHeader = UserAccountsDrawerHeader(
    decoration: BoxDecoration(
      color: boxColor,
    ),
    accountName: Text(
      "Stanlee",
    ),
    accountEmail: Text(
      "stan@gmail.com",
    ),
    currentAccountPicture: const CircleAvatar(
      // backgroundImage: AssetImage('assets/steve.png'),
      child: Center(
        child: Icon(Icons.people_outline),
      ),
    ),
  );
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
        title: text("StanLee", 20),
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
                    tbox("1234", "Total Students", 67.0, 27.0, context),
                    tbox("121", "Total Teachers", 67.0, 27.0, context),
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
              drawerHeader,
              ListTile(
                title: text("One", 16),
                leading: const Icon(
                  Icons.one_k,
                  color: textColor,
                ),
                onTap: () {
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: text("Two", 16),
                leading: const Icon(
                  Icons.comment,
                  color: textColor,
                ),
                onTap: () {
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
