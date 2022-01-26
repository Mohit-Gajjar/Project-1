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
                  snapshot.data!.docs[0]["assigned_subject"],
                  snapshot.data!.docs[0]["contact"],
                  snapshot.data!.docs[0]["email"],
                  snapshot.data!.docs[0]["name"],
                  snapshot.data!.docs[0]["role"],
                  snapshot.data!.docs[0]["LoginEmail"])
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
      appBar: appBar("Teacher Info"),
      body: Container(
        child: teacherInfo(),
      ),
    );
  }
}

class TeacherInfo extends StatelessWidget {
  TeacherInfo(this.department, this.subject, this.contact,
      this.email, this.name, this.role, this.loginEmail);

  final String department;
  final String subject;
  final String contact;
  final String email;
  final String name;
  final String role;
  final String loginEmail;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: textBlackBold("Teacher`s Name", 14),
          subtitle: textBlackThin(name, 16),
        ),
        ListTile(
          title: textBlackBold("Teacher`s Contact No", 14),
          subtitle: textBlackThin(contact, 16),
        ),
        ListTile(
          title: textBlackBold("Teacher`s Email", 14),
          subtitle: textBlackThin(email, 16),
        ),
        ListTile(
          title: textBlackBold("Assigned Subject", 14),
          subtitle: textBlackThin(subject, 16),
        ),
        ListTile(
          title: textBlackBold("Department", 14),
          subtitle: textBlackThin(department, 16),
        ),
        ListTile(
          title: textBlackBold("Role", 14),
          subtitle: textBlackThin(role, 16),
        ),
      ],
    );
  }
}
