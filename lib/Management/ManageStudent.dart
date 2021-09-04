import 'package:asms/Constants/Constants.dart';
import 'package:asms/Constants/Widgets.dart';
import 'package:asms/Database/DatabaseMethods.dart';
import 'package:asms/Management/Profiles/StudentProfile.dart';
import 'package:flutter/material.dart';

class ManageStudent extends StatefulWidget {
  const ManageStudent({Key? key}) : super(key: key);

  @override
  _ManageStudentState createState() => _ManageStudentState();
}

class _ManageStudentState extends State<ManageStudent> {
  Stream? studentListStream;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Widget studentList() => StreamBuilder(
      stream: studentListStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return StudentTile(snapshot.data.docs[index]["StudentName"],
                      snapshot.data.docs[index]["StudentEnrollmentNo"]);
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      });
  @override
  void initState() {
    getStudentInfo();
    super.initState();
  }

  getStudentInfo() {
    databaseMethods.getStudents().then((val) {
      studentListStream = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: text("Manage Student", 16),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: studentList(),
      ),
    );
  }
}

class StudentTile extends StatelessWidget {
  final String enroll;
  final String name;
  StudentTile(this.name, this.enroll);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentProfile(
                      enroll: enroll,
                    )));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: Center(
            child: text(name[0].toUpperCase(), 16),
          ),
        ),
        title: text(name, 16),
        subtitle: text(enroll, 14),
      ),
    );
  }
}
