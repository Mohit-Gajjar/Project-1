import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:flutter/material.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  Stream? teacherInfoStream;
  Widget teacherInfo() {
    return StreamBuilder(
        stream: teacherInfoStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? TeacherInfo(
                  snapshot.data!.docs[0]["assigned_department"],
                  snapshot.data!.docs[0]["assigned_semester"],
                  snapshot.data!.docs[0]["assigned_subject"],
                  snapshot.data!.docs[0]["contact"],
                  snapshot.data!.docs[0]["email"],
                  snapshot.data!.docs[0]["name"],
                  snapshot.data!.docs[0]["role"],
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  void initState() {
    getTeacherInfo();
    super.initState();
  }

  getTeacherInfo() {
    DatabaseMethods().getTeachers().then((val) {
      teacherInfoStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: text("Teacher Info", 16),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: teacherInfo(),
      ),
    );
  }
}

class TeacherInfo extends StatelessWidget {
  TeacherInfo(
    this.department,
    this.semester,
    this.subject,
    this.contact,
    this.email,
    this.name,
    this.role,
  );

  final String department;
  final String semester;
  final String subject;
  final String contact;
  final String email;
  final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: text("Teacher`s Name", 14),
          subtitle: text(name, 16),
        ),
        ListTile(
          title: text("Teacher`s Contact No", 14),
          subtitle: text(contact, 16),
        ),
        ListTile(
          title: text("Teacher`s Email", 14),
          subtitle: text(email, 16),
        ),
        ListTile(
          title: text("Assigned Semester", 14),
          subtitle: text(semester, 16),
        ),
        ListTile(
          title: text("Assigned Subject", 14),
          subtitle: text(subject, 16),
        ),
        ListTile(
          title: text("Department", 14),
          subtitle: text(department, 16),
        ),
        ListTile(
          title: text("Role", 14),
          subtitle: text(role, 16),
        ),
      ],
    );
  }
}
